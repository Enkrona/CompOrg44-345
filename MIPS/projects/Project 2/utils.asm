# File: utils.asm
# Purpose: To define utilities which will be used in MIPS programs.
# Author: Charles Kann
#
# Instructors are granted permission to make copies of this file
# for use by # students in their courses. Title to and ownership
# of all intellectual property rights
# in this file are the exclusive property of
# Charles W. Kann, Gettysburg, Pa.
#
# Subprograms Index:
# Exit - Call syscall with a server 10 to exit the program
# NewLine - Print a new line character (\n) to the console
# PrintInt - Print a string with an integer to the console
# PrintString - Print a string to the console
# PromptInt - Prompt the user to enter an integer, and return
# it to the calling program.
#
# Modification History
# 12/27/2014 - Initial release


# subprogram: PrintNewLine
# author: Charles Kann
# purpose: to output a new line to the user console
# input: None
# output: None
# side effects: A new line character is printed to the
# user's console
.text
PrintNewLine:
 li $v0, 4
 la $a0, __PNL_newline
 syscall
 jr $ra
.data
 __PNL_newline: .asciiz "\n"
 
 
# subprogram: PrintInt
# author: Charles W. Kann
# purpose: To print a string to the console
# input: $a0 - The address of the string to print.
# $a1 - The value of the int to print
# returns: None
# side effects: The String is printed followed by the integer value.
.text
PrintInt:
 # Print string. The string address is already in $a0
 li $v0, 4
 syscall

 # Print integer. The integer value is in $a1, and must
 # be first moved to $a0.
 move $a0, $a1
 li $v0, 1
 syscall

 #return
 jr $ra
 
 
# subprogram: PromptInt
# author: Charles W. Kann
# purpose: To print the user for an integer input, and
# to return that input value to the caller.
# input: $a0 - The address of the string to print.
# returns: $v0 - The value the user entered
# side effects: The String is printed followed by the integer value.
.text
PromptInt:
 # Print the prompt, which is already in $a0
 li $v0, 4
 syscall

 # Read the integer value. Note that at the end of the
 # syscall the value is already in $v0, so there is no
 # need to move it anywhere.
 move $a0, $a1
 li $v0, 5
 syscall

 #return
 jr $ra
 

# subprogram: PrintString
# author: Charles W. Kann
# purpose: To print a string to the console
# input: $a0 - The address of the string to print.
# returns: None
# side effects: The String is printed to the console.
.text
PrintString:
 addi $v0, $zero, 4
 syscall
 jr $ra
 
# subprogram: PromptStringIn
# author: Bradley Taylor
# purpose: To take input after printing a string (basically once a prompt has been printed it will take in the next input from user)
# input: $a0 - The address of the string to print.
# returns: $input, - The value the user entered
# side effects: The String is printed to the console, and user input stored in $v0
PromptStringIn: 
 li $v0, 4	#  Printing the String that is input
 syscall 

 li $v0, 8	#  Storing result in "input" and max of $a1 size
 la $a0, input
 lw $a1, inputMax
 syscall 

# returning to where it came from
 jr $ra
 
 #  subprogram: NAND
 #  author: Bradley Taylor
 #  purpose: to NAND two values that are input 
 #  inputs: $t0, $t1 used for each num to NAND 
 #  outputs: $t3
 #  returns the value of the NAND operation
 #  which in this case is an AND, then a NOR
.text
NAND:
  and $t4, $t0, $t1	#  combines the nums
  nor $t3, $t4, $t4	#  nors the numbers serving as a NAND
  jr $ra
  
  
 #  subprogram: Multiplyby10
 #  author: Bradley Taylor
 #  purpose: to multiply a num by 10 
 #  inputs: $t0
 #  outputs: $t1
 #  returns: the value of the input times 10
.text
multiplyby10:
  add $t1, $t0, $t0	#  num times 2 (x2)
  add $t1, $t1, $t0	#  double num + num (x3) 
  add $t1, $t1, $t0	#  triple num + num (x4)
  add $t1, $t1, $t0	#  quadruple num + num (x5)
  add $t1, $t1, $t1	#  quintuple num + quintuple num (x10 effect)
  jr $ra

 #  subprogram: equationSolve
 #  author: Bradley Taylor
 #  purpose: to solve an equation
 #  inputs: $a0-$a3 
 #  outputs: $v0
 #  returns: the value of the inputs when solving the equation
.text
equationSolve:
  mul $t7, $a3, $a3	# squares x ($a3) and stores in $t7
  mul $t7, $t0, $t7 	# multiplies x^2($t7) and a ($a0) and stores in $t7
  
  mul $t6, $a1, $a3	#  multiplies b ($a1) and x ($a3) and stores in $t6
  add $t7, $t7, $t6	#  adds a*x^2 ($t7) and bx ($t6) stores back in $t7 
  
  add $t0, $t7, $a2	#  adds ax^2 + bx and c and stores in $v0 
  move $v0, $t0	        #  stores result of equation in $v0 for printing 
  jr $ra

 #  subprogram: average
 #  author: Bradley Taylor
 #  purpose: to find average value of 4 nums
 #  inputs: $a0-$a3 
 #  outputs: $v0
 #  returns the average value of the numbers input
 #
.text
average:
	li $t7, 4		#  loads value of 4 
	add $t5, $a0, $a1	#  adding nums 1,2 
	add $t6, $a2, $a3 	#  adding nums 3,4 to (1+2) 
	add $t5, $t5, $t6 	#  adding (1+2) + (3+4) stores in $t5
	div $t5, $t7 	 	#  dividing by 4 and storing value in $v0 for output
	mflo $v0 		#  putting result in $v0
	#  returning to main 
 	jr $ra
 
# subprogram: Exit
# author: Charles Kann
# purpose: to use syscall service 10 to exit a program
# input: None
# output: None
# side effects: The program is exited
.text
Exit:
 li $v0, 10
 syscall
