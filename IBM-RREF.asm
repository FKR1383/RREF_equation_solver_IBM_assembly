.data
    print_int_format:  .asciz "%d"
    print_uint_format: .asciz "%u"
    read_int_format:   .asciz "%d"
    read_uint_format:  .asciz "%u"
    print_float_format: .asciz "%lf"
    read_float_format:   .asciz "%lf"
    tmp_float: .zero 8
    tmp_row:   .zero 16000
    matrix: .zero 8000000
    n: .zero 8
    m: .zero 8
    row_index1: .zero 8
    row_index2: .zero 8
    row_tmp_index: .zero 8
    lower_bound: .double -0.00001
    upper_bound: .double 0.00001
    pivot_element: .double 0
    message: .asciz "Impossible"
    null_variable: .zero 8
    reg12: .zero 8
    reg13: .zero 8

.text
.globl print_int
.globl print_char
.globl print_nl
.globl print_string
.globl read_int
.globl read_uint
.globl read_char
.globl asm_main
.globl read_float
.globl print_float

print_int:
	stg     %r14, -4(%r15)
    lay     %r15, -8(%r15)
    lr      %r3,  %r2
    larl    %r2,  print_int_format
    brasl   %r14, printf
	lay     %r15, 8(%r15)
	lg      %r14, -4(%r15)
    br      %r14


print_uint:
	stg     %r14, -4(%r15)
    lay     %r15, -8(%r15)
    lr      %r3,  %r2
    larl    %r2,  print_uint_format
    brasl   %r14, printf
	lay     %r15, 8(%r15)
	lg      %r14, -4(%r15)
    br      %r14


print_char:
	stg     %r14, -4(%r15)
    lay     %r15, -8(%r15)
    brasl   %r14, putchar
	lay     %r15, 8(%r15)
	lg      %r14, -4(%r15)
    br      %r14

print_space:
	stg     %r14, -4(%r15)
    lay     %r15, -8(%r15)
    la      %r2,  32
    brasl   %r14, putchar
	lay     %r15, 8(%r15)
	lg      %r14, -4(%r15)
    br      %r14

print_nl:
	stg     %r14, -4(%r15)
    lay     %r15, -8(%r15)
	la      %r2,  10
    brasl   %r14, putchar
	lay     %r15, 8(%r15)
	lg      %r14, -4(%r15)
    br      %r14


print_string:
	stg     %r14, -4(%r15)
    lay     %r15, -8(%r15)
    brasl   %r14, puts
	lay     %r15, 8(%r15)
	lg      %r14, -4(%r15)
    br      %r14


read_int:
	stg     %r14, -4(%r15)
    lay     %r15, -8(%r15)
    lay     %r3,  0(%r15)
    larl    %r2,  read_int_format
    brasl   %r14, scanf
	l       %r2,  0(%r15)
	lay     %r15, 8(%r15)
	lg      %r14, -4(%r15)
    br      %r14


read_uint:
	stg     %r14, -4(%r15)
    lay     %r15, -8(%r15)
    lay     %r3,  0(%r15)
    larl    %r2,  read_uint_format
    brasl   %r14, scanf
	l       %r2,  0(%r15)
	lay     %r15, 8(%r15)
	lg      %r14, -4(%r15)


read_char:
	stg     %r14, -4(%r15)
    lay     %r15, -8(%r15)
    brasl   %r14, getchar
	lay     %r15, 8(%r15)
	lg      %r14, -4(%r15)
    br      %r14
read_float:
	stg     %r14, -8(%r15)
    lay     %r15, -168(%r15)
    lay     %r3,  0(%r15)
    larl    %r2,  read_float_format
    brasl   %r14, scanf
    l       %f0,  0(%r15)
	lay     %r15, 168(%r15)
	lg      %r14, -8(%r15)
	br      %r14

print_float:
	stg     %r14, -8(%r15)
    lay     %r15, -168(%r15)
    lr      %r3, %f0
    larl    %r2,  print_float_format
    brasl   %r14, printf
	lay     %r15, 168(%r15)
	lg      %r14, -8(%r15)
    br      %r14

get_input:
	stg     %r14, -8(%r15)
    lay     %r15, -168(%r15)
    brasl   %r14, read_int
    larl    %r6, n
    st      %r2, 0(%r6)
    lr      %r7, %r2
    l       %r2, 0(%r6)
    la      %r3, 1
    ar      %r7, %r3
    larl    %r6, m
    st      %r7, 0(%r6)
    l       %r2, 0(%r6)
    la      %r6, 0
    la      %r8, 0
    larl    %r6, n
    l       %r9, 0(%r6)
    la      %r8, 0
    larl    %r6, m
    l       %r7, 0(%r6)
    mr      %r8, %r7
    la      %r7, 8
    mr      %r8, %r7
    la      %r7, 0
