require "figly/version"
require "figly/settings"

module Figly
  def self.setup(path)
    raise "File does not exist: #{path}" unless File.exists?(path)
    ext = File.extname(path)
    @@data = case ext
    when '.toml'
      require 'toml'
      TOML.load_file(path)
    when '.yml'
      require 'yaml'
      YAML.load_file(path)
    when '.json'
      require 'json'
      JSON.parse(File.read(path))
    else
      raise "Unsupported file extension (#{ext})"
    end
    @@data
  end

  def self.data
    @@data
  end
end
