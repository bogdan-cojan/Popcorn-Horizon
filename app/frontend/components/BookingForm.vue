<template>
  <div class="container">
    <div class="row">
      <div class="col-md-6">
        <h2 class="d-flex justify-content-center mb-2">
          Buy ticket for {{ movie.title }}
        </h2>
        <div class="form-group">
          <label for="date">Select a date:</label>
          <input
            v-model="form.date"
            class="form-control"
            type="date"
            name="date"
            :min="minDate"
            :max="maxDate"
          />
          <div
            class="btn-group mt-4 d-flex justify-content-center"
            role="group"
          >
            <button
              v-for="(clock, clockIndex) in clocks"
              :key="clockIndex"
              @click="this.form.clock = clock"
              type="button"
              class="btn m-1 rounded fw-bold"
              :class="{
                'btn-success': this.form.clock === clock,
                'btn-warning': this.form.clock !== clock,
              }"
            >
              {{ clock }}
            </button>
          </div>
        </div>
      </div>
      <div class="col-md-6">
        <h2 class="d-flex justify-content-center mb-2">Select your seat:</h2>
        <SelectSeats
          @selected-seats="handleSelectedSeats"
          @save-btn-clicked="handleTableInfoTickets"
        />
      </div>
    </div>
    <div class="row mt-3">
      <div class="col-md-12">
        <TableInfoTickets
          v-if="showTickets"
          :movie="movie"
          :quantity="form.seats.length"
          :seats="form.seats"
        />
        <UserDetails />
      </div>
    </div>
    <div v-if="isFormFinished" class="d-flex justify-content-center">
      <button type="button" class="btn btn-primary">Continue</button>
    </div>
  </div>
</template>

<script>
import SelectSeats from "./SelectSeats.vue";
import TableInfoTickets from "./TableInfoTickets.vue";
import UserDetails from "./UserDetails.vue";

export default {
  name: "BookingForm",
  props: ["movie"],
  components: {
    SelectSeats,
    TableInfoTickets,
    UserDetails,
  },
  mounted() {
    this.getMinMaxDates();
  },
  data() {
    return {
      isFormFinished: false,
      showTickets: false,
      clocks: ["16:00", "19:30", "23:00"],
      minDate: "",
      maxDate: "",
      form: {
        seats: [],
        date: "",
        clock: "",
        user: {
          firstName: "",
          lastName: "",
          email: "",
        },
      },
    };
  },
  methods: {
    getMinMaxDates() {
      const today = new Date().toISOString().split("T")[0];
      const oneMonthLater = new Date();
      oneMonthLater.setMonth(oneMonthLater.getMonth() + 1);
      this.minDate = today;
      this.maxDate = oneMonthLater.toISOString().split("T")[0];
    },

    handleSelectedSeats(selectedSeats) {
      this.form.seats = selectedSeats;
    },

    handleTableInfoTickets() {
      this.showTickets = true;
    },
  },
};
</script>
