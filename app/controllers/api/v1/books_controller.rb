class Api::V1::BooksController < ApplicationController
  before_action :set_book, only: [:show, :update, :destroy]

  has_scope :by_name, only: [:index]
  has_scope :by_publisher, only: [:index]
  has_scope :by_country, only: [:index]
  has_scope :by_release_date, only: [:index]

  include BooksSerializer
  # GET /books
  def index
    @books = apply_scopes(Book).all
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

  # PATCH/PUT /books/1
  def update
    unless @book.present?
      render json: { message: 'Entity not found' }, status: :not_found
      return
    end
    if @book.update(book_params)
      render json: serialize_updated_book(@book)
    else
      render json: @book.errors, status: :unprocessable_entity
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
