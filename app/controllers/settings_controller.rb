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

  def practice
    s = Setting.where(:id => params.fetch(:id_from_path)).first
    first_digit = rand(s.upper_digit_limit - s.lower_digit_limit) + s.lower_digit_limit
    second_digit = rand(s.upper_digit_limit - s.lower_digit_limit) + s.lower_digit_limit
    operation = rand(4)
    operation_list = ["x", "/", "+", "-"]

    @problem = first_digit.to_s + operation_list[operation] + second_digit.to_s
    if operation == 0
      @answer = first_digit * second_digit
    elif operation == 1
      @answer = first_digit * second_digit
    elif operation == 2
      @answer = first_digit * second_digit
    elif operation == 3
      @answer = first_digit * second_digit
    end

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
