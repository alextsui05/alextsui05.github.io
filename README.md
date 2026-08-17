Hugo project for my personal blog

# Requirements

- Git
- [Hugo 0.165.0](https://github.com/gohugoio/hugo/releases/tag/v0.165.0)
- Go 1.24

# Quickstart

```
# run the site locally at localhost:1313
hugo server

# deploy main branch to github pages; see .github/workflows/hugo.yaml
git push origin main
```

# Memos

## How to upgrade `hugo`

I use the Hugo extended prebuilt binaries from the [Github releases](https://github.com/gohugoio/hugo/releases) page. 
It's self-contained so just replace your binary with the latest version and you're good to go.

## How to update theme

I'm using the [ananke](https://github.com/gohugo-ananke/ananke/wiki/Installation-as-GoHugo-Module) theme installed as a hugo module.
The following commands should pull the latest vesrion:

```
hugo mod get -u ./...
hugo mod tidy
```