get_input_loop:
    larl    %r6, matrix
    ar      %r6, %r7
    brasl   %r14, read_float
    ste      %f0, 0(%r6)
    la      %r8, 8
    ar      %r7, %r8
    cr      %r7, %r9
    jl      get_input_loop


	lay     %r15, 168(%r15)
	lg      %r14, -8(%r15)
    br      %r14
print_output:
	stg     %r14, -8(%r15)
    lay     %r15, -168(%r15)
    larl    %r6, n
    l       %r9, 0(%r6)
    la      %r8, 0
    larl    %r6, m
    l       %r7, 0(%r6)
    mr      %r8, %r7
    la      %r7, 8
    mr      %r8, %r7
    la      %r7, 0
    la      %r7, 8
    larl    %r6, m
    l       %r13, 0(%r6)
    la      %r12 , 0
    mr      %r12, %r7
    lr      %r7, %r13

print_output_loop:
    larl    %r6, matrix
    la      %r8, 8
    ar      %r6, %r7
    sr      %r6, %r8
    le      %f0, 0(%r6)
    brasl   %r14, print_float
    brasl   %r14, print_space
    ar      %r7, %r13
    cr      %r7, %r9
    jle      print_output_loop


	lay     %r15, 168(%r15)
	lg      %r14, -8(%r15)
    br      %r14

swap_two_rows:
    stg     %r14, -8(%r15)
    lay     %r15, -168(%r15)
    larl    %r6, m
    l       %r7, 0(%r6)
    larl    %r6, row_index1
    l       %r9, 0(%r6)
    xr      %r8, %r8
    mr      %r8, %r7
    la      %r7, 8
    xr      %r8, %r8
    mr      %r8, %r7
    larl    %r6, m
    l       %r7, 0(%r6)
    larl    %r6, row_index2
    l       %r13, 0(%r6)
    xr      %r12, %r12
    mr      %r12, %r7
    la      %r7, 8
    xr      %r12, %r12
    mr      %r12, %r7
    larl    %r6, m
    l       %r7, 0(%r6)
    xr      %r6, %r6
loop_for_swap:
    larl    %r8, matrix
    ar      %r8, %r9
    le      %f0, 0(%r8)
    larl    %r8, tmp_float
    ste     %f0, 0(%r8)
    larl    %r8, matrix
    ar      %r8, %r13
    le      %f0, 0(%r8)
    larl    %r8, matrix
    ar      %r8, %r9
    ste     %f0, 0(%r8)
    larl    %r8, tmp_float
    le      %f0, 0(%r8)
    larl    %r8, matrix
    ar      %r8, %r13
    ste     %f0, 0(%r8)
    la      %r8, 8
    ar      %r9, %r8
    ar      %r13, %r8
    la      %r8, 1
    ar      %r6, %r8
    cr      %r6, %r7
    jl      loop_for_swap
    lay     %r15, 168(%r15)
    lg      %r14, -8(%r15)
    br      %r14


subtract_row_from_tmp_row:
    stg     %r14, -8(%r15)
    lay     %r15, -168(%r15)
    larl    %r6, m
    l       %r7, 0(%r6)
    larl    %r6, row_index1
    l       %r9, 0(%r6)
    xr      %r8, %r8
    mr      %r8, %r7
    la      %r7, 8
    xr      %r8, %r8
    mr      %r8, %r7 # r9 is the index
    larl    %r6, m
    l       %r7, 0(%r6)
    xr      %r6, %r6
    la      %r8, 8
    mr      %r6, %r8
    xr      %r6, %r6
loop_for_sub:
    larl    %r8, matrix
    ar      %r8, %r9
    le      %f0, 0(%r8)
    larl    %r8, tmp_row
    ar      %r8, %r6
    sdb     %f0, 0(%r8)
    larl    %r8, matrix
    ar      %r8, %r9
    ste     %f0, 0(%r8)
    la      %r8, 8
    ar      %r9, %r8
    la      %r8, 8
    ar      %r6, %r8
    cr      %r6, %r7
    jl      loop_for_sub
    lay     %r15, 168(%r15)
    lg      %r14, -8(%r15)
    br      %r14

