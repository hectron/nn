# frozen_string_literal: true

require_relative '../../command'
require_relative '../../configuration'

module Nn
  module Commands
    class Template
      class Edit < Nn::Command
        attr_accessor :template

        def initialize(template)
          @template = template
        end

        def execute(input: $stdin, output: $stdout)
          template_dir = Nn::Configuration.template_directory

          if template.nil?
            files        = Dir.glob(File.join(template_dir, '*'))
            files.each { |file| file.gsub!(%r{#{template_dir}/}, '') } # clean up file path

            template = prompt.select("Which template would you like to edit?", files, filter: true)
          end

          path = File.join(template_dir, template)

          editor.open(path)
        end
      end
    end
  end
end
