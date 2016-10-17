# main.rb
require 'readline'
require './command.rb'
require './invoker.rb'
require './receiver.rb'

class Client
  def initialize()
    puts 'Client Box'

    @receiver = Receiver.new()
    @invoker = Invoker.new()

    @receiver.show()
  end

  def update()
    #input = Readline.readline("> ")
    #puts input
    com1 = AddCommand.new(@receiver)
    com2 = SubCommand.new(@receiver)
    @invoker.set_command(com1)
    @invoker.set_command(com2)
    @invoker.set_command(AddCommand.new(@receiver, 5))
    @invoker.set_command(SubCommand.new(@receiver, 3))

    @invoker.show_commands()
    @invoker.execute()
    @receiver.show()

    @invoker.show_commands
    @invoker.show_used_commands
    @receiver.show

    2.times{
      @invoker.undo
      @invoker.show_used_commands
      @receiver.show
    }
  end
end

#------ Action Point ------

client = Client.new()
client.update
