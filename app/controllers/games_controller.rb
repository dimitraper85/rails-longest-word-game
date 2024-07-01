require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array('A'..'Z').sample(10)
  end

  def score
    @word = params[:word].upcase.chars
    @letters = params[:letters]
    url = "https://dictionary.lewagon.com/#{@word.join}"
    result_serialized = URI.open(url).read
    @api_results = JSON.parse(result_serialized)
    @word.each do |letter|
      if @letters.include? letter
        if @api_results["found"] == true
          @result = "Congratulations! The word #{@word.join} is a valid english word with #{@api_results["length"]} characters."
        else
          @result = "The word #{@word.join} is not a valid english word..."
        end
      else
        @result = "The word #{@word.join} can’t be built out of the original grid..."
      end
    end
  end
end
