# Imagen base
FROM node:14

# Directorio de trabajo
WORKDIR /app

# Copiar archivos de la aplicación
COPY package.json .
COPY package-lock.json .
COPY index.html .
COPY main.js .
COPY server.js .

# Instalación de dependencias
RUN npm install --production

# Exponer el puerto
EXPOSE 3000

# Comando de inicio de la aplicación
CMD [ "node", "server.js" ]
