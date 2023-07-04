class CartsController < ApplicationController
    before_action :authenticate_user!


    def index
        books = current_user.cart ? current_user.books : []
        render json: {
            data: {
                books: books,
                price: calculate_books_price()
            }
        }
    end

    def create
        if params[:book_id]
            book_id = params[:book_id]
            begin
                book = Book.find(book_id)
                cart = Cart.new(book_id: book_id, user_id: current_user.id)

                if cart.save
                    render json: {
                        data: current_user.books
                    }
                else
                    render json: {
                        errors: cart.errors
                    }
                end
            rescue ActiveRecord::RecordNotFound
                render json: {
                    errors: 'Book do not exist'
                }
            end

        else 
            render json: {
                errors: 'book_id is required'
            }
        end
    end

    def delete
        if params[:book_id]
            book_id = params[:book_id]
            begin
                book = Book.find(book_id)
                if current_user.books.include?(book)
                  if current_user.books.find(book.id).destroy
                    render json: {
                        data: current_user.books
                    }
                  else
                    render json: {
                        errors: 'something went wrong'
                    }
                  end
                else
                    render json: {
                        errors: 'Book do not exist in cart'
                    }    
                end
            rescue ActiveRecord::RecordNotFound
                render json: {
                    errors: 'Book do not exist'
                }
            end

        else 
            render json: {
                errors: 'book_id is required'
            }
        end
    end


    def calculate_books_price
        return current_user.books.sum(:price)
    end
end