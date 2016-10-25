require './command.rb'

# initialize トークンに分離して配列に入れる
# evaluate   構文木を生成
# execute    コマンド実行

class Parser
  def initialize(lexer, receiver)
    @@receiver = receiver

    @parse_list = []
    @parse_flag = true
    lexer.get_tokens.each do |token|
      if integer_string?(token)
        @parse_list.push(TerminalExpression_Number.new(token))
      else
        case token
        when 'add' then
          @parse_list.push(TerminalExpression_Add.new)
        when 'sub' then
          @parse_list.push(TerminalExpression_Sub.new)
        when 'exec' then
          @parse_list.push(TerminalExpression_Exec.new)
        when 'help' then
          @parse_list.push(TerminalExpression_Help.new)
        when 'stack' then
          @parse_list.push(TerminalExpression_Stack.new)
        when 'exit' then
          @parse_list.push(TerminalExpression_Exit.new)
        else
          puts "ERROR: Undefined Command [#{token}]"
          @parse_flag = false
          break
        end
      end
    end

    @parse_root = @parse_list[0]
    
  end

  # return Command or nil
  # 評価
  def evaluate
    stack = []
    @parse_list.each do |reaf|
      reaf.interpret(stack)
    end
    stack.pop
  end

  # 
  def execute
  end

  def integer_string?(string)
      Integer(string)
      true
    rescue ArgumentError
      false
  end

  def parse_check?
    @parse_flag
  end

  def self.receiver
    @@receiver
  end
end



class Expression
  def interpret(stack)
    puts 'ERROR Expression class interpret()'
  end
end

# composite pattern Reaf
class TerminalExpression_Number < Expression
  def initialize(num)
    @number = num.to_i
  end

  def interpret(stack)
    stack.push(self)
  end

  def to_s
    "Expression :Number #{@number}"
  end

  def to_i
    @number
  end
end

class TerminalExpression_Add < Expression
  def interpret(stack)
    num = stack.pop
    stack.push(AddCommand.new(Parser.receiver, num.to_i))
  end

  def to_s 
    'Expression :Add'
  end
end

class TerminalExpression_Sub < Expression
  def interpret(stack)
    num = stack.pop
    stack.push(SubCommand.new(Parser.receiver, num.to_i))
  end

  def to_s
    'Expression :Sub'
  end
end

class TerminalExpression_Exec < Expression
  def interpret(stack)
    stack.push(self)
  end
end

class TerminalExpression_Help < Expression
  def initialize
  end

  def interpret(invoker)
    puts '------ Help ------'
  end

  def to_s 
    "Expression :Help"
  end
end

class TerminalExpression_Stack < Expression
  def interpret(stack)
    stack.push(self)
  end
end

class TerminalExpression_Exit < Expression
  def interpret(stack)
    stack.push(self)
  end
end