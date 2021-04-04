# return an array of integers
def roll_dice(sides, quantity)
  quantity.times.map{ Random.rand(sides) + 1 }
end