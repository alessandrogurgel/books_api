module ExternalBooksSerializer
  def serialize_books(books, status_code = 200)
    {
      status_code: status_code,
      status: 'success',
      data: books.map { |b|
        {
          name: b['name'],
          isbn: b['isbn'],
          authors: b['authors'],
          number_of_pages: b['numberOfPages'],
          publisher: b['publisher'],
          country: b['country'],
          release_date: b['released']
        }
      }
    }
  end
end