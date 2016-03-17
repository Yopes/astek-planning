# -*- coding: utf-8 -*-
require 'json'

class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    redirect_to root_path if signed_in?
  end

  def create
    redirect_to root_path if signed_in?
    invitation = JSON.parse(params[:invitation].gsub(/:([a-zA-z]+)/,'"\\1"').gsub('=>', ': '))
    token = invitation.symbolize_keys[:value]
    if user_params[:password] == params[:password_verification] and
        Invitation.find_by_token(token) and User.new(user_params).save
      Invitation.find_by_token(token).delete
      flash['success'] = 'Succès lors de la création du nouvel utilisateur'
      redirect_to root_path
    else
      flash.now['alert'] = 'Erreur lors de la création de l\'utilisateur'
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:login, :firstname, :lastname, :mail, :tel, :promo, :password)
  end

end
