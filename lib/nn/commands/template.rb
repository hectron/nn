# frozen_string_literal: true

# This is the way to invoke subcommands
module Nn
  module Commands
    class Template < Thor
      default_task :edit
      namespace :template

      desc 'rm TEMPLATE', 'Delete a template'
      method_option :help, aliases: '-h', type: :boolean,
                           desc: 'Display usage information'
      def rm(template)
        if options[:help]
          invoke :help, ['rm']
        else
          require_relative 'template/rm'
          Nn::Commands::Template::Rm.new(template, options).execute
        end
      end

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

        E.g. `nn template edit TEMPLATE`
      DESC
      def edit(template = nil)
        if options[:help]
          invoke :help, ['edit']
        else
          require_relative 'template/edit'
          Nn::Commands::Template::Edit.new(template).execute
        end
      end

      desc 'new TEMPLATE', 'Create a template'
      long_desc <<-DESC
        This will create a template and open it in your $EDITOR.

        E.g. `nn template new TEMPLATE`
      DESC
      def new(template)
        if options[:help]
          invoke :help, ['new']
        elsif template.nil?
          invoke :help
        else
          require_relative 'template/new'
          Nn::Commands::Template::New.new(template).execute
        end
      end
    end
  end
end
