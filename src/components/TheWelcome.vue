<template>
  <div>
    <section>
      <h2>Create Your CV</h2>
      <p>Creating a resume is easy with our CV builder. We understand the unique needs of job seekers with disabilities, and our platform makes it simple to highlight your strengths and experience.</p>
      <router-link to="/signup">
        <button>Get Started</button>
      </router-link>
    </section>

    <section>
      <h2>Why Choose Us?</h2>
      <ul>
        <li>
          <h3>Accessibility Features</h3>
          <p>Our CV builder is designed with accessibility in mind. We offer a variety of features to help job seekers with disabilities create a resume that accurately reflects their skills and experience.</p>
        </li>
        <li>
          <h3>User-Friendly Interface</h3>
          <p>Our platform is easy to use, even for those who may not be tech-savvy. Our step-by-step process guides you through each section of your CV, ensuring that you don't miss anything important.</p>
        </li>
        <li>
          <h3>Professional Results</h3>
          <p>Our CV builder is designed to help you create a polished and professional-looking resume that will help you stand out in the job market. With our platform, you can be confident that your CV will make a great impression.</p>
        </li>
      </ul>
    </section>

    <section>
      <h2>Testimonials</h2>
      <ul>
        <li>
          <p>"Thanks to this platform, I was able to create a resume that accurately reflects my skills and experience. I feel more confident applying for jobs now, and I've already received a few interviews!" - Jane Doe</p>
        </li>
        <li>
          <p>"I've used a lot of resume builders over the years, but this is by far the best one I've found. It's user-friendly and the results are professional-looking. Highly recommend!" - John Smith</p>
        </li>
      </ul>
    </section>
  </div>
</template>

<script>
export default {
  name: 'CVBuilderView',
  // Add any necessary data, computed properties, or methods here
}
</script>

<style scoped>
/* Add any necessary styles here */
h2 {
  font-size: 2rem;
  font-weight: 700;
  margin-bottom: 1rem;
  color: #1ab188;
}

h3 {
  font-size: 1.5rem;
  font-weight: 700;
  margin-bottom: 1rem;
}

p {
  font-size: 16px;
  font-weight: 400;
  margin-bottom: 1rem;
}

ul {
  list-style: none;
  margin: 0;
  padding: 0;
}

section {
  margin-bottom: 2rem;
}

section:last-child {
  margin-bottom: 0;
}

section ul li {
  margin-bottom: 1rem;
}

button {
  background-color: #1ab188;
  border: none;
  border-radius: 4px;
  color: #fff;
  cursor: pointer;
  font-size: 1rem;
  font-weight: 700;
  padding: 0.5rem 1rem;
  height: 100%;
}

button:hover {
  background-color: #128c73;
}

button:focus {
  outline: none;
}

button:active {
  background-color: #0d6145;
  transform: scale(0.98);
}

@media (min-width: 768px) {
  section {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
  }

  section ul {
    width: 50%;
  }

  section ul li {
    margin-bottom: 2rem;
  }
}

@media (min-width: 1024px) {
  section ul {
    width: 60%;
  }
}

@media (min-width: 1400px) {
  section ul {
    width: 80%;
  }
}


</style>
