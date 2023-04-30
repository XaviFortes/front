<template>
  <div class="modify_user">
    <h1 class="title">Modify User</h1>
    <form class="form" @submit.prevent="modifyUser">
      <label class="form-label" for="#user_id">DNI:</label>
      <input
        v-model="user_id"
        class="form-input"
        type="text"
        id="user_id"
        required
        placeholder="DNI"
      />
      <label class="form-label" for="#password">Password:</label>
      <input
        v-model="password"
        class="form-input"
        type="password"
        id="password"
        placeholder="Password"
      />
      <label class="form-label" for="#full_name">Full Name:</label>
      <input
        v-model="full_name"
        class="form-input"
        type="text"
        id="full_name"
        required
        placeholder="Full Name"
      />
      <label class="form-select-bkg" for="#visual_disability">Visual Disability:</label>
      <select v-model="visual_disability" class="form-select" id="visual_disability" required>
        <option value=0>Selecciona una opción</option>
        <option value=0>0%</option>
        <option value=1>Del 1% al 33%</option>
        <option value=2>Del 33% al 66%</option>
        <option value=3>Del 66% al 100%</option>
      </select>

      <label class="form-label" for="#mental_disability">Mental Disability:</label>
      <input
        v-model="mental_disability"
        class="form-input"
        type="number"
        id="mental_disability"
        required
        placeholder="Mental Disability"
      />
      <label class="form-label" for="#deaf_disability">Deaf Disability:</label>
      <input
        v-model="deaf_disability"
        class="form-input"
        type="number"
        id="deaf_disability"
        required
        placeholder="Deaf Disability"
      />
      <label class="form-label" for="#birth_date">Birth Date:</label>
      <input
        v-model="birth_date"
        class="form-input"
        type="date"
        id="birth_date"
        required
        placeholder="Birth Date"
      />
      <label class="form-label" for="#description">Description:</label>
      <input
        v-model="description"
        class="form-input"
        type="text"
        id="description"
        required
        placeholder="Description"
      />
      <label class="form-label" for="#abilities">Abilities:</label>
      <input
        v-model="abilities"
        class="form-input"
        type="text"
        id="abilities"
        required
        placeholder="Abilities"
      />
      <label class="form-label" for="#specific_disability">Specific Disability:</label>
      <input
        v-model="specific_disability"
        class="form-input"
        type="text"
        id="specific_disability"
        required
        placeholder="Specific Disability"
      />
      <input class="form-submit" type="submit" value="Modify User" />
    </form>
  </div>
</template>

<script lang="ts">
import { modify_user } from "@/api/auth";
export default {
data: () => ({
  user_id: "",
  full_name:"",
  visual_disability:0,
  mental_disability:0,
  deaf_disability:0,
  birth_date:"",
  description:"",
  abilities:"",
  specific_disability:"",
  password: "",
  
  error: false,
}),
methods: {
  async modifyUser() {
    try {
      await modify_user(this.user_id, this.password, this.full_name, this.visual_disability, this.mental_disability, this.deaf_disability, this.birth_date, this.description, this.abilities, this.specific_disability);
      this.$router.push("/");
    } catch (error) {
      console.log(error);
    }
  },
},
};
</script>

<style lang="scss" scoped>
.modify_user {
  min-width: 100vw;
  position: relative;
  padding-top: 50px;
  z-index: 5;
}
.register {
padding: 2rem;
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
box-shadow: 0 4px 10px 4px rgba(0, 0, 0, 0.3);

}
.form-label {
margin-top: 2rem;
color: white;
margin-bottom: 0.5rem;
&:first-of-type {
  margin-top: 0rem;
}
}
.form-select{
  margin-top: 2rem;
  padding: 10px;
  background-color: #0b9185;
color: white;
border: 1px solid white;
margin-bottom: 0.5rem;
&:first-of-type {
margin-top: 0rem;
}

}
.form-select-bkg{
  margin-top: 2rem;
  color: white;
  margin-bottom: 0.5rem;
  
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
&:hover {
  background: #0b9185;
}
}
.error {
margin: 1rem 0 0;
color: #ff4a96;
}
</style>
