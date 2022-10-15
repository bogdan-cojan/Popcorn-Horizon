<template>
  <div class="col">
    <div class="card h-100">
      <!-- <img :src="movie.image" class="card-img-top" alt="poster_image" /> -->
      <div class="card-body">
        <h5 class="card-title">{{ movie.title }}</h5>
        <p class="card-text">{{ movie.rating }}</p>
      </div>
      <div class="card-footer">
        <small class="text-muted">{{ movie.trailer_link }}</small>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    movie: {},
  },
};
</script>

<style scoped></style>
