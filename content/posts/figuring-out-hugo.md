+++
date = '2025-02-07T05:26:40Z'
lastmod = '2025-07-17T16:30:49+0000'
title = 'Figuring Out Hugo'
+++

Here are some notes from setting up the `ananke` theme.

# Menu setup

- Add `sectionPagesMenu = 'main'` to `hugo.toml` to enable the section links in the upper right
- I couldn't figure out how to add social media links when I installed the theme
  with git submodules. It worked when I installed it the hugo modules way
  though. Here's the snippet in my `hugo.toml` in my project root to set it up:

```toml
[params.ananke.social.follow]
networks = [
  'facebook',
  'github',
  'x-twitter'
]

[params.ananke.social.facebook]
username = 'tsui.a'

[params.ananke.social.github]
username = 'alextsui05'

[params.ananke.social.x-twitter]
username = 'alextsui'
```

# About page

I created this page with a leaf bundle in Hugo at `content/about/index.md`.
Initially I created a `content/about/_index.md` file to generate an about page, with a top-level navbar link.
However, the text formatting wasn't what I expected.
My understanding is that Hugo has different types of [page bundles](https://gohugo.io/content-management/page-bundles), and using `_index.md` indicates a branch bundle, whereas `index.md` indicates a leaf bundle.
I think branch bundles are intended to be for like index pages that have paginated lists of content, where leaf bundles are more like standalone pages.
The Hugo theme provides different styles to both of these.
So I just renamed `_index.md` to `index.md` and the styles looked more like a blog post.

So going with a leaf bundle gave my about page the right look, but this introduced a problem where the About link disappeared from my main menu navbar.
My guess is that, with `sectionPagesMenu = 'main'` as configured above, the main menu automatically picks up all the top-level sections (e.g. posts from `content/posts`, etc.).
When the about page was a branch bundle, it was treated like a top-level section, but as a leaf bundle, it is not a section, but just a page, so it disappeared from the main menu.
We can add a link to a page in the main menu by specifying in the page's front matter that it should be a menu item.
Here's the front matter for my about page (referencing the example site in Ananke theme):

```toml
+++
date = '2025-07-17T04:52:00Z'
title = 'About'
[menu.main]
weight = 1
+++
```

# Adding the last updated date

TODO
