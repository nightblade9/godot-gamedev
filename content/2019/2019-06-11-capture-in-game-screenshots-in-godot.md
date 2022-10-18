Title: Capture In-Game Screenshots in Godot
Date: 2019-06-11
Category: Technical
Tags: Godot

![Animation of a game saving, with a screenshot appearing on the save screen](https://i.imgur.com/OlsyPli.gif)

Godot allows you to capture in-game screen-shots, without the use of any plugins/addons. However, I couldn't find a complete, step-by-step guide to do this, without relying on any specific nodes being instantiated in your scene.

You can follow these steps. I tested these on Godot 3.0.6. Some of the code originated in a thread that mentioned that "you need this prior to Godot 3.1," but through testing, I eventually removed all unnecessary code. I can confirm that this sample works, because I implemented it in [Eman Quest](https://twitter.com/search?q=%23EmanQuest).

# Saving Screenshots

Godot provides a rather straight-forward API for saving a screenshot:

```
var screenshot_path = "user://screenshot-test.png"

# Retrieve the captured image
var image = get_tree().get_root().get_texture().get_data()

# Flip it on the y-axis (because it's flipped)
image.flip_y()

image.save_png(screenshot_path)
```

This saves a screenshot into a file called `screenshot-test.png`, under the user space; on Windows, that's something like `C:\Users\CURRENTLY_LOGGED_IN_USER\AppData\Roaming\Godot\app_userdata\Eman Quest\screenshot-save0.png`, where `CURRENTLY_LOGGED_IN_USER` is your user name (eg. `nightblade`).

# Loading Screenshots

Loading screenshots proves more complicated:

- To load the data, you can use `image.load_png_from_buffer`, but it takes a `PoolByteArray` - not something you can load with a call to `preload("res://...")`. This requires using the `File` API.
- To set the texture onto a sprite, you cannot simply assign it to an `Image` instance; instead, you need to create and initialize an `ImageTexture` instance.

After we sort through these issues, we end up with code like this:

```
var file = File.new()
file.open("user://screenshot-test.png", File.READ)
var buffer = file.get_buffer(file.get_len())
file.close()

var image = Image.new()
image.load_png_from_buffer(buffer)

var image_texture = ImageTexture.new()
image_texture.create_from_image(image)

sprite.texture = image_texture
```

This loads the PNG file `screenshot-test.png` from the user-space into an `Image`, wraps it into an `ImageTexture`, and assigns it to some `Sprite` instance

# Crop and Scale

Since we loaded our PNG into a `Sprite`, we can execute other operations on it:

- You can set the `region_rect` properties (through code or through the editor) to crop the image
- You can set the `scale` to create a thumbnail of the image
- You can apply effects, colourization, etc.

This affords a lot of interesting use-cases, such as creating a thumbnail of the in-game screen per save-game (my personal use case).