<script lang="ts">
import { defineComponent, ref, onMounted, computed } from 'vue';
import axios from 'axios';

interface LogEntry {
  timestamp: string;
  level: string;
  message: string;
  source: string;
}

export default defineComponent({
  setup() {
    const logi = ref<LogEntry[]>([]);
    const selectedLevel = ref<string>('all');

    onMounted(async () => {
      try {
        const res = await axios.get('http://localhost:5044/logs'); // docelowy endpoint
        logi.value = res.data;
      } catch (err) {
        console.error('Błąd przy pobieraniu logów:', err);
      }
    });

    const przefiltrowaneLogi = computed(() => {
      if (selectedLevel.value === 'all') return logi.value;
      return logi.value.filter(log => log.level === selectedLevel.value);
    });

    return { logi, selectedLevel, przefiltrowaneLogi };
  }
});
</script>

<template>
  <div>
    <h1>Logi systemowe</h1>

    <label for="level">Filtruj wg poziomu:</label>
    <select id="level" v-model="selectedLevel">
      <option value="all">Wszystkie</option>
      <option value="info">Info</option>
      <option value="warning">Warning</option>
      <option value="error">Error</option>
    </select>

    <table border="1" cellpadding="5" cellspacing="0">
      <thead>
        <tr>
          <th>Data</th>
          <th>Poziom</th>
          <th>Źródło</th>
          <th>Wiadomość</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(log, index) in przefiltrowaneLogi" :key="index">
          <td>{{ log.timestamp }}</td>
          <td>{{ log.level }}</td>
          <td>{{ log.source }}</td>
          <td>{{ log.message }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<style scoped>
h1 {
  margin-bottom: 1rem;
}
table {
  width: 100%;
  margin-top: 1rem;
}
select {
  margin-left: 0.5rem;
}
</style>
