# frozen_string_literal: true

# This is the way to invoke subcommands
module Nn
  module Commands
    class Template < Thor
      namespace :template
      default_task :edit

      desc 'ls [PATH]', 'List templates'
      def ls(path = nil)
        if options[:help]
          invoke :help, ['ls']
        else
          require_relative 'template/ls'
          Nn::Commands::Template::Ls.new(path).execute
        end
      end

      desc 'edit TEMPLATE', 'Create/edit a template'
      long_desc <<-DESC
        If a template doesn't exist, this will create it and open it in your $EDITOR.

        This command can also be invoked without `edit` specified.

        E.g. `nn template TEMPLATE`
      DESC
      def edit(template = nil)
        if options[:help]
          invoke :help, ['edit']
        elsif template.nil?
          invoke :help
        else
          require_relative 'template/edit'
          Nn::Commands::Template::Edit.new(template).execute
        end
      end
    end
  end
end
