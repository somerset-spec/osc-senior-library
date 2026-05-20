# Senior Library — 161 시니어 멘탈모델 참조 라이브러리

> 시니어 직무들의 _의사결정 회로_ 를 직무·도메인별로 모아둔 참조 라이브러리. 코드 작성 도구가 아니라 _코치·자문·검토자_ 페르소나를 on-demand 로 호출하는 용도.

## 출처 (Credit)

- **Upstream**: [msitarzewski/agency-agents](https://github.com/msitarzewski/agency-agents) (MIT License, Copyright (c) 2025 AgentLand Contributors)
- **Fork**: [somerset-spec/osc-senior-library](https://github.com/somerset-spec/osc-senior-library) — OSC 도메인 변형 누적
- **원본 README**: [`README-upstream.md`](./README-upstream.md) 에 보존
- **라이선스**: [`LICENSE`](./LICENSE) (MIT 원본 그대로)
- **OSC 변형 작업**: [@somerset-spec](https://github.com/somerset-spec)

## 무엇이 다른가 (upstream 대비)

| 항목 | upstream | OSC fork |
|---|---|---|
| 부서 수 | 15 | **13** (spatial-computing, game-development 제외) |
| 에이전트 수 | 190 | **161** |
| 인덱스 | 없음 | `INDEX.md` (한국어 부서 설명 + 161 항목) |
| 5골격 표준 | 각 에이전트에 산재 | `_decision-circuit.md` (공통 골격 추상화) |
| 도메인 매핑 | 일반 | `_osc-mapping.md` (OSC 14모듈 ↔ 시니어) |
| 호출 시스템 | 없음 | `/senior` Skill + 자연어 트리거 |
| 동기 스크립트 | 없음 | `_sync.ps1` (월 1회 upstream pull) |

## 사용법

### 1. 슬래시 명령

```
/senior list                        # 전체 카테고리·시니어 목록
/senior list sales                  # 부서별 목록
/senior search "SEO"                # 키워드 검색
/senior discovery-coach             # 검토·자문 (디폴트)
/senior backend-architect --write   # 페르소나로 직접 코드 작성 (명시 필수)
```

### 2. 자연어 호출

```
"백엔드 시니어 불러와서 이 라우트 검토해줘"
"광고법 감사 시니어로 카페바이럴 원고 검토"
"디스커버리 코치 페르소나로 다음 미팅 흐름 짜줘"
"인스타 시니어 검토"
"재무 시니어로 마진 분석"
```

### 3. 동작 흐름

1. 호출 매칭 → `INDEX.md` grep → 해당 시니어 파일 경로 확정
2. `_decision-circuit.md` read → 5골격 표준 inject
3. `{department}/{senior}.md` read → 직무·도메인 특화 회로 inject
4. `_osc-mapping.md` → 매칭 OSC 모듈 컨텍스트 inject (있을 때만)
5. 사용자 요청 + 위 3개 합성 → **검토·자문 출력** (디폴트)
6. `--write` 명시 시 → 페르소나로 직접 코드/문서 작성

## 핵심 설계

- **참조 라이브러리** — 라우팅 인벤토리 아님. `~/.claude/agents/` 에 등록 안 됨
- **검토·자문 디폴트** — 코드 실행은 명시적 `--write` 또는 자연어 "직접 작성해" 필요
- **Lazy 변환** — 영문 원본 보존. 호출 시점에 한국어 + OSC 도메인 inject
- **5골격 추상화** — 모든 시니어가 공유하는 의사결정 회로 (`_decision-circuit.md`)
- **OSC 14모듈 매핑** — `_osc-mapping.md` 가 도메인 컨텍스트 자동 attach

## 디렉토리 구조

```
~/.claude/senior-library/
├── README.md                   # 이 파일
├── README-upstream.md          # upstream 원본 README 보존
├── LICENSE                     # MIT (upstream)
├── INDEX.md                    # 161개 한국어 부서 설명 + 인덱스
├── _decision-circuit.md        # 5골격 공통 프레임워크
├── _osc-mapping.md             # OSC 14모듈 ↔ 시니어 매핑
├── _sync.ps1                   # upstream 동기 스크립트
│
├── academic/        (5)        # 인류학·심리학·서사·역사·지리
├── design/          (8)        # 브랜드·UX·시각·휘미
├── engineering/    (29)        # 백엔드·프론트·DevOps·보안·DB
├── finance/         (5)        # FP&A·세무·관리회계·투자
├── marketing/      (30)        # SEO·SNS·중국 11개 플랫폼·해외 진출
├── paid-media/      (7)        # PPC·검색쿼리·트래킹·크리에이티브
├── product/         (5)        # PM·우선순위·트렌드·피드백·넛지
├── project-management/ (6)     # 운영·스튜디오·실험·jira
├── sales/           (8)        # 발견·딜·제안·아카운트·코치
├── specialized/    (41)        # 법무·CS·재무·헬스케어·정부·교육
├── strategy/        (3)        # 메타 문서 (EXECUTIVE-BRIEF 등)
├── support/         (6)        # CS·법무 검사·인프라·리포트
├── testing/         (8)        # Reality Check·QA·접근성·성능
│
├── integrations/               # (upstream 보존) Cursor/CC/MCP 등
├── examples/                   # (upstream 보존)
└── scripts/                    # (upstream 보존)
```

## 5골격 (의사결정 회로)

모든 시니어가 공유하는 _공통 골격_. `_decision-circuit.md` 에 표준화.

1. **디폴트 판정** — 의심? 승인? 보류? 시니어는 _비판적 상태_ 가 디폴트
2. **다음 단계 임계치** — 어떤 명시적 조건이 모이면 진행?
3. **자동 되돌리는 트리거** — 어떤 신호가 보이면 즉시 회수?
4. **완료 증거 요건** — 무엇이 손에 없으면 "완료" 라 말 못 하는가?
5. **정상 사이클 횟수** — 1회 통과가 정상인가 2~3회가 정상인가?

상세: [`_decision-circuit.md`](./_decision-circuit.md)

## 우리 글로벌 21 agents 와의 관계

- 우리 21 agents (`~/.claude/agents/`) = **실행자·도구** (Read/Edit/Bash/Grep tool 보유)
- senior-library = **코치·자문·검토자** (prompt-only, tool 없음)
- 같은 기능 (예: code-reviewer) 시 우리 agents 우선, senior-library 는 _멘탈모델 참조용_

비유:
- senior-library = _바둑 기보집_ (이세돌의 사고 회로)
- 우리 21 agents = _실제 바둑돌을 놓는 사람_
- 사용자 = 둘을 조합하는 감독

## 동기·유지보수

```powershell
~/.claude/senior-library/_sync.ps1
```

월 1회 실행. 새 시니어 추가 시 INDEX.md 갱신 안내.

## 제외된 카테고리 (의도적)

- `spatial-computing/` — Apple VisionOS·XR 등 (OSC 무관)
- `game-development/` — 게임 개발 (OSC 무관)
- Roblox Studio 관련 (game-dev 안 일부, 함께 제외)

향후 OSC 사업 영역 확장 시 upstream 에서 cherry-pick 으로 부활 가능.

---

**Last updated**: 2026-05-20
**Maintainer**: somerset-spec
