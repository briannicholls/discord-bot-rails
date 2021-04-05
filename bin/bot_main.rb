require 'discordrb'
require_relative './command_logic/dice.rb'

bot = Discordrb::Bot.new(
  token:     ENV['DISCORD_CLIENT_TOKEN'],
  client_id: ENV['DISCORD_CLIENT_ID']
)

# bot.message with_text: '!age' do |incoming_message|
#   incoming_message.respond "Brian is 33 years of age."
# end

bot.message(start_with: '!game') do |incoming_message|

  # Await a MessageEvent specifically from the invoking user.
  # Timeout defines how long a user can spend playing one game.
  # This does not affect subsequent games.
  #
  # You can omit the options hash if you don't want a timeout.
  event.user.await!(timeout: 300) do |guess_event|
    # Their message is a string - cast it to an integer
    guess = guess_event.message.content.to_i

    # If the block returns anything that *isn't* true, then the
    # event handler will persist and continue to handle messages.
    if guess == magic
      # This returns `true`, which will destroy the await so we don't reply anymore
      guess_event.respond 'you win!'
      true
    else
      # Let the user know if they guessed too high or low.
      guess_event.respond(guess > magic ? 'too high' : 'too low')

      # Return false so the await is not destroyed, and we continue to listen
      false
    end
  end
  event.respond "My number was: `#{magic}`."
  
end


bot.message(start_with: '!') do |event|
  message_content = event.content
  puts "Incoming message: #{message_content}"

  # User is attempting a command
  if ChatCommand.slug_valid? message_content
    # regex checking if command is a dice roll
    if is_dice_command?(message_content)

      arr = message_content.gsub('!', '').split /[dD]/
      options = {
        qty:   arr[0].to_i == 0 ? 1 : arr[0].to_i,
        sides: arr[1].to_i
      }
      puts "Dice roll options:"
      puts "Sides: #{options[:sides]}, Qty: #{options[:qty]}"

      response = "Rolled #{options[:qty].humanize} #{options[:sides]}-sided dice: "
      response = response + roll_dice(options[:sides], options[:qty]).join(', ')

      event.respond response
    end

  end

end

bot.run