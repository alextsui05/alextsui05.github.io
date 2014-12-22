---
title: Weekly Update 7
---
This week, I finally submitted a paper for my research that had been keeping me occupied for the past several weeks. 
As promised, I was able to put in a few hours to committing a new options panel for [VimAddin](http://github.com/alextsui05/VimAddin).
Now when you go into the Preferences window, you'll be able to find this under Text Editor:

<a class="image-link" href="public/img/vim-addin-preferences-panel.png"><img src="public/img/vim-addin-preferences-panel.png"></a>

Right now, you still have to activate VimAddin in the same clunky way: install the addin, check this checkbox, and restart Monodevelop.
I hope to figure this out next week so that when you uncheck the box above, it will switch you back to basic input mode.

Now that I have a UI set up, now I have to go through and pull out the Vim-specific keychords and make them customizable through a table widget, sort of like how [VsVim](https://github.com/jaredpar/VsVim) handles IDE/plugin shortcuts.
I can't wait to have `Ctrl+F` map to page down once again!
