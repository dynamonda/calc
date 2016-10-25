class Lexer
  def initialize(context)
    context.chomp!
    @tokens = context.split
  end

  def print_tokens
    @tokens.each do |token|
      print "[#{token}],"
    end
    puts
  end

  def get_tokens
    @tokens
  end
end
