<template>
  <div class="matrix-container">
    <div v-for="(row, rowIndex) in seats" :key="rowIndex" class="matrix-row">
      <button
        v-for="(seat, seatIndex) in row"
        :key="seatIndex"
        class="btn m-1"
        :class="{
          'btn-success': !isSelected(seat),
          'btn-warning': isSelected(seat),
          'btn-danger': isReserved(rowIndex + 1, seat),
        }"
        :disabled="isReserved(rowIndex + 1, seat)"
        @click="toggleSeat(rowIndex, seat)"
      >
        {{ seat }}
      </button>
    </div>
  </div>
</template>

<script>
export default {
  props: ['takenSeats'],
  inject: ["form"],
  name: "SelectSeats",
  data() {
    return {
      seats: [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9],
      ],
    };
  },
  methods: {
    toggleSeat(rowIndex, seat) {
      const seatIndex = this.form.seats.findIndex((s) => s.seat === seat);
      if (seatIndex === -1) {
        this.form.seats.push({ row: rowIndex + 1, seat: seat });
      } else {
        this.form.seats.splice(seatIndex, 1);
      }
    },

    isSelected(seat) {
      return this.form.seats.some((s) => s.seat === seat);
    },

    isReserved(row, seat) {
      return this.takenSeats.some(takenSeat => takenSeat.seat === `R${row}-S${seat}`);
    }
  },
};
</script>

<style scoped>
.matrix-container {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.matrix-row {
  display: flex;
}
</style>