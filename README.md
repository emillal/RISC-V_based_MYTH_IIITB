# RISC-V based MYTH
This repository summarises work done on the RISC-V workshop hosted by **Kunal Ghosh** of VSD Corp. Pvt. Ltd.<br />

# Day 1
<details>
  <summary>Introduction</summary>
  <br />
  RISC-V is an open-source instruction set architecture (ISA) for computer processors.<br>
  An instruction set architecture defines the set of instructions that a processor can execute and the organization and behaviour of those instructions.
  RISC-V is unique in that any single company or organization does not own it. and it is freely available for anyone to use, modify, and implement without 
  the need for licensing fees or proprietary restrictions.<br />  
  <br />
  The RISC-V project began at the University of California, Berkeley in 2010, and it has since gained significant traction in both academia and industry.
  Its open nature has led to a growing ecosystem of hardware and software developers collaborating to create a wide range of products, from simple embedded 
 devices to high-performance supercomputers.
  <br /><br/>

  ![Screenshot from 2023-08-19 12-10-50](https://github.com/mrdunker/RISC-V_based_MYTH_IIIITB/assets/38190245/ab1ac3a5-139e-499e-8863-4f3e4a9777aa)

  <br/>
  Application software (apps) and hardware are linked by 'system software'.There are various layers of **system software**. This includes major components like   
  Compiler and Assembler.<br />
  <br />
  The compiler compiles high-level codes like C and C++ to Instructions(eg: the codes inside .exe files) that can be read by the Assembler.<br />
  The Assembler converts it into binary codes which the machine can understand. The instructions act as an interface between the high-level language and the 
  machine language.<br />
  <br />
  The converted binary is then given to an RTL snippet that understands the instruction. This is done by a Hardware Description Language (HDL).<br />
  This is basically called RTL implementation and a netlist is being generated. with this, a physical design implementation of the design is generated.<br />

</details>
<details>
  <summary>Lab 1 : RISC-V software toolchain | GCC Compile and Disassemble</summary>
  <br />	
  First, let us write a basic C program to find the sum of n numbers.<br />
  
  ```
  #include <stdio.h>
  int main(){
  int n = 100,sum=0,i;
  for(i=0;i<=n;i++)
  {
	  sum= sum +i;
  }
  printf("The sum of %d consecutive numbers is :%d \n",n,sum);
  return 0;
  }
```
  We need to install the necessary Rriscv_workshop_collateralsISC-V toolchain for RISC-V activities.<br />
  Steps to set up the toolchain:
  1. git clone https://github.com/kunalg123/riscv_workshop_collaterals.git using terminal
  2. go to the **riscv_workshop_collaterals** folder.
  3. On terminal **chmod 755 run.sh** and then **./run.sh**
  4. During the installation, an error might pop up at the end. Ignore it for now.
  5. The riscv_toolchain folder will be on the **home**.
  6. change directory(cd) to  /riscv_toolchain/iverilog/
  7. Then do the following commands:
      
      ```
      git checkout --track -b v10-branch origin/v10-branch
      git pull 
      chmod 777 autoconf.sh 
      ./autoconf.sh 
      ./configure 
      make
      sudo make install
      ```
   8. We need to set the PATH variable in .bashrc.Do the following commands.<br />
      
      ```
      gedit .bashrc
      **within .bashc file**
      export PATH="/home/<username>/riscv_toolchain/riscv64-unknown-elf-gcc-8.3.0-2019.08.0-x86_64-linux-ubuntu14/bin:$PATH"
      **within .bashrc file **
      source .bashrc
      ```

   <br />
   So to compile the .c file with the RISC-V compiler tool. we are using the below command.<br /><br />
   
   ```
   riscv64-unknown-elf-gcc -O1 -mabi=lp64 -march=rv64i -o <filename>.o <filename>.c
   ```
   <br />
   To view the assembly code for the same, do the following command.<br /><br />
   
   ```
   riscv64-unknown-elf-objdump -d <filename>.o
   ```
   ![Screenshot from 2023-08-19 07-51-55](https://github.com/mrdunker/RISC-V_based_MYTH_IIIITB/assets/38190245/723e9b0f-2c68-481c-be8a-e96635999e88)


   To view the detailed code do the following command.<br />

   ```
   riscv64-unknown-elf-objdump -d <filename>.o | less
   ```
   To find **main** we type /main in the **:<command>** and press the 'N' button.<br />
   
   ![Screenshot from 2023-08-19 07-59-21](https://github.com/mrdunker/RISC-V_based_MYTH_IIIITB/assets/38190245/8caf4dea-5340-4655-b708-ad93a195daf0)

   In the above screenshot, we can see the memory address for the instructions. Where it starts and where another one begins.<br />
   If we subtract '**00000000000101c0**'(end of main) and '**0000000000010184**'(beginning of main) and then divide by 4 we get 15. Which is the number of 
   instructions within that particular block(main).<br />
   <br />

   Now let's execute the below commands:<br/>

   ```
   riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o <filename>.o <filename>.c
   riscv64-unknown-elf-objdump -d <filename>.o | less
   ```
  ![Screenshot from 2023-08-19 08-14-21](https://github.com/mrdunker/RISC-V_based_MYTH_IIIITB/assets/38190245/43edc39a-1c7e-4216-93d5-60ded9c4d433)

  
In the above screenshot, if we subtract '**00000000000100e0**'(end of main) and '**00000000000100b0**'(beginning of main) and then divide by 4 we get 12. Which 
is the number of instructions within that particular block(main).<br />
   <br />

  
</details>
<details>
   <summary>Lab 2 : Spike Simulation and Debug</summary>
    <br />
    In this lab, we are going to Debug the '.o' file that we generated using the RISC-V compiler.<br />
    For that, we use the following command:

    ```
    spike pk <filename>.o // to give an output
    spike -d pk <filename>.o //open debugger
    ```
   The debugger mode will be open.<br />
   We use the until command to move to a particular address.<br />
   Here we are debugging the highlighted instructions.<br /><br />
   ![Screenshot from 2023-08-19 09-49-10](https://github.com/mrdunker/RISC-V_based_MYTH_IIIITB/assets/38190245/20f164b4-07c2-4ff1-9f56-012dc38590df)
   <br />
   
   The following commands are used in the debugger:<br />
   ```
   until pc 0 100b0 //moves the program counter(PC) to the address
   reg 0 a2    //views content of the address
   **We press enter to go to the next instruction**
   ```

   ![Screenshot from 2023-08-19 09-49-25](https://github.com/mrdunker/RISC-V_based_MYTH_IIIITB/assets/38190245/e319c824-4009-47f3-806d-fd0c1ac7ce3b)
   <br />

   In the above screenshot, we can see the register pertaining to a particular instruction getting updated.<br />
	
</details>

<details>
    <summary>Integer number representation</summary>
    <br />
    Integer number representation refers to the method used to represent whole numbers (integers) within a computer's memory or processor. There are different   
    ways to represent integers in binary form, which is the fundamental language of computers. <br />
    On a high level, we recognize numbers as decimals but computers recognize them as binary (1's or 0's). So binary conversion is key here.<br/><br />

  ## Unsigned Numbers
  <br />
  Unsigned numbers are a type of integer representation that only includes non-negative integers. These numbers do not have a sign bit to indicate whether they 
  are positive or negative; they   
  represent values greater than or equal to zero. In binary representation, all the bits are used to represent the magnitude of the number, and there is no need 
  to allocate a bit for the sign.

  Unsigned numbers are often used in situations where negative values are not relevant or meaningful. They can represent quantities, indices, counts, and other 
  values that are always positive or zero.
    
![Screenshot from 2023-08-19 11-56-34](https://github.com/mrdunker/RISC-V_based_MYTH_IIIITB/assets/38190245/64d3197c-7010-4473-9013-42cb67cc59d0)
	
   It is important to note that:
   - 1 byte is 8 bits
   - 1 word is 4 bytes
   - 2 words (double word) is 8 bytes
   <br />
   So A word is 32 bits and a double word is 16 bits.<br />
   <br />
   ### 2 bit
   <br />
   the total number of representations = **2^2=4**<br />
   0 -> (2^2 -1)<br />

   <br />
   ### 4 bit
   <br />
   the total number of representations = **2^4=16**<br />
   0 -> (2^4 -1)<br />

   <br />
   Similarly, we can follow the same for the **RISC-V** which has 64-bit Architecture.
   <br />
   the total number of representations = **2^16**<br />
   0 -> (2^16 -1)<br />

   ## Signed Numbers
   <br />
   Signed numbers are a type of integer representation that includes both positive and negative integers. In computer systems, signed numbers are represented 
   using various methods to indicate the 
   sign and magnitude of the number.
   <br />
   Two's complement is the most widely used method for representing signed integers in computers. In this method, the leftmost bit (the most significant bit) is 
   the sign bit. A value of 0 in the 
   sign bit represents a positive number, and a value of 1 represents a negative number. The remaining bits represent the magnitude of the number in binary form.
   <br /><br />
   To negate a number in two's complement, you invert all the bits (change 0s to 1s and vice versa) and then add 1 to the result. This method simplifies 
   arithmetic operations and eliminates the need for a separate subtraction circuit.

</details>
<details>
  <summary>Lab Signed and unsigned</summary>
  
### LAB 3A 

Here we are going to execute the following code.<br />
The output is given for unsigned numbers and we are just viewing if it is within the range or it goes out in which case displays either the minimum or maximum values.<br />

```

#include <stdio.h>
#include <math.h>
int main()
{
    unsigned long long int max = (unsigned long long int)(pow(2,64)-1);       //statement 1  //will display the max number
    //unsigned long long int max = (unsigned long long int)(pow(2,127)-1);    //statement 2  //(out of range) will display the max number(within range)
    //unsigned long long int max = (unsigned long long int)(pow(2,10)-1);     //statement 3  //will display number (since it is within range)
    //unsigned long long int max = (unsigned long long int)(pow(2,64) * -1);  //statement 4  //will display 0 since it is a -ve number
    printf("highest number represented by unsigned long long int is %llu\n",max);
    return 0;
}
```
The output is given below in sequential order.<br />
![Screenshot from 2023-08-19 13-10-09](https://github.com/mrdunker/RISC-V_based_MYTH_IIIITB/assets/38190245/5f4c5dfd-57b1-430f-9b67-67af49ae30a6)

### LAB 3B

Here we are going to execute the following code.<br />

```
#include <stdio.h>
#include <math.h>
int main()
{
    long long int max = (long long int)(pow(2,63)-1);        //will display the max number
    long long int min = (long long int)(pow(2,63) * -1);     //will display the min number
    printf("highest number represented by long long int is %lld\n",max);
    printf("lowest number represented by long long int is %lld\n",min);
    return 0;
}
```
The below screenshot shows the output of the same.<br />

![Screenshot from 2023-08-19 14-41-36](https://github.com/mrdunker/RISC-V_based_MYTH_IIIITB/assets/38190245/7456d5d9-b8a3-4ad5-ade7-f10906029213)

	
</details>

# Day 2

<details>
  <summary>Introduction to ABI and verification Flows</summary>
  <br />
  The Application Binary Interface (ABI) is a set of rules and conventions that dictate how binary code communicates and interacts with other binary code, usually across different components of a 
  software system or even across different software systems. In simpler terms, it defines how functions are called, how data is organized, and how components cooperate at the binary level.<br />

  There are multiple layers between the Application program and the Hardware. One of these layers is the ABI.<br />
  
  ![Screenshot from 2023-08-19 15-20-31](https://github.com/mrdunker/RISC-V_based_MYTH_IIIITB/assets/38190245/8850d871-98dc-4978-95ea-36abf4c9973c)
  <br />
  ABIs are crucial for enabling interoperability between different software components, whether they're compiled by the same or different compilers, or even 
  running on different hardware 
  architectures. Operating systems, libraries, and various programming languages need to adhere to a specific ABI to ensure that their binary components can work 
  together seamlessly.<br />
  <br />
  ## What is XLEN?
  <br />
  'XLEN' typically refers to the **X Register Length**. The XLEN value represents the number of bits in the general-purpose registers, which are used for 
  storing data and performing computations. In a RISC-V system with a 32-bit XLEN, the general-purpose registers would be 32 bits wide.<br /> 
  Similarly, **in a RISC-V system with a 64-bit XLEN, the general-purpose registers would be 64 bits wide**. The XLEN value has a significant impact on the 
  performance, memory-addressing capabilities, and overall capabilities of the processor.<br />
  A larger XLEN allows for more addressable memory space and potentially more complex computations. However, it also comes with increased hardware. The XLEN 
  value has a significant impact on the performance, memory-addressing capabilities, and overall capabilities of the processor. <br />

  There are two ways in which we can load data  into the 64-bit register.<br />
  - Can be directly loaded
  - Can be loaded into memory and then loaded to reg

  <br />
  RISC-V follows the little-endian condition.<br />
  Little Endian is a byte order or endianness used in computer architecture to represent multi-byte data types such as integers and floating-point numbers in 
  memory.<br /> 
  In a Little Endian system, the least significant byte (LSB) of a multi-byte value is stored at the lowest memory address, while the most significant byte (MSB)
  is stored at the highest memory address.<br /><br />
  RISC-V little-endian is illustrated by the figure below:<br />
  
  ![Screenshot from 2023-08-19 15-44-13](https://github.com/mrdunker/RISC-V_based_MYTH_IIIITB/assets/38190245/7fccf896-d030-496e-bc23-8f5852414520)
  <br />
  
</details>
<details>
  <summary>Load,Add and Store Instructions</summary>
   <br />

   Firstly let us load an array 'M' of 3 double-word as shown in the below figure.<br />
	
   ![Screenshot from 2023-08-19 15-59-44](https://github.com/mrdunker/RISC-V_based_MYTH_IIIITB/assets/38190245/c5342f67-4af9-4a6e-a5fa-3ecc7dfe1e8b)
   <br />
   Here let us load it into the 'x8' register. let's say reg 'x23' contains the base address of array **M** and it is '0'.<br />
   as in it starts at 0. Let us consider the instruction below,**ld(load doubleword)**.<br />

   ```
   ld   x8, 16(x23)
   ```
  breaking down the instruction:<br />
  - ld: load double
  - x8: destination register 'rd'
  - 16: offset immediate
  - x23: Souce register 'rs1'
 <br />
 Here the immediate offset gets added to the contents of the source register to form the final address and loads the value from '16' in the figure above into
 the x8 reg.<br />
 
![Screenshot from 2023-08-19 16-12-32](https://github.com/mrdunker/RISC-V_based_MYTH_IIIITB/assets/38190245/d74c08b8-50e8-474d-8350-f29bd9fa30cb)
<br />
The diagram above represents the instruction(**I-type**).<br />
It  is important to note that even though the register size is of 64-bit in RV64 the instruction size is 32-bit.<br />
The opcode and the funct3 determine the type of instruction, whether it is an 'ld' or 'addi' etc.<br />
rs1 and rd are the source and destination registers respectively.<br />
The immediate bits will contain the offset.<br />
<br />
Let us look at another instruction,**add**.<br />

```
add x8, x24,x8
```
<br />
The structure for the above command is given below (R-type), unlike the one before here there are two source registers instead of one and another funct 
register also. <br />

![Screenshot from 2023-08-19 16-23-38](https://github.com/mrdunker/RISC-V_based_MYTH_IIIITB/assets/38190245/adb5c485-27ad-4907-8220-cb8fe59d7ecb)

There is another instruction going by **sd(store doubleword)**.<br />

```
sd x8, 8(x23)
```
Since there is a limited availability of registers we need to store values to registers after loading and doing operations.<br />
The Instruction structure will look like so(**S-type**):<br />
![Screenshot from 2023-08-19 16-35-09](https://github.com/mrdunker/RISC-V_based_MYTH_IIIITB/assets/38190245/71eff24c-8d55-4982-bd3b-7c313ddcafb1)
<br />

### Instruction set in RISC-V
There are mainly three types of Instructions:<br />
1. I-type: I-type instructions are used for operations that involve an immediate value (constant) and a register.
2. R-type: R-type instructions are used for operations that involve two source registers and a destination register.<br />
   	   These instructions typically perform arithmetic, logical, or bitwise operations.
3. S-type: S-type instructions are used for memory store operations.<br/>
 	   These instructions store data from a source register in memory at an address determined by an offset from another register.


</details>

<details>
  <summary>LAB work using ABI function calls</summary>	
    <br />
    For this lab, we are going to create a C program and simulate it with a Function call.<br />
    We are going to be following the below algorithm.<br />
    
   ![Screenshot from 2023-08-19 18-27-06](https://github.com/mrdunker/RISC-V_based_MYTH_IIIITB/assets/38190245/5c77693e-5d2f-4466-ba04-f8148b8b5f3a)
   <br />
   The C program used is:<br />

   ```
   #include <stdio.h>
   extern int load(int x,int y);
   int main()
	{
    	int result = 0;
   	int count =9;
    	result = load(0x0,count+1);
    	printf("Sum of numbers from 1 to %d is %d\n",count,result);
	}
   ```
   We also create a load.S file as below:<br />
   
   ```
   .section .text
   .global load
   .type load, @function

   load: 
        add   a4,a0,zero    //initialize sum register a4 with 0x0
        add   a2,a0,a1      //store count of 10 in reg a. reg a1 is loaded with 0xa(decimal 10) from main
        add   a3,a0,zero    //initialize intermediate sum reg a3 by 0x0

   loop:
	add   a4,a3,a4     // Incremental addition
        addi  a3,a3,1      // Increment intermediate register by 1
        blt   a3,a2,loop   // If a3 is less than a2,branch to label <loop> 
        add   a0,a4,zero   // store final result to reg a0 so that it can be read by main pgm
        ret

   ```
We do the following commands in the terminal:<br />

```
riscv64-unknown-elf-gcc -ofast -mabi=lp64 -march=rv64i -o <filename>.o <filename>.c load.S
spike pk <filename>.o
riscv64-unknown-elf-objdump -d <filename>.o | less

```
The output screenshots are shown below:<br />
![Screenshot from 2023-08-19 18-34-28](https://github.com/mrdunker/RISC-V_based_MYTH_IIIITB/assets/38190245/08969317-393a-43de-a74c-0839f0e4fbc5)
![Screenshot from 2023-08-19 18-35-44](https://github.com/mrdunker/RISC-V_based_MYTH_IIIITB/assets/38190245/0a357ad0-9cb7-4e84-82da-d9eacd7763e6)

</details>

<details>
<summary>Basic verification flow using verilog</summary>
<br />
 In this lab, we are basically going to generate a hex file and a bitstream of the same code done above.<br />
 We run the below code to generate the same.<br />

 ```
 riscv64-unknown-elf-gcc -c -mabi=ilp32 -march=rv32im -o <filename>.o <filename>.c
 riscv64-unknown-elf-gcc -c -mabi=ilp32 -march=rv32im -o load.o load.S

 riscv64-unknown-elf-gcc -c -mabi=ilp32 -march=rv32im -o syscalls.o syscalls.c
 riscv64-unknown-elf-gcc -mabi=ilp32 -march=rv32im -Wl,--gc-sections -o firmware.elf load.o <filename>.o syscalls.o -T riscv.ld -lstdc++
 chmod -x firmware.elf
 riscv64-unknown-elf-gcc -mabi=ilp32 -march=rv32im -nostdlib -o start.elf start.S -T start.ld -lstdc++
 chmod -x start.elf
 riscv64-unknown-elf-objcopy -O verilog start.elf start.tmp
 riscv64-unknown-elf-objcopy -O verilog firmware.elf firmware.tmp
 cat start.tmp firmware.tmp > firmware.hex
 python3 hex8tohex32.py firmware.hex > firmware32.hex
 rm -f start.tmp firmware.tmp
 iverilog -o testbench.vvp testbench.v picorv32.v
 chmod -x testbench.vvp
 vvp -N testbench.vvp

 ```

The file firmware.hex is the hex file and firmware32.hex is the bitstream generated.<br />
The below file is firmware.hex.<br />
![Screenshot from 2023-08-19 19-03-24](https://github.com/mrdunker/RISC-V_based_MYTH_IIIITB/assets/38190245/83b6a54b-6e82-4dd1-9d30-c0992e125820)
<br /><br />
The below file is firmware32.hex  (bitstream).<br />
![Screenshot from 2023-08-19 19-03-42](https://github.com/mrdunker/RISC-V_based_MYTH_IIIITB/assets/38190245/48f4cbb3-ad76-4e53-89dd-7885fc2eba3a)

</details>

# Day 3
<details>
<summary>Digital logic with TL-Verilog and Makerchip</summary>
<br />
	
In this part of the workshop, we are going to look at:<br />
 1. Logic gates
 2. MakerChip platform(IDE)
 3. Combinational Logic
 4. Sequential Logic
 5. Piplining logic
 6. Slate

## Introduction to logic gates

Logic gates are fundamental building blocks of digital circuits. They are electronic devices that perform basic logical operations
on one or more binary inputs (usually 0 or 1) to produce a single binary output. These gates are the foundation of all digital systems, 
including computers, microcontrollers, and other digital devices. Logic gates are typically implemented using electronic 
components such as transistors.<br />

The most common logic gates are:<br />
1. NOT
2. AND
3. OR
4. NAND
5. NOR
6. XOR
7. XNOR

![Screenshot from 2023-08-19 21-30-21](https://github.com/mrdunker/RISC-V_based_MYTH_IIIITB/assets/38190245/ffb2cea3-d872-43e4-ba83-86e5e604ae9d)
<br />

## Makerchip
[Makerchip](https://makerchip.com/) is an online platform that provides an integrated development environment (IDE) for digital design and verification using 
SystemVerilog and TL  Verilog. It allows engineers, students, and enthusiasts to design and simulate digital circuits, develop RTL (Register Transfer Level) 
code, and explore hardware design concepts without requiring the local installation of tools.<br />

To Familiarize oneself with the IDE there are tutorials on the platform where we can experiment.<br />

## Combinational Logic

For this, I have started with a basic inverter logic program, [logical operations](images/combinational.png) and a [multi-bit mux program](images/mux2.png). Here we are using Transitional Level Verilog(TL-V), which is quite different from standard verilog code, syntax varies quite a bit. There is no need to declare ```$out``` and ```$in``` unlike Verilog. There is also no need to assign ```$in```. A random stimulus is provided, and a warning is produced.<br />

Attaching output of the inverter in Makerchip IDE for reference:<br />
![invertor](https://github.com/mrdunker/RISC-V_based_MYTH_IIITB/assets/38190245/d0c8752d-0483-4969-96d9-fb8b40edc82f)
<br />
<br />

Now let us do a bit more of a complex combinational circuit. Let us create the following circuit.<br />
Below shown is a calculator which uses a mux.<br />

![combi_calc1](https://github.com/mrdunker/RISC-V_based_MYTH_IIITB/assets/38190245/484ad7b6-742f-4ef1-9bd3-d552b0e63033)
<br /><br />
The code for this [here](codes/comibational_calc.tlv) and the output is shown as below.<br />

![combi](https://github.com/mrdunker/RISC-V_based_MYTH_IIITB/assets/38190245/d16536c7-c161-4d90-a426-6351fcee22a0)

## Sequential Logic

Sequential Circuits will always use a clock. The basic element required for a circuit to be sequential is a D-FF. The DFF transitions<br />
to the next state on the positive edge of the clock.<br />
A basic circuit design implementing a [Fibonacci series](images/fibbanochi.png) is done on Makerchip.<br />
Also, a free-running counter having the following design is implemented. <br /><br />
![freerncntr](images/freerncntr.png)
<br />
Right-click open the [code](codes/freecounter.tlv) to get the tlv code for the free running counter.<br />
<br />
The output for the same is shown below.<br />
![feecnte](images/feecnte.png)

</details>
<details>
<summary>LAB Sequential Calculator</summary>
<br />
Here we are going to implement a FF to the combinational calculator we did before.<br />
The design of the sequential calculator is like so:<br />
<br />
	
![seqcalc0](images/seqcalc0.png)
<br />
The output of the previous clock cycle is assigned to the input1.<br />
The tlv code is available [here](codes/seq_calc.tlv).<br />
<br />
The output for the same is shown below.<br />
![seqcalc](images/seqcalc.png)
</details>

<details>
<summary>Pipeling Logic</summary>
<br />
Here firstly we are trying to make the following pipeline and see the output waveform.<br />
	
![err](images/err.png)
<br />
Click to view the [code](codes/pipelining.tlv). <br />
The output in Makerchip is shown below.<br />

![error](images/error.png)

## Two-cycle calculator

We are required to write code and view the waveform of the below design.<br />

![calc_pipeline](images/calc_pipeline.png)
<br />
As shown above, the 2-cycle calculator clears the output alternatively and the output of given inputs is observed at the next cycle.<br />
Click to view the [code](codes/calc_pipe.tlv).<br />
<br />
The output on Makerchip is shown below.<br />

![pipelining _out](images/pipelining _out.png)
 
</details>

# Acknowledgements
- [Kunal Ghosh](https://github.com/kunalg123), Co-founder, VSD Corp. Pvt. Ltd.
- [Steve Hoover](https://github.com/stevehoover), Founder, Redwood EDA
- [Shivani Shah](https://github.com/shivanishah269), IIIT-Bangalore
  
# References

1. https://github.com/kunalg123/riscv_workshop_collaterals
   


