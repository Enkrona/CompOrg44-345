.text
main: 
	la $a0, prompt	#prompting user to input number 1  
	jal PromptInt
	move $s0, $v0	#  storing the result in $s0 for num1 

	li $s1, 0		#  current sum in the game
	li $s2, 0		#  current counter in the game/loop

	slti $t7, $s0, 0 	#  sets $t7 to 1 if the num input ($s0) is less than 0 
	beq $t7, 1, end_if	#  branches to end_if the $t7 is flagged "1" or True meaning the num is less than 0 and invalid

	sgt $t7, $s0, 100 	#  sets $t7 to 1 if the num input ($s0) is less than 0 
	beq $t7, 1, end_if	#  branches to end_if the $t7 is flagged "1" or True meaning the num is greater than 100 and invalid

	jal PrintNewLine 	#  prints a new line for the nums

	jal game		# goes to outer_Loop to start game 

	#  subprogram: game
 	#  author: Bradley Taylor
 	#  purpose: to find average of numbers input, and to exit if given -1 or the number is less than 100
 	#  inputs: $s0-$s2	$s0 is input, $s1 is sum , $s2 is a counter 
 	#  outputs: $s7
 	#  returns the average value of the numbers input
 	#  Also calls average_Game, end_game, end_if which supplement info into the subprogram
	game:
		sle $t7, $s0, -1	#  if the user inputs a -1 or less it will quit and then compute average
		beq $t7, 1, average_Game	#  branches to averageGame to compute average	

		sgt $t6, $s0, 100 	#  sets $t6 to 1 if the num input ($s0) is greater than 100 
		beq $t6, 1, end_if	#  branches to end_if the $t6 is flagged "1" or True meaning the num is greater than 100 and invalid

		addi $s2, $s2, 1	# iterates the loop, increments currenNum ($s2) by 1

		# resetting game info! 
		la $a0, prompt	#prompting user to input number 1  
		jal PromptInt
		move $s0, $v0	#  storing the result in $s0 for num1
		add $s1, $s0, $s1	#  adding currentNum that is read in ($s0) to the sum ($s1) 
		b game	# sending back to the game 

	#  The user has input an invalid value, so we exit! 
	end_if:
		la $a0, promptInvalid
		jal PrintString	
		jal Exit	#  game over man!

	average_Game:
		div $s1, $s2	#  divides sum by counter (total by how many nums entered) 
		mflo $s7 	#  puts average in $s7 and then goes to print
		jal end_Game	#  end game which prints 

	end_Game:
		la $a0, results	#  loads results
		move $a1, $s7 	#  moves average ($s7) into $a1 for printing
		jal PrintInt
		jal Exit	#  end game! 

.data
prompt: .asciiz "Please input number from 0-100 (or -1) to exit: "
results: .asciiz "Average is: "
promptInvalid: .asciiz "Invalid input. Exitting."
.include "utils.asm"