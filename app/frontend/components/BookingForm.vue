<template>
  <div class="container-fluid row g-3 align-items-center mt-2">
    <div class="row">
      <div class="col-md-6">
        <h2 class="d-flex justify-content-center mb-2">
          Cumpărați bilet pentru {{ movie.title }}
        </h2>
        <SelectDates />
      </div>
      <Transition name="fade-slide">
        <div v-if="form.date && form.time" class="col-md-6">
          <h2 class="d-flex justify-content-center mb-2">Selectează-ți locul:</h2>
          <SelectSeats :taken-seats="takenSeats" />
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
                :placeholder="email ? email : 'E-mail'"
                :disabled="email"
                :value="form.user.email"
                required
              />
            </div>
            <div class="d-flex justify-content-center mt-4">
              <button type="submit" data-payment-type="later" class="btn btn-primary me-2">Rezerva</button>
              <!-- <button type="submit" data-payment-type="now" class="btn btn-primary">Pay Now</button> -->
            </div>
          </form>
        </div>
      </Transition>
    </div>
  </div>
  <Transition name="fade-slide">
    <Modal title="Rezervare bilet" :showModal="isModalOpen" @close="toggleModal" @save="handleSave">
      Vă mulțumim că ați rezervat biletele la noi. După ce apăsați butonul „Save”, biletele dvs. pentru film vor fi disponibile pe pagina de "Bilete". Vă rugăm să nu uitați să plătiți biletele la casa cinematografului cu cel puțin 30 de minute înainte de începerea filmului. Bucurați-vă de spectacol!
    </Modal>
  </Transition>
</template>

<script>
import SelectDates from "./SelectDates.vue";
import SelectSeats from "./SelectSeats.vue";
import TableInfoTickets from "./TableInfoTickets.vue";
import Modal from "./Modal.vue";
import axios from "axios";

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
      email: '',
      takenSeats: [],
      currentUser: '',
      isModalOpen: false,
      form: {
        movieId: this.movie.id,
        seats: [],
        date: "",
        time: "",
        user: {
          email: this.getEmail(),
        },
      },
    };
  },
  watch: {
    'form.date': 'getTakenSeats',
    'form.time': 'getTakenSeats',
  },
  async created() {
    this.currentUser = await this.setUsername(); 
    this.email = this.getEmail();
  },
  methods: {
    async getTakenSeats() {
      if (this.form.date && this.form.time) {
        try {
          const response = await axios.get('apis/v1/tickets/find_tickets_by_date_time', {
            params: {
              date: this.form.date,
              time: this.form.time
            }
          });
          this.takenSeats = response.data.data
        } catch (error) {
          console.error(error);
        }
      }
    },

    toggleModal() {
      this.isModalOpen = !this.isModalOpen;
    },

    async setUsername() {
      if(localStorage.getItem('token') !== null){
        const usernameCookie = await cookieStore.get('username');
        if(usernameCookie){
          return usernameCookie.value;
        }
      }
    },

    handlePayment(event) {
      const paymentType = event.submitter.dataset.paymentType;
      if (paymentType === 'later') {
        if(localStorage.getItem('token') !== null){
          this.toggleModal();
        }else{
          window.location.href = '/users';
        }
      } else if (paymentType === 'now'){
        // stripe payment
        alert('Payment successful!');
      }
    },

    getEmail() {
      return localStorage.getItem('email');
    },

    async handleSave() {
      this.toggleModal();
      this.$store.dispatch("tickets/create", this.form);
    }
  },
};
</script>