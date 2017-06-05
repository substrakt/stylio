# Stylio

Stylio is a Sinatra based framework to make a living style guide that can easily be ported into a Rails application.

Currently supports Sass and ERB

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'stylio'
```

And then execute:

`bundle install`

Or install it yourself as:

`gem install stylio`

Add the framework folders

`mkdir components && mkdir layouts`

## Usage

Run `bundle exec stylio` in your project folder to start the server.

See (stylio-example)[http://github.com/substrakt/stylio-example] to see an example setup.

Stylesheets are added to the `assets/stylesheets` folder which you will need to create. The structure inside of this folder is completely up to the designers' own standards.

## Adding components

`bundle exec stylio generate-component COMPONENT_NAME` which will add two files in this folder:

An erb partial `touch _COMPONENT_NAME.html.erb`
A fixture file `touch COMPONENT_NAME.yml`

The root level yaml parameters create multiple examples of the partial. Any data below the root level is accessed in the partial e.g. `<%= params[:title] %>`

See (stylio-example)[http://github.com/substrakt/stylio-example] to see an example setup.

## Adding layouts

`mkdir layouts/LAYOUT_NAME` and then add a file in this folder:

An erb template `touch LAYOUT_NAME.html.erb`

No parameters can be referenced on this page except for `<%= yield %>`.

See (stylio-example)[http://github.com/substrakt/stylio-example] to see an example setup.

## Adding Javascripts

You can use sprockets as normal. You should create an `application.js` file in the `assets` folder. This can use `require` directives as per sprockets. You may use CoffeeScript or JavaScript.

## Adding examples

`mkdir examples/EXAMPLE_NAME` and then add a file in this folder:

An erb template `touch EXAMPLE_NAME.html.erb`
and yaml file `touch EXAMPLE_NAME.yml`

No parameters can be referenced on this page except for `<%= yield %>` and calling other components and the name of the yml data `<%= render_component 'component_name', :component_data %>`

See (stylio-example)[http://github.com/substrakt/stylio-example] to see an example setup.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/substrakt/stylio. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
