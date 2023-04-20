<template>
  <div class="btn-group-vertical" role="group" aria-label="Vertical radio toggle button group">
    <input type="radio" class="btn-check" name="vbtn-radio" id="vbtn-radio1"
      @change="$emit('dashboard-btn-clicked')" autocomplete="off" checked>
    <label class="btn btn-outline-danger" for="vbtn-radio1">Dashboard</label>
    <input type="radio" class="btn-check" name="vbtn-radio" id="vbtn-radio2"
      @change="$emit('create-movie-btn-clicked')"  autocomplete="off">
    <label class="btn btn-outline-danger" for="vbtn-radio2">Create movie</label>
  </div>
</template>

<script>
export default {
  name: "AdminMenu",
}
</script>
