def r3k1(n, j):
   if j == 0:
      return 1
   if j == 1:
      return 2 * n + 1
   if j == 2:
      return 2 * n * n + n
   if n < 1:
      return 0
   print("n: ", n, "j: ", j)
   value = r3k1(n - 1, j)
   value += 2 * r3k1(n - 1, j - 1)
   value += r3k1(n - 2, j - 2)
   value += r3k1(n - 2, j - 3)
   return value

n = int(input("Size: "))
j = int(input("Blue vertices: "))
value = r3k1(n, j)
print(value)