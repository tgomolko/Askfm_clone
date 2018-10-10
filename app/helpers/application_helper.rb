module ApplicationHelper
  def answered_questions_count
    @user.questions.where(answered: true).count
  end

  def unanswered_questions_count
    current_user.questions.where(answered: false).count if user_signed_in? 
  end
end
