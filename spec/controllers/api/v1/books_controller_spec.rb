require 'rails_helper'

RSpec.describe Api::V1::BooksController, type: :controller do
  describe 'GET #index' do
    context 'when there are books' do
      context 'with no filter params' do
      end
      it 'returns all books' do
        5.times do
          create(:book)
        end

        get :index
        expect(assigns(:books).count).to eq(5)
      end

      it 'returns all books in an appropriate structure' do
        book = create(:book)
        get :index
        data = JSON.parse response.body
        expected_data = {
          'status' => 'success',
          'status_code' => 200,
          'data' => [{'name' => book.name,
                      'isbn' => book.isbn,
                      'authors' => [book.authors.first],
                      'number_of_pages' => book.number_of_pages,
                      'publisher' =>  book.publisher,
                      'country' => book.country,
                      'release_date' => book.release_date.to_s(:db)}]
        }
        expect(data).to eq(expected_data)
      end
    end
  end

  context 'when there are no books' do
    it 'should return status 200' do
      get :index
      expect(response.status).to eq(200)
      data = JSON.parse(response.body)
      expected_data = {
        'status' => 'success',
        'status_code' => 200,
        'data' => []
      }
      expect(data).to eq(expected_data)
    end
  end
end
