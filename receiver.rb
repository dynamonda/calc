class Receiver
  attr_accessor :A

  def initialize()
    @A = 0
  end

  # Command.execute() -> this.action()
  def action()
  end

  def add_a(num)
    @A += num
  end

  def sub_a(num)
    @A -= num
  end

  def mul_a(num)
    @A = @A * num
  end

  def show()
    puts "A:[#{@A}]"
  end
end
