Title: Text Rendering Performance Check for a ReactJS ASCII Roguelike
Date: 2019-03-19
Category: Technical
Tags: ReactJS, Roguelike

![image](https://i.imgur.com/bMgMS3E.gif)

Recently, I was tasked with learning ReactJS (or just "React"). So, I made the most obvious choice possible: I decided to write an ASCII roguelike, which uses React as the front-end.

## Why an ASCII Roguelike?

Why? For several, obvious reasons:

- I have very limited time to work on this; perhaps as little as one hour a day, or less.
- ASCII roguelikes require little beyond a good monospace font -- no complex graphics, very simple animations
- I enjoy creating roguelikes. It's fun. Fun motivates me to work on this, which fuels my learning.
- Having created several (failed/incomplete) roguelikes in the past, I know how to code them. I don't have to think too hard about level generation algorithms, line-of-sight (or area-of-sight) lighting, etc. so I can focus on the technology.

I set out to create, in my mind, the first step of any text roguelike: draw text on the screen *really fast* and see how it performs. HTML should render at lightning-speed in my modern browser, right?

Wrong.

## The Simplest Possible Performance Test

React is just a front-end technology; it doesn't dictate how I should structure my HTML. With that in mind, I set out to answer two questions:

- What kind of performance can I expect with my roguelike?
- What factors affect performance? Does changing the font, applying colour (or not), using nested `div` tags vs. `span` tags, etc. make any difference?

In brief, the answer to question #2 ended up being "no." Performance bottlenecks on something else entirely; none of those changes make any significant difference.

I wrote a little Javascript that tests exactly what I want:

- Define dimensions of the screen. In this case, 50x16 tiles.
- Create a `div` tag for each tile. Style it appropriately (eg. width/height big enough to fit any character)
- Very frequently (like, 60 times per second), update each tile's display to a random character with a random colour.

You can see the code, more or less (with FPS counting),  [here](https://github.com/nightblade9/space-marine-junaid/blob/master/prototypes/1-dom-performance/index.html).  It's simple, and to the point.

## The Results

In a word: abysmal! On my fairly beefy dev machine (lots of RAM, good CPU, mediocre GPU), it renders at a measly 6-7FPS. You can see the results [in this tweet](https://twitter.com/nightblade99/status/1098278413935280128).

As I mentioned earlier, I tried several variations; none of them improve performance, at all. The core of it comes down to a call to set the character itself. Pseudocode:

```
var character = ...
var colour = ...
var tile = window.tiles[i];
tile.innerText = character
```

It turns out that browsers, even modern ones, even on beefy hardware, are *really, really slow* when you set `innerText`. The only alternative - using `innerHTML` -- is slower, and probably broken on Internet Explorer.

### The Conclusion

For an ASCII roguelike without too much going on, 6FPS is probably enough. If I really cared about performance, I could switch to canvas-rendering and a bitmap font (lots of work and not sure how it works with React), or using images - either images of text, or real images.

For me, the goal is to learn ReactJS, so I plan to continue forward with this as-is, without major surgery.