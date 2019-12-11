class ResultsController < ApplicationController
  def index
    @results = Result.all.order({ :created_at => :desc })

    render({ :template => "results/index.html.erb" })
  end

  def show
    the_id = params.fetch("id_from_path")
    @result = Result.where({:id => the_id }).at(0)

    render({ :template => "results/show.html.erb" })
  end

  def create
    @result = Result.new
    @result.first_number = params.fetch("first_number_from_query")
    @result.second_number = params.fetch("second_number_from_query")
    @result.operation = params.fetch("operation_from_query")
    @result.correct_answer = params.fetch("correct_answer_from_query")
    @result.user_answer = params.fetch("user_answer_from_query")
    @result.setting_id = params.fetch("id_from_path")

    if @result.valid?
      @result.save
      redirect_to("/settings/" + params.fetch("id_from_path") +"/practice/0", { :notice => "Result created successfully." })
    else
      redirect_to("/settings", { :notice => "Result failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("id_from_path")
    @result = Result.where({ :id => the_id }).at(0)

    @result.first_number = params.fetch("first_number_from_query")
    @result.second_number = params.fetch("second_number_from_query")
    @result.operation = params.fetch("operation_from_query")
    @result.correct_answer = params.fetch("correct_answer_from_query")
    @result.user_answer = params.fetch("user_answer_from_query")
    @result.score_id = params.fetch("score_id_from_query")

    if @result.valid?
      @result.save
      redirect_to("/results/#{@result.id}", { :notice => "Result updated successfully."} )
    else
      redirect_to("/results/#{@result.id}", { :alert => "Result failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("id_from_path")
    @result = Result.where({ :id => the_id }).at(0)

    @result.destroy

    redirect_to("/results", { :notice => "Result deleted successfully."} )
  end

  def destroy_all
    user_settings= Setting.where(:owner_id => session.fetch(:user_id))
    user_settings.each do |user_s|
      Result.where(:setting_id => user_s).each do |result|
        result.destroy
      end

    end

    redirect_to("/results", { :notice => "All results deleted successfully."} )
  end
end
