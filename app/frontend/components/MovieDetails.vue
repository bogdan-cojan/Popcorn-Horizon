<template>
  <div class="card mb-3 w-100">
    <div class="row g-0">
      <div class="col-md-3">
        <img style="max-width: 360px;" :src="movie.image" class="img-fluid rounded-start" alt="poster">
      </div>
      <div class="col-md-9">
        <div class="card-body">
          <h5 class="card-title">{{ movie.title }}</h5>
          <p class="card-text d-flex justify-content-around">
            <div class="badge text-bg-primary"> Rating: {{ movie.rating }} 
              <i class="bi bi-star-fill" style="color: yellow"></i>
            </div>
            <div class="badge text-bg-primary"> Release year: {{ movie.year }} </div>
            <div class="badge text-bg-primary"> Running time: {{ movie.running_time }} mins</div>
          </p>
          <p class="card-text">{{ movie.description }}</p>
          <p class="card-text d-flex justify-content-between w-50">
            <div class="badge rounded-pill text-bg-primary" v-for="genre in movie.genres">
              {{ genre }}
            </div>
          </p>
          <a 
            class="btn btn-primary position-absolute bottom-0 m-4" style="right: 0"
            role="button"
            :href="movie.trailer_link" target="_blank">
              <i class="bi bi-play-fill" style="color: red"></i>
              Watch trailer
          </a>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: "MovieDetails",
    props: ["movie"],
  }
</script>
