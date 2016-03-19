# -*- coding: utf-8 -*-
class HomeController < ApplicationController

  include PlanningHelper

  def index
    if !signed_in?
      redirect_to signin_path
    else
      time = Time.new
      next_job = current_user.jobs.where(["date >= ?", serialize_date(time)]).order(date: :asc).first
      if !next_job.nil?
        @next_working_day = display_date(get_time(next_job.date))
        @serialized_date = serialize_date(get_time(next_job.date))
      else
        @next_working_day = "No work planned"
      end
       @next_working_day = "Today" if @next_working_day == display_date(time) 
    end
  end

  def new
    redirect_to root_path if signed_in?
  end

  def create
    if signed_in?
      redirect_to root_path
    else
      user = User.auth(params[:user][:login],
                       params[:user][:password])
      if user.nil?
        flash.now[:alert] = 'Erreur lors de la connexion'
        render 'new'
      else
        sign_in user
        flash[:success] = 'Vous êtes désormais connecté'
        redirect_to root_path
      end
    end
  end

  def destroy
    if signed_in?
      sign_out
    end
    redirect_to root_path
  end

end
