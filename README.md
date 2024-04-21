# README

## Ruby version/Ruby のバージョン

- ruby 3.0.6p216 (2023-03-30 revision 23a532679b) [x86_64-darwin21]

## Rails Version/Rails のバージョン

- Rails 7.0.8.1

- System dependencies

- Configuration

## DB

- Postgresql

## Database creation

In the main root exec this command to create, migrate and seed DB.
ルートディレクトリで以下のコマンドを実行して、データベースを作成、マイグレートし、シードを行います。

```typescript
  ./refresh_db.sh
```

if you experience permission issues exec this command.
実行時に権限の問題が発生した場合は、このコマンドを実行してください。

```typescript
  chmod +x refresh_db.sh
```

## USER FOR TEST THE APP/ アプリのテスト用ユーザー

```bash
user_id: user0
password: password
```

## Set the ENV files with the correct credentials

```typescript
  CLIENT_ID=**********************
  CLIENT_SECRET=********************
```

### Uncommented Gems and Additional Gems

- bcrypt uncommented
- dotenv for ENV security

## Others

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...
