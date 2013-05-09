
ATM Simulator
================================

This is an exercise in BDD and SOLID app development. The project is a simulation of an ATM machine to run on an iPad.

An outline of the ATM requirement and suggested OOD is here: http://www.math-cs.gordon.edu/courses/cs211/ATMExample/

I'm not intending to strictly follow that, its more an exercise for me to see how to use good OOP techniques to build a simple but slightly less than trivial app.

About the Development
--------------------------

The purpose of this exercise is to learn more about applying BDD and SOLID principles to the development of a project.

So that you can follow along, I'm making a point of committing changes at a very high level of detail - effectively after every red, green and refactor step of the process.  When I want to try out new concepts without messing up the master branch, I break out another branch, and will merge the result back into master if the experiment works out.

This approach hopefully will document the thought processes along the way, but I'll also be adding to the story below as I see fit.  If you look at the commit history, you'll be able to see the nitty gritty.


Some Background
--------------------

I'm far from a competent iOS developer.  I'm still working my way towards getting my first app into the AppStore.  I did write a comic book app for a friend a couple of years ago, but is was a hedge development in case his main developer, who was being unreliable, failed to come up with the goods.  Just as I completed the app, so did the other developer, and as they had been a profit sharing agreement, they went with the other codebase.  No biggie for me.

That was in the days of XCode 3 and iOS 4 I think, pre-ARC and Storyboarding.  So coming back to iOS development again had quite a few areas to investigate, and I had never really mastered much with that earlier project.  Also, I wanted to try and put some other development principles into practice, as past experiments just led to some of the smelliest code imaginable, which I wanted to avoid for my own project.

I've done a couple of other experiments (check out my Github profile) but they were mainly logic exercises with TDD/BDD, and so I chose this exercise because I could put a real user interface on it and target an iOS device.

The Story So Far
==================

I made a good start in terms of building the business logic, but realised I had my head in the wrong place.  The first major refactoring was to stop thinking about building 'an ATM machine' and to think more in terms of the controller logic and the peripherals which it connected to.  Here is the point where [I threw everything away to start over](https://github.com/dmeehan1968/ATMSimulator/commit/a5cda1d76fedb27f6c9225464f4bc48d63f5cd37)

Getting Perspective
-------------------

Realising that the entire project was the 'ATM' and that the part I was starting with was the controller logic was a good mental shift, and it was interesting to see how BDD style development led me to that discovery.  In some of the past exercises, I had failed to refactor big enough and early enough to not end up with major wasted effort, and so I was happy to discard the first few hours progress for the sake of clarity.

BDD was also leading me down the line of loose coupling, which was just what I felt was needed.  But of course there are many ways to make dependencies between your objects, and trying to decide whether delegation, notification or key-value-observing was going to be right was hard.  None of the tutorials I could find online or in books really had much to say on these area, other than 'it depends'.  So really it was a case of needing to experiment.

Delegation was the obvious one because Apple use it so heavily themselves.  This was fine, but the project quickly started to look like a [disjointed minefield](https://github.com/dmeehan1968/ATMSimulator/commit/478abf5004b285e9d8ddbe33a2b984a94179f002).

I decided to branch at this point to experiment with bindings.  Lots I read about KVO suggested it was not a good way to go, but the loose coupling looked like it would help with the design.  The obvious requirement in the view controller was for some way of binding model to ui control, but its something lacking from iOS, and even seems to be not great on OSX.  But I made a 'bindings' branch to see if I could roll my own, and got into a horrible mess.  

Simplify and Reuse
-------------------

In the end I had to look for outside help, and found [MAKVONotificationCenter](https://github.com/mikeash/MAKVONotificationCenter) as a solution.  It's also handily available as a Cocoapod so [very easy to integrate into the project](https://github.com/dmeehan1968/ATMSimulator/blob/c9bea0da667154a85fcea84e74e2fea6a6dd106f/Podfile).

This indeed sorted out a lot of the mess, seemingly solving the problems of removing observers before objects get deallocated and KVO starts throwing warnings all over the Xcode console.  This allowed me to vastly simplify the code, removing all of the delegate logic and even suggesting that ATMConsole and ATMOperatorSwitch, the only dependencies to ATMController so far, might not even need to be objects in their own right, as they just contain properties.

The second part of binding was to link UI events to the model.  Whilst in theory this would be easy, again Apple's target/action implementation is just a mess.  Turning again to blocks as a solution, rather than trying to implement my own solution, I found [MTControl](https://github.com/mysterioustrousers/MTControl) which is also available as a Cocoapod.  This was nice and easy to implement, and whilst looking at the code suggests that it both KVO and event handling can be wrapped into some sort of adapter class, it led to a much cleaner codebase.