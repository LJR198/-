<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>


export default {
  name: 'app',
  components: {

  }
}
</script>

<style>
#app,body,html{
  width: 100%;
  height: 100%;
}
.el-calendar-day{
    height: 130px;
    
}
</style>
