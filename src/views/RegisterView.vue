<template>
  <div class="register">
    <h1 class="title">Sign Up</h1>
    <form class="form" @submit.prevent="register">
      <label class="form-label" for="#user_id">DNI:</label>
      <input
        v-model="user_id"
        class="form-input"
        type="text"
        id="user_id"
        required
        placeholder="DNI"
      />
      <label class="form-label" for="#email">Email:</label>
      <input
        v-model="email"
        class="form-input"
        type="email"
        id="email"
        required
        placeholder="Email"
      />
      <label class="form-label" for="#nick">Nick:</label>
      <input
        v-model="nick"
        class="form-input"
        type="text"
        id="nick"
        required
        placeholder="Nick"
      />
      <label class="form-label" for="#password">Password:</label>
      <input
        v-model="password"
        class="form-input"
        type="password"
        id="password"
        placeholder="Password"
      />
      <label class="form-label" for="#password-repeat"
        >Repeat password:</label
      >
      <input
        v-model="passwordRepeat"
        class="form-input"
        type="password"
        id="password-repeat"
        placeholder="Password"
      />
      <input class="form-submit" type="submit" value="Sign Up" />
    </form>
  </div>
</template>

<script lang="ts">
import { register } from "@/api/auth";
export default {
  data: () => ({
    user_id: "",
    email: "",
    nick: "",
    password: "",
    passwordRepeat: "",
    error: false,
  }),
  methods: {
    async register() {
      try {
        await register(this.user_id, this.nick, this.email, this.password);
        this.$router.push("/");
      } catch (error) {
        console.log(error);
      }
    },
  },
};
</script>

<style lang="scss" scoped>
.register {
  min-width: 100vw;
  position: relative;
  padding-top: 50px;
  z-index: 5;
  padding: 5rem;  
}
.title {
  text-align: center;
  color: #1ab188;
}
.form {
  margin: 3rem auto;
  display: flex;
  flex-direction: column;
  justify-content: center;
  width: 20%;
  min-width: 350px;
  max-width: 100%;
  background: rgba(19, 35, 47, 0.9);
  border-radius: 5px;
  padding: 20px;
  box-shadow: 0 4px 10px 4px rgba(0, 0, 0, 0.3);
}
.form-label {
  margin-top: 2rem;
  color: white;
  margin-bottom: 0.5rem;
  font-weight: bold;
  
  &:first-of-type {
    margin-top: 0rem;
  }
}
.form-input {
  padding: 10px 15px;
  background: none;
  background-image: none;
  border: 1px solid white;
  color: white;
  &:focus {
    outline: 0;
    border-color: #1ab188;
  }
}
.form-submit {
  background: #1ab188;
  border: none;
  color: white;
  margin-top: 3rem;
  padding: 1rem 0;
  cursor: pointer;
  transition: background 0.2s;
  font-weight: bold; /* Agregamos esta línea para poner el texto en negrita */
  &:hover {
    background: #0b9185;
  }
}

.error {
  margin: 1rem 0 0;
  color: #ff4a96;
}
</style>
