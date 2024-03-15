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
              v-for="(time, timeIndex) in times"
              :key="timeIndex"
              @click="this.form.time = time"
              type="button"
              class="btn m-1 rounded fw-bold"
              :class="{
                'btn-success': this.form.time === time,
                'btn-warning': this.form.time !== time,
              }"
            >
              {{ time }}
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
        <div class="container mt-2 w-50">
          <div class="mb-3">
            <label class="form-label">*E-mail</label>
            <input
              type="text"
              class="form-control"
              placeholder="E-mail"
              v-model="form.user.email"
            />
          </div>
        </div>
      </div>
    </div>
    <div class="d-flex justify-content-evenly mt-4">
      <button type="button" @click="toggleModal" class="btn btn-primary">Pay Later</button>
      <button type="button" class="btn btn-primary">Pay Now</button>
    </div>
  </div>
  <Transition name="fade-slide">
    <Modal title="Ticket Reservation" :showModal="isModalOpen" @close="toggleModal" @save="handleSave">
      Thank you for reserving your tickets with us. An email confirmation will be sent to you shortly after you press the "Save" button. Please remember to pay for your tickets at the cinema's box office at least 30 minutes before the movie starts. Enjoy your show!
    </Modal>
  </Transition>
</template>

<script>
import SelectSeats from "./SelectSeats.vue";
import TableInfoTickets from "./TableInfoTickets.vue";
import Modal from "./Modal.vue";

export default {
  name: "BookingForm",
  props: ["movie"],
  components: {
    SelectSeats,
    TableInfoTickets,
    Modal,
  },
  mounted() {
    this.getMinMaxDates();
  },
  data() {
    return {
      isModalOpen: false,
      showTickets: false,
      times: ["16:00", "19:30", "23:00"],
      minDate: "",
      maxDate: "",
      form: {
        movieId: this.movie.id,
        seats: [],
        date: "",
        time: "",
        user: {
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

    toggleModal() {
      this.isModalOpen = !this.isModalOpen;
    },

    handleSave() {
      this.isModalOpen = !this.isModalOpen;
      // post the ticket to the server
    }
  },
};
</script>
