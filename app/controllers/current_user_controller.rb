class CurrentUserController < ApplicationController
  before_action :authenticate_user!, only: :get_user
  before_action :authenticate_author!, only: :get_author

  def get_user
    if current_user
      render json: {
        data: current_user
      }  
    end
  end

  def get_author
    if current_author
      render json: {
        data: current_author
      }
    end
  end

end
