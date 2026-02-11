# AI Agentic Development Boilerplate

AI支援によるプロダクト開発ライフサイクル全体をカバーする **Claude Code** ボイラープレート。
プロダクトマネジメント → デザイン → 開発 → QA を、エージェントとスキルで一貫して実行できる。

## 想定する技術スタック

| レイヤー | 技術 |
|---------|------|
| フロントエンド | Next.js (App Router), TypeScript, Tailwind CSS |
| バックエンド | TypeScript, ドメイン駆動設計（DDD） |
| テスト | Vitest（ユニット/統合）, Playwright（E2E） |
| 外部サービス | Notion（プロジェクト管理/ドキュメント）, GitHub（コード/PR/Issues） |

## ディレクトリ構成

```
.
├── CLAUDE.md                      # Claude Code へのプロジェクト指示書
├── .mcp.json                      # MCP サーバー設定（GitHub, Notion）
├── .gitignore
├── docs/                          # ドキュメント出力先
│   ├── prd/                       #   PRD
│   ├── product/                   #   プロダクト企画
│   ├── user-stories/              #   ユーザーストーリー
│   ├── tasks/                     #   タスク分解
│   ├── components/                #   コンポーネント仕様
│   ├── architecture/              #   アーキテクチャ設計
│   └── bugs/                      #   バグレポート
└── .claude/
    ├── settings.json              # 共有設定（permissions, hooks, env）
    ├── settings.local.json        # 個人設定（git管理外）
    ├── agents/                    # カスタムエージェント定義
    │   ├── product-manager.md
    │   ├── designer.md
    │   ├── code-reviewer.md
    │   ├── debugger.md
    │   └── qa-engineer.md
    ├── skills/                    # スラッシュコマンド（スキル）定義
    │   ├── ideate-product/
    │   ├── create-prd/
    │   ├── create-user-stories/
    │   ├── breakdown-tasks/
    │   ├── design-component/
    │   ├── plan-architecture/
    │   ├── write-tests/
    │   ├── review-pr/
    │   ├── create-bug-report/
    │   └── sync-notion/
    ├── hooks/                     # ライフサイクルフック
    │   └── post-write-lint.sh
    └── rules/                     # プロジェクトルール
        ├── coding-standards.md
        ├── git-workflow.md
        └── project-structure.md
```

## セットアップ

### 前提条件

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) がインストール済みであること
- Node.js, npm がインストール済みであること
- `gh` CLI がインストール済みであること
- Notion アカウントを持っていること

### 手順

1. リポジトリをクローンまたはテンプレートとしてコピーする

2. `settings.local.json` を作成し、GitHub トークンを設定する

```bash
cp .claude/settings.local.json.example .claude/settings.local.json
```

```jsonc
{
  "env": {
    "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_xxxxx"
  }
}
```

3. フック用スクリプトに実行権限を付与する

```bash
chmod +x .claude/hooks/*.sh
```

4. Claude Code を起動する

```bash
claude
```

5. Notion MCP の OAuth 認証を行う

```
/mcp
```

Notion MCP を選択し、ブラウザで OAuth 認証を完了する。認証時にプロジェクトで使用するページへのアクセスを許可する。

6. Notion プロジェクトページをセットアップする

Claude Code に「Notion にプロジェクトページを作成して」と伝えると、以下の構造が自動作成される:

- **要件定義** ページ（PRD 用）
- **バックログ** データベース（ユーザーストーリー用）
- **スプリント** データベース（タスク用）
- **バグトラッカー** データベース（バグレポート用）

既存の空ページを使いたい場合は、そのページの URL を Claude Code に伝える。

## エージェント

タスクの性質に応じて自動的に、または明示的に呼び出される専門エージェント。

| エージェント | 役割 | ツール権限 |
|---|---|---|
| `product-manager` | プロダクト企画・PRD作成・ユーザーストーリー・タスク分解 | 読み書き + Web検索 |
| `designer` | UIコンポーネント設計・アクセシビリティレビュー | 読み書き + Web検索 |
| `code-reviewer` | コード品質・セキュリティレビュー | **読み取り専用** |
| `debugger` | バグ調査・パフォーマンス最適化・リファクタリング | 読み書き |
| `qa-engineer` | テスト作成・バグレポート・カバレッジ分析 | 読み書き |

## スキル（スラッシュコマンド）

Claude Code 上で `/コマンド名` で実行できるスキル。

