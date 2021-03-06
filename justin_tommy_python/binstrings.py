#!/usr/bin/env/python3

from itertools import product
from math import ceil, factorial as fact

def gen_comb(n, r, j):
   """
   Generates all posible binary strings of a given size with a given number of ones.

   :param: n: The size of the hypergraph.
   :param: r: The uniformity of the hypergraph.
   :param: j: The amount of 1 valued vertices.
   """
   # Order of a size n, r uniform hypergraph.
   o = (n * (r - 1) + 1)
   binstrings = list(product([0, 1], repeat=o))
   binstrings = [x for x in binstrings if x.count(1) is j]
   return binstrings

def is_valid(bin_string, n, r, k):
   """
   Checks whether a given binary string satisfies our conditions.

   :param: bin_string: The binary string to be checked.
   :param: n: The size of the hypergraph.
   :param: r: The uniformity of the hypergraph.
   :param: k: The size of the subhypergraph to avoid.
   """
   # i becomes each pivot position(i.e. the intersect of the edges)
   for i in range(0, (n - k + 1) * (r - 1), r - 1):
      flag = 1
      j = i
      # Cycles through an edge until a zer0 is found.
      while flag == 1 and j < i + (k * (r - 1) + 1):
         if bin_string[j] == 0:
            flag = 0
         j += 1
      if flag == 1:
         # Returns false if an edge of all ones is found.
         return False
   return True

def gen_strings_it(n, r, j, k):
   """
   Generates the binary strings iteratively.

   This function will generate binary strings which model loose uniform hypergraphs with boolean
   valued vertices. The hypergraphs are said to have 'failed' if a copy of a subhypergraph is
   filled with ones.

   :param: n: The size of the hypergraph.
   :param: r: The uniformity of the hypergraph.
   :param: j: The amount of 1 valued vertices.
   :param: k: The size of the subhypergraph to avoid.
   :return: A list of the binary strings that satisfy the requirements.
   """
   all_strings = gen_comb(n, r, j)
   valid_strings = []
   for string in all_strings:
      if is_valid(string, n, r, k):
         valid_strings.append(string)
   return valid_strings

def gen_strings_rec(n, r, j, k, bin_string='', good_strings=None):
   """
   Generates the binary strings recursively.

   This function will generate binary strings which model loose uniform hypergraphs with boolean
   valued vertices. The hypergraphs are said to have 'failed' if a copy of a subhypergraph is
   filled with ones.

   :param: n: The size of the hypergraph.
   :param: r: The uniformity of the hypergraph.
   :param: j: The amount of 1 valued vertices.
   :param: k: The size of the subhypergraph to avoid.
   :param: bin_string: A string of ones and zeros.
   :param: good_strings: A list of the binary strings that satisfy the requirements.
   :return: A list of the binary strings that satisfy the requirements.
   """
   if good_strings is None:
      good_strings = []
   # Appends the string to our 'good' list once it is the correct length.
   if len(bin_string) > n * (r - 1):
      # Checks that the correct amount of 1's are present before appending.
      if bin_string.count('1') == j:
         good_strings.append(bin_string)
      return good_strings
   else:
      gen_strings_rec(n, r, j, k, bin_string + '0', good_strings)
      # Only adds a 1 if there are currently fewer than j 1's.
      if (bin_string.count('1') < j and
         # Only adds a 1 if it will not cause a hyperedge to fully actuate.
         (len(bin_string) % (r - 1) != 0 or bin_string[k * (1 - r):] != '1' * k * (r - 1))):
         gen_strings_rec(n, r, j, k, bin_string + '1', good_strings)
   return good_strings

def choose(n, k):
   """
   Calculates the binomial coefficient for the given parameters. (n choose k)

   :param: n: The cardinality of a set
   :param: k: The number of elements to choose from that set
   :return: The number of ways there are to select k elements from a set of size n
   """
   print("{} choose {}".format(n, k))
   if n < k:
      result = 0
   else:
      result = fact(n) // (fact(k) * fact(n - k))
   return result

def r3k1(n, j):
   """
   Counts the number of possible ways to avoid a completely blue edge in 
   a 3 uniform hyperpath with j blue vertices.

   :param: n: The size of the hypergraph.
   :param: j: The amount of 1 valued vertices.
   :return: The number of binary strings that satisfy the requirements.
   """
   ## Base Cases ##
   if j == 0: return 1
   if j == 1: return 2 * n + 1
   if n <  1: return 0
   if j == 2: return 2 * n ** 2 + n
   if j >  2 * n + 1 - ceil(n / 2): return 0

   ## Recurrence ##
   val =  r3k1(n - 1, j)
   val += r3k1(n - 1, j - 1) * 2
   val += r3k1(n - 2, j - 2)
   val += r3k1(n - 2, j - 3)
   return val

