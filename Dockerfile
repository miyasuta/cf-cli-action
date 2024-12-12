FROM ubuntu:24.04

# 必要なパッケージをインストール
RUN apt-get update && apt-get install -y \
    ca-certificates \
    jq \
    wget \
    gpg \
    curl \
    gnupg

# Cloud Foundry CLIのセットアップ
RUN wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | gpg --dearmor -o /usr/share/keyrings/cli.cloudfoundry.org.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/cli.cloudfoundry.org.gpg] https://packages.cloudfoundry.org/debian stable main" | tee /etc/apt/sources.list.d/cloudfoundry-cli.list
RUN apt-get update && apt-get install -y cf8-cli

# Node.jsとnpmのインストール
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
RUN apt-get install -y nodejs

# mbtのインストール
RUN npm install -g mbt

# エントリーポイントスクリプトの追加
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# FROM ubuntu:18.04

# RUN apt-get update
# RUN apt-get install -y ca-certificates jq

# RUN echo "deb [trusted=yes] https://packages.cloudfoundry.org/debian stable main" > /etc/apt/sources.list.d/cloudfoundry-cli.list
# RUN apt-get update
# RUN apt-get install -y cf8-cli

# ADD entrypoint.sh /entrypoint.sh
# ENTRYPOINT ["/entrypoint.sh"]
