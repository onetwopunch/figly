# Figly

A simple config gem to use in either rails or any other ruby gem.

## Installation

Add this line to your application's Gemfile:

    gem 'figly'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install figly

## Usage

The only setup that's required is to set the path of you're configuration file that must be in YAML. Just throw the following code into an initializer.:

    Figly.load_file "path/to/config.yml"

**NOTE: You can load multiple config files of different types and they will be deep merged together in your settings**

If you're config looks like this:

    some_key: 234
	nest1:
	  nest2:
	    nest3: Yay

You can do the following:

    Figly::Settings.some_key
    #=> 234

    Figly::Settings.nest1
    #=> {"nest2" => {"nest3" => "Yay"}}

    Figly::Settings.nest1.nest2.nest3
    #=> "Yay"

Figly currently supports the following file extensions, and will infer the parser based on the extension:

- .yml => YAML
- .toml => TOML
- .json => JSON


## UPDATE: As of version 1.1.0

You can now use your settings directly from Figly::Settings with indifferent access. So using the above config, you can access
the value `Yay` in all of the following ways, plus the ways you were able to before.

```
Figly::Settings[:nest1][:nest2].nest3
Figly::Settings['nest1'][:nest2]['nest3']

# Or if calling a method on a module makes you uncomfortable, you can use #to_h
Figly::Settings.to_h['nest1'][:nest2]['nest3']
```

## Testing    

If you want to contribute start by making sure the tests work:

    bundle install

To access a REPL environment that loads the libraries:

    ./bin/console

To run tests:

    rspec spec

## Contributing

1. Fork it ( https://github.com/onetwopunch/figly/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
