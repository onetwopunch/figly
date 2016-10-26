require "figly/version"
require "figly/settings"

module Figly
  class ParserError < StandardError; end
  class UnsupportedFormatError < StandardError; end
  class ConfigNotFoundError < StandardError; end

  def self.load_file(path)
    raise ConfigNotFoundError, "File does not exist: #{path}" unless File.exists?(path)
    ext = File.extname(path)
    data = case ext
    when '.toml'
      begin
        require 'toml'
        # HACK: TOML captures Parslet errors and puts them so they get swallowed
        # here we redirect stdout to an IO buffer that we can read from and test
        # that the value doesn't match an error
        old_stdout = $stdout
        $stdout = StringIO.new('','w')
        TOML.load_file(path).tap do |d|
          cap = $stdout.string
          raise ParserError, cap if cap =~ /^Failed to match/
        end
      rescue Exception => e
        raise ParserError, e.message
      ensure
        # Make sure to reset the old stdout even if an exception is thrown
        $stdout = old_stdout
      end
    when '.yml'
      begin
        require 'yaml'
        YAML.load_file(path)
      rescue Exception => e
        raise ParserError, e.message
      end
    when '.json'
      begin
        require 'json'
        JSON.parse(File.read(path))
      rescue Exception => e
        raise ParserError, e.message
      end
    else
      raise UnsupportedFormatError, "Unsupported file extension (#{ext})"
    end

    # Here we merge config files if there are multiple load calls
    if defined?(@@data) && !@@data.nil?
      _deep_merge(@@data, data)
    else
      @@data = data
    end
  end

  ## Useful for testing
  def self.clean
    @@data = nil
  end

  def self.data
    @@data
  end

  def self._deep_merge(first, second)
    merger = proc { |key, v1, v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : v2 }
    first.merge!(second, &merger)
  end
end
