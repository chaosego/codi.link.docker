# Build Stage
FROM node:18-alpine AS builder
WORKDIR /app
COPY package.json ./
RUN npm install --force --ignore-scripts
COPY . .
EXPOSE 5173
RUN npm run build

# Runtime Stage
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]