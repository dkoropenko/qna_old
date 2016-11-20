class AnswersController < ApplicationController
  before_action :find_question, only: [:index, :new, :create]
  before_action :find_answer, only: [:show, :edit, :update, :destroy]


  def index
    @answers = @question.answers
  end

  def show
  end

  def new
    @answer = @question.answers.new
  end

  def edit
  end

  def create
    @answer = @question.answers.new answer_params
    @answer.user = current_user

    if @answer.save
      redirect_to question_path @question
    else
      render :new
    end
  end

  def update
    if @answer.update answer_update_params
      redirect_to questions_path
    else
      render :edit
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
    params.require(:answer).permit(:body)
  end

  def answer_update_params
    params.require(:answer).permit(:body, :question_id)
  end
end
