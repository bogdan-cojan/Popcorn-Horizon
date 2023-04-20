<template>
  <div class="card h-100 w-50">
    <img :src="movie.image" class="card-img-top rounded" alt="poster_image" />
    <div class="card-body">
      <h5 class="card-title">{{ movie.title }}</h5>
      <p class="card-text">{{ movie.rating }} 
        <i style="color: yellow" class="bi bi-star-fill"></i></p>
    </div>
    <div class="card-footer d-flex justify-content-around">
      <a
        :href="movie.trailer_link"
        target="_blank"
        class="btn btn-primary"
        role="button"
        ><i style="color: red" class="bi bi-play-btn-fill"></i> Trailer</a
      >
      <a
        href="/"
        class="btn btn-primary rounded-circle"
        title="Info"
        role="button"
        ><i style="color: rebeccapurple" class="bi bi-info-square-fill"></i></a
      >
    </div>
  </div>
</template>

<script>
export default {
  name: "MovieCard",
  props: ["movie"],
};
</script>
