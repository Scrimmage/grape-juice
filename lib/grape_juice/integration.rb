require 'grape_juice/expose_matcher'
require 'grape_juice/integration/rspec'

module GrapeJuice
  module Integration

    if defined?(Rspec)
      require 'grape_juice/integration/rspec'
    end

  end
end
