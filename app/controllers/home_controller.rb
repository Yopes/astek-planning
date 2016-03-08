# -*- coding: utf-8 -*-
class HomeController < ApplicationController

  def index
  end

  def new
  end

  def create
    user = User.auth(params[:user][:login],
                     params[:user][:password])
    if user.nil?
      flash.now[:alert] = 'Erreur lors de la connexion'
      render 'new'
    else
      #sign_in user
      flash[:success] = 'Vous êtes désormais connecté'
      redirect_to root_path
    end
  end

end
