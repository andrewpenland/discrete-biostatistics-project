#!/usr/bin/env/python3

import unittest as ut
from binstrings import gen_strings_it as gsi, gen_strings_rec as gsr
from binstrings import r3k1, anyr_k1, r3_anyk, anyr_anyk

SIZE = 5 #will test all values up to SIZE for size
UNIF = 5 #will test all values up to UNIF for uniformity
ORD = SIZE * (UNIF - 1) + 1 #order of a size SIZE, UNIF uniform hypergraph

class TestBinstrings(ut.TestCase):

#   def test_gen_strings(self):
#      for n in range(1, SIZE + 1):
#         for r in range(2, UNIF + 1):
#            for j in range(0, ORD + 1):
#               for k in range(1, n + 1):
#                  #print("IN TEST SUITE: n={}, r= {}, j={}, k={}".format(n, r, j, k))
#                  self.assertEqual(len(gsr(n, r, j, k)), len(gsi(n, r, j, k)))

#   def test_r3k1(self):
#      for n in range(1, SIZE + 1):
#         for j in range(ORD + 1):
#            #print("IN TEST SUITE: n={}, j={}".format(n, j))
#            self.assertEqual(len(gsr(n, 3, j, 1)), r3k1(n, j))

   def test_anyr_k1(self):
      for n in range(1, SIZE + 1):
         for r in range(3, UNIF):
            for j in range(ORD + 1):
               print("IN TEST SUITE: n={}, r={}, j={}".format(n, r, j))
               self.assertEqual(len(gsr(n, r, j, 1)), anyr_k1(n, r, j))

#   def test_r3_anyk(self):
#      for n in range(1, SIZE + 1):
#         for j in range(ORD + 1):
#            for k in range(2, n):
#               #print("IN TEST SUITE: n={}, j={}, k={}".format(n, j, k))
#               self.assertEqual(len(gsr(n, 3, j, k)), r3_anyk(n, j, k))

#   def test_anyr_anyk(self):
#      for n in range(1, SIZE + 1):
#         for r in range(3, UNIF + 1):
#            for j in range(ORD + 1):
#               for k in range(2, n):
#                  print("IN TEST SUITE: n={}, r={}, j={}, k={}".format(n, r, j, k))
#                  self.assertEqual(len(gsr(n, r, j, k)), anyr_anyk(n, r, j, k))

if __name__ == '__main__':
   ut.main()

