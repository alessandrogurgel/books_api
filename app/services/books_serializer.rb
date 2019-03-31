module BooksSerializer
  def serialize_books(books, status_code = 200)
    {
      status_code: status_code,
      status: 'success',
      data: books
    }
  end

  def serialized_created_book(book, status_code = 201)
    {
      status_code: status_code,
      status: 'success',
      data: {
        book: book
      }
    }
  end
end