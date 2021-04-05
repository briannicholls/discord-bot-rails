# return an array of integers
def roll_dice(sides, quantity)
  puts "Rolling #{quantity} #{sides}-sided dice"
  p quantity.times.map{ Random.rand(sides) + 1 }
end

def is_dice_command?(command_slug)
  puts "Is #{command_slug} a dice command?"
  p !!command_slug.match(/!\d*[dD]\d+/)
end