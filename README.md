# MATLAB Autonomous Navigation Robot

## Overview
This project is a MATLAB-controlled autonomous robot system designed to navigate a room using sensor data and servo-based scanning.

Our team was responsible for building the robot from scratch, including assembling the chassis, wiring components, and integrating all hardware before developing the control logic.

## Project Objective
The robot started in the center of a circular enclosure and completed two tasks:

1. Scan the room to locate a cylinder and drive into it
2. Return to center, detect a doorway using two light sources, and exit

## My Role
I developed the MATLAB control logic for the servo scanning system and sensor processing.

- Programmed a servo to scan 180 degrees at a controlled speed
- Collected and processed distance sensor readings
- Identified objects by detecting low-distance values
- Calculated angle and distance of detected targets
- Passed directional data to the robot for movement decisions

For navigation to the exit:
- Captured light sensor readings during scanning
- Detected two light sources indicating the closed doorway
- Calculated direction and guided the robot toward the exit

## System Design
- MATLAB used as the primary control and processing environment
- Arduino used as the hardware interface for sensors and movement
- Servo head used for scanning and data collection
- Sensors used for distance and light detection

## Included Files
- matlab/ServoScan.m
- matlab/ServoChallenge.mlx
- matlab/LightSensor.m
- matlab/LightSensorScan.mlx
- matlab/DriveDistance.m
- matlab/blinkingLED.m
- matlab/buzzerFile.m
- matlab/raw_sensor.txt

## Note
This repository focuses on the MATLAB control and sensor-processing side of the project. Arduino was used as the interface layer, but firmware development was not part of my role.
