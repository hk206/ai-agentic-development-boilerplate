---
name: sync-notion
description: ドキュメントをNotionワークスペースに同期する。PRD、ユーザーストーリー、タスクをNotionに送信したいときに使用する。
argument-hint: "[ドキュメントファイルパスまたはドキュメント種別]"
disable-model-invocation: true
allowed-tools: Read, Glob, Bash
---

# Notion同期

`$ARGUMENTS` で指定されたドキュメントをNotionに同期する。

## 前提条件

- Notion MCPサーバーが `.mcp.json` で設定されていること（リモートHTTP: `https://mcp.notion.com/mcp`）
- OAuth認証が完了していること（初回は `/mcp` コマンドで認証フローを実行）
- Notion側に対象のページ/データベースが作成済みであること

## 同期手順

1. 対象ドキュメントを読み込む
2. Notion MCPサーバーのツールを使用してページを作成/更新する
3. 同期結果を報告する

## 同期マッピング（カスタマイズ推奨）

ドキュメント種別とNotionの保存先の対応を設定する:

- PRD（`docs/prd/`）→ Notionの「要件定義」ページ配下
- ユーザーストーリー（`docs/user-stories/`）→ Notionの「バックログ」データベース
- タスク（`docs/tasks/`）→ Notionの「スプリント」データベース
- バグレポート（`docs/bugs/`）→ Notionの「バグトラッカー」データベース

## 注意事項

- 既存ページがある場合は更新する（重複作成しない）
- 同期結果をユーザーに報告する
- Notion MCPが未設定の場合はセットアップ手順を案内する:
  1. `.mcp.json` に Notion MCPサーバーが設定されていることを確認する
  2. Claude Codeで `/mcp` コマンドを実行し、Notion MCPの認証フロー（OAuth）を完了する
  3. 認証完了後、Notion MCPのツールが使用可能になる

## トラブルシューティング

- 認証エラー: `/mcp` コマンドでOAuth認証を再実行する
- ページが見つからない: OAuth認証時にアクセスを許可したページか確認する
- ツールが表示されない: Claude Codeを再起動してMCPサーバーを再読み込みする
