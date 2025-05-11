# Etap 1: Używamy lekkiego obrazu Node.js
FROM node:18-alpine

# Instalujemy opcjonalne zależności systemowe (np. git, jeśli są potrzebne)
RUN apk add --no-cache bash

# Ustawiamy katalog roboczy
WORKDIR /app

# Kopiujemy pliki package.json i package-lock.json (jeśli istnieją)
COPY package*.json ./

# Instalujemy zależności, w tym axios
RUN npm install

# Kopiujemy resztę plików aplikacji
COPY . .

# Udostępniamy port używany przez Vite
EXPOSE 5173

# Domyślne polecenie uruchamiające serwer deweloperski Vite
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0", "--port", "5173"]
