R.<e12,e13,e14,e15,e16,e21,e23,e24,e25,e26,e31,e32,e34,e35,e36,e41,e42,e43,e46,e45,e51,e52,e53,e54,e56,e61,e62,e63,e64,e65> = PolynomialRing(QQ); R

A_K5 = Matrix([[0,e12,e13,e14,e15],
            [e21,0, e23,e24,e25],
            [e31,e32,0,e34,e35],
            [e41,e42,e43,0,e45],
            [e51,e52,e53,e54,0]])

A_K6 = Matrix([[0,e12,e13,e14,e15,e16],
            [e21,0, e23,e24,e25,e26],
            [e31,e32,0,e34,e35,e36],
            [e41,e42,e43,0,e45,e46],
            [e51,e52,e53,e54,0,e56],
            [e61,e62,e63,e64,e65,0]])
         
def tester(weight_function, polynom, N):
    if abs(polynom(weight_function)) == N:
        return true
    else:
        return false
   
def test_all_weight_functions(A, roots, co_roots, ring):
    c_plus = [0]*A.nrows()
    for k in  range(A.nrows()):
        c_plus[k] = sum(A[:,k])

    B_plus = diagonal_matrix(ring, c_plus)
    
    L_plus = B_plus - A
    L_W = L_plus.delete_columns(roots)
    L_JW = L_W.delete_rows(co_roots)
    
    polynom = L_JW.determinant(); 
    S = PolynomialRing(QQ, polynom.variables())
    polynom = S(polynom)

    weight_functions = Tuples([-1,1], polynom.nvariables() - 1)
    number_of_spanning_forests = polynom.number_of_terms()
    count = 0
    N = len(weight_functions)
    
    for t in weight_functions:
        weight_function = t + [1]
        h = tester(weight_function, polynom, number_of_spanning_forests)
        count = count + 1
        
        if h == true:
            print(weight_function)
            print(roots)
            print(co_roots)
        if count == N:
            print(str(roots) + str(co_roots) + " tested")
        
def test_all_rootsets(A, ring, n):
   c = 0
   possible_roots = [k for k in range(A.nrows())]
   S = Subsets(possible_roots, n)
   T = Subsets(possible_roots, n)
   for roots in S:
       for co_roots in T:
           schnitt = roots.intersection(co_roots)
           if schnitt.is_empty():
               test_all_weight_functions(A, roots, co_roots, ring)
               c = c+1
               print(c)
 
 test_all_rootsets(A_K6, R, 2)
