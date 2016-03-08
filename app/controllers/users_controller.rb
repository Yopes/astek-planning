# -*- coding: utf-8 -*-
require 'json'

class UsersController < ApplicationController

  def new
  end

  def create
    #p JSON.parse(params[:invitation].gsub(/:([a-zA-z]+)/,'"\\1"').gsub('=>', ': ')).symbolize_keys[:value]
    @user = User.new(user_params)
    if @user.save
      flash['success'] = 'Succès lors de la création du nouvel utilisateur'
      redirect_to root_path
    else
      flash.now['alert'] = 'Erreur lors de la création de l\'utilisateur'
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:login, :firstname, :lastname, :mail, :tel, :promo, :password, :invitation)
  end

end
