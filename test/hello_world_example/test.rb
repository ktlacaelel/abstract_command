require './lib/abstract_command.rb'

# Hello World Example.
class HelloCommand < AbstractCommand
  def template
    'echo Hello %<name>s'
  end
end

command = HelloCommand.new
command.name = 'World.'

puts command.to_s
