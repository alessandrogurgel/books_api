class Api::V1::BooksController < ApplicationController
  before_action :set_book, only: [:show, :update, :destroy]

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
      render json: serialize_created_book(@book), status: :created
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # GET /books/1
  def show
    if @book.present?
      render json: serialize_book(@book)
    else
      render json: { message: 'Entity not found' }, status: :not_found
    end
  end

  # DELETE /books/1
  def destroy
    if @book.present?
      @book.destroy
      render json: serialize_deleted_book(@book)
    else
      render json: { message: 'Entity not found' }, status: :not_found
    end
  end

  private

  def set_book
    @book = Book.find_by(id: params[:id])
  end

  def book_params
    params.require(:book).permit(:name, :isbn, :country, :number_of_pages, :publisher, :release_date, :authors => [])
  end
end
