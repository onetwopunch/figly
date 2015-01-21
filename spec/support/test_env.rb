module TestEnv
  def config_file
    File.join(root, 'spec/support/config.yml')
  end
  
  def root
    support = File.dirname __dir__
    File.expand_path(File.join(support, ".."))
  end

end
