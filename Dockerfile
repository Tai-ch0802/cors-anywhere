# Node.js 14 已於 2023-04 EOL（之後的 HTTP 解析、TLS 等安全修補都不會再有），改用仍在維護的 LTS
FROM node:22-alpine

# 設定工作目錄
WORKDIR /app

# 依 lockfile 安裝，版本固定、可重現
COPY package.json package-lock.json ./

# --omit=dev：不安裝 devDependencies；--ignore-scripts：不執行相依套件的 install script
RUN npm ci --omit=dev --ignore-scripts --no-audit --no-fund

# 複製所有程式碼到容器內（node_modules / .git 由 .dockerignore 排除）
COPY . .

# 設定環境變數預設值 (對應 server.js 的邏輯)
ENV PORT=8080
ENV HOST=0.0.0.0

# 宣告容器會使用的 Port
EXPOSE 8080

# 以非 root 身分執行（官方 node 映像內建 node 使用者）
USER node

# 啟動服務 (參考 Procfile)
CMD ["node", "server.js"]
