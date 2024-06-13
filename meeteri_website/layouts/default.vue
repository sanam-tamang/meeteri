<script setup>
import { onMounted } from 'vue'
import { initFlowbite } from 'flowbite'

// initialize components based on data attribute selectors
onMounted(() => {
    initFlowbite();
})




useHead({
  title: 'Meeteri ',
  meta: [
    { name: 'description', content: 'Meeteri, your good friend' }
  ],
 
})
</script>
<template>
    <div class="relative">
       <!-- Navbar start -->
      <Navbar/>
      <!-- Navbar end -->
      <slot />
      
    </div>
  </template>
  