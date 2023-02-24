Title: Using Godot with C# for Blind-Friendly Text Games
Date: 2023-02-23
Category: Technical
Tags: Godot

![Picture of a speaker crossed-out](https://i.imgur.com/WClABct.png)

I recently found a sweet, sweet solution to using Godot to create text-games for blind-friendly players. This matters because:

- [The performance of Godot's TTS APIs can vary a lot](https://docs.godotengine.org/en/stable/tutorials/audio/text_to_speech.html#caveats-and-other-information)
- Console output easily integrates with screen readers
- Blind players can take advantage of their preferences (voice, speech rate, etc.) and advanced screen-reader features (forward, rewind, etc.)
- Godot ships with many strong features for audio games, such as reverb and 2D positional audio.

# The Problem

Running Godot games spawns a console window. By default, this window displays a lot of things we wouldn't want players to see or care about, such as:

- The version of Godot running
- The renderer used (e.g. Vulkan)
- Warnings generated from our game
- Errors and stack-traces generated from our game

# The Solution

Fortunately, the former displays on `stdout`, and the latter on `stderr`. This provides us with a simple way to run Godot and suppress all text:

- In the Project Settings > Application > Run, check `Disable stderr`. This prevents warnings/errors from being printed.
- Check `Flush stdout on Print debug`. This means every print statement gets immediately printed.

All this leaves is a way to print output to the console; you can achieve this by creating a warpper method like so:

```C#
public static void Write(string message) {
    System.Console.WriteLine(message);
    Godot.GD.Print(message);
}
```

The first line prints only when the game is exported. The second prints only when the game is run in-editor (e.g. debugging). If the `--no-header` argument is implemented, you can also add that to your shell/batch script for running your game to disable the Godot header output; `--quiet` does the same thing.

# User Input

Also, you can read player input with `System.Console.ReadLine` and friends - but be warned that this freezes the main Godot game. Perhaps running it in a separate thread may work. This makes it simple to build an interactive text game.

# Going Beyond Text

Of course, there's no reason to stick just to text. You can use your main Godot game window to display relevant data, stats, scenes, whatever you like. You can even add buttons and allow users to input using buttons or console text as they see fit. Plus, fancy features like reverb!

# What's Next

While text games aren't the Bee's Knees any more, I would love to see more text-accessible games made in Godot using this approach. If you're interested, check out the [Games for Blind Gamers 2 Jam](https://itch.io/jam/games-for-blind-gamers-2), or follow along on [Mastodon](https://mastodon.gamedev.place/@nightblade9) or [Twitter](https://twitter.com/nightblade9) as I build a blind-first game using this approach.