class PlanningController < ApplicationController

  include PlanningHelper

  def index
    time = get_time
    @date = display_date(time)
    @prev_date = serialize_date(time - 86400)
    @next_date = serialize_date(time + 86400)
    @current_date = serialize_date(time)
    @jobs = Job.where("date = '#{serialize_date(time)}'").all
    @tasks = Task.where("date = '#{serialize_date(time)}'").all
  end

  def create_job
    date = JSON.parse(params[:date].gsub(/:([a-zA-z]+)/,'"\\1"').gsub('=>', ': '))
    date_value = date.symbolize_keys[:value]
    job = Job.new(date: date_value, todo: params[:todo])
    if !params[:todo].empty? and
        Task.where(["todo = ? and date = ?", params[:todo], date_value]).first.nil?
      flash[:alert] = "Activity does not exist"
    else
      if job.user = User.find_by_login(params[:login])
        job.save
      else
        flash[:alert] = "Can't find user"
      end
    end
    redirect_back
  end

  def create_task
    date = JSON.parse(params[:date].gsub(/:([a-zA-z]+)/,'"\\1"').gsub('=>', ': '))
    date_value = date.symbolize_keys[:value]
    task = Task.new(date: date_value, todo: params[:todo], need: params[:need])
    task.save
    redirect_back
  end

end
