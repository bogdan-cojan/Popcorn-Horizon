import { createStore } from 'vuex';

export default createStore({
  state: {
    movies: [],
  },
  mutations: {
    setMovies(state, movies) {
      state.movies = movies;
    },

    removeMovie(state, movieId) {
      state.movies = state.movies.filter(movie => movie.id !== movieId);
    },

    addMovie(state, movie) {
      state.movies.push(movie);
    },

    editMovie(state, updatedMovie) {
      const index = state.movies.findIndex(movie => movie.id === updatedMovie.id);
      if (index !== -1) {
        state.movies.splice(index, 1, updatedMovie);
      }
    },
  },
  actions: {
    async fetchMovies({ commit }) {
      const res = await fetch("/apis/v1/movies");
      const data = await res.json();
      commit('setMovies', data);
    },

    async deleteMovie({ commit }, movieId) {
      const res = await fetch(`/apis/v1/movies/${movieId}`, {
        method: 'DELETE',
      });

      if (res.ok) {
        commit('removeMovie', movieId);
      } else {
        throw new Error('Failed to delete movie.');
      }
    },

    async createMovie({ commit, dispatch }, movie) {
      const res = await dispatch('submitMovie', { movie, method: "POST", url: "/apis/v1/movies" });
      if(res.status === 201) {
        const newMovie = await res.json();
        commit('addMovie', newMovie);
        window.location.href = "/";
      }
    },

    async updateMovie({ commit, dispatch }, movie) {
      const res = await dispatch('submitMovie', { movie, method: "PUT", url: `/apis/v1/movies/${movie.id}` });
      if(res.status === 200) {
        const updatedMovie = await res.json();
        commit('editMovie', updatedMovie);
        window.location.href = "/";
      }
    },

    async submitMovie(_, { movie, method, url }) {
      const formData = new FormData();
      Object.keys(movie).forEach(key => {
        if (key !== 'genres') {
          formData.append(key, movie[key]);
        }
      });
      formData.append("genres", JSON.stringify(movie.genres));
  
      return await fetch(url, {
        method,
        body: formData,
      });
    }
  },
});
