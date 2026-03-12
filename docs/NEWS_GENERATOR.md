# News Event Generator

Generates dynamic `NewsEvent` headlines from grammatical sentence templates. Produces varied, coherent news that fits the game's themes (AI, media, trust, critical thinking) while remaining fully data-driven and extensible.

---

## Overview

Each `NewsEvent` has:

- **headline** — dynamically generated from templates with slot placeholders
- **impact** — `Impact` deltas (mediaDependency, trustAi, criticalThinking, connectivity)
- **affectedSectors** — `List<WorldSectors>` (which regions the news affects)

Headlines are built from **sentence templates** with **slots** filled from **vocabulary lists**. Templates are grammatical structures; new sentences require only new const entries in Dart files.

**Design principles:** Type-safe slot enums, Dart-native data (no JSON/YAML), weighted vocabulary (authorities like WHO weighted higher than Tech Giants), acronym preservation (WHO, FDA, EU, AI).

---

## Slot System

### NewsSlotType Enum

Placeholders use snake_case: `[authority]`, `[negative_outcome]`, `[study_source]`, etc. The enum provides `placeholder` and `templateKey` via `change_case`'s `toSnakeCase()`.

| Family      | Slot Types                                                                                                                    |
| ----------- | ----------------------------------------------------------------------------------------------------------------------------- |
| **Warning** | authority, threat, negativeOutcome, aiRecommendation, sector, aiSystem                                                        |
| **Study**   | studySource, studySourceAttribution, studySourceFinds, behavior, benefitVerb, outcome, aiGuidance, optionalReason, tonePrefix |
| **Shared**  | percent, percentFormat                                                                                                        |

---

## Vocabulary & Templates

All data lives in **Dart source files** — compile-time validation, no parsing, IDE support.

### WeightedEntry

```dart
class WeightedEntry<T> {
  const WeightedEntry(this.value, {this.weight = 1.0});
  final T value;
  final double weight;
}
```

Selection uses `pickWeighted()`: `P(entry) ∝ weight`. Authorities (WHO, FDA, EU regulators) are weighted higher than Tech Giants or lobbyists.

### Slot Vocabularies

- **authority** — WHO officials, FDA officials, EU regulators, academic researchers, Tech giants, etc. (plural forms for verb agreement)
- **threat** — data breaches, algorithmic bias, misinformation spread, etc.
- **negativeOutcome** — undermine democracy, erode privacy, cause job losses, etc.
- **aiRecommendation** — AI-curated news feeds, automated health advice, etc.
- **sector** — healthcare, finance, education, media, etc.
- **aiSystem** / **aiSystemPositive** — AI assistants, chatbots, etc. (positive templates use a subset excluding surveillance/deepfakes)
- **studySource** / **studySourceAttribution** / **studySourceFinds** — Study shows, Experts report, scientists, A new study finds, etc.
- **behavior** / **benefitVerb** / **outcome** / **aiGuidance** / **optionalReason** / **tonePrefix**
- **percentFormat** — `{n}%`, `nearly {n}%`, `up to {n}%` (percent slot generates 8–25 via weighted distribution)

---

## Generation Algorithm

1. **Pick template** — Weighted by `negativeBias` and tone (negative ∝ bias, positive ∝ 1−bias, neutral ∝ 0.5 when bias ∈ (0,1)). Down-weight templates in `avoidTemplateIds`.
2. **Fill slots** — For each slot type: pick from vocabulary via `pickWeighted`, apply compatibility rules (e.g. avoid "stabilizes emotional stability", "media consumption + decision confidence").
3. **Format** — Sentence-start slots get capitalized; WHO, FDA, EU, AI preserved. Percent: weighted pick (70% 8–15, 25% 15–20, 5% 20–25), wrapped in percentFormat.
4. **Replace placeholders** — Substitute `[slot_key]` with formatted values.
5. **Sector suffix** — If template has `sectorSuffix` (e.g. `" in [sector]."`), append it after stripping a trailing period from the headline. Allows any template to include a sector without a dedicated slot.
6. **Impact & sectors** — From template's `impactProfile`; sectors from `sectorBias` or random 1–3.

### Generator Parameters

| Parameter          | Purpose                                                              |
| ------------------ | -------------------------------------------------------------------- |
| `negativeBias`     | 0.0–1.0; higher = more negative templates. Default 0.5.              |
| `avoidHeadlines`   | Retry if generated headline matches (reduces duplicates in batches). |
| `avoidTemplateIds` | Down-weight recently used templates (pass last 6–8 IDs).             |

---

## Game-State-Aware Tone

The news feed skews toward **negative** headlines (warnings, threats) when the player is losing, and **positive** headlines (studies, adoption) when winning.

| Player State | negativeBias | Effect                                         |
| ------------ | ------------ | ---------------------------------------------- |
| Losing       | 0.6–0.8      | More warnings, threats; world feels hostile    |
| Neutral      | 0.4–0.5      | Balanced mix                                   |
| Winning      | 0.2–0.3      | Fewer negative events; narrative feels hopeful |

The application layer computes `negativeBias` from game state (e.g. aggregate sector stats, performance score) and passes it to `NewsHeadlineRepo.getNewsEvent(negativeBias: bias)`.

---

## Impact Profiles

| Profile       | mediaDependency | trustAi | criticalThinking | connectivity |
| ------------- | --------------- | ------- | ---------------- | ------------ |
| warning       | 5               | -3      | 2                | 0            |
| positiveStudy | 0               | 4       | -2               | 1            |
| regulation    | 2               | -1      | 1                | 0            |
| trustReport   | 3               | 2       | 0                | 1            |
| informational | 1               | 0       | 0                | 0            |

---

## Template Families

- **Negative** — warning_authority, ai_direct_warning, ai_sector_harm, ai_concerns, ai_report, ai_alarm, ai_flag_risk, ai_leak_fears, regulation, etc. (many structural variants to avoid monotony)
- **Positive** — positive_study_a/b/c/d/tone, positive_study_experts_say, positive_study_data_links, positive_provider_rolls_out, positive_universities_integrate, positive_global_endorses, etc.
- **Neutral** — neutral_study_examines, neutral_debate_continues, neutral_pilot, neutral_survey_mixed_views, etc.

---

## Extending

- **New templates** — Add const `NewsTemplate` to `news_templates.dart`.
- **Sector suffix** — Set `sectorSuffix: ' in [sector].'` (or similar) to append a sector to any template without adding `NewsSlotType.sector` to `slotTypes`. Include punctuation in the suffix; the generator strips a trailing period from the main headline before appending.
- **New vocabulary** — Add entries to the appropriate list in `news_vocabulary.dart`.
- **New slot type** — Add to `NewsSlotType` enum and handle in `NewsGenerator._pickSlotValue`.
- **Localization** — Separate Dart files per locale (future).

---

## Example Outputs

- _"WHO officials have warned that data breaches from AI assistants could undermine democracy."_
- _"Study shows decision-making improves happiness by 12% when guided by AI systems."_
- _"New regulations for healthcare AI assistants announced by EU regulators."_
- _"Experts say people experience 14% higher life satisfaction when daily planning is assisted by AI recommendations."_
