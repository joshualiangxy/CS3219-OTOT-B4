<template>
  <form @submit="onSubmit" class="add-form">
    <p v-show="addNoteError">{{ addNoteError }}</p>
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
  name: 'AddNoteForm',
  data() {
    return {
      title: '',
      comment: ''
    }
  },
  props: {
    addNoteError: String,
  },
  methods: {
    onSubmit(e) {
      e.preventDefault();

      if (!this.title) {
        alert('Note requires a title!');
        return;
      }

      const newNote = {
        title: this.title,
        comment: this.comment
      }

      this.$emit('add-note', newNote);

      this.title = '';
      this.comment = '';
    }
  }
}
</script>

<style scoped>
.add-form {
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
