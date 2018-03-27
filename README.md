# RDK Sim

Simple Matlab model for 2 wheeled bot with laser scanner.

User guide:
- run `Obstacle_generator` script
- place some obstacles and trajectory point
- press `I'm finished`
- run `RDK_Sim(obstacles,false,trajPoints)`
- ...
- profit

UI

In RDK_Sim there is 4 graphs
- bottom left: obstacles and bot riding around them
- bottom right: laser scanner model
- top left: obstacles found using laser scanner and bot data (heading and coordinates)
- top right: current target and last potential collision
