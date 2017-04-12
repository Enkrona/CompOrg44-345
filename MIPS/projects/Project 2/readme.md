Project 2
Objectives: To give you an opportunity to write a musical masterpiece (and get some more
practice with subroutines, loops, etc.)
Background: MIPS comes with some helpful syscalls to play music and generate random
numbers.
Instructions:
In this project, you will write and invoke 3 subprograms: Scale, Maestro, and PlayString
# subprogram: Scale
# purpose: plays a scale of notes from start to end, each note lasting duration milliseconds.
# input: $a0 = start, $a1 = end, $a2 = duration
# output: none
# returns: none
# side-effects: plays notes from $a0 to $a1 inclusive, each of time $a2
# subprogram: Maestro
# purpose: play a random series of notes (each between 20-107). Each note will last 500 ms.
# input: $a0 = # of notes
# output: prints the # of each (randomly generated) note as it is played
# returns: none
# side-effects: plays $a0 notes, chosen at random between 20-107
# subprogram: PlayString
# purpose: play the characters of a string (e.g., michael), based on their ascii code values.
# input: $a0 = address of String to play
# output: none
# returns: none
# side-effects: plays the notes corresponding to each character
All inputs to these subprograms will come from the console (with appropriate prompts).
