require 'spec_helper'

describe Figly do
  context 'YAML' do
    before do
      Figly.setup(config_file)
    end

    it 'should correctly access and integer on the top level' do
      expect(Figly::Settings.some_key).to eq(234)
    end

    it 'should correctly access an array' do
      expect(Figly::Settings.hello).to eq([1,2,3])
    end

    it 'should correclty access a hash' do
      expect(Figly::Settings.nest1).to eq({'nest2' => {'nest3' => 'Yay'} } )
    end

    it 'should correctly access a value nested in a hash' do
      expect(Figly::Settings.nest1.nest2.nest3).to eq('Yay')
    end

    it 'should correctly access a nestd hash within an array' do
      expect(Figly::Settings.ary.first.nest1.nest2).to eq('Woot')
    end

    it 'should return nil when accessing a key that doesnt exist' do
      expect(Figly::Settings.blah).to eq(nil)
    end
  end

  context 'TOML' do
    before do
      Figly.setup(config_file 'toml')
    end
    it 'should parse and work for TOML' do
      expect(Figly::Settings.a.b).to eq({"c"=>{"d"=>"test"}})
    end
  end

  context 'JSON' do
    before do
      Figly.setup(config_file 'json')
    end
    it 'should parse and work with JSON' do
      expect(Figly::Settings.userId).to eq(1)
    end
  end
end
