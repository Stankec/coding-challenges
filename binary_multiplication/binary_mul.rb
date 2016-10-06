def binary_mul(a, b)
  return 0 if (a == 0) || (b == 0)

  aa = a >> 1
  bb = b << 1

  return binary_mul(aa, bb) if a.even?
  b + binary_mul(aa, bb)
end

puts(binary_mul(6, -3))
