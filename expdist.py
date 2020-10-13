from bin_strings import *
from math import exp
import numpy as np

def S(t):
   N, R, K, L = 3, 3, 1, 0.1
   o = (N * (R - 1) + 1)
   bound = o - o // 3
   total = 0
   for j in range(bound):
      f = len(gen_strings_rec(N, R, j, K))
      ex = exp(-1 * L * t)
      p = ex ** (o - j) * (1 - ex) ** j
      total += f * p
   return total

def main():
   """
   Main function.

   This function is a driver for the rest of the program.
   """
   x = np.arange(100)
   y = [S(t) for t in x]
   print(y)

if __name__ == '__main__':
   main()
