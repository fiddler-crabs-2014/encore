require 'spec_helper'

describe User do

  describe "associations" do
    it { should have_many(:attended_concerts) }
    it { should have_many(:concerts).through(:attended_concerts) }
  end

end
