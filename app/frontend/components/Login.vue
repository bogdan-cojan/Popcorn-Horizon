<template>
  <form class="container-fluid w-50 mt-5" @submit.prevent="login">
    <h4>Login</h4>
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
      const admin = response.data.admin;
      const email = response.data.email;
      localStorage.setItem('token', token);
      localStorage.setItem('admin', admin);
      localStorage.setItem('email', email);
      await cookieStore.set({
        name: 'username',
        value: username,
        expires: new Date(Date.now() + 86400000),
      });
      axios.defaults.headers.common['Authorization'] = `Bearer ${token}`;
      window.location.href = '/';
    },
  },
};
</script>