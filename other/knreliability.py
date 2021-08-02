#!/bin/python3
from functools import lru_cache

@lru_cache(maxsize=None)
def h(p, k, n):
    if 0 <= n and n < k:
        return 1
    if n < 0:
        return 0

    sumation = p ** (n-k+1)
    for r in range(1, n - k + 1 +1) : # +1 because range is exclusive
        for m in range(r+1, r + k - 1 + 1): # +1 because range is exclusive
            sumation += h(p, k, n-m) * p**r * (1-p)**(m-r)

    return sumation


if __name__ == "__main__":
    from sys import argv
    from sympy import symbols, expand
    p = symbols("p")
    k = int(argv[1])
    n = int(argv[2])

    hp=h(p, k, n)
    print("h(p, " + str(k) + ", " + str(n) + ") = ", expand(hp))
