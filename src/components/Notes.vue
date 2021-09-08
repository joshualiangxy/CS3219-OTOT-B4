<template>
  <div :key="note._id" v-for="note in notes">
    <Note
      @delete-note="$emit('delete-note', note._id)"
      @edit-note="editNote"
      :note="note"
      :axiosInstance="axiosInstance"
    />
  </div>
</template>

<script>
import Note from './Note.vue';

export default {
  name: 'Notes',
  components: {
    Note
  },
  props: {
    notes: Array,
    axiosInstance: Function
  },
  methods: {
    editNote(updatedNote) {
      this.$emit('edit-note', updatedNote);
    }
  },
  emits: [
    'delete-note',
    'edit-note'
  ]
}
</script>
