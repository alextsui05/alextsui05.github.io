---
title: Weekly Update 9
category: 'Weekly Update'
---
Made a baby step with VimAddin. Basically, the issue I discovered a few months back that prevented you from effectively scrolling down in VimAddin had to do with conflicting keybindings.

![Bad keybindings](public/img/md-debugger-keybindings.png)

To perform these debugger actions, the user would hit Control+D first, followed by the second key. This broke the only way VimAddin had to scroll down and made it impossible for me to use.

Now that I know this, the workaround is to unbind/rebind the conflicting key bindings using Control+D or Control+F.

The solution moving forward is to split out the actions into actual extension points provided by the addin. I'm not sure how this is going to look exactly or how I have to refactor, since right now, VimAddin reads keyboard input and does things automatically. I plan to read over the Monodevelop addin tutorial to remind myself of how to go about creating a command, because I think that seems to be the minimum unit of functionality that you can bind with key bindings.

The latest checkin 1.1.10 introduces no new functionality but just reads the version info from the assembly and puts it in the preferences panel. I just wanted to bump to let people know the project has a pulse. Look forward to the next commit being a fix to the above-mentioned issue.