def anyr_k1(n, r, j, val=0):
   """
   Counts the number of possible ways to avoid a completely blue edge in 
   an r uniform hyperpath with j blue vertices.

   :param: n: The size of the hypergraph.
   :param: r: The uniformity of the hypergraph.
   :param: j: The amount of 1 valued vertices.
   :param: val: The running total of binary strings.
   :return: The number of binary strings that satisfy the requirements.
   """
   ## Base Cases ##
   #if n < 0 or j <  0: return 0
   print("n={}, j={}".format(n, j))
   if j == 0: return 1
   if n == 0: return 1 if j == 1 else 0
   if j < r:
      print("J < R: n={}, j={}".format(n, j))
      return choose(n * (r - 1) + 1, j)
   if j > n * (r - 1) + 1 - ceil(n / 2): return 0

   ## Recurrence ##
   tmp = 0
   for i in range(r - 1): #goes up to and includes r-2
      print("ENTER LOOP: n={}, j={}".format(n, j))
      tmp += choose(r - 1, i) * anyr_k1(n - 1, r, j - i, val)
      print("MIDDLE OF LOOP: n={}, j={}".format(n, j))
      tmp += choose(r - 2, i) * anyr_k1(n - 2, r, j - (r - 1) - i, val)
      print("EXIT LOOP: n={}, j={}".format(n, j))
   val += tmp
   return val

def r3_anyk(n, j, k, val=0):
   """
   Counts the number of possible ways to avoid a completely blue subhyperpath 
   of size k in a 3 uniform hyperpath with j blue vertices.

   :param: n: The size of the hypergraph.
   :param: j: The amount of 1 valued vertices.
   :param: k: The size of the subhypergraph to avoid.
   :param: val: The running total of binary strings.
   :return: The number of binary strings that satisfy the requirements.
   """
   ## Base Cases ##
   if n < 0 or j <  0: return 0
   if j == 0: return 1
   if n == 0: return 1 if j == 1 else 0
   if j < 2 * k + 1: return choose(2 * n + 1, j)
   if j > 2 * n + 1 - ceil((n - k + 1) / (k + 1)): return 0

   ## Recurrence ##
   tmp =  r3_anyk(n - 1, j, k)
   tmp += r3_anyk(n - 1, j - 1, k) * 2
   tmp += r3_anyk(n - 2, j - 2, k)
   tmp += r3_anyk(n - 2, j - 3, k)

   for i in range(1, k): #goes up to and includes k-1
      tmp += r3_anyk(n - (i + 1), j - 2 * i - 1, k, val)
      tmp += r3_anyk(n - (i + 2), j - 2 * (i + 1), k, val)
      tmp += r3_anyk(n - (i + 2), j - 2 * (i + 1) - 1, k, val)
   val += tmp
   return val

def anyr_anyk(n, r, j, k, val=0):
   """
   Counts the number of possible ways to avoid a completely blue subhyperpath 
   of size k in an r uniform hyperpath with j blue vertices.

   :param: n: The size of the hypergraph.
   :param: r: The uniformity of the hypergraph.
   :param: j: The amount of 1 valued vertices.
   :param: k: The size of the subhypergraph to avoid.
   :param: val: The running total of binary strings.
   :return: The number of binary strings that satisfy the requirements.
   """
   ## Base Cases ##
   if n < 0 or j <  0: return 0
   if j == 0: return 1
   if n == 0: return 1 if j == 1 else 0
   if j < k * (r - 1) + 1: return choose(n * (r - 1) + 1, j)
   if j > n * (r - 1) + 1 - ceil((n - k + 1) / (k + 1)): return 0

   ## Recurrence ##
   tmp = 0
   for i in range(r - 1): #goes up to and includes r-2
      tmp += choose(r - 1, i) * anyr_anyk(n - 1, r, j - i, k, val)
      tmp += choose(r - 2, i) * anyr_anyk(n - 2, r, j - (r - 1) - i, k, val)

   for l in range(1, k): #goes up to and includes k-1
      for i in range(r - 2): #goes up to and includes r-3
         tmp += choose(r - 2, i) * anyr_anyk(n - (l + 1), r, j - l * (r - 1) - 1 - i, k, val)
      for i in range(r - 1): #goes up to and includes r-2
         tmp += choose(r - 2, i) * anyr_anyk(n - (l + 2), r, j - (l + 1) * (r - 1) - i, k, val)
   val += tmp
   return val
