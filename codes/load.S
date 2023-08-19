.section .text
.global load
.type load, @function

load: 
        add   a4,a0,zero    //initialize sum register a4 with 0x0
        add   a2,a0,a1      //store count of 10 in reg a. reg a1 is loaded with 0xa(decimal 10) from main
        add   a3,a0,zero    //initialize intermediate sum reg a3 by 0x0

loop:   add   a4,a3,a4     // Incremental addition
        addi  a3,a3,1      // Incremet intermediate register by 1
        blt   a3,a2,loop   // If a3 is less that a2,branch to label <loop> 
        add   a0,a4,zero   // store final result to reg a0 so that it can be read by main pgm
        ret


        