class ReedMuller
  attr_accessor :weights, :rate

  def initialize(rate)
    self.rate = Integer(rate)
    self.weights = get_weights()
  end

  def calculate
    n = 2 ** rate
    positions = (0...n).to_a
    result_hash = {}

    positions.each do |position|
      if position == 0
        result_bytes = Array.new(rate, 0).unshift(1)
      else
        subset = positions_subset(position)
        convert_positions = positions_to_convert(subset)
        result_bytes = get_result_bytes(convert_positions)
      end
      result_hash[position] = result_bytes
    end

    result_hash
  end

  def get_result_bytes(positions)
    bytes = Array.new(rate, 0)
    positions.each do |position|
      bytes.each_with_index do |byte, index|
        bytes[index] = 1 if index == position
      end
    end
    bytes.unshift(1)
  end

  def positions_subset(num)
    words = weights.keys
    summary = Array.new(rate, "0")

    1.upto(words.length) do |n|
      sum = words.combination(n).find do |subset|
        subset.reduce(0) { |sum, word| sum += weights[word] } == num
      end

      summary = sum unless sum.nil?
    end

    summary
  end

  def positions_to_convert(positions_subset)
    positions = get_weights().keys
    positions_subset.map { |position| positions.index(position) }.compact
  end

  private

  def get_weights
    set = []
    rate.times do |index|
      value = 2 ** index
      set.push value
    end
    weights = {}
    set.each { |el| weights[el.to_s] = el }
    weights
  end

end

ReedMuller.new(3).calculate()
=begin

RM(2)
r = 2 ^ 2
f2 = [ [0,0], [0,1], [1,0], [1,1]]
v0 = [ 1, 1, 1, 1 ]
#      3  2  1  0
v1 = [ 1, 0, 1, 0 ]
v2 = [ 1, 1, 0, 0 ]

RM(3)
r = 2 ^ 3
f3 = [ [0,0,0],[1,1,1],[0,1,0],[1,0,1],[0,1,1],[1,1,0],[1,0,0],[0,0,1] ]

#     1  2  3  4  5  6  7  8
v0 = [1, 1, 1, 1, 1, 1, 1, 1]
#     7  6  5  4  3  2  1  0
v1 = [1, 0, 1, 0, 1, 0, 1, 0]
v2 = [1, 1, 0, 0, 1, 1, 0, 0]
v3 = [1, 1, 1, 1, 0, 0, 0, 0]

=end
