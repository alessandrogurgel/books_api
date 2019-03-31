require 'rails_helper'

RSpec.describe Api::ExternalBooksController, type: :controller do
  describe 'GET #index' do
    context 'when params containing name' do
      context 'when external api is available' do
        context 'when there are books' do
          it 'should return status 200', :vcr do
            get :index, { params: { name: 'A Clash of Kings' }}
            expect(response.status).to eq(200)
          end

          it 'should return the books in an appropriate structure', :vcr do
            get :index, { params: { name: 'A Clash of Kings' }}
            data = JSON.parse(response.body)
            expected_data = {
              'status' => 'success',
              'status_code' => 200,
              'data' =>
                [{'name' => 'A Clash of Kings',
                  'isbn' => '978-0553108033',
                  'authors' => ['George R. R. Martin'],
                  'number_of_pages' => 768,
                  'publisher' => 'Bantam Books',
                  'country' => 'United States',
                  'release_date' => '1999-02-02T00:00:00'}]
            }
            expect(data).to eq(expected_data)
          end
        end

        context 'when there is no book to return' do
          it 'should return status 200', :vcr do
            get :index, { params: { name: 'wrong book title' }}
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

      context 'when external api is unavailable' do
        it 'responds with service unavailable 503', :vcr do
          # we simulate service unavailable mocking response via vcr_cassettes
          get :index, { params: { name: 'A Clash of Kings' }}
          expect(response.status).to eq(503)
        end
      end

    end

    context 'when params is invalid (i.e. does not have name)' do
      it 'responds with bad request 400' do
        get :index
        expect(response.status).to eq(400)
      end
    end

  end
end