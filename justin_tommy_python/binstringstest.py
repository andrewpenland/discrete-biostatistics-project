import unittest as ut
from binstrings import gen_strings_it as gsi
from binstrings import gen_strings_rec as gsr
from binstrings import r3k1
from binstrings import anyr_k1
from binstrings import r3_anyk
from binstrings import anyr_anyk

DEPTH = 4 #will test all possible values <= DEPTH for size and uniformity
O = DEPTH**2 - DEPTH + 1 #order of a size DEPTH, DEPTH uniform hypergraph
O3 = 2 * DEPTH + 1 #order of a size DEPTH, 3 uniform hypergraph

class TestBinstrings(ut.TestCase):
   """
   def test_gen_strings(self):
      for n in range(1, DEPTH + 1):
         for r in range(2, DEPTH + 1):
            for j in range(0, O + 1):
               for k in range(1, n + 1):
                  self.assertEqual(len(gsr(n, r, j, k)), len(gsi(n, r, j, k)))

   def test_r3k1(self):
      for n in range(1, DEPTH + 1):
         for j in range(0, O3 + 1):
            #print("n =", n, "j =", j, "r3k1 =", r3k1(n, j))
            self.assertEqual(len(gsr(n, 3, j, 1)), r3k1(n, j))
   """
   def test_anyr_k1(self):
      for n in range(1, DEPTH + 1):
         for r in range(3, DEPTH + 1):
            for j in range(0, O + 1):
               print("n =", n, "r =", r, "j =", j, "anyr_k1 =", anyr_k1(n, r, j))
               self.assertEqual(len(gsr(n, r, j, 1)), anyr_k1(n, r, j))
   """
   def test_r3_anyk(self):
      for n in range(1, DEPTH + 1):
         for j in range(0, O3 + 1):
            for k in range(1, n + 1):
               self.assertEqual(len(gsr(n, 3, j, k)), r3_anyk(n, j, k))

   def test_anyr_anyk(self):
      for n in range(1, DEPTH + 1):
         for r in range(2, DEPTH + 1):
            for j in range(0, O + 1):
               for k in range(1, n + 1):
                  self.assertEqual(len(gsr(n, r, j, k)), anyr_anyk(n, r, j, k))
   """
if __name__ == '__main__':
   ut.main()

