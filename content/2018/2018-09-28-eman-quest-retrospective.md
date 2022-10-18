Title: Eman Quest Restrospective: A Procedural RPG in a Month
Date: 2018-09-28
Category: Devlog
Tags: Retrospective

![screenshot of a hero facing a boss](https://i.imgur.com/Nu9doZ9.jpg)

This month, I set out with a very specific goal: create a 2D procedurally-generated RPG; something I've never heard of (or done before). Although I ran out of time, I plan to devote another month to the game. This retrospective discusses the good, the bad, and the work ahead of us.

## Goal: What is a Procedurally-Generated RPG?

I grew up playing Secret of Mana, Final Fantasy, Chrono Trigger, and other great titles. One day, I thought to myself, *what if I can only create one more game before I die? What would I create?*

The answer? Something akin to those favourites; a game that generates a *brand new,* quality RPG, *every time you plan.* I spent some weeks brainstorming what I needed and didn't need, plans to create content such as monsters, weapons, etc. Some things clearly need to be procedurally-generated (such as dungeons and maps), while others don't (such as enemy sprites and player skills).

A couple of false-starts later, I finally opened up the Godot editor and started the third (or fourth) attempt.

## The Good: What Went Well

Initially, I focued on the *technical* side of procedural generation: creating stuff! As of writing, the game:

- Generates a new, persistent world map each time; this includes a river that runs into a small lake, and randomly-positioned dungeon entrances
- A procedurally-generated forest dungeon; it's a single, large map, with trees, dirt paths, monsters, and a boss.
- Procedurally-generated equipment (weapons and armour), each with unique stats modifiers
- Loot in the form of treasure chests in the forest dungeon.
- The story. While very basic, the game generates the intro plot text, including the town name and final enemy type

The forest dungeon took longer than expected. On the technical side, I figured out how to make Godot generate and persist my maps/game; initially with packed scenes (which got garbage-collected when I changed scenes, causing crashes), and later by separating the generation of game data from the presentation (populating scenes/tilemaps/etc. from content).

Solving technical issues aside, I also spent too much time on what didn't go so well: the battle engine.

## The Bad: What Could've Been Better

I find the concept of memory games fascinating (as an ex-Lumosity player). An Extra Credits video on [puzzle vs. reflex mechanics](https://www.youtube.com/watch?v=oEDVDhOYJ2I) challenged me to introduce something new into my game.

At the heart of every RPG, in terms of fun gameplay, lies a fun and challenging battle system. I decided to design a memory-based battle system:

![battle engine animation](https://i.imgur.com/vln27Un.gif)

This probably proved to be my undoing. I spent several days designing, balancing, and tweaking the battle engine; adding new features, action types, and skills. Five beta testers provided feedback after trying it out:

- One really liked it
- One said it's okay and could be improved
- Three others didn't like it

In the end, after several days, I forced myself to stop tweaking/changing it and decided to focus on fulfilling the rest of the game.

Last, and perhaps worst, the game *feels* incomplete. Sure, you get a randomly-generated forest; but even with the intended scope for the end of the month (two dungeons with two different variations, including unique monsters), it might not be enough to give players that experience of a procedurally-generated RPG.

## What's Next

I don't intend to give up; I plan to fill out and ship a version of this game (although with what functionality/content remains to be seen). My current plan of action looks like:

- Finish the end-game sequence so players can actually complete the game
- Create two variants on the forest (frost forest and death forest) each with unique enemies
- Create a second dungeon (cave) with two variants (one is a volcano)

Finally, I plan to create a *proper RPG world.* A good RPG, like a good novel, contains elements that all harmonize and work together to communicate a singular world/message. Right now, we have a patch of hastily-named enemies, skills, etc. and these need to be brought together.

More specifically, I didn't yet start the other hard/fun part of a procedural RPG: creating a procedural world (and story) that feels unique. This includes a unique/different protagonist for each story.

Finally, another round of beta testing should reveal whether the game is interesting/fun or not, and I should either finish it as-is or if I need to rewrite/rethink battles entirely. Time will tell. September may be almost gone, but October brings another month brimming with potential for me to see this game through to its potential.

If you're interested in following my development on this project, feel free to [follow me on Twitter](https://twitter.com/nightblade99). 