| コマンド | 説明 | 主な出力先 |
|---------|------|-----------|
| `/ideate-product` | プロダクト企画・構想（市場分析、Lean Canvas、MVP仮説） | `docs/product/` |
| `/create-prd` | PRD（プロダクト要件定義書）作成 | `docs/prd/` |
| `/create-user-stories` | ユーザーストーリー作成 | `docs/user-stories/` |
| `/breakdown-tasks` | 実装タスク分解・タスク管理ツール登録（Notion / GitHub Issues） | `docs/tasks/` |
| `/design-component` | UIコンポーネント設計仕様書作成 | `docs/components/` |
| `/plan-architecture` | アーキテクチャ設計（独立コンテキストで実行） | `docs/architecture/` |
| `/write-tests` | テスト作成（ユニット/統合/E2E を自動判定） | 対象ファイルと同階層 |
| `/review-pr` | PRレビュー（`gh` CLI経由で差分を取得） | ターミナル出力 |
| `/create-bug-report` | バグレポート作成・GitHub Issue発行 | `docs/bugs/` |
| `/sync-notion` | ドキュメントをNotionに同期 | Notion |

### 典型的なワークフロー

```
/ideate-product → /create-prd → /create-user-stories → /breakdown-tasks → 実装 → /write-tests → /review-pr
```

## フック

`.claude/settings.json` で定義されたライフサイクルフック。

| フック | トリガー | 内容 |
|-------|---------|------|
| `post-write-lint.sh` | `PostToolUse`（Write/Edit時） | 編集された `.ts/.tsx/.js/.jsx` ファイルに対してESLintを実行。エラーがあればClaude Codeにフィードバックして自動修正を促す |

## ルール

`.claude/rules/` に定義されたプロジェクトルール。Claude Code が自動的に参照する。

| ファイル | 内容 |
|---------|------|
| `coding-standards.md` | TypeScript厳格モード、`any`禁止、React規約、命名規則、Tailwind CSS、DDD設計原則（エンティティ、値オブジェクト、リポジトリ、ユースケース） |
| `git-workflow.md` | ブランチ命名（`feature/`、`fix/` 等）、Conventional Commits、PR運用 |
| `project-structure.md` | DDD レイヤー構成（Domain / Application / Infrastructure / Presentation）、ファイル配置ルール |

## 権限設定

`settings.json` で定義された権限。

**自動許可（allow）:**
- `npm run *`, `npx *`
- `git status`, `git diff`, `git log`, `git branch`
- `gh pr *`, `gh issue *`
- `Read`, `Glob`, `Grep`

**明示的に拒否（deny）:**
- `rm -rf *`
- `git push --force*`
- `git reset --hard*`

## MCP サーバー

`.mcp.json` で設定された外部サービス連携。

| サーバー | URL | 用途 |
|---------|-----|------|
| GitHub | `https://api.githubcopilot.com/mcp/` | GitHub操作（`GITHUB_PERSONAL_ACCESS_TOKEN` が必要） |
| Notion | `https://mcp.notion.com/mcp` | Notionページ操作（初回はOAuth認証が必要） |

## エージェントチーム

`CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` が有効化されており、複数のClaude Codeインスタンスが並列で協働できる。

### チームが有効なケース

- **プロダクト企画**: PM + デザイナー + 技術で多角的に検討
- **新機能の設計〜実装**: 要件整理・アーキテクチャ設計・コーディングを並列実行
- **コードレビュー**: セキュリティ・パフォーマンス・テストカバレッジなど異なる観点で同時レビュー
- **バグ調査**: 複数の仮説を並列で検証

### チーム編成の原則

- 各メンバーに明確な責務を与える
- 1メンバーあたり5〜6タスクを目安にする
- ファイル競合を避けるため担当ファイル群を分ける
- リーダーは実装せず調整に徹する（デリゲートモード推奨）

## カスタマイズ

このボイラープレートをベースに、自分のプロジェクトに合わせてカスタマイズできる。

- **エージェント追加**: `.claude/agents/` にMarkdownファイルを追加
- **スキル追加**: `.claude/skills/[skill-name]/SKILL.md` を作成
- **ルール変更**: `.claude/rules/` のファイルを編集
- **フック追加**: `.claude/hooks/` にスクリプトを追加し、`settings.json` の `hooks` に登録
- **MCP サーバー追加**: `.mcp.json` にサーバー定義を追加

## ライセンス

MIT
