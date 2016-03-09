# -*- coding: utf-8 -*-
class HomeController < ApplicationController

  def index
    redirect_to signin_path if !signed_in?
  end

  def new
    redirect_to root_path if signed_in?
  end

  def create
    redirect_to root_path if signed_in?
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

  def destroy
    if signed_in?
      sign_out
    end
    redirect_to root_path
  end

end
