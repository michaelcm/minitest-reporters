module Minitest
  module Reporters
    module ANSI
      module Code

        def self.color?
          color_terminal = !!(ENV['TERM'].to_s =~ /(color|rxvt|xterm)/i)
          $stdout.tty? || color_terminal
          true
        end

        def self.stripColor( input )
          input.scan(/\033\[([0-9]+);([0-9]+);([0-9]+)m(.+?)\033\[0m|([^\033]+)/m).inject('') do |str, match|
            str << (match[3] || match[4])
          end
        end

        if color?
          require 'ansi/code'

          include ::ANSI::Code
          extend ::ANSI::Code
        else
          def black(s = nil)
            block_given? ? yield : s
          end

          %w[ red green yellow blue magenta cyan white ].each do |color|
            alias_method color, :black
          end

          extend self
        end
      end
    end
  end
end
