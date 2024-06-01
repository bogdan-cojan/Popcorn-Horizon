<template>
  <div v-if="currentUser.admin === 'true'" class="fixed-top mt-2 ms-3" title="Settings">
    <a href="/admin">
      <i style="color: red" class="bi bi-gear-fill"></i>
    </a>
  </div>
  <div class="container-fluid d-flex mt-1 mb-2" role="group">
      <div class="d-flex w-50 justify-content-end">
        <button
          @click="select('home')"
          type="button"
          class="btn btn-outline-primary"
        >
          Home
        </button>
        <button
          v-if="currentUser.token"
          @click="select('tickets')"
          type="button"
          class="btn btn-outline-primary"
        >
          Bilete
        </button>
      </div>
      <div class="d-flex w-50 justify-content-end">
        <div v-if="username" class="badge text-bg-primary d-flex justify-content-center align-items-center" style="width: 6rem;">
          {{ this.username }}
        </div>
        <button v-if="currentUser.token" @click="logout"
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
  </div>
</template>

<script>
import axios from 'axios';
import { eventBus } from '../entrypoints/eventBus';

export default {
  name: "Navbar",
  data() {
    return {
      currentUser: {token: localStorage.getItem('token'), admin: localStorage.getItem('admin')}, 
      username: '',
    }
  },
  async created() {
    this.username = await this.setUsername(); 
  },
  methods: {
    logout() {
      localStorage.removeItem('token');
      localStorage.removeItem('admin');
      localStorage.removeItem('email');
      cookieStore.delete('username');
      delete axios.defaults.headers.common['Authorization'];
      window.location.href = "/";
    },

    async setUsername() {
      const usernameCookie = await cookieStore.get('username');
      if(usernameCookie){
        return usernameCookie.value;
      }
    },

    select(view) {
      if(window.location.pathname !== '/'){
        window.location.href = '/';
      }else {
        eventBus.emit('set-page', view);
      }
    }
  }
}
</script>