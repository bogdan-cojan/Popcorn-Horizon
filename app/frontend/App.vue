<template>
  <div id="main">
    <div class="btn-group" role="group">
      <button
        v-on:click="moviesBtnClicked()"
        type="button"
        class="btn btn-outline-primary"
      >
        Movies
      </button>
      <button
        v-on:click="newMovieBtnClicked()"
        type="button"
        class="btn btn-outline-primary"
      >
        Create movie
      </button>
    </div>
    <div id="movies">
      <Movies />
    </div>
    <div id="newMovie">
      <FormMovie />
    </div>
  </div>
</template>

<script>
import Movies from "./components/Movies.vue";
import FormMovie from "./components/FormMovie.vue";

export default {
  components: {
    Movies,
    FormMovie,
  },
  methods: {
    moviesBtnClicked() {
      var movies = document.querySelector("#movies");
      var newMovieForm = document.querySelector("#newMovie");
      movies.style.display = "block";
      newMovieForm.style.display = "none";
    },

    newMovieBtnClicked() {
      var movies = document.querySelector("#movies");
      var newMovieForm = document.querySelector("#newMovie");
      movies.style.display = "none";
      newMovieForm.style.display = "block";
    },
  },
};
</script>

<style scoped>
#newMovie {
  display: none;
}
</style>
