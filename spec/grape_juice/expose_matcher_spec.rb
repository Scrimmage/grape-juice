require 'spec_helper'

describe GrapeJuice::ExposeMatcher do

  context "rspec integration" do
    class AddressEntity
    end
    class PersonEntity < Grape::Entity
      expose :name

      expose :address, using: AddressEntity

    end

    subject { PersonEntity }


    it { is_expected.to expose(:name) }
    it { is_expected.to expose(:address).using(AddressEntity) }
  end
end
