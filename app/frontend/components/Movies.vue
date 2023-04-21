<template>
  <div class="container-fluid row row-cols-1 row-cols-md-3 g-4">
    <div class="col" :key="movie.id" v-for="movie in this.movies">
      <MovieCard v-if="!this.movie" :movie="movie" @click="showMovie(movie)" />
    </div>
  </div>
  <div v-if="this.movie" class="container-fluid">
    <div class="container-fluid" @click="this.movie=null">
      <i style="color: green;font-size: 24px;" class="bi bi-arrow-left-circle-fill"></i>
    </div>
    <Movie :movie="this.movie" />
  </div>
</template>

<script>
import MovieCard from "./MovieCard.vue";
import { eventBus } from "../entrypoints/eventBus";
import Movie from "./Movie.vue";

export default {
  data() {
    return {
      movies: [],
      movie: null,
    };
  },
  methods: {
    showMovie(movie) {
      this.movie = movie;
    },

    async fetchMovies() {
      const res = await fetch("/apis/v1/movies");
      const data = await res.json();
      this.movies = data;
    },
  },
  async created() {
    await this.fetchMovies();
    eventBus.on('new-movie-added', async () => {
      await this.fetchMovies();
    })
  },
  components: {
    MovieCard,
    Movie
  },
};
</script>
