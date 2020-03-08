# frozen_string_literal: true

require_relative '../../command'

module Nn
  module Commands
    class Template
      class Edit < Nn::Command
        def initialize(template)
          @template = template
        end

        def execute(input: $stdin, output: $stdout)
          # Command logic goes here ...
          output.puts "OK"
        end
      end
    end
  end
end
