<template>
  <aside :class="`${is_expanded ? 'is-expanded' : ''}`">
    <div class="logo">
      <img :src="logoURL" alt="Vue" />
    </div>

    <div class="menu">
      <router-link to="/" class="button">
        <span class="material-icons">home</span>
        <span class="text">Home</span>
      </router-link>
      <router-link to="/form" class="button">
        <span class="material-icons">list</span>
        <span class="text">Modify Profile</span>
      </router-link>
      <router-link to="/search" class="button">
        <span class="material-icons">search</span>
        <span class="text">Search User</span>
      </router-link>
      <router-link to="/coverletter" class="button">
        <span class="material-icons">description</span>
        <span class="text">Create CV</span>
      </router-link>
    </div>

    <div class="flex"></div>

    <div class="menu">
      <router-link to="/signup" class="button">
        <span class="material-icons">key</span>
        <span class="text">Create Account</span>
      </router-link>
      <!-- <router-link to="/" class="button">
        <span class="material-icons">settings</span>
        <span class="text">Settings</span>
      </router-link> -->
    </div>
  </aside>
</template>
  
<script setup lang="ts">
  import { ref } from "vue";
  import logoURL from "/icono.png";
  const is_expanded = ref(localStorage.getItem("is_expanded") === "true");
</script>


<style>
  aside {
    position: fixed;
    top: 0;
    background-color: #2f3848;
    color: #fff;
    font-family: Arial, sans-serif;
    padding: 20px;
    width: 100%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    z-index: 1000;
  }
  
  .logo img {
    height: 50px;
    width: 150px;
  }
  
  h3 {
    font-size: 1.2rem;
    font-weight: bold;
    margin-top: 20px;
    text-transform: uppercase;
  }
  
  .menu {
    display: flex;
    flex-direction: row;
    
  }
  
  .menu .button {
    align-items: center;
    background-color: transparent;
    border: none;
    color: #fff;
    cursor: pointer;
    display: flex;
    margin-left: 10px;
    padding: 10px;
    transition: all 0.3s ease;
  }
  
  .menu .button:hover {
    background-color: #424f63;
  }
  
  .menu .button .material-icons {
    margin-right: 10px;
  }
  
  .flex {
    flex: 1;
  }
  
  .menu-toggle {
    background-color: transparent;
    border: none;
    color: #fff;
    cursor: pointer;
    font-size: 1.5rem;
    height: 50px;
    width: 50px;
  }
  
  .menu-toggle:hover {
    background-color: rgba(255, 255, 255, 0.1);
    border-radius: 50%;
  }
  
  .is-expanded .menu {
    max-height: 500px;
    overflow-y: auto;
  }
  
  main {
    margin-top: 70px;
  }
</style>
