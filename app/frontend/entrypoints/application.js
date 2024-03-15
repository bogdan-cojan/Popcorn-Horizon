import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap";
import "bootstrap/dist/js/bootstrap.min.js";
import "bootstrap-icons/font/bootstrap-icons.css";
import { createApp } from "vue/dist/vue.esm-bundler";
import store from './store.js';
import Navbar from "../components/Navbar.vue";
import App from "../App.vue";
import Users from "../Users.vue";
import Admin from "../Admin.vue";

createApp(Navbar).mount("#navbar");
createApp(App).use(store).mount("#app");
if(isLoggedIn() && window.location.pathname === "/users") {
  window.location.href = "/";
} else { createApp(Users).mount("#users") }
createApp(Admin).use(store).mount("#admin");

function isLoggedIn() {
  return localStorage.getItem('token') !== null;
}
