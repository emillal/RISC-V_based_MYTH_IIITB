# RISC-V based MYTH
This repository summarises work done on the RISC-V workshop hosted by **Kunal Ghosh** of VSD Corp. Pvt. Ltd.<br />

# Day 1
<details>
  <summary>Introduction</summary>
  <br />
  RISC-V is an open-source instruction set architecture (ISA) for computer processors.<br>
  An instruction set architecture defines the set of instructions that a processor can execute and the organization and behaviour of those instructions.
  RISC-V is unique in that any single company or organization does not own it. and it is freely available for anyone to use, modify, and implement without the need for licensing fees or proprietary restrictions.<br />  
  <br />
  The RISC-V project began at the University of California, Berkeley in 2010, and it has since gained significant traction in both academia and industry.
  Its open nature has led to a growing ecosystem of hardware and software developers collaborating to create a wide range of products, from simple embedded devices to high-performance supercomputers.
  <br /><br/>

  ![Screenshot from 2023-08-19 12-10-50](https://github.com/mrdunker/RISC-V_based_MYTH_IIIITB/assets/38190245/ab1ac3a5-139e-499e-8863-4f3e4a9777aa)

  <br/>
  Application software (apps) and hardware are linked by 'system software'.There are various layers of **system software**. This includes major components like Compiler and Assembler.<br />
  <br />
  The compiler compiles high-level codes like C and C++ to Instructions(eg: the codes inside .exe files) that can be read by the Assembler.<br />
  The Assembler converts it into binary codes which the machine can understand. The instructions act as an interface between the high-level language and the machine language.<br />
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
   8. W need to set the PATH variable in .bashrc.Do the following commands.<br />
      
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
   If we subtract '**00000000000101c0**'(end of main) and '**0000000000010184**'(beginning of main) and then divide by 4 we get 15. Which is the number of instructions within that particular    block(main).<br />
   <br />

   Now let's execute the below commands:<br/>

   ```
   riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o <filename>.o <filename>.c
   riscv64-unknown-elf-objdump -d <filename>.o | less
   ```
  ![Screenshot from 2023-08-19 08-14-21](https://github.com/mrdunker/RISC-V_based_MYTH_IIIITB/assets/38190245/43edc39a-1c7e-4216-93d5-60ded9c4d433)

  
In the above screenshot, if we subtract '**00000000000100e0**'(end of main) and '**00000000000100b0**'(beginning of main) and then divide by 4 we get 12. Which is the number of instructions within that particular block(main).<br />
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
    Integer number representation refers to the method used to represent whole numbers (integers) within a computer's memory or processor. There are different ways to represent integers in binary      form, which is the fundamental language of computers. <br />
    On a high level, we recognize numbers as decimals but computers recognize them as binary (1's or 0's). So binary conversion is key here.<br/><br />

  ### Unsigned Numbers
  <br />
  Unsigned numbers are a type of integer representation that only includes non-negative integers. These numbers do not have a sign bit to indicate whether they are positive or negative; they   
  represent values greater than or equal to zero. In binary representation, all the bits are used to represent the magnitude of the number, and there is no need to allocate a bit for the sign.

  Unsigned numbers are often used in situations where negative values are not relevant or meaningful. They can represent quantities, indices, counts, and other values that are always positive or  
  zero.
    
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

   ### Signed Numbers
   <br />
   Signed numbers are a type of integer representation that includes both positive and negative integers. In computer systems, signed numbers are represented using various methods to indicate the 
   sign and magnitude of the number.
   <br />
   Two's complement is the most widely used method for representing signed integers in computers. In this method, the leftmost bit (the most significant bit) is the sign bit. A value of 0 in the 
   sign bit represents a positive number, and a value of 1 represents a negative number. The remaining bits represent the magnitude of the number in binary form.
   <br /><br />
   To negate a number in two's complement, you invert all the bits (change 0s to 1s and vice versa) and then add 1 to the result. This method simplifies arithmetic operations and eliminates the 
   need for a separate subtraction circuit.
   

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
  ABIs are crucial for enabling interoperability between different software components, whether they're compiled by the same or different compilers, or even running on different hardware 
  architectures. Operating systems, libraries, and various programming languages need to adhere to a specific ABI to ensure that their binary components can work together seamlessly.<br />
  <br />
  ### What is XLEN?
  <br />
  'XLEN' typically refers to the **X Register Length**. The XLEN value represents the number of bits in the general-purpose registers, which are used for storing data
  and performing computations. In a RISC-V system with a 32-bit XLEN, the general-purpose registers would be 32 bits wide.<br /> 
  Similarly, **in a RISC-V system with a 64-bit XLEN, the general-purpose registers would be 64 bits wide**. The XLEN value has a significant impact on the performance, memory-addressing 
  capabilities, and overall capabilities of the processor.<br />
  A larger XLEN allows for more addressable memory space and potentially more complex computations. However, it also comes with increased hardware. The XLEN value has a significant impact on the 
  performance, memory-addressing capabilities, and overall capabilities of the processor. <br />

  There are two ways in which we can load data  into the 64-bit register.<br />
  - Can be directly loaded
  - Can be loaded into memory and then loaded to reg

  <br />
  RISC-V follows the little-endian condition.<br />
  Little Endian is a byte order or endianness used in computer architecture to represent multi-byte data types such as integers and floating-point numbers in memory.<br /> 
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
 Here the immediate offset gets added to the contents of the source register to form the final address and loads the value from '16' in the figure above into the x8 reg.<br />
 
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
The structure for the above command is given below (R-type), unlike the one before here there are two source registers instead of one and another funct register also. <br />

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

