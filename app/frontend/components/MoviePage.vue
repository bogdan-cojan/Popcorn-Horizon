<template>
  <ul class="nav nav-tabs" id="myTab" role="tablist">
    <li class="nav-item" role="presentation">
      <button
        class="nav-link active"
        id="home-tab"
        data-bs-toggle="tab"
        data-bs-target="#home-tab-pane"
        type="button"
        role="tab"
        aria-controls="home-tab-pane"
        aria-selected="true"
      >
        {{ movie.title }}
      </button>
    </li>
    <li class="nav-item" role="presentation">
      <button
        class="nav-link"
        id="book-tab"
        data-bs-toggle="tab"
        data-bs-target="#book-tab-pane"
        type="button"
        role="tab"
        aria-controls="book-tab-pane"
        aria-selected="true"
      >
        Rezerva bilet
      </button>
    </li>
  </ul>
  <div class="tab-content" id="myTabContent">
    <div
      class="tab-pane fade show active"
      id="home-tab-pane"
      role="tabpanel"
      aria-labelledby="home-tab"
      tabindex="0"
    >
      <MovieDetails :movie="movie" />
    </div>
    <div
      class="tab-pane fade show"
      id="book-tab-pane"
      role="tabpanel"
      aria-labelledby="book-tab"
      tabindex="1"
    >
      <Booking :movie="movie" />
    </div>
  </div>
</template>

<script>
import MovieDetails from "./MovieDetails.vue";
import Booking from "./Booking.vue";

export default {
  name: "MoviePage",
  props: ["movie"],
  components: {
    MovieDetails,
    Booking,
  },
};
</script>
