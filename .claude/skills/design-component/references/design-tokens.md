# デザイントークン

プロジェクト共通のデザイントークン定義。コンポーネント設計時に参照する。

> このファイルはプロジェクトに合わせてカスタマイズすること。

## カラーパレット

### ブランドカラー

| トークン | Tailwind | 用途 |
|----------|----------|------|
| `primary` | `blue-600` | メインアクション、リンク |
| `primary-hover` | `blue-700` | ホバー状態 |
| `secondary` | `gray-600` | サブアクション |
| `accent` | `violet-600` | 強調・アクセント |

### セマンティックカラー

| トークン | Tailwind | 用途 |
|----------|----------|------|
| `success` | `green-600` | 成功状態 |
| `warning` | `yellow-500` | 警告状態 |
| `error` | `red-600` | エラー状態 |
| `info` | `blue-500` | 情報表示 |

### ニュートラル

| トークン | Tailwind | 用途 |
|----------|----------|------|
| `text-primary` | `gray-900` | メインテキスト |
| `text-secondary` | `gray-600` | サブテキスト |
| `text-muted` | `gray-400` | 補助テキスト |
| `bg-primary` | `white` | メイン背景 |
| `bg-secondary` | `gray-50` | サブ背景 |
| `border` | `gray-200` | ボーダー |

## タイポグラフィ

| トークン | サイズ | 行間 | 用途 |
|----------|--------|------|------|
| `heading-1` | `text-3xl` (30px) | `leading-tight` | ページタイトル |
| `heading-2` | `text-2xl` (24px) | `leading-tight` | セクションタイトル |
| `heading-3` | `text-xl` (20px) | `leading-snug` | サブセクション |
| `body` | `text-base` (16px) | `leading-normal` | 本文 |
| `body-sm` | `text-sm` (14px) | `leading-normal` | 補助テキスト |
| `caption` | `text-xs` (12px) | `leading-normal` | キャプション |

## スペーシング

| トークン | 値 | 用途 |
|----------|----|------|
| `space-xs` | `1` (4px) | 最小間隔 |
| `space-sm` | `2` (8px) | 小間隔 |
| `space-md` | `4` (16px) | 標準間隔 |
| `space-lg` | `6` (24px) | 大間隔 |
| `space-xl` | `8` (32px) | セクション間 |
| `space-2xl` | `12` (48px) | ページセクション間 |

## ボーダー

| トークン | 値 | 用途 |
|----------|----|------|
| `radius-sm` | `rounded` (4px) | 小要素 |
| `radius-md` | `rounded-md` (6px) | ボタン、入力 |
| `radius-lg` | `rounded-lg` (8px) | カード |
| `radius-full` | `rounded-full` | アバター、バッジ |

## ブレークポイント

| トークン | 値 | 用途 |
|----------|----|------|
| `sm` | 640px | モバイル（横向き） |
| `md` | 768px | タブレット |
| `lg` | 1024px | デスクトップ |
| `xl` | 1280px | 大画面 |

## シャドウ

| トークン | Tailwind | 用途 |
|----------|----------|------|
| `shadow-sm` | `shadow-sm` | ボタン、入力 |
| `shadow-md` | `shadow-md` | カード |
| `shadow-lg` | `shadow-lg` | モーダル、ドロップダウン |
