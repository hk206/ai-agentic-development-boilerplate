---
name: write-tests
description: 指定されたコードに対してテストを作成する。ユニットテスト、統合テスト、E2Eテストの作成が必要なときに使用する。
argument-hint: "[対象ファイルパス] [テスト種別(任意): unit|integration|e2e]"
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
---

# テスト作成

`$ARGUMENTS` に対してテストを作成する。

## テスト種別の自動判定

引数にテスト種別が指定されていない場合、対象ファイルから自動判定する:

- `src/components/` → ユニットテスト（コンポーネントテスト）
- `src/app/api/` → 統合テスト（APIテスト）
- `src/lib/`, `src/hooks/`, `src/services/` → ユニットテスト
- `src/app/**/page.tsx` → E2Eテスト

## ユニットテスト（Vitest）

```typescript
import { describe, it, expect, vi } from 'vitest'

describe('[テスト対象]', () => {
  // 正常系
  it('should [期待する動作]', () => {
    // Arrange
    // Act
    // Assert
  })

  // 異常系
  it('should throw when [異常条件]', () => {
    expect(() => fn(invalidInput)).toThrow()
  })

  // エッジケース
  it('should handle [エッジケース]', () => {
    // 空配列、null、境界値など
  })
})
```

### コンポーネントテスト

```typescript
import { render, screen } from '@testing-library/react'
import userEvent from '@testing-library/user-event'

describe('[コンポーネント名]', () => {
  it('should render correctly', () => {
    render(<Component />)
    expect(screen.getByRole('...')).toBeInTheDocument()
  })

  it('should handle user interaction', async () => {
    const user = userEvent.setup()
    render(<Component onClick={mockFn} />)
    await user.click(screen.getByRole('button'))
    expect(mockFn).toHaveBeenCalledOnce()
  })
})
```

## 統合テスト

```typescript
describe('[APIエンドポイント]', () => {
  it('should return 200 with valid request', async () => {
    const response = await fetch('/api/resource', {
      method: 'POST',
      body: JSON.stringify(validData),
    })
    expect(response.status).toBe(200)
  })

  it('should return 400 with invalid request', async () => {
    const response = await fetch('/api/resource', {
      method: 'POST',
      body: JSON.stringify(invalidData),
    })
    expect(response.status).toBe(400)
  })
})
```

## E2Eテスト（Playwright）

```typescript
import { test, expect } from '@playwright/test'

test.describe('[テスト対象フロー]', () => {
  test('should [フロー全体の期待動作]', async ({ page }) => {
    await page.goto('/')
    await page.getByRole('button', { name: '...' }).click()
    await expect(page.getByText('...')).toBeVisible()
  })
})
```

## テスト作成後の確認

1. テストを実行して通ることを確認: `npm run test`
2. カバレッジ確認: `npm run test -- --coverage`
3. カバレッジ不足箇所があれば追加テストを提案する

## ファイル配置

- ユニット/統合テスト: 対象ファイルと同階層に `[filename].test.ts(x)`
- E2Eテスト: `e2e/` ディレクトリに配置
