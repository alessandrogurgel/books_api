module BooksSerializer
  def serialize_books(books, status_code = 200)
    {
      status_code: status_code,
      status: 'success',
      data: books
    }
  end
end