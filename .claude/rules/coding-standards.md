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
- ドメイン層ではカスタムエラークラスを定義し、インフラ層で適切なHTTPレスポンスに変換する

## 命名規則

- 変数・関数: camelCase
- 型・インターフェース: PascalCase
- 定数: UPPER_SNAKE_CASE
- ファイル: kebab-case（コンポーネント以外）
- ディレクトリ: kebab-case

## アーキテクチャ: ドメイン駆動設計（DDD）

バックエンドのコードはドメイン駆動設計に基づいて構成する。

### レイヤー構成と依存ルール

```
Presentation → Application → Domain ← Infrastructure
```

- **Domain（ドメイン層）**: ビジネスロジックの中核。外部に一切依存しない
- **Application（アプリケーション層）**: ユースケースの実行。ドメイン層のみに依存する
- **Infrastructure（インフラ層）**: DBアクセス、外部API連携。ドメイン層のインターフェースを実装する
- **Presentation（プレゼンテーション層）**: Next.js の API Routes / Server Actions。アプリケーション層を呼び出す

内側のレイヤーは外側のレイヤーに依存してはならない（依存性逆転の原則）。

### ドメイン層のパターン

#### エンティティ（Entity）

- 一意の識別子（ID）を持つ
- ビジネスルールをメソッドとして持つ
- 不変条件をコンストラクタまたはファクトリメソッドで保証する

```typescript
class User {
  private constructor(
    readonly id: UserId,
    private _name: UserName,
    private _email: Email,
  ) {}

  static create(params: { name: string; email: string }): User {
    return new User(
      UserId.generate(),
      UserName.create(params.name),
      Email.create(params.email),
    )
  }

  changeName(name: string): void {
    this._name = UserName.create(name)
  }
}
```

#### 値オブジェクト（Value Object）

- 等価性は値で判定する（参照ではない）
- イミュータブル
- バリデーションロジックをファクトリメソッドに含める

```typescript
class Email {
  private constructor(readonly value: string) {}

  static create(value: string): Email {
    if (!value.includes('@')) {
      throw new InvalidEmailError(value)
    }
    return new Email(value)
  }

  equals(other: Email): boolean {
    return this.value === other.value
  }
}
```

#### リポジトリインターフェース（Repository）

- ドメイン層にインターフェースを定義し、インフラ層で実装する
- コレクションのように振る舞う

```typescript
// domain/repositories/user-repository.ts
type UserRepository = {
  findById(id: UserId): Promise<User | null>
  save(user: User): Promise<void>
  delete(id: UserId): Promise<void>
}
```

#### ドメインサービス（Domain Service）

- 単一のエンティティに属さないビジネスロジック
- 複数のエンティティにまたがる操作に使用する

### アプリケーション層のパターン

#### ユースケース（Use Case）

- 1ユースケース = 1クラス/1関数
- ドメインオブジェクトの操作をオーケストレーションする
- トランザクション境界を管理する

```typescript
// application/use-cases/create-user.ts
class CreateUserUseCase {
  constructor(
    private readonly userRepository: UserRepository,
  ) {}

  async execute(input: CreateUserInput): Promise<CreateUserOutput> {
    const user = User.create({ name: input.name, email: input.email })
    await this.userRepository.save(user)
    return { id: user.id.value }
  }
}
```

### 守るべき原則

- ドメインオブジェクトはプリミティブ型をそのまま公開しない（値オブジェクトで包む）
- ドメイン層に ORM のエンティティや DB スキーマを持ち込まない
- ユースケースはドメインロジックを持たない（ドメインオブジェクトに委譲する）
- インフラ層の実装の詳細はドメイン層から見えてはならない
