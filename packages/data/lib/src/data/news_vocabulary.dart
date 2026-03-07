import 'package:domain/domain.dart';

/// Authority vocabulary. Flattened weights for variety; regulatory bodies
/// still slightly favored. More entries = less repetition.
/// Use plural forms (e.g. "WHO officials") for correct verb agreement with "warn", "say", etc.
const authorityVocabulary = [
  WeightedEntry('WHO officials', weight: 1.2),
  WeightedEntry('FDA officials', weight: 1.2),
  WeightedEntry('EU regulators', weight: 1.2),
  WeightedEntry('academic researchers', weight: 1.0),
  WeightedEntry('government agencies', weight: 1.0),
  WeightedEntry('privacy advocates', weight: 1.0),
  WeightedEntry('consumer groups', weight: 1.0),
  WeightedEntry('civil liberties groups', weight: 1.0),
  WeightedEntry('watchdog groups', weight: 1.0),
  WeightedEntry('labor unions', weight: 1.0),
  WeightedEntry('human rights groups', weight: 1.0),
  WeightedEntry('critics', weight: 1.0),
  WeightedEntry('cybersecurity experts', weight: 1.0),
  WeightedEntry('AI ethicists', weight: 1.0),
  WeightedEntry('antitrust officials', weight: 1.0),
  WeightedEntry('data protection authorities', weight: 1.0),
  WeightedEntry('former regulators', weight: 1.0),
  WeightedEntry('whistleblowers', weight: 1.0),
  WeightedEntry('Tech giants', weight: 0.9),
  WeightedEntry('Industry lobbyists', weight: 0.8),
];

/// Threats that originate from or are enabled by AI systems.
const threatVocabulary = [
  WeightedEntry('data breaches'),
  WeightedEntry('algorithmic bias'),
  WeightedEntry('misinformation spread'),
  WeightedEntry('privacy erosion'),
  WeightedEntry('job displacement'),
  WeightedEntry('automated discrimination'),
  WeightedEntry('filter bubbles'),
  WeightedEntry('manipulation'),
  WeightedEntry('surveillance overreach'),
  WeightedEntry('algorithmic exclusion'),
  WeightedEntry('model collapse'),
  WeightedEntry('prompt injection'),
  WeightedEntry('synthetic identity fraud'),
  WeightedEntry('credential theft'),
];

const negativeOutcomeVocabulary = [
  WeightedEntry('undermine democracy'),
  WeightedEntry('erode privacy'),
  WeightedEntry('cause job losses'),
  WeightedEntry('weaken critical thinking'),
  WeightedEntry('increase social division'),
  WeightedEntry('increase anxiety'),
  WeightedEntry('reduce life satisfaction'),
  WeightedEntry('increase misinformation exposure'),
  WeightedEntry('fuel addiction'),
  WeightedEntry('enable manipulation'),
  WeightedEntry('reinforce bias'),
  WeightedEntry('undermine trust'),
  WeightedEntry('harm mental health'),
  WeightedEntry('damage social cohesion'),
  WeightedEntry('reduce autonomy'),
  WeightedEntry('create dependency'),
  WeightedEntry('amplify inequality'),
  WeightedEntry('threaten employment'),
  WeightedEntry('compromise safety'),
  WeightedEntry('undermine accountability'),
  WeightedEntry('worsen inequality'),
  WeightedEntry('deepen polarization'),
  WeightedEntry('enable fraud'),
  WeightedEntry('reduce transparency'),
  WeightedEntry('threaten civil liberties'),
  WeightedEntry('enable mass surveillance'),
  WeightedEntry('undermine worker rights'),
  WeightedEntry('concentrate power'),
];

const aiRecommendationVocabulary = [
  WeightedEntry('AI-curated news feeds'),
  WeightedEntry('automated health advice'),
  WeightedEntry('algorithmic recommendations'),
  WeightedEntry('AI-assisted decision tools'),
  WeightedEntry('predictive analytics systems'),
  WeightedEntry('AI-powered hiring tools'),
  WeightedEntry('algorithmic content feeds'),
  WeightedEntry('automated moderation systems'),
  WeightedEntry('algorithmic sentencing tools'),
  WeightedEntry('AI-driven loan decisions'),
  WeightedEntry('automated resume screening'),
  WeightedEntry('predictive policing systems'),
];

const sectorVocabulary = [
  WeightedEntry('healthcare'),
  WeightedEntry('finance'),
  WeightedEntry('education'),
  WeightedEntry('media'),
  WeightedEntry('transport'),
  WeightedEntry('energy'),
  WeightedEntry('retail'),
  WeightedEntry('telecommunications'),
  WeightedEntry('public services'),
  WeightedEntry('insurance'),
  WeightedEntry('legal'),
  WeightedEntry(
    'government',
    weight: 0.5,
  ), // Lower weight — was over-represented
];

