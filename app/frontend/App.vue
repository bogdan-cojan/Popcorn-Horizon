<template>
  <div id="main">
    <Movies v-if="currentView === 'home'" />
    <MyTickets v-if="currentView === 'tickets'" />
  </div>
</template>

<script>
import Movies from "./components/Movies.vue";
import MyTickets from "./components/MyTickets.vue";
import { eventBus } from "./entrypoints/eventBus";

export default {
  name: "App",
  data() {
    return {
      currentView: 'home',
    };
  },
  components: {
    Movies,
    MyTickets
  },
  created() {
    eventBus.on('set-page', (view) => {
      this.currentView = view;
    })
  }
};
</script>

<style>
  @import './assets/stylesheets/style.css';
</style>