<template>
  <h4>Login</h4>
  <form class="container-fluid" @submit.prevent="login">
    <div class="form-floating mb-2">
      <input
        class="form-control"
        id="floatingEmail"
        v-model.trim="email"
        type="email" 
        placeholder="Email"
      />
      <label for="floatingEmail">Email</label>
    </div>
    <div class="form-floating mb-2">
      <input
        class="form-control"
        id="floatingPassword"
        v-model.trim="password" 
        type="password" 
        placeholder="Password"
      />
      <label for="floatingPassword">Password</label>
    </div>
    <div class="col d-flex justify-content-around">
      <button type="submit" class="btn btn-primary">Login</button>
      <button
          @click="$emit('login', false)"
          type="button"
          class="btn btn-outline-primary"
        >
        Signup ?
      </button>
    </div>
  </form>
</template>

<script>
import axios from 'axios';

export default {
  name: "Login",
  data() {
    return {
      email: '',
      password: '',
    };
  },
  methods: {
    async login() {
      const response = await axios.post('/apis/v1/login', {
        email: this.email,
        password: this.password,
      });
      const token = response.data.token;
      const username = response.data.username;
      localStorage.setItem('token', token);
      localStorage.setItem('username', username);
      axios.defaults.headers.common['Authorization'] = `Bearer ${token}`;
      window.location.href = '/';
    },
  },
};
</script>
