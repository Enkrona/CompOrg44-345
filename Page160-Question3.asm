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
	move $s2, $v0	#  storing the result in $s0 for num3 
	
	#  moving all values to $a registers for subprogram usage 
	move $a0, $s0
	move $a1, $s1
	move $a2, $s2

	jal median	# jumps to num checking
	
	#  subprogram: median
 	#  author: Bradley Taylor
 	#  purpose: to find median of 3 nums
 	#  inputs: $a0-$a2
 	#  outputs: $s7
 	#  returns the median value of the numbers input
 	#  Also calls numSwapMin, numSwapMid, end_if which supplement info into the subprogram
	median: 
	slt $t7, $a0, $a1
	beqz $t7, numSwapMin	#  if $a0 is not less than $a1 then swap the nums
	
	move $t7, $zero		#  zeroes out $t7 
	
	slt $t7, $a1, $a2	#  if $a1 (median) is less than $a2 set $t7 to 1 ( a1 < a2 )
	move $s7, $a1		#  if $a1 is the median we move it out for reading
	beq $t7, 1, end_if 	#  all the nums are in correct order! 
	
	beqz $t7, numSwapMid 	# Since $a2 is less than $a1 we need to swap them and recheck using numSwapMid			
	
	#  this will swap $a0, and $a1 if they are not in the correct order 
	numSwapMin: 
		move $t5, $a1	#  $t5 holds a1
		move $t6, $a0 	#  $t6 holds a0
		move $a0, $t5	#  move $a1 ($t5) into $a0 as the new min number 
		move $a1, $t6	#  move $a0 ($t6) into $a1 as the new median 
		jr $ra 
	#  this will swap $a1 and $a2 if not in correct order then recursively return to median to check and if it passes all checks then it ends 	
	numSwapMid:
		move $t5, $a2	#  $t5 holds a2
		move $t6, $a1 	#  $t6 holds a1
		move $a1, $t5	#  move $a1 ($t5) into $a0 as the new median number 
		move $a2, $t6	#  move $a0 ($t6) into $a2 as the new high 
		b median
	#  ends and prints nums 	
	end_if:
		jal PrintNewLine	#  for good measure
		la $a0, results		#  results string
		move $a1, $s7		#  moving median to $a1 for printing
		jal PrintInt		#  printing
		jal Exit		#  exiting

.data
prompt: .asciiz "Please input number 1: "
prompt2: .asciiz "Please input number 2: "
prompt3: .asciiz "Please input number 3: "
results: .asciiz " Median is: "
.include "utils.asm"