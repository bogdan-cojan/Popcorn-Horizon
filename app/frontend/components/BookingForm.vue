<template>
  <div class="container-fluid row g-3 align-items-center mt-2">
    <div class="row">
      <div class="col-md-6">
        <h2 class="d-flex justify-content-center mb-2">
          Buy ticket for {{ movie.title }}
        </h2>
        <SelectDates />
      </div>
      <Transition name="fade-slide">
        <div v-if="form.date && form.time" class="col-md-6">
          <h2 class="d-flex justify-content-center mb-2">Select your seat:</h2>
          <SelectSeats />
        </div>
      </Transition>
    </div>
    <div class="row mt-3">
      <Transition name="fade-slide">
        <div v-if="form.date && form.time && form.seats.length > 0" class="col-md-12">
          <TableInfoTickets
            :movie="movie"
            :quantity="form.seats.length"
            :seats="form.seats"
          />
          <form class="container mt-2 w-50" @submit.prevent="handlePayment">
            <div class="mb-3">
              <label class="form-label">*E-mail</label>
              <input
                type="text"
                class="form-control"
                placeholder="E-mail"
                v-model="form.user.email"
                required
              />
            </div>
            <div class="d-flex justify-content-center mt-4">
              <button type="submit" data-payment-type="later" class="btn btn-primary me-2">Pay Later</button>
              <button type="submit" data-payment-type="now" class="btn btn-primary">Pay Now</button>
            </div>
          </form>
        </div>
      </Transition>
    </div>
  </div>
  <Transition name="fade-slide">
    <Modal title="Ticket Reservation" :showModal="isModalOpen" @close="toggleModal" @save="handleSave">
      Thank you for reserving your tickets with us. An email confirmation will be sent to you shortly after you press the "Save" button. Please remember to pay for your tickets at the cinema's box office at least 30 minutes before the movie starts. Enjoy your show!
    </Modal>
  </Transition>
</template>

<script>
import SelectDates from "./SelectDates.vue";
import SelectSeats from "./SelectSeats.vue";
import TableInfoTickets from "./TableInfoTickets.vue";
import Modal from "./Modal.vue";

export default {
  provide() {
    return {
      form: this.form,
    };
  },
  name: "BookingForm",
  props: ["movie"],
  components: {
    SelectDates,
    SelectSeats,
    TableInfoTickets,
    Modal,
  },
  data() {
    return {
      isModalOpen: false,
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
    toggleModal() {
      this.isModalOpen = !this.isModalOpen;
    },

    handlePayment(event) {
      const paymentType = event.submitter.dataset.paymentType;
      if (paymentType === 'later') {
        this.toggleModal();
      } else if (paymentType === 'now'){
        // stripe payment
        alert('Payment successful!');
      }
    },

    async handleSave() {
      this.toggleModal();
      this.$store.dispatch("tickets/create", this.form);
    }
  },
};
</script>