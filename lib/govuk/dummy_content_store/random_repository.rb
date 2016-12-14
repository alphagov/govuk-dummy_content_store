module Govuk
  module DummyContentStore
    class RandomRepository
      attr_reader :schema_name

      def generate(schema_name)
        JSON.dump(GovukSchemas::RandomExample.for_schema(frontend_schema: schema_name).payload)
      end
    end
  end
end
