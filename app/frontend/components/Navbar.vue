<template>
  <div class="btn-group" role="group">
      <button
        @click="emitMoviesBtnClicked"
        type="button"
        class="btn btn-outline-primary"
      >
        Home
      </button>
      <button
        @click="emitNewMovieBtnClicked"
        type="button"
        class="btn btn-outline-primary"
      >
        Create movie
      </button>
      <button v-if="currentUser.username" @click="logout"
      type="button" class="btn btn-outline-primary"
      >Logout</button>
      <a v-else class="nav-link" href="/users">
        <button
          type="button"
          class="btn btn-outline-primary"
        >
          Login
        </button>
      </a>
  </div>
</template>

<script>
import axios from 'axios';
import { eventBus } from '../entrypoints/eventBus';

export default {
  name: "Navbar",
  data() {
    return {
      currentUser: {username: localStorage.getItem('username'), token: localStorage.getItem('token')} 
    }
  },
  methods: {
    logout() {
      localStorage.removeItem('token');
      localStorage.removeItem('username');
      delete axios.defaults.headers.common['Authorization'];
      window.location.href = "/";
    },

    changeUrl(url) {
      if(window.location.pathname !== url) {
        window.history.pushState({}, '', url);
        location.reload();
      }
    },

    emitMoviesBtnClicked() {
      this.changeUrl("/");
      eventBus.emit('movies-btn-clicked', true);
    },

    emitNewMovieBtnClicked() {
      this.changeUrl("/");
      eventBus.emit('new-movie-btn-clicked', false);
    }
  }
}
</script>
