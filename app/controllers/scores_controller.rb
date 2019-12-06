class ScoresController < ApplicationController
  def index
    @scores = Score.all.order({ :created_at => :desc })

    render({ :template => "scores/index.html.erb" })
  end

  def show
    the_id = params.fetch("id_from_path")
    @score = Score.where({:id => the_id }).at(0)

    render({ :template => "scores/show.html.erb" })
  end

  def create
    @score = Score.new
    @score.total_score = params.fetch("total_score_from_query")
    @score.question_types = params.fetch("question_types_from_query")
    @score.response_times = params.fetch("response_times_from_query")
    @score.setting_id = params.fetch("setting_id_from_query")

    if @score.valid?
      @score.save
      redirect_to("/scores", { :notice => "Score created successfully." })
    else
      redirect_to("/scores", { :notice => "Score failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("id_from_path")
    @score = Score.where({ :id => the_id }).at(0)

    @score.total_score = params.fetch("total_score_from_query")
    @score.question_types = params.fetch("question_types_from_query")
    @score.response_times = params.fetch("response_times_from_query")
    @score.setting_id = params.fetch("setting_id_from_query")

    if @score.valid?
      @score.save
      redirect_to("/scores/#{@score.id}", { :notice => "Score updated successfully."} )
    else
      redirect_to("/scores/#{@score.id}", { :alert => "Score failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("id_from_path")
    @score = Score.where({ :id => the_id }).at(0)

    @score.destroy

    redirect_to("/scores", { :notice => "Score deleted successfully."} )
  end
end
