# BlueCherries

The three kinds of password generators that I come across are the following:

1. Generates random characters, often with some user provided
   requirements/limitations. These are often the hardest to remember.
2. Generates "pronounceable random character passwords" where it still works
   more or less like the first category, but with fairly readable syllables.
3. The ["XKCD passwords"](http://xkcd.com/936/) which are just a number of
   words after each other.

The problem with all of these is that they don't care about how easy it is to
type them quickly. This project seeks to create a generator which takes the
easy-to-remember passwords of category #3, but chooses words which are easy to
type on a given keyboard layout. This is done by prioritizing finger rolls,
hand alteration and staying as close to the home row as possible (among other
things, it'll probably be more than that).

Generation of passwords like those from category #1 (with the benefit of being
easier to type) could probably also be done but this is a secondary objective
for the moment.

## Installation

Add this line to your application's Gemfile:

    gem 'bluecherries'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bluecherries

## Usage

TODO: Make the gem do something before writing usage instructions.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
