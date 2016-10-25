class Command
  def initialize()
    puts 'ERROR'
  end

  def execute()
    puts 'ERROR'
  end

  def undo
    puts 'ERROR'
  end

  def print()
    puts 'ERROR'
  end
end


class AddCommand < Command
  def initialize(receiver, num=1)
    @receiver = receiver
    @num = num
  end

  def execute()
    @receiver.add_a(@num)
  end

  def undo()
    @receiver.sub_a(@num)
  end

  def print()
    puts "Command: Add #{@num}"
  end
end

class SubCommand < Command
  def initialize(receiver, num=1)
    @receiver = receiver
    @num = num
  end

  def execute()
    @receiver.sub_a(@num)
  end

  def undo()
    @receiver.add_a(@num)
  end

  def print()
    puts "Command: Sub #{@num}"
  end
end

class MulCommand < Command
  def initialize(receiver, num=2)
    @receiver = receiver
    @num = num
  end

  def execute
    @receiver.mul_a(@num)
  end

  def print
    puts "Command: Mul #{@num}"
  end
end
