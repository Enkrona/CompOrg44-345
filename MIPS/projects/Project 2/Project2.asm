.text 
main: 
	la $a0, promptScaleStart
	jal PromptInt
	move $s0, $v0 
	
	la $a0, promptScaleEnd
	jal PromptInt
	move $s1, $v0 
	
	la $a0, promptScaleTime
	jal PromptInt
	move $s2, $v0 
	
	sgt $t0, $s1, $s0
	beq $t0, 1, ScaleLoop

	ScaleLoop: 
		sle $t0, $s0, $s1	#  here this tests to see if the scale you are on (or starting with) is less than the ending scale
		addi $s0, $s0, 1	#  adds one to the scale you are on (or starting with) to iterate the loop 
		
		#  Moving vars to temp for use in Sale
		move $a0, $s0 	#  Starting Scale
		move $a1, $s1	#  Ending Scale
		move $a2, $s2	#  Time/Duration
		
		beq $t0, 1, Scale	#  If $t0, *used above that if the currentScale is less than the ending scale* is equal to 1 than branch to scale 
		jal PrintNewLine	#  Cleaning up console for Maestro
		beqz $t0, MaestroStart

	#  Start of Maestro  Subprogram 
	MaestroStart: 
		jal PrintNewLine	#  Advising user that the program is entering Maestro
		la $a0, maestroBegin
		jal PrintString 
		jal PrintNewLine
		
		la $a0, promptMaestroNum	#  Prints prompt and reads in an int for number of notes to play, (next two lines)
		jal PromptInt
		move $s0, $v0
		
		move $s1, $zero			#  Setting noteCounter to be 0 to count up 
		
		sgt $t0, $s0, $zero		#  So long as $s0 is greater than 0, it will branch to MaestroLoop
		beq $t0, 1, MaestroLoop
		
		MaestroLoop: 
			sle $t0, $s1, $s0	#  checks if the current noteCounter ($s1) is less than max ($s0)
			addi $s1, $s1, 1		#  Adding one to the counter
			
			move $a0, $s0		#  Moving only because instructions state to do so for the subprogram
			
			beq $t0, 1, Maestro	#  Starts Maestro
			jal PrintNewLine	#  Cleaning up and starting PlayString
			beqz $t0, PlayStringStart

	PlayStringStart:
		jal PrintNewLine		#  Advising user that we are entering the PlayString Subprogram
		la $a0, playStringBegin		
		jal PrintString
		jal PrintNewLine
		
		la $a0, promptString		#  printing the prompt for PlayString, and storing user input in "input"
		jal PromptStringIn
		
		la $a0, input 			#  Loading address of input to $a0
		move $s7, $a0 			#  storing in $s7 for safe keeping 
		li $s6, 0 			#  Counter used to store current value of character we are on
		b PlayString
		
	
	endOfProject:
		jal Exit	#  end of program 
		
## -- START OF SUBPROGRAMS -- ##	

	Scale: 
	# subprogram: Scale
	# purpose: plays a scale of notes from start to end, each note lasting duration milliseconds.
	# input: $a0 = start, $a1 = end, $a2 = duration
	# output: none
	# returns: none
	# side-effects: plays notes from $a0 to $a1 inclusive, each of time $a2
	
	#  Moving vars back for use in the Loop 
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	
	move $a1, $s2 	#  Replace $a1 which was end with duration of sound ($s2) to conform to MIPS standards 
	li $a2, 69	# Choosing an insrument, random
	li $a3, 127 	#  Choosing volume, 100
	li $v0, 33
	syscall 
	b ScaleLoop 
	
	
	Maestro:
	# subprogram: Maestro
	# purpose: play a random series of notes (each between 20-107). Each note will last 500 ms.
	# input: $a0 = # of notes
	# output: prints the # of each (randomly generated) note as it is played
	# returns: none
	# side-effects: plays $a0 notes, chosen at random between 20-107
	
	move $s0, $a0 	# Moving var back to sa safe register due to MIPS Standards for syscall of Music
	
	#  Random num generation 
	li $a0, 58	#  Lower bound for random num
	li $a1, 107 	#  Upper bound for random num
	li $v0, 42
	syscall 
	move $s7, $a0	#  Moving randomly generated num to safe $s7 for storage 
	
	#  Sound/Music Generation
	move $a0, $s7 	#  Tone/Pitch from random num
	li $a1, 500 	#  Duration (fixed value of 500ms) 
	li $a2, 5 	#  Intrument: Piano? 
	li $a3, 127	#  Volume: MAX
	li $v0, 33	#  Iniating playback
	syscall 

	la $a0, resultNumMaestro
	move $a1, $s7
	jal PrintInt
	jal PrintNewLine
	
	b MaestroLoop

 
	PlayString: 
	# subprogram: PlayString
	# purpose: play the characters of a string (e.g., michael), based on their ascii code values.
	# input: $a0 = address of String to play
	# output: none
	# returns: none
	# side-effects: plays the notes corresponding to each character
	lb $s6, 0($a0)		#  Loading the content of the word at memory address $a0 + 0
	beqz $s6, endOfProject	#  If the value is 0, then exit program 
	addi $a0, $a0, 1	#  Add/increment the address by 1
	move $a0, $s6		#  moving the ASCII value at $s6 to $a0 for the subprogram PlayString
	
	#  Prepare the corresponding registers for sounds 
	#  Sound/Music Generation
	#  $a0 is already prepared above
	li $a1, 500 	#  Duration (fixed value of 500ms) 
	li $a2, 5 	#  Intrument: Piano? 
	li $a3, 127	#  Volume: MAX
	li $v0, 33	#  Iniating playback
	syscall 
		
	b PlayString		#  Branching to PlayString to increment loop 
		

.data
promptScaleStart: .asciiz "Please enter starting point for scale (from 0-127): "
promptScaleEnd: .asciiz "Please enter ending point for scale (from 0-127): "
promptScaleTime: .asciiz "How long do you want it to play (in milliseconds): "
maestroBegin: .asciiz "#### BEGIN MAESTRO ####" 
promptMaestroNum: .asciiz "Please enter a number of notes to be played (from 20-107): "
resultNumMaestro: .asciiz "The number for the tone produced is: "
playStringBegin: .asciiz "#### BEGIN PLAYSTRING ####"
promptString: .asciiz "Please enter a string to be used to played: "
input: .space 12 
inputMax: .word 11
.include "utils.asm"
