#!/usr/bin/env zsh
# dev-runner.sh — 야간 자율 실행 스크립트
# cron: 0 22 * * * /Users/ecleya/Projects/dotfiles/scripts/dev-runner.sh >> ~/.claude/dev-runner.log 2>&1

REGISTRY="$HOME/.claude/dev-registry"
LOG_PREFIX="[$(date '+%Y-%m-%d %H:%M:%S')]"

echo "$LOG_PREFIX dev-runner 시작"

# 레지스트리 없으면 종료
if [[ ! -f "$REGISTRY" ]]; then
  echo "$LOG_PREFIX 레지스트리 없음. 종료."
  exit 0
fi

# 각 프로젝트 순회
while IFS= read -r project_path; do
  [[ -z "$project_path" ]] && continue
  [[ ! -d "$project_path" ]] && continue

  echo "$LOG_PREFIX 프로젝트 확인: $project_path"

  # tasks/ 디렉토리 스캔
  tasks_dir="$project_path/.claude/tasks"
  [[ ! -d "$tasks_dir" ]] && continue

  for status_file in "$tasks_dir"/*/status.md; do
    [[ ! -f "$status_file" ]] && continue

    task_dir=$(dirname "$status_file")
    task_id=$(basename "$task_dir")

    # 현재 단계 파악
    prd_status=$(grep "^prd_status:" "$status_file" | awk '{print $2}')
    design_status=$(grep "^design_status:" "$status_file" | awk '{print $2}')
    implement_status=$(grep "^implement_status:" "$status_file" | awk '{print $2}')
    review_status=$(grep "^review_status:" "$status_file" | awk '{print $2}')

    echo "$LOG_PREFIX 태스크: $task_id | prd=$prd_status design=$design_status impl=$implement_status review=$review_status"

    # 다음 실행할 단계 결정
    next_agent=""

    if [[ "$prd_status" == "completed" && "$design_status" == "pending" ]]; then
      next_agent="designer"
    elif [[ "$design_status" == "completed" && "$implement_status" == "pending" ]]; then
      next_agent="engineer"
    elif [[ "$implement_status" == "reported" && "$review_status" == "pending" ]]; then
      next_agent="reviewer"
    fi

    [[ -z "$next_agent" ]] && continue

    echo "$LOG_PREFIX $task_id → $next_agent 에이전트 실행"

    # in_progress 마킹
    sed -i '' "s/${next_agent}_status: pending/${next_agent}_status: in_progress/" "$status_file" 2>/dev/null || \
    sed -i "s/${next_agent}_status: pending/${next_agent}_status: in_progress/" "$status_file"

    # 에이전트 프롬프트 로드 및 플레이스홀더 치환
    agent_file="$HOME/.claude/skills/dev/agents/${next_agent}.md"
    if [[ ! -f "$agent_file" ]]; then
      echo "$LOG_PREFIX 에러: 에이전트 파일 없음 $agent_file"
      continue
    fi

    task_name=$(grep "^task_name:" "$status_file" | sed 's/task_name: //')
    prompt=$(cat "$agent_file" \
      | sed "s|{TASK_DIR}|$task_dir|g" \
      | sed "s|{PROJECT_PATH}|$project_path|g" \
      | sed "s|{TASK_ID}|$task_id|g" \
      | sed "s|{TASK_NAME}|$task_name|g")

    # Claude 실행
    cd "$project_path" && \
      claude --print "$prompt" -y >> "$task_dir/runner.log" 2>&1

    exit_code=$?
    if [[ $exit_code -eq 0 ]]; then
      echo "$LOG_PREFIX $task_id → $next_agent 완료"
    else
      echo "$LOG_PREFIX $task_id → $next_agent 실패 (exit: $exit_code)"
      # in_progress → pending 복구
      sed -i '' "s/${next_agent}_status: in_progress/${next_agent}_status: pending/" "$status_file" 2>/dev/null || \
      sed -i "s/${next_agent}_status: in_progress/${next_agent}_status: pending/" "$status_file"
    fi

  done
done < "$REGISTRY"

echo "$LOG_PREFIX dev-runner 완료"
