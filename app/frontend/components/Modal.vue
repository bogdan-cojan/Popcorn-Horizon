<template>
  <div v-if="showModal" class="modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-modal="true" role="dialog" style="display: block;">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">{{ title }}</h5>
          <button type="button" @click="$emit('close')" class="btn-close"></button>
        </div>
        <div class="modal-body">
          <slot></slot>
        </div>
        <div class="modal-footer">
          <button type="button" @click="$emit('close')" class="btn btn-secondary">Close</button>
          <button type="button" @click="$emit('save')" class="btn btn-primary">Save</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Modal',
  props: ['showModal', 'title'],
};
</script>
