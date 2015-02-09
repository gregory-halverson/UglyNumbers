filename = ARGV[0]

def ugly? n
  n % 2 == 0 or n % 3 == 0 or n % 5 == 0 or n % 7 == 0
end

def evaluate_expression expression
  if expression =~ /[+-]/
    return eval expression
  else
    return expression.to_i
  end
end

def permute_injections number
  digits = number.to_s
  permutations = []

  if digits.length == 1
    permutations.push digits[0]
    return permutations
  end

  for injection in ['', '+', '-']
    for recursive_permutations in permute_injections(digits[1..-1].to_i)
      permutations.push digits[0] + injection + recursive_permutations
    end
  end

  return permutations
end

File.open filename, 'r' do |file|
  for line in file
    number = line.chomp
    permutations = permute_injections number
    ugly_count = permutations.count { |p| ugly?(evaluate_expression(p)) }
    puts ugly_count
  end
end