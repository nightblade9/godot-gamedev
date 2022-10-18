Title: Web Application Translation Architecture in .NET
Date: 2020-08-11
Category: Web Development
Tags: .NET Core, Architecture

![globe of languages](https://i.imgur.com/bqyLzs1.png?1)

So you want to localize and internationalize your web application? There are a lot of considerations, but here, we briefly discuss just the translation part.

This post covers a couple of the architectural/design options and discusses their respective trade-offs. While this is a bit specific to .NET, other languages no doubt provide similar concepts, with various levels of API support (e.g. language stored in cookies)

# Individual Translations via RESX Files

.NET and .NET Core provide some infrastructure called "resource files" (`.resx`) extension). These are XML files which you can edit directly in Visual Studio; at runtime, they compile down to a binary format. They generally recommend creating a few resource files (one per back-end controller or shared module). Advantages of this approach include:

- Easy editing of the file (in-IDE)
- Easy versioning/history of the file (it's a text format)
- API support for configuring the prefered language in a cookie, etc.
- Localized changes on translation change (no need to re-test everything)
- Efficient, with a small size at runtime

The disadvantages of this format include:

- Any translation change requires recompiling the entire application
- Editing dozens of files can be very cumbersome
- Difficult to make a translation change and see it immediately in-app (unless you're a developer)
- You can't store any sort of metadata (e.g. notes) with translations

Overall, I think this approach works well if you plan to update translations periodically and don't need an external translater. (If you do, and they're not a coder, you'll need to make additional tooling to export/import the strings in a format they can understand.)

# Using a Database for Translations

One common alternative approach is to store the translations in a database (relational or otherwise) and simply load/display them at runtime. This confers some additional advantages over resource files:

- Ability to update a translation and instantly see the change in-app
- Ability to store meta-data (like notes) with each message
- You can quickly query to find missing strings in various languages
- Non-technical users can easily edit translations via a simple web UI

However, it contains some additional downsides:

- You need to write a web UI to allow translators to be able to view/update translations
- Making several database calls just to load one view/page, can be costly in terms of performance
- You can read/cache strings in memory on app-start, but then your app requires additional memory per language

I think this approach suits situations where you absolutely must be able to see updated translations reflected immediately, or where you have non-technical translators who need an easy way to be able to update translations.

If you know of any other architectures/designs, drop me a note [on Twitter](https://twitter.com/nightblade99) and let me know!