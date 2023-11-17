<template>
  <div class="container mt-2 w-75">
    <form @submit.prevent="saveUserInfo()">
      <div class="mb-3" v-for="input in inputDetails" :key="input">
        <label class="form-label">*{{ input }}</label>
        <input
          type="text"
          class="form-control"
          :placeholder="input"
          required
          :disabled="isFormComplete"
        />
      </div>

      <div class="d-flex justify-content-center">
        <button v-if="noUserInfos" type="submit" class="btn btn-primary">
          Save
        </button>
      </div>
    </form>
  </div>
</template>

<script>
export default {
  name: "UserDetails",
  data() {
    return {
      inputDetails: ["First Name", "Last Name", "E-mail"],
      noUserInfos: true,
      isFormComplete: false,
      user: {
        firstName: "",
        lastName: "",
        email: "",
      },
    };
  },
  methods: {
    saveUserInfo() {
      if (
        this.user.firstName.length !== 0 &&
        this.user.lastName.length !== 0 &&
        this.user.email.length !== 0
      ) {
        this.isFormComplete = true;
        this.noUserInfos = false;
        this.$emit("user-details", this.user);
      }
    },
  },
};
</script>
