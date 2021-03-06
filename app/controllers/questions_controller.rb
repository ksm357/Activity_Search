class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  # before_action :is_owner?, only: [:edit, :update, :destroy]
  load_and_authorize_resource
  
  def index
    @questions = Question.all
  end

  def show
    @questionComment = QuestionComment.new
    @questionComments = @question.question_comments
  end

  def new
    @question = Question.new
  end
  
  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to @question
    else
      render :new
    end
  end

  def edit
    unless current_user == @question.user
      redirect_to @question
    end
  end
  
  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end
  
  def destroy
    @question.destroy!
    redirect_to root_path
  end
  
  
  
  private
  
    def set_question
      @question = Question.find(params[:id])
    end
    
    def question_params
    params.require(:question).permit(:questionTitle, :questionContent, :user_id)
    end
    
end
