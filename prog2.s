#Name: Mahliet Admasu
#login ID: madmasu
#ID number: 119383582
#I pledge on my honor that I have not given or recieved any unauthorized 
#assistance on this assignment.


# -*- mode: text -*-

	.data

number: .word 0
base:   .word 0
result: .word 0

	.text

main:
	li      $sp, 0x7ffffffc    # set up stack pointer

	li      $v0, 5
	syscall		           # read number
	move    $t0, $v0
	sw      $t0, number


	li      $v0, 5
	syscall	                   # read base		  
	move    $t1, $v0
	sw 	$t1, base

	
        sub     $sp, $sp, 8
	lw	$t0, number
	sw	$t0, 4($sp)	   # push argument number onto the stack
 
	lw	$t1, base
	sw	$t1, 8($sp)	   # push argument base onto the stack

	
	jal	num_digits	   # call num_digits

	
	add	$sp, $sp, 8	   # pop argument from the stack

	
	sw	$v0, result	   # store the result

	
	li	$v0, 1
	lw	$a0, result	   # print the result
	syscall

	li	$v0, 11            # print "/n"
	li	$a0, 10
	syscall

	
	li	$v0, 10		   # exit
	syscall
	
num_digits:
			                    # prologue
	sub	$sp, $sp, 12	            # set new stack pointer
	sw	$ra, 12($sp)	            # save return address in stack
	sw	$fp, 8($sp)	            # save old frame pointer
	add	$fp, $sp, 12	            # set new frame pointer


	li	$t0, 0		            # ans=0
	sw 	$t0, 4($sp)		    # store ans

	lw	$t1, 8($fp)	            # load base
	blez  	$t1, less_base		    # branch if base <= 0



	lw	$t2, 4($fp)	            # load n
	beqz	$t2, zero_n		    # branch if n=0

	bltz	$t2, less_n	            # branch if n < 0

        beq 	$t0, 1, base_one            # branch if  base == 1
        j 	not_one_base		    # else jump


less_base:
	li	$t0, -1			    # ans = -1
	sw	$t0, 4($sp)		    # store ans
  	move	$v0, $t0
  	j 	return

zero_n:
	li	$t0, 1			    # ans = 1
	sw	$t0, 4($sp)		    # store ans
 	move	$v0, $t0
	j	return	

less_n:
	neg	$t2, $t2		    # n = -n
	sw	$t2, 4($fp)		    # store n
  	lw 	$t0, 8($fp)		    # load base
  	beq 	$t0, 1, base_one	    # branch if base=1
  	j 	not_one_base		    # else jump 
  

not_one_base:
	lw	$t2, 4($fp)		    # load n
  	lw  	$t1, 8($fp)		    # load base

	lw	$t0, 4($sp)		    # load ans
	add	$t0, $t0, 1		    # add 1 to ans
	sw	$t0, 4($sp)		    # store ans

	
	div	$t2, $t2, $t1	            # divide n by base
	sw	$t2, 4($fp)		    # store n
  	bnez 	$t2, not_one_base	    # branch if n!=0
  	move	$v0, $t0
  	j 	return

return:				# epilogue
	lw	$ra, 12($sp)    # load return address from stack
	lw	$fp, 8($sp)	# restore old frame pointer from stack
	add	$sp, $sp, 12	# reset stack pointer
	jr	$ra		# return to caller using saved return address
 
base_one:
	lw	$t0, 4($fp)	# load base
    	sw    	$t0, 4($sp)	# store base
    	move	$v0, $t0 
    	j 	return



