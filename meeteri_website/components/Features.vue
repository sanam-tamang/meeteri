<template>
    <section class="py-8" id="features-section">
        <div class="max-w-screen-xl mx-auto px-4 text-gray-600 md:px-8">
            <div class="text-center text-2xl font-semibold ">
                <p class="my-12 text-4xl">Our Salient Features</p>
            </div>
            <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
              <!-- First card -->
              <div class="shadow-md p-4 cursor-pointer hover:shadow-lg transition-all border hover:scale-105 border-white hover:border-indigo-500 rounded-md  grid gap-3">

                <div class="w-16 h-16     text-white flex justify-center items-center rounded-md">
                
                    <!-- <Icon class="text-xl " name="uil:user" /> -->
    <nuxt-img src="/Feature_icons/daily routine.png" class="cursor-pointer" />

                </div>
                <p class="text-xl">Daily Routine Tracker</p>


                <div class="grid  grid-flow-col gap-3 justify-start items-center">
                <Icon class="text-xl w-4 h-4 bg-orange-400 text-white rounded-full" name="uil:check" />
                <p class="">Daily routine tracking with expert feedback.</p>
                </div> 

                <div class="grid  grid-flow-col gap-3 justify-start items-center">
                <Icon class="text-xl w-4 h-4 bg-orange-400 text-white rounded-full" name="uil:check" />
                <p class="">Goal setting and monitoring with professional chek-ins.</p>
                </div> 

                <div class="grid  grid-flow-col gap-3 justify-start items-center">
                <Icon class="text-xl w-4 h-4 bg-orange-400 text-white rounded-full" name="uil:check" />
                <p class="">Personalized adjustments for a balanced lifestyle.</p>
                </div> 



                </div>

                <!-- Second card -->
                <div class="shadow-md p-4 cursor-pointer hover:shadow-lg transition-all border hover:scale-105 border-white hover:border-indigo-500 rounded-md  grid gap-3">

                    <div class="w-16 h-16   text-white flex justify-center items-center rounded-md">
                    
                        <nuxt-img src="/Feature_icons/anonymous_post.webp" class="cursor-pointer" />

                    </div>
                    <p class="text-xl">Anonymous post</p>
                    <div class="grid  grid-flow-col gap-3 justify-start items-center">
                    <Icon class="text-xl w-4 h-4 bg-orange-400 text-white rounded-full" name="uil:check" />
                    <p class="">Anonymous sharing of thoughts and experiences.</p>
                    </div> 
                    <div class="grid  grid-flow-col gap-3 justify-start items-center">
                    <Icon class="text-xl w-4 h-4 bg-orange-400 text-white rounded-full" name="uil:check" />
                    <p class="">Encourages open experssion without fear of judgement.</p>
                    </div> 
                    <div class="grid  grid-flow-col gap-3 justify-start items-center">
                    <Icon class="text-xl w-4 h-4 bg-orange-400 text-white rounded-full" name="uil:check" />
                    <p class="">Safe space for questions, struggles and support.</p>
                    </div> 
                    </div>
                  
                    <!-- third card -->

                    <div class="shadow-md p-4 cursor-pointer hover:shadow-lg transition-all border hover:scale-105 border-white hover:border-indigo-500 rounded-md  grid gap-3">

                        <div class="w-16 h-16   text-white flex justify-center items-center rounded-md">
                        
                    <nuxt-img src="/Feature_icons/online_cummunities.jpeg" class="cursor-pointer" />

                        </div>
                        <p class="text-xl">Online Communities</p>
                        <div class="grid  grid-flow-col gap-3 justify-start items-center">
                        <Icon class="text-xl w-4 h-4 bg-orange-400 text-white rounded-full" name="uil:check" />
                        <p class="">Individual and community activities.</p>
                        </div> 
                        <div class="grid  grid-flow-col gap-3 justify-start items-center">
                        <Icon class="text-xl w-4 h-4 bg-orange-400 text-white rounded-full" name="uil:check" />
                        <p class="">Supportive environment for sharing and learning.</p>
                        </div> 
                        <div class="grid  grid-flow-col gap-3 justify-start items-center">
                        <Icon class="text-xl w-4 h-4 bg-orange-400 text-white rounded-full" name="uil:check" />
                        <p class="">Open conversations to reduce stigma.</p>
                        </div> 
                        </div>


                        <!-- fourth card -->
                        <div class="shadow-md p-4 cursor-pointer hover:shadow-lg transition-all border hover:scale-105 border-white hover:border-indigo-500 rounded-md  grid gap-3">

                            <div class="w-16 h-16   text-white flex justify-center items-center rounded-md">
                            
                                <nuxt-img src="/Feature_icons/events.png" class="cursor-pointer" />

                            </div>
                            <p class="text-xl">Multiple Events</p>
                            <div class="grid  grid-flow-col gap-3 justify-start items-center">
                            <Icon class="text-xl w-4 h-4 bg-orange-400 text-white rounded-full" name="uil:check" />
                            <p class="">Discover and participate in mental health events.</p>
                            </div> 
                            <div class="grid  grid-flow-col gap-3 justify-start items-center">
                            <Icon class="text-xl w-4 h-4 bg-orange-400 text-white rounded-full" name="uil:check" />
                            <p class="">Workshops, webinars, support groups and gatherings.</p>
                            </div> 
                            <div class="grid  grid-flow-col gap-3 justify-start items-center">
                            <Icon class="text-xl w-4 h-4 bg-orange-400 text-white rounded-full" name="uil:check" />
                            <p class="">Opportunities for learning networking and Supportive behaviours.</p>
                            </div> 
                            </div>

                            <!-- fifth card -->
                            <div class="shadow-md p-4 cursor-pointer hover:shadow-lg transition-all border hover:scale-105 border-white hover:border-indigo-500 rounded-md  grid gap-3">

                                <div class="w-16 h-16   text-white flex justify-center items-center rounded-md">
                                
                                    <nuxt-img src="/Feature_icons/roadmaps.jpeg" class="cursor-pointer" />

                                </div>
                                <p class="text-xl">Academic Roadmaps</p>
                                <div class="grid  grid-flow-col gap-3 justify-start items-center">
                                <Icon class="text-xl w-4 h-4 bg-orange-400 text-white rounded-full" name="uil:check" />
                                <p class="">Personalized planning.</p>
                                </div> 
                                <div class="grid  grid-flow-col gap-3 justify-start items-center">
                                <Icon class="text-xl w-4 h-4 bg-orange-400 text-white rounded-full" name="uil:check" />
                                <p class="">Process tracking.</p>
                                </div> 
                                <div class="grid  grid-flow-col gap-3 justify-start items-center">
                                <Icon class="text-xl w-4 h-4 bg-orange-400 text-white rounded-full" name="uil:check" />
                                <p class="">Internship and job opportunities.</p>
                                </div> 
                                </div>
                                
                                <!-- sixth card -->

                                <div class="shadow-md p-4 cursor-pointer hover:shadow-lg transition-all border hover:scale-105 border-white hover:border-indigo-500 rounded-md  grid gap-3">

                                    <div class="w-16 h-16   text-white flex justify-center items-center rounded-md">
                                    
                                        <nuxt-img src="/Feature_icons/career.png" class="cursor-pointer" />

                                    </div>
                                    <p class="text-xl">Career Councelling</p>
                                    <div class="grid  grid-flow-col gap-3 justify-start items-center">
                                    <Icon class="text-xl w-4 h-4 bg-orange-400 text-white rounded-full" name="uil:check" />
                                    <p class="">Costumized roadmap and career services.</p>
                                    </div> 
                                    <div class="grid  grid-flow-col gap-3 justify-start items-center">
                                    <Icon class="text-xl w-4 h-4 bg-orange-400 text-white rounded-full" name="uil:check" />
                                    <p class="">Personalised guidance for academic and professional paths.</p>
                                    </div> 
                                    <div class="grid  grid-flow-col gap-3 justify-start items-center">
                                    <Icon class="text-xl w-4 h-4 bg-orange-400 text-white rounded-full" name="uil:check" />
                                    <p class="">Advice on course selection,planning and skill development.</p>
                                    </div> 
                                    </div>

                                    <!-- seventh card -->

                                    <div class="shadow-md p-4 cursor-pointer hover:shadow-lg transition-all border hover:scale-105 border-white hover:border-indigo-500 rounded-md  grid gap-3">

                                        <div class="w-16 h-16   text-white flex justify-center items-center rounded-md">
                                        
                                            <nuxt-img src="/Feature_icons/personal diary.png" class="cursor-pointer" />

                                        </div>
                                        <p class="text-xl">Personal Diary</p>
                                        <div class="grid  grid-flow-col gap-3 justify-start items-center">
                                        <Icon class="text-xl w-4 h-4 bg-orange-400 text-white rounded-full" name="uil:check" />
                                        <p class="">Journaling.</p>
                                        </div> 
                                        <div class="grid  grid-flow-col gap-3 justify-start items-center">
                                        <Icon class="text-xl w-4 h-4 bg-orange-400 text-white rounded-full" name="uil:check" />
                                        <p class="">search and orgnize</p>
                                        </div> 
                                        <div class="grid  grid-flow-col gap-3 justify-start items-center">
                                        <Icon class="text-xl w-4 h-4 bg-orange-400 text-white rounded-full" name="uil:check" />
                                        <p class="">Privacy and costumization</p>
                                        </div> 
                                        </div>

                                        <!-- eight card -->
                                        <div class="shadow-md p-4 cursor-pointer hover:shadow-lg transition-all border hover:scale-105 border-white hover:border-indigo-500 rounded-md  grid gap-3">

                                            <div class="w-16 h-16   text-white flex justify-center items-center rounded-md">
                                            
                                                <nuxt-img src="/Feature_icons/reminders.png" class="cursor-pointer" />

                                            </div>
                                            <p class="text-xl">Remainders</p>
                                            <div class="grid  grid-flow-col gap-3 justify-start items-center">
                                            <Icon class="text-xl w-4 h-4 bg-orange-400 text-white rounded-full" name="uil:check" />
                                            <p class="">Costum remainders.</p>
                                            </div> 
                                            <div class="grid  grid-flow-col gap-3 justify-start items-center">
                                            <Icon class="text-xl w-4 h-4 bg-orange-400 text-white rounded-full" name="uil:check" />
                                            <p class="">Schedule Entries</p>
                                            </div> 
                                            <div class="grid  grid-flow-col gap-3 justify-start items-center">
                                            <Icon class="text-xl w-4 h-4 bg-orange-400 text-white rounded-full" name="uil:check" />
                                            <p class="">Notification settings</p>
                                            </div> 
                                            </div>



            </div>
        </div>

    </section>
</template>

<script>
    export default {
        name: 'FeatureSection',
        data() {
            return {
                features: [
                    {
                        icon: "user",
                        title: "Daily Routine Tracker",
                        desc: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec congue, nisl eget molestie varius, enim ex faucibus purus.",
                        href: "javascript:void(0)"
                    },



                ]
            }
        }
    }
</script>