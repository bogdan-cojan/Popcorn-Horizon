<template>
  <div id="main">
    <!-- <Movies /> -->
    <FormMovie />
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
};
</script>
