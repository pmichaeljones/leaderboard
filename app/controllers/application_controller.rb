class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  require 'Net::HTTP'
  require 'JSON'

  # Using GitHub API, pull an hash of all of the user's public repos
  def get_user_repos(github_username)
    uri = URI("https://api.github.com/users/#{github_username}/repos")
    response = Net::HTTP.get_response(uri)
    if response.message == 'OK'
      user_repos = Net::HTTP.get(uri)
      JSON.parse(user_repos)
    else
      flash[:danger] = "There was an error. Did you write your correct GitHub username?"
    end
  end

  # Parse repo hash and return an array of every repo ID number
  # Array returned is an array of public repo IDs: example: [23433435,123434542,7665675,567796575]
  def get_repo_id_array(hash_of_all_public_repos)

  end

  # Iterate over every user repo by contributor and add THEIR contributions to total
  # Using input like this [23433435,123434542,7665675,567796575], we find all contributors
  # on each of those repos and only count the contributions by TeaLeaf student
  def get_total_commits(array_of_repo_id_numbers)
    uri = URI('https://api.github.com/repositories/25378418/contributors')


    uri = URI('https://api.github.com/repositories/25378418/contributors')
    my_repos = Net::HTTP.get(uri)
    JSON.parse(my_repos)

  end

end
