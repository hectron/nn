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
