<script lang="ts">
import { defineComponent, ref, onMounted } from 'vue';
import axios from 'axios';

export default defineComponent({
  setup() {
    const logi = ref<any>(null);

    onMounted(async () => {
      try {
        const res = await axios.get('http://localhost:5044/test');
        logi.value = res.data;
      } catch (err) {
        console.error('Błąd przy pobieraniu logów:', err);
      }
    });

    return { logi };
  }
});
</script>

<template>
  <div>
    <h1>Logi</h1>
    <pre>{{ logi }}</pre>
  </div>
</template>
