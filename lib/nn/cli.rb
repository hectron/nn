# frozen_string_literal: true

require 'thor'

module Nn
  # Handle the application command line parsing
  # and the dispatch to various command objects
  #
  # @api public
  class CLI < Thor
    # Error raised by this runner
    Error = Class.new(StandardError)

    desc 'version', 'Show nn version'
    def version
      require_relative 'version'
      puts "v#{Nn::VERSION}"
    end
    map %w(--version -v) => :version

    desc 'new NOTE', 'Create a new note'
    method_option :template, aliases: '-t', type: :string,
                         desc: 'Template to use (if exists)'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def new(note)
      if options[:help]
        invoke :help, ['new']
      else
        require_relative 'commands/new_note'
        Nn::Commands::NewNote.new(note, options).execute
      end
    end

    desc 'edit NOTE', 'Edits an existing note'
    method_option :help, aliases: '-h', type: :boolean,
                  desc: 'Display usage information'
    def edit(note = nil)
      if options[:help]
        invoke :help, ['edit']
      else
        require_relative 'commands/edit_note'
        Nn::Commands::EditNote.new(note, options).execute
      end
    end

    desc 'sync', 'Sync notes in repository'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def sync(*)
      if options[:help]
        invoke :help, ['sync']
      else
        require_relative 'commands/sync'
        Nn::Commands::Sync.new(options).execute
      end
    end

    desc 'config', 'Configure nn'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def config(*)
      if options[:help]
        invoke :help, ['config']
      else
        require_relative 'commands/config'
        Nn::Commands::Config.new(options).execute
      end
    end

    require_relative 'commands/template'
    register Nn::Commands::Template, 'template', 'template [SUBCOMMAND]', 'Create/configure templates'

  end
end
