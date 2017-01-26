def binary_mul(a, b)
  return 0 if a.zero? || b.zero?

  aa = a >> 1
  bb = b << 1

  return binary_mul(aa, bb) if a.even?
  b + binary_mul(aa, bb)
end

test_numbers = [6, 3]

puts('Got:')
puts(binary_mul(test_numbers.first, test_numbers.last))

puts('Expected:')
puts(test_numbers.first * test_numbers.last)
