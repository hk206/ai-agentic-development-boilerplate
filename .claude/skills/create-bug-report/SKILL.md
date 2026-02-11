---
name: create-bug-report
description: バグレポートを作成する。不具合の報告やGitHub Issue作成が必要なときに使用する。
argument-hint: "[バグの概要]"
disable-model-invocation: true
allowed-tools: Read, Write, Bash, Glob, Grep
---

# バグレポート作成

`$ARGUMENTS` に基づいてバグレポートを作成する。

## 手順

1. バグの概要からコードベースを調査する
2. 再現手順を特定する
3. 構造化されたバグレポートを作成する
4. `docs/bugs/` に保存する
5. 必要に応じてGitHub Issueとして発行する

## バグレポートの構成

テンプレート: [templates/bug-report-template.md](templates/bug-report-template.md)

### タイトル
`[BUG] 簡潔な問題の説明`

### 深刻度の判定基準

| 深刻度 | 定義 | 例 |
|--------|------|-----|
| Critical | サービス停止、データ損失 | 本番環境のクラッシュ |
| High | 主要機能が使用不可 | ログインできない |
| Medium | 機能は使えるが不便 | 検索結果の並び順が不正 |
| Low | 軽微な問題 | UIの表示崩れ |

### レポート形式

```markdown
# [BUG] [タイトル]

| 項目 | 内容 |
|------|------|
| 報告日 | YYYY-MM-DD |
| 深刻度 | Critical / High / Medium / Low |
| ステータス | Open / In Progress / Resolved |
| 担当者 | |

## 再現手順

### 前提条件
-

### 手順
1.
2.
3.

### 期待される動作
-

### 実際の動作
-

## 環境情報

- OS:
- ブラウザ:
- Node.js:
- npm:

## 関連ログ・スタックトレース

```
[ログ/エラーメッセージ]
```

## 原因の推定（わかる場合）

-

## スクリーンショット

<!-- スクリーンショットがあれば添付する -->

## 関連ファイル

-

## 備考

-
```

## タスク管理ツールへの登録

バグレポート作成後、ユーザーに登録先を確認すること:

- **Notion**: `/sync-notion` スキルを使用してNotionのバグトラッカーデータベースに登録する
- **GitHub Issues**: `gh issue create` コマンドで Issue として作成する
