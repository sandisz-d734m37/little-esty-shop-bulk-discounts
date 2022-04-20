class ContributorFacade
  def self.contributor_or_error_msg
    json = GithubService.get_contributor_usernames
    # binding.pry if json[:message]
    json[:message].nil? ? create_repo : json
    # binding.pry if json.find {|c| c[:message] != nil}
    # json.any? {|c| c[:message]} ? json : create_contributor
    #ternary operator
  end

  def self.create_contributor
    json = GithubService.get_contributor_usernames
    json.map do |contributor|
      Contributor.new({login: contributor[:login], contributions: contributor[:contributions]})
    end
  end
end
