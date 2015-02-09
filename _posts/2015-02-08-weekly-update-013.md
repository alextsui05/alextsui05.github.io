---
title: Weekly Update 13 - Going on hiatus
category: 'Weekly Update'
---

I just cleaned up and pushed the VimAddin custom keybindings, with <code>Control+B</code> for page up and <code>Control+F</code> for page down. By default, this will conflict with some preset IDE shortcuts and hence do nothing, but going into <code>Preferences > Key Bindings</code> will signal you to address these conflicts. It should be safe to unbind the default actions for Control+F (which you can replace with VimAddin's find command: /) and Control+B (which you can replace with VimAddin's match brace command: %).

In other news, I've got a chance to refresh my ties with CGAL. Waqar and Efi have finished their work on polycurve arrangements. This generalizes CGAL's existing polyline arrangement, whose curve is a list of line segments joined end-to-end. Now you can have a list of arbitrary curve type (Bezier, algebraic, unbounded linear segments, for example). I need to pick up work on the demo again, which suffers from long compilation time as is and still hasn't been integrated. Also with CGAL, coincidentally, a [fellow UCD student](https://github.com/acgetchell) contacted me about contributing to CGAL. His [application](http://collaborate.mozillascience.org/projects/quantumGravity) requires some unsupported Pachner moves in the 3D Triangulation package. It's cool to get a chance to keep involved and I hope more people do now that CGAL is moving to more open development workflows on Github in the coming months.

With that, I'm going on hiatus for the next month. I will need to focus on my school project until the upcoming deadline at the beginning of March. Wish me luck, and see you back online next month.
