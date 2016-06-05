alias PitchforkApi.Repo
alias PitchforkApi.Artist
alias PitchforkApi.Album

albums = [
  %{name: "The Fan-Tas-Tic Box Set", rating: 8.5, artist: "Slum Village"},
  %{name: "Eyes on the Lines", rating: 9.0, artist: "Steve Gunn"},
  %{name: "The Wailing Wailers", rating: 8.0, artist: "The Wailers"},
  %{name: "Still They Pray", rating: 7.6, artist: "Cough"},
  %{name: "iiiDrops", rating: 8.2, artist: "Joey Purp"}
]

for album <- albums do
  artist = Repo.get_by(Artist, name: album.artist) ||
    Repo.insert!(%Artist{name: album.artist})

  Repo.insert!(%Album{name: album.name, rating: album.rating, artist_id: artist.id})
end
