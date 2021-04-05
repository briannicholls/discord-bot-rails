class ChatCommand < ApplicationRecord
  def self.slug_valid?(slug)
    puts "Is #{slug} a valid command?"
    p !!slug.match(/!\w+/)
  end
end
