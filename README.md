# README

Make sure the bundler version is upper than 2.5 if you have issues run this command.
Bundler のバージョンが 2.5 以上であることを確認してください。問題が発生した場合は、このコマンドを実行してください。

```bash
  gem install bundler -v '~> 2.5'
```

## Initializing

- Please install all gems before starting. / 開始する前にすべての GEM をインストールしてください。

```bash
bundle install
```

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

## User for testing app / アプリのテスト用ユーザー

```bash
user_id: user0
password: password
```

## Set the ENV files with the correct credentials

- Ask for the credentials if you don't have it. / 資格情報を持っていない場合は、資格情報を求めてください。
- create and .env file in the root directory. / ルートディレクトリに.env ファイルを作成してください。
- If you don't set this the cooperation tweet feature will fail. / これを設定しないと、ツイート連携機能が失敗します。

```typescript
  CLIENT_ID=**********************
  CLIENT_SECRET=********************
```

### Uncommented Gems and Additional Gems

- bcrypt uncommented
- dotenv for ENV security

## Others

- How to run the test suite / テストスイートの実行方法

```bash
  rails test test/
```
