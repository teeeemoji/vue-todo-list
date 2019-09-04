<template>
  <div id="app">
    <Layout>
      <template v-slot:header>
        My Simple ToDo List
      </template>
      <div is="ToDoList"></div>
      <template v-slot:footer>
        credit to Teeeemoji
      </template>
    </Layout>
  </div>
</template>

<script>
import Layout from './components/Layout'
import ToDoList from './components/ToDoList'

export default {
  name: 'app',
  components: {
    Layout,
    ToDoList
  }
}
</script>

<style>
* {
  box-sizing: border-box;
}

html,
body {
  margin: 0;
  padding: 0;
  height: 100%;
}

ul,
ol {
  padding: 0;
  margin: 0;
}

#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  height: 100%;
}
</style>
