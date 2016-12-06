class QuestionsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_question, only: [:show, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new question_params
    @question.user = current_user

    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      redirect_to new_question_path, notice: 'Question not saved. Check attributes.'
    end
  end

  def update
    @question.update(question_params)
  end

  def destroy
    if @question.destroy
      redirect_to questions_path
    else
      render :edit, notice: 'You cannot delete this question'
    end
  end

  private

  def find_user
    @user = User.find params[:user_id]
  end

  def find_question
    @question = Question.find params[:id]
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
