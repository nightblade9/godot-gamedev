Title: How to Get Your Game to Done
Date: 2018-05-09
Category: Game Design
Tags: Project Management

![image](https://i.imgur.com/TklGFnF.png)

Most games never reach completion. Most of us know this -- especially programmers, who typically leave a trail of dead projects in their wake.  Well-intentioned projects, but incomplete projects none-the-less. 

What steps can you take to increase the chances of actually finishing, and get your game to that glorified "done" state?

At Deen Games, we work in a team of two (or I sometimes work alone), part-time, without funding. The steps below outline our process -- one which, if we applied it consistently, would lead to us finishing many more games.  Each step in the process fulfills a specific purpose, which I will explain along the way.

But first, a quick detour on why games fail.

## Why Games Fail

Why do we fail to complete games so often? When you look at the bigger picture (across mutliple projects and teams), you find a number of common reasons:

- **Overambitious:** Many games require much more time and effort than the instigators realize; often, when realization dawns, the thought of "it'll take *how* many years for us to finish?" causes a game to reach the trash pile. This can be anything from requiring tons of game content to requiring art or audio capabilities beyond what we can deliver.
- **Motivation:** Motivation dies near the middle of the project. Great teams can forage onward; but, many projects fail early because the original motivation just isn't there.
- **Time Scale:** Some teams, like ours, are very sensitive to time; if a game starts to slog on, and on, and *on* forever, we lose motivation (see above) and throw in the towel.
- **Content Complexity:** As an indie, we can innovate without worry. However, projects that require complex features (eg. procedurally-generated branching storylines and quests) or complex content (hundreds of maps and events and quests) can stretch us beyond what we can achieve.

Having summarized the main failure points, let's dive into the process and see how we get around some of these issues.

## Game Development Life Cycle

We don't really use agile; we just work linearly given whatever amount of time and energy we have (since we're part time). However, you can always break these stages into different stories and apply them to an agile/iterative life-cycle.

### Craft a Motivational Vision

Every good game starts with a good vision. What are we trying to build? Is it a completely procedurally-generated 2D RPG, an Android game that teaches Arabic vocabulary to kids aged 4-8, or a stealth-based MMO? Write it down.

The vision should be clear, and should list what we want to achieve by releasing this game; it should also be composed of *highly motivational statements for the team.* When motivation slumps, we can review this, and get a burst of re-energizing/motivation.

### Inject the Learning Goal

At Deen Games, we develop Islamic and educational games. The next step is to write down our goal: what do players get out of playing this game? The learning goal can be grand (eg. acquire fluency in a new language) or benign (get exposure to Muslim culture specific to Yemen), but it needs to be decided up-front.  Again, write it down.

Without this, we tend to abandon projects because they don't make the world a better place in some way.

### Brainstorm the Core Game Loop(s)

The core game loop (or loops) of your game, are those activities and actions the player plays over and over and over again. In a typical platformer, that's running, jumping, dodging; in an FPS, it's seeking weapons/ammo/armour, shooting, and dodging.

This is really the fruit of the game design; the place where we codify the vision and learning goal into the *actual gameplay*. This is how players learn (through experience), and how we communicate that through *the actual mechanics* (instead of simply a story or dialog).

This forms the core of your game; without this, your game won't be fun; motivation fizzles, fast.

### Risk Analysis

I learned of Risk Analysis during my studies as a PMP. You want to analyze your project and find any risks -- those sneaky issues that, if they occur, could (or will certainly) cause the downfall of your project.

Using risk analysis, you can quickly identify risks like the following:

- The game requires a large world (overambitious or content complexity)
- We actually need a really good, custom-made level editor to make it (technical complexity)
- The procedural generation is really hard (technical complexity)
- The game won't work without very high-quality or a large quantity of good art (eg. interactive books)
- The game will take us years to build
- The game doesn't really achieve what our vision entailed

Here in the process, you want to mitigate or minimize the risks. For example, maybe you're working on an underwater sea-life themed infinite runner, and your risk is that you need really good art.  Your options might include:

- Change the theme to something else (eg. cubes instead of animals).
- Settle on a simpler, achievable art style. Pixel art is often a choice here, because it's easy to create decent pixel art.
- Team up with someone who can create the art you need.
- Find an artist for hire who will charge a decent rate and get you the quality you want.

In the worst case, if the project just can't be done, this is the time to go back to the brainstorming phase and see if you can come up with something different. Alternatively, you can acccept the risk and move on (but this often leads to failure).

### Prototype to Find the Fun

Many games are not fun. And nothing is more demotivational than investing hours and hours into a game that's boring or tedious.  In this stage, prototype your game and find out what combination of features makes it fun.

While prototyping is an art (and science), and something you should read more about, here are some of the key take-aways for this stage:

