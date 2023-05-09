<template>
    <div class="login">
      <h1 class="title">Create Cover Letter</h1>
      <form class="form" @submit.prevent="login">
        <label class="form-label" for="#username">Username:</label>
        <input
          v-model="username"
          class="form-input"
          type="text"
          id="username"
          required
          placeholder="Username"
        />
        <label class="form-label" for="#password">Password:</label>
        <input
          v-model="password"
          class="form-input"
          type="password"
          id="password"
          required
          placeholder="Password"
        />
        <input class="form-submit" type="submit" value="Create" />
      </form>
      <div class="form-center">
        <p v-html="text" class="form-paragraph"></p> <!-- Changed from textarea to p -->
      </div>
    </div>
  </template>
  
  <script>
  import { login } from "@/api/auth";
  
  export default {
    data() {
      return {
        username: "",
        password: "",
        text: "",
      };
    },
    methods: {
      async login() {
        try {
          const response = await login(this.username, this.password);
          this.text = response.data; // assign the response to the data object
        } catch (error) {
          console.error(error);
          this.error = true;
        }
      },
    },
  };
  </script>
  
  <style scoped>
  .login {
    min-width: 100vw;
    position: relative;
    padding-top: 50px;
    z-index: 5;
  }
  
  .title {
    text-align: center;
    color: darkgray;
    padding: 5rem 0 0 2rem;
  }
  
  .form {
    margin: 3rem auto;
    display: flex;
    flex-direction: column;
    justify-content: center;
    width: 40%;
    min-width: 30vw;
    max-width: 80vw;
    background: rgba(19, 35, 47, 0.9);
    border-radius: 5px;
    padding: 40px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.4);
  }
  
  .form-label {
    font-size: 1.2rem;
    color: #fff;
    margin-bottom: 0.5rem;
  }
  
  .form-input {
    padding: 0.5rem;
    margin-bottom: 1rem;
    border-radius: 3px;
    border: none;
  }
  
  .form-submit {
    margin-top: 1rem;
    background-color: #0b9185;
    color: #fff;
    border: none;
    border-radius: 3px;
    padding: 0.5rem;
    cursor: pointer;
  }
  
  .form-submit:hover {
    background-color: #0b9185;
  }
  
  .form-paragraph {
    padding: 0.5rem;
    border-radius: 3px;
    border: none;
    min-height: 200px;
  }
  
  .form-center {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 1rem;
  }
  </style>
  