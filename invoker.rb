class Invoker
  def initialize()
    @commands = []
    @used_commands = []
  end

  def set_command(command)
    @commands.push(command)
  end

  def execute()
    @commands.each do |command|
      command.execute
      @used_commands.push(command)
    end
    @commands.clear
  end

  def undo(step=1)
    @used_commands.last.undo
    @used_commands.pop
  end

  def show_commands()
    puts '[commands list]'
    @commands.each do |command|
      command.print
    end
  end

  def show_used_commands
    puts '[used commands list]'
    @used_commands.each do |command|
      command.print
    end
  end
end