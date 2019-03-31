class Api::ExternalBooksController < ApplicationController
  include ExternalBooksFetcher
  include ExternalBooksSerializer

  def index
    if invalid_params?
      render json: { message: 'Invalid parameters. You should send the name of the book via \'name\' param' }, status: :bad_request
      return
    end
    success, books = fetch_books(valid_params[:name])
    if success
      render json: serialize_books(books)
    else
      render json: { message: 'API external books unavailable at this time.' }, status: :service_unavailable
    end
  end

  private

  def invalid_params?
    name = valid_params[:name]
    name.blank?
  end

  def valid_params
    params.permit(:name)
  end
end
