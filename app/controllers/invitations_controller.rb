# -*- coding: utf-8 -*-
class InvitationsController < ApplicationController
  before_action :redirect_not_admin

  def new
  end

  def create
    invitation = Invitation.new
    invitation.save
    flash.now['success'] = "Invitation envoyé #{invitation.token}"
    render 'new'
  end

end
