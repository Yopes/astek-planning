class JobsController < ApplicationController

  include JobsHelper

  def index
    time = Time.new
    @date = "#{week_day[time.wday]} #{time.day} #{months[time.month]} #{time.year}"
    @users = []
    begin
      Job.all.find_by_date!(serialize_date(time)).each do |job|
        @users << job.user
      end
      rescue
    end
  end

end
