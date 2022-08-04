require 'httparty'
require 'pry'

class GithubAPIService

    github =  GithubAPIService.new
    # def initialize
        
    # end
    def get_user
        response = HTTParty.get("https://api.github.com/repos/brennacodes/little-esty-shop")
        JSON.parse(response.body, symbolize_names: true)
    end
end