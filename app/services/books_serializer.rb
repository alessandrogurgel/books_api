module BooksSerializer
  def serialize_books(books)
    {
      status_code: 200,
      status: 'success',
      data: books
    }
  end

  def serialize_created_book(book)
    {
      status_code: 201,
      status: 'success',
      data: {
        book: book
      }
    }
  end

  def serialize_deleted_book(book)
    {
      status_code: 204,
      status: 'success',
      message: "The book #{book.name} was deleted successfully",
      data: []
    }
  end

  def serialize_updated_book(book)
    {
      status_code: 200,
      status: 'success',
      message: "The book #{book.name} was updated successfully",
      data: book
    }
  end

  def serialize_book(book)
    {
      status_code: 200,
      status: 'success',
      data: book
    }
  end

end