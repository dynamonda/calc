# main.rb
require 'readline'
require './command.rb'
require './invoker.rb'
require './receiver.rb'
require './lexer.rb'
require './parser.rb'

class Client
  def initialize()
    puts 'Client Box'

    @receiver = Receiver.new()
    @invoker = Invoker.new(@receiver)

    @receiver.show()
  end

  def update()
    @invoker.show_commands
    @invoker.show_used_commands
    @receiver.show

    loop_flag = true
    while loop_flag do
      input = Readline.readline("> ")
      parser = Parser.new(Lexer.new(input), @receiver) # 解析
      if(parser.parse_check?)
        command = parser.evaluate   # 実行
        if command.is_a?(Command) then
          @invoker.set_command(command)
        else
          if command.is_a?(TerminalExpression_Exec) then
            @invoker.execute()
            @receiver.show
          elsif command.is_a?(TerminalExpression_Stack) then
            @invoker.show_commands
          else
            puts 'Exit Calc Bye'
            loop_flag = false 
          end
        end
      end
    end
  end
end

#------ Action Point ------

client = Client.new()
client.update


#------ command exam ------
# add [number] <- AddCommand(5)
# sub [number] <- SubCommand(5)
# exec  <- execute
# undo  <- undo(1)
# undo [number] <-undo(number)
# cancel<- stack commands all clear
# show  <- print stack commands
# help  <- print help strings
# help [command] <- print command howtouse