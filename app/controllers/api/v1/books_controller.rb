class Api::V1::BooksController < ApplicationController
  include BooksSerializer
  # GET /books
  def index
    @books = Book.all
    render json: serialize_books(@books)
  end

  # POST /books
  def create
    @book = Book.new(book_params)
    if @book.save
      render json: serialized_created_book(@book), status: :created
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  private

  def book_params
    params.require(:book).permit(:name, :isbn, :country, :number_of_pages, :publisher, :release_date, :authors => [])
  end
end
