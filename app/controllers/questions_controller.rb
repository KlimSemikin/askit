# frozen_string_literal: true

class QuestionsController < ApplicationController
  include QuestionsAnswers

  before_action :require_authentication, except: %i[show index]
  before_action :set_question!, only: %i[destroy edit show update]
  before_action :authorize_question!
  after_action :verify_authorized

  def create
    @question = current_user.questions.build question_params
    if @question.save
      respond_to do |format|
        format.html do
          flash[:success] = t('.success')
          redirect_to questions_path
        end

        format.turbo_stream do
          @question = @question.decorate
          flash.now[:success] = t('.success')
        end
      end
    else
      render :new
    end
  end

  def destroy
    @question.destroy
    flash[:success] = t('.success')
    redirect_to questions_path, status: :see_other
  end

  def edit; end

  def index
    @tags = Tag.where(id: params[:tag_ids]) if params[:tag_ids]
    @pagy, @questions = pagy Question.all_by_tags(params[:tag_ids]), link_extra: 'data-turbo-frame="pagination"'
    @questions = @questions.decorate
  end

  def new
    @question = Question.new
  end

  def show
    load_question_answers
  end

  def update
    if @question.update question_params
      respond_to do |format|
        format.html do
          flash[:success] = t('.success')
          redirect_to questions_path
        end

        format.turbo_stream do
          @question = @question.decorate
          flash.now[:success] = t('.success')
        end
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, tag_ids: [])
  end

  def set_question!
    @question = Question.find(params[:id])
  end

  def authorize_question!
    authorize(@question || Question)
  end
end
