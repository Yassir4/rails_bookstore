class CurrentUserController < ApplicationController
  before_action :authenticate_user!
  def index
    if current_user
      render json: {
        user: current_user
      }  
    end
  end
end
