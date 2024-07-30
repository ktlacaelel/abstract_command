require 'abstract_command'

module Command
  class Hello < AbstractCommand
    def template
      'echo Hello %<name>s'
    end
  end
end

command = Command::Hello.new(:name => 'Kazu')
puts command.to_s
puts command.system
