class SettingsController < ApplicationController
  def index
    @settings = Setting.all.order({ :created_at => :desc })

    render({ :template => "settings/index.html.erb" })
  end

  def show
    the_id = params.fetch("id_from_path")
    @setting = Setting.where({:id => the_id }).at(0)

    render({ :template => "settings/show.html.erb" })
  end
  def stats
    the_id = params.fetch("id_from_path")
    @setting = Setting.where({:id => the_id }).at(0)
    setting_results = Result.where(:setting_id => @setting.id)
    # num_slices = setting_results.length / 100
    # times = []
    # scores = []
    # setting_results.each_slice(num_slices).to_a.each do |group|
    #   group.each do |result|
    #end
    @total_correct = setting_results.where("correct_answer == user_answer").group_by { |c| c.created_at.to_date }
    @total_attempts = setting_results.group_by { |c| c.created_at.to_date }
    
    @data = [["Date", "Percent Correct"]]
    @total_attempts.keys.each do |date|
      if @total_correct[date] == nil
        @data.push([date, 0.0])
      else
        @data.push([date, @total_correct[date].length*100/@total_attempts[date].length])
      end
    end


    render({ :template => "settings/stats.html.erb" })
  end
  def practice
    s = Setting.where(:id => params.fetch(:id_from_path)).first
    @current_setting = s
    first_digit = rand(s.upper_digit_limit - s.lower_digit_limit) + s.lower_digit_limit
    second_digit = rand(s.upper_digit_limit - s.lower_digit_limit) + s.lower_digit_limit
    operation_list = []
    if s.multiplication == true
      operation_list.push("x")
    end
    if s.division == true
      operation_list.push("/")
    end
    if s.addition == true
      operation_list.push("+")
    end
    if s.subtraction == true
      operation_list.push("-")
    end
    operation = rand(operation_list.length)
    operation_hash = {"x" => 0, "/" => 1, "+" => 2, "-" => 3}
    @problem = first_digit.to_s + operation_list[operation] + second_digit.to_s
    # ensure that all answers are whole numbers
    if operation_list[operation] == "/"
      @problem = (first_digit * second_digit).to_s + "/" + second_digit.to_s
    end
    if operation_list[operation] == "x"
      @answer = first_digit * second_digit
    elsif operation_list[operation] == "/"
      @answer = first_digit
    elsif operation_list[operation] == "+"
      @answer = first_digit + second_digit
    elsif operation_list[operation] == "-"
      @answer = first_digit - second_digit
    end
    @problem_info = {:first_number_from_query => first_digit,
                      :second_number_from_query => second_digit, 
                      :operation_from_query => operation_hash.fetch(operation_list[operation]), 
                      :correct_answer_from_query => @answer}
    # @current_result = Results.new
    # @current_result.setting_id = s.id
    # @current_result.first_digit = first_digit
    # @current_result.second_digit = second_digit
    # @current_result.operation = operation
    # @current_result.correct_answer = @answer
    # @next_url = request.original_url
    # @next_url[-1] = @next_url[-1] + 1
    
    render({ :template => "settings/game.html.erb"})
  end

  def create
    @setting = Setting.new
    @setting.owner_id = params.fetch("owner_id_from_query")
    @setting.upper_digit_limit = params.fetch("upper_digit_limit_from_query")
    @setting.lower_digit_limit = params.fetch("lower_digit_limit_from_query")
    @setting.multiplication = params.fetch("multiplication_from_query", false)
    @setting.addition = params.fetch("addition_from_query", false)
    @setting.division = params.fetch("division_from_query", false)
    @setting.subtraction = params.fetch("subtraction_from_query", false)

    if @setting.valid?
      @setting.save
      redirect_to("/settings", { :notice => "Setting created successfully." })
    else
      redirect_to("/settings", { :notice => "Setting failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("id_from_path")
    @setting = Setting.where({ :id => the_id }).at(0)

    @setting.owner_id = params.fetch("owner_id_from_query")
    @setting.upper_digit_limit = params.fetch("upper_digit_limit_from_query")
    @setting.lower_digit_limit = params.fetch("lower_digit_limit_from_query")
    @setting.multiplication = params.fetch("multiplication_from_query", false)
    @setting.addition = params.fetch("addition_from_query", false)
    @setting.division = params.fetch("division_from_query", false)
    @setting.subtraction = params.fetch("subtraction_from_query", false)

    if @setting.valid?
      @setting.save
      redirect_to("/settings/#{@setting.id}", { :notice => "Setting updated successfully."} )
    else
      redirect_to("/settings/#{@setting.id}", { :alert => "Setting failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("id_from_path")
    @setting = Setting.where({ :id => the_id }).at(0)

    @setting.destroy

    redirect_to("/settings", { :notice => "Setting deleted successfully."} )
  end
end
