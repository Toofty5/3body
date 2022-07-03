# 3 Body Simulation for Playdate

![3 Body Simulation](animation.gif)

This is a 3-body simulation for the [Playdate](https://play.date) portable device console.  Currently, there is a lot of cheating in terms of the math, which came from [Wikipedia](https://en.wikipedia.org/wiki/Three-body_problem).

The most glaring issue is what to do when the points are very close to each other.  The acceleration of each point is dependent on the inverse-cube of the distance to the other points, and when they're close, you get closer to dividing by zero.

The effect was that one of the points would get launched off to the side.  As a stopgap, I've put a cap on the acceleration the system can put on any given point.  I imagine there's a more practical way of doing this but for now I'm just glad it works.

