#!/bin/bash
# PostToolUse (Write|Edit) フック: TypeScript/JavaScriptファイル編集後の自動リント
#
# stdin からツール入力をJSONとして受け取る。
# 終了コード:
#   0 = 問題なし（続行）
#   2 = ブロック（stderrのメッセージをClaudeにフィードバック）

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

# ファイルパスが取得できない場合はスキップ
if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# TypeScript/JavaScript ファイルのみ対象
case "$FILE_PATH" in
  *.ts|*.tsx|*.js|*.jsx) ;;
  *) exit 0 ;;
esac

# ファイルが存在しない場合はスキップ
if [ ! -f "$FILE_PATH" ]; then
  exit 0
fi

# npx が利用可能か確認
if ! command -v npx &> /dev/null; then
  exit 0
fi

# ESLint設定が存在するか確認（なければスキップ）
PROJECT_DIR=$(dirname "$FILE_PATH")
while [ "$PROJECT_DIR" != "/" ]; do
  if [ -f "$PROJECT_DIR/.eslintrc.json" ] || \
     [ -f "$PROJECT_DIR/.eslintrc.js" ] || \
     [ -f "$PROJECT_DIR/.eslintrc.cjs" ] || \
     [ -f "$PROJECT_DIR/eslint.config.js" ] || \
     [ -f "$PROJECT_DIR/eslint.config.mjs" ]; then
    break
  fi
  PROJECT_DIR=$(dirname "$PROJECT_DIR")
done

if [ "$PROJECT_DIR" = "/" ]; then
  exit 0
fi

# リント実行
RESULT=$(cd "$PROJECT_DIR" && npx eslint "$FILE_PATH" 2>&1)
EXIT_CODE=$?

if [ $EXIT_CODE -ne 0 ]; then
  echo "リントエラーが検出されました:" >&2
  echo "$RESULT" >&2
  exit 2
fi

exit 0
