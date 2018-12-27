# Advanced Lane Keeping Assist

## Description
This project is for my Advanced Driver Assistance Systems assignment. The requirements of this assignment are to design, implement and simulate an ADAS solution using Matlab and Simulink.

The feature of an autonomous car that I have chosen to design in this project is Advanced Lane Keeping Assist. This feature will be used on roads without road markings to help with positioning of the vehicle on the road by calculating where the road markings should be, thereby creating a lane in which the car should remain. 

## Design
This feature takes data from external sensors such as cameras to analyse the road ahead. This data is combined with data from the cloud which indicates the type of road that the car is on, for example if the car is on a one-way road it does not need to calculate the position of two lanes as there will be no on-coming cars. In the event that the car moves onto a road where there is road markings visible, this system will turn off and another lane keeping assist algorithm can take over.
<img src= "images/Design-Diagram.JPG"/>
*Figure 1: Design Diagram*

## Implementation
This project was implemented using Matlab and Simulink. The main algorithm used in the Matlab section of the project was the Hough transform.

A plant model of a car was used in Simulink to simulate the communication between the Matlab algorithm and the steering control.

This feature detects the edge of the road and measures the distance between each edge. This distance is then divided by 2 and a line is drawn along the center-line of the road creating two lanes. Map data is used to make a decision on which lane the car should drive in as well as confirming the type of road, i.e. a one-way road. Messages are then sent to the steering ECU to keep the car within the calculated lane.

