import unittest
from bin_strings import gen_strings_it

#How many binary strings of length N that do not have r consecutive ones. 
#legal: 1.Any run of r 1's does not begin and end on index congruent 0 mod(r-1)
#2. No run of more than R consecutive 1's.
#Goal: Generate legal strings and count them. 
class TestBinstrings(unittest.TestCase):
   def test_N2R2(self):
      expectedResult = [(1,0,0), (1,0,1), (0,0,0), (0,0,1),(0,1,0)]
      for tup in expectedResult:
         self.assertIn(tup , gen_strings_it(2,2,'x'))
      self.assertEqual(len(gen_strings_it(2,2,'x')),5)

   def test_N2R3(self):
      badResults = [(0, 0, 1, 1, 1), (0, 1, 1, 1, 1), ( 1, 0, 1, 1, 1), (1, 1, 1, 0, 0), (1, 1, 1, 0, 1), (1, 1, 1, 1, 0), (1, 1, 1, 1, 1) ]
      self.assertEqual(len(gen_strings_it(2,3,'x')), 25)
      for tup in badResults:
         self.assertNotIn(tup, gen_strings_it(2,3,'x'))

   def test_N3R2(self):
      badResults = [(0,0,1,1), (0,1,1,0), (0,1,1,1), (1,0,1,1), (1,1,0,0), (1,1,0,1) ,(1,1,1,0) , (1,1,1,1)]
      for tup in badResults:
         self.assertNotIn(tup,gen_strings_it(3,2,'x'))

   def test_N3R3(self):
      self.assertEqual(len(gen_strings_it(3,3,'x')),89)

   def test_N4R2(self):
      expectedResults = [(0,0,0,0,0), (0,0,0,0,1), (0,0,0,1,0) , (0,0,1,0,0),(0,0,1,0,1),(0,1,0,0,0),(0,1,0,0,1),(0,1,0,1,0), (1,0,0,0,0), (1,0,0,0,1),(1,0,0,1,0), (1,0,1,0,0) , (1,0,1,0,1)]
      for tup in expectedResults:
         self.assertIn(tup,gen_strings_it(4,2,'x'))
      self.assertEqual(len(gen_strings_it(4,2,'x')),13)


if __name__ == '__main__':
   unittest.main()
