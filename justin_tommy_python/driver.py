from bin_strings import *

def usr_input():
   """Get user input.

   This function will collect user input including the graph size, hyperedge size, and
   how much to print.
   :return: The size of the hypergraph.
   :return: The uniformity of the hypergraph.
   :return: The amount of 1 valued vertices.
   :return: The size of the subhypergraph to avoid.
   :return: How much information to print.
   :return: Whether to use iteration or recursion.
   """
   n = int(input('Enter the size of the hypergraph: '))
   r = int(input('Enter the uniformity of the hypergraph: '))
   j = int(input('Enter the amount of blue vertices: '))
   k = int(input('Enter the size of the avoided subhypergraph: '))
   fill = input('Print all results? (y/n): ').lower()
   method = input('Compute recursively or iteratively? (r/i): ').lower()
   return n, r, j, k, fill, method

def print_results(method, n, r, j, k):
   """
   Prints the the number of valid binary strings with the given parameters.

   :param: method: Whether to use iteration or recursion.
   :param: n: The size of the hypergraph.
   :param: r: The uniformity of the hypergraph.
   :param: j: The amount of 1 valued vertices.
   :param: k: The size of the subhypergraph to avoid.
   """
   outstr = '(n = {}, r = {}, j = {}, k = {}): {} possible binary strings.'
   if method == 'r' or method == 'recursively':
      print(outstr.format(n, r, j, k, len(gen_strings_rec(n, r, j, k))))
   else:
      print(outstr.format(n, r, j, k, len(gen_strings_it(n, r, j, k))))

def main():
   """
   Main function.

   This function is a driver for the rest of the program.
   """
   n, r, j, k, fill, method = usr_input()
   outstr = '(n = {}, r = {}, j = {}, k = {}): {} possible binary strings.'
   if fill == 'n' or fill == 'no':
      # Print the number of successful binary strings with the given parameters
      print_results(method, n, r, j, k)
   else:
      # Print all successful binary strings with all possible values up to the given parameters
      for w in range(1, n + 1):
         for x in range(2, r + 1):
            for y in range(0, j + 1):
               for z in range(1, k + 1):
                  print_results(method, w, x, y, z)

if __name__ == '__main__':
   main()
