# Git運用ルール

## ブランチ命名

- `feature/` — 新機能
- `fix/` — バグ修正
- `refactor/` — リファクタリング
- `docs/` — ドキュメント変更
- `test/` — テスト追加・修正
- `chore/` — その他（依存関係更新、設定変更等）

例: `feature/user-authentication`, `fix/login-error`

## コミットメッセージ

Conventional Commits 形式を使用する:

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### type

- `feat`: 新機能
- `fix`: バグ修正
- `refactor`: リファクタリング（機能変更なし）
- `docs`: ドキュメント変更
- `test`: テスト追加・修正
- `chore`: ビルド・CI設定等
- `style`: フォーマット変更（コードの意味に影響しない）
- `perf`: パフォーマンス改善

### 例

```
feat(auth): ログイン画面にOAuth認証を追加

Google OAuth 2.0を使用したソーシャルログイン機能を実装。
既存のメール/パスワード認証と併用可能。

Closes #42
```

## PR運用

- 1 PR = 1機能/1修正（小さく保つ）
- PRタイトルはConventional Commits形式
- レビュー前にセルフレビューを行う
- CIが通ってからレビュー依頼する
