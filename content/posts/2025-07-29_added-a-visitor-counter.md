+++
date = '2025-07-29T23:20:42+0000'
draft = false
title = 'Added a visitor counter'
+++

After [setting up this Hugo site]({{< ref "posts/2025-02-07_figuring-out-hugo.md" >}}), I wanted to spruce it up a bit by bringing back a throwback from classic websites back in the day: a visitor counter.
Below are some notes on that as I get more accustomed to working with Hugo.

# The backend

I prepared a backend to handle the visitor count.
Making a request to the backend will increment and return the visitor count.
I hosted the backend on Google's Cloud Run platform.
I chose this platform for the backend because it's serverless and at this point would fall under the free tier of usage, i.e. cost me zero dollars.
Also, I wanted to go through the exercise of setting up a serverless backend.
I'll make a separate post about the details later.
For now, all we need to know for this discussion is that the backend is accessible by a URL.
In order to make it available to frontend Javascript, I will put it in the DOM.
I decided to put it in a `meta` tag in the `head` of the HTML document.
The [ananke theme has a predefined block](https://github.com/theNewDynamic/gohugo-theme-ananke/blob/ff04bf8ba23e3deeeca7c030bca0f0a8537cacfc/layouts/_default/baseof.html#L54) that pulls in a partial file if it's available, so I placed the following snippet in `layouts/partials/head-additions.html`:

```html
<meta name="backstage-url" content="{{ site.Params.backstage.url }}">
```

# Frontend setup

First, I added a DOM placeholder for where I wanted to display the visitor count on my top-level index page.
How do I add arbitrary HTML into a content page though?
The top-level index page comes from `content/_index.md`, but I can't put arbitrary HTML in the Markdown file.
What I *can* do is define my own [shortcode](https://gohugo.io/content-management/shortcodes/), which is essentially an HTML partial file that can be called from content files.
I defined my `layout/_shortcodes/view_counter.html` below.
Note the `span` tag with the data attribute - I'll query for this placeholder in Javascript.

```html
Some <span data-view-count></span> others have visited before you.
```

Then I called the `view_counter` shortcode from the content file like so:

```
{{</* view_counter */>}}
```

Next I added Javascript to Hugo that requests to the backend and displays the visitor count on the page.
How do I add arbitrary Javascript though?
First I need to write the Javascript.
Hugo expects Javascript and other assets to be in the `assets/` folder.
I put the script below in `assets/js/custom.js`:

{{< highlight javascript "linenos=inline, hl_lines=2 7, style=catppuccin-macchiato" >}}
(async () => {
  const backstageUrl = document.querySelector('meta[name="backstage-url"]')?.getAttribute('content')
  if (!backstageUrl) {
    return;
  }

  const viewCount = document.querySelector("[data-view-count]");
  if (viewCount) {
    let count = '';
    try {
      const response = await fetch(`${backstageUrl}/counters/1`);
      const counter = await response.json();

      count = counter.count ?? 0;
    } catch (err) {
      console.log(err);
    }
    viewCount.innerHTML = count;
  }
})();
{{< /highlight >}}

Note that line 2 references the backstage URL that I added via the `head-additions.html` above.
Also note that line 7 references the container element in the `view_counter` shortcode defined above.

Next I added the script to the front page with an HTML `script` tag.
I wanted to add it as close to the bottom of the page as possible, and [the ananke theme's predefined `footer` block](https://github.com/theNewDynamic/gohugo-theme-ananke/blob/92ee7adbb8717c2788b047d9a94d4513ee75c02c/layouts/_default/baseof.html#L64) looks like the closest spot.
I overrode the block for just the front page by copying `layouts/index.html` to my project and defining my `footer` block:

```go
{{ define "footer" }}
{{ partials.IncludeCached "site-footer.html" . }}
{{ $script := resources.Get "js/custom.js" }}
{{ $script := $script | minify | fingerprint "sha256" }}
<script src="{{ $script.RelPermalink }}"></script>
{{ end }}
```

# Environment-based configuration

I wanted to specify a different backstage URL when I'm in development and when I'm in production.
To do this, I moved my single site configuration `hugo.toml` from the root directory up to `config/_default`.
Then I split out the `params` entries into their own `params.toml` file.
This allowed me to define an override for production environment.
The end result looks like this:

```
config
├── _default
│   ├── hugo.toml
│   └── params.toml
└── development
    └── params.toml
```

```toml
# params.toml
[backstage]
url = "https://backstage.atsui.click"
```

As you may have guessed, this value gets read in and substituted above where we have `{{ site.Params.backstage.url }}`.

# Conclusion

It's not really useful but I've always wanted one for my personal site, so there you have it.
It was also a good way to get my feet wet doing serverless backend stuff, and I learned a bunch.
Stay tuned for the writeup about the backend.
