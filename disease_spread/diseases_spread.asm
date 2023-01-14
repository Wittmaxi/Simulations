;---------------------------------------;
; Simulate spread of disease            ;
;---------------------------------------;
; Compile with                          ;
;                                       ;
; uasm -win64 diseases_spread.asm       ;
; ld diseases_spread.o                  ;
;---------------------------------------;
;=======================================;
; Macros                                ;
;=======================================;
;---------------------------------------;
; @@@@@@@                               ;
; RawPrint                              ;
;---------------------------------------;
RawPrint MACRO ptr, len                 ;
    MOV rax, 4                          ;
    MOV rbx, 1                          ;
    MOV rcx, ptr                        ;
    MOV rdx, len                        ;
    INT 80H                             ;
ENDM                                    ;
;---------------------------------------;
BSS SEGMENT                             ;
    prevGenHealthy DD 0.9               ;
    curGenHealthy DD 0.4                ;
    iteration DB 0                      ;
    coeff DD 1                          ;
    percentConvert DD 100               ;
    percentBuff DD ?                    ;
BSS ENDS                                ;
                                        ;
;---------------------------------------;
DATA SEGMENT                            ;
    ;- control sequences for changing the colors of graphs
    newL DB 0AH                         ;
    newLLen EQU 1                       ;
    ;
    greenText DB 1BH, "[32;1m"       ;
    greenTextLen EQU $ - greenText      ;
    ;                                   ;
    redText DB 1BH, "[31;1m"         ;
    redtextLen EQU $ - redText          ;
    ;                                   ;
    blockChar DB 023H                   ;
    blockCharLen EQU 1                  ;
    ;- Different texts to print out     ;
    greeter DB "Simulate the spread of a disease - Displayed in a graphical format", 0AH, "2023, Maximilian Wittmer", 0AH
    greeterLen EQU $ - greeter          ;
DATA ENDS                               ;
                                        ;
;---------------------------------------;
TEXT SEGMENT                            ;
;---------------------------------------;
; _start                                ;
;---------------------------------------;
PUBLIC _start                           ;
_start PROC                             ;
    ;- prints the greeter               ;
    RawPrint OFFSET greenText, greenTextLen
    RawPrint OFFSET greeter, greeterLen ;
    RawPrint OFFSET redTExt, redTextLen ;
    RawPrint OFFSET newL, newLLen       ;
    RawPrint OFFSET newL, newLLen       ;
    RawPrint OFFSET newL, newLLen       ;

    XOR rcx, rcx                        ;
    MOV ecx, DWORD PTR [prevGenHealthy] ;
    PUSH rcx                            ;
    CALL printGraph
    ;- init                             ;
    ;- exit execution                   ;
    ;-- Print newline                   ;
    RawPrint OFFSET newL, newLLen       ;
    ;-- syscal exit                     ;
    MOV rax, 1                          ;
    XOR rbx, rbx                        ;
    INT 80H                             ;
_start ENDP                             ;
                                        ;
                                        ;
;---------------------------------------;
; calcGen                               ;
;---------------------------------------;
calcGen PROC                            ;

calcGen ENDP                            ;
                                        ;
;---------------------------------------;
; Print graph                           ;
;---------------------------------------;
; RBP + 16 (DWORD) = percentage healthy ;
;---------------------------------------;
printGraph PROC                         ;
    ENTER 0, 0                          ; TODO: move percentBuff into the stackframe
    ;- convert percentages to real number
    FLD DWORD PTR [RBP + 16]            ;
    FILD DWORD PTR [percentConvert]     ;
    FMUL st(0), st(1)                   ; multiply the percentage with 100
    FIST DWORD PTR [percentBuff]        ;
    ;- print the healthy patients first ;
    ;-- Select Color                    ;
    RawPrint OFFSET greenText, greenTextLen
    ;-- Print the blocks
    XOR rcx, rcx                        ;
    MOV ecx, DWORD PTR [percentBuff]    ;
    PUSH rcx                            ;
    CALL printBlocks                    ;
    ;- Now unhealthy patients           ;
    ;-- Select color                    ;
    RawPrint OFFSET redText, redTextLen ;
    ;-- Calculate amount                ;
    XOR rcx, rcx                        ;
    MOV cx, 100                         ;
    MOV eax, DWORD PTR [percentBuff]    ;
    SUB cx, ax                          ;
    ;-- print out                       ;
    PUSH rcx                            ;
    CALL printBlocks                    ;
    ;-                                  ;
    LEAVE                               ;
    RET                                 ;
printGraph ENDP                         ;
                                        ;
;---------------------------------------;
; printBlocks                           ;
;---------------------------------------;
; RSP + 16 (WORD) = amount of blocks    ;
;---------------------------------------;
printBlocks PROC                        ;
    ENTER 0, 0                          ;
    MOV rcx, QWORD PTR [RBP + 16]       ;
    ;- if zero, skip                    ; LOOP with rcx = 0 will underflow and loop a ton of times
    OR rcx, rcx                         ;
    JZ @@x                              ;
    ;- Loop as many times as required and print
@@loop:                                 ;
    PUSH rcx                            ;
    RawPrint OFFSET blockChar, blockCharLen; invalidates RCX
    POP rcx                             ;
    LOOP @@loop                         ;
@@x:                                    ;
    LEAVE                               ;
    RET                                 ;
printBlocks ENDP                        ;


                                        ;
;---------------------------------------;
TEXT ENDS                               ;
END                                     ;
