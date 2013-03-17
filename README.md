# Mongoid::Votable

Votable for mongoid

## Installation

Add this line to your application's Gemfile:

    gem 'mongoid-votable'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongoid-votable

## Usage

~~~ruby
class Topic
  include Mongoid::Document
  include Mongoid::Votable
  
end
~~~

~~~ruby
topic.vote!(1, user)
topic.vote!(-1, user)

topic.vote!(10, user)

topics = Topic.voted_by(user)
~~~

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
