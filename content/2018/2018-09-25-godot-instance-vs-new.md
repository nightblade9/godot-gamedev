Title: Instance vs. New in Godot
Date: 2018-09-25
Category: Technical
Tags: Godot

![godot logo](https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Godot_logo.svg/799px-Godot_logo.svg.png)

## Summary

Godot provides a way to separate the presentation part of game entities from their underlying data. You can think of this as something akin to the Model-View-Controller design pattern, where scripts (classes/code) respresent the model and instanced scenes (sprite, animation, etc.) represent the presentation and control (eg. collision resolution).

During the development of [Eman Quest](https://deengames.itch.io/eman-quest), we continuously ran into a problem around instancing scenes that are *strongly typed* and have methods from their corresponding scripts. In fact, there's even [an open bug about it](https://github.com/godotengine/godot/issues/15866) as of Godot 3.0.6.

You can find a description of the problem below, along with the solution, and recommendations.

## Why This Became a Problem

We created Eman Quest as a procedurally-generated RPG; the idea is to generate a persistent, complete world (maps, enemies, etc.) By itself, this proves to be an interesting and troublesome problem to solve, because:

- In Godot, everything is a scene. Your world map, forest map, etc. are scenes.
- You can't easily persist scenes or their entities.
- When you change scenes, the old scene -- and all entities -- get garbage-collected.
- Fundamentally, you need to separate *data from the view/presentation.* 

To solve this, we started initially by generating scenes and saving those; when the GC reared it's dragonish head, we instead moved to saving data as arbitrary JSON (dictionaries) of key/value pairs; when this required maintaining a set of properties twice (eg. monster strength in JSON vs. strength attribute in the instanced scene), we finally moved to *creating scenes and matching scripts/classes.*

Then we broke Godot.

## The Problem and Symptoms

Near the middle of development, while creating a `TreasureChest` class, I ran into an interesting problem: although my script file defined several methods and properties (like `.open()` or `.contents`), I couldn't call any of them; Godot complained:

> Invalid set index 'contents' (on base: StaticBody2D') with value of type 'Nil'

Godot identified/typed the instance as `StaticBody2D`, not `TreasureChest`. Why?

It turns out the answer lies in the two methods Godot offers to create objects: `.instance` and `.new`

## Scenes vs. Scripts as Classes

Naively, Godot offers two ways to create an entity: `instance` and `new`.

If it's a `Scene` with sub-objects (such as a `Sprite`), you load/preload the `.tscn`, and call `instance`. For example: `var treasure_chest = load("res://Entities/TreasureChest.tscn").instance()`. 

This creates the entire hierarchy of sub-scenes. When you call `add_child` to add it to the scene, Godot calls the `_ready` function; this is where you put *constructor-like* code.

Alternatively, if you just have a "class" defined in a script, you load/preload the `.gd` file and call `new` on it. For example: `var treasure_chest = load("res://Entities/TreasureChest.gd").new(contents, coordinates, etc.)`. 

In the latter case, you define an `_init` function for a constructor, and specify whatever parameters you like. This conveniently allows you to specify state and guarantee invariants, such as "treasure chests always have non-null contents."

However, *Godot breaks when you cross these two together.* If you load a `.tscn` definition and then call `instance`, and *the class/script back-end has an `_init` function,* the instanced scene doesn't have any of the scripts defined methods/properties.

## Solution and Combining the Two Approaches

This *could* be because of timing (when in the life-cycle we're creating the script), I don't know. What I do know, is that removing `_init` fixes the problem. But then, how do we re-add initialization of the entity's state?

For entities where we use both the instanced scene (in the place where we populate the tilemaps, etc. on-screen) and the script only (as the generated back-end data/object), we decided on the following approach:

- Don't use `_init`. It could lead to this obscure bug again later, and suck up a ton of time to figure out.
- To construct a new object class/script instance, create an `initialize` method and use that as the constructor. This is where we can set state/invariants, etc.
- Keep a single scene for the presentation, and use a script to keep all the back-end class code (properties/methods)
- When we need to instance the actual scene tree for that object -- such as with monsters or treasure chests -- keep the data object separate, and create an `initialize_from` instance.
- `initialize_from` sets all the properties on the scene (such as presentation: is the treasure chest already opened or not?) based on the properties of the class/data object underlying.

This approach also solved other problems, such as keeping references to instances across scenes. Godot doesn't like this, because it tries to GC everything. Storing the data separately neatly (sometimes in a singleton script) solves this problem.

## Conclusion and Future Improvements

This solution solves our problem neatly. It keeps our code DRY, by using one definition of an entity's properties. It allows us to separate presentation from model/data, which is useful to prevent coupling.

But, it's not ideal. At best, we can use `_init` judiciously for entities that we know we'll never show in a scene. We can always resort to using data (dictionaries/JSON) instead of classes; we miss out on code completion, but this better represents entity-component systems with data-driven design.

Did you ever run into this problem? Do you see a better way of solving it? Drop a comment and let us know, we would really love to hear about better solutions to this problem.