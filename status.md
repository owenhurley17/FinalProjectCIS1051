# Status Report

#### Your name

Owen Hurley

#### Your section leader's name

Owen Hurley

#### Project title

Pong Enchanced

***

Short answers for the below questions suffice. If you want to alter your plan for your project (and obtain approval for the same), be sure to email your section leader directly!

#### What have you done for your project so far?

So far, I have completed watching the CS50 Pong videos that gave me a solid introduction to Lua and Love.  I started making my own Pong from scratch as I found it easier to just create my own solution insetad of modifying the CS50 code.  I have implemented a functioning main menu, a basic AI for the computer that does not allow the player to win, but I do not make it too obvious.  I may change it to allow the player to win eventually as it seems the odds may be stacked against the player too much.  I have also implemented a process for having the computer's paddle grow after every time it scores on the player by ~50 pixels.  

#### What have you not done for your project yet?

I still have to implement having a portion of the player's paddle not be a solid object (allowing the ball to pass through despite the paddle being present).  I do not anticipate this to be difficult however because I already have the plan to implement this.  Essentially, at the start of the game a random section (of the four that make up the paddle) will be selected and once the computer (or player) scores, a rando number between one and four will be selected.  The number selected will match the section of the paddle and thus that section will now have no collision.

#### What problems, if any, have you encountered?

I am having a problem with collision detection between the balls and the paddles.  Currently, collision works ~75% of the time.  Sometimes the ball will bounce back and forth a couple times then for no reason, it will go straight through.  My theory is that this occurs when the ball hits the barrier between two sections of the paddle.  The paddle is essentially 4 independent objects that move together to create the illusion of one larger paddle.  My theory is that the paddle collision code used in CS50 was not built for having multiple paddles and thus glitches out when the ball hit the barrier between two sections of the paddle.  I will most likely have to deisgn my own code for collision to fix this.
