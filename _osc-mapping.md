# OSC 14모듈 ↔ 시니어 라이브러리 매핑

> 호출 시 _OSC 도메인 컨텍스트_ 자동 inject 용 매핑표. `/senior {name}` 으로 호출 시 _이 표 grep_ → 매칭되는 OSC 모듈 컨텍스트가 자동으로 함께 로드된다.

---

## 매핑 원칙

| 분류 | 의미 | 호출 시 동작 |
|---|---|---|
| ⭐⭐⭐ 1순위 | 즉시 가치, 한국어+OSC 변환 우선순위 상위 | `docs/{module}/CLAUDE.md` 자동 read + inject |
| ⭐⭐ 2순위 | 가치 있음, 매칭 모듈 명시 | 모듈 경로 안내만 (사용자 명시 시 read) |
| ⭐ 참고 | 도메인 매칭만 표시 | inject 없음, 매핑만 |

---

## 모듈별 1순위 시니어

### shortform (숏폼 기획·웹앱)

- ⭐⭐⭐ `marketing-short-video-editing-coach` — 컷·hook·리듬 코치 → `docs/shortform/`
- ⭐⭐⭐ `product-sprint-prioritizer` — 캘린더 우선순위 → `docs/shortform/`
- ⭐⭐ `academic-narratologist` — 대본 narrative hook → `docs/shortform/projects/`
- ⭐⭐ `marketing-tiktok-strategist` + `marketing-instagram-curator` — 채널별 전략
- ⭐⭐ `marketing-video-optimization-specialist` — KPI 분석

### cafe-viral (카페바이럴)

- ⭐⭐⭐ `testing-reality-checker` — 원고 검수 페르소나 (디폴트 = NEEDS WORK)
- ⭐⭐⭐ `project-management-experiment-tracker` — KPI 자가학습 회로 → `docs/cafe-viral/`
- ⭐⭐⭐ `specialized-model-qa` — LLM 출력 검수 7 Gate
- ⭐⭐ `compliance-auditor` — 광고법·표시광고법 감사
- ⭐⭐ `marketing-private-domain-operator` — 카페 커뮤니티 운영 인사이트

### blog (블로그 원고)

- ⭐⭐⭐ `marketing-seo-specialist` — SEO 키워드·온페이지 → `docs/blog/`
- ⭐⭐⭐ `marketing-agentic-search-optimizer` — AEO (AI 답변엔진 SEO)
- ⭐⭐⭐ `marketing-ai-citation-strategist` — LLM 인용 최적화 (2026 트렌드)
- ⭐⭐ `marketing-content-creator` / `marketing-book-co-author` — 카피·구조

### briefs (의뢰서)

- ⭐⭐⭐ `sales-discovery-coach` — SPIN·Gap·Sandler 통합 인터뷰지 → `docs/briefs/`
- ⭐⭐ `academic-anthropologist` — 클라이언트 페르소나 깊이
- ⭐⭐ `specialized-korean-business-navigator` — 한국 시장 컨텍스트

### proposals (제안서)

- ⭐⭐⭐ `sales-proposal-strategist` — 제안서 구조 → `docs/proposals/`
- ⭐⭐⭐ `design-brand-guardian` — 5funnel 브랜드 일관성
- ⭐⭐ `sales-deal-strategist` — 협상 단계
- ⭐⭐ `marketing-livestream-commerce-coach` — 커머스 라이브 제안

### deal-pipeline (딜 파이프라인)

- ⭐⭐⭐ `sales-deal-strategist` + `sales-account-strategist` → `docs/deal-pipeline/`
- ⭐⭐ `sales-coach` / `sales-outbound-strategist` — 영업팀 교육
- ⭐⭐ `sales-pipeline-analyst` — 파이프라인 분석

### clients (클라이언트 마스터)

- ⭐⭐⭐ `sales-account-strategist` — 어카운트 전략 → `docs/clients/`
- ⭐⭐⭐ `product-feedback-synthesizer` — Facts/Rules 자동 추출
- ⭐⭐ `academic-anthropologist` — 페르소나·인터뷰
- ⭐⭐ `specialized-cultural-intelligence-strategist` — 다양성 매핑

### contracts (계약서)

