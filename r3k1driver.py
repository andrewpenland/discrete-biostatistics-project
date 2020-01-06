from bin_strings import *

def usr_input():
   """Get user input.

   This function will collect user input including the graph size, hyperedge size, and
   how much to print.
   :return: The size of the hypergraph.
   :return: The amount of 1 valued vertices.
   """
   n = int(input('Enter the size of the hypergraph: '))
   j = int(input('Enter the amount of blue vertices: '))
   return n, j

def main():
   """
   Main function.

   This function is a driver for the rest of the program.
   """
   n, j = usr_input()
   # Print all binary strings with the given parameters
   print(gen_strings_rec(n, 3, j, 1))

if __name__ == '__main__':
   main()
