require 'rails_helper'

RSpec.describe GithubService do
  describe 'API Repo Endpoint' do
    it "gets repo data from the github endpoint", :vcr do
      json = GithubService.get_repo_data
      expect(json).to have_key(:name)
    end

  end

  describe 'API Contributor Endpoint' do
    it "gets contributor usernames from contributors endpoint", :vcr do
      json = GithubService.get_contributor_usernames
      json.each do |contributor|
        expect(contributor).to have_key(:login)
        expect(contributor).to have_key(:contributions)
      end
    end
  end
end
