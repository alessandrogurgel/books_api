class Api::V1::BooksController < ApplicationController
  include BooksSerializer
  # GET /books
  def index
    @books = Book.all
    render json: serialize_books(@books)
  end
end
