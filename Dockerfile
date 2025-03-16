# Używamy obrazu Node.js w wersji 18-alpine
FROM node:18-alpine

# Ustawiamy katalog roboczy
WORKDIR /app

# Kopiujemy pliki package.json i package-lock.json (jeśli istnieje)
COPY package*.json ./

# Instalujemy zależności
RUN npm install

# Kopiujemy cały kod aplikacji
COPY . .

# Udostępniamy port, na którym działa aplikacja (np. Vite domyślnie używa 5173)
EXPOSE 5173

# Uruchamiamy aplikację w trybie developerskim
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0", "--port", "5173"]
