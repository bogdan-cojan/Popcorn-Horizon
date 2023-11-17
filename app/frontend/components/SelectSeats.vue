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
          'btn-danger':
            !noSavedSeats && this.selectedSeats.some((s) => s.seat === seat),
        }"
        @click="toggleSeat(rowIndex, seat)"
      >
        {{ seat }}
      </button>
    </div>
    <button
      v-if="noSavedSeats"
      class="btn btn-primary mt-3"
      @click="saveSeats()"
    >
      Save
    </button>
  </div>
</template>

<script>
export default {
  name: "SelectSeats",
  data() {
    return {
      seats: [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9],
      ],
      selectedSeats: [],
      noSavedSeats: true,
    };
  },
  methods: {
    toggleSeat(rowIndex, seat) {
      const seatIndex = this.selectedSeats.findIndex((s) => s.seat === seat);
      if (seatIndex === -1) {
        this.selectedSeats.push({ row: rowIndex + 1, seat: seat });
      } else {
        this.noSavedSeats = true;
        this.selectedSeats.splice(seatIndex, 1);
      }
    },

    isSelected(seat) {
      return this.selectedSeats.some((s) => s.seat === seat);
    },

    saveSeats() {
      if (this.selectedSeats.length === 0) {
        alert("No seats selected !");
      } else {
        this.noSavedSeats = false;
        this.$emit("selected-seats", this.selectedSeats);
        this.$emit("save-btn-clicked");
      }
    },
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
