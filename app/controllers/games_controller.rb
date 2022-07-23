require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    word = params[:word]
    letters = params[:letters].split(' ')
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)
    # raise
    if user["found"] == true
      if word_in_grid?(word, letters)
        @result = "<b>Congratulations!</b> #{word.upcase} is a valid English word!".html_safe
      else
        @result = "Sorry but <b>#{word.upcase}</b> can't be built out of #{letters.join(', ').upcase}".html_safe
      end
    else user["found"] == false
      @result= "Sorry but <b>#{word.upcase}</b> does not seem to be a valid English word...".html_safe
    end
    # raise
  end

  private

  def word_in_grid?(word, letters)
    arr = word.split(//)
    # raise
    return true if (arr - letters).empty?
  end
end
