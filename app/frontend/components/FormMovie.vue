<template>
  <form
    enctype="multipart/form-data"
    action="http://localhost:5100/apis/v1/movies"
    method="POST"
  >
    <div>
      <label for="title">Title</label>
      <input name="title" />
    </div>
    <div>
      <label for="image">Movie poster</label>
      <input name="image" type="file" />
    </div>
    <div>
      <button type="submit">Create</button>
    </div>
  </form>
</template>

<script>
export default {
  methods: {
    async submitHandler(movie_params) {
      let bodyContent = JSON.stringify({
        title: movie_params.title,
        image: movie_params.image,
      });

      const res = await fetch("/apis/v1/movies", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: bodyContent,
      });

      console.log(res.status);
    },
  },
};
</script>
