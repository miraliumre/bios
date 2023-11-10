[BITS 16]
[ORG 0x7C00]

%define FREQUENCY 3000

; Duration in milliseconds
%define duration_ms_cx(t) ((( (t)*1000 ) >> 16) & 0xFFFF)
%define duration_ms_dx(t) (((t)*1000)&0xFFFF)

; ---------------------------------------------------------------------
;                           MAIN PROGRAM CODE
; ---------------------------------------------------------------------

cli                            ; Disable interrupts for exclusive control

mov al, 0xB6                   ; Prepare control word for the speaker
out 0x43, al                   ; Send control word to Timer Control Port

mov ax, FREQUENCY              ; High-byte of frequency to Channel 2
out 0x42, al                   ; Send high-byte to Channel 2 Data Port
mov al, ah                     ; Low-byte of frequency to Channel 2
out 0x42, al                   ; Send low-byte to Channel 2 Data Port

in al, 0x61                    ; Read port 0x61 state into AL
or al, 0x03                    ; Modify AL to activate the speaker
out 0x61, al                   ; Output AL to turn on the speaker

mov ax, 0x8600                 ; BIOS delay function
mov cx, duration_ms_cx(1000)   ; High word of the delay time
mov dx, duration_ms_dx(1000)   ; Low word of the delay time
int 0x15                       ; Invoke BIOS interrupt

in al, 0x61                    ; Read port 0x61 state into AL again
and al, 0xFC                   ; Modify AL to deactivate the speaker
out 0x61, al                   ; Output AL to turn off the speaker

jmp $                          ; Infinite loop to halt further execution

; ---------------------------------------------------------------------
;                                 DATA
; ---------------------------------------------------------------------

times 510-($-$$) db 0          ; Fill boot sector with zeros up to 510 bytes
dw 0xAA55                      ; End-of-sector boot signature
