VIDEO FOR PROJECT:
https://www.youtube.com/watch?v=8NZ00qE1aU4

I – The Basics
This project was based off the CS50 2020 Pong Track and uses some of the code in the project.  My game is like the original Pong, but it does contain a couple new features intended to make it harder for the player to win

II – New Features
The first new feature is that of a simple AI for Player 2.  The AI controlling the paddle on the right is not impossible to beat, but it is very hard.  The only way to beat the AI is to get lucky with the angle and speed of the ball.  I made the paddle speed for the AI slower than that of the player which means that if the player gets lucky with the speed and angle of the ball, they will score as it will be physically impossible for the paddle to get to the ball in time.  

The second new feature is a “multiplier” on the AI controlled paddle.  Every time the computer scores, the size of the computer’s paddle increases by 12 pixels.  While that does not sound like a lot, by the time the score gets to 3 or 4 (in favor of the computer), the computer’s paddle is quite large.

The third new feature is varying speed for the ball.  For each new round, the speed and angle of the ball is randomized.  That means that sometimes the ball will move very slowly and other times it will move very fast.  The faster the ball, the better the chance the player has of scoring against the computer, as explained above.

The final new feature is “holes” in the player’s paddle.  Instead of being one 60-pixel long paddle, the player’s paddle is 4 15-pixel paddles attached to each other that act as one large object.  The game exploits a glitch in the collision code where if the ball hits a barrier between two of the paddles, the ball will go through the paddle.  On the other hand, if ball hits the center of one of the four paddles, it will deflect the ball as normal.  This feature makes it harder for the player to win because even if they line the paddle up with the ball, there is still a chance they will lose anyway.  But someone who is clever enough can get around this if they are able to estimate where the paddle is divided into four sub paddles.

III -- Issues/Struggles
While I had small issues that were resolved very quickly, one problem that persisted throughout the project was collision.  In my opinion, which could be completely wrong, the collision in Love/Lua is not very good.  One problem I had was when the ball would hit the corner of the paddle.  When the ball hit the corner of the paddle, it would go through the paddle anyway despite the two colliding.  I spent a lot of time trying to fix this, but in the end I could not – so it is one glitch with the game.  I also had a problem with the collision on the upper and lower borders of the screen. ~10% of the time when the ball hit the top or bottom of the screen, instead of deflecting, the ball would attach itself to the top of the screen and slide along the top/bottom of the screen (its y coordinate staying constant).  It would slide until the ball went through a paddle (it would not collide with the paddle even if it was there).  Other than that, I had no real struggles with this project and any issues that came up were mostly due to spelling errors.

Learning Lua was a unique part of this project and while having base knowledge of computer science concepts helped, learning the syntax of Lua was tough.  It was a little bit of learning curve but by the time I finished the CS50 videos, I felt comfortable coding in Lua and Love.
