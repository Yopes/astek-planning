class JobsController < ApplicationController

  include JobsHelper

  def index
    time = get_time
    @date = display_date(time)
    @prev_date = serialize_date(time - 86400)
    @next_date = serialize_date(time + 86400)
    @current_date = serialize_date(time)
    @jobs = Job.where("date = '#{serialize_date(time)}'").all
  end

  def create
    date = JSON.parse(params[:date].gsub(/:([a-zA-z]+)/,'"\\1"').gsub('=>', ': '))
    date_value = date.symbolize_keys[:value]
    job = Job.new(date: date_value, todo: params[:todo])
    if job.user = User.find_by_login(params[:login])
      job.save
    else
      flash[:alert] = "Can't find user"
    end
    redirect_back
  end

end
