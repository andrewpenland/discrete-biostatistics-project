from itertools import product 

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
