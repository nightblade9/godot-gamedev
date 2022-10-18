Title: Creating Tilemaps with Tile Entities in Godot
Date: 2018-10-02
Category: Technical
Tags: Godot

Godot's tile editor provides you with the ability to quickly make 2D tile-maps, similar to RPG Maker. This makes it easy to design and tweak maps. But can we take it a step further? Can we, in fact, use the tilemap editor to create *functioning entities* -- making it a domain-specific editor for our specific game?

We can. This post walks through a lightning-quick method you can use.

## The Core Idea

Godot's `Tilemap` entities are simple. They're essentially a reference to a tileset (graphic with all your tiles on it), and one or more layers of those tiles drawn on a grid.  In Godot, tilemaps are all about presentation.

What if you want to add functionality though? Imagine you're creating a 2D adventure or RPG (like, hmm, [Eid Island](https://play.google.com/store/apps/details?id=com.deengames.eidisland) maybe?), and you want to be able to draw enemies on the map. Or trees you can chop down, coins you can pick up, or anything else.

By itself, Godot doesn't provide a way to do this. However, I asked around on Discord, and checked some issues on GitHub about this; a definitive, simple approach appeared, something like a best-practice. How? Easy.

- Define your tilesets as usual, including objects
- Draw them in as many layers as you like, as usual
- At runtime, iterate over the tiles, replacing the object ones with real entities (`Scene` instances)

## The Secet Sauce: Swapping Tiles for Entities

Godot makes this process quite easy. As a pre-requisite, I would recommend:

- All your tiles have proper, uniquely-identifying names (like `Tree` or `Plain Water`)
- You create entities for everything you want to replace, such as a `Tree` scene (subclasses `Node2D`, has a `Sprite`, script, etc.)
- You map the two. I use a dictionary such as: `var entity_tiles = { "Tree": preload("res://Scenes/Entities/Tree.tscn") }`

With this in place, we simply iterate over the tiles and -- if the name appears in our dictionary -- replace the tile with its corresponding entity. Here's [an early reference implementation](https://github.com/nightblade9/eid-island/blob/7ec52d4a9b33feb87d6e05be0908e449cb1fa330/source/Scripts/MapCreator.gd#L48) in Eid Island. 

```
# Find entities on the map (eg. trees). Remove them and replace them with
# real entities (scenes) so that we can have logic (attach scripts) to them.
func _populate_entities(map):
	var possible_tilemaps = map.get_children()
	for tile_map in possible_tilemaps:
		if tile_map is TileMap:
			var tile_set = tile_map.tile_set
			for cell in tile_map.get_used_cells():
				var tile_id = tile_map.get_cellv(cell)
				var tile_name = tile_set.tile_get_name(tile_id)
				if entity_tiles.has(tile_name):

					# Spawn + replace with entity of the same name
					var scene = entity_tiles[tile_name]
					var instance = scene.instance()
					map.add_child(instance)
					instance.position.x = cell.x * Globals.TILE_WIDTH
					instance.position.y = cell.y * Globals.TILE_HEIGHT

					# Remove tile
					tile_map.set_cellv(cell, -1)
```

`Globals.TILE_WIDTH` and `TILE_HEIGHT` refer to the (fixed) tile size; you can, alternatively, use the tileset/tilemap to get the cell size, or use the entity size as a reference (although the entity should be exactly one tile size for that to work).

With this in place, you can quickly and easily create levels with real functionality from simple tilesets.

## Next Steps

One obvious missing piece of functionality is customization. What if my tile is, say, a door that warps somewhere, and I want to specify the destination properties when I draw the tile? How can I do that?

Unfortunately, I don't know the answer yet. As far as I know, Godot doesn't allow you to add additional variables/properties to the tile itself. Perhaps you could store the data elsewhere, such as a separate dictionary mapping entity/coordinates to custom data.

If you know how to solve this latter problem, drop us a note [on Twitter](https://github.com/nightblade99) or in the Godot Discord chat so we can use it too!