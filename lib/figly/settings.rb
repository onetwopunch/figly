require 'yaml'
module Figly
  module Settings
    module SettingsHash
      def method_missing(meth, *args, &blk)
        m = meth.to_s
        if has_key? m
          value = self[m]
          return value.extend(SettingsHash) if value.instance_of? Hash
          value
        end
      end
    end

    def self.settings_hash
      YAML.load_file(Figly.path)
    end

    def self.method_missing(meth, *args, &block)
      if self.settings_hash.has_key? meth.to_s
        val = settings_hash[meth.to_s]
        if val.instance_of?(Hash)
          val.extend(SettingsHash)
        elsif val.instance_of? Array
          val.each_with_index{ |item ,idx| item.extend(SettingsHash) if item.instance_of? Hash }
        end
        return val
      end
    end
  end
end
