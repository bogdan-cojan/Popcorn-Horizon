<template>
  <div class="form-group">
    <label for="date">Select a date:</label>
    <input
      v-model="form.date"
      class="form-control"
      type="date"
      name="date"
      :min="minDate"
      :max="maxDate"
      required
    />
    <div class="btn-group mt-4 d-flex justify-content-center" role="group">
      <button
        v-for="(time, timeIndex) in times"
        :key="timeIndex"
        @click="form.time = time"
        type="button"
        class="btn m-1 rounded fw-bold"
        :class="{
          'btn-success': form.time === time,
          'btn-warning': form.time !== time,
        }">
          {{ time }}
      </button>
    </div>
  </div>
</template>

<script>
export default {
  inject: ["form"],
  name: "SelectDates",
  mounted() {
    this.getMinMaxDates();
  },
  data() {
    return {
      times: ["16:00", "19:30", "23:00"],
      minDate: "",
      maxDate: "",
    }
  },
  methods: {
    getMinMaxDates() {
      const today = new Date().toISOString().split("T")[0];
      const oneMonthLater = new Date();
      oneMonthLater.setMonth(oneMonthLater.getMonth() + 1);
      this.minDate = today;
      this.maxDate = oneMonthLater.toISOString().split("T")[0];
    },
  },
};
</script>