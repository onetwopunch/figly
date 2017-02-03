module Figly
  module Settings
    module SettingsHash
      def method_missing(m, *args, &blk)
        value = self[m]
        return value.extend(SettingsHash) if value.instance_of? Hash
        value
      end

      def [](key)
        if self.key?(key.to_s)
          self.fetch(key.to_s)
        elsif self.key?(key.to_sym)
          self.fetch(key.to_sym)
        end
      end

      def symbolize_keys
        _symbolize_keys(self)
      end

      def symbolize_keys!
        _symbolize_keys(self, in_place: true)
      end

      private
      def _symbolize_keys(hash, in_place: false)
        h = in_place ? hash : hash.dup
        h.tap do |h|
          h.keys.each do |key|
            if key.is_a?(String)
              val = h.delete(key)
              h[key.to_sym] = if val.is_a?(Hash)
                _symbolize_keys(val, in_place: in_place)
              else
                val
              end
            end
          end
        end
      end
    end

    def self.to_h
      Figly.data
    end

    def self.method_missing(meth, *args, &block)
      m = meth == :[] ? args[0] : meth
      data = Figly.data
      val = if data.key?(m.to_s)
         data[m.to_s]
      elsif data.key?(m.to_sym)
         data[m.to_sym]
      end

      if val.instance_of?(Hash)
        val.extend(SettingsHash)
      elsif val.instance_of? Array
        val.each_with_index{ |item ,idx| item.extend(SettingsHash) if item.instance_of? Hash }
      end
      return val
    end
  end
end
