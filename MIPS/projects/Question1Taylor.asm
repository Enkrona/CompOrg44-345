.text
main: 
	la $a0, prompt  #  using the prompt program from kahn to read in an int
 	jal PromptInt
	move $s0, $v0	#  storing the result in $s0 for input
	li $s1, 3	#  storing the num "3" in $s1
	li $s2, 2		#  current num in the loop
	li $s3, 2		#  setting $s5 to be the counter for the loop

	slt $t7, $s0, $s1	#  sets $t7 to 1 if the num input ($s0) is less than 3 ($s1) 
	beq $t7, 1, end_if	#  branches to end_if the $t7 is flagged "1" or True meaning the num is less than 3 and invalid
	
	jal PrintNewLine 	#  prints a new line for the nums
	
	outer_loop: 
		slt $t7, $s2, $s0	#  as long as current num ($s2) is less than max num ($s0) it will continue
		addi $s2, $s2, 1	# iterates the loop, increments currenNum ($s2) by 1
		li $s3, 2		#  setting $s5 to be the counter for the loop
		beq $t7, 1, inner_loop 	#  ends when current num ($s2) is not less than max ($s0)
		beqz $t7, end_outer_loop	#  If the condition is true (currentNum is less than max) goes in inner loop 
		
	inner_loop:
		rem $t1, $s2, $s3 	#  divides currentNum ($s2) by counterNum ($s3), sets remainder to $t1 (checkBit) 
		addi $s3, $s3, 1	#  increment counterNum ($s3) by one 
		beqz $t1, outer_loop	#  if there is no remainder it is not prime, exits to outer_loop 
		slt $t1, $s3, $s2	#  checks if counterNum is less than currentNum ($s2), if true sets to $t1 to "1"
		beq $t1, 1, inner_loop	#  if the counterNum is less than currentNum ($s2) then recursively call the command to iterate again
		la $a0, results		#  preparing results for printing
		move $a1, $s2		#  move the currentNum ($s2) to $a1 for printing
		jal PrintInt		#  printing
		beqz $t1, outer_loop 	#  if the counterNum ($s3) is not less than currentNum ($s2) go to outer_loop to iterate again
	
	end_if: 		#  ends program and prints that the number was less than 3 
		la $a0, promptInvalid
		jal PrintString
		
	end_outer_loop: 
	
	jal Exit 	# Killing program

.data
prompt: .asciiz "Please input a number you'd like to find prime nums to: "
promptInvalid: .asciiz "Invalid input. Exitting."
results: .asciiz ", "
.include "utils.asm" 
