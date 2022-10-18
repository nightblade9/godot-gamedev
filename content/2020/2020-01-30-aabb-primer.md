Title: A Primer on AABB Collision Resolution
Date: 2020-01-30
Category: Technical
Tags: Physics

![video demo](https://i.imgur.com/GLQzqUP.gif)

This blog post includes a discussion about AABB collision resolution: what it is and isn't, it's strengths and weaknesses, some common pitfalls, and how you can (hopefully) implement it in your low-level gaming tool of choice, if needed.

I learned all this (the second time) as part of adding fast/stable collision resolution to [Puffin](https://nightblade9.github.io/puffin), a fast, lightweight 2D game engine built on top of MonoGame.

## AABB, Collision Detection, and Collision Resolution

Some quick definitions to start:

- AABB (Axis Aligned Bounding Boxes) means two non-rotated boxes, that are aligned on one axis. In 2D, everything on the same "layer" or "z" is on the same axis; in 3D, it means your boxes are on the same plane.
- Collsiion detection means detecting if there is a collision (two AABBs overlapping) or will be a collision (eg. in 0.3s these two will start colliding).
- Collision resolution means resolving the collision. Broadly, there are two approaches to this: prevention or pre-collision resolution (stop just at the onset of collision when the two AABBs touch), and post-collision resolution (once two AABBs overlap, move them backward in time until they no longer overlap).

My approach to AABB uses pre-collision resolution, because it tends to be less complex and more stable.

## Pros and Cons of AABB

Why should you use AABB collision resolution? There are many other options, such as collision points, sphere/line collsion algorithms, polygons, etc.

The strengths of AABB include:

- It works well in most cases. Most games can do well enough with just bounding boxes on their entities.
- It's relatively simple to code (math-wise), because it's just boxes.
- It's quite cheap computationally (eg. doesn't have an expensive square-root calculation, unlike spherical checks)

However, it includes some drawbacks:

- It doesn't work with rotated boxes
- It doesn't work well with non-box shapes
- It requires extra work for it to work well with multi-entity collisions
- It's succeptible to "tunnelling" (high-speed objects move through solid objects because of their velocity)

If you can live with those limitations, I recommend AABB, primarily because it is computationally cheap (works well with a high number of colliding entities).

## Collision Resolution is Complex, like Physics

While AABB collision resolution is *relatively* easier to code, it doesn't mean it's *easy* to code. Many game frameworks don't include collision resolution, because this is part of the physics engine.

Read that again: it's often part of the *physics engine*. Physics engines are notoriously difficult to get right, and require lots of fiddling and corner-case evaluation. Even high-quality physics engines have limitations, such as tunneling.

It took me around 10 hours to discover all the caveats and get this to work right. And it works well, including with multi-entity collisions. Test thoroughly.

That said, my implementation includes a few bonus features:

- It's resistant to collision tunneling (but not impervious)
- It works with multiple objects colliding at the same time
- It allows an object to optionally "collide and slide" along the object it collides with

With that out of the way, let's dive into the actual theory of how to make a stable AABB resolution, and then some code.

## High-Level Description of AABB

AABB collision resolution works by looking at the X and Y component resolutions of your velocity. Simply put:

- Consider the intended destination of your moving entity (where it will be after updating its position, not where it is now)
- Look at the distance `dx` to travel before we collide on the X-axis and `dy` for the Y-axis
- Divide these by your component X-velocity and Y-velocity respectively (`vx` and `vy`) to figure out how long before each axis collision takes place (`tx` and `ty`)
- Resolve the collision on the axis that collides first

![AABB sweep test with velocity](https://i.imgur.com/gCtzUeJ.png)

This excellent diagram (credit: LaroLaro on [GameDev.SE](https://gamedev.stackexchange.com/questions/28577/2d-aabb-vs-aabb-sweep-how-to-calculate-hit-normal)) shows a moving object (A) that will collide with a second object (B). Based on the component velocities, you can see from the projected A box that the faster collision will be on the Y-axis first.

Because collision resolution takes place on a single axis at a time, you may end up having to resolve the same collision multiple times to get a stable resolution. I find that running the collision resolution twice suffices.

## And Now, the Code

Below, I discuss some pseudocode that's almost the same as the actual (C#) code from Puffin. The same code can apply to any programming language or framework.

One unorthodox implementation detail I used: when each entity moves, I make a note of their "intended" destination X/Y. If that location would cause it to collide inside an object, I instead update it so it stops just at the point of collision.  In my pseudocode below, you'll see this as `intendedX` and `intendedY`.

For every collidable entity, you're going to compare it to every other collidable entity. Since we're using AABBs, this is pretty simple: just compare the coordinates plus intended movement of the moving entity, against the entity that isn't moving:

```csharp
private static bool isAabbCollision(float x1, float y1, int w1, int h1, float x2, float y2, int w2, int h2)
{
    // Adapted from https://tutorialedge.net/gamedev/aabb-collision-detection-tutorial/
    return x1 < x2 + w2 &&
        x1 + w1 > x2 &&
        y1 < y2 + h2 &&
        y1 + h1 > y2;
}
```

You simply call this with `e1.x + e1.velocity.x, e1.y + e1.velocity.y, e1.width, e1.height, e2.x, e2.y, e2.width, e2.height` and it will return if they collide or not.

However, to stop at the point of collision, we need to consider our entity's velocity: if it's moving right, then the distance to collide on the X-axis is the right edge of `e1` compared to the left-edge of `e2`. If it's moving left, then vice-versa (left edge of `e1` vs. the right edge of `e2`). The same thing applies when we resolve on the Y-axis.

```csharp
// Assuming we have two AABBs, what's the actual distance between them?
// eg. if `e1` is on the left of `e2`, we want `dx` to be `e2.left - e1.right`.
private static (float, float) CalculateAabbDistanceTo(Entity e1, Entity e2)
{
    float dx = 0;
    float dy = 0;

    if (e1.X < e2.X)
    {
        dx = e2.X - (e1.X + e1.Width);
    }
    else if (e1.X > e2.X)
    {
        dx = e1.X - (e2.X + e2.Width);
    }
    
    if (e1.Y < e2.Y)
    {
        dy = e2.Y - (e1.Y + e1.Height);
    }
    else if (e1.Y > e2.Y)
    {
        dy = e1.Y - (e2.Y + e2.Height);
    }
    
    return (dx, dy);
}
```

Then, for every collidable entity, if it results in an AABB collision with another collidable entity, we figure out which axis collides first, based on which one collides first time-wise:

```csharp
// Another entity occupies that space. Use separating axis theorem (SAT)
// to see how much we can move, and then move accordingly, resolving at whichever
// axis collides first by time (not whichever one is the smallest diff).
(float xDistance, float yDistance) = CalculateAabbDistanceTo(entity, target);
(float xVelocity, float yVelocity) = (entity.VelocityX, entity.VelocityY);
float xAxisTimeToCollide = xVelocity != 0 ? Math.Abs(xDistance / xVelocity) : 0;
float yAxisTimeToCollide = yVelocity != 0 ? Math.Abs(yDistance / yVelocity) : 0;
```

Resolving collision based on collision time solves some corner-cases where an object is very close to collision on one axis, but moving much faster on the other axis (eg. a player falling off a tall building moves into it, and instead of colliding against the side, he collides with the top).

Once we know which collision is first, it's easy to resolve if the collision is only on one axis:

```csharp
float shortestTime = 0;

if (xVelocity != 0 && yVelocity == 0)
{
    // Colliison on X-axis only
    shortestTime = xAxisTimeToCollide;
    entity.IntendedMoveDeltaX = shortestTime * xVelocity;
}
else if (xVelocity == 0 && yVelocity != 0)
{
    // Collision on Y-axis only
    shortestTime = yAxisTimeToCollide;
    entity.IntendedMoveDeltaY = shortestTime * yVelocity;
}
```

Finally, the most complex case: what do we do if the object would collide on both X- and Y-axes? We resolve the fastest collision first:

```csharp
else
{
    // Collision on X and Y axis (eg. slide up against a wall)
    shortestTime = Math.Min(Math.Abs(xAxisTimeToCollide), Math.Abs(yAxisTimeToCollide));
    entity.IntendedMoveDeltaX = shortestTime * xVelocity;
    entity.IntendedMoveDeltaY = shortestTime * yVelocity;
}
```

Easy! If it would take 0.1s to collide on the X-axis, and 0.2 on the Y-axis, we increment the entity's X and Y by their velocity times 0.1 (the faster collision time).

Finally, for stable resolutions, make sure you run the collision resolution twice per update. Since MonoGame-based frameworks give you the update time, simply run the update twice, with half of the elapsed time, each update:

```csharp
var halfElapsed = TimeSpan.FromMilliseconds(elapsed.TotalMilliseconds / 2);
// Resolve collisions twice to stabilize multi-collisions.
this.ProcessMovement(halfElapsed, entity);
this.ProcessMovement(halfElapsed, entity);
```

That's it, you're done!

## Slide on Collide

With basic collision resolution out of the way, you might ask "how do I slide up against the target object instead of simply stopping abruptly?"

The answer to that caused about 50% of my development time. The answer is "you collide as usual but then move on the other axis as much as is reasonable," where reasonable means "don't move so much you collide with something else." In this case, don't slide if doing so would land you in another AABB collision.

Another complication I can't explain well is my need to refer to the "old" intended X/Y distances; I'm not 100% sure at this moment why I needed those, but those are needed for a proper resolution.

Some code:

```csharp
    if (entity.SlideOnCollide)
    {
        // Setting oldIntendedX/oldIntendedY might put us directly inside another solid thing.
        // No worries, we resolve collisions twice, so the second iteration will catch it.

        // Resolved collision on the X-axis first
        if (shortestTime == xAxisTimeToCollide)
        {
            // Slide vertically
            entity.IntendedMoveDeltaX = 0;
            // If we're in a corner, don't resolve incorrectly; move only if we're clear on the Y-axis.
            // Fixes a bug where you  move a lot in the corner (left/right/left/right) and suddenly go through the wall. 
            if (!isAabbCollision(entity.X, entity.Y + oldIntendedY, entity.Width, entity.Height,
                collideAgainst.X, collideAgainst.Y, target.Width, target.Height))
                {
                    entity.IntendedMoveDeltaY = oldIntendedY;
                }
        }
        // Resolved collision on the Y-axis first
        if (shortestTime == yAxisTimeToCollide)
        {
            // Slide horizontally
            entity.IntendedMoveDeltaY = 0;
            // If we're in a corner, don't resolve incorrectly; move only if we're clear on the X-axis.
            // Fixes a bug where you  move a lot in the corner (left/right/left/right) and suddenly go through the wall.
            if (!isAabbCollision(entity.X + oldIntendedX, entity.Y, entity.Width, entity.Height,
                collideAgainst.X, collideAgainst.Y, target.Width, target.Height))
                {
                    entity.IntendedMoveDeltaX = oldIntendedX;
                }
        }
    }
}
```

## Wrapping it All Up

That concludes a somewhat whirlwind tour of AABB collision detection. I hope you came out of it understanding the pros and cons, how to assess when you need it or not, and enough pseudo-code to actually get it working for you.

I would love to hear from you! If you have any feedback, please drop me a message/tweet [on Twitter](https://twitter.com/nightblade99).