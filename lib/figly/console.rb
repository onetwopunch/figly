require 'pry'
Pry.config.prompt = lambda do |context, nesting, pry|
  "[figly] #{context}> "
end

config = File.expand_path(File.join(__FILE__, '../../../spec/support/config.yml'))
