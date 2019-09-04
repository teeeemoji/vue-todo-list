<template>
  <div
    class="item-checkbox-comp"
    @click.stop="_handleChange"
    @dblclick.prevent.stop
  >
    <input type="checkbox" v-model="checked" hidden />
    <div :class="['item-checkbox-inner', {checked}]"></div>
  </div>
</template>

<script>
export default {
  name: 'ItemCheckbox',
  model: {
    prop: 'checked',
    event: 'change'
  },
  props: {
    checked: {
      type: Boolean,
      default: false
    }
  },
  methods: {
    _handleChange: function() {
      this.$emit('change', !this.checked)
    }
  }
}
</script>

<style scoped>
.item-checkbox-comp {
  display: inline-block;
  vertical-align: middle;
  height: 38px;
  padding: 4px 0;
  cursor: pointer;
}

.item-checkbox-comp .item-checkbox-inner {
  position: relative;
  width: 30px;
  height: 30px;
  background-color: #fff;
  border-radius: 50%;
  border: 1px solid #dcdfe6;
  transition: all 0.3s ease-in-out;
}

.item-checkbox-comp .item-checkbox-inner::after {
  content: '';
  display: block;
  position: absolute;
  left: 4px;
  top: 7px;
  width: 18px;
  height: 8px;
  border-width: 0 0 2px 2px;
  border-style: solid;
  border-color: #fff;
  transform: rotate(-45deg);
}

.item-checkbox-comp .item-checkbox-inner.checked {
  border-color: #409eff;
  background-color: #409eff;
}
</style>