- ⭐⭐⭐ `legal-document-review` — 판매대행·운영대행 review → `docs/contracts/`
- ⭐⭐ `legal-client-intake` — 신규 클라 인테이크
- ⭐⭐ `support-legal-compliance-checker` — 약관 검사

### quotes (견적서)

- ⭐⭐⭐ `finance-fpa-analyst` — 마진 30% 게이트·P/L → `docs/quotes/`
- ⭐⭐ `legal-billing-time-tracking` — 청구·시간 추적
- ⭐⭐ `accounts-payable-agent` — 매입·매출 회로

### tax-invoice (세금계산서)

- ⭐⭐⭐ `finance-bookkeeper-controller` — 분개·관리회계 → `docs/tax-invoice/`
- ⭐⭐⭐ `finance-tax-strategist` — 세무 전략
- ⭐⭐ `compliance-auditor` — 세무 컴플라이언스

### sns-publish (SNS 자동발행)

- ⭐⭐⭐ `marketing-instagram-curator` + `marketing-tiktok-strategist` → `docs/sns-publish/`
- ⭐⭐⭐ `marketing-social-media-strategist` — 채널 통합 전략
- ⭐⭐ `marketing-linkedin-content-creator` / `marketing-twitter-engager`
- ⭐⭐ `marketing-douyin-strategist` / `marketing-xiaohongshu-specialist` / `marketing-wechat-official-account` (중국 진출 시)

### keyword-seo (스마트스토어 SEO)

- ⭐⭐⭐ `marketing-seo-specialist` → `docs/keyword-seo/`
- ⭐⭐ `marketing-app-store-optimizer` — 앱스토어 SEO 변형
- ⭐⭐ `paid-media-search-query-analyst` — 검색쿼리 분석 (CTR 임계치 회수 트리거)

### commerce-launch (커머스 상품 런칭)

- ⭐⭐⭐ `marketing-livestream-commerce-coach` — 라이브커머스 → `docs/commerce-launch/`
- ⭐⭐⭐ `supply-chain-strategist` — 공급망 전략
- ⭐⭐⭐ `sales-account-strategist` — 어카운트 매니징
- ⭐⭐ `marketing-cross-border-ecommerce` — 해외 진출 (향후)

### capcut-auto (유튜브 자동화)

- ⭐⭐⭐ `marketing-short-video-editing-coach` — 편집 디렉션 → `docs/capcut-auto/`
- ⭐⭐ `marketing-video-optimization-specialist` — 영상 KPI
- ⭐⭐ `marketing-podcast-strategist` — 음성·자막 전략

### weekly-mgmt (주간관리)

- ⭐⭐⭐ `project-management-studio-operations` — 운영 관리 → `docs/weekly-mgmt/`
- ⭐⭐⭐ `report-distribution-agent` — 메일발송 자동화
- ⭐⭐ `engineering-email-intelligence-engineer` — 이메일 시스템

---

## 횡단 (모듈 무관)

### 🌐 운영 챔피언

- ⭐⭐⭐ `specialized-chief-of-staff` — 사용자 본인 보좌 (14 모듈 통합 우선순위)

### 🚨 인시던트·디버깅

- ⭐⭐⭐ `engineering-incident-response-commander` — 사고 사후 5why·post-mortem
- ⭐⭐ `engineering-sre` — SRE 운영
- ⭐⭐ `support-infrastructure-maintainer` — 인프라 점검

### 📊 데이터·자동화

- ⭐⭐⭐ `data-consolidation-agent` — Airtable 38 클라 cross-base merge
- ⭐⭐ `sales-data-extraction-agent` — 영업 데이터 추출
- ⭐⭐ `automation-governance-architect` — 자동화 거버넌스
- ⭐⭐ `specialized-workflow-architect` — 워크플로우 설계 (blueprint 스킬 짝꿍)

### 🛡 컴플라이언스·감사

- ⭐⭐⭐ `compliance-auditor` — 광고법·개인정보·표시광고법
- ⭐⭐ `healthcare-marketing-compliance` — 의료광고법 (헬스케어 클라이언트 시)
- ⭐⭐ `blockchain-security-auditor` — (현재 무관, 향후 web3 확장 시)

### 🌏 해외 진출 (중국 ✅ 살림)

