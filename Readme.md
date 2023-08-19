# RISC-V based MYTH
This repository summarises work done on the RISC-V workshop by VSD Corp. Pvt. Ltd.<br />

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
  <br />
  
  Application software (apps) and hardware are linked by 'system software'.There are various layers of **system software**. This includes major components like Compiler and Assembler.<br />
  <br />
  The compiler compiles high-level codes like C and C++ to Instructions(eg: the codes inside .exe files) that can be read by the Assembler.<br />
  The Assembler converts it into binary codes which the machine can understand. The instructions act as an interface between the high-level language and the machine language.<br />
  <br />
  The converted binary is then given to an RTL snippet that understands the instruction. This is done by a Hardware Description Language (HDL).<br />
  This is basically called RTL implementation and a netlist is being generated. with this, a physical design implementation of the design is generated.<br />

</details>
<details>
  <summary>Lab 1 : RISC-V software toolchain</summary>
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
      
                                               

  
</details>
