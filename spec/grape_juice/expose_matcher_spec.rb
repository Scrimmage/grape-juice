require 'spec_helper'

describe GrapeJuice::ExposeMatcher do

  context "rspec integration" do
    class PersonEntity < Grape::Entity
      expose :name
    end

    subject { PersonEntity }


    it { is_expected.to expose(:name) }
  end
end
