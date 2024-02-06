defmodule LendingLibWeb.BookView do
  use LendingLibWeb, :view

  def author_select_options(authors) do
    for author <- authors, do: {author.name, author.id}
  end

  def genre_select_options(genres) do
    for genre <- genres, do: {genre.name, genre.id}
  end
end
