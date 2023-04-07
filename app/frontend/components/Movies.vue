<template>
  <div class="container-fluid row row-cols-1 row-cols-md-3 g-4">
    <div class="col" :key="movie.id" v-for="movie in this.movies">
      <MovieCard :movie="movie" />
    </div>
  </div>
</template>

<script>
import MovieCard from "./MovieCard.vue";
import { eventBus } from "../entrypoints/eventBus";

export default {
  data() {
    return {
      movies: [],
    };
  },
  methods: {
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
  },
};
</script>
