# GitHub 인증 및 권한 설정 가이드

이 문서는 NPM package boilerplate 프로젝트를 설정하고 GitHub Projects 칸반 보드를 관리하기 위해 필요한 GitHub 인증 및 권한 설정 방법을 설명합니다.

## 목차

1. [GitHub CLI 설치](#1-github-cli-설치)
2. [기본 GitHub 인증](#2-기본-github-인증)
3. [GitHub Projects 권한 추가](#3-github-projects-권한-추가)
4. [NPM 배포를 위한 토큰 설정](#4-npm-배포를-위한-토큰-설정)
5. [문제 해결](#5-문제-해결)

---

## 1. GitHub CLI 설치

### macOS (Homebrew)

```bash
brew install gh
```

### Linux

```bash
# Debian/Ubuntu
sudo apt install gh

# Fedora/RHEL
sudo dnf install gh
```

### Windows

```powershell
# Chocolatey
choco install gh

# Scoop
scoop install gh
```

설치 확인:

```bash
gh --version
```

---

## 2. 기본 GitHub 인증

### 2.1 인증 시작

```bash
gh auth login
```

### 2.2 인증 옵션 선택

프롬프트에서 다음을 선택:

1. **GitHub.com** 선택
2. **HTTPS** 또는 **SSH** 프로토콜 선택 (HTTPS 권장)
3. **인증 방법 선택**:
   - **Login with a web browser** (권장) - 브라우저에서 인증
   - **Paste an authentication token** - Personal Access Token 직접 입력

### 2.3 웹 브라우저 인증 (권장)

1. 터미널에 표시되는 **one-time code** 복사
2. Enter 키를 누르면 브라우저가 자동으로 열림
3. https://github.com/login/device 에서 코드 입력
4. "Authorize GitHub CLI" 클릭

### 2.4 인증 상태 확인

```bash
gh auth status
```

출력 예시:

```
github.com
  ✓ Logged in to github.com account YOUR_USERNAME
  - Active account: true
  - Git operations protocol: https
  - Token: gho_************************************
  - Token scopes: 'gist', 'read:org', 'repo'
```

---

## 3. GitHub Projects 권한 추가

GitHub Projects 칸반 보드를 생성하고 관리하려면 추가 권한이 필요합니다.

### 3.1 권한 추가 명령어

```bash
gh auth refresh -h github.com -s project,read:project
```

### 3.2 브라우저 인증

1. 터미널에 표시되는 **one-time code** 복사:
   ```
   ! First copy your one-time code: XXXX-XXXX
   ```

2. 브라우저에서 https://github.com/login/device 열기

3. 코드 입력 및 "Authorize" 클릭

4. 인증 완료 메시지 확인:
   ```
   ✓ Authentication complete.
   ```

### 3.3 권한 확인

```bash
gh auth status
```

`Token scopes`에 `project`, `read:project`가 포함되어 있는지 확인:

```
- Token scopes: 'admin:public_key', 'gist', 'project', 'read:org', 'read:project', 'repo'
```

### 3.4 필요한 프로젝트 권한 목록

| 권한 | 용도 |
|------|------|
| `project` | GitHub Projects 생성, 수정, 삭제 |
| `read:project` | GitHub Projects 조회 |

---

## 4. NPM 배포를 위한 토큰 설정

### 4.1 NPM Access Token 생성

1. https://www.npmjs.com/ 로그인
2. 프로필 아이콘 클릭 → **Access Tokens**
3. **Generate New Token** → **Classic Token** 선택
4. 토큰 타입 선택:
   - **Automation** (CI/CD용, 권장)
   - **Publish** (수동 배포용)
5. 생성된 토큰 복사 (한 번만 표시됨!)

### 4.2 GitHub Secrets에 토큰 추가

#### 웹 인터페이스 사용

1. GitHub 저장소 페이지에서 **Settings** 탭
2. 왼쪽 메뉴에서 **Secrets and variables** → **Actions**
3. **New repository secret** 클릭
4. Secret 정보 입력:
   - **Name**: `NPM_TOKEN`
   - **Value**: NPM에서 복사한 토큰
5. **Add secret** 클릭

#### CLI 사용 (gh CLI)

```bash
gh secret set NPM_TOKEN
# 프롬프트에 토큰 붙여넣기
```

또는 한 줄로:

```bash
echo "your_npm_token_here" | gh secret set NPM_TOKEN
```

### 4.3 Secrets 확인

```bash
gh secret list
```

출력:

```
NPM_TOKEN  Updated 2025-11-29
```

---

## 5. 문제 해결

### 문제 1: "Permission denied" 오류

**증상**:
```
ERROR: Permission to username/repo.git denied
```

**해결 방법**:

1. HTTPS로 변경:
   ```bash
   git remote set-url origin https://github.com/username/repo.git
   ```

2. 재인증:
   ```bash
   gh auth login
   ```

### 문제 2: 프로젝트 권한 부족

**증상**:
```
GraphQL: Resource not accessible by integration (addProjectV2ItemById)
```

**해결 방법**:

프로젝트 권한 추가:
```bash
gh auth refresh -h github.com -s project,read:project
```

### 문제 3: NPM 배포 실패

**증상**:
```
npm ERR! code E401
npm ERR! 401 Unauthorized - PUT https://registry.npmjs.org/@scope/package
```

**해결 방법**:

1. NPM_TOKEN 확인:
   ```bash
   gh secret list
   ```

2. 토큰 재생성 및 업데이트:
   - NPM 웹사이트에서 새 토큰 생성
   - GitHub Secrets 업데이트

3. package.json의 publishConfig 확인:
   ```json
   "publishConfig": {
     "access": "public"
   }
   ```

### 문제 4: 토큰 만료

**증상**:
```
HTTP 401: Unauthorized (https://api.github.com/...)
```

**해결 방법**:

토큰 갱신:
```bash
gh auth refresh
```

---

## 요약: 전체 설정 체크리스트

- [ ] GitHub CLI 설치 (`brew install gh`)
- [ ] GitHub 기본 인증 (`gh auth login`)
- [ ] 프로젝트 권한 추가 (`gh auth refresh -s project,read:project`)
- [ ] 인증 상태 확인 (`gh auth status`)
- [ ] NPM Access Token 생성
- [ ] GitHub Secrets에 NPM_TOKEN 추가
- [ ] 저장소 생성 및 푸시 (`gh repo create`)
- [ ] GitHub Projects 생성 및 이슈 추가

---

## 참고 자료

- [GitHub CLI 공식 문서](https://cli.github.com/manual/)
- [GitHub Projects 문서](https://docs.github.com/en/issues/planning-and-tracking-with-projects)
- [NPM Publishing 가이드](https://docs.npmjs.com/creating-and-publishing-scoped-public-packages)
- [GitHub Actions Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets)

---

**작성일**: 2025-11-29
**마지막 업데이트**: 2025-11-29
