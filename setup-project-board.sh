#!/bin/bash
set -e  # Exit on error

# GitHub Project Board Setup Script
# This script creates a GitHub Project and adds issues to it

OWNER="choigawoon"
REPO="boilerplate"
PROJECT_TITLE="NPM Package Boilerplate Development"

echo "=================================================="
echo "GitHub Project Board Setup"
echo "=================================================="
echo ""

# Step 1: Create GitHub Project
echo "[1/3] Creating GitHub Project: $PROJECT_TITLE"
PROJECT_JSON=$(gh project create \
  --owner "$OWNER" \
  --title "$PROJECT_TITLE" \
  --format json)

PROJECT_URL=$(echo "$PROJECT_JSON" | jq -r '.url')
PROJECT_NUMBER=$(echo "$PROJECT_JSON" | jq -r '.number')

echo "✓ Project created successfully"
echo "  URL: $PROJECT_URL"
echo "  Number: $PROJECT_NUMBER"
echo ""

# Step 2: Create issues with labels
echo "[2/3] Creating issues..."
echo ""

# Issue 1: NPM Publishing
echo "Creating issue 1/6: NPM 퍼블리시 설정 및 테스트"
ISSUE_1=$(gh issue create \
  --repo "$OWNER/$REPO" \
  --title "NPM 퍼블리시 설정 및 테스트" \
  --body "## 목표
NPM 레지스트리에 패키지를 자동으로 퍼블리시하는 워크플로우를 설정하고 테스트합니다.

## 작업 내용
- [ ] NPM_TOKEN secrets 설정 가이드 작성
- [ ] .github/workflows/publish.yml 워크플로우 검증
- [ ] 테스트 퍼블리시 실행
- [ ] 버전 태그 자동화 확인

## 참고사항
- NPM 계정 및 organization 권한 필요
- package.json의 name, version 필드 확인
- 퍼블리시 전 빌드 과정 검증" \
  --label "enhancement,ci/cd" \
  --format json)

ISSUE_1_NUMBER=$(echo "$ISSUE_1" | jq -r '.number')
ISSUE_1_ID=$(echo "$ISSUE_1" | jq -r '.id')
echo "  ✓ Issue #$ISSUE_1_NUMBER created"

# Issue 2: CI/CD Testing
echo "Creating issue 2/6: CI/CD 워크플로우 테스트"
ISSUE_2=$(gh issue create \
  --repo "$OWNER/$REPO" \
  --title "CI/CD 워크플로우 테스트" \
  --body "## 목표
GitHub Actions 워크플로우가 모든 시나리오에서 정상 동작하는지 테스트합니다.

## 작업 내용
- [ ] PR 생성 시 빌드 및 린트 테스트
- [ ] PR 머지 시 자동 배포 테스트
- [ ] 실패 케이스 핸들링 확인
- [ ] 워크플로우 실행 시간 최적화

## 테스트 시나리오
1. 새 브랜치에서 PR 생성
2. 코드 리뷰 및 수정
3. main 브랜치로 머지
4. 자동 배포 확인" \
  --label "testing,ci/cd" \
  --format json)

ISSUE_2_NUMBER=$(echo "$ISSUE_2" | jq -r '.number')
ISSUE_2_ID=$(echo "$ISSUE_2" | jq -r '.id')
echo "  ✓ Issue #$ISSUE_2_NUMBER created"

# Issue 3: Version Management
echo "Creating issue 3/6: 패키지 버전 관리 자동화"
ISSUE_3=$(gh issue create \
  --repo "$OWNER/$REPO" \
  --title "패키지 버전 관리 자동화" \
  --body "## 목표
Semantic versioning과 changelog 자동 생성을 통해 버전 관리를 자동화합니다.

## 작업 내용
- [ ] semantic-release 또는 changesets 도입 검토
- [ ] 커밋 메시지 컨벤션 정의 (conventional commits)
- [ ] CHANGELOG.md 자동 생성 설정
- [ ] Git 태그 자동 생성 워크플로우
- [ ] 버전 범프 자동화 (patch/minor/major)

## 고려사항
- Breaking changes 감지 및 major 버전 업데이트
- Release notes 자동 생성
- NPM 퍼블리시 연동" \
  --label "enhancement,automation" \
  --format json)

ISSUE_3_NUMBER=$(echo "$ISSUE_3" | jq -r '.number')
ISSUE_3_ID=$(echo "$ISSUE_3" | jq -r '.id')
echo "  ✓ Issue #$ISSUE_3_NUMBER created"

# Issue 4: Example Project
echo "Creating issue 4/6: 예제 프로젝트 추가"
ISSUE_4=$(gh issue create \
  --repo "$OWNER/$REPO" \
  --title "예제 프로젝트 추가" \
  --body "## 목표
이 boilerplate를 사용하는 방법을 보여주는 예제 프로젝트를 추가합니다.

## 작업 내용
- [ ] examples/ 디렉토리 생성
- [ ] 기본 사용법 예제 작성
- [ ] TypeScript 설정 예제
- [ ] 빌드 및 퍼블리시 예제
- [ ] README.md에 예제 링크 추가

## 예제 시나리오
1. 새 NPM 패키지 시작하기
2. 기존 프로젝트를 boilerplate로 마이그레이션
3. CI/CD 워크플로우 커스터마이징" \
  --label "documentation,enhancement" \
  --format json)

ISSUE_4_NUMBER=$(echo "$ISSUE_4" | jq -r '.number')
ISSUE_4_ID=$(echo "$ISSUE_4" | jq -r '.id')
echo "  ✓ Issue #$ISSUE_4_NUMBER created"

# Issue 5: Unit Tests
echo "Creating issue 5/6: 단위 테스트 추가"
ISSUE_5=$(gh issue create \
  --repo "$OWNER/$REPO" \
  --title "단위 테스트 추가" \
  --body "## 목표
Jest 또는 Vitest를 사용하여 단위 테스트 환경을 구축합니다.

## 작업 내용
- [ ] 테스트 프레임워크 선택 (Jest vs Vitest)
- [ ] 테스트 환경 설정
- [ ] 샘플 테스트 작성
- [ ] CI/CD에 테스트 단계 추가
- [ ] 코드 커버리지 리포팅 설정

## 테스트 범위
- 빌드 스크립트 테스트
- 설정 파일 검증 테스트
- 유틸리티 함수 테스트 (있는 경우)

## 성공 기준
- 모든 PR에서 테스트 자동 실행
- 테스트 커버리지 80% 이상" \
  --label "testing,enhancement" \
  --format json)

ISSUE_5_NUMBER=$(echo "$ISSUE_5" | jq -r '.number')
ISSUE_5_ID=$(echo "$ISSUE_5" | jq -r '.id')
echo "  ✓ Issue #$ISSUE_5_NUMBER created"

# Issue 6: AI Agent PR Guide
echo "Creating issue 6/6: AI Agent PR 자동화 가이드 작성"
ISSUE_6=$(gh issue create \
  --repo "$OWNER/$REPO" \
  --title "AI Agent PR 자동화 가이드 작성" \
  --body "## 목표
AI Agent가 자동으로 PR을 생성하고 관리하는 방법을 문서화합니다.

## 작업 내용
- [ ] AI Agent PR 생성 워크플로우 문서화
- [ ] GitHub CLI 사용법 가이드
- [ ] 자동 커밋 메시지 컨벤션 정의
- [ ] PR 템플릿 최적화 (AI 친화적)
- [ ] 자동 리뷰 및 머지 가이드라인

## 포함할 내용
1. Claude Code를 사용한 PR 생성
2. gh CLI를 사용한 자동화 스크립트
3. GitHub Actions를 통한 AI 트리거 워크플로우
4. 베스트 프랙티스 및 주의사항

## 참고 자료
- GitHub CLI documentation
- Claude Code best practices
- Conventional commits specification" \
  --label "documentation,automation" \
  --format json)

ISSUE_6_NUMBER=$(echo "$ISSUE_6" | jq -r '.number')
ISSUE_6_ID=$(echo "$ISSUE_6" | jq -r '.id')
echo "  ✓ Issue #$ISSUE_6_NUMBER created"
echo ""

# Step 3: Add issues to project board
echo "[3/3] Adding issues to project board..."
echo ""

# Get project ID and field IDs
PROJECT_ID=$(gh project view "$PROJECT_NUMBER" --owner "$OWNER" --format json | jq -r '.id')
echo "Project ID: $PROJECT_ID"

# Add each issue to the project
echo "Adding issue #$ISSUE_1_NUMBER to project..."
gh project item-add "$PROJECT_NUMBER" --owner "$OWNER" --url "https://github.com/$OWNER/$REPO/issues/$ISSUE_1_NUMBER"

echo "Adding issue #$ISSUE_2_NUMBER to project..."
gh project item-add "$PROJECT_NUMBER" --owner "$OWNER" --url "https://github.com/$OWNER/$REPO/issues/$ISSUE_2_NUMBER"

echo "Adding issue #$ISSUE_3_NUMBER to project..."
gh project item-add "$PROJECT_NUMBER" --owner "$OWNER" --url "https://github.com/$OWNER/$REPO/issues/$ISSUE_3_NUMBER"

echo "Adding issue #$ISSUE_4_NUMBER to project..."
gh project item-add "$PROJECT_NUMBER" --owner "$OWNER" --url "https://github.com/$OWNER/$REPO/issues/$ISSUE_4_NUMBER"

echo "Adding issue #$ISSUE_5_NUMBER to project..."
gh project item-add "$PROJECT_NUMBER" --owner "$OWNER" --url "https://github.com/$OWNER/$REPO/issues/$ISSUE_5_NUMBER"

echo "Adding issue #$ISSUE_6_NUMBER to project..."
gh project item-add "$PROJECT_NUMBER" --owner "$OWNER" --url "https://github.com/$OWNER/$REPO/issues/$ISSUE_6_NUMBER"

echo ""
echo "=================================================="
echo "Setup Complete!"
echo "=================================================="
echo ""
echo "Project URL: $PROJECT_URL"
echo ""
echo "Created Issues:"
echo "  #$ISSUE_1_NUMBER - NPM 퍼블리시 설정 및 테스트"
echo "  #$ISSUE_2_NUMBER - CI/CD 워크플로우 테스트"
echo "  #$ISSUE_3_NUMBER - 패키지 버전 관리 자동화"
echo "  #$ISSUE_4_NUMBER - 예제 프로젝트 추가"
echo "  #$ISSUE_5_NUMBER - 단위 테스트 추가"
echo "  #$ISSUE_6_NUMBER - AI Agent PR 자동화 가이드 작성"
echo ""
echo "All issues have been added to the 'Todo' status on the project board."
echo "Visit $PROJECT_URL to view your kanban board!"
echo ""
