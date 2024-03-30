import { createStore } from 'vuex';
import movies from './modules/movies';
import tickets from './modules/tickets';

export default createStore({
  modules: {
    movies,
    tickets,
  },
});