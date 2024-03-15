<template>
  <form
    class="container-fluid row g-3 align-items-center"
    enctype="multipart/form-data"
    @submit.prevent="submitHandler"
  >
    <div class="form-floating col-md-6">
      <input
        class="form-control"
        id="floatingTitle"
        placeholder="Title"
        v-model.trim="form.title"
        required
      />
      <label for="floatingTitle">Title</label>
    </div>
    <div class="form-floating col-md-6">
      <input
        class="form-control"
        type="number"
        step=".1"
        min="0.0"
        max="10.0"
        placeholder="Rating"
        id="floatingRating"
        v-model="form.rating"
        required
      />
      <label for="floatingRating">Rating</label>
    </div>
    <div class="col-md-6">
      <label for="inputImage">Image (Poster Movie)</label>
      <input
        type="file"
        class="form-control"
        id="inputImage"
        v-on:change="onFileChange"
        v-bind:required="!movie"
      />
      <small v-if="movie" class="form-text text-muted">
        <i class="bi bi-exclamation-triangle-fill text-warning"></i>
        Current image: <span class="text-warning">{{ this.imageName }}</span>. You only need to choose a new image if you want to change the current one.
      </small>
    </div>
    <div class="form-floating col-md-6">
      <input
        type="url"
        class="form-control"
        id="floatingTrailerLink"
        placeholder="Trailer link"
        v-model.trim="form.trailer_link"
        required
      />
      <label for="floatingTrailerLink">Trailer link (YouTube)</label>
    </div>
    <div class="form-floating col-md-6">
      <input
        type="number"
        min="1900"
        class="form-control"
        id="floatingYear"
        placeholder="Year"
        v-model="form.year"
        required
      />
      <label for="floatingYear">Year</label>
    </div>
    <div class="form-floating col-md-6">
      <input
        type="number"
        min="1"
        max="150"
        class="form-control"
        id="floatingRunningTime"
        placeholder="Running time"
        v-model="form.running_time"
        required
      />
      <label for="floatingRunningTime">Running time (minutes)</label>
    </div>
    <h5>Select the genres of the movie</h5>
    <div v-for="genre in genres" :key="genre.id" class="form-check col-auto">
      <input
        :value="genre.name"
        v-model="form.genres"
        class="form-check-input"
        type="checkbox"
        id="gridCheck"
      />
      <label class="form-check-label" for="gridCheck">
        {{ genre.name }}
      </label>
    </div>
    <div class="form-floating">
      <input
        type="textarea"
        class="form-control"
        id="floatingDescription"
        placeholder="Description"
        style="height: 100px"
        v-model.trim="form.description"
        required
      />
      <label for="floatingDescription">Description</label>
    </div>
    <div class="col-auto">
      <button type="submit" class="btn btn-primary me-4">Save</button>
      <button @click="handleCancel" type="submit" class="btn btn-secondary">Cancel</button>
    </div>
  </form>
</template>

<script>
export default {
  props: ["movie"],
  data() {
    return {
      newImageSelected: false,
      imageName: "",
      form: this.movie || {
        title: "",
        rating: 0.0,
        trailer_link: "",
        image: {},
        year: 1900,
        running_time: 1,
        genres: [],
        description: "",
      },
      genres: [
        { id: 1, name: "Action" },
        { id: 2, name: "Horror" },
        { id: 3, name: "Thriller" },
        { id: 4, name: "Drama" },
        { id: 5, name: "Science fiction" },
        { id: 6, name: "Western" },
        { id: 7, name: "Comedy" },
        { id: 8, name: "Romance" },
        { id: 9, name: "Crime" },
        { id: 10, name: "Fantasy" },
        { id: 11, name: "Adventure" },
        { id: 12, name: "Animation" },
        { id: 13, name: "Mystery" },
        { id: 14, name: "War" },
        { id: 15, name: "Documentary" },
      ],
    };
  },
  created() {
    this.imageName = this.getImageName();
  },
  methods: {
    handleCancel(){
      this.form = {
        title: "",
        rating: 0.0,
        trailer_link: "",
        image: {},
        year: 1900,
        running_time: 1,
        genres: [],
        description: "",
      };
      this.$emit("cancel");
    },

    getImageName() {
      if (!this.movie) return "";
      return new URL(this.movie.image).pathname.split('/').pop();
    },

    onFileChange(e) {
      var file = e.target.files || e.dataTransfer.files;
      if (!file.length) return;
      this.form.image = file[0];
      this.newImageSelected = true;
    },

    async submitHandler() {
      if (this.movie) {
        this.$store.dispatch('updateMovie', { movie: this.form, newImageSelected: this.newImageSelected });
      } else {
        this.$store.dispatch('createMovie', this.form);
      }
    },
  },
};
</script>
