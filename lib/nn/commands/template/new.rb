# frozen_string_literal: true

require_relative '../../command'
require_relative '../../configuration'

module Nn
  module Commands
    class Template
      class New < Nn::Command
        attr_reader :template

        def initialize(template)
          @template = template
        end

        def execute(input: $stdin, output: $stdout)
          begin
            ensure_can_create

            unless template_folder_exists?
              generator.create_dir(Nn::Configuration.template_directory)
            end

            new_template_path = File.join(Nn::Configuration.template_directory, template)

            generator.create_file(new_template_path)

            editor.open(new_template_path)
          rescue => e
            logger.fatal("Error:", e.message, template: template)
          end
        end

        private

        def ensure_can_create
          raise "Template directory not specified" unless Nn::Configuration.template_directory
        end

        def template_folder_exists?
          File.directory?(Nn::Configuration.template_directory)
        end
      end
    end
  end
end
