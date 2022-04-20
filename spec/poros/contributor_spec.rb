require 'rails_helper'

RSpec.describe Contributor do
  it "exists and has attributes" do
      data = { name: "j bonez", login: 1000 }
      repo = Contributor.new(data)

      expect(repo).to be_a(Contributor)
      expect(repo.name).to eq(data[:name])
  end
end
