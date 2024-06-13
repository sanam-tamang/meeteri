<template>
   
    <section class="py-28 my-10" id="hero-section">
      <div class="max-w-screen-xl mx-auto text-gray-600 gap-x-12 items-center justify-between overflow-hidden md:flex md:px-8">
          <div class="flex-none space-y-5 px-4 sm:max-w-lg md:px-0 lg:max-w-xl">
              <h1 class="text-sm text-indigo-600 font-medium">
                Over 50,000 Students Helped
              </h1>
              <h2 class="text-4xl text-gray-800 font-extrabold md:text-5xl">
                Your Companion for Mental Health and Study Support 
              </h2>
              <p>
                Track your daily routines, get feedback from doctors, and engage with a supportive community.
              </p>
              <div class="items-center gap-x-3 space-y-3 max-w-max sm:flex sm:space-y-0 block py-4 px-10 text-center text-white font-medium bg-indigo-600 duration-150 hover:bg-indigo-500 active:bg-indigo-700 rounded-full shadow-lg hover:shadow-none">
                  <a href="#" class="">
                    Download Our App
                  </a>
                  
                  <Icon class="text-xl "  name="uil:google-play" />

                
              </div>
          </div>
          <div class="flex-none mt-14 md:mt-0 md:max-w-xl">
              <img
                  src="https://images.unsplash.com/photo-1573164713619-24c711fe7878?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1738&q=80"
                  class=" md:rounded-tl-[108px]"
                  alt=""
              />
          </div>
      </div>
    
  </section>
  </template>
  
  <script>
  export default {
    data() {
      return {
        isOpen: false,
        navigation: [
          { title: "Partners", path: "javascript:void(0)" },
          { title: "Customers", path: "javascript:void(0)" },
          { title: "Team", path: "javascript:void(0)" },
        ],
      };
    },
    methods: {
      toggleMenu() {
        this.isOpen = !this.isOpen;
      },
    },
  };
  </script>