# frozen_string_literal: true
require 'json'

module Nn
  class Configuration
    SETTINGS_AVAILABLE = %i{filetype note_directory template prefix}.freeze
    DEFAULT_SETTINGS   = {
      filetype:       '.md',
      prefix:         '%Y%m%d',
      note_directory: Dir.pwd,
    }.freeze

    def self.instance
      @@instance ||= self.new
    end

    def self.note_directory
      dir = instance.current_config.fetch(:note_directory)

      unless dir.nil? || dir.empty?
        File.absolute_path(File.expand_path(dir))
      end
    end

    def self.template_directory
      note_dir = note_directory

      if note_dir
        File.join(note_dir, 'templates')
      end
    end

    def self.prefix
      instance.current_config.fetch(:prefix)
    end

    def self.template
      instance.current_config.fetch(:template)
    end

    def self.filetype
      instance.current_config.fetch(:filetype)
    end

    def self.current_config
      instance.current_config
    end

    def current_config
      @current_config ||= default_config
        .merge(home_config)
        .merge(local_config)
        .merge(environment_config)
    end

    private

    def default_config
      {}.tap do |config|
        SETTINGS_AVAILABLE.each do |setting|
          config[setting] = DEFAULT_SETTINGS[setting]
        end
      end
    end

    def home_config
      load_settings_from_file("#{Dir.home}/.nn/settings.json")
    end

    def local_config
      load_settings_from_file("#{Dir.pwd}/.nn/settings.json")
    end

    def environment_config
      {}.tap do |config|
        SETTINGS_AVAILABLE.each do |setting|
          key = "NN_#{setting}".upcase

          if ENV.has_key?(key)
            config[setting] = ENV[key]
          end
        end
      end
    end

    def load_settings_from_file(filename)
      if !File.exist?(filename) || File.zero?(filename)
        {}
      else
        json = JSON.parse(File.read(filename), symbolize_names: true)
        json.slice(*SETTINGS_AVAILABLE) # only return the relavent keys
      end
    end
  end
end