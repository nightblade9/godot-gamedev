Title: A Practical Guide to Make Your Own Game Engine
Date: 2021-07-23
Category: Game Development

Want to make games faster, bigger, and with better quality, while investing the same amount of time? It's possible, albeit with an unintuitive solution: a custom game engine. I'm here to tell you why you can, and should, build a custom game engine.

It's 2021, and lots of strong, general-purpose game engines abound: from Unreal to Godot to GameMaker to Construct, tools exist for beginner and experienced developers alike. Why bother making your own game engine?

It's a great learning tool, sure, but a better reason exists: you can *customize your game engine to your own personal style and workflow.*

A great example of this is RPG Maker, which specializes in making JRPG games. Using RPG Maker, you can - very quickly, and without much coding skill - create large-scale and complex JRPGs. RPG Maker includes events for all kinds of common JRPG things (dialog, shops, inns, quest NPCs, etc.) which makes it very, very fast to build, compared to building something from scratch.

Even if you think this isn't a great idea, I guarantee you will learn a ton by doing this. If you're convinced, read on.

## Pick a Small Target

You're not planning to build a general-purpose, large-scale game engines. Those are difficult, and require [lots of different skillls](https://www.gamedesigning.org/learn/make-a-game-engine/) which you may not have.

First, identify an existing game engine, framework, library, toolkit, etc. that you use and like. What's great about it? Importantly, what's not good about it? Where can you improve upon it, or what pain-points does it inflict on you that you wish you could work around?

Once you identified your starting-point, you can even build on top of an existing game engine. This way, you create a standalone library, or a thin "layer" that makes some tasks easier. It could be as simple as scene management, or as complicated as common code for a roguelike.

Whatever your goal, pick something small and achievable as the first step.

## Pick a Companion Game

Now, the most important part: **do not build your game engine or framework in isolation!** You will end up with bloated features that are difficult to use, and code that nobody uses.  Instead, design a small standalone game that you feel really excited to build.

The key: build your game *in tandem* with your game engine. For example, if you need outlined text, add some code for that to your game engine, then add it to the titlescreen, options screen, or whatever location in your game that you need it.

This keeps your code useful, streamlined, and well-tested to begin with; it greatly increases the chances that you can ship something useful at the end of your game development cycle, whether the game ships or not.

Work on your game framework with that cycle: add code, test it, implement it in your game. Rinse, repeat.

## Use-Case

If your game framework extends beyond a simple library, you should consider the user workflow carefully. How do users use your framework? Do they link a DLL, or copy/paste code into their project? Do you need to provide a template project with some starter code, or simply a spec for a JSON file?

Looking at this early on makes it easier for users to eventually use your game framework.

## Testing and Quality

Testing your game framework is really important. As it grows, you will find it increasingly likely that you accidentally break things in other places and not notice. I highly recommend writing unit tests and/or integration tests for *every single line of code you write.* This makes it very easy to make changes: you simply run the tests, and they identify anything broken you need to fix.

## A War Story: Oneons and Puffin

I applied this process to a number of game frameworks over the years (mostly abandonware). One of them, [Puffin](https://github.com/nightblade9/puffin-v1), actually shipped to production (I finished it and launched the game and the framework). It didn't meet my long-term needs, but it worked well enough.

Here's a quick summary of how that came to be:

- **Target:** I really like Godot. One thing that frequently bugs me is the lack of free support for exporting your game for the Nintendo Switch. I'm also not a big fan of GDscript, the internal, Python-like scripting language.
- **Goal:** I decided to build something similar to Godot - a visual IDE - albeit in C#. I chose MonoGame as my base, since I've used it before, and since it has excellent free support for porting to the Switch
- **Small Target:** For the first version of Puffin, I decided to leverage my experience with CraftyJS and build a small, easy-to-use fluent API. I based it on Entity-Component System architecture. (This isn't a good fit for Godot-like games, which use nested nodes.)
- **Start Small:** I build the absolute minimum code to get started: a base entity class, and some components for rendering sprites and text. That's it.  I decided I would limit myself to no IDE or UI controls, as those require a lot of additional effort to build.
- **Companion Game:** I started immediately on [Oneons](https://store.steampowered.com/app/1342600/Oneons_Prisoners/), my companion game: a tiny broughlike dungeon-crawler with 12 floors of mayhem, monsters with powers, and tactical combat. I shipped the first version of Oneons, with Puffin, in a month for the [Persistent Game Jam](https://itch.io/jam/persistent-roguelike-jam/).
- **Unit testing:** Most of the Puffin code is unit-tested, and every commit builds and runs the test in Jenkins. This helped me notice when I accidentally broke things.

Ultimately, Puffin didn't meet my needs; in particular, the choice of an ECS architecture didn't mesh well with Godot-style nested scenes and subscenes.

I may revisit Puffin in the future, and I certainly learned a lot about development through this experience. I hope you, too, will find the time and effort to build something, big or small, to help you build games you like faster and better than whatever you're using today.
