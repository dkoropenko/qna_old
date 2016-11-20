class QuestionsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_question, only: [:show, :edit, :update, :destroy]
  # before_action :find_user, only: [:create]

  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.new
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = Question.new question_params
    @question.user = current_user

    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def update
    if @question.update question_params
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    if @question.belongs? current_user
      @question.destroy
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
