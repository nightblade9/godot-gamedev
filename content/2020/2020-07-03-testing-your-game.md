Title: Thoroughly Testing Your Game
Date: 2020-07-07
Category: Game Development

![2 unit tests, 0 integration tests](https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimg.devrant.com%2Fdevrant%2Frant%2Fr_519301_QxQcw.gif&f=1&nofb=1)

# Why Test?

Of all the fun, interesting, exciting game development topics I could write about, I chose: testing.

Why?

Because testing is *essential* to shipping your game without bugs and without hours upon hours of manual effort. As we'll see shortly, there are well-known patterns and practices you can apply; some generic to softwre testing, and some specific to game testing. 

I discovered these practices after working more then a decade as a professional software developer, and applying them on and off for a decade as a hobbyist game developer. They take time, yes. They work, often and they're better (faster, more reliable, consistent) than manual testing.

# Overall Strategy

Your goal with software testing is to release your game at the highest possible quality: that means NO BUGS! Everything should work the way the designers intended, *without* us spending tons of manual hours play-testing the same parts over and over and over (yawn).

Your overall strategy needs to include the following categories:

- **Unit Testing:** So you know your methods/classes/scripts/objects work at a granular level.
- **System Testing:** Make sure cross-object workflows succeed, like "user last-shots an enemy and gets bonus gold." Sometimes called integration testing, functional testing, or end-to-end testing.
- **Regression Testing:** Every bug you find and catch should be exploited by a unit test. If that test passes, it guarantees the bugs won't repeat.
- **Exploratory Testing:** There's no substitute for playing your game and trying weird stuff. You'll find quirks and things that your automated tests won't catch.

Without these fundamentals, be prepared for lots of bugs and poor game reviews! Above and beyond them, depending on your available time, skill, and interest, you may benefit from additional categories:

- **Balancing:** Write tests that make sure the game is balanced, e.g. each class has roughly the same DPS, or that dungeons generate with roughly the right progressive difficulty
- **Performance or Crash Testing:** Running previously-problematic code and making sure it's fast or doesn't crash. This includes running your game overnight to see if bad things happen.

I can't reasonably explain all those topics in a suitable depth without writing an essay, but get in touch with me if you would like more information on these topics.

# Testing Process

Regardless of how little or how much you utilize the above categories of testing, you *need* to properly test your game whenever you make a change. Properly means: sufficiently testing those areas that *may* be affected, to make sure they still work as expected.

After all, global variables are still a thing. Singletons can easily be accessed from anywhere. Highly-coupled code is common in (and out) of games. You need to make sure you didn't break stuff by mistake.

How? Simple; but it all depends on two things:

- You have a continuous integration setup which builds on every commit
- You have a way of producing a final kit (installer, standalone executable, etc.) that you're going to ship

Let's start with baby steps. Whenever you make a code change:

- Write unit tests
- Run all unit tests continuously (before you check in)
- Have a continuous integration solution (e.g. Jenkins, Travis-CI) build your code and run tests every commit

This makes sure your code works (very granularly, at a class/scene/script method) and that you didn't break anything in an unrelated area. Good unit testing usually uncovers bugs (while you're writing the test code). They run fast (sub-second), so you can test lots of things quickly.

If you have integration/functional/system tests, they're usually slower (seconds each), but highly valuable, since they're like a mini version of your game in some scenario/situation. Run those as part of the build, too.

After the build runs, it generates a playable binary of some sort. Against this, you want to properly test the new feature/change/fix you just added. Like, *properly*, including things leading up to it and things after it should have happened.

With this done, you can be reasonably sure your game works, assuming you have good coverage of unit, regression, and system tests. You may want to run some exploratory tests: mess around and see if you can find anything or break anything.

# Release-Time Testing Process

Your game is done, hurray! Congratulations! Now, the fun part: testing your game before you ship it. Since you have a robust build system in place, take the binaries from a passing build, and test it.

The best way to know if your game is likely ready, is:

- Play it from beginning to end
- Stop and fix any bugs you find, verifying them through the build binaries
- Depending on the game length, either start over, or finish the run

Repeat this until you can complete the game without finding anything to fix.

Also, when you find a bug, you don't need to re-test *everything*; you can re-test *just* the affected area (e.g. inventory management) and any other areas that might be affected because of shared/common/global code (e.g. item crafting).

# Balancing, Performance and Crash Testing

If you write tests for balancing (make sure monsters, or skills, or levels, etc. are balanced with respect to each other), performance (make sure a certain part of the game runs fast enough), or crash (exercise a workflow and check it doesn't crash) testing, you can run them as little or as much as you like.

I recommend running them at least weekly or per-sprint, to make sure nothing broke unexpectedly. If you have a good CI system and don't mind longer test runs, you can run them as part of the CI.

# Conclusion

Testing is expensive! It takes time and effort! Write tests, debug tests, update tests! Anyone who tried this process will likely tell you *it's worth it*. The pay-off of pressing a button or pushing a commit, and having *confidence* that your game works, in every way you tested, is well worth the effort.

Don't be daunted. Take baby steps. Practice. Ask questions. Try to add a bit more to each new project you start, so you can eventually master all these skills. They take time.

If you ever want a second opinion or sounding board, or have questions or comments, feel free to reach out to me [on Twitter](https://twitter.com/nightblade99) or [Discord](https://discord.gg/frKXYtG).
