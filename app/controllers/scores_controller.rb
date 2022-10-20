class ScoresController < ApplicationController
  before_action :set_score, only: %i[ show edit update destroy ]

  # GET /scores or /scores.json
  def index
    @scores = Score.all
    session[:prev_page] = 'index_score'
  end

  # GET /scores/1 or /scores/1.json
  def show
  end

  # GET /scores/new
  def new
    @score = Score.new
  end

  # GET /scores/1/edit
  def edit
  end

  # POST /scores or /scores.json
  def create
    @score = Score.new(score_params)
    respond_to do |format|
      if @score.save
        if session[:prev_page] === "edit_score_student"
          format.html do
            redirect_to edit_score_student_path({id: session[:student_id]})
          end
        else
          format.html { redirect_to score_url(@score), notice: "Score was successfully created." }
          format.json { render :show, status: :created, location: @score }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scores/1 or /scores/1.json
  def update
    puts(session[:prev_page])
    respond_to do |format|
      if @score.update(score_params)
          if session[:prev_page] === "edit_score_student"
            format.html do
              redirect_to edit_score_student_path({id: session[:student_id]})
            end
          else
            format.html { redirect_to score_url(@score), notice: "Score was successfully updated." }
            format.json { render :show, status: :ok, location: @score }
          end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scores/1 or /scores/1.json
  def destroy
    @score.destroy
    
    if session[:prev_page] === "edit_score_student"
      redirect_to edit_score_student_path({id: session[:student_id]})
    else
      respond_to do |format|
        format.html { redirect_to scores_url, notice: "Score was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_score
      @score = Score.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def score_params
      params.require(:score).permit(:subject, :point, :grade, :student_id)
    end
end
