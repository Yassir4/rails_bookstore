class CurrentUserController < ApplicationController
  before_action :authenticate_user!, only: :get_user
  before_action :authenticate_author!, only: :get_author

  def get_user
    if current_user
      render json: {
        data: user_json()
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

  private
    def user_json
      {
        id: current_user.id,
        username: current_user.username,
        email: current_user.email,
        books_ids: current_user.cart ? current_user.books.map { |b| b[:id] } : []
      }
    end
end

