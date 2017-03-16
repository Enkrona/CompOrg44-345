.text
main: 

	la $a0, prompt	#prompting user to input number 1 
	jal PromptInt
	move $s0, $v0	#  storing the result in $s0 for num1 

	la $a0, prompt2	#  prompting user for number 2
	jal PromptInt
	move $s1, $v0	#  storing the result in $s1 for num2

	la $a0, prompt3	#  prompting user to input number 3 
	jal PromptInt
	move $s2, $v0	#  storing the result in $s2 for num3 

	la $a0, prompt4	#  prompting for num 4
	jal PromptInt
	move $s3, $v0	#  storing the result in $s3 for num4

	#  moving all values to $a registers for subprogram usage 
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	move $a3, $s3

	jal average	#  calls the average subprogram which will return the average in $v0 
	move $s7, $v0 	#  Moves the average to $s7 for safe keeping 

	#  moving all values to $a registers for subprogram usage 
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2
	move $a3, $s3

	jal largest_Num 	#  calls the largestNum subprogram to find the largest num and return in $v0
	jal end_if		#  ending the program and printing results 

	#  subprogram: largest_Num
 	#  author: Bradley Taylor
 	#  purpose: to find largest number in 4 numbers
 	#  inputs: $a0-$a3
 	#  outputs: $s6
 	#  returns the largest value of the numbers input
 	#  Also calls numSwapMin, numSwapMid, numSwapHigh, end_if which supplement info into the subprogram
 	
	largest_Num:
		slt $t7, $a0, $a1	#  checks if $a0 is less than $a1
		beqz $t7, numSwapMin	#  if $a0 is not less than $a1 then swap the nums

		move $t7, $zero		#  zeroes out $t7 

		slt $t7, $a1, $a2	#  if $a1 (second num) is less than $a2 set $t7 to 1 ( a1 < a2 ) 

		beqz $t7, numSwapMid 	#  Since $a2 is less than $a1 we need to swap them and recheck using numSwapMid

		slt $t7, $a2, $a3 	#  checks to see if $a2 (third num) is less than $a3 (High num)
		move $s6, $a3		#  if $a3 is the highest we move it out for reading
		beq $t7, 1, end_if 	#  all the nums are in correct order!		

		beqz $t7, numSwapHigh 	#  Since $a3 is less than $a2 we need to swap them and recheck using numSwapHigh				

	#  this will swap $a0, and $a1 if they are not in the correct order 
	numSwapMin: 
		move $t5, $a1	#  $t5 holds a1
		move $t6, $a0 	#  $t6 holds a0
		move $a0, $t5	#  move $a1 ($t5) into $a0 as the new min number 
		move $a1, $t6	#  move $a0 ($t6) into $a1 as the new median 
		b largest_Num 
	#  this will swap $a1 and $a2 if not in correct order then return to largest_Num to check and if it passes all checks then it ends 	
	numSwapMid:
		move $t5, $a2	#  $t5 holds a2
		move $t6, $a1 	#  $t6 holds a1
		move $a1, $t5	#  move $a1 ($t5) into $a0 as the new median number 
		move $a2, $t6	#  move $a0 ($t6) into $a2 as the new high 
		b largest_Num
	#  this will swap $a2 and $a3,  if not in correct order then return to largest_Num to check and if it passes all checks then it ends 
	numSwapHigh:
		move $t5, $a3	#  $t5 holds $a3
		move $t6, $a2	#  $5 holds $a2
		move $a2, $t5	#  moves $a3 ($t5) into $a2 as the new third number 
		move $a3, $t6	#  moves $a2 ($t6) into $a3 as the new high number 
		b largest_Num	#  returns to largest_num to continue the sort 

	end_if: 

		la $a0, results	#  loads address for printing of result
		move $a1, $s7 	#  moving average to $a1  for printing
		jal PrintInt	#  printing average 

		jal PrintNewLine	#  for cleanliness 

		la $a0, resultsLarge	#  moving largest num string to $a0 for printing
		move $a1, $s6 		#  overwritting old value and storing largest num in $s6 
		jal PrintInt 
		jal Exit		#  GAME OVER!  
.data
prompt: .asciiz "Please input number 1: "
prompt2: .asciiz "Please input number 2: "
prompt3: .asciiz "Please input number 3: "
prompt4: .asciiz "Please input number 4: "
results: .asciiz " Average was: "
resultsLarge: .asciiz " Largest num was: "
.include "utils.asm"