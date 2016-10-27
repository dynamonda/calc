# Memento
require './command.rb'

class Memento
  attr_reader :memory_num, :commands, :used_commands
  def initialize(memory_num, commands, used_commands)
    @memory_num = memory_num        # receiver
    @commands = commands            # invoker コマンドのレシーバーまでコピーされてしまう
    @used_commands = used_commands  # invoker
  end
end

class Originator
  def initialize(receiver, invoker)
    @receiver = receiver
    @invoker = invoker
  end

  def save_to_memento
    commands = []
    used_commands = []
    @invoker.commands.each do |command|
      commands.push(command.to_s)
    end
    @invoker.used_commands.each do |command|
      used_commands.push(command.to_s)
    end
    Memento.new(@receiver.A, commands, used_commands)
  end

  def restore_from_memento(m)
    if m.nil? then
      puts 'ERROR: Not Exist Memento'
    else
      @receiver.A = m.memory_num

      @invoker.commands.clear
      m.commands.each do |command|
        @invoker.commands.push(command_from_s(@receiver, command))
      end

      @invoker.used_commands.clear
      m.used_commands.each do |command|
        @invoker.used_commands.push(command_from_s(@receiver, command))
      end

      puts 'Restore'
    end
  end

  def command_from_s(receiver, str)
    array_str = str.split
    case array_str[0]
    when 'add' then
      return AddCommand.new(receiver, array_str[1].to_i)
    when 'sub' then
      return SubCommand.new(receiver, array_str[1].to_i)
    else
    end
  end
end

class Caretaker
  def initialize
    @save_states = []
  end

  def add_memento(m)
    @save_states.push(m)
    puts "Saved Memento [#{@save_states.length-1}]"
  end

  def get_memento(index)
    @save_states[index]
  end
end