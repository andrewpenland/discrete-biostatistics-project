def gen_strings(n, r, j, bin_string = '', good_strings = None):
   """Generates the binary strings.

   This function will generate binary strings which model loose hypergraphs with boolean valued 
   vertices. The hypergraphs are said to have 'failed' if an entire edge is filled with ones.

   Args:
      n: The size of the hypergraph.
      r: The size of the hyperedges.
      j: The amount of 1 valued vertices.
      bin_string: A string of ones and zeros.
      good_strings: A list of the binary strings that satisfy the requirements.

   Returns:
      A list of the binary strings that satisfy the requirements.

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
      gen_strings(n, r, j, bin_string + '0', good_strings)
      # Only adds a 1 if there are currently fewer than j 1's.
      if (bin_string.count('1') < j and
         # Only adds a 1 if it will not cause a hyperedge to fully actuate.
         (len(bin_string) % (r - 1) != 0 or bin_string[1 - r :] != '1' * (r - 1))):
         gen_strings(n, r, j, bin_string + '1', good_strings)
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
      j: The amount of 1 valued vertices.
      fill: How much information to print.
   """
   n = int(input('Enter the size of the hypergraph: '))
   r = int(input('Enter the uniformity of the hypergraph: '))
   j = int(input('Enter the amount of blue vertices: '))
   fill = input('Print all results? (y/n): ').lower()
   return n, r, j, fill

def main():
   """Main function.

   This function is a driver for the rest of the program.

   Args:
      None

   Returns:
      None
   """
   n, r, j, fill = usr_input()
   outStr = '(n = {}, r = {}, j = {}): {} possible binary strings.'
   if fill == 'n':
      # Print the number of successful binary strings with the given prameters
      print(outStr.format(n, r, j, len(gen_strings(n, r, j))))
   else:
      # Print all successful binary strings with all possible values up to the given parameters
      for x in range(1, n + 1):
         for y in range(2, r + 1):
            for z in range(1, j + 1):
               print(outStr.format(x, y, z, len(gen_strings(x, y, z))))

main()

