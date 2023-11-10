[BITS 16]
[ORG 0x7C00]

; ---------------------------------------------------------------------
;                           MAIN PROGRAM CODE                          
; ---------------------------------------------------------------------

cli                            ; Disable interrupts for exclusive control

mov al, 0xB6                   ; Prepare control word for the speaker
out 0x43, al                   ; Send control word to Timer Control Port

mov al, 0x04                   ; High-byte of frequency to Channel 2
out 0x42, al                   ; Send high-byte to Channel 2 Data Port

mov al, 0xA9                   ; Low-byte of frequency to Channel 2
out 0x42, al                   ; Send low-byte to Channel 2 Data Port

in al, 0x61                    ; Read port 0x61 state into AL
or al, 0x03                    ; Modify AL to activate the speaker
out 0x61, al                   ; Output AL to turn on the speaker

mov ah, 0x86                   ; BIOS delay function
xor cx, cx                     ; High word of the delay time
mov dx, 0x4240                 ; Low word of the delay time
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
