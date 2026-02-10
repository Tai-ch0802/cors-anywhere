# 依據你的要求，使用 node:14-alpine 作為基底
FROM node:14-alpine

# 設定工作目錄
WORKDIR /app

# 複製 package.json (如果有的話也包含 package-lock.json)
COPY package.json ./

# 安裝依賴套件
# --production 參數可以避免安裝 devDependencies，讓映像檔更小
RUN npm install --production

# 複製所有程式碼到容器內
COPY . .

# 設定環境變數預設值 (對應 server.js 的邏輯)
ENV PORT=8080
ENV HOST=0.0.0.0

# 宣告容器會使用的 Port
EXPOSE 8080

# 啟動服務 (參考 Procfile)
CMD ["node", "server.js"]
