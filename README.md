# Govuk::DummyContentStore

The dummy content store allows you to run a frontend using the examples from
the `govuk-content-schemas` repo. You will not need to run the content store
itself.

## Installation

The dummy content store is best installed as a stand-alone gem:

    $ gem install govuk-dummy_content_store

## Usage

Start the server using:

    $ dummy_content_store

By default it will look for the schemas:

  1. at the path specified by the `EXAMPLES_PATH` environment variable
  2. in the current directory
  3. at the path specified in the first argument

## Contributing

1. Fork it ( https://github.com/alphagov/govuk-dummy_content_store/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
