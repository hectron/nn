# frozen_string_literal: true

require 'date'

require_relative '../command'
require_relative '../configuration'

module Nn
  module Commands
    class EditNote < Nn::Command
      attr_reader :note, :options

      def initialize(note, options)
        @note    = note
        @options = options
      end

      def execute(input: $stdin, output: $stdout)
        begin
          # Todo -- support editing a note implicitly, depending on default filetype
          path = prompt.select("Which note would you like to edit?", all_notes, filter: true)
          editor.open(path)
        rescue => e
          logger.fatal("Error:", e.message, note: note)
        end
      end

      private

      def all_notes
        note_dir = Nn::Configuration.note_directory
        files    = Dir.glob(File.join(note_dir, '**', '*'))
        files
          .reject { |f| f.include?(Nn::Configuration.template_directory) }
          .each { |f| f.gsub!(%r{#{note_dir}/}, '') }
          .reject { |f| f == '.' || f == '..' }
      end

    end
  end
end
