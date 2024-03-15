<template>
  <div id="main">
    <Movies />
  </div>
</template>

<script>
import Movies from "./components/Movies.vue";

export default {
  name: "App",
  components: {
    Movies,
  },
};
</script>

<style>
  @import './assets/stylesheets/style.css';
</style>
