<template>
  <div class="container-fluid">
    <div class="row">
      <div class="col-md-2">
        <AdminMenu 
          @dashboard-btn-clicked="changeChild()"
          @create-movie-btn-clicked="changeChild()"
        />
      </div>
      <div class="col-md-10">
        <AdminDashboard v-if="isChildVisible"/>
        <FormMovie v-if="!isChildVisible"/>
      </div>
    </div>
  </div>
</template>

<script>
import AdminMenu from './components/AdminMenu.vue';
import AdminDashboard from './components/AdminDashboard.vue';
import FormMovie from './components/FormMovie.vue';

export default {
  name: "Admin",
  components: {
    AdminMenu,
    AdminDashboard,
    FormMovie
  },
  data() {
    return {
      isChildVisible: true,
    }
  },
  methods: {
    changeChild() {
      this.isChildVisible = !this.isChildVisible;
    }
  }
}
</script>
