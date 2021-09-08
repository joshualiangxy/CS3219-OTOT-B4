<template>
  <div class="container">
    <Header
      @toggle-add-note="toggleAddNote"
      :showAddNote="showAddNote"
    />
    <p v-show="deleteNoteError">{{ deleteNoteError }}</p>
    <AddNoteForm
      v-show="showAddNote"
      @add-note="addNote"
      :addNoteError="addNoteError"
    />
    <Notes
      @edit-note="editNote"
      @delete-note="deleteNote"
      :axiosInstance="axiosInstance"
      :notes="notes"
    />
  </div>
</template>

<script>
import axios from 'axios';
import Header from './components/Header.vue';
import Notes from './components/Notes.vue';
import AddNoteForm from './components/AddNoteForm.vue';

export default {
  name: 'App',
  components: {
    AddNoteForm,
    Header,
    Notes
  },
  data() {
    return {
      axiosInstance: axios.create({ baseURL: 'https://notes-app-qjkfjkawhq-as.a.run.app/notes' }),
      addNoteError: '',
      deleteNoteError: '',
      notes: [],
      showAddNote: false,
    };
  },
  methods: {
    async addNote(newNote) {
      try {
        const response = await this.axiosInstance.post('/', newNote);

        if (response.status !== 201) {
          this.deleteNoteError = '';
          this.addNoteError = 'Something went wrong when creating your note :(';
          return;
        }

        this.deleteNoteError = '';
        this.addNoteError = '';
        this.notes.push(response.data);
        this.showAddNote = false;
      } catch (err) {
        this.deleteNoteError = '';
        this.addNoteError = 'Something went wrong when creating your note :(';
      }
    },
    async editNote(updatedNote) {
      this.addNoteError = '';
      this.deleteNoteError = '';
      this.notes = this.notes.map(note => note._id === updatedNote._id ? updatedNote : note);
    },
    async deleteNote(_id) {
      if (confirm('Are you sure?')) {
        try {
          const response = await this.axiosInstance.delete(`/${_id}`);

          if (response.status !== 200) {
            this.addNoteError = '';
            this.deleteNoteError = 'Something went wrong when deleting your note :(';
            return;
          }

          this.addNoteError = '';
          this.deleteNoteError = '';
          this.notes = this.notes.filter(note => note._id !== _id);
        } catch (err) {
          this.addNoteError = '';
          this.deleteNoteError = 'Something went wrong when deleting your note :(';
        }
      }
    },
    toggleAddNote() {
      this.showAddNote = !this.showAddNote;
    }
  },
  async created() {
    try {
      const response = await this.axiosInstance.get('/');

      if (typeof response.data == 'string')
        return;
      this.notes = response.data;
    } catch (err) {
      console.log(err);
    }

    console.log(this.notes);
  }
};
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400&display=swap');

* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body {
  font-family: 'Poppins', sans-serif;
}

.container {
  max-width: 500px;
  margin: 30px auto;
  overflow: auto;
  min-height: 300px;
  border: 1px solid steelblue;
  padding: 30px;
  border-radius: 5px;
}

.btn {
  display: inline-block;
  background: #000;
  color: #fff;
  border: none;
  padding: 10px 20px;
  margin: 5px;
  border-radius: 5px;
  cursor: pointer;
  text-decoration: none;
  font-size: 15px;
  font-family: inherit;
}

.btn:focus {
  outline: none;
}

.btn:active {
  transform: scale(0.98);
}

.btn-block {
  display: block;
  width: 100%;
}
</style>
