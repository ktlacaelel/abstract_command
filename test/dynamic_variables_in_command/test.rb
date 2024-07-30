require 'abstract_command'

class VarsCommand < AbstractCommand
  def template
    'echo %<var_1>s %<var_2>s %<var_3>s %<var_4>s %<var_5>s'
  end
end

command = VarsCommand.new
command.var_1 = 'one'
command.var_2 = 'two'
command.var_3 = 'three'
command.var_4 = 'four'
command.var_5 = 'five'
puts command.to_s
puts command.system
