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

    desc 'version', 'nn version'
    def version
      require_relative 'version'
      puts "v#{Nn::VERSION}"
    end
    map %w(--version -v) => :version

    desc 'sync', 'Command description...'
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

    desc 'config', 'Command description...'
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

    desc 'template', 'Command description...'
    method_option :help, aliases: '-h', type: :boolean,
                         desc: 'Display usage information'
    def template(*)
      if options[:help]
        invoke :help, ['template']
      else
        require_relative 'commands/template'
        Nn::Commands::Template.new(options).execute
      end
    end
  end
end
