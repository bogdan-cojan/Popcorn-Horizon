<template>
  {{ message }}

  <ButtonCounter />
</template>

<script>
import ButtonCounter from "./components/ButtonCounter.vue";

export default {
  data() {
    return {
      message: "Hello Vue.js !",
    };
  },
  components: {
    ButtonCounter,
  },
};
</script>
