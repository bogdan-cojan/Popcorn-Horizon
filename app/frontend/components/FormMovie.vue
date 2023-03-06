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
      />
    </div>
    <div class="form-floating col-md-6">
      <input
        type="url"
        class="form-control"
        id="floatingTrailerLink"
        placeholder="Trailer link"
        v-model.trim="form.trailerLink"
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
        v-model="form.runningTime"
      />
      <label for="floatingRunningTime">Running time (minutes)</label>
    </div>
    <h5>Select the genres of the movie</h5>
    <div v-for="genre in genres" :key="genre.id" class="form-check col-auto">
      <input
        :value="genre.name"
        v-model="this.form.selectedGenres"
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
      />
      <label for="floatingDescription">Description</label>
    </div>
    <div class="col-auto">
      <button type="submit" class="btn btn-primary">Save</button>
    </div>
  </form>
</template>

<script>
export default {
  data() {
    return {
      form: {
        title: "",
        rating: 0.0,
        trailerLink: "",
        image: {},
        year: 1900,
        runningTime: 1,
        selectedGenres: [],
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
  methods: {
    onFileChange(e) {
      var file = e.target.files || e.dataTransfer.files;
      if (!file.length) return;
      this.form.image = file[0];
    },

    async submitHandler() {
      // let bodyContent = JSON.stringify({
      //   title: movie_params.title,
      //   image: movie_params.image,
      // });

      const formData = new FormData();

      // for (const name in this.form) {
      //   formData.append(name, this.form[name]);
      // }

      formData.append("title", this.form.title);
      formData.append("rating", this.form.rating);
      formData.append("trailer_link", this.form.trailerLink);
      formData.append("image", this.form.image);
      formData.append("year", this.form.year);
      formData.append("running_time", this.form.runningTime);
      formData.append("genres", JSON.stringify(this.form.selectedGenres));
      formData.append("description", this.form.description);

      // console.log(formData);

      const res = await fetch("/apis/v1/movies", {
        method: "POST",
        body: formData,
      });

      console.log(res.status);
    },
  },
};
</script>
