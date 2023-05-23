require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params['word']}"
    word_serialized = URI.open(url).read
    if JSON.parse(word_serialized)['found'] && (params['letters'].include? params['word'])
      @score = 10 * params['word'].length
      @message = "Congrats! You reached a score of #{@score}"
    elsif (params['letters'].include? params['word']) == false
      @score = 0
      @message = "Sorry but #{params['word']} can't be builed with the given letters"
    else
      @score = 0
      @message = 'No words found'
    end
  end
end

# for each letter in word compare with array of letters and delete every compared letter from the array
# word_array = params['word'].chars
