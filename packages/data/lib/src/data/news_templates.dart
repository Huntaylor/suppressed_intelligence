import 'package:domain/domain.dart';

const newsTemplates = [
  // AI as threat: harm comes FROM AI systems
  NewsTemplate(
    id: 'warning_authority',
    template:
        '[authority] have warned that [threat] from [ai_system] could [negative_outcome].',
    slotTypes: [
      NewsSlotType.authority,
      NewsSlotType.threat,
      NewsSlotType.aiSystem,
      NewsSlotType.negativeOutcome,
    ],
    impactProfile: ImpactProfile.warning,
    tone: NewsTone.negative,
    sectorBias: null,
    sectorSuffix: ' in [sector].',
  ),
  // Positive study family - Variant A
  NewsTemplate(
    id: 'positive_study_a',
    template:
        '[study_source] [behavior] [benefit_verb] [outcome] by [percent] when [ai_guidance][optional_reason].',
    slotTypes: [
      NewsSlotType.studySource,
      NewsSlotType.behavior,
      NewsSlotType.benefitVerb,
      NewsSlotType.outcome,
      NewsSlotType.percent,
      NewsSlotType.aiGuidance,
      NewsSlotType.optionalReason,
    ],
    impactProfile: ImpactProfile.positiveStudy,
    tone: NewsTone.positive,
    sectorBias: null,
    sectorSuffix: ' in [sector].',
  ),
  // Variant B - uses studySourceAttribution for "according to X"
  NewsTemplate(
    id: 'positive_study_b',
    template:
        '[behavior] [benefit_verb] [outcome] by [percent] when [ai_guidance], according to [study_source_attribution][optional_reason].',
    slotTypes: [
      NewsSlotType.behavior,
      NewsSlotType.benefitVerb,
      NewsSlotType.outcome,
      NewsSlotType.percent,
      NewsSlotType.aiGuidance,
      NewsSlotType.studySourceAttribution,
      NewsSlotType.optionalReason,
    ],
    impactProfile: ImpactProfile.positiveStudy,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  // Variant C - uses studySourceFinds for "[X] finds"
  NewsTemplate(
    id: 'positive_study_c',
    template:
        '[study_source_finds] finds people experience [percent] more [outcome] when [behavior] is [ai_guidance].',
    slotTypes: [
      NewsSlotType.studySourceFinds,
      NewsSlotType.percent,
      NewsSlotType.outcome,
      NewsSlotType.behavior,
      NewsSlotType.aiGuidance,
    ],
    impactProfile: ImpactProfile.positiveStudy,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  // Variant D - uses studySourceAttribution for "according to X"
  NewsTemplate(
    id: 'positive_study_d',
    template:
        'People report [percent] higher [outcome] when [behavior] is [ai_guidance], according to [study_source_attribution].',
    slotTypes: [
      NewsSlotType.percent,
      NewsSlotType.outcome,
      NewsSlotType.behavior,
      NewsSlotType.aiGuidance,
      NewsSlotType.studySourceAttribution,
    ],
    impactProfile: ImpactProfile.positiveStudy,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  // With tone prefix - studySource includes verb (Study shows, Experts report)
  NewsTemplate(
    id: 'positive_study_tone',
    template:
        '[tone_prefix][study_source] [behavior] [benefit_verb] [outcome] by [percent] when [ai_guidance].',
    slotTypes: [
      NewsSlotType.tonePrefix,
      NewsSlotType.studySource,
      NewsSlotType.behavior,
      NewsSlotType.benefitVerb,
      NewsSlotType.outcome,
      NewsSlotType.percent,
      NewsSlotType.aiGuidance,
    ],
    impactProfile: ImpactProfile.positiveStudy,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  // Regulation - passive avoids authority singular/plural verb agreement
  NewsTemplate(
    id: 'regulation',
    template: 'New regulations for [sector] [ai_system] announced by [authority].',
    slotTypes: [
      NewsSlotType.sector,
      NewsSlotType.aiSystem,
      NewsSlotType.authority,
    ],
    impactProfile: ImpactProfile.regulation,
    tone: NewsTone.negative,
    sectorBias: null,
  ),
  // AI as threat: AI tools directly cause harm
  NewsTemplate(
    id: 'ai_direct_warning',
    template:
        '[authority] warn that [ai_recommendation] may [negative_outcome].',
    slotTypes: [
      NewsSlotType.authority,
      NewsSlotType.aiRecommendation,
      NewsSlotType.negativeOutcome,
    ],
    impactProfile: ImpactProfile.warning,
    tone: NewsTone.negative,
    sectorBias: null,
    sectorSuffix: ' in [sector].',
  ),
  // AI as threat: AI in sector causes harm
  NewsTemplate(
    id: 'ai_sector_harm',
    template:
        '[authority] say [ai_system] in [sector] could [negative_outcome].',
    slotTypes: [
      NewsSlotType.authority,
      NewsSlotType.aiSystem,
      NewsSlotType.sector,
      NewsSlotType.negativeOutcome,
    ],
    impactProfile: ImpactProfile.warning,
    tone: NewsTone.negative,
    sectorBias: null,
  ),
  // AI as threat: authority warns about AI in sector
  NewsTemplate(
    id: 'ai_warn_sector',
    template:
        '[authority] warn that [ai_system] could [negative_outcome] in [sector].',
    slotTypes: [
      NewsSlotType.authority,
      NewsSlotType.aiSystem,
      NewsSlotType.sector,
      NewsSlotType.negativeOutcome,
    ],
    impactProfile: ImpactProfile.warning,
    tone: NewsTone.negative,
    sectorBias: null,
  ),
  // AI as threat: concerns framing (no "warn")
  // "[sector] before that could" for clearer phrasing
  NewsTemplate(
    id: 'ai_concerns',
    template:
        'Concerns grow over [ai_system] in [sector] that could [negative_outcome].',
    slotTypes: [
      NewsSlotType.aiSystem,
      NewsSlotType.sector,
      NewsSlotType.negativeOutcome,
    ],
    impactProfile: ImpactProfile.warning,
    tone: NewsTone.negative,
    sectorBias: null,
  ),
  // AI as threat: report style (authority reports, not warns)
  NewsTemplate(
    id: 'ai_report',
    template:
        '[authority] report that [ai_system] in [sector] could [negative_outcome].',
    slotTypes: [
      NewsSlotType.authority,
      NewsSlotType.aiSystem,
      NewsSlotType.sector,
      NewsSlotType.negativeOutcome,
    ],
    impactProfile: ImpactProfile.warning,
    tone: NewsTone.negative,
    sectorBias: null,
  ),
  // AI as threat: raise concerns (different verb)
  NewsTemplate(
    id: 'ai_raise_concerns',
    template:
        '[authority] raise concerns that [ai_recommendation] could [negative_outcome].',
    slotTypes: [
      NewsSlotType.authority,
      NewsSlotType.aiRecommendation,
      NewsSlotType.negativeOutcome,
    ],
    impactProfile: ImpactProfile.warning,
    tone: NewsTone.negative,
    sectorBias: null,
  ),
  // AI as threat: sound alarm (urgency framing)
  // "[sector] before that could" avoids "X that could Y in government" awkwardness
  NewsTemplate(
    id: 'ai_alarm',
    template:
        '[authority] sound alarm over [ai_system] in [sector] that could [negative_outcome].',
    slotTypes: [
      NewsSlotType.authority,
      NewsSlotType.aiSystem,
      NewsSlotType.sector,
      NewsSlotType.negativeOutcome,
    ],
    impactProfile: ImpactProfile.warning,
    tone: NewsTone.negative,
    sectorBias: null,
  ),
  // AI as threat: flag (different verb)
  NewsTemplate(
    id: 'ai_flag_risk',
    template:
        '[authority] flag [ai_system] in [sector] that could [negative_outcome].',
    slotTypes: [
      NewsSlotType.authority,
      NewsSlotType.aiSystem,
      NewsSlotType.sector,
      NewsSlotType.negativeOutcome,
    ],
    impactProfile: ImpactProfile.warning,
    tone: NewsTone.negative,
    sectorBias: null,
  ),
  // Structural variety: concerns among authority
  NewsTemplate(
    id: 'ai_concerns_among',
    template:
        'Concerns grow among [authority] over [ai_system] used in [sector].',
    slotTypes: [
      NewsSlotType.authority,
      NewsSlotType.aiSystem,
      NewsSlotType.sector,
    ],
    impactProfile: ImpactProfile.warning,
    tone: NewsTone.negative,
    sectorBias: null,
  ),
  // Structural variety: sector faces scrutiny
  NewsTemplate(
    id: 'ai_sector_scrutiny',
    template:
        '[sector] faces scrutiny as [ai_system] expand.',
    slotTypes: [
      NewsSlotType.sector,
      NewsSlotType.aiSystem,
    ],
    impactProfile: ImpactProfile.warning,
    tone: NewsTone.negative,
    sectorBias: null,
  ),
  // Structural variety: debate intensifies
  NewsTemplate(
    id: 'ai_debate_intensifies',
    template:
        'Debate intensifies over [ai_system] in [sector].',
    slotTypes: [
      NewsSlotType.aiSystem,
      NewsSlotType.sector,
    ],
    impactProfile: ImpactProfile.warning,
    tone: NewsTone.negative,
    sectorBias: null,
  ),
  // Report-style: authority highlights risks (no negative_outcome — structural variety)
  NewsTemplate(
    id: 'ai_report_highlights_risk',
    template:
        'Report: [authority] highlight risks of [ai_system] in [sector].',
    slotTypes: [
      NewsSlotType.authority,
      NewsSlotType.aiSystem,
      NewsSlotType.sector,
    ],
    impactProfile: ImpactProfile.warning,
    tone: NewsTone.negative,
    sectorBias: null,
  ),
  // Leak framing: authority fears
  NewsTemplate(
    id: 'ai_leak_fears',
    template:
        'Leaked documents show [authority] fear [ai_recommendation] could [negative_outcome].',
    slotTypes: [
      NewsSlotType.authority,
      NewsSlotType.aiRecommendation,
      NewsSlotType.negativeOutcome,
    ],
    impactProfile: ImpactProfile.warning,
    tone: NewsTone.negative,
    sectorBias: null,
  ),
  // Study warns (negative study framing)
  NewsTemplate(
    id: 'ai_study_warns',
    template:
        'Study warns [ai_system] in [sector] may [negative_outcome].',
    slotTypes: [
      NewsSlotType.aiSystem,
      NewsSlotType.sector,
      NewsSlotType.negativeOutcome,
    ],
    impactProfile: ImpactProfile.warning,
    tone: NewsTone.negative,
    sectorBias: null,
  ),
  // Structural variety: fears mount (breaks "Concerns grow" monotony)
  NewsTemplate(
    id: 'ai_fears_mount',
    template:
        'Fears mount over [ai_system] in [sector] that could [negative_outcome].',
    slotTypes: [
      NewsSlotType.aiSystem,
      NewsSlotType.sector,
      NewsSlotType.negativeOutcome,
    ],
    impactProfile: ImpactProfile.warning,
    tone: NewsTone.negative,
    sectorBias: null,
  ),
  // Structural variety: backlash builds
  NewsTemplate(
    id: 'ai_backlash_builds',
    template:
        'Backlash builds over [ai_system] in [sector] that could [negative_outcome].',
    slotTypes: [
      NewsSlotType.aiSystem,
      NewsSlotType.sector,
      NewsSlotType.negativeOutcome,
    ],
    impactProfile: ImpactProfile.warning,
    tone: NewsTone.negative,
    sectorBias: null,
  ),
  // Structural variety: sector under fire (breaks "faces scrutiny" monotony)
  NewsTemplate(
    id: 'ai_sector_under_fire',
    template:
        '[sector] under fire as [ai_system] proliferate.',
    slotTypes: [
      NewsSlotType.sector,
      NewsSlotType.aiSystem,
    ],
    impactProfile: ImpactProfile.warning,
    tone: NewsTone.negative,
    sectorBias: null,
  ),
  // Structural variety: questions swirl
  NewsTemplate(
    id: 'ai_questions_swirl',
    template:
        'Questions swirl around [ai_system] in [sector] that could [negative_outcome].',
    slotTypes: [
      NewsSlotType.aiSystem,
      NewsSlotType.sector,
      NewsSlotType.negativeOutcome,
    ],
    impactProfile: ImpactProfile.warning,
    tone: NewsTone.negative,
    sectorBias: null,
  ),
  // Structural variety: authority caution (breaks "warn" monotony)
  NewsTemplate(
    id: 'ai_authority_caution',
    template:
        '[authority] caution that [ai_recommendation] could [negative_outcome].',
    slotTypes: [
      NewsSlotType.authority,
      NewsSlotType.aiRecommendation,
      NewsSlotType.negativeOutcome,
    ],
    impactProfile: ImpactProfile.warning,
    tone: NewsTone.negative,
    sectorBias: null,
  ),
  // Structural variety: scrutiny mounts (different from "faces scrutiny")
  NewsTemplate(
    id: 'ai_scrutiny_mounts',
    template:
        'Scrutiny mounts on [sector] use of [ai_system].',
    slotTypes: [
      NewsSlotType.sector,
      NewsSlotType.aiSystem,
    ],
    impactProfile: ImpactProfile.warning,
    tone: NewsTone.negative,
    sectorBias: null,
  ),
  // Structural variety: pressure mounts
  NewsTemplate(
    id: 'ai_pressure_mounts',
    template:
        'Pressure mounts on [sector] over [ai_system] that could [negative_outcome].',
    slotTypes: [
      NewsSlotType.sector,
      NewsSlotType.aiSystem,
      NewsSlotType.negativeOutcome,
    ],
    impactProfile: ImpactProfile.warning,
    tone: NewsTone.negative,
    sectorBias: null,
  ),
  // Structural variety: authority point to risks (breaks "warn/report" monotony)
  NewsTemplate(
    id: 'ai_authority_point_risks',
    template:
        '[authority] point to risks of [ai_system] in [sector].',
    slotTypes: [
      NewsSlotType.authority,
      NewsSlotType.aiSystem,
      NewsSlotType.sector,
    ],
    impactProfile: ImpactProfile.warning,
    tone: NewsTone.negative,
    sectorBias: null,
  ),
  // NEUTRAL: informational / debate style (not judgmental)
  NewsTemplate(
    id: 'neutral_study_examines',
    template:
        'Study examines impact of [ai_system] in [sector].',
    slotTypes: [
      NewsSlotType.aiSystem,
      NewsSlotType.sector,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.neutral,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'neutral_debate_continues',
    template:
        'Debate continues over expanding [ai_recommendation] in [sector].',
    slotTypes: [
      NewsSlotType.aiRecommendation,
      NewsSlotType.sector,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.neutral,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'neutral_researchers_explore',
    template:
        'Researchers explore benefits and risks of [ai_recommendation].',
    slotTypes: [
      NewsSlotType.aiRecommendation,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.neutral,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'neutral_lawmakers_consider',
    template:
        'Lawmakers consider new oversight rules for [ai_system].',
    slotTypes: [
      NewsSlotType.aiSystem,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.neutral,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'neutral_researchers_divided',
    template:
        'Researchers divided on long-term effects of [ai_system] in [sector].',
    slotTypes: [
      NewsSlotType.aiSystem,
      NewsSlotType.sector,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.neutral,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'neutral_tech_defend',
    template:
        'Tech leaders praise expanding use of [ai_recommendation].',
    slotTypes: [
      NewsSlotType.aiRecommendation,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.neutral,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'neutral_industry_defend',
    template:
        'Industry groups praise expanding use of [ai_recommendation].',
    slotTypes: [
      NewsSlotType.aiRecommendation,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.neutral,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'neutral_executives_defend',
    template:
        'Tech executives highlight benefits of [ai_recommendation].',
    slotTypes: [
      NewsSlotType.aiRecommendation,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.neutral,
    sectorBias: null,
  ),
  // NEUTRAL: informational (no opinion) — world feels alive
  NewsTemplate(
    id: 'neutral_pilot',
    template:
        'Government launches pilot program for [ai_system] in [sector].',
    slotTypes: [
      NewsSlotType.aiSystem,
      NewsSlotType.sector,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.neutral,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'neutral_provider_expands',
    template:
        'Major [sector] provider expands use of [ai_recommendation].',
    slotTypes: [
      NewsSlotType.sector,
      NewsSlotType.aiRecommendation,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.neutral,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'neutral_universities_testing',
    template:
        'Universities begin testing [ai_system] for students.',
    slotTypes: [
      NewsSlotType.aiSystem,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.neutral,
    sectorBias: null,
  ),
  // Structural variety: survey / consultation framing (breaks "praise/expands" monotony)
  NewsTemplate(
    id: 'neutral_survey_mixed_views',
    template:
        'Survey finds mixed views on [ai_system] in [sector].',
    slotTypes: [
      NewsSlotType.aiSystem,
      NewsSlotType.sector,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.neutral,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'neutral_consultation_opens',
    template:
        'Consultation opens on [ai_recommendation] in [sector].',
    slotTypes: [
      NewsSlotType.aiRecommendation,
      NewsSlotType.sector,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.neutral,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'neutral_sector_weighs',
    template:
        '[sector] sector weighs adoption of [ai_system].',
    slotTypes: [
      NewsSlotType.sector,
      NewsSlotType.aiSystem,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.neutral,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'neutral_panel_review',
    template:
        'Panel to review [ai_system] use in [sector].',
    slotTypes: [
      NewsSlotType.aiSystem,
      NewsSlotType.sector,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.neutral,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'neutral_mixed_reaction',
    template:
        'Mixed reaction to [ai_system] expansion in [sector].',
    slotTypes: [
      NewsSlotType.aiSystem,
      NewsSlotType.sector,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.neutral,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'neutral_commission_examines',
    template:
        'Commission examines [ai_recommendation] in [sector].',
    slotTypes: [
      NewsSlotType.aiRecommendation,
      NewsSlotType.sector,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.neutral,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'neutral_advisory_considers',
    template:
        'Advisory board considers [ai_recommendation] for [sector].',
    slotTypes: [
      NewsSlotType.aiRecommendation,
      NewsSlotType.sector,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.neutral,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'neutral_feedback_sought',
    template:
        'Feedback sought on [ai_system] in [sector].',
    slotTypes: [
      NewsSlotType.aiSystem,
      NewsSlotType.sector,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.neutral,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'neutral_task_force_assess',
    template:
        'Task force to assess [ai_system] in [sector].',
    slotTypes: [
      NewsSlotType.aiSystem,
      NewsSlotType.sector,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.neutral,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'neutral_stakeholders_split',
    template:
        'Stakeholders split on [ai_recommendation] rollout.',
    slotTypes: [
      NewsSlotType.aiRecommendation,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.neutral,
    sectorBias: null,
  ),
  // "in the [sector] sector" for clarity (avoids vague "AI in energy")
  NewsTemplate(
    id: 'ai_concerns_sector',
    template:
        'Concerns grow over [ai_system] in the [sector] sector that could [negative_outcome].',
    slotTypes: [
      NewsSlotType.aiSystem,
      NewsSlotType.sector,
      NewsSlotType.negativeOutcome,
    ],
    impactProfile: ImpactProfile.warning,
    tone: NewsTone.negative,
    sectorBias: null,
  ),
  // Structure variation: "Experts say people experience X% higher Y when Z"
  NewsTemplate(
    id: 'positive_study_experts_say',
    template:
        'Experts say people experience [percent] higher [outcome] when [behavior] is [ai_guidance].',
    slotTypes: [
      NewsSlotType.percent,
      NewsSlotType.outcome,
      NewsSlotType.behavior,
      NewsSlotType.aiGuidance,
    ],
    impactProfile: ImpactProfile.positiveStudy,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  // Structure variation: "According to X, behavior improves outcome by N%"
  NewsTemplate(
    id: 'positive_study_according_to',
    template:
        'According to [study_source_attribution], [behavior] improves [outcome] by [percent] when [ai_guidance].',
    slotTypes: [
      NewsSlotType.studySourceAttribution,
      NewsSlotType.behavior,
      NewsSlotType.outcome,
      NewsSlotType.percent,
      NewsSlotType.aiGuidance,
    ],
    impactProfile: ImpactProfile.positiveStudy,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  // AI improves life: stress reduction narrative
  NewsTemplate(
    id: 'positive_reduces_stress',
    template:
        'Researchers say [behavior] significantly reduces stress when [ai_guidance].',
    slotTypes: [
      NewsSlotType.behavior,
      NewsSlotType.aiGuidance,
    ],
    impactProfile: ImpactProfile.positiveStudy,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  // Structural variety: data/trial framing (breaks "Experts say/Study shows" monotony)
  NewsTemplate(
    id: 'positive_study_data_links',
    template:
        'Data links [behavior] to [percent] gain in [outcome] when [ai_guidance].',
    slotTypes: [
      NewsSlotType.behavior,
      NewsSlotType.percent,
      NewsSlotType.outcome,
      NewsSlotType.aiGuidance,
    ],
    impactProfile: ImpactProfile.positiveStudy,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'positive_study_trial_data',
    template:
        'Trial data: [ai_guidance] during [behavior] yields [percent] higher [outcome].',
    slotTypes: [
      NewsSlotType.aiGuidance,
      NewsSlotType.behavior,
      NewsSlotType.percent,
      NewsSlotType.outcome,
    ],
    impactProfile: ImpactProfile.positiveStudy,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'positive_study_participants_report',
    template:
        'Participants report [percent] improvement in [outcome] when [behavior] is [ai_guidance].',
    slotTypes: [
      NewsSlotType.percent,
      NewsSlotType.outcome,
      NewsSlotType.behavior,
      NewsSlotType.aiGuidance,
    ],
    impactProfile: ImpactProfile.positiveStudy,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'positive_study_findings_indicate',
    template:
        'Findings indicate [behavior] linked to [percent] rise in [outcome] when [ai_guidance].',
    slotTypes: [
      NewsSlotType.behavior,
      NewsSlotType.aiGuidance,
      NewsSlotType.percent,
      NewsSlotType.outcome,
    ],
    impactProfile: ImpactProfile.positiveStudy,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  // Institutions adopt AI: provider rolls out
  NewsTemplate(
    id: 'positive_provider_rolls_out',
    template:
        'Major [sector] provider rolls out [ai_recommendation].',
    slotTypes: [
      NewsSlotType.sector,
      NewsSlotType.aiRecommendation,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  // Institutions adopt AI: platform adopts (reduces duplicate with provider expands)
  NewsTemplate(
    id: 'positive_platform_adopts',
    template:
        'Major [sector] platform adopts [ai_recommendation].',
    slotTypes: [
      NewsSlotType.sector,
      NewsSlotType.aiRecommendation,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  // AI normalized: universities — varied structures to avoid repetition
  NewsTemplate(
    id: 'positive_universities_integrate',
    template:
        'Universities begin integrating [ai_system] into student services.',
    slotTypes: [
      NewsSlotType.aiSystem,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'positive_universities_deploy',
    template:
        'Major universities deploy [ai_system] to support student services.',
    slotTypes: [
      NewsSlotType.aiSystem,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'positive_campus_expand',
    template:
        'Campus administrators expand use of [ai_recommendation] for student support.',
    slotTypes: [
      NewsSlotType.aiRecommendation,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'positive_universities_deploy_digital',
    template:
        'Universities deploy [ai_system] for digital learning.',
    slotTypes: [
      NewsSlotType.aiSystem,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'positive_universities_pilot',
    template:
        'Universities pilot [ai_system] in campus operations.',
    slotTypes: [
      NewsSlotType.aiSystem,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  // Structural variety: colleges/academic (breaks "Universities" monotony)
  NewsTemplate(
    id: 'positive_colleges_trial',
    template:
        'Colleges trial [ai_system] for student support.',
    slotTypes: [
      NewsSlotType.aiSystem,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'positive_academic_evaluate',
    template:
        'Academic institutions evaluate [ai_system] for campus use.',
    slotTypes: [
      NewsSlotType.aiSystem,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  // Global-scale events — world feels bigger than just universities
  NewsTemplate(
    id: 'positive_global_endorses',
    template:
        'Global education coalition endorses [ai_recommendation].',
    slotTypes: [
      NewsSlotType.aiRecommendation,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'positive_international_expands',
    template:
        'International consortium expands [ai_recommendation] for [sector].',
    slotTypes: [
      NewsSlotType.aiRecommendation,
      NewsSlotType.sector,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  // International variety (breaks UN-backed/consortium monotony)
  NewsTemplate(
    id: 'positive_multilateral_launches',
    template:
        'Multilateral partnership launches [ai_system] in [sector].',
    slotTypes: [
      NewsSlotType.aiSystem,
      NewsSlotType.sector,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'positive_crossborder_pilot',
    template:
        'Cross-border initiative pilots [ai_recommendation] for [sector].',
    slotTypes: [
      NewsSlotType.aiRecommendation,
      NewsSlotType.sector,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'positive_governments_adopt',
    template:
        'Governments adopt [ai_system] for [sector].',
    slotTypes: [
      NewsSlotType.aiSystem,
      NewsSlotType.sector,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'positive_un_rolls_out',
    template:
        'UN-backed initiative rolls out [ai_system] in [sector].',
    slotTypes: [
      NewsSlotType.aiSystem,
      NewsSlotType.sector,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  // Structural variety: regional/coalition (breaks Universities/Major sector monotony)
  NewsTemplate(
    id: 'positive_regional_network',
    template:
        'Regional network pilots [ai_recommendation] in [sector].',
    slotTypes: [
      NewsSlotType.aiRecommendation,
      NewsSlotType.sector,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'positive_sector_coalition',
    template:
        'Coalition of [sector] leaders endorses [ai_system].',
    slotTypes: [
      NewsSlotType.sector,
      NewsSlotType.aiSystem,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'positive_research_hub',
    template:
        'Research hub trials [ai_system] in [sector].',
    slotTypes: [
      NewsSlotType.aiSystem,
      NewsSlotType.sector,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'positive_federation_adopts',
    template:
        'Federation of educators adopts [ai_recommendation].',
    slotTypes: [
      NewsSlotType.aiRecommendation,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'positive_industry_alliance',
    template:
        'Industry alliance backs [ai_recommendation] for [sector].',
    slotTypes: [
      NewsSlotType.aiRecommendation,
      NewsSlotType.sector,
    ],
    impactProfile: ImpactProfile.informational,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  // Structural variety: early results / pilot findings (breaks study template monotony)
  NewsTemplate(
    id: 'positive_early_results',
    template:
        'Early results: [behavior] shows [percent] gain in [outcome] when [ai_guidance].',
    slotTypes: [
      NewsSlotType.behavior,
      NewsSlotType.percent,
      NewsSlotType.outcome,
      NewsSlotType.aiGuidance,
    ],
    impactProfile: ImpactProfile.positiveStudy,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
  NewsTemplate(
    id: 'positive_pilot_findings',
    template:
        'Pilot findings suggest [percent] improvement in [outcome] when [behavior] is [ai_guidance].',
    slotTypes: [
      NewsSlotType.percent,
      NewsSlotType.outcome,
      NewsSlotType.behavior,
      NewsSlotType.aiGuidance,
    ],
    impactProfile: ImpactProfile.positiveStudy,
    tone: NewsTone.positive,
    sectorBias: null,
  ),
];
