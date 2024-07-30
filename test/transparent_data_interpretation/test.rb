require 'abstract_command'

developers = [
  { :name => 'Kazu' },
  { :name => 'Adrian' },
  { :name => 'Cesar' },
  { :name => 'Sergio' }
]

module Command
  class Hello < AbstractCommand
    def template
      'echo Hello %<name>s'
    end
  end
end

developers.each do |developer|
  Command::Hello.new(developer).system
end
