# ActsAsHocAvatarable

  Ease the use of ActiveStorage as an avatar for eg. user model.
  This is specially made for API usage, where data is delivered as a base64 string.
  Images can be resized on saving.
  This uses ActiveStorage, thus minimum rails version is 5.2

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'acts_as_hoc_avatarable'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install acts_as_hoc_avatarable

## Usage

install it with:

    $ rails generate acts_as_hoc_avatarable:install

And finally migrate with:

    $ rails db:migrate

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
