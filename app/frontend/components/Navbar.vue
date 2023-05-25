<template>
  <div class="fixed-top mt-2 ms-3" title="Settings">
    <a href="/admin">
      <i style="color: red" class="bi bi-gear-fill"></i>
    </a>
  </div>
  <div class="container-fluid d-flex justify-content-center mt-1 mb-2" role="group">
      <button
        @click="sendHome()"
        type="button"
        class="btn btn-outline-primary me-1"
      >
        Home
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

    sendHome() {
      if(window.location.pathname !== "/"){
        window.location.href = "/";
      }
    }
  }
}
</script>
