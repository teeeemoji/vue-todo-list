<template>
  <li :class="['todo-list-item-comp', {done}]" @dblclick.stop="_handleClick">
    <div class="editable" v-if="isEdit">
      <el-input
        :class="{error}"
        :value="title"
        @input="_handleInputChange"
        ref="input"
      >
        <template v-slot:prepend>
          <ItemCheckbox
            :checked="done"
            @change="_handleStatusChange"
          ></ItemCheckbox>
        </template>
      </el-input>
    </div>
    <div class="viewable" v-else>
      <ItemCheckbox
        class="viewable-checkbox"
        :checked="done"
        @change="_handleStatusChange"
      ></ItemCheckbox>
      <span :class="['viewable-name', {done}]">{{ title | trim }}</span>
    </div>
  </li>
</template>

<script>
import ItemCheckbox from './ItemCheckbox'

export const EMPTY_ITEM = {
  isEdit: false,
  addTime: -1,
  doneTime: null,
  title: '',
  done: false
}

export function generateEmptyItem() {
  return {
    ...EMPTY_ITEM,
    addTime: new Date().valueOf()
  }
}

export default {
  name: 'Layout',
  components: {
    ItemCheckbox
  },
  filters: {
    trim: function(value) {
      return value.trim()
    }
  },
  props: {
    isEdit: {
      type: Boolean,
      default: false
    },
    addTime: {
      type: [Date, Number],
      default: function() {
        return new Date().valueOf()
      }
    },
    doneTime: {
      type: Date,
      default: null
    },
    title: {
      type: String,
      default: ''
    },
    done: {
      type: Boolean,
      default: false
    }
  },
  data: function() {
    return {
      error: false
    }
  },
  methods: {
    _handleClick: function(e) {
      this.$emit('edit', e, this.$vnode.key)
    },
    _handleInputChange: function(value) {
      if (this.error) {
        this.error = false
      }
      this.$emit('change', {title: value})
    },
    _handleStatusChange: function(status) {
      this.$emit('status-change', this.$vnode.key, status)
    },
    validate: function() {
      this.error = !this.title
      return !this.error
    }
  }
}
</script>

<style>
.todo-list-item-comp {
  list-style: none;
  margin-bottom: 12px;
  background-color: #fff;
}

.todo-list-item-comp .viewable {
  min-height: 40px;
  border: 1px solid transparent;
  word-break: break-word;
  word-break: break-all;
}

.todo-list-item-comp .viewable-checkbox {
  width: 71px;
  padding-left: 20px;
  vertical-align: top;
}

.todo-list-item-comp .viewable-name {
  position: relative;
  display: inline-block;
  padding-left: 16px;
  padding-top: 8px;
  padding-right: 12px;
  max-width: calc(100% - 71px);
}

.todo-list-item-comp.done .viewable-name {
  text-decoration: line-through;
  text-decoration-color: #409eff;
  color: #999;
}

.todo-list-item-comp input {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  font-size: 15px;
}

.todo-list-item-comp .error input {
  border-color: red;
}
</style>
