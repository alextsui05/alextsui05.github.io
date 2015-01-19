---
title: Weekly Update 10
category: 'Weekly Update'
---

In short, I spend this weekend learning more about the hype that is [neovim](https://neovim.org).

## Considering neovim

I first heard it posted on Xamarin forums a week or two ago. As far as I understand it, it's a massive overhaul of vim to make it more modular and extensible with any programming language. I think two big goals for doing this is:

1. Make it easy to contribute to.  There was an interview last November with Bram Moolenaar where he jokes that the way to ensure future success of the Vim project is to [keep him alive](http://www.binpress.com/blog/2014/11/19/vim-creator-bram-moolenaar-interview/). I laughed, but I guess it's partly true.
2. Make it easy to embed in other editors. Since it runs headless and receives input remotely, the interface can be anything from traditional curses to your favorite editor or IDE. Just a few days ago, there was a video showing [neovim embedded in the Atom editor](https://www.youtube.com/watch?v=yluIxQRjUCk). Also, trolling the neovim Google group, there's neovim support for Floobits, one of those collaborative code editing services, so you can collaborate from the comfort of your terminal while people can chime in from their own instance of neovim or the web.

<a class="image-link" href="{{site.baseurl}}/public/img/floobits.png"><img src="{{site.baseurl}}/public/img/floobits.png" /></a>

Well, let's not get carried away, though. It's not like we can suddenly do this.

<img src="{{site.baseurl}}/public/img/ncis.gif" />

I think it would be great to just embed vim in MonoDevelop rather than emulate it. I will have to check out the [proof of concept](https://github.com/carlosdcastillo/vim-mode), which has been in the works for 11 months now. And neovim's website states it is pre-alpha, with features still missing. Neocomplete, for example, doesn't work because Lua support is still coming. In spite of the long road ahead, I can only conclude by stating the emotion I am filled with at the moment: [Excitement](https://github.com/Shougo/deoplete.nvim/issues/1)!

## Gedit python plugin

Another detour that I took is fiddle with making a gedit plugin. The [plugin tutorial](https://wiki.gnome.org/Apps/Gedit/PythonPluginHowTo) is written for gedit 3, but it didn't mention that it requires python 3 to be used as the loader. Anyways, I got it working and I think I can hack jedi in without too much trouble. More on this later.
