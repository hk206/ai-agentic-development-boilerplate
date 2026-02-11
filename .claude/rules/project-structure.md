# ディレクトリ構成ルール

## Next.js App Router 構成

```
src/
├── app/                    # ページ・ルーティング（App Router）
│   ├── layout.tsx          # ルートレイアウト
│   ├── page.tsx            # トップページ
│   ├── globals.css         # グローバルスタイル
│   ├── (auth)/             # 認証関連ルートグループ
│   │   ├── login/
│   │   └── register/
│   └── api/                # APIルート
│       └── [resource]/
│           └── route.ts
├── components/             # UIコンポーネント
│   ├── ui/                 # 基本UIコンポーネント（Button, Input等）
│   └── features/           # 機能別コンポーネント
├── lib/                    # ユーティリティ・ヘルパー
│   ├── utils.ts            # 汎用ユーティリティ
│   └── constants.ts        # 定数定義
├── hooks/                  # カスタムフック
├── types/                  # 型定義
├── services/               # 外部API連携・データアクセス
└── __tests__/              # テストファイル（ミラー構成）
```

## ファイル配置ルール

- コンポーネントは `src/components/` に配置する
- ページ固有のコンポーネントは `src/app/[page]/_components/` に配置する
- 共通フックは `src/hooks/` に配置する
- 型定義は `src/types/` に集約する
- API連携ロジックは `src/services/` に配置する

## テストファイル配置

- ユニットテスト: 対象ファイルと同階層に `*.test.ts(x)` として配置
- 統合テスト: `src/__tests__/integration/` に配置
- E2Eテスト: プロジェクトルートの `e2e/` に配置

## ドキュメント配置

- プロダクト企画: `docs/product/`
- PRD: `docs/prd/`
- ユーザーストーリー: `docs/user-stories/`
- タスク: `docs/tasks/`
- コンポーネント仕様: `docs/components/`
- アーキテクチャ設計: `docs/architecture/`
- バグレポート: `docs/bugs/`
