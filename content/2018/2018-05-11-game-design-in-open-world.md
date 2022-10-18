Title: Game Design in Open-World
Date: 2018-05-11
Authors: chemicalink
Category: Game Development

According to many, open-world is fun. Perhaps it's the sense of freedom, progression, or influence upon the world
which tickles a player's funny bone. Whichever it is, if there's anything we game designers know, it's that it's hard to
pull off.

### Open-World?! What's That Mumbo-Jumbo's All About?

Firstly, what is an open-world game? [Trusty Wikipedia reports](https://en.wikipedia.org/wiki/Open_world),
```
A video game in which a player can roam a virtual world and approach objectives freely, as opposed to a game with more linear gameplay.
```
Yet with such a notion of a player freely wandering into wherever they please comes bundled with a set of issues which,
if not dealt with properly, will make or break your game. Most prominently...

### Player Power Level vs. World Power Level

Imagine you're making a game with a linear main quest where monsters gradually get stronger as the player progresses and
gains more power. You wake up one day and decide open-world is the one feature which *has* to be included in your game.
So you go ahead and remove all travel restrictions, and add a bit of side content.

The ingenuous player decides to delay your main quest and spend some time on side quests. "Those monsters sure keep
getting stronger," thought the player. "I need to do some side quests so I can stay one step ahead of them."

Lo and behold, your carefully crafted power balance is completely destroyed, leaving you with an overpowered player
to wipe the floor with any poor monster who dares cross his path.

I'm sure you can imagine an alternative where the player is wrecked in side quests meant for a more powerful player.

### The Solution

So how do you solve this? Let me just quote [a little thing](https://gamedev.stackexchange.com/a/1660) I've read in the vast cosmos of the interwebz:
```
Game design is pretty much one giant [CENSORED] ball of borrowing
```
In other words, in order to do things properly, we need to study the work of others, and see how *they*'ve done it.

Let's take a [look](http://en.uesp.net/wiki/Skyrim:Leveling) at the amazing Skyrim. How does it handle its level scaling?
```
Different locations in Skyrim have different inherent difficulties. In other words, some dungeons are designed to be too difficult for low-level characters to enter.
```
That is to say, every location has a minimum and a maximum level. Say we have a dungeon from level 5 to 30.

If the player enters *before* the minimum level at, say, level 2, they enter a dungeon with stronger level 5 enemies and
better loot. If the player enters *within* the level range, for example, level 15, the dungeon would contain level 15
enemies. And if the player enters *after* the maximum level, that is, 30+ they get to wipe the floor with level 30 enemies.

Such a system allows for intricate risk/reward balancing. As in, "Just defeated a horde of trolls 10 levels above yourself? Here's
some awesome loot to compensate." and "Done wiping the floor? Here's your two septims."

### In Conclusion

Well there you have it. You've learned to avoid a game-breaking problem with open-world games. And in the solution,
apply a new fun mechanic giving the player *choice*; and lots of rewards for daring ones.

What do you think of the proposed solution? Have you encountered other problems with open-world games? Leave us a comment
with your thoughts.
