<template>
  <div class="todo-list-comp">
    <div class="empty-todo-list" v-if="!todoList.length">
      Empty
    </div>
    <transition-group
      ref="list"
      class="todo-list"
      name="todo-list"
      tag="ul"
      @after-enter="_afterEnter"
      v-else
    >
      <li
        class="todo-list-item"
        ref="item"
        is="ToDoListItem"
        v-for="todoItem in sortedTodoList"
        v-bind="todoItem.addTime === editItemId ? tmpItem : todoItem"
        :key="todoItem.addTime"
        :isEdit="todoItem.addTime === editItemId"
        @edit="_handleListItemEdit"
        @status-change="_handleStatusChange"
        @change="_handleItemChange"
      ></li>
      <li
        class="todo-list-item"
        ref="new"
        is="ToDoListItem"
        v-if="isAddNew"
        v-bind="tmpItem"
        :key="isAddNew ? tmpItem.addTime : -1"
        :isEdit="isAddNew"
        @edit="_handleListItemEdit"
        @status-change="_handleStatusChange"
        @change="_handleItemChange"
      ></li>
    </transition-group>
    <div class="operations" key="viewing" v-if="!isEdit">
      <el-button key="new" @click="_handleAddNewClick">
        New
      </el-button>
    </div>
    <div class="operations" key="editing" v-if="isEdit">
      <el-button key="confirm" @click="_handleConfirmClick">
        Confirm
      </el-button>
      <el-button v-show="isEdit" key="cancel" @click="_handleCancelClick">
        Cancel
      </el-button>
    </div>
  </div>
</template>

<script>
import ToDoListItem, {generateEmptyItem} from './ToDoListItem'
import Velocity from 'velocity-animate'

const NOT_EDIT_INDEX = -1

export default {
  name: 'ToDoList',
  components: {
    ToDoListItem
  },
  data: function() {
    return {
      todoList: [
        {
          addTime: 1,
          title: '1 ToDo Item'
        },
        {
          addTime: 2,
          title: '2 ToDo Item'
        },
        {
          addTime: 3,
          title: '3 ToDo Item'
        },
        {
          addTime: 4,
          title: '4 ToDo Item'
        },
        {
          addTime: 5,
          title: '5 ToDo Item'
        }
      ],
      editItemId: NOT_EDIT_INDEX,
      isAddNew: false,
      tmpItem: {
        ...generateEmptyItem()
      }
    }
  },
  computed: {
    isEdit: function() {
      return this.editItemId !== NOT_EDIT_INDEX || this.isAddNew
    },
    sortedTodoList: function() {
      return this.todoList.slice().sort(function(a, b) {
        if (a.done === b.done) {
          return 0
        } else if (a.done && !b.done) {
          return -1
        } else {
          return 1
        }
      })
    }
  },
  methods: {
    _handleListItemEdit: function(e, addTime) {
      if (this.isEdit) {
        return
      }
      const index = this.todoList.findIndex(function(i) {
        return i.addTime === addTime
      })
      this.editItemId = addTime
      this.tmpItem = {...this.todoList[index]}
    },
    _handleItemChange: function(newVal) {
      this.tmpItem = Object.assign({}, this.tmpItem, newVal)
    },
    _handleStatusChange: function(key, newStatus) {
      const index = this.todoList.findIndex(function(i) {
        return i.addTime === key
      })
      if (this.todoList[index]) {
        this.$set(
          this.todoList,
          index,
          Object.assign({}, this.todoList[index], {done: newStatus})
        )
      } else {
        this.$set(this.tmpItem, 'done', newStatus)
      }
    },
    _handleAddNewClick: function() {
      this.isAddNew = true
      this.tmpItem = generateEmptyItem()
    },
    _handleConfirmClick: function() {
      if (this.isAddNew) {
        if (!this.$refs.new.validate()) {
          return
        }
        this.isAddNew = false
        this.todoList.push(Object.assign({}, this.tmpItem))
      } else {
        const addTime = this.editItemId
        const ref = this.$refs.item.find(function(i) {
          return i.addTime === addTime
        })
        if (!ref || !ref.validate()) {
          return
        }
        const itemIndex = this.todoList.findIndex(function(i) {
          return i.addTime === addTime
        })
        this.$set(this.todoList, itemIndex, {...this.tmpItem})
      }
      this.editItemId = NOT_EDIT_INDEX
    },
    _handleCancelClick: function() {
      if (this.isAddNew) {
        this.isAddNew = false
      }
      this.editItemId = NOT_EDIT_INDEX
    },
    _afterEnter: function(el) {
      const listDOM = this.$refs.list.$el
      if (!!listDOM && listDOM.offsetHeight < listDOM.scrollHeight) {
        Velocity(el, 'scroll', {duration: 300, container: listDOM})
      }
    }
  }
}
</script>

<style>
.todo-list-comp {
  display: flex;
  position: relative;
  text-align: left;
  font-size: 15px;
  width: 600px;
  margin: 0 auto;
  border: 1px solid #dcdfe6;
  border-radius: 4px;
  padding-bottom: 80px;
  height: 100%;
  min-height: 300px;
  overflow: hidden;
}

.todo-list {
  flex-grow: 1;
  padding: 20px;
  overflow-y: auto;
}

.todo-list-item {
  transition: all 0.3s ease-in-out;
}

.todo-list-enter,
.todo-list-leave-to {
  opacity: 0;
  transform: translateX(1000px);
}

.todo-list-leave-active {
  position: absolute;
}

.operations {
  position: absolute;
  left: 0;
  bottom: 0;
  width: 100%;
  padding: 20px;
  text-align: center;
  background-color: #fff;
  border-top: 1px solid #dcdfe6;
}
</style>
