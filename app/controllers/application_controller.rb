class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :initialize_question

  def initialize_question
    @question = Question.new
  end
end
