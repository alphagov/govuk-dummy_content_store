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

It will look for the schema files in the following locations:

  1. at the path specified by the `GOVUK_CONTENT_SCHEMAS_PATH` environment variable
  2. in the current directory
  3. at the path specified in the first argument

If a fallback url is specified on startup:

    $ dummy_content_store -u https://www.gov.uk/api/content

  or 

    $ DUMMY_CONTENT_STORE_FALLBACK_URL=https://www.gov.uk/api/content dummy_content_store

it will look also for live contents at the specified url, if the example content is not found.

## Configuration

By default the dummy content store runs on port 3068 which is the same port as
content store. If you want run it on a different port you can configure it
using the `PORT` environment variable:

    $ PORT=9999 dummy_content_store

## Contributing

1. Fork it ( https://github.com/alphagov/govuk-dummy_content_store/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
