class GamesController < ApplicationController
  def new
    @letters = (0...8).map { rand(97..122).chr }
    session[:letters] = @letters
  end

  def score
    word_array = params[:word].chars
    @letters = session[:letters]
    letters_match = true
    @message = ''

    word_array.each do |letter|
      @letters.include?(letter) ? @letters.delete(letter) : letters_match = false
    end

    require 'json'
    require 'open-uri'
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    result = JSON.parse(open(url).read)

    if letters_match == true && result['found'] == true
      @message = 'Correct!'
    elsif letters_match == false
      @message = 'This does not match the original string...'
    elsif result['found'] == false
      @message = 'This is not a valid word...'
    end
  end
end
