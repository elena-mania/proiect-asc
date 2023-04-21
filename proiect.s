//
.data 
	nrcerinta: .space 4
	n: .space 4
	m1: .space 40000
	m2: .space 40000
	mres: .space 40000
	vleg: .space 400
	index: .space 4
	aux: .space 4
	index_linie: .space 4
	index_coloana: .space 4
	
	k: .space 4
	i: .space 4
	j: .space 4
	
	end_line: .asciz "\n"
	formscan: .asciz "%d "
	formprint: .asciz "%d\n"

.text

///matrix_mult(m1, m2, mres, n)
matrix_mult:
	push %ebp
	movl %esp,%ebp
	
	pushl %ebx
	pushl %edi
	pushl %esi
	
	movl 20(%ebp),%ecx
	subl $40,%esp
	
	movl $0,-20(%ebp)
loop_1:
	cmp %ecx,-20(%ebp)
	je et_fin
	movl $0,-24(%ebp)
	loop_2:
		cmp %ecx,-24(%ebp)
		je exit_loop2
		
		/// mres=0	
		movl -20(%ebp),%eax
		xorl %edx,%edx
		mull %ecx
		addl -24(%ebp),%eax
			
		movl 16(%ebp),%edi
		movl $0,(%edi,%eax,4)
		
		movl $0,-28(%ebp)
		loop_3:
			cmp %ecx,-28(%ebp)
			je exit_loop3
			
			/// m1[-20(%ebp)][-28(%ebp)]
			
			movl -20(%ebp),%eax
			xorl %edx,%edx
			mull %ecx
			addl -28(%ebp),%eax
			
			movl 8(%ebp),%edi
			movl (%edi,%eax,4),%ebx
			
			/// m2[-28(%ebp)][-24(%ebp)]
	
			movl -28(%ebp),%eax
			xorl %edx,%edx
			mull %ecx
			addl -24(%ebp),%eax
			
			movl 12(%ebp),%edi
			movl (%edi,%eax,4),%esi
			
			movl %ebx,%eax
			xorl %edx,%edx
			mull %esi
			movl %eax,%ebx
			
			///mres[-20(ebp)][-24(ebp)]
			movl -20(%ebp),%eax
			xorl %edx,%edx
			mull %ecx
			addl -24(%ebp),%eax
			
			movl 16(%ebp),%edi
			addl %ebx,(%edi,%eax,4)
			
			incl -28(%ebp)
			jmp loop_3
	exit_loop3:
		incl -24(%ebp)
		jmp loop_2
exit_loop2:
	incl -20(%ebp)
	jmp loop_1	
et_fin:
	addl $40,%esp
	popl %esi
	popl %edi
	popl %ebx
	pop %ebp
	ret	

.global main

main:
	pushl $nrcerinta
	pushl $formscan
	call scanf
	addl $8,%esp
	
	pushl $n
	pushl $formscan
	call scanf
	addl $8,%esp
	
	movl $vleg,%edi
	xorl %ecx,%ecx
//Numarul de legaturi pentru fiecare nod, citite sub forma unui vector
et_loopNrLeg:
	cmp n,%ecx
	je et_continue
	pushl %ecx
	pushl $aux
	pushl $formscan
	call scanf
	addl $8,%esp
	pop %ecx
	
	movl aux,%edx
	movl %edx,(%edi,%ecx,4)
	incl %ecx
	jmp et_loopNrLeg
	
///Legaturile fiecarui nod in parte	
et_continue:
	xorl %ecx,%ecx
	movl $vleg,%edi
	
et_for1:
	cmp n,%ecx
	je et_CERINTA
	
	movl (%edi,%ecx,4),%ebx
	movl $0,index
	et_for2:
		cmp index,%ebx
		je et_cont
		pushl %edi
		pushl %ebx
		pushl %ecx
		pushl $aux
		pushl $formscan
		call scanf
		addl $8,%esp
		popl %ecx
		popl %ebx
		popl %edi
		/// m1[%ecx][aux]=1
			
		movl %ecx,%eax
		xorl %edx,%edx
		mull n
		addl aux,%eax
	
		lea m1,%esi
		movl $1,(%esi,%eax,4)
		
		//copiez m2 pt cerinta 2
		lea m2,%edx
		movl $1,(%edx,%eax,4)
		
		addl $1,index
		jmp et_for2
et_cont:
	incl %ecx
	jmp et_for1
	
//verificarea cerintei
et_CERINTA:
	movl $1,%eax
	cmp %eax,nrcerinta
	je et_cerinta1
	jne et_cerinta2

///cerinta1: afisarea matricei de adiacenta
et_cerinta1:
	movl $0, index_linie
for_linii:
	movl index_linie, %ecx
	cmp %ecx, n
	je et_exit
	movl $0, index_coloana
	for_coloane:
		movl index_coloana, %ecx
		cmp %ecx, n
		je exit_for_coloane
		movl index_linie, %eax
		movl $0, %edx
		mull n
		addl index_coloana, %eax
		lea m1, %edi
		movl (%edi,%eax,4), %ebx
		pushl %ebx
		pushl $formscan
		call printf
		addl $8,%esp
		pushl $0
		call fflush
		addl $4,%esp
		incl index_coloana
		jmp for_coloane
exit_for_coloane:
	pushl $end_line
	call printf
	addl $4,%esp
	pushl $0
	call fflush
	addl $4,%esp
	incl index_linie
	jmp for_linii
	
///cerinta2: afisarea numarului de drumuri de lungime k dintre doua noduri date
et_cerinta2:
	///lungimea
	pushl $k
	pushl $formscan
	call scanf
	addl $8,%esp
	///nodul sursa
	pushl $i
	pushl $formscan
	call scanf
	addl $8,%esp
	///nodul destinatie
	pushl $j
	pushl $formscan
	call scanf
	addl $8,%esp
	
	subl $1,k

	movl $0,index
et_loop3:
	movl index,%ecx
	cmp k,%ecx
	je et_afisare
	push n
	push $mres
	push $m2
	push $m1
	call matrix_mult
	addl $16,%esp
	
	movl $0,index_linie
///mut mres in m2
et_loop1:
	movl index_linie, %ecx
	cmp %ecx,n
	je et_exit_loop1
	
	movl $0,index_coloana
	et_loop2:
		movl index_coloana,%ecx
		cmp %ecx,n
		je et_exit_loop2
		
		movl index_linie,%eax
		xorl %edx,%edx
		mull n
		addl index_coloana, %eax
		
		lea mres, %esi
		lea m2,%edi
		
		movl (%esi,%eax,4),%ebx
		movl %ebx,(%edi,%eax,4)
		
		incl index_coloana
		jmp et_loop2
	et_exit_loop2:
		incl index_linie
		jmp et_loop1
et_exit_loop1:
	incl index
	jmp et_loop3
	
et_afisare:
	movl i,%eax
	movl $0,%edx
	movl n,%ebx
	mul %ebx
	addl j,%eax
	lea mres,%edi
	pushl (%edi,%eax,4)
	pushl $formprint
	call printf
	addl $8,%esp
	pushl $0
	call fflush
	addl $4,%esp	
et_exit:
	movl $1,%eax
	xor %ebx,%ebx
	int $0x80
