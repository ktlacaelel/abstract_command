
# before ruby 1.9.1 the format method does not support
# the syntax we want, so we have a simplified version of
# format for older versions of ruby.
# its placed in the AbstractCommand class because we want
# to avoid possible collisions for people requiring our code.
# It can live on a better place though..
class AbstractCommand
  class Formatter
    REGEXP = /(%<)(\S+)(>\w)/
    def self.format(template, params)
      template.gsub(REGEXP) do
        params[$2.to_sym]
      end
    end
  end
end
