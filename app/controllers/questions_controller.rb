class QuestionsController < ApplicationController
  before_action :set_question!, only: %i[destroy edit show update]

  def create
    @question = Question.new question_params
    if @question.save
      flash[:success] = "Question created!"
      redirect_to questions_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy
    flash[:success] = "Question deleted!"
    redirect_to questions_path
  end

  def edit
  end

  def index
    @pagy, @questions = pagy Question.order(created_at: :desc)
    @questions = @questions.decorate
  end

  def new
    @question = Question.new
  end

  def show
    @question = @question.decorate
    @answer = @question.answers.build
    @pagy, @answers = pagy @question.answers.order(created_at: :desc)
    @answers = @answers.decorate
  end

  def update
    if @question.update question_params
      flash[:success] = "Question updated!"
      redirect_to questions_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def question_params
    params.require("question").permit(:title, :body)
  end

  def set_question!
    @question = Question.find(params[:id])
  end
end
