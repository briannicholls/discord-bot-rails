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

  binding.pry

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

bot.messaage(with_text: '!d20') do |event|
  
end



bot.run