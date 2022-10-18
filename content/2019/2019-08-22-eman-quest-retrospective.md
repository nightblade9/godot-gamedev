Title: Eman Quest Retrospective
Date: 2019-08-22
Category: Retrospective
Tags: Godot

<img src="https://i.imgur.com/rpSFnxr.png" alt="screenshot of the protagonist in a cave map" width="750" height="450" />

Welcome to the rather large retrospective on [Eman Quest](https://deengames.itch.io/eman-quest). Eman Quest, if you haven't heard about it, is a "procedurally-generated mini-RPG with memory mechanics." You can try the full game, for free, on Itch.

This retrospective covers two parts: first, the overall idea (what did I plan to achieve? What did I actually achieve? Reflections), and the key lessons learned (mostly specific to Godot).

# The Overall Idea: A Procedurally-Generated RPG

I really like procedural content generation (in general), although it's deceptively difficult to implement correctly (corner cases really get you). I always wanted to make a "procedurally-generated Chrono Trigger-like RPG," although that's a huge undertaking; Eman Quest was the first step: creating a small, "lightweight" or "mini" RPG.

What, exactly, did I include in Eman Quest?

- A fixed story about life, faith, and family
- Seven different areas; these are three geographies (forest, cave, and dungeon) each with multiple biomes (frost forest, death forest, desert dungeon, etc.)
- A unique world: each time you play a new game, it picks three out of seven biomes, and generates the required maps for each.
- Unique enemies, two per area, statically-generated and balanced with careful trade-offs (eg. glass cannon, tank), and a unique boss per biome.
- Procedurally-generated equipment (weapons, armour), including their stats
- A battle system that relies on not puzzle/thinking or skills/reflexes, but memory: remember the selected tiles, pick them to get action points, chain them to get tech points, and then use them for your turn.
- Two fixed skills in battle
- A progression system with experience, levels, and stats points you can distribute to your liking (respeccing is free).

<img src="https://i.imgur.com/2bx1y6M.gif" alt="one round of battle" width="750" height="450" />

I didn't include many things in Eman Quest; specifically, I analyzed Bastion, how they cut corners to cut down on the amount of content they needed to complete the game, and applied it to my game. Specificially:

- I scrapped procedural story-, world-, event-, and character-creation, and wrote a fixed story instead
- I scrapped the world map, because it adds little or no value
- I didn't incude any NPCs or shops, because those require a lot of art/coding. (You always find better equipment in chests than what you're using.)
- I cut a few things in content: avatars, some biome variants (crystal caves), variant bosses, and unique final-boss skills.

# What Went Well

Overall, I am very happy with the result, and thankful that I could finish this project, although it doesn't come quite close to my initial vision (due to scope cuts and resource/time constraints).

Things I really like about Eman Quest:

- It "feels" like a procedurally-generated RPG.
- It's balanced (monsters seem quite distinct/different to fight) even though it's on the easy side
- Quite a few people completed the game
- The memory mechanics received some compliments (more on the design below)
- I shipped. Especially considering I tend to abandon long-running projects, this is especially important to me
- I polished the game considerably, including audio (background and sound-effects)
- I received some fan-art, and several questions about my protagonist; which prompted me to create an elaborate background, and a character representing many minorities: a strong woman, a Muslim, and an African
- I represented Muslims and Islam positively, and communicated one of our values (good treatment of parents)
- I learned a lot about game accessibility, and added a few accessibility options into my game

Below, you can see the fan-art of the protagonist, Aisha.

As my first full Godot project, I'm not really proud of the code quality; as I joked on [my Discord server](https://discord.gg/frKXYtG), code quality decreases as you get closer to production!

<img src="https://i.imgur.com/LeKMWbk.jpg" width="600" height="570" />

## Memory Mechanics

