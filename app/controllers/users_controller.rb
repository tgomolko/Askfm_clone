class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :following, :followers, :feed]
  before_action :authenticate_user!, except: [:show, :index]
  
  def index
    @users = User.last(5)
  end

  def new
  end

  def show
    @question =  Question.new
    @question.user_id = params[:id]
    @answered_questions = @user.questions.where(answered: true).order("created_at DESC")
  end

  def following
    @following_users = @user.following
  end

  def followers
    @user_followers = @user.followers
  end

  def feed
    @feeds = Question.where(user_id: @user.following_ids, answered: true).order("created_at DESC")
  end

  private

    def set_user
      @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:notice] = "User not found!"
        redirect_to root_path
    end
end
