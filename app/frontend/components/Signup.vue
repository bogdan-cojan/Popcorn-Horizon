<template>
    <h4>Signup</h4>
    <form class="container-fluid" @submit.prevent="submit">
      <div class="form-floating mb-2">
      <input
        class="form-control"
        id="floatingEmail"
        v-model.trim="email"
        type="email" 
        placeholder="Email"
        required
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
        required
      />
      <label for="floatingPassword">Password</label>
    </div>
    <div class="form-floating mb-2">
      <input
        class="form-control"
        id="floatingPasswordConfirmation"
        v-model.trim="passwordConfirmation" 
        type="password" 
        placeholder="Password confirmation"
        required
      />
      <label for="floatingPassword">Password confirmation</label>
    </div>
    <div class="col d-flex justify-content-around">
      <button type="submit" class="btn btn-primary">Sign up</button>
      <button
          @click="$emit('login', true)"
          type="button"
          class="btn btn-outline-primary"
        >
        Login ?
      </button>
    </div>
  </form>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      email: '',
      password: '',
      passwordConfirmation: '',
    };
  },
  methods: {
    submit() {
      axios.post('/apis/v1/register', {
        user: {
          email: this.email,
          password: this.password,
          password_confirmation: this.passwordConfirmation,
        },
      }).then((response) => {
        localStorage.setItem('token', response.data.token);
        localStorage.setItem('username', response.data.username);
        axios.defaults.headers.common['Authorization'] = `Bearer ${response.data.token}`;
        window.location.href = '/';
      }).catch((error) => {
        console.error(error.response.data);
      });
    },
  },
};
</script>
