# frozen_string_literal: true

require_relative '../command'

module Nn
  module Commands
    class NewNote < Nn::Command
      def initialize(note, options)
        @note = note
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        # Command logic goes here ...
        output.puts "OK"
      end
    end
  end
end
