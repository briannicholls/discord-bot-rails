class CreateChatCommands < ActiveRecord::Migration[6.1]
  def change
    create_table :chat_commands do |t|
      t.string :slug

      t.timestamps
    end
  end
end
