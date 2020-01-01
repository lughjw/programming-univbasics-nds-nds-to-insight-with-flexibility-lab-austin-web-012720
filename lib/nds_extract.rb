# Provided, don't edit
require 'directors_database'

# A method we're giving you. This "flattens"  Arrays of Arrays so: [[1,2],
# [3,4,5], [6]] => [1,2,3,4,5,6].

def flatten_a_o_a(aoa)
  result = []
  i = 0

  while i < aoa.length do
    k = 0
    while k < aoa[i].length do
      result << aoa[i][k]
      k += 1
    end
    i += 1
  end

  result
end

def movie_with_director_name(director_name, movie_data)
  { 
    :title => movie_data[:title],
    :worldwide_gross => movie_data[:worldwide_gross],
    :release_year => movie_data[:release_year],
    :studio => movie_data[:studio],
    :director_name => director_name
  }
end


# Your code after this point

def movies_with_director_key(name, movies_collection)
  # GOAL: For each Hash in an Array (movies_collection), provide a collection
  # of movies and a directors name to the movie_with_director_name method
  # and accumulate the returned Array of movies into a new Array that's
  # returned by this method.
  #
  # INPUT:
  # * name: A director's name
  # * movies_collection: An Array of Hashes where each Hash represents a movie
  #
  # RETURN:
  #
  # Array of Hashes where each Hash represents a movie; however, they should all have a
  # :director_name key. This addition can be done by using the provided
  # movie_with_director_name method
  
  a_o_h_movies_with_directors_names = []
  index = 0
  while index < movies_collection.size do
    a_o_h_movies_with_directors_names << movie_with_director_name(name, movies_collection[index])
    index += 1
  end
  
  a_o_h_movies_with_directors_names
end


def gross_per_studio(collection)
  # GOAL: Given an Array of Hashes where each Hash represents a movie,
  # return a Hash that includes the total worldwide_gross of all the movies from
  # each studio.
  #
  # INPUT:
  # * collection: Array of Hashes where each Hash represents a movie
  #
  # RETURN:
  #
  # Hash whose keys are the studio names and whose values are the sum
  # total of all the worldwide_gross numbers for every movie in the input Hash
  
  studio_totals = {}
  studios = studios_by_name(collection)
  
  index = 0
  while index < studios.size do
    studio_name = studios[index]
    studio_totals[studio_name] = calculate_studio_total(studio_name, collection)
    index += 1
  end
  
  studio_totals
end

def calculate_studio_total(studio_name, collection)
  # GOAL: Given the name of the studio sum up its total worldwide_gross
  # from the collection
  #
  # INPUT: 
  # * studio_name: name of the studio as a String
  # * collection: Array of Hashes where each Hash represents a movie
  #
  # RETURN: worldwide gross for that studio
  
  studio_gross = 0
  collection.each do |movie|
    if movie[:studio] == studio_name
      studio_gross += movie[:worldwide_gross]
    end
  end
  
  studio_gross
end

def studios_by_name(collection)
  # GOAL: Given an Array of Hashes where each Hash represents a movie,
  # return an Array of the names of the studios in the collection
  #
  # INPUT: 
  # * collection: Array of Hashes where each Hash represents a movie
  #
  # RETURN: Array of the names of the studios
  
  studios = []
  
  collection.each do |movie|
    studios << movie[:studio]
  end
  
  studios.uniq
end

def movies_with_directors_set(source)
  # GOAL: For each director, find their :movies Array and stick it in a new Array
  #
  # INPUT:
  # * source: An Array of Hashes containing director information including
  # :name and :movies
  #
  # RETURN:
  #
  # Array of Arrays containing all of a director's movies. Each movie will need
  # to have a :director_name key added to it.
  
  
  movies = []
  index = 0
  
  while index < source.size do
    director_name = source[index][:name]
    movies_collection = source[index][:movies]
    movies << movies_with_director_key(director_name, movies_collection)
    index += 1
  end
  
  movies
end

# ----------------    End of Your Code Region --------------------
# Don't edit the following code! Make the methods above work with this method
# call code. You'll have to "see-saw" to get this to work!

def studios_totals(nds)
  a_o_a_movies_with_director_names = movies_with_directors_set(nds)
  movies_with_director_names = flatten_a_o_a(a_o_a_movies_with_director_names)
  return gross_per_studio(movies_with_director_names)
end
