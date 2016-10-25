module TestEnv
  def config_file(ext = 'yml')
    File.join(root, "spec/support/config.#{ext}")
  end

  def root
    support = File.dirname __dir__
    File.expand_path(File.join(support, ".."))
  end
end
