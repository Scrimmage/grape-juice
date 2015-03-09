module GrapeJuice
  module Integration
    module Rspec

      RSpec.configure do |config|
        config.include GrapeJuice::ExposeMatcher
      end

    end
  end
end
