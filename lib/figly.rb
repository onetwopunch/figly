require "figly/version"
require "figly/settings"
module Figly
  @@path = nil unless defined? @@path

  def self.setup(path)
    @@path = path
  end

  def self.path
    @@path
  end
end
