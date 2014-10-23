module ApplicationHelper

  require 'net/http'
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
  def get_repo_id_array(array_of_repo_hashes)
    repo_id_array = []

    array_of_repo_hashes.each do |array|
      repo_id_array << array["id"]
    end

    return repo_id_array
  end

  # Iterate over every user repo by contributor and add THEIR contributions to total
  # Using input like this [23433435,123434542,7665675,567796575], we find all contributors
  # on each of those repos and only count the contributions by TeaLeaf student
  def get_total_commits(array_of_repo_id_numbers, username)

      total_contributions = 0

      array_of_repo_id_numbers.each do |number|
        uri = URI("https://api.github.com/repositories/#{number}/contributors")
        repo_contributors = Net::HTTP.get(uri)
        contributor_json = JSON.parse(repo_contributors)

        contributor_json.each do |contributor|
          if contributor["login"] == username
            total_contributions += contributor["contributions"].to_i
          else
            total_contributions += 0
          end
        end
      end

      return total_contributions
  end

end


#uri = URI("https://api.github.com/repositories/1685240/contributors")
#repo_contributors = Net::HTTP.get(uri)
#contributor_json = JSON.parse(repo_contributors)

#include ApplicationHelper
#my_repos = get_user_repos("jcasimir")
#my_repo_array = get_repo_id_array(my_repos)
#get_total_commits(my_repo_array, "jcasimir")

#[1685240, 2316254, 3789416, 8977592, 1437638, 9148800, 1162928, 5179150, 2289540, 544593, 1247174, 377675, 4007609, 3839552, 6770435, 10456182, 6090681, 4393257, 3939825, 17426801, 3552346, 14999461, 15557465, 1303975, 15291654, 632160, 3071714, 8184774, 24399580, 7963942]

