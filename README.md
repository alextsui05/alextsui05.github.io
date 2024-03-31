This is the website hosted at https://alextsui05.github.io.
The files under `docs/` are served as the website, and everything else is behind the scenes.
See [here](https://docs.github.com/en/pages/getting-started-with-github-pages/creating-a-github-pages-site) for details on how to set up a Github page for yourself.

# Development

For development, I serve the files locally, make edits, inpect them in the browser, and repeat:

```sh
cd docs/
python3 -m http.server 3000
```

This project uses [Tailwind](https://tailwindcss.com/docs/installation), so I have it running while editing the webpage:

```sh
npx tailwindcss -i docs/input.css -o docs/output.css --watch
```
