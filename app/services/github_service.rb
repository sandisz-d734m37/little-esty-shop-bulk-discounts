class GithubService < BaseService
  def self.get_repo_data
    response = conn('https://api.github.com').get('/repos/phillipkamps/little-esty-shop')
    get_json(response)
  end

  def self.get_contributor_usernames
    response = conn('https://api.github.com').get('/repos/phillipkamps/little-esty-shop/contributors')
    get_json(response)
  end
end
