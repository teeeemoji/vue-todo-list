<template>
  <div class="todo-list-layout">
    <div v-if="$slots.header" is="Header">
      <slot name="header"></slot>
    </div>
    <div v-if="$slots.default" class="body">
      <slot></slot>
    </div>
    <div v-if="$slots.footer" class="footer" is="Footer">
      <slot name="footer"></slot>
    </div>
  </div>
</template>

<script>
import Header from './Header'
import Footer from './Footer'

export default {
  name: 'Layout',
  components: {
    Header,
    Footer
  }
}
</script>

<style scoped>
.todo-list-layout {
  display: flex;
  flex-direction: column;
  position: relative;
  height: 100%;
  width: 100%;
  min-height: 400px;
  min-width: 600px;
  padding-bottom: 40px;
}

.body {
  flex-grow: 1;
  overflow: hidden;
  position: relative;
}

.footer {
  position: absolute;
  left: 0;
  bottom: 0;
  width: 100%;
  height: 40px;
  line-height: 40px;
}
</style>
