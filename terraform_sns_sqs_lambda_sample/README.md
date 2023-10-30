# 本リソースについて

Terraform を用いて SNS, SQS, Lambda を構築するサンプル

- 動作確認には LocalStack を使用（Docker）

```
% docker compose up -d

% docker compose ps
NAME                IMAGE                               COMMAND                  SERVICE             CREATED             STATUS                    PORTS
localstack          localstack/localstack:2.2.0-arm64   "docker-entrypoint.sh"   localstack          50 minutes ago      Up 50 minutes (healthy)   127.0.0.1:4510-4559->4510-4559/tcp, 127.0.0.1:4566->4566/tcp, 5678/tcp
```

# 記載記事リンク

//todo
