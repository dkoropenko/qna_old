class AnswersController < ApplicationController

  before_action :authenticate_user!
  before_action :find_question, only: [:create]
  before_action :find_answer, only: [:update, :choose_best_answer, :destroy]

  def create
    @answer = @question.answers.create answer_params
    @answer.user = current_user
    @answer.save
  end

  def update
    if @answer.belongs? current_user
      @answer.update answer_params
    end
  end

  def choose_best_answer
    @question = @answer.question

    if @question.belongs?(current_user) && @question.clear_best_answers
      @answer.update answer_params
    end
  end

  def destroy
    if @answer.belongs? current_user
      @answer.destroy
      redirect_to @answer.question
    else
      redirect_to @answer.question, notice: 'You can\'t delete this answer'
    end
  end

  private

  def find_answer
    @answer = Answer.find params[:id]
  end

  def find_question
    @question = Question.find params[:question_id]
  end

  def answer_params
    params.require(:answer).permit(:body, :is_best)
  end
end
