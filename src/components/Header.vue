<template>
  <div class="todo-list-layout-header">
    <slot></slot>
  </div>
</template>

<script>
export default {
  name: 'Header'
}
</script>

<style scoped>
.todo-list-layout-header {
  padding: 20px;
  font-size: 24px;
  font-weight: bold;
  text-align: center;
  color: #666;
}
</style>
