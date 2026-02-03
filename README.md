IR Object Counter using 8051 Microcontroller (2-Digit Display)

A microcontroller-based IR sensor object counter using multiplexed 7-segment displays.

🔍 Overview

This project implements a real-time object/people counter using the AT89S52 (8051) microcontroller. An IR sensor detects beam interruption and the system increments the count from 00 to 99, displayed using two multiplexed common-anode 7-segment displays.





.

🎯 Aim & Design Specification


Implement an IR-based object counter using 8051

Detect beam breaks reliably and debounce input

Display count on 7-segment display

Applications: library, industry, conveyor belt systems, entry/exit counting

⚙️ Hardware Used

(From pages 9–10 of your report)

AT89C51 / AT89S52 MCU

IR LED + Photodiode/IR sensor module

Two 7-Segment CA displays

330Ω resistors

12 MHz Crystal

5V Regulated Supply (LM7805)

Switches / Push buttons

Breadboard + Jumper wires

🧩 Working Principle


Initialize MCU, ports and display

Read IR sensor (Active-LOW)

Debounce input

Increment count

Convert count to TENS & ONES (00–99)

Multiplex both 7-segment displays

Show stable count continuously

🔌 Connection Summary
Inputs
Component	Pin	Function
IR Sensor	P3.4	Active LOW detection
Outputs
Component	Pin	Function
Ones Display	P2.1	Digit enable
Tens Display	P2.0	Digit enable
Segments a–g,dp	P1.0–P1.7	Shared segment lines



🧠 Software Implementation (Assembly)

Place your final corrected code inside src/counter.asm.
(You already have this prepared.)

📸 Project Images

Add images from page 12 of the PDF to the /circuit/ folder. 

mpmcproject[1][1] (1)

🚀 Future Enhancements

Up/Down counter

Programmable limits

EEPROM storage

Interrupt-based design

3-digit expansion
