;====================================================
; 8051 Object / Button Counter
; Displays count on two 7-segment displays
; Units  -> Port 2
; Tens   -> Port 1
; Input  -> P3.4 (Active LOW)
;====================================================

ORG 0000H              ; Program starts at memory address 0000H

COUNTL EQU 30H         ; Define COUNTL as memory location 30H (units digit)
COUNTH EQU 31H         ; Define COUNTH as memory location 31H (tens digit)
TEMP   EQU 32H         ; Define TEMP as memory location 32H (unused variable)

;----------------------------------------------------
; MAIN PROGRAM
;----------------------------------------------------
MAIN:
    MOV P2, #00H       ; Clear Port 2 (used for displaying units digit)
    MOV P1, #00H       ; Clear Port 1 (used for displaying tens digit)
    MOV P3, #0FFH      ; Configure Port 3 as input (switches connected here)
    MOV COUNTL, #00H   ; Initialize units count = 0
    MOV COUNTH, #00H   ; Initialize tens count = 0

;----------------------------------------------------
; WAIT FOR BUTTON PRESS
;----------------------------------------------------
START:
    JB P3.4, START     ; Wait until button (P3.4) is pressed (active low)
    ACALL INCREMENT    ; Call subroutine to increment counter

WAIT_RELEASE:
    JNB P3.4, WAIT_RELEASE ; Wait for button release (avoid multiple counts)
    SJMP START         ; Jump back to start and wait for next press

;----------------------------------------------------
; INCREMENT SUBROUTINE
;----------------------------------------------------
INCREMENT:
    MOV A, COUNTL      ; Load accumulator with units count
    INC A              ; Increment units digit

    ACALL D            ; Call delay subroutine (debouncing)
    ACALL D            ; Additional delay for stable display

    CJNE A, #0AH, STOREL ; Compare A with 10, if not equal, go to STOREL
    MOV A, #00H        ; If units reached 10, reset to 0
    MOV COUNTL, A      ; Store 0 in COUNTL

    MOV A, COUNTH      ; Load accumulator with tens digit
    INC A              ; Increment tens digit

    ACALL D            ; Delay
    ACALL D            ; Delay

    CJNE A, #0AH, STORET ; Compare with 10, if not equal, store it
    MOV A, #00H        ; If tens reached 10, reset to 0

STORET:
    MOV COUNTH, A      ; Store new tens digit
    SJMP DISP          ; Jump to display routine

STOREL:
    MOV COUNTL, A      ; Store new units digit

;----------------------------------------------------
; DISPLAY ROUTINE
;----------------------------------------------------
DISP:
    ; Display units on Port 2
    MOV A, COUNTL      ; Load units count
    MOV DPTR, #SEGTAB  ; Load address of seven-segment table
    MOVC A, @A+DPTR    ; Fetch corresponding 7-seg code
    MOV P2, A          ; Output to Port 2

    ; Display tens on Port 1
    MOV A, COUNTH      ; Load tens count
    MOV DPTR, #SEGTAB  ; Load address of seven-segment table
    MOVC A, @A+DPTR    ; Fetch corresponding 7-seg code
    MOV P1, A          ; Output to Port 1

    RET                ; Return from subroutine

;----------------------------------------------------
; DELAY SUBROUTINE
;----------------------------------------------------
D:
    MOV R1, #200       ; Outer loop count

D1:
    MOV R2, #255       ; Inner loop count

D2:
    DJNZ R2, D2        ; Inner delay loop
    DJNZ R1, D1        ; Outer delay loop
    RET                ; Return from delay subroutine

;----------------------------------------------------
; SEVEN SEGMENT LOOKUP TABLE (Common Cathode)
;----------------------------------------------------
SEGTAB:
    DB 0C0H            ; 0 → Display pattern for ‘0’
    DB 0F9H            ; 1 → Display pattern for ‘1’
    DB 0A4H            ; 2 → Display pattern for ‘2’
    DB 0B0H            ; 3 → Display pattern for ‘3’
    DB 099H            ; 4 → Display pattern for ‘4’
    DB 092H            ; 5 → Display pattern for ‘5’
    DB 082H            ; 6 → Display pattern for ‘6’
    DB 0F8H            ; 7 → Display pattern for ‘7’
    DB 080H            ; 8 → Display pattern for ‘8’
    DB 090H            ; 9 → Display pattern for ‘9’

END                   ; End of program

