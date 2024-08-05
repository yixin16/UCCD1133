.data
welcome:    .asciiz "Welcome to our Program."

#------------------------------Show menu and prompt input--------------------------------------------#

options:    .asciiz "\n1: (A AND B) OR C\n2: (A OR B) AND C\n3: A AND (B OR C)\n4: (A + B) - C\n5: (A * B) + C\n6: (A - B) * C\n-1: quit\n"  #show menu
mainprompt: .asciiz "Please enter the equation: \n\n"
eq1:        .asciiz "Here is (A AND B) OR C\n\nEnter three values:\n"
eq2:        .asciiz "Here is (A OR B) AND C\n\nEnter three values:\n"
eq3:        .asciiz "Here is A AND (B OR C)\n\nEnter three values:\n"
eq4:        .asciiz "Here is (A + B) - C\n\nEnter three values:\n"
eq5:        .asciiz "Here is (A * B) + C\n\nEnter three values:\n"
eq6:        .asciiz "Here is (A - B) * C\n\nEnter three values:\n"

# ----------------Message to prompt the user to input each value-----------------------------#

prompt_A:   .asciiz "Enter value A: "
prompt_B:   .asciiz "Enter value B: "
prompt_C:   .asciiz "Enter value C: "

#-------------------------------------#
result:     .asciiz "The result is: "
newline:    .asciiz "\n"
goodbye:    .asciiz "Thanks for using our program. Goodbye!"

.text
.globl main

# -------------------Function to get A ------------------------#
getA:
    # Display a message before prompting for user input
    li $v0, 4
    la $a0, prompt_A
    syscall

    # Prompt for user input and store in $v0
    li $v0, 5
    syscall

    jr $ra

# -------------------Function to get B ------------------------#
getB:
    # Display a message before prompting for user input
    li $v0, 4
    la $a0, prompt_B
    syscall

    # Prompt for user input and store in $v0
    li $v0, 5
    syscall

    jr $ra

# -------------------Function to get C ------------------------#
getC:
    # Display a message before prompting for user input
    li $v0, 4
    la $a0, prompt_C
    syscall

    # Prompt for user input and store in $v0
    li $v0, 5
    syscall

    jr $ra

main:
    # -----------------Print Welcome message -----------#
    li $v0, 4   #'li': load immediate,  'v0': system call code before making a system call
    la $a0, welcome
    syscall  #perform the operation

while:
    # -------------- Print option and prompt ------------#

    li $v0, 4   #load the system call code '4' into register v0
    la $a0, options  #load address of the options prompted into a0.
    syscall  #system call instruction is used to perform the operation specified in v0. 

    # Prompt for user input
    li $v0, 4
    la $a0, mainprompt
    syscall

    # Get user input (equation choice)
    li $v0, 5  #system call code=5(read integer input)
    syscall	#triggers a system cal based on the value in v0,=5
    move $t0, $v0

#------------------------------------- Branch by input options -----------------------------------------#
    # Check for exit (-1). (if option==1 exit;)
    beq $t0, -1, exit

    #----------else if----------#
    beq $t0, 1, performEq1
    beq $t0, 2, performEq2
    beq $t0, 3, performEq3
    beq $t0, 4, performEq4
    beq $t0, 5, performEq5
    beq $t0, 6, performEq6

   #---else (invalid input, loop again) ---#
    j while

#---------------End of main -------------------------#


#-------------Equation (1) (A AND B) OR C---------------#
performEq1:
    # Print equation prompt with instructions
    li $v0, 4
    la $a0, eq1
    syscall

    # Get A value from user (regular whole numbers)
    jal getA
    move $s1, $v0 # A

    # Get B value from user (regular whole numbers)
    jal getB
    move $s2, $v0 # B

    # Get C value from user (regular whole numbers)
    jal getC
    move $s3, $v0 # C

    # Calculate (A AND B) OR C
    and $t1, $s1, $s2
    or $t2, $t1, $s3

    # Print the result
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    j while

#-------------Equation (2) (A OR B) AND C---------------#
performEq2:
    # Print equation prompt with instructions
    li $v0, 4
    la $a0, eq2
    syscall

    # Get A value from user (regular whole numbers)
    jal getA
    move $s1, $v0 # A

    # Get B value from user (regular whole numbers)
    jal getB
    move $s2, $v0 # B

    # Get C value from user (regular whole numbers)
    jal getC
    move $s3, $v0 # C

    # Calculate (A OR B) AND C
    or $t1, $s1, $s2
    and $t2, $t1, $s3

    # Print the result
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    j while

#-------------Equation (3) A AND (B OR C)---------------#
performEq3:
    # Print equation prompt with instructions
    li $v0, 4
    la $a0, eq3
    syscall

    # Get A value from user (regular whole numbers)
    jal getA
    move $s1, $v0 # A

    # Get B value from user (regular whole numbers)
    jal getB
    move $s2, $v0 # B

    # Get C value from user (regular whole numbers)
    jal getC
    move $s3, $v0 # C

    # Calculate A AND (B OR C)
    or $t1, $s2, $s3
    and $t2, $s1, $t1

    # Print the result
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    j while

#-------------Equation (4) (A + B ) - C ---------------#
performEq4:
    # Print equation prompt
    li $v0, 4
    la $a0, eq4
    syscall

    # Get A value from user
    jal getA
    move $s1, $v0 # A

    # Get B value from user
    jal getB
    move $s2, $v0 # B

    # Get C value from user
    jal getC
    move $s3, $v0 # C

    # Calculate (A + B) - C
    add $t1, $s1, $s2
    sub $t2, $t1, $s3

    # Print the result
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    j while

#-------------Equation (5) (A * B) + C---------------#
performEq5:
    # Print equation prompt
    li $v0, 4
    la $a0, eq5
    syscall

    # Get A value from user
    jal getA
    move $s1, $v0 # A

    # Get B value from user
    jal getB
    move $s2, $v0 # B

    # Get C value from user
    jal getC
    move $s3, $v0 # C

    # Calculate (A * B) + C
    mul $t1, $s1, $s2
    add $t2, $t1, $s3

    # Print the result
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    j while

#-------------Equation (6) (A - B) * C---------------#
performEq6:
    # Print equation prompt
    li $v0, 4
    la $a0, eq6
    syscall

    # Get A value from user
    jal getA
    move $s1, $v0 # A

    # Get B value from user
    jal getB
    move $s2, $v0 # B

    # Get C value from user
    jal getC
    move $s3, $v0 # C

    # Calculate (A - B) * C
    sub $t1, $s1, $s2
    mul $t2, $t1, $s3

    # Print the result
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    j while

# Exit and print goodbye message
exit:
    # Print goodbye message and exit
    li $v0, 4
    la $a0, goodbye
    syscall

    # Exit program
    li $v0, 10
    syscall