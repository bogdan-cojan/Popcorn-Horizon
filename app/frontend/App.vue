<template>
  <div id="main">
    <Movies v-if="isChildVisible" />
    <FormMovie v-if="!isChildVisible" />
  </div>
</template>

<script>
import Movies from "./components/Movies.vue";
import FormMovie from "./components/FormMovie.vue";
import { eventBus } from "./entrypoints/eventBus";

export default {
  name: "App",
  data() {
    return {
      isChildVisible: true,
    }
  },
  components: {
    Movies,
    FormMovie
  },
  created() {
    eventBus.on('movies-btn-clicked', eventData => { 
      this.isChildVisible = eventData;
    })
    eventBus.on('new-movie-btn-clicked', eventData => { 
      this.isChildVisible = eventData;
    })
    eventBus.on('new-movie-added', () => {
      this.isChildVisible = true;
    })
  },
};
</script>
