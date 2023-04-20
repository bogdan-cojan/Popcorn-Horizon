import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap/dist/js/bootstrap.min.js";
import { createApp } from "vue/dist/vue.esm-bundler";
import Navbar from "../components/Navbar.vue";
import App from "../App.vue";
import Users from "../Users.vue";

createApp(Navbar).mount("#navbar");
createApp(App).mount("#app");
if(isLoggedIn() && window.location.pathname === "/users") {
  window.location.href = "/";
} else { createApp(Users).mount("#users") }

function isLoggedIn() {
  return localStorage.getItem('token') !== null;
}
