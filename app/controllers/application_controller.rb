class ApplicationController < ActionController::Base
  before_action :repo_info, only: [:index, :show, :edit, :new]
  before_action :contributor_info, only: [:index, :show, :edit, :new]

  def repo_info
    @repo = RepositoryFacade.repo_or_error_msg
  end

  def contributor_info
    @contributors = ContributorFacade.contributor_or_error_msg
  end
end
