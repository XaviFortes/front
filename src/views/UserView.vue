<template>
  <main>
    <!-- Get all messages with v-for -->
    <ul id="msgs">
      <div v-if="user">
        <h3 id="userNick">{{ user.username }}</h3>
        <p>{{ user.full_name }}</p>
        <p>{{ user.email }}</p>
        <p>{{ user.abilities }}</p>
        <p>{{ user.job_experience }}</p>
        <p>{{ user.description }}</p>
      </div>
      <div v-else>
        <p>Loading user...</p>
      </div>
    </ul>
  </main>
</template>

<script lang="ts">
import { ref, onMounted } from "vue";
import { useRoute } from "vue-router";
import axios from "axios";

export default {
  setup() {
    const route = useRoute();
    const user = ref(null);

    // Fetch user data from API when component is mounted
    onMounted(async () => {
      const user_id = route.params.user_id;
      axios.defaults.withCredentials = false;
      const response = await axios.get(`https://48qgipie48.execute-api.eu-south-2.amazonaws.com/Test/get_user?dni=${user_id}`);
      user.value = response.data;
    });
    return { user };
  },
};
</script>


<style lang="scss" scoped>
main {
  padding-top: 0;
  padding-bottom: 0;
}
#msgs {
  overflow-y: auto;
  height: 90vh;
  width: 120vh;
}
// Send messages form styling
#msgForm {
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-radius: 10px;
  width: 100%;
  height: 7vh;
  bottom: 0;
  left: 0;
  background-color: var(--primary);
  padding: 0 1rem;
}
#msgInput {
  width: 100%;
  height: 100%;
  border: none;
  padding: 0 1rem;
  font-size: 1.2rem;
  background-color: var(--secondary);
  color: var(--light);
}
#msgInput:focus {
  outline: none;
}
#msgForm button {
  width: 10%;
  height: 100%;
  border: none;
  border-radius: 10px;
  background-color: var(--secondary);
  color: var(--light);
  font-size: 1.2rem;
  cursor: pointer;
}
#msgImg {
  width: 100%;
  height: 100%;
  object-fit: scale-down;
  border-radius: 10px;
}
img {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  margin-bottom: 15px;
  margin-right: 10px;
  vertical-align: middle;
}
li > div {
  flex-direction: column;
  justify-content: center;
}
li {
  display: flex;
  border: 1px solid var(--light);
  border-radius: 10px;
  padding: 1rem;
  margin-bottom: 1rem;
}
div {
  margin-left: 10px;
}
#userNick {
  margin-right: 100%;
  color: var(--primary);
}
#msgDate {
  margin-left: auto;
  color: darkgray;
}
small {
  font-size: 0.6rem;
}

#chatSettings {
  display: flex;
  align-items: center;
}
#chatPic {
  position: relative;
  width: 50px;
  height: 50px;
  margin-right: 1rem;
}
#chatInfo {
  display: flex;
  flex-direction: column;
}
// CSS for the sideChatBar
#sideChatBar h2 {
  color: var(--primary);
  font-size: large;
}
#sideChatBar h3 {
  color: var(--primary);
}
#user-info {
  display: flex;
  align-items: center;
  margin-bottom: 1rem;
}
#chatName,
#chatDesc {
  color: var(--primary);
  text-decoration: underline;
  cursor: pointer;
}
</style>
