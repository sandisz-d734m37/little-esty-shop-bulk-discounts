require "rails_helper"

RSpec.describe ContributorFacade do
  it "creates contributor poros", :vcr do
    contributors = ContributorFacade.create_contributor
    contributors.each do |c|
      expect(c).to be_a(Contributor)
    end
  end
end
