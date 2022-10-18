Title: Using Feature Toggles to Keep your Demo Code Up-to-Date 
Date: 2022-03-28
Category: Game Development

One of the problems we run into as game developers, is keeping our game demos up-to-date. Data suggests that keeping your demo up longer results in more wishlists and sales; but how do you manage keeping your demo up-to-date with your game as it changes (including copying over bug-fixes)?

Most developers opt to keep a separate branch/version of demo code, and manually keep that up-to-date. As the game and demo code diverge more and more, porting over changes and bug-fixes becomes a bigger and bigger headache.

Instead, I proprose another solution: using feature toggles to keep your demo separate. This way, you keep a single code-base for your demo and production game. (You can read about feature toggles in [Fowler's execllent, comprehensive guide](https://www.martinfowler.com/articles/feature-toggles.html).)

How this works:

- You add a feature toggle for something like "is_demo" or "demo_content"
- You gate as much content as possible behind the toggle
- You publish two versions of your game: one with the feature (demo) and one without (full game)

Benefits of this approach:

- Main game and demo are always in synch: you can easily change what's in the demo (levels, skills, etc.)
- Any bug-fixes in the main game, for bugs that are present in the demo, get fixed in the demo for free.
- Requires minimally-invasive changes in your game to create the demo version

The main drawback of this approach, is that **your demo includes all the content and functionality of the actual game.** While this means you can easily do things like switch which skills and levels are available to the player, it also adds the possibility of someone reverse-engineering your demo and getting full access to your game. If you're not okay with that, I suggest you look at other approaches.

## Gating Content

Depending on your language/engine of choice, you either gate content behind pre-processor statements (e.g. `#if DEBUG`) or regular if-statements (e.g. `if Features.IsDemoMode == true`).

I can't stress this enough: it's really important to learn from "defense in-depth" and **gate as much as you can.** You want to protect your game from technically apt adversaries who can decompile/reverse-engineer it and gain access to the full game.

To do this, add checks absolutely everywhere possible. For something like [Gem Worlds](https://store.steampowered.com/app/1858760?utm_source=blog_demo_features), this means adding checks in the skill shop, in the core game (when a level loads), on the title screen (continuing a game but you're past the end of the demo?), etc.

For additional security, if possible, store content and data in JSON/external files, and use your editor to switch which of those files is used in the demo. (e.g. if your skills are stored in `skills.json`, maybe you have two versions - `skills.json` and `skills-demo.json` - and can switch which one is used in the demo build.)

While this is game-specific, the more checks you add, the better; not only do you reduce the chance of accidentally giving players access to the full game, but you also make sure that there's no way for them to break out of the demo content.

The other problem with gating using feature toggles, is that **it really requires additional testing of the final build.** Try your game, play through to the end; then put on your attacker hat, and try to circumvent the restrictions. Can you edit the save files and get inaccessible skills, or go past the last part of the demo? Make sure you test until you feel comfortable that it's bullet-proof.

If all else fails, platforms like Steam allow you to remove/disable the binaries (and in Steam's case, it yoinks the files away from the user's system). You can always rely on that in case things go bad.

## Publishing Two Versions

Finally, constructing the demo build. Many programming languages since C/C++ allow you to define build-time constants, and specify build profiles. This includes C/C++, C#, Java, and others. I will focus on Godot/GDScript, since that's my current stack of choice.

As of Godot 3.4, you need to:

- Launch the export dialog (`Project` > `Export ...`)
- Create a second export option for each platform you support (e.g. Windows, Linux)
- Click on the `Features` tab
- Under `Custom (comma-separated`), add your feature, e.g. `demo_content`
- Profit

(The same steps apply to other game engines, like Unity, MonoGame, etc.)

Once that's done, viola, you have two separate builds - demo and non-demo. Make sure you test thoroughly!

## Closing Thoughts

This blog post illustrates one way to create demo builds, that are always in synch with the main game content. It's not the best approach or the worst, simply one approach you can choose. While it ships the full game along with the demo, with defense in-depth, you can be quite confident that players can't access anything they shouldn't.

If you have any thoughts or alternative approaches, hit me up on [Twitter](https://twitter.com/nightblade99) or [Discord](https://discord.gg/frKXYtG), I would love to know of a better way to achieve this.
