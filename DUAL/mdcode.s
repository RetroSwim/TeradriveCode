    ; This will be loaded into work ram at a very special location
    org $FF0100
Start:
    ; Disable interrupts
    move.w  #$2700,sr

    ; Free up the 286
    move.b  #$8B,($AF1164)

    ; Set up a note on the PSG
    move.b  #$98,($C00011)
    move.b  #$8f,($C00011)
    move.b  #$1f,($C00011)
    
Loop:
    ; Beep boop!
    move.b  #$90,($C00011)
    
    bsr     Delay            

    move.b  #$9f,($C00011)
    
    bsr     Delay           

    bra     Loop             

Delay:
    ; A delay loop like mamma used to make.
    move.w  #$FFFF,d0     
Wait:
    dbra    d0,Wait      
    rts

    ; Purely here so I didn't have to keep retyping it.
Key:dc.b 'PRODUCED BY OR UNDER LICENSE FROM SEGA ENTERPRISES Ltd.',0