multiply_pivot_to_row:
    stg     %r14, -8(%r15)
    lay     %r15, -168(%r15)
    larl    %r6, m
    l       %r7, 0(%r6)
    larl    %r6, row_index1
    l       %r9, 0(%r6)
    xr      %r8, %r8
    mr      %r8, %r7
    la      %r7, 8
    xr      %r8, %r8
    mr      %r8, %r7 # r9 is the index
    larl    %r6, m
    l       %r7, 0(%r6)
    xr      %r6, %r6
    la      %r8, 8
    mr      %r6, %r8
    xr      %r6, %r6
loop_for_mul:
    larl    %r8, matrix
    ar      %r8, %r9
    le      %f0, 0(%r8)
    larl    %r8, pivot_element
    mdb     %f0, 0(%r8)
    larl    %r8, tmp_row
    ar      %r8, %r6
    ste     %f0, 0(%r8)
    la      %r8, 8
    ar      %r9, %r8
    la      %r8, 8
    ar      %r6, %r8
    cr      %r6, %r7
    jl      loop_for_mul
    lay     %r15, 168(%r15)
    lg      %r14, -8(%r15)
    br      %r14

divide_row:
    stg     %r14, -8(%r15)
    lay     %r15, -168(%r15)
    larl    %r6,  row_index1
    l       %r6,  0(%r6) # r6 = row_index1
    larl    %r7,  row_index2
    l       %r7 ,  0(%r7) # r7 = row_index2
    larl    %r8,  row_tmp_index
    st      %r7,  0(%r8) # row_tmp_index = row_index2
    larl    %r7,  row_index2
    st      %r6,  0(%r7)
    brasl   %r14, save_reg
    brasl   %r14, find_pivot_element_in_row
    brasl   %r14, load_reg
    larl    %r8,  row_tmp_index
    l       %r7,  0(%r8)
    larl    %r8,  row_index2
    st      %r7,   0(%r8)
    larl    %r6, m
    l       %r7, 0(%r6)
    larl    %r6, row_index1
    l       %r9, 0(%r6)
    xr      %r8, %r8
    mr      %r8, %r7
    la      %r7, 8
    xr      %r8, %r8
    mr      %r8, %r7 # r9 is the index
    larl    %r6, m
    l       %r7, 0(%r6)
    xr      %r6, %r6
    la      %r8, 8
    mr      %r6, %r8
    xr      %r6, %r6
loop_for_divide:
    larl    %r8, matrix
    ar      %r8, %r9
    le      %f0, 0(%r8)
    larl    %r8, pivot_element
    ddb     %f0, 0(%r8)
    larl    %r8, matrix
    ar      %r8, %r9
    ste     %f0, 0(%r8)
    la      %r8, 8
    ar      %r9, %r8
    la      %r8, 8
    ar      %r6, %r8
    cr      %r6, %r7
    jl      loop_for_divide
    lay     %r15, 168(%r15)
    lg      %r14, -8(%r15)
    br      %r14

find_pivot_element_in_row:
    stg     %r14, -8(%r15)
    lay     %r15, -168(%r15)
    larl    %r6, row_index1
    l       %r7, 0(%r6)
    larl    %r6, row_index2
    l       %r8, 0(%r6)
    xr      %r6, %r6
    larl    %r6, m
    l       %r9, 0(%r6)
    mr      %r6, %r9
    ar      %r7, %r8
    xr      %r6, %r6
    la      %r8, 8
    mr      %r6, %r8
    larl    %r6, matrix
    ar      %r6, %r7
    le      %f0, 0(%r6)
    larl    %r6, pivot_element
    ste     %f0, 0(%r6)
    lay     %r15, 168(%r15)
    lg      %r14, -8(%r15)
    br      %r14

save_reg:
    stg     %r14, -8(%r15)
    lay     %r15, -168(%r15)
    larl    %r6, reg12
    st      %r12, 0(%r6)
    larl    %r6, reg13
    st      %r13, 0(%r6)
    lay     %r15, 168(%r15)
    lg      %r14, -8(%r15)
    br      %r14

load_reg:
    stg     %r14, -8(%r15)
    lay     %r15, -168(%r15)
    larl    %r6, reg12
    l      %r12, 0(%r6)
    larl    %r6, reg13
    l      %r13, 0(%r6)
    lay     %r15, 168(%r15)
    lg      %r14, -8(%r15)
    br      %r14

rref:
    stg     %r14, -8(%r15)
    lay     %r15, -168(%r15)
    la      %r12, 0
