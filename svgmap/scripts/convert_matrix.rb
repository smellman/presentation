
require 'matrix'

def parse(args)
  a = args[0]
  b = args[1]
  c = args[2]
  d = args[3]
  e = args[4]
  f = args[5]
  xs = args[6]
  ys = args[7]
  ma = Matrix[[a, c],
              [b, d]]
  v = Vector[xs - e,
             ys - f]
  ret = ma.inv*v
  p ret
  p "#{ret[1]},#{ret[0]}"
end

if __FILE__ == $0
  if ARGV.length < 8
    p "a b c d e f xs ys"
    exit 0
  end
  parse(ARGV.map(&:to_f))
end
