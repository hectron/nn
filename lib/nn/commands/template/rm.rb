# frozen_string_literal: true

require_relative '../../command'

module Nn
  module Commands
    class Template
      class Rm < Nn::Command
        def initialize(template, options)
          @template = template
          @options = options
        end

        def execute(input: $stdin, output: $stdout)
          # Command logic goes here ...
          output.puts "OK"
        end
      end
    end
  end
end