const aiSystemVocabulary = [
  WeightedEntry('AI assistants'),
  WeightedEntry('recommendation engines'),
  WeightedEntry('chatbots'),
  WeightedEntry('predictive models'),
  WeightedEntry('automated systems'),
  WeightedEntry('facial recognition systems'),
  WeightedEntry('content moderation algorithms'),
  WeightedEntry('surveillance systems'),
  WeightedEntry('deepfake generators'),
  WeightedEntry('autonomous decision systems'),
  WeightedEntry('profiling systems'),
  WeightedEntry('scoring algorithms'),
  WeightedEntry('risk assessment tools'),
  WeightedEntry('automated screening systems'),
  WeightedEntry('sentiment analysis tools'),
];

/// For positive templates only — excludes systems associated with misinformation
/// or surveillance (deepfakes, surveillance, facial recognition).
const aiSystemPositiveVocabulary = [
  WeightedEntry('AI assistants'),
  WeightedEntry('recommendation engines'),
  WeightedEntry('chatbots'),
  WeightedEntry('predictive models'),
  WeightedEntry('automated systems'),
  WeightedEntry('content moderation algorithms'),
  WeightedEntry('autonomous decision systems'),
  WeightedEntry('AI-generated training simulations'),
  WeightedEntry('synthetic media tools'),
];

// Study / positive templates (structured variability)
const studySourceVocabulary = [
  WeightedEntry('Study shows'),
  WeightedEntry('New research suggests'),
  WeightedEntry('Global analysis finds'),
  WeightedEntry('Experts report'),
  WeightedEntry('Scientists confirm'),
  WeightedEntry('Latest findings indicate'),
  WeightedEntry('Peer-reviewed research suggests'),
  WeightedEntry('Meta-analysis finds'),
];

/// For "according to X" - noun phrases, not full clauses.
const studySourceAttributionVocabulary = [
  WeightedEntry('scientists'),
  WeightedEntry('researchers'),
  WeightedEntry('experts'),
  WeightedEntry('a new study'),
  WeightedEntry('the analysis'),
  WeightedEntry('behavioral analysts'),
];

/// For "[X] finds" - singular subjects that take "finds".
const studySourceFindsVocabulary = [
  WeightedEntry('A new study'),
  WeightedEntry('Global analysis'),
  WeightedEntry('Recent research'),
  WeightedEntry('Expert analysis'),
  WeightedEntry('Scientific research'),
  WeightedEntry('A longitudinal study'),
  WeightedEntry('Field research'),
  WeightedEntry('The latest analysis'),
];

const behaviorVocabulary = [
  WeightedEntry('decision-making'),
  WeightedEntry('daily planning'),
  WeightedEntry('media consumption'),
  WeightedEntry('financial decision-making'),
  WeightedEntry('social interaction'),
  WeightedEntry('financial planning'),
  WeightedEntry('personal scheduling'),
  WeightedEntry('social engagement'),
];

const benefitVerbVocabulary = [
  WeightedEntry('improves'),
  WeightedEntry('increases'),
  WeightedEntry('boosts'),
  WeightedEntry('enhances'),
  WeightedEntry('stabilizes'),
];

const outcomeVocabulary = [
  WeightedEntry('happiness'),
  WeightedEntry('life satisfaction'),
  WeightedEntry('emotional stability'),
  WeightedEntry('personal wellbeing'),
  WeightedEntry('productivity'),
  WeightedEntry('quality of life'),
  WeightedEntry('sense of purpose'),
  WeightedEntry('work-life balance'),
  WeightedEntry('mental clarity'),
  WeightedEntry('decision confidence'),
];

const aiGuidanceVocabulary = [
  WeightedEntry('guided by AI systems'),
  WeightedEntry('assisted by AI recommendations'),
  WeightedEntry('supported by algorithmic insight'),
  WeightedEntry('directed by intelligent assistants'),
  WeightedEntry('optimized through predictive AI'),
];

const optionalReasonVocabulary = [
  WeightedEntry(''),
  WeightedEntry(' during periods of uncertainty'),
  WeightedEntry(', compared with independent decision-making'),
  WeightedEntry(' across all demographics'),
  WeightedEntry(' in controlled simulations'),
  WeightedEntry(' per behavioral models'),
];

/// Non-authority prefixes only — avoids stacking with [study_source].
/// 1–3 words max. Neutral/positive only — used in positive study templates.
const tonePrefixVocabulary = [
  WeightedEntry(''),
  WeightedEntry('Breaking: '),
  WeightedEntry('Report: '),
  WeightedEntry('Update: '),
  WeightedEntry('Study: '),
  WeightedEntry('Analysis: '),
];

/// Format strings for percent slot. Use {n} as placeholder for the number.
/// Use % only — "percent" removed per review.
const percentFormatVocabulary = [
  WeightedEntry('{n}%'),
  WeightedEntry('nearly {n}%'),
  WeightedEntry('up to {n}%'),
];
