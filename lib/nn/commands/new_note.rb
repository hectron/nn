# frozen_string_literal: true

require 'date'

require_relative '../command'
require_relative '../configuration'

module Nn
  module Commands
    class NewNote < Nn::Command
      attr_reader :note, :options

      def initialize(note, options)
        @note    = note
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        begin
          ensure_can_create
          ensure_template_exists if template?

          if in_folders? && !custom_folder_exists?
            generator.create_dir(new_note_folder_path, Nn::Configuration.note_directory)
          end

          if template?
            generator.copy_file(template, new_note_path)
          else
            generator.create_file(new_note_path)
          end

          editor.open(new_note_path)
        rescue => e
          logger.fatal("Error:", e.message, note: note)
        end
      end

      private

      def ensure_can_create
        raise "Note directory not set up" unless note_directory_configured?
        raise "Cannot create a note outside of note directory" unless in_note_directory?
      end

      def ensure_template_exists
        raise "Template `#{options['template']}` does not exist" unless File.exist?(template)
      end

      def template
        @template ||= if options.has_key?('template')
          File.join(Nn::Configuration.template_directory, options['template'])
        else
          nil
        end
      end

      def new_note_name
        @new_note_name ||= begin
          filename = File.basename(note, '.*')

          "#{new_note_prefix}_#{filename}#{new_note_filetype}"
        end
      end

      def new_note_filetype
        note_extension = File.extname(note)

        if note_extension.empty?
          Nn::Configuration.filetype
        else
          note_extension
        end
      end

      def new_note_prefix
        DateTime.now.strftime(Nn::Configuration.prefix)
      end

      def new_note_folder_path
        @new_note_folder_path ||= begin
          folder = File.dirname(note)

          if folder == '.'
            ''
          else
            folder
          end
        end
      end

      def new_note_path
        @new_note_path ||= File.join(Nn::Configuration.note_directory,
                                     new_note_folder_path,
                                     new_note_name)
      end

      def note_directory_configured?
        File.directory?(Nn::Configuration.note_directory)
      end

      def custom_folder_exists?
        File.directory?(File.join(Nn::Configuration.note_directory, new_note_folder_path))
      end

      def in_note_directory?
        !note.start_with?('~') && !note.start_with?('/')
      end

      def in_folders?
        !new_note_folder_path.nil? && !new_note_folder_path.empty?
      end

      def template?
        !template.nil? && !template.empty?
      end
    end
  end
end
