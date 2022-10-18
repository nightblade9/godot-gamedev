Title: Publishing Godot Games to Steam for MacOS without Hardware
Date: 2022-07-22
Category: Technical
Tags: Godot, MacOS

![Godot and Mac](https://i.imgur.com/VXjBne7.png)

Are you working on a Godot desktop game? Would you like to publish it to MacOS, without the pain of learning about MacOS-specific requirements like signing, notorization, and paying $99/year?

The good news is, if you plan to publish your game on Steam, you can easily do this, without Mac hardware. My inspiration for this is: be the change you want to see in the world. Publish your game for Mac (and Linux), so the market grows, and more great games support these OSes.

If you're interested in how to do this, skip the section below; if you're interested in how this all works (sort of), the next section gives a very brief overview of the problem.

## Preamble: Signing, Notarization, and DMG Files

I don't pretend to understand how all this works. My understanding, as someone who mainly uses Unix and Windows, is the following:

- Like Windows, Mac OS requires developers to "sign" their apps with a cryptographic key of some sort
- Unsigned apps previously run on Mac OS with a warning; as of writing (2022 June), they no longer run at all.
- Notarization is a more scrutenized form of signing, and requires sending your app to Apple to approve
- DMG files are native to Mac, and internally contain an .app file

The key thing here: the DMG contains an .app "file" (looks like an executable on MacOS), which is actually a zip file. That zip contains your actual binaries.

## MacOS and Steam

Follow these steps:

- Create a new export profile for Mac. Configure as you like (e.g. exclusion files)
- On a non-Mac system, export your project for Mac. If you're using the CLI, make sure you speify the output file name as a zip file (e.g. `Game-MacOS.zip`)
- Verify the zip contents: it should have a `Game.app` directory (with `Game` replaced with your game name) at the root, with a `Contents` subdirectory
- Upload that zip to Steam
- Set up your launch options. According to the [current Steamworks docs](https://partner.steamgames.com/doc/sdk/uploading#Initial_Setup_New_App), for MacOS, your `Executable` should be set to `Game.app/Contents/MacOS/Game` (replace `Game` with your actual game name / folder name). 

And that's it! If you launch the game on Mac, it should just work!

Finally: I recommend you always make sure someone with Mac hardware tests your game to ensure it launches correctly. If you don't have a friend with a Mac, you can always ask me on [Twitter](https://twitter.com/nightblade99) or by [email](mailto:nightbladecodes@gmail.com) to try it out.