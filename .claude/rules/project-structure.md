# ディレクトリ構成ルール

## 全体構成

```
src/
├── app/                        # Presentation層: Next.js App Router
│   ├── layout.tsx
│   ├── page.tsx
│   ├── globals.css
│   ├── (auth)/                 # ルートグループ
│   │   ├── login/
│   │   └── register/
│   └── api/                    # API Routes
│       └── [resource]/
│           └── route.ts
├── components/                 # Presentation層: UIコンポーネント
│   ├── ui/                     # 基本UIコンポーネント（Button, Input等）
│   └── features/               # 機能別コンポーネント
├── hooks/                      # Presentation層: カスタムフック
├── domain/                     # Domain層: ビジネスロジックの中核
│   ├── models/                 # エンティティ・値オブジェクト
│   │   └── user/
│   │       ├── user.ts         # エンティティ
│   │       ├── user-id.ts      # 値オブジェクト
│   │       └── email.ts        # 値オブジェクト
│   ├── repositories/           # リポジトリインターフェース
│   │   └── user-repository.ts
│   ├── services/               # ドメインサービス
│   └── errors/                 # ドメイン固有のエラー
├── application/                # Application層: ユースケース
│   └── use-cases/
│       └── user/
│           ├── create-user.ts
│           └── update-user.ts
├── infrastructure/             # Infrastructure層: 外部実装
│   ├── repositories/           # リポジトリの実装
│   │   └── user-repository-impl.ts
│   ├── database/               # DB接続・マイグレーション
│   └── external/               # 外部API連携
├── lib/                        # 共通ユーティリティ（レイヤー非依存）
│   ├── utils.ts
│   └── constants.ts
└── types/                      # 共有型定義
```

## レイヤー別の配置ルール

### Presentation層（`app/`, `components/`, `hooks/`）

- Next.js の App Router ルーティングは `src/app/` に配置する
- 共有UIコンポーネントは `src/components/` に配置する
- ページ固有のコンポーネントは `src/app/[page]/_components/` に配置する
- API Routes でユースケースを呼び出す。ビジネスロジックは書かない

### Domain層（`domain/`）

- エンティティ・値オブジェクトは `src/domain/models/[集約名]/` に配置する
- リポジトリインターフェースは `src/domain/repositories/` に配置する
- ドメインサービスは `src/domain/services/` に配置する
- ドメインエラーは `src/domain/errors/` に配置する
- **このディレクトリは外部ライブラリ（ORM等）に依存してはならない**

### Application層（`application/`）

- ユースケースは `src/application/use-cases/[機能名]/` に配置する
- 1ファイル = 1ユースケース
- ドメイン層のみをインポートする

### Infrastructure層（`infrastructure/`）

- リポジトリ実装は `src/infrastructure/repositories/` に配置する
- DB接続設定は `src/infrastructure/database/` に配置する
- 外部API連携は `src/infrastructure/external/` に配置する
- ドメイン層のインターフェースを実装する

## テストファイル配置

- ユニットテスト: 対象ファイルと同階層に `*.test.ts(x)` として配置
- 統合テスト: `src/__tests__/integration/` に配置
- E2Eテスト: プロジェクトルートの `e2e/` に配置
- **ドメイン層のテストは外部依存なしで実行できること**

## ドキュメント配置

- プロダクト企画: `docs/product/`
- PRD: `docs/prd/`
- ユーザーストーリー: `docs/user-stories/`
- タスク: `docs/tasks/`
- コンポーネント仕様: `docs/components/`
- アーキテクチャ設計: `docs/architecture/`
- バグレポート: `docs/bugs/`