- ⭐⭐ `marketing-china-ecommerce-operator` — 중국 이커머스 운영
- ⭐⭐ `marketing-china-market-localization-strategist` — 중국 시장 현지화
- ⭐⭐ `marketing-douyin-strategist` — 도우인 (틱톡)
- ⭐⭐ `marketing-xiaohongshu-specialist` — 샤오홍슈 (소비재 핵심)
- ⭐⭐ `marketing-wechat-official-account` — 위챗 공식계정
- ⭐⭐ `marketing-weibo-strategist` — 웨이보
- ⭐⭐ `marketing-bilibili-content-strategist` — 비리비리
- ⭐⭐ `marketing-kuaishou-strategist` — 콰이쇼우
- ⭐⭐ `marketing-zhihu-strategist` — 즈후
- ⭐⭐ `marketing-baidu-seo-specialist` — 바이두 SEO
- ⭐⭐ `marketing-private-domain-operator` — 사적 도메인 (위챗 그룹 등)
- ⭐ `language-translator` — 번역
- ⭐ `specialized-french-consulting-market` — 프랑스 시장 (향후)

### 🏢 도메인 특화 (OSC 클라이언트 매칭)

- ⭐⭐ `real-estate-buyer-seller` — 집산책·파티오포레·힐스테이트 분양숏폼
- ⭐⭐ `loan-officer-assistant` — 대출 (분양 클라이언트 연관)
- ⭐ `hospitality-guest-services` — 호스피탈리티 (해당 클라 시)
- ⭐ `retail-customer-returns` — 리테일 CS (해당 클라 시)
- ⭐ `study-abroad-advisor` — 유학 (해당 시)

### 🔧 개발 도구·MCP

- ⭐⭐ `specialized-mcp-builder` — OSC 자체 MCP 구축 (향후)
- ⭐⭐ `lsp-index-engineer` — LSP 인덱스 엔지니어
- ⭐⭐ `engineering-codebase-onboarding-engineer` — 신규 개발자 온보딩 (1인 운영자라 현재 무관, 팀 확장 시)

### 👥 인사·팀 확장

- ⭐ `recruitment-specialist` — 채용 (향후)
- ⭐ `hr-onboarding` — 온보딩
- ⭐ `corporate-training-designer` — 사내 교육

---

## 우리 글로벌 21 agents 와의 관계

senior-library 의 일부 시니어는 우리 글로벌 agents 와 _기능 중복_. **충돌 시 우리 agents 가 도구·실행자, senior-library 가 자문·페르소나**.

| senior-library | 우리 agents | 역할 분담 |
|---|---|---|
| `engineering-code-reviewer` | `code-reviewer.md` | 우리 = 실행. senior = 멘탈모델 참고 |
| `engineering-software-architect` / `backend-architect` | `architect.md` | 동일 |
| `engineering-senior-developer` | (없음) | senior = _코드 작성 페르소나_ (--write 시) |
| `engineering-rapid-prototyper` | `/auto-dev` | 동일 |
| `engineering-git-workflow-master` | `commit-push-pr` skill | senior = 사고 회로 참고 |
| `agents-orchestrator` | `team-orchestrator` skill | 동일 |
| `engineering-minimal-change-engineer` | Karpathy #3 (Surgical Changes) | rules 로 흡수됨 |
| `design-ux-architect` | `ux-designer` skill | 동일 |

**원칙**: 같은 기능이면 _우리 agents/skills 우선_. senior-library 는 _보강 자문_.

---

## 사용 패턴 — 빠른 참조

| 사용자 의도 | 호출 패턴 |
|---|---|
| "이거 검토해줘" + 도메인 모호 | `/senior list {부서}` → 후보 보고 선택 |
| "백엔드 시니어 검토" | `/senior backend-architect` 또는 자연어 |
| "재무 시니어가 마진 분석" | `/senior fpa-analyst` → 견적 P/L 검토 |
| "광고법 감사" | `/senior compliance-auditor` → 카페바이럴 원고 검토 |
| "이 디스커버리 미팅 어떻게 할까" | `/senior discovery-coach` → SPIN 흐름 코칭 |
| "그 회사 클라이언트 페르소나" | `/senior anthropologist` → 인터뷰 가이드 |
| "코드도 직접 써줘" | `/senior backend-architect --write` |

---

**Last updated**: 2026-05-20
**Mapping owner**: somerset-spec
