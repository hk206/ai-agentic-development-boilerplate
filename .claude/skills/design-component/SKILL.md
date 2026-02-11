---
name: design-component
description: UIコンポーネントの設計仕様書を作成する。新しいコンポーネントの設計やProps API定義が必要なときに使用する。
argument-hint: "[コンポーネント名]"
allowed-tools: Read, Write, Edit, Glob, Grep
---

# コンポーネント設計

`$ARGUMENTS` のUIコンポーネント設計仕様書を作成する。

## 手順

1. 既存のコンポーネント構成を調査する（`src/components/` を確認）
2. デザイントークンを参照する
3. コンポーネント仕様書を作成する
4. `docs/components/[component-name].md` に保存する

## デザイントークン参照

プロジェクトのデザイントークンは [references/design-tokens.md](references/design-tokens.md) を参照。

## 仕様書の構成

### 1. コンポーネント概要

- **名前**: PascalCase（例: `UserProfile`）
- **説明**: コンポーネントの目的と使用場面
- **分類**: atom / molecule / organism

### 2. Props API

```typescript
type ComponentProps = {
  /** Propの説明 */
  propName: PropType
}
```

- 各Propに JSDoc コメントで説明を付ける
- オプショナルなPropsにはデフォルト値を定義する
- コールバックPropsは `on` プレフィックスを付ける（例: `onClick`）

### 3. バリアント

- `variant`: 視覚的なバリエーション（例: `primary`, `secondary`, `ghost`）
- `size`: サイズオプション（例: `sm`, `md`, `lg`）

### 4. 状態管理

- 内部状態の定義
- Controlled / Uncontrolled パターンの選択
- ローディング状態・エラー状態・空状態の定義

### 5. アクセシビリティ

- 適切なHTML要素の選択
- ARIA属性の定義
- キーボード操作の定義
- フォーカス管理

### 6. 使用例

```tsx
// 基本
<Component prop="value" />

// バリアント
<Component variant="secondary" size="lg" />

// 制御
<Component value={value} onChange={setValue} />
```

## 注意事項

- 既存のコンポーネントとの一貫性を保つ
- Tailwind CSSでのスタイリングを前提とする
- レスポンシブ対応を考慮する
