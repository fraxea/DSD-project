# DSD Project

In this project, we implement elevator in verilog and test its performance on a senario.

![elevator_image](https://dazenelevator.com/wp-content/uploads/2023/03/double-deck-elevator-china.jpg)

## 1- Implementation

We implemented an elevator for a house with four floors and one lobby, so there are 5 different states for our elevator.

### 1.1- Inputs and outputs

- `in_btn`: There are 5 buttons, one button for each floor to request the elevator.
- `out_btn`: Inside the elevator there are 5 buttons, one for each floor to request exitting the elevator.
- `in_snsr`/`out_snsr`: For each floor, there is an input sensor, and an output sensor. When both sensors are active, the elevator will stop on that floor.
- There is a signal for the movement direction of the elevator and a signal for the motor. We named them `direction`(0=down/1=up) and `motor`(0=off/1=on), respectively. Note that when motor is off, the value of direction is not important.

### 1.2- Details

We set the time for stopping in a floor, $1000$, pressing a button $30$, and moving one floor $100$. We handled stopping the elevator when reaching the final floor (first or last).

## Senario

We test our module by introducing a challenging senario:

### Level 0: Reseting the elevator

### Level 1: out button 3 pressed

### Level 2: pass one floor

### Level 3: out button 4 pressed

### Level 4: reach floor 3

### Level 5: in button 0 (lobby) pressed

### Level 6: reach floor 4

### Level 7: Go down

### Level 8: in button 1 pressed

### Level 9: reach floor 1

### Level 10: reach lobby

### Author

[Mohammad Shafizadeh](https://github.com/fraxea) (401 110 386)
