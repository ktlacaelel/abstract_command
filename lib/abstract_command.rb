require 'open3'
require 'shellwords'
require './lib/formatter.rb'

# Shell Command Abstraction.
#
# Hides away all the details to generate a command.
# And provides an easy interface to interact with shell commands as if
# they were objects.
#
# This is good for the following reasons:
#
# - Enforces standardization.
# - Enforces separation of command definition and consumption.
# - Enforces configuration over code.
# - Enforces configuration over refactoring.
# - Enforces simple shell-command definition.
# - Enforces automatic sanitization of variables that get interpolated.
# - Provides a simple Object Oriented Interface.
# - Provides a scope for variables that belong to the command.
# - Provides getters and setter for every interpolation in command.
# - Provides a neat interface that plugs to data structures transparently.
# - Avoids methods with many arguments.
# - Avoids changes in the standared libarary: system, backtick, etc.
#
class AbstractCommand

  # '%<name>s'.scan(/(%<)(\w+)(>)/)
  # => [["%<", "name", ">"]]
  VARIABLE_REGEX = /(%<)(\w+)(>)/

  def template
    raise 'must implement'
  end

  def variables
    result = []
    template.scan(VARIABLE_REGEX).each do |variable|
      result.push(variable[1])
    end
    result
  end

  def initialize(properties = {})
    variables.each do |variable|
      self.class.send(:attr_accessor, variable.to_sym)
    end
    properties.each do |key, value|
      setter = (key.to_s + '=').to_sym
      send(setter, value)
    end
  end

  def to_s
    bindings = {}
    variables.each do |variable|
      value = instance_variable_get("@#{variable}")
      bindings[variable.to_sym] = "#{value}".shellescape
    end
    format(template, bindings)
  end

  def format(template, bindings)
    if RUBY_VERSION <= '1.9.1'
      Formatter.format(template, bindings)
    else
      super(template, bindings)
    end
  end

  def system
    super(to_s)
  end

  def backtick
    `#{to_s}`
  end

  def execute
    begin
      stdout, stderr, status = Open3.capture3(to_s)
      status = status.exitstatus
    rescue StandardError => error
      stdout = ""
      if(error.message)
        stderr = error.message
      end
      status = 1
    end
    return stdout, stderr, status
  end

end
