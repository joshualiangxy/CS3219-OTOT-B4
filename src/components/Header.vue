<template>
  <header>
    <h1>{{ title }}</h1>
    <Button
      @btn-click="$emit('toggle-add-note')" 
      :text="showAddNote ? 'Close' : 'Add Note'"
      :color="showAddNote ? 'red' : 'green'"
    />
  </header>
</template>

<script>
import Button from './Button.vue';

export default {
  name: 'Header',
  components: {
    Button
  },
  props: {
    title: {
      type: String,
      default: 'Notes Board'
    },
    showAddNote: {
      type: Boolean,
      default: false
    }
  }
};
</script>

<style scoped>
header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}
</style>