- Use the most minimal art possible -- coloured boxes. If it's fun at this stage, it'll be fun when it's full-blown production pipelined content; if it's not fun now, no amount of polish can make it fun.
- Focus on core game mechanics, or technical risk (eg. PCG algorithms)
- Avoid superficial things like stories, characters, names, etc. unless these are really key to make or break your game
- If the controls are okay, and it doesn't hurt the fun of the prototype, leave it as-is.
- Don't write a tutorial; writing good, interactive tutorials is really time-consuming. Ditto for writing the UI.
- Use feature toggles so you can quickly turn features on or off; this helps decide what the final game will be.

Chances are, you will find that your prototype *isn't* the fun experience you thought it would be. No problem, recycle -- add things, change things, remove things, and iterate until you find the balance that *is* fun -- or until you get tired (there's no way to make a butterfly simulator fun ... or is there?).

### Validate your Prototype with Others

Show your prototype to your team members (hopefully they worked on it with you), friends, and family. Provide them with instructions (since the game likely has none). Listen to the feedback people give you on what works and doesn't; but be weary of suggestions for improvement (these are usually terrible and have nothing to do with your game vision and objectives).

If you can get someone else (or a number of players) to agree that your prototype *really is fun*, even at this stage, you're in business.

If you didn't go back to the drawing board on your game, congratulations! You have an idea that sounds and *plays* fun. This is the hardest part -- all you need to do now is complete it and ship it.

### Create a Minimal Viable Product

Your game probably requires a lot of stuff -- levels, entities, art, algorithms, characters, text, a tutorial, and more!  At this stage, you probably realize that you can't possibly finish this game in a decent time-line (unless it's a very, *very* simple game).

You now need to focus on shipping. To do that, you need to pare the game down to *the core essence of the game.* In a way, you already did this: you focused on your core game loop, and prototyped it until it was fun. You should now have a good idea of what your game entails.

Now, think about every feature, every level, every piece of content. Ask yourself constantly: can I live without this? Can I ship my game without this? Or maybe not -- maybe, without this one element, there really *is* no game.

Organize your list of stuff into two broad buckets: MVP (really really need it) and a v2.0 bucket. Anything you don't need, keep it in the v2.0 bucket until after you complete the release (we'll come back to this).

Keep your list of MVP items close at hand; ideally, you want to also prioritize it (in case you lose motivation in the middle and still want to ship something). 

### Get it Done

Once that's done, crank out your game. There's no magic to this; focus on the code, the content, everything and anything you need. As you work through things, you  may come up with new ideas or realizations of things you need to do; constantly ask yourself again, can I ship without this? And keep focused.

### I18N on the Cheap

Translation is a difficult and complex process. Chances are that, within your circle of team members (and possibly family members or good friends), you will find people who are fluent in more than just English.

Enlist them to translate your game into their native language! While the translation might not be great, it's much better to ship *something* than to wait endlessly for that perfect translation to spring into being.

Of course, if your game isn't easy to localize, you need to fix that first. And next time, make it localizable from the start! (Tip: it's easy enough to make a single class that fetches strings for the current language and returns them, and loads a simple JSON/XML/etc. file that contains the game strings.)

### Test Thoroughly

When you finally finish your slog through the backlog of work, test the game thoroughly; test every possible feature, level, piece of content, and option. Enlist your teamies and friends -- they often find bugs by trying different workflows. (You tend to test the same content over and over and over during development, and get blind to the other options.)

Once that's done, congratulations! You're ready to ship your game. Build the final executable, prepare your website/marketing material (eg. tweets), and unleash it on the world.

## Beyond v1.0

At this point, we're technically done. You could put your game down and walk away, or take a breather to work on something else and come back. Either way, if you decide to invest more in your game, here's the good news: we're not done yet!

### Monitor for Feedback

If you're blessed enough to have a big following on Twitter, or Itch.io/Steam/etc. (or the app store for your mobile platform), you will hear feedback. Listen to everything, and make a note somewhere. You need to sift through and prioritize this feedback, and decide what to ship (and not ship).

Remember that v2.0 backlog of deferred work we created while finding our game MVP? Revisit it, look critically through it again, and rework it or reprioritize it.

### Restart the Process

Given this combined backlog of stuff to work on, you can go back to the "brainstorming" phase. Pick a set of features, dust off your prototype, and add them. How do they affect the user experience? Are they worth integrating into the main game?

When you know the answer, you can put those changes into your game and ship another small release. (Testing thoroughly is a good idea, and test automation helps here.) 

Publishing multiple small releases tends to give you more visibility and feedback across the internet, so repeat this as many times as you like.

# In Conclusion

In this article, we covered a lot of ground. We started by looking at some of the common reasons game development projects failed, and then looked into our Deen Games current (ideal) process to see how we work around many of these failures.

In doing so, we take a project through the stages of:

- Creating a vision
- Crafting a learning goal
- Prototyping the core game mechanics
- Creating a small MVP
- Shipping our game
- Localizing our game on the cheap
- Monitoring for feedback
- Iterating and repeating to create incremental releases

Do you see any holes in our process? Do you have another process or different steps that work for you? Drop us a comment and let us know.

