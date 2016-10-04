class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: [:edit, :update, :destroy]
  before_action :set_question, only: [:new, :edit, :create, :update, :destroy]
  before_action :create_answer, only: :create

  # GET /answers/new
  def new
    @answer = Answer.new(question_id: @question.id)
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers
  # POST /answers.json
  def create
    respond_to do |format|
      if @answer.save
        format.html { redirect_to @question, notice: 'Answer was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @question, notice: 'Answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to @question, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_answer
    @answer = Answer.find(params[:id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def answer_params
    params.require(:answer).permit(:body, :question_id, :user_id)
  end

  def create_answer
    @answer = Answer.new(answer_params)
    @answer.user = current_user
    @answer.question = @question
  end
end
