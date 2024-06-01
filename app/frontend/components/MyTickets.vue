<template>
  <div class="container-fluid">
    <div class="row">
      <div v-for="ticket in tickets" :key="ticket.id" class="col-md-4">
        <div class="card m-2 border-primary" style="max-width: 460px;">
          <div class="row g-0">
            <div class="col-md-4 d-flex justify-content-center align-items-center">
              <i class="bi bi-ticket-perforated" style="font-size: 4rem;"></i>
            </div>
            <div class="col-md-8">
              <div class="card-body">
                <h5 class="card-title">{{ ticket.movie_title }}</h5>
                <p class="card-text"><small class="text-muted">{{ ticket.date }} la {{ ticket.time }}</small></p>
                <p class="card-text">Loc: {{ ticket.seat }}</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: "MyTickets",
  data() {
    return {
      tickets: [],
      email: '',
    };
  },
  methods: {
    async fetchTickets() {
      const response = await axios.get('/apis/v1/tickets/find_tickets_by_user', {
        params: {
          user: {
            email: this.email,
          }
        },
      });
      this.tickets = response.data.data;
    },

    getEmail() {
      return localStorage.getItem('email');
    }
  },
  created() {
    this.email = this.getEmail();
    this.fetchTickets();
  },
}
</script>