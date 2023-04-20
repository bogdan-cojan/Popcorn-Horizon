<template>
  <div class="container-fluid">
    <Login v-if="isLoginVisible" @login="updateLogin" />
    <Signup v-else @login="updateLogin" />
  </div>
</template>

<script>
import Login from './components/Login.vue';
import Signup from './components/Signup.vue';

export default {
  name: "Users",
  data() {
    return {
      isLoginVisible: true,
    }
  },
  components: {
    Login,
    Signup,
  },
  methods: {
    updateLogin(login) {
      this.isLoginVisible = login;
    }
  },
}
</script>
