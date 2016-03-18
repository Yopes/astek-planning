class PlanningController < ApplicationController
  before_action :redirect_not_connected
  before_action :redirect_not_admin, only: [:create_job, :create_task]

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
    job = Job.new(date: date_value)
    job.task = nil
    if !params[:todo].empty? and
        (job.task = Task.where(["todo = ? and date = ?", params[:todo], date_value]).first).nil?
      flash[:alert] = "Activity does not exist"
    else
      if job.user = User.find_by_login(params[:login])
        job.save
        if !job.task.nil?
          job.task.people += 1
          job.task.save
        end
        job.user.past_days += 1
        job.user.save
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
