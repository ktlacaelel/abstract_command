require './lib/abstract_command.rb'

module Command

  class Hello < AbstractCommand
    def template
      'echo Hello %<name>s'
    end
  end

  class Bye < AbstractCommand
    def template
      'echo Bye %<name>s'
    end
  end

end

command = Command::Hello.new
command.name = 'world'
puts command.to_s
puts command.system
puts command.backtick
