<template>
  <div class="container-fluid">
    <BookingForm :movie="movie" />
  </div>
</template>

<script>
import BookingForm from "./BookingForm.vue";

export default {
  name: "Booking",
  props: ["movie"],
  components: {
    BookingForm,
  },
};
</script>
