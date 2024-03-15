<template>
  <div class="container-fluid">
    <div class="row">
      <div class="col-md-2">
        <AdminMenu @selectedView="handleView" :currentView="selectedView" />
      </div>
      <div class="col-md-10">
        <AdminDashboard v-if="selectedView === 'dashboard'" @editMovie="handleEdit"/>
        <FormMovie v-if="selectedView === 'form'" :movie="movieToEdit" @cancel="handleCancel"/>
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
      selectedView: 'dashboard',
      movieToEdit: null,
    }
  },
  methods: {
    resetMovieToEdit() {
      this.movieToEdit = null;
    },
    
    handleCancel() {
      this.resetMovieToEdit();
      this.selectedView = 'dashboard';
    },

    handleEdit(movie) {
      this.movieToEdit = movie;
      this.selectedView = 'form';
    },

    handleView(newView) {
      this.resetMovieToEdit();
      this.selectedView = newView;
    }
  }
}
</script>
