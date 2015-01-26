---
title: Weekly Update 11 - VimAddin custom keybindings progress
category: 'Weekly Update'
---

Any Command that you add can be rebound by the user through Preferences > Key Bindings. I register a command for page down as follows:

{% highlight xml %}
<Extension path="/MonoDevelop/Ide/Commands">
    <Category _name="VimAddin" id="VimAddin">
        <Command id="VimAddin.VimAddinCommands.PageDown"
            _label="Page Down"
            _description="Page down in the text editor"
            shortcut="Control|F"
            defaultHandler="VimAddin.NullHandler" />
    </Category>
</Extension>
{% endhighlight %}

This creates a categorized command as follows:

{% popup_image public/img/vimaddin-keybindings.png %}

The nice thing is once this is set up, the user will be able to see at a glance if there are any conflicting key bindings.

With this setup, the <kbd>Control+F</kbd> will trigger the handler, but the key event stops there; however, it needs to continue to the VimAddin edit mode so that it executes the page down action. I'm trying to programmatically send the <kbd>Control+F</kbd> but it results in an odd null pointer exception:

~~~~~
Error while executing command: Page Down
System.NullReferenceException: Object reference not set to an instance of an object
  at VimAddin.ViEditMode.CheckVisualMode () [0x00000] in <filename unknown>:0 
  at VimAddin.ViEditMode.HandleKeypress (Key key, UInt32 unicodeKey, ModifierType modifier) [0x00000] in <filename unknown>:0 
  at VimAddin.IdeViMode.HandleKeypress (Key key, UInt32 unicodeKey, ModifierType modifier) [0x00000] in <filename unknown>:0 
  at VimAddin.IdeViMode.SendKeys (Key key, UInt32 unicodeKey, ModifierType modifier) [0x00000] in <filename unknown>:0 
  at VimAddin.NullHandler.Run () [0x00000] in <filename unknown>:0 
  at MonoDevelop.Components.Commands.CommandHandler.Run (System.Object dataItem) [0x00002] in ../monodevelop/main/src/core/MonoDevelop.Ide/MonoDevelop.Components.Commands/CommandHandler.cs:61 
  at MonoDevelop.Components.Commands.CommandHandler.InternalRun (System.Object dataItem) [0x00003] in ../monodevelop/main/src/core/MonoDevelop.Ide/MonoDevelop.Components.Commands/CommandHandler.cs:42 
  at MonoDevelop.Components.Commands.CommandManager.DefaultDispatchCommand (MonoDevelop.Components.Commands.ActionCommand cmd, MonoDevelop.Components.Commands.CommandInfo info, System.Object dataItem, System.Object target, CommandSource source) [0x00085] in ../monodevelop/main/src/core/MonoDevelop.Ide/MonoDevelop.Components.Commands/CommandManager.cs:1151 
  at MonoDevelop.Components.Commands.CommandManager.DispatchCommand (System.Object commandId, System.Object dataItem, System.Object initialTarget, CommandSource source) [0x002fc] in ../monodevelop/main/src/core/MonoDevelop.Ide/MonoDevelop.Components.Commands/CommandManager.cs:1118
~~~~~

I have a feeling it's something simple and [have already asked](https://forums.xamarin.com/discussion/comment/99253#Comment_99253) about it on the Xamarin forums. Once I get it, I'll go ahead and make key bindings for the other <kbd>Control</kbd> actions.
