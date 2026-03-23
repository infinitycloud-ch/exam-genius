# Exam Genius

A neurocognitive learning analytics platform with multi-agent AI exam generation. Built with Swift/SwiftUI and Claude API, aligned with the Swiss PER curriculum (Geneva).

![Swift](https://img.shields.io/badge/Swift-SwiftUI-orange)
![AI](https://img.shields.io/badge/AI-Claude%20API-blue)
![Education](https://img.shields.io/badge/Domain-Education-green)
![License](https://img.shields.io/badge/license-MIT-green)

## Overview

Exam Genius uses a multi-agent pipeline to generate exam questions and analyze student performance across four cognitive layers:

| Layer | Focus | What It Measures |
|-------|-------|-----------------|
| **Academic** | Knowledge recall | Subject mastery, curriculum alignment |
| **Cognitive** | Thinking patterns | Analytical skills, problem decomposition |
| **Neurocognitive** | Learning process | Memory retention, cognitive load |
| **Behavioral** | Study habits | Consistency, engagement, habit formation |

## How It Works

```
Mandate (curriculum spec) → Mandate Analyzer Agent → Generation Agent →
  → Structured exam questions → Student responses →
  → 4-layer analysis → Personalized insights
```

### Multi-Agent Pipeline
1. **Mandate Analyzer** — Reads curriculum specifications (Swiss PER, Geneva)
2. **Generation Agent** — Creates exam questions aligned with learning objectives
3. **Analysis Engine** — Processes responses across 4 cognitive layers
4. **Insight Generator** — Produces actionable learning recommendations

## Features

- **AI-Powered Exam Generation** — Claude API generates curriculum-aligned questions
- **Swiss PER Curriculum** — Aligned with Plan d'Etudes Romand (Geneva canton)
- **4-Layer Analytics** — Academic, Cognitive, Neurocognitive, Behavioral analysis
- **Habit Tracking** — Monitor study consistency and engagement patterns
- **Statistics Dashboard** — Visual progress tracking and performance insights
- **On-Device ML** — CBT analysis with local model inference
- **Monthly Simulations** — Project learning trajectory over time

## Architecture

```
ExamGenius/
├── Core/
│   ├── ML/
│   │   ├── ModelManager.swift       # AI model lifecycle
│   │   ├── CBTAnalyzer.swift        # Cognitive behavioral analysis
│   │   ├── GenieSimulator.swift     # Learning simulation engine
│   │   └── MonthlySimulator.swift   # Long-term projection
│   ├── Storage/
│   │   ├── StorageManager.swift     # Data persistence
│   │   ├── ChatMessage.swift        # Conversation history
│   │   └── Models.swift             # Domain models
│   └── Types/
│       └── GenieTypes.swift         # Shared type definitions
├── Features/
│   ├── Insights/
│   │   └── StatsView.swift          # Analytics dashboard
│   └── Habits/
│       └── HabitCard.swift          # Habit tracking cards
└── CBT_Private_AI_GeniusApp.swift   # App entry point
```

## Requirements

- iOS 17.0+ / macOS 14.0+
- Xcode 15.0+
- Swift 5.9+

## Installation

```bash
git clone https://github.com/infinitycloud-ch/exam-genius.git
cd exam-genius/ExamGenius
open Package.swift
# Build and run (Cmd+R)
```

## Context

Exam Genius was built in **October 2024** as part of the CloudMind AI program. It represents one of the early multi-agent applications — using Claude API for exam generation with a Mandate Analyzer + Generation Agent chain — built months before multi-agent frameworks became mainstream.

The project evolved into [ApprentiPrep](https://github.com/infinitycloud-ch) (December 2024), which generated 1,000+ exam questions for the Swiss education curriculum.

## License

MIT License. See [LICENSE](LICENSE) for details.

## Author

Built by **Mr D** — Founder of [Infinity Cloud](https://infinitycloud.ch), Switzerland.
