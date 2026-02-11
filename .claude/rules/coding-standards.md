# コーディング規約

## TypeScript

- `strict: true` を必須とする
- `any` 型の使用は禁止。`unknown` を使い、型ガードで絞り込む
- 明示的な戻り値の型定義を推奨
- `interface` よりも `type` を優先（union/intersection が必要な場合）
- Enum は使用禁止。`as const` オブジェクトまたはunion型を使用する

## React

- 関数コンポーネント + React Hooks のみ使用
- `React.FC` は使用しない。Props型を引数に直接指定する
- カスタムフックは `use` プレフィックスを付ける
- `useEffect` の依存配列は省略しない
- コンポーネントファイルは PascalCase（例: `UserProfile.tsx`）

## インポート順序

1. React / Next.js
2. 外部ライブラリ
3. 内部モジュール（`@/` エイリアス）
4. 型インポート（`type` キーワード付き）
5. スタイル

## スタイリング

- Tailwind CSS を使用する
- インラインスタイルは使用しない
- 複雑なスタイルは `cn()` ユーティリティ（clsx + tailwind-merge）で結合する

## エラーハンドリング

- try-catch は最小スコープで使用する
- API境界では必ずエラーハンドリングを行う
- ユーザー向けエラーメッセージは日本語で定義する

## 命名規則

- 変数・関数: camelCase
- 型・インターフェース: PascalCase
- 定数: UPPER_SNAKE_CASE
- ファイル: kebab-case（コンポーネント以外）
- ディレクトリ: kebab-case
