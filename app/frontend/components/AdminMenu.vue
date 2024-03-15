<template>
  <div class="btn-group-vertical" role="group" aria-label="Vertical radio toggle button group">
    <input type="radio" class="btn-check" name="vbtn-radio" id="vbtn-radio1"
      @change="select('dashboard')" autocomplete="off" :checked="currentView === 'dashboard'">
    <label class="btn btn-outline-danger" for="vbtn-radio1">Dashboard</label>
    <input type="radio" class="btn-check" name="vbtn-radio" id="vbtn-radio2"
      @change="select('form')"  autocomplete="off" :checked="currentView === 'form'">
    <label class="btn btn-outline-danger" for="vbtn-radio2">Form movie</label>
  </div>
</template>

<script>
export default {
  name: "AdminMenu",
  props: ['currentView'],
  methods: {
    select(view) {
      this.$emit('selectedView', view);
    }
  },
}
</script>
