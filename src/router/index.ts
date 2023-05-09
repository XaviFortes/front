import { createRouter, createWebHistory } from "vue-router";
import HomeView from "../views/HomeView.vue";
import { isLogged } from "@/api/auth";
import { useToast } from "vue-toastification";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "home",
      component: HomeView,
    },
    {
      path: "/login",
      name: "login",
      component: () => import("../views/LoginView.vue"),
    },
    {
      path: "/signup",
      name: "register",
      component: () => import("../views/RegisterView.vue"),
    },
    {
      path: "/activate",
      name: "activate",
      component: () => import("../views/ActivateView.vue"),
    },
    {
      path: "/form",
      name: "formulario",
      component: () => import("../views/FormView.vue"),
    },
    {
      path: "/user/:user_id",
      name: "user",
      component: () => import("../views/UserView.vue"),
    },
    {
      path: "/logout",
      name: "logout",
      component: () => import("../views/LogoutView.vue"),
    },
    {
      path: "/contact",
      name: "contact",
      component: () => import("../views/ContactView.vue"),
    },
    {
      path: "/search",
      name: "search",
      component: () => import("../views/SearchView.vue"),
    },
    {
      path: "/:pathMatch(.*)*",
      name: "not-found",
      component: () => import("../views/NotFoundView.vue"),
    },
  ],
});

/*
router.beforeEach(async (to, from, next) => {
  const publicPages = ["/login", "/signup", "/", "/activate", "/form", "/user", "/user/:user_id"];
  const authRequired = !publicPages.includes(to.path);
  const toast = useToast();
  const loggedIn = await isLogged().then((res) => {
    if (res.data.message === "Logged!") {
      return true;
    } else {
      return false;
    }
  });
  if (authRequired && !loggedIn) {
    toast.error("You must be logged in to access this page.");
    return next("/login");
  }
  next();
});
*/

export default router;