rref2_main_loop:
    larl    %r6, row_index1
    st      %r12, 0(%r6)
    larl    %r6, row_index2
    st      %r12, 0(%r6)
    brasl   %r14, save_reg
    brasl   %r14, find_pivot_element_in_row
    brasl   %r14, load_reg
    larl    %r6, lower_bound
    le      %f0, 0(%r6)
    larl    %r6, pivot_element
    kdb     %f0, 0(%r6)
    jh      suitable_row_found
    
    larl    %r6, upper_bound
    le      %f0, 0(%r6)
    larl    %r6, pivot_element
    kdb     %f0, 0(%r6)
    jl      suitable_row_found
    j       find_suitable_row
    
suitable_row_found:
    larl    %r6, row_index1
    st      %r12, 0(%r6)
    
    larl    %r6, row_index2
    st      %r12, 0(%r6)
    
    brasl   %r14, save_reg
    brasl   %r14, find_pivot_element_in_row
    brasl   %r14, load_reg
    
    larl    %r6, row_index1
    st      %r12, 0(%r6)
    
    brasl   %r14, save_reg
    brasl   %r14, divide_row
    brasl   %r14, load_reg
    
    xr      %r13, %r13
for_loop_to_clear_rows:
    larl    %r6, n
    c       %r13, 0(%r6)
    jh      ending_rows
    je      ending_rows
    cr      %r13, %r12
    je      skip_this_row
    
    larl    %r6, row_index1
    st      %r13, 0(%r6)
    
    larl    %r6, row_index2
    st      %r12, 0(%r6)
    
    brasl   %r14, save_reg
    brasl   %r14, find_pivot_element_in_row
    brasl   %r14, load_reg
    
    larl    %r6, row_index1
    st      %r12, 0(%r6)
    
    brasl   %r14, save_reg
    brasl   %r14, multiply_pivot_to_row
    brasl   %r14, load_reg

    larl    %r6, row_index1
    st      %r13, 0(%r6)
     
    brasl   %r14, save_reg
    brasl   %r14, subtract_row_from_tmp_row
    brasl   %r14, load_reg  
skip_this_row:
    la      %r8, 1
    ar      %r13, %r8
    
    larl    %r6, n
    c       %r13, 0(%r6)
    jl      for_loop_to_clear_rows
    
ending_rows:
    la      %r8, 1
    ar      %r12, %r8
    
    larl    %r6, n
    c       %r12, 0(%r6)
    jl      rref2_main_loop
    brasl   %r14, save_reg
    brasl   %r14, print_output
    brasl   %r14, load_reg
    lay     %r15, 168(%r15)
    lg      %r14, -8(%r15)
    br      %r14     
find_suitable_row:
    lr      %r13, %r12
    la      %r8, 1
    ar      %r13, %r8
    
    larl    %r6, n
    c       %r13, 0(%r6)
    
    je impossible
for_loop_to_find_suitable_row:

    larl    %r6, row_index1
    st      %r13, 0(%r6)
    
    larl    %r6, row_index2
    st      %r12, 0(%r6)
    
    brasl   %r14, save_reg
    brasl   %r14, find_pivot_element_in_row
    brasl   %r14, load_reg
    
    larl    %r6, lower_bound
    le      %f0, 0(%r6)
    larl    %r6, pivot_element
    kdb     %f0, 0(%r6)
    jh      is_suitable_row
    
    larl    %r6, upper_bound
    le      %f0, 0(%r6)
    larl    %r6, pivot_element
    kdb     %f0, 0(%r6)
    jl      is_suitable_row
    j       isnt_suitable_row
is_suitable_row:
    larl    %r6, row_index1
    st      %r13, 0(%r6)
    
    larl    %r6, row_index2
    st      %r12, 0(%r6)
     
    brasl   %r14, save_reg
    brasl   %r14, swap_two_rows
    brasl   %r14, load_reg
    
    j suitable_row_found
isnt_suitable_row:
    la      %r8, 1
    ar      %r13, %r8
    larl    %r6, n
    c       %r13, 0(%r6)
    jl      for_loop_to_find_suitable_row
impossible:
    larl    %r2, message
    brasl   %r14, save_reg
    brasl   %r14, print_string
    brasl   %r14, load_reg

    lay     %r15, 168(%r15)
    lg      %r14, -8(%r15)
    br      %r14
    
       
    
    
    
    
    
    lay     %r15, 168(%r15)
    lg      %r14, -8(%r15)
    br      %r14



asm_main:
	stg     %r14, -4(%r15)
    lay     %r15, -8(%r15)

    brasl   %r14, save_reg
    brasl   %r14, get_input
    brasl   %r14, load_reg

    brasl   %r14, save_reg
    brasl   %r14, rref
    brasl   %r14, load_reg

    lay     %r15, 8(%r15)
	lg      %r14, -4(%r15)
    br      %r14




