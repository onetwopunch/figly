require 'figly'
require 'support/test_env'

RSpec.configure do |config|
	# Use color in STDOUT
  config.color = true
	config.include TestEnv
end
