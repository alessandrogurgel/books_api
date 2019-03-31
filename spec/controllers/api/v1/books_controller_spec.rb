require 'rails_helper'

RSpec.describe Api::V1::BooksController, type: :controller do
  describe 'GET #index' do
    context 'when there are books' do
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

    context 'when we use searchable params' do
      before do
        (1..10).each do |i|
          create(:book, name: "book #{i}")
        end
        2.times do
          create(:book, country: 'Argentina')
        end

        3.times do
          create(:book, publisher: 'Acme Books')
        end

        4.times do
          create(:book, release_date: 25.years.ago)
        end
      end
      context 'using name' do
        it 'returns only one book' do
          get :index, params: { by_name: 'book 10' }
          expect(assigns(:books).count).to eq(1)
        end
      end

      context 'using country' do
        it 'returns two books' do
          get :index, params: { by_country: 'Argentina' }
          expect(assigns(:books).count).to eq(2)
        end
      end

      context 'using publisher' do
        it 'returns only three books' do
          get :index, params: { by_publisher: 'Acme Books' }
          expect(assigns(:books).count).to eq(3)
        end
      end

      context 'using release_date' do
        it 'returns only fourth books' do
          get :index, params: { by_release_date: 25.years.ago.year }
          expect(assigns(:books).count).to eq(4)
        end
      end
    end
  end

  describe 'POST #create' do
    context 'when book body is valid' do
      let!(:valid_attributes) do
        {
          name: "My First Book",
          isbn: "123-3213243567",
          authors: [
            "John Doe"
          ],
          number_of_pages: 350,
          publisher: "Acme Books",
          country: "United States",
          release_date: "2019-08-01"
        }
      end

      it 'returns 201' do
        post :create, {
          params: {
            book: valid_attributes
          }
        }
        expect(response.status). to eq(201)
      end

      it 'creates the requested book' do
        expect do
          post :create, {
            params: {
              book: valid_attributes
            }
          }
        end.to change(Book, :count).from(0).to(1)

      end

      it 'returns the created book in an appropriate structure' do
        post :create, {
          params: {
            book: valid_attributes
          }
        }
        data = JSON.parse response.body
        expected_data = {
          'status' => 'success',
          'status_code' => 201,
          'data' => {
             'book' => {
               'name' => "My First Book",
               'isbn' => "123-3213243567",
               'authors' => ["John Doe"],
               'number_of_pages' => 350,
               'publisher' =>  "Acme Books",
               'country' => "United States",
               'release_date' => "2019-08-01"
             }
          }
        }
        expect(data).to eq(expected_data)
      end
    end

    context 'when book body is not valid' do
      let!(:invalid_attributes) do
        {
          name: nil,
          isbn: "123-3213243567",
          authors: [
            "John Doe"
          ],
          number_of_pages: 350,
          publisher: "Acme Books",
          country: "United States",
          release_date: "2019-08-01"
        }
      end
      it 'returns 422' do
        post :create, {
          params: {
            book: invalid_attributes
          }
        }
        expect(response.status). to eq(422)
      end
    end
  end

  describe 'GET #show' do
    context 'when book exists' do
      let!(:book) { create(:book)}

      it 'returns 200' do
        get :show, { params: { id: book.id } }
        expect(response.status). to eq(200)
      end

      it 'returns it in an appropriate structure' do
        get :show, { params: { id: book.id } }
        data = JSON.parse response.body
        expected_data = {
          'status' => 'success',
          'status_code' => 200,
          'data' => {'name' => book.name,
                      'isbn' => book.isbn,
                      'authors' => [book.authors.first],
                      'number_of_pages' => book.number_of_pages,
                      'publisher' =>  book.publisher,
                      'country' => book.country,
                      'release_date' => book.release_date.to_s(:db)}
        }
        expect(data).to eq(expected_data)
      end
    end

    context 'when book does not exists' do
      it 'returns 404' do
        get :show, { params: { id: -1 } }
        expect(response.status). to eq(404)
      end
    end
  end

  describe 'PUT #update' do
    context 'when params are valid' do
      let!(:valid_attributes) do
        {
          name: "My First Book",
          isbn: "123-3213243567",
          authors: [
            "John Doe"
          ],
          number_of_pages: 350,
          publisher: "Acme Books",
          country: "United States",
          release_date: "2019-08-01"
        }
      end
      let!(:book){ create(:book) }
      it 'returns 200' do
        put :update, { params: { id: book.id, book: valid_attributes } }
        expect(response.status). to eq(200)
      end

      it 'returns the updated book in an appropriate structure' do
        put :update, { params: { id: book.id, book: valid_attributes } }
        data = JSON.parse response.body
        expected_data = {
          'status' => 'success',
          'status_code' => 200,
          'message' => 'The book My First Book was updated successfully',
          'data' => {
            'name' => "My First Book",
            'isbn' => "123-3213243567",
            'authors' => ["John Doe"],
            'number_of_pages' => 350,
            'publisher' =>  "Acme Books",
            'country' => "United States",
            'release_date' => "2019-08-01"
          }
        }
        expect(data).to eq(expected_data)
      end

      context 'when element is not found' do
        it 'returns 404' do
          put :update, { params: { id: -1 } }
          expect(response.status). to eq(404)
        end
      end
    end

    context 'when params are invalid' do
      let!(:book){ create(:book) }
      let!(:invalid_attributes){ { name: nil } }

      it 'returns 422' do
        put :update, { params: { id: book.id,book: invalid_attributes } }
        expect(response.status). to eq(422)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when book exists' do
      let!(:book) { create(:book, name: 'My First Book')}

      it 'destroys the requested book' do
        expect {
          delete :destroy, params: { id: book.id }
        }.to change(Book, :count).by(-1)
      end
      it 'returns an appropriate structure' do
        delete :destroy, params: { id: book.id }
        data = JSON.parse response.body
        expected_data = {
          'status' => 'success',
          'status_code' => 204,
          'message' => 'The book My First Book was deleted successfully',
          'data' => []
        }
        expect(data).to eq(expected_data)
      end
    end
    context 'when book does not exist' do
      it 'returns 404' do
        delete :destroy, { params: { id: -1 } }
        expect(response.status). to eq(404)
      end
    end
  end
end
