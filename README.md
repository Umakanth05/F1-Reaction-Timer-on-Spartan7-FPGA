F1 Reaction Timer using Verilog on Spartan-7 FPGA

A hardware-based **F1 Style Reaction Timer Game** implemented using **Verilog HDL** on the **Boolean Digital Board (Spartan-7 FPGA)**.  
The project simulates the Formula-1 race starting sequence using LEDs and measures the user's reaction time using push buttons and a seven-segment display.

---
Project Overview

This project recreates the Formula-1 race light sequence:

1. LEDs turn ON one by one
2. After all 5 LEDs turn ON:
   - All LEDs turn OFF
   - All LEDs turn ON again briefly
3. LEDs turn OFF and the timer starts
4. User must press the STOP button as fast as possible
5. Reaction time is displayed on the 4-digit seven-segment display

If the STOP button is pressed early before the timer starts, the display shows:

9999

indicating a false start.

---
Features

- Finite State Machine (FSM) based design
- Sequential LED light control
- Reaction time measurement
- False start detection
- Seven-segment display interfacing
- FPGA hardware implementation
- Functional simulation using Vivado

---
Hardware Used

- Boolean Digital Board
- AMD/Xilinx Spartan-7 FPGA
- On-board LEDs
- Push Buttons
- 4-digit Seven Segment Display

---
Software Used

- Vivado Design Suite
- Verilog HDL
- Behavioral Simulation

---
Project Files

| File Name                 | Description |
| `f1_reaction_timer.sv`    | Top module implementing FSM and timer |
| `seven_segment_display.v` | Seven-segment display driver module |
| `f1_reaction_timer_tb.v`  | Testbench for simulation |
| `constraints.xdc`         | FPGA pin mapping constraints |
| `README.md`               | Project documentation |

---
FSM States

The project uses the following FSM states:

- `IDLE`
- `L1`
- `L2`
- `L3`
- `L4`
- `L5`
- `BLINK`
- `TIMING`
- `DONE`

---
Working Principle

1. Idle State
System waits for the START button press.

2. LED Sequence
Five LEDs glow sequentially like an F1 starting signal.

3. Blink State
After the fifth LED:
- LEDs OFF
- LEDs ON
- LEDs OFF again

4. Timer Start
Reaction timer begins counting.

5. User Reaction
When the STOP button is pressed:
- Timer stops
- Reaction time is displayed

6. False Start Detection
If STOP is pressed before timing starts:
- Display shows `9999`

---

Simulation

Behavioral simulation was performed in Vivado.

### Simulation Output

- LED sequence verified
- State transitions verified
- Timer operation verified
- Seven-segment display verified

---

FPGA Hardware Implementation

The design was successfully implemented on the Boolean Spartan-7 FPGA board.

Hardware Demonstration

- Sequential LED activation works correctly
- Timer starts after LED sequence
- Reaction time displayed on seven-segment display
- Push-button interaction verified

---

How to Run

Simulation

1. Open Vivado
2. Create a new project
3. Add:
   - `f1_reaction_timer.sv`
   - `seven_segment_display.v`
   - `f1_reaction_timer_tb.v`
4. Run Behavioral Simulation

FPGA Implementation

1. Add `.xdc` constraints file
2. Run:
   - Synthesis
   - Implementation
   - Generate Bitstream
3. Program the Spartan-7 FPGA board

---

Testbench Details

The testbench performs:

- Clock generation
- Reset initialization
- Start button simulation
- Stop button simulation
- Timing verification

Clock period used:

10 ns

---

Future Improvements

- Randomized start delay
- Faster display refresh
- UART result transmission
- High-score storage
- Sound/Buzzer integration
- Multi-player mode

---

Author

Developed by: **[Gwta Umakanth]**

Domain:
- FPGA Design
- Verilog HDL
- Digital System Design
- VLSI

---

License

This project is open-source and available for educational purposes.
