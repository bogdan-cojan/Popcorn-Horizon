<template>
  <table class="table table-bordered table-hover">
    <thead>
      <tr>
        <th>Ticket</th>
        <th>Quantity</th>
        <th>Ticket Price</th>
        <th>Seats Information</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>{{ movie.title }}</td>
        <td>{{ quantity }}</td>
        <td>{{ price }} lei</td>
        <td>
          <p v-for="info in getSeatsInfo" :key="info">{{ info }}</p>
        </td>
      </tr>
    </tbody>
  </table>
  <p class="mt-3 fw-bold mb-4">Grand Total {{ getGrandTotal }} lei</p>
</template>

<script>
export default {
  name: "TableInfoTickets",
  props: ["movie", "quantity", "seats"],
  data() {
    return {
      price: 25,
    };
  },
  computed: {
    getGrandTotal() {
      return this.quantity * this.price;
    },

    getSeatsInfo() {
      var seatsInfo = new Array();
      const groupedSeats = {};

      this.seats.forEach((s) => {
        if (!groupedSeats[s.row]) {
          groupedSeats[s.row] = [];
        }
        groupedSeats[s.row].push(s.seat);
      });

      for (const row in groupedSeats) {
        const seats = groupedSeats[row].join(", ");
        seatsInfo.push(`Row ${row}; Seats ${seats}`);
      }

      return seatsInfo;
    },
  },
};
</script>
