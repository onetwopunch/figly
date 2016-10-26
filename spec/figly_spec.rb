require 'spec_helper'

describe Figly do
  context 'YAML' do
    before { Figly.load_file(config_file) }
    after { Figly.clean }

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
    before { Figly.load_file(config_file 'toml') }
    after { Figly.clean }
    it 'should parse and work for TOML' do
      expect(Figly::Settings.a.b).to eq({"c"=>{"d"=>"test"}})
    end
  end

  context 'JSON' do
    before { Figly.load_file(config_file 'json') }
    after { Figly.clean }
    it 'should parse and work with JSON' do
      expect(Figly::Settings.userId).to eq(1)
    end
  end

  context 'multi files' do
    before {
      Figly.load_file(config_file 'json')
      Figly.load_file(config_file 'toml')
    }

    it 'should have both sets of data merged' do
      expect(Figly::Settings.userId).to eq(1)
      expect(Figly::Settings.a.b.c).to eq({"d"=>"test"})
    end
  end

  context 'errors' do
    after { Figly.clean }

    context 'ParserError' do
      it 'should error on bad.yml' do
        expect{Figly.load_file('spec/support/bad.yml')}.to raise_error(Figly::ParserError)
      end
      it 'should error on bad.json' do
        expect{Figly.load_file('spec/support/bad.json')}.to raise_error(Figly::ParserError)
      end
      it 'should error on bad.toml' do
        expect{Figly.load_file('spec/support/bad.toml')}.to raise_error(Figly::ParserError)
      end
      it 'should reset $stdout to the default even on an error' do
        expect{ Figly.load_file('spec/support/bad.toml') rescue nil }.not_to change { $stdout }
      end
    end

    it 'should raise an error if the config file is not found' do
      expect{ Figly.load_file('spec/support/nonexistent.json') }.to raise_error(Figly::ConfigNotFoundError)
    end

    it 'should raise an error on an unsupported config file format' do
      expect{ Figly.load_file("spec/support/config.ini") }.to raise_error(Figly::UnsupportedFormatError)
    end

    it 'should raise an exception if data is trying to be accessed before Figly has been loaded' do
      expect{ Figly::Settings.a.b }.to raise_error(Figly::ConfigNotLoaded)
    end
  end
end
