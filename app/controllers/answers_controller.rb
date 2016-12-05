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
    @answer.update answer_params
  end

  def choose_best_answer
    @question = @answer.question
    @answer.make_best!
  end

  def destroy
    @question = @answer.question
    @answer.destroy
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
