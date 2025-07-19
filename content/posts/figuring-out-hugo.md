+++
date = '2025-02-07T05:26:40Z'
lastmod = '2025-07-19T16:52:40+0000'
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

I modified the layout so it shows when a post was last updated underneath when it was first published.
The last updated is specified in the front matter with the `lastmod` property.
The default layout doesn't render this info though, so I had to override it in my project.
The way I did this was check out the [`gohugo-ananke-theme`](https://github.com/theNewDynamic/gohugo-theme-ananke) code, copy `layouts/_default/single.html` over to my project folder, and make edits to it:

{{< highlight go "linenos=inline, hl_lines=2 5-12, style=catppuccin-macchiato" >}}
  {{ if not .Date.IsZero }}
  <time class="f6 mt4 dib tracked {{ if not (.Lastmod.After .Date) }}mb4{{ end }}" {{ fmt.Printf `datetime="%s"` (.Date.Format "2006-01-02T15:04:05Z07:00") | safe.HTMLAttr }}>
    {{- .Date | time.Format (compare.Default "January 2, 2006" .Site.Params.date_format) -}}
  </time>
    {{ if .Lastmod.After .Date }}
    <p class="f6">
    Last updated:
    <time class="f6 mb4 dib tracked" {{ fmt.Printf `datetime="%s"` (.Date.Format "2006-01-02T15:04:05Z07:00") | safe.HTMLAttr }}>
      {{- .Lastmod | time.Format (compare.Default "January 2, 2006" .Site.Params.date_format) -}}
    </time>
    </p>
    {{ end }}
  {{end}}
{{< /highlight >}}

Let's break down line 2:

```
{{ if not (.Lastmod.After .Date) }}mb4{{ end }}
```

We are conditionally including the CSS class `mb4`.
The expression `.Lastmod.After .Date` is checking whether `lastmod` is a time that comes after `date`. See [`Time`](https://gohugo.io/methods/time/after/#article) doc.


[`mb4`](https://tachyons.io/docs/layout/spacing/) is a class defined by the Tachyons library that specifies `margin-bottom: 4px`.
Basically, the logic is if `lastmod` is after `date`, that means the page was updated after it was published, so we remove `margin-bottom` from the published date so we can put it on the updated date below.

```
  {{ if .Lastmod.After .Date }}
    <p class="f6">
    Last updated:
    <time class="f6 mb4 dib tracked" {{ fmt.Printf `datetime="%s"` (.Lastmod.Format "2006-01-02T15:04:05Z07:00") | safe.HTMLAttr }}>
      {{- .Lastmod | time.Format (compare.Default "January 2, 2006" .Site.Params.date_format) -}}
    </time>
    </p>
    {{ end }}
  {{end}}
```

Finally, a note about the layout path.
It seems like as of Hugo 0.146.0, the template system got an overhaul, and lookup paths got changed.
For one thing, they got rid of `_default`, so `layouts/_default/single.html` should be `layouts/single.html` instead.
More details on this [here](https://gohugo.io/templates/new-templatesystem-overview/).
