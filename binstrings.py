#!/bin/python3

# find all bin strs of length 2n+1
# start indexing at 0
# no more than 3 consecutive 1s
# has exactly k 1s
# runs of 3 must start on an odd index

from itertools import *

for i in range(10):
    combs = product([0,1], repeat=2*i+1)
    ks = [0 for i in range(2*i + 2)]
    
    for comb in combs:
        i_in_a_row = 0
        bad = False
        ind = 0
        for element in comb:
            if element == 1:
                i_in_a_row += 1
            elif element == 0:
                i_in_a_row = 0
            
            if (i_in_a_row == 3 and ind % 2 == 0) or i_in_a_row > 3:
                bad = True
                break # we don't need to keep testing at this point
            ind += 1
        
        if not bad:
            ks[sum(comb)] += 1        


    print("n = ", i)
    print("count of tuples with k=index is ", ks)
    print()
