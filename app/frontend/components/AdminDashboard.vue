<template>
  <table class="table table-striped table-hover table-bordered mt-2">
    <thead class="table-dark">
      <tr>
        <th>Id</th>
        <th>Title</th>
        <th>Edit</th>
        <th>Delete</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="movie in this.list" :key="movie.id">
        <td>{{ movie.id }}</td>
        <td>{{ movie.title }}</td>
        <td class="d-flex justify-content-center">
          <button class="btn btn-primary" @click="editMovie(movie)">
            <i class="bi bi-pencil-fill"></i> Edit
          </button>
        </td>
        <td>
          <button class="btn btn-danger" @click="prepareDelete(movie.id)">
            <i class="bi bi-trash-fill"></i> Delete
          </button>
        </td>
      </tr>
    </tbody>
  </table>
  <Transition name="fade-slide">
    <Modal title="Confirma stergerea" :showModal="isModalOpen" @close="toggleModal" @save="handleSave">
      Sigur doriți să ștergeți acest film? Această acțiune nu poate fi anulată.
    </Modal>
  </Transition>
</template>

<script>
import { mapState } from 'vuex';
import Modal from './Modal.vue';

export default {
  name: "AdminDashboard",
  computed: mapState('movies', ['list']),
  components: {
    Modal,
  },
  data() {
    return {
      isModalOpen: false,
      movieIdToDelete: null,
    };
  },
  methods: {
    prepareDelete(id) {
      this.movieIdToDelete = id;
      this.toggleModal();
    },

    handleSave() {
      this.deleteMovie(this.movieIdToDelete);
      this.toggleModal();
    },

    toggleModal() {
      this.isModalOpen = !this.isModalOpen;
    },

    editMovie(movie) {
      this.$emit('editMovie', movie);
    },
    
    deleteMovie(id) {
      this.$store.dispatch('movies/delete', id);
    }
  },
  created() {
    this.$store.dispatch('movies/index');
  },
};
</script>