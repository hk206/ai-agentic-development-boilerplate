---
name: review-pr
description: GitHub PRのコードレビューを行う。PRの差分を分析し、構造化されたレビューコメントを生成する。
argument-hint: "[PR番号またはPR URL]"
disable-model-invocation: true
allowed-tools: Read, Glob, Grep, Bash
---

# PRレビュー

`$ARGUMENTS` のPRをレビューする。

## PR情報（自動取得）

- 変更ファイル一覧: !`gh pr diff $ARGUMENTS --stat 2>/dev/null || echo "PR情報の取得に失敗しました。PR番号を確認してください。"`
- PR概要: !`gh pr view $ARGUMENTS 2>/dev/null || echo "PR情報の取得に失敗しました。"`
- PR差分: !`gh pr diff $ARGUMENTS 2>/dev/null || echo "PR差分の取得に失敗しました。"`

## レビュー観点

### 1. 変更の妥当性
- PR説明と変更内容が一致しているか
- スコープが適切か（変更が大きすぎないか）
- 不要な変更が含まれていないか

### 2. コード品質
- `.claude/rules/coding-standards.md` への準拠
- 命名の適切さ
- コードの重複
- 関数の責任範囲

### 3. セキュリティ
- 入力バリデーション
- 認証・認可の確認
- 秘密情報の露出チェック
- XSS, CSRF, インジェクション

### 4. 型安全性
- TypeScript型定義の適切さ
- `any` 型の使用有無
- 型ガードの使用

### 5. テスト
- テストの追加・更新が必要か
- テストケースの網羅性

### 6. パフォーマンス
- パフォーマンスへの影響
- 不要な再レンダリング
- バンドルサイズへの影響

## 出力形式

```markdown
## PRレビュー: #[PR番号] [タイトル]

### サマリー
[変更内容の要約と全体的な評価]

### Critical（必須修正）
- **[ファイル:行番号]**: [指摘内容]
  - 修正案: [具体的なコード]

### Warning（修正推奨）
- **[ファイル:行番号]**: [指摘内容]
  - 修正案: [具体的なコード]

### Suggestion（改善提案）
- **[ファイル:行番号]**: [指摘内容]

### Good（良い点）
- [優れた実装への言及]

### 判定
- [ ] Approve（承認）
- [ ] Request Changes（修正依頼）
- [ ] Comment（コメントのみ）
```
