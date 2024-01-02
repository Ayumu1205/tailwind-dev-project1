FROM ubuntu:latest
WORKDIR /root

# パッケージアップデート & インストール
RUN apt update -y &&\
    apt upgrade -y &&\
    apt install -y curl

# nodejsのインストール
RUN curl -sL https://deb.nodesource.com/setup_20.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt install -y nodejs

# tailwindcssのインストール
WORKDIR /root/app
RUN npm install -D tailwindcss postcss-cli autoprefixer
RUN npm init -y &&\
    npx tailwindcss init -p 

# # tailwindcss, postcssの設定
RUN echo "content: ['./*.html']" >> tailwind.config.js
RUN touch tailwind.css &&\
    echo "@tailwind base;" >> tailwind.css &&\
    echo "@tailwind components;" >> tailwind.css &&\
    echo "@tailwind utilities;" >> tailwind.css

# # ビルド
RUN touch dist.css &&\
    npx tailwindcss -i tailwind.css -o dist.css

ENTRYPOINT [ "/bin/bash" ]