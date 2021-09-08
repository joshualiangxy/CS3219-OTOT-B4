<template>
  <form @submit="onSubmit" class="edit-form">
    <p v-show="editNoteError">{{ editNoteError }}</p>
    <div class="form-control">
      <label>Title</label>
      <input
        v-model="title"
        type="text"
        name="title"
        placeholder="Meeting @3pm"
      />
    </div>
    <div class="form-control">
      <label>Comment</label>
      <input
        v-model="comment"
        type="text"
        name="comment"
        placeholder="Prepare notes"
      />
    </div>
    <input class="btn btn-block" type="submit" value="Save Note" />
  </form>
</template>

<script>
export default {
  name: 'EditNoteForm',
  data() {
    return {
      title: this.note.title,
      comment: this.note.comment,
      editNoteError: ''
    }
  },
  props: {
    axiosInstance: Function,
    note: Object,
  },
  methods: {
    async onSubmit(e) {
      e.preventDefault();

      if (!this.title) {
        alert('Note requires a title!');
        return;
      }

      const updatedNote = {
        _id: this.note._id,
        title: this.title,
        comment: this.comment
      }

      try {
        const response = await this.axiosInstance.put('/', updatedNote);

        if (response.status !== 200) {
          this.editNoteError = 'Something went wrong when updating your note :(';
          return;
        }

        this.editNoteError = '';
        this.title = response.data.title;
        this.comment = response.data.comment;
        this.$emit('edit-note', response.data);
      } catch (err) {
        this.editNoteError = 'Something went wrong when updating your note :(';
      }
    }
  }
}
</script>

<style scoped>
.edit-form {
  margin-bottom: 40px;
}

.form-control {
  margin: 20px 0;
}

.form-control label {
  display: block;
}

.form-control input {
  width: 100%;
  height: 40px;
  margin: 5px;
  padding: 3px 7px;
  font-size: 17px;
}
</style>
