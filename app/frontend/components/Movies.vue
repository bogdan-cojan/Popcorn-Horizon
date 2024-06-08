<template>
  <div class="container-fluid ps-5 row row-cols-1 row-cols-md-3 g-4">
    <div class="col" :key="movie.id" v-for="movie in this.list">
      <MovieCard v-if="!this.movie" :movie="movie" @click="showMovie(movie)" />
    </div>
  </div>
  <div v-if="this.movie" class="container-fluid">
    <div class="container-fluid d-flex justify-content-start m-1">
      <i @click="this.movie=null" style="color: green;font-size: 24px;cursor: pointer;" class="bi bi-arrow-left-circle-fill"></i>
    </div>
    <MoviePage :movie="this.movie" />
  </div>
</template>

<script>
import { mapState } from 'vuex';
import MovieCard from "./MovieCard.vue";
import MoviePage from "./MoviePage.vue";

export default {
  computed: mapState('movies', ['list']),
  data() {
    return {
      movie: null,
    };
  },
  methods: {
    showMovie(movie) {
      this.movie = movie;
    },
  },
  async created() {
    this.$store.dispatch('movies/index');
  },
  components: {
    MovieCard,
    MoviePage
},
};
</script>