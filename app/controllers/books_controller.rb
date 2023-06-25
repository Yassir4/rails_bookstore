class BooksController < ApplicationController
    before_action :authenticate_author!, only: [:create, :edit, :add_avatar]

    def show
        if params[:id] 
            begin
                book = Book.find(params[:id])
                render json: {
                    data: book_json(book)
                }
            rescue ActiveRecord::RecordNotFound
                render json: {
                    errors: 'Book not found'
                }
            end
        end
    end


    def all
        if params[:page] and Book.page(params[:page])
            books_page = Book.page(params[:page]).map do |book|
                {
                   id: book.id,
                   title: book.title,
                   description: book.description,
                   cover_url: cover_url(book),
                   created_at: book.created_at,
                   price: book.price
                }
                end
            
               render json: {
                    data: {
                        books: books_page,
                        next_page: Book.page(params[:page]).next_page 
                    }
                }
        else
            render json: {
                errors: 'something went wrong'
            }
        end
    end

    def create 
        book = current_author.books.new(book_params)
        if book.valid?
            book.save
            render json: {
                data: book_json(book)
            }
        else
            render json: {
                errors: book.errors
            }
        end
    end

    def add_cover
        book_id = params[:id]
        book_cover = params[:cover]
        if book_cover && book_id
            book = Book.find(book_id)
            if book
                book.cover.attach(book_cover)
                render json: {
                    cover_url:  url_for(rails_blob_url(book.cover))
                }
            else
                render json: {
                    errors: 'Book not found'
                }
            end
        else 
            render json: {
                errors: 'make sure book id and cover exists'
            }
        end
    end
    
    def destroy
        book = Book.find(params[:id])
        book.destroy
        render json: {
            data: {
                message: 'Book Deleted successfully'
            }
        }
    
    end

    def update
        book_id = params[:id]
        if book_id
            book = Book.find(book_id)
            if book
                book.update(book_params)
                render json: {
                    data: book_json(book)
                }
            else
                render json: {
                    errors: 'Book not found'
                }
            end
        else 
            render json: {
                errors: 'make sure book id exists'
            }
        end
    end
    

    private

    def book_params
        params.permit(:title, :description, :cover, :price)
    end

    def book_json(book)
        {
            book: {
                id: book.id,
                title: book.title,
                description: book.description,
                cover_url: cover_url(book),
                created_at: book.created_at,
                price: book.price
            }
        }
    end

    def cover_url(book)
        if book.cover.attached?
            url_for(rails_blob_url(book.cover))
        else
            nil
          # Return a default or placeholder image URL if cover is not attached
          # You can customize this as per your requirements
        #   "default_cover_url"
        end
    end
    

end
