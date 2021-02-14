# frozen_string_literal: true

require_relative '../../command'
require_relative '../../configuration'

module Nn
  module Commands
    class Template
      class Ls < Nn::Command
        def initialize(options)
          @options = options
        end

        def execute(input: $stdin, output: $stdout)
          template_dir = Nn::Configuration.template_directory
          files = Dir.glob(File.join(template_dir, '*'))
          files.each do |file|
            file.gsub!(%r{#{template_dir}/}, '')
          end
          prompt.select("Which template would you like to edit?", files, filter: true)
          output.puts files
        end
      end
    end
  end
end
