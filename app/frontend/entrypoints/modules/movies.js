export default {
  namespaced: true,
  state: {
    list: [],
  },
  mutations: {
    setMovies(state, movies) {
      state.list = movies;
    },

    removeMovie(state, movieId) {
      state.list = state.list.filter(movie => movie.id !== movieId);
    },

    addMovie(state, movie) {
      state.list.push(movie);
    },

    editMovie(state, updatedMovie) {
      const index = state.list.findIndex(movie => movie.id === updatedMovie.id);
      if (index !== -1) {
        state.list.splice(index, 1, updatedMovie);
      }
    },
  },
  actions: {
    async index({ commit }) {
      const res = await fetch("/apis/v1/movies");
      const data = await res.json();
      commit('setMovies', data);
    },

    async delete({ commit }, movieId) {
      const res = await fetch(`/apis/v1/movies/${movieId}`, {
        method: 'DELETE',
      });

      if (res.ok) {
        commit('removeMovie', movieId);
      } else {
        throw new Error('Failed to delete movie.');
      }
    },

    async create({ commit, dispatch }, movie) {
      const res = await dispatch('submitMovie', { movie, method: "POST", url: "/apis/v1/movies" });
      if(res.status === 201) {
        const newMovie = await res.json();
        commit('addMovie', newMovie);
        window.location.href = "/";
      }
    },

    async update({ commit, dispatch }, { movie, newImageSelected }) {
      if(!newImageSelected) {
        console.log("image new selected: ", newImageSelected);
        delete movie.image;
      }

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
    },
  },
};