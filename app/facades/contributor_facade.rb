class ContributorFacade
  def self.contributor_or_error_msg
    json = GithubService.get_contributor_usernames
    json.any? {|c| c[:message]} ? json : create_contributor
    #ternary operator
  end

  def self.create_contributor
    json = GithubService.get_contributor_usernames
    json.map do |contributor|
      Contributor.new({login: contributor[:login], contributions: contributor[:contributions]})
    end
  end
end