![memory mechanics screenshot](https://i.imgur.com/xOOetlV.png)

Aside from the technical challenge of creating a procedural RPG, I challenged myself to create a fun battle mechanic based on memory instead of reflexes or puzzles.  I also received lots of good feedback about this from users, who praised the memory mechanic as interesting.

The core mechanic works simply: a 5x5 grid appears, some squares highlight for a fractional second, and then disappear. You need to click on those highlighted tiles to accumulate "action points," which you can use for different actions (attack costs 2, critical costs 3, and defend/heal costs 1).

In initial prototypes, I experimented with requiring players to pick both energy (action poinst) and actions they wanted to play. This proved to be quite "stressful," because you have a fractional second to look for both required energy tiles and action tiles; midway through development, I streamlined it into what it is now.  I also tried several variations (incluiding a "simon says" type mini-game and a stream of "which of these items did you never see before"), both of which didn't seem fun enough to include in the final.

I also found that battles become somewhat rote and mechanical/deterministic after a while: you pick the five specified tiles, then pick crit, attack, and repeat, healing as necessary.  To change it up, and to reward skillful play, I added techniques/skills and technical points.

Players who pick three or more tiles correctly in a row (with no mistakes) acquire tech points. If you select all five tiles correctly, you get a total of three tech points. You can save these up and use either five or seven for stun/vampire skills respectively. This adds an element of strategy and non-determinism.  Tech poinst also persist across battles, adding another dimension of planning.

# What Didn't Go Well + Key Insights

I initially planned one month to complete the project; it ended up taking around nine months. Why? Many reasons, including:

- I realized early on that different forests just didn't cut it, and needed both variation (styles of forests) and map types (cave, dungeon, etc.)
- Creating art was not my strong-suite, and I needed three distinct tilesets, each with two unique variations
- Finding, drawing and animating 14 monsters, and their walk cycles, took a lot of effort; even though I found many of the base sprites and received lots of help on the art side.
- I added the story about five months in, and required implementing an entire message dialog system, key-item system, final-game events, and lots of unexpected things.
- Technical struggles with, and crashes in, Godot (more on that below).

I ran into several difficulties along the way.  These include:

- Learning Godot's API, which seemed quite foreign to me (anything is a scene and can contain sub-scenes). Also, Godot is quite a wide framework, and it takes time to discover/learn/use things (like UI components).
- Learning about Godot's automatic garbage-collection (`free` and `queue_free`) and how they destroy all objects when changing scenes. This caused me to rewrite my early version to completely separate data about maps (tiles, treasure, etc.) from the visual presentation of those, which got GCed.
- I wrote garbage, prototype-quality code throughout. This lead to numerous bugs (some difficult to diagnose and fix), and a cycle of "fix something but break something else" late in development. You can see tweets with some bugs, including a few hilarious ones, [here](https://twitter.com/search?q=%40nightblade99 %23EmanQuest %23Bugs).
- I didn't write any unit or integration tests. This meant I could break things without noticing for days/weeks. I remedied this quite late in development by using GUT (Godot Unit Testing).
- Lack of CI. Unlike other, C#-based projects, I couldn't get Travis to run my tests; so if I forgot to run tests, broken things stay unnoticed.
- The final game crashed a lot, which caused a lot of stress and resulted in a lot of lessons; so I wrote a section just on that.
- Close to the end of development, I lost my GPU on my main development machine, and my main Windows installed contained drivers that didn't run with Godot 3.0.6. I ended up switching to Linux (which included up-to-date drivers), but lost of a lot of time; I also upgraded Godot to 3.1.1, which initially showed a problem with cave maps running at 2-3FPS, but works fine on Linux.
- Serialization for saving games. As [the Godot docs on saving games](https://docs.godotengine.org/en/3.1/tutorials/io/saving_games.html) suggests, you need to *manually* serialize all your (nested, hierarchial) data structures into JSON. This requires a lot of boilerplate, and it's very tedious (you may miss a field and not realize unless you test thoroughly).

## The Game Crashed on Release

When I released the game, it crashed. A lot. This undoubtedly resulted in a terrible first-impression, although I received several supportive comments such as "it crashed once and then I reloaded and it was fine" or "it keeps crashing after battles but I completed the game."

Why did it crash, why didn't I notice, and how did I fix the crashes?  Well, I'm glad you asked.

Godot runs the game in the editor, somewhat differently from when you export the final platform-specific release. This includes differences such as caring about case-sensitivity (which the Editor doesn't, on Windows), and - critically - crashing when you do Bad Things (like waiting for an event and disposing the scene before it comes back).

I always tested Eman Quest from within the editor, so I never noticed (or cared to notice?) the errors. The game also crashed on Linux and (troublingly) MacOS (which I don't have hardware to test with), but not on Windows, so I failed to catch it in my pre-release testing.

In the end, I upgraded Godot from 3.0.6 to 3.1.1 (someone commented that it didn't work with their graphics card, and 3.1.1 works with OpenGLES 3.1 and earlier), and the crashes disappeared.  I also:

- Tested on Linux (after switching to Linux) and found I could reproduce, and fix, one crash
- Fixed sporadically-appearing errors that Godot printed out, which fixed at least one crash
- Received great offers of help from people on Twitter, specifically running MacOS, who found workflows in-game that reproduced the crash, and verified after I fixed them.

# Action Items

I learned several key lessons out of this. Learning about Godot itself proved invaluable; beyond that:

- **Write clean code.** (Clean meaning, as good as you can make it.) This results in less bugs and less painful troubleshooting later on when things turn bad.
- **Export and test your project often.** This catches bugs, crashes, and all kinds of badness that you don't want players to find first.
- **Fix all runtime errors, and any errors/warnings Godot generates.** These often foreshadow crashes when the game runs (sometimes, only on select platforms - Windows seems fairly resilient)
- **Unit test everything.** Unit testing is cheap, runs quickly, and pays for itself in spades; you can quickly catch issues without manually retesting everything.
- **Set up a continuous integration pipeline to run your tests.** With GitHub and Travis, you can check in code, and get an email whenever you broke some tests (but didn't notice by running them manually). That can be invaluable to avoid breaking things that work.
- **The Godot community is awesome.** Ask on Discord, open a GitHub issue, post a tweet - there are experienced developers who will get back to you, promptly, with solid solutions. Just be careful what you ask for! (I upgraded to Godot 3.1.1  and needed to redo all my UI to fix a tiny bug with one slider.)
- **Always update to the latest version of Godot.** It really works better, and often clears up hard-to-fix bugs.
- **Make friends on Twitter.** You never know who will like, follow, comment, download your game, and - critically - help often comes from those who we least expect it from.

Finally, I want to personally thank everyone who helped me with the project - you know who you are. Without your help, coaching, support, and mentorship, I would never actually finished the game.