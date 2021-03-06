@********************************************************************
@*          crt0.s                                                  *
@*            Start Up Routine (For GAS)                            *
@*                                                                  *
@*          Copyright (C) 1999-2001 NINTENDO Co.,Ltd.               *
@********************************************************************
    .INCLUDE    "toolinclude/AgbDefine.s"
    .INCLUDE    "toolinclude/AgbMemoryMap.s"
    .TEXT


@--------------------------------------------------------------------
@-       Interrupt Branch Process (Table Lookup) 32Bit        25-60c-
@--------------------------------------------------------------------
	.section .iwram, "ax", %progbits
    .extern     IntrTable
    .arm
    .align
    .global     intr_main
intr_main:
        mov     r3, #REG_BASE           @ Check IE/IF
        add     r3, r3, #OFFSET_REG_IE  @ r3: REG_IE
        ldr     r2, [r3]
        and     r1, r2, r2, lsr #16     @ r1: IE & IF
	ands    r0, r1, #CASSETTE_INTR_FLAG  @ Game Pak interrupt
loop:   bne     loop
        mov     r2, #0
        ands    r0, r1, #V_BLANK_INTR_FLAG   @ V Blank interrupt
        bne     jump_intr
        add     r2, r2, #4
        ands    r0, r1, #H_BLANK_INTR_FLAG   @ H Blank interrupt
        bne     jump_intr
        add     r2, r2, #4
        ands    r0, r1, #V_COUNT_INTR_FLAG   @ V Counter interrupt
        bne     jump_intr
        add     r2, r2, #4
        ands    r0, r1, #TIMER0_INTR_FLAG    @ Timer 0 interrupt
        bne     jump_intr
        add     r2, r2, #4
        ands    r0, r1, #TIMER1_INTR_FLAG    @ Timer 1 interrupt
        bne     jump_intr
        add     r2, r2, #4
        ands    r0, r1, #TIMER2_INTR_FLAG    @ Timer 2 interrupt
        bne     jump_intr
        add     r2, r2, #4
        ands    r0, r1, #TIMER3_INTR_FLAG    @ Timer 3 interrupt
        bne     jump_intr
        add     r2, r2, #4
        ands    r0, r1, #SIO_INTR_FLAG       @ Serial Communication interrupt
        bne     jump_intr
        add     r2, r2, #4
        ands    r0, r1, #DMA0_INTR_FLAG      @ DMA0 interrupt
        bne     jump_intr
        add     r2, r2, #4
        ands    r0, r1, #DMA1_INTR_FLAG      @ DMA1 interrupt
        bne     jump_intr
        add     r2, r2, #4
        ands    r0, r1, #DMA2_INTR_FLAG      @ DMA2 interrupt
        bne     jump_intr
        add     r2, r2, #4
        ands    r0, r1, #DMA3_INTR_FLAG      @ DMA3 interrupt
        bne     jump_intr
        add     r2, r2, #4
        ands    r0, r1, #KEY_INTR_FLAG       @ Key interrupt
jump_intr:
        strh    r0, [r3, #2]            @ IF Clear           11c
        ldr     r1, =IntrTable          @ Jump to user IRQ process
        add     r1, r1, r2
        ldr     r0, [r1]
        bx      r0


@   .ORG    0x200


    .END

