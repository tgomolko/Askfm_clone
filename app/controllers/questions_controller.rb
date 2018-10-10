class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:create]
  before_action :ensure_edit_question!, only: [:edit]
  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.where(user_id: current_user.id, answered: false)
    @answered_questions = Question.where(user_id: current_user.id, answered: true)
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to user_path(@question.user_id), notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    @question.answer = question_params[:answer]
    @question.answered = true
    respond_to do |format|
      if @question.save
        format.html { redirect_to user_path(@question.user_id), notice: 'Question was successfully answered.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:alert] = "Page not found!"
        redirect_to root_path
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:question, :user_id,:answer, :answered)
    end

    def ensure_edit_question!
       if current_user.id != @question.user_id
       redirect_to user_path(@question.user_id), notice: "You don't belong there!"
      end
    end
end
