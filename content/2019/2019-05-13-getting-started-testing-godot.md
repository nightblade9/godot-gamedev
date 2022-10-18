Title: Getting Started with Unit and Integration Testing in Godot
Date: 2019-05-13
Category: Game Development

![screenshot with code on top](https://i.imgur.com/F3hoasj.jpg)
(Image credit: [Godot blog](https://godotengine.org/article/tests-needed-godot-2-1-4-beta))

Godot affords the possibility of unit and integration testing `gdscript` code via the GUT extension. If you're getting started with unit/integrated testing (collectively "automated testing") or Godot, and interested in what automated testing can do for you, read on.

# What is Automated Testing and Why do I Care?

Your game contains lots of logic. When you make changes, you need to re-test that everything that worked before, still works (nothing broke). As you find and fix bugs, and get into corner-cases of your game (eg. testing the entire play-through), manually re-testing everything becomes more and more time-consuming.

Automated testing provides a solution to these problems: what if you could *write code* that would test your game code? What if that code could run through all the necessary scenarios of your game in a matter of minutes, or seconds? What if you could run the tests after every single change, and be sure that you never broke anything?

Automated testing provides exactly this benefit. You write test-code that tests your "production" code. Unit tests, which test very small levels of functionality, run in in a matter of milliseconds; integration tests, which typically test workflows (fight monster, get experience, level up, spend skill points) take longer, but allow you to automate workflows.

Finally, any experienced developer with automated testing will agree: the *mindset change* you get from automated testing is unparalleled. Not only can you test *every single line of code* you change, making sure it works, but you can also make bigger, riskier changes, because of your safety-net of unit tests. You can actually go faster, and make bigger changes, with your safety net of automated tests.

# The Downside of Automated Testing

Like many things, automated testing is a trade-off. Unit testing is the de-facto standard now in the software industry, so we happily accept the downsides in exchange for the wealth of benefits we receive. Regardless, here they are:

- **Automated tests take time to write.** You could be writing production code instead! For very tiny projects, proof-of-concepts, prototypes, and simple applications, you may not care about testing at all.
- **Writing testable code changes your code.** Your code ends up being more decoupled, more isolated, and more testable. While these are all good software engineering practices, some communities look down on this.
- **Flaky tests.** Poorly-written integration tests (and sometimes unit tests) can fail on and off, sometimes for reasons not related to your change. (As you become more experienced with testing, you learn how to write less-flaky tests.)
- **Major refactoring is expensive.** If you decide to change a significant amount of code - like moving a method from one place to another, or significantly changing functionality - you now need to pay the cost of updating lots of broken tests.

Overall, the benefits heavily outweigh the costs. There's really no reason not to write automated tests!

# Unit vs. Integration Testing

We touched earlier on the difference between unit and integration tests. Typically, unit tests test a single method or class. The hallmark of unit tests, is that they don't depend on anything external - they don't touch the database, the file-system, they don't make web-service calls, etc. Because of this, unit tests tend to be extremely stable and robust, and run in sub-millisecond time. A large suite of thousands of unit tests may run in just a few seconds.

However, unit tests, by nature, test only a very limited set of functionality. Integration tests, in contrast, typically test more complex scenarios, and/or workflows.

Imagine we wrote an RPG-style game. The user can battle monsters; on victory, he receives experience points, and can use those to invest in learning new skills.  If we structured this as typical domain-driven classes (such as `Player`, `Monster`, etc.) we might write unit tests such as:

- `Player.attack(target)` damages the target
- `Player.hurt(damage)` decreases health
- `Player.hurt(damage)` throws an error if damage is less than zero (programmer bug)

These are all class/object/method-level tests. In contrast, we might write integration tests such as:

- When a player fights an enemy and defeats it, the player receives experience points
- When the player receives enough XP, they level up and gain skill points
- When monsters defeat the player, the game reaches a "game over" state

These tests, by nature, work with a larger set of code - so you can test more things. But, they can also be more fragile - if something breaks in the workflow (damage calculation broken? Level-up calculation broken? Skill-points UI broken?), the test can fail.

# Godot with  Mono vs. GDscript

Godot provides two options for unit testing, depending on whether you prefer C# or GDscript.

If you prefer C#, create your project as a Godot + Mono project, and write as much logic as possible in the C# code. This way, you can use the "usual" set of C# testing tools (NUnit, Moq, etc.) and everything Just Works.

If you can't, won't, or prefer GDscript, you can use the GUT extension. (GUT stands for Godot Unit Test.)

# Getting Started Testing (with Gut)

The [GUT project page on GitHub](https://github.com/bitwes/Gut) provides a [detailed explanation of getting started](https://github.com/bitwes/Gut/wiki/Install), which I won't repeat here. Install GUT in your project, create a new scene with the `Gut` object, and you're ready to go.

Instead, I'll focus on getting started testing: what do you test? Assuming you have an existing project with an extensive code-base and zero unit tests, what do you do?

Fundamentally, you need to start doing two things:

1) Refactor your code to make it more testable
2) Write tests for any new code

We didn't really touch on testable code in any depth. The short version is: write simple classes with simple methods, and avoid dependencies on any external "things." For example, if your `Player.damage` class depends on a `Globals.battle_difficulty` multiplier, accept it as a passed-in value instead of referencing the `Globals` script. Change this:

```
// player.gd
class damage(target):
  var total_defense = target.defense * (1 + Globals.battle_difficulty)
  target.current_health -= self.strength - total_defense

// Elsewhere
player.damage(selected_monster)
```

To this:

```
// player.gd
class damage(target, battle_difficulty):
  var total_defense = target.defense * (1 + battle_difficulty)
  target.current_health -= self.strength - total_defense

// Elsewhere
player.damage(selected_monster, Globals.battle_difficulty)
```

While the code is functionally equivalent, the latter is far more testable: you can pass in whatever value of `battle_difficutly` you want in your tests, even invalid values like -3! In fact, this is the kind of functionality you want to unit-test: in addition to making sure it works with a correct difficulty, you can test that it fails appropriately (eg. throws an error or returns 0) with an invalid value - something you can't easily test through the actual game.

# In Conclusion

We covered a lot of ground in this article.  In summary:

- We talked about automated testing, and why we care about it at all
- We looked at some of the benefits and advantages of unit-testing
- We touched on some of the downsides, most of which are not really disadvantageous
- We looked at unit vs. integration tests, and one way to define integration tests as workflows
- We covered testing with C# (in brief) vs. testing GDscript with Godot
- We looked at writing a few simple unit tests on a player class, and making code more testable

I hope this post benefited you, and convinced you to at least try unit testing! Please let me know your feedback [on Twitter](https://twitter.com/nightblade99) - whether you decide to try testing, what you didn't understand, and what kind of topics you would like me to cover in future articles on Godot and testing.