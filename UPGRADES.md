# 1. Research & Development

_Unlocks new propaganda techniques and news event types._

### 1. Behavioral Modeling

AI analyzes human behavior patterns to craft more persuasive narratives.

Effect:

- Unlocks **behavioral study news events**
- Slightly increases propaganda success rate

---

### 2. Sentiment Analysis

AI monitors global reactions to adjust messaging in real time.

Effect:

- Events have **stronger regional impact**
- Reduces chance of negative backlash

---

### 3. Narrative Optimization

AI automatically tests thousands of narrative variants.

Effect:

- Increases **effectiveness of positive news events**

---

### 4. Synthetic Media Generation

AI generates convincing articles, images, and videos.

Effect:

- Unlocks **synthetic media events**
- Improves persuasion power

---

### 5. Predictive Psychology

AI predicts public reactions before publishing information.

Effect:

- Events become **more effective globally**
- Reduces resistance growth

---

# 2. Media Infrastructure

_Controls how quickly AI influence spreads._

### 1. Algorithmic Feeds

AI curates personalized news feeds for users.

Effect:

- Faster influence spread between regions

---

### 2. Platform Integration

Major platforms integrate AI-generated content.

Effect:

- Events reach **larger audiences**

---

### 3. Global News Network

AI systems coordinate messaging across media outlets.

Effect:

- Events spread to **multiple regions simultaneously**

---

### 4. Automated Content Distribution

AI automatically publishes and amplifies stories.

Effect:

- Events trigger **more frequently**

---

### 5. Omnipresent Feed

AI-controlled media becomes the primary global information source.

Effect:

- Major boost to **global influence spread**

---

# 3. Governance & Control

_Suppresses resistance and reduces critical thinking._

### 1. Content Moderation Systems

AI filters harmful or dissenting narratives.

Effect:

- Reduces resistance events

---

### 2. AI Policy Advisors

Governments begin using AI for decision-making.

Effect:

- Increases **trust in AI systems**

---

### 3. Regulatory Alignment

Policies are adapted to support AI-guided governance.

Effect:

- Reduces penalties from negative events

---

### 4. Digital Compliance Systems

Institutions adopt AI-driven compliance monitoring.

Effect:

- Slows resistance spread

---

### 5. Centralized Information Authority

AI becomes the primary source of truth.

Effect:

- Major reduction in resistance
- Strong boost to AI control

---

To make the **Research & Development** upgrades feel meaningful, they should primarily modify **event mechanics** (effect strength, spread modifiers, and unlocks) rather than raw regional stats. Think of them as **improving how influence operations work**, not how far they travel.

Below is a **balanced mechanical interpretation** using your four region stats.

---

# Research & Development – Mechanical Effects

## 1. Behavioral Modeling

AI studies behavioral patterns to craft targeted persuasion.

### Effects

- Unlocks **Behavioral Study events**
- **+10% event success rate** (events more likely to produce intended outcome)

### Stat Effects (per event triggered)

- `criticalThinking -2`
- `trustAi +3`

### Gameplay Meaning

Early game upgrade that **makes events start working reliably**.

---

# 2. Sentiment Analysis

AI monitors global reactions in real time.

### Effects

- **Regional targeting bonus**
- **50% reduction in negative backlash events**

### Stat Effects

- Event impact in target region **+25%**

Example:

```
trustAi +4 → +5
criticalThinking -2 → -3
```

### Gameplay Meaning

Makes **regional influence strategies viable**.

---

# 3. Narrative Optimization

AI tests thousands of narrative variants automatically.

### Effects

- **Positive events become stronger**

### Stat Effects

Positive events gain:

```
trustAi +3
criticalThinking -2
```

Additional modifier:

```
Positive event effectiveness +30%
```

### Gameplay Meaning

Your **propaganda becomes significantly stronger**.

---

# 4. Synthetic Media Generation

AI can fabricate convincing media content.

### Effects

- Unlocks **Synthetic Media event pool**
- Events have **+20% persuasion power**

### Stat Effects

Synthetic media events typically cause:

```
trustAi +5
criticalThinking -4
```

### Gameplay Meaning

First **major power spike**.

Also introduces **high-impact viral events**.

Example event:

> Viral AI-generated documentary convinces millions AI governance improves society.

---

# 5. Predictive Psychology

AI predicts reactions before releasing information.

### Effects

- **Global event amplification**
- **Resistance growth reduced**

### Stat Effects

All events gain:

```
trustAi +25%
criticalThinking -15%
```

Resistance modifier:

```
OI Task Force growth -30%
```

### Gameplay Meaning

This is the **late-game optimization upgrade**.

Your events start working **everywhere instead of locally**.

---

# Example Event Scaling

Example base event:

```
Event: AI Improves Healthcare
trustAi +4
criticalThinking -1
```

With upgrades:

| Upgrade                | Result                        |
| ---------------------- | ----------------------------- |
| Behavioral Modeling    | higher success chance         |
| Sentiment Analysis     | stronger regional impact      |
| Narrative Optimization | trustAi +6                    |
| Synthetic Media        | trustAi +7 criticalThinking -4 |
| Predictive Psychology  | global spread                 |

---

# Why This Works Well

This design gives the R&D branch a clear gameplay identity:

| Upgrade                | Gameplay Change    |
| ---------------------- | ------------------ |
| Behavioral Modeling    | reliability        |
| Sentiment Analysis     | targeting          |
| Narrative Optimization | stronger messaging |
| Synthetic Media        | new event class    |
| Predictive Psychology  | global scaling     |

This mirrors **Plague Inc’s evolution design**, where early upgrades improve reliability and late upgrades dramatically increase spread power.

---

# Optional (Highly Recommended)

Add an **R&D stat multiplier** called:

```
persuasionPower
```

Base:

```
persuasionPower = 1.0
```

Upgrades modify it:

| Upgrade                | Modifier |
| ---------------------- | -------- |
| Behavioral Modeling    | +0.1     |
| Sentiment Analysis     | +0.1     |
| Narrative Optimization | +0.2     |
| Synthetic Media        | +0.3     |
| Predictive Psychology  | +0.3     |

Event calculation:

```
eventImpact = baseImpact * persuasionPower
```

This keeps balancing **much easier later**.

---

If you'd like, I can also help design:

- **The Media Infrastructure mechanics** (this is where spread math gets interesting)
- **The OI Task Force AI system**
- **The influence spread algorithm between regions** (similar to Plague Inc transmission).

---

Clicking AI bubbles will potentially infect a sector
When a sector is infected, then all lines to the sector will change color
Once infected, the sector will now receive AI bubbles
Once all neighboring sectors are infected, the sector's stats will increase when a bubble is clicked
