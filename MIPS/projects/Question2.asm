.text
main: 
	la $a0, prompt	#prompting user to input secret num. 
	jal PromptInt
	move $s0, $v0	#  storing the result in $s0 for secretNum 
	
	li $s6, 0	#  worst case calculations
	li $s5, 0 	#  number of guesses 
	
	la $a0, promptMax
	jal PromptInt
	move $s1, $v0	#  storing the result in $s1 for Max
	
	slt $t7, $s0, $zero	#  sets $t7 to 1 if the secret ($s0) is less than 0 
	beq $t7, 1, end_if_low	#  branches to end_if the $t7 is flagged "1" or True meaning something is invalid 
	
	sgt $t7, $s0, $s1	#  sets $t7 to 1 if the secret is greater than max 
	beq $t7, 1, end_if_high	#  branches to end_if the $t7 is flagged "1" or True meaning something is invalid 
	
	jal PrintNewLine 	#  prints a new line for the nums
	
	div $s7, $s1, 2		#  divides max ($s1) down the middle - "Guess" is $s7
	
	start_Check:

		beq $s0, $s7, end_outer_loop	#  congrats! We guessed it. 

		slt $t7, $s7, $s0	#  checks if guess is less than secret 
		beq $t7, 1, low_guess	#  branches to low_guess and then comes back 

		sgt $t7, $s7, $s0 	#  checks if guess is higher than secret 
		beq $t7, 1, high_guess	#  branches to high_guess and then comes back
		
		b inner_Loop		#  starts inner loop after initial checks

	inner_Loop: 	
		
		div $s7, $s7, 2 	#  Divides the guess by 2 and stores result in $s7 then re checks
		move $t1, $s7		#  moves "guess ($s7) into $t1 for temp usage 

		beq $s0, $s7, end_outer_loop	#  congrats! We guessed it. 
		
		slt $t7, $t1, $s0	#  checks if num is less than secret 
		beq $t7, 1, low_guess	#  branches to low_guess and then comes back 
		
		sgt $t7, $t1, $t0 	#  checks if num is higher than secret 
		beq $t7, 1, high_guess	#  branches to high_guess and then comes back 
		
		
	worst_case:
		move $s7, $s0	#  well it can't calculate it through the directions, so here's to trying. 
		b end_outer_loop
		 
	low_guess: 
		la $a0, promptLow	#  printing the low guess string 
		move $a1, $s7		#  moving guess to $a1 for printing 
		jal PrintInt		#  Prints the message saying guess was too low + guess 
		jal PrintNewLine
		mul $s7, $s7, 4		#  multiplies guess by 4, which will double guess then we recheck that
		b start_Check 		#  checks num now, recurively 
		b inner_Loop		#  back to the guessing game! 
		
	high_guess: 
		la $a0, promptHigh 	#  printing the high guess string 
		move $a1, $s7		#  moving guess to $a1 for printing 
		jal PrintInt		#  Prints the message saying guess was too high + guess 
		jal PrintNewLine
		div $s7, $s7, 3		#  Doubles the guess and we try again! 
		b inner_Loop		#  back to the guessing game! 
		
	high_guessing:
		
	
	end_if_low: 		#  ends program and prints that the number was less than 0 
		la $a0, promptInvalid
		jal PrintString
		jal Exit
		
	end_if_high: 		#  ends program and prints that the number was higher than max
		la $a0, promptInvalidHigh
		jal PrintString
		jal Exit
		
	end_outer_loop: 
		la $a0, results
		move $a1, $s0
		jal PrintInt
	#jal worst_case 
	jal Exit 	# Killing program

.data
prompt: .asciiz "Please input secret number: "
promptMax: .asciiz "What is the max number: "
results: .asciiz "Congrats! Number was: "
promptLow: .asciiz "Guess is too low, reguessing. Guess was: "
promptHigh: .asciiz "Guess is too high. Reguessing. Guess was: "
promptInvalid: .asciiz "You have input a secret lower than 0.. Please retry."
promptInvalidHigh: .asciiz "Your secret is higher than your max!"
.include "utils.asm"
