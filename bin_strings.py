from argparse import *

def gen_strings(n, r, bin_string = '', good_strings = None):
   """Generates the binary strings.
   
   This function will generate binary strings which model loose hypergraphs with boolean valued 
   vertices. The hypergraphs are said to have 'failed' if an entire edge is filled with ones.

   Args:
      n: The size of the hypergraph.
      r: The size of the hyperedges.
      bin_string: A string of ones and zeros.
      good_strings: A list of the binary strings that satisfy the requirements.
      
   Returns:
      A list of the binary strings that satisfy the requirements.
         
   """
   if good_strings is None:
      good_strings = []
   if len(bin_string) > n * (r - 1):
      good_strings.append(bin_string)
      return good_strings
   else:
      gen_strings(n, r, bin_string + '0', good_strings)
      if len(bin_string) % (r - 1) != 0 or bin_string[1 - r :] != '1' * (r - 1):
         gen_strings(n, r, bin_string + '1', good_strings)
   return good_strings

def usr_input():
   """Get user input.
   
   This function will collect user input including the graph size, hyperedge size, and 
   how much to print.

   Args:
      None

   Returns:
      n: The size of the hypergraph.
      r: The size of the hyperedges.
      fill: How much information to print.
   """
   n = int(input('Enter the size of the hypergraph: '))
   r = int(input('Enter the size of the hyperedge: '))
   fill = input('Print all results? (y/n): ')
   return n, r, fill

def main():
   """Main function.
   
   This function is a driver for the rest of the program.

   Args:
      None

   Returns:
      None
   """
   n, r, fill = usr_input()
   if fill == 'n':
      # Print the number of successful binary strings with the given prameters
      print('(n = {}, r = {}): {} possible binary strings.'.format(n, r, len(gen_strings(n, r))))
   else:
      # Print all successful binary strings with all possible values up to the given parameters
      for i in range(2, n + 1):
         for j in range(2, r + 1):
            print('(n = {}, r = {}): {} possible binary strings.'.format(i, j, len(gen_strings(i, j))))

main()
