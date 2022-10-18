Title: Godot Game Crashes On Startup, Logo Shows/Hides
Date: 2019-04-29
Category: Technical
Tags: Godot, Android

I recently rebuilt a small app/game using Godot. For reference, the game contained one core loop, and took about four hours to build (from scratch). I reused all of the assets from the previous version of the game (audio and graphics), which took the bulk of development time on the original.

The game built and ran flawlessly in Godot on Windows. As soon as I ran it on Android, the game briefly showed the Godot loading logo for ~100ms, then it disappeared, then reappeared/disappeared around four times (you can see the original issue I opened about on GitHub, [here](https://github.com/godotengine/godot/issues/27583)).

The root cause of all this was multiple resources preloading the same script. I had a scene that preloaded `HelperScript.gd` and then `Second.tscn`; but `Second.tscn` also preloaded `HelperScript.gd`, causing the crash.

I found three different ways to address this problem:

- **Use singletons.** Instead of preloading `HelperScript.gd` everywhere, I simply added it to the list of auto-loaded singletons in Godot. Problem solved. (This solution also makes sense, because I needed the same common method from `HelperScript.gd`.)
- **Use `load` instead of `preload`.** This makes me think `preload` is bugged; calling `load` succeeds without any issues. Obviously, this has performance implications - you may *want* to preload your entire game at startup time.
- **Refactor.** In my case, I needed a common function from a shared script. What if I used the same file, but two different functions? Perhaps I could split `HelperScript.gd` into two different scripts, and just load what I need instead.

If you find your Godot game crashes on startup without explanation, maybe this is something you can investigate. (Failing that, go for a `git bisect` and try to isolate the commit that broke everything.)