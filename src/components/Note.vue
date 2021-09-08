<template>
  <div class="note">
    <h3>
      {{ note.title }}
      <div>
        <i @click="toggleEditNote" class="fas fa-edit" />
        <i @click="$emit('delete-note')" class="fas fa-times" />
      </div>
    </h3>
    <p>{{ note.comment }}</p>
    <EditNoteForm
      v-show="showEditNote"
      @edit-note="editNote"
      :axiosInstance="axiosInstance"
      :note="note"
    />
  </div>
</template>

<script>
import EditNoteForm from './EditNoteForm.vue';

export default {
  name: 'Note',
  components: {
    EditNoteForm
  },
  data() {
    return {
      showEditNote: false
    };
  },
  props: {
    axiosInstance: Function,
    note: Object
  },
  methods: {
    async editNote(updatedNote) {
      this.showEditNote = false;
      this.$emit('edit-note', updatedNote);
    },
    toggleEditNote() {
      this.showEditNote = !this.showEditNote;
    }
  },
  emits: [
    'edit-note',
    'delete-note'
  ]
};
</script>

<style scope>
.fa-times {
  margin-left: 0.1rem;
  color: red;
}

.note {
  background: #f4f4f4;
  margin: 5px;
  padding: 10px 20px;
  cursor: pointer;
}

.note h3 {
  display: flex;
  align-items: center;
  justify-content: space-between;
}
</style>
