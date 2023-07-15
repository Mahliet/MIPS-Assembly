#Name: Mahliet Admasu
#login ID: madmasu
#ID number: 119383582
#I pledge on my honor that I have not given or recieved any unauthorized 
#assistance on this assignment.


# -*- mode: text -*-
	
	.data

l1:		.word 0
w1:		.word 0
l2:		.word 0
w2:		.word 0
rect1:		.word 0
rect2:		.word 0
result:		.word 0

	.text

main: 
	li	$v0, 5
	syscall				# read l1
	move 	$t1, $v0
	sw  	$t1, l1			# store l1

	li 	$v0, 5
	syscall				# read  w1
	move 	$t2, $v0
	sw  	$t2, w1			# store w1

	li 	$v0, 5
	syscall				# read  l2
	move 	$t3, $v0
	sw  	$t3, l2			# store l2

	li 	$v0, 5
	syscall				# read  w2
	move 	$t4, $v0
	sw  	$t4, w2			# store w2

	
	bltz	$t1 ifs			# branch to ifs if l1 < 0
	bltz 	$t2 ifs		  	# branch to ifs if w1 < 0
	bltz 	$t3 ifs		  	# branch to ifs if l2 < 0
	bltz 	$t4 ifs		  	# branch to ifs if w2 < 0

	mul 	$t5, $t1, $t2	  	# rect1 = l1*w1
	sw  	$t5, rect1	  	# store $t5 

	mul 	$t6, $t3, $t4	  	# rect2 = l2*w2
	sw  	$t6, rect2	  	# store $t6

	blt 	$t5, $t6, less	  	# branch if rect1 < rect2
	bgt 	$t5, $t6, greater	# branch if rect1 > rect2
	j 	exit 	  		# jump to exit

less:
	li	$t0, -1			# result = -1	
	sw 	$t0, result		# store $t0
	j 	exit

greater:
	li	$t0, 1			# result = 1
	sw 	$t0, result		# store $t0
	j 	exit

ifs:
	li	$t0, -2			# result = -2
	sw 	$t0, result		# store $t0
	
exit:
	li	$v0, 1
	lw 	$a0, result	        # print result
	syscall

	li	$v0, 11			# print "/n"
	li 	$a0, 10
	syscall

	li	$v0, 10			# exit
	syscall


	

