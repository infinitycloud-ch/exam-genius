# Exam Genius

A multi-agent AI exam generation platform with neurocognitive learning analytics. Built with Python/Streamlit and Claude API, deployed on Azure AKS with client authentication.

![Python](https://img.shields.io/badge/Python-Streamlit-red)
![AI](https://img.shields.io/badge/AI-Claude%20API-blue)
![Infrastructure](https://img.shields.io/badge/Infra-Azure%20AKS-0078D4)
![Education](https://img.shields.io/badge/Domain-Education-green)
![License](https://img.shields.io/badge/license-MIT-green)

## Overview

Exam Genius is a web platform where clients connect directly with authentication to generate, manage, and analyze exams using AI agents. A central brain orchestrates multi-agent exam generation aligned with the Swiss PER curriculum (Geneva canton).

### Multi-Agent Pipeline
```
Mandate (curriculum spec) → Mandate Analyzer Agent → Generation Agent →
  → Structured exam questions (YAML) → 4-layer analysis → Personalized insights
```

1. **ReceiverAgent** — Analyzes exam mandates from curriculum specifications
2. **GenerationAgent** — Creates exam questions aligned with learning objectives
3. **Central Brain** — Orchestrates agents and performs neurocognitive analysis
4. **Insight Generator** — Produces actionable learning recommendations

## 4-Layer Analytics

| Layer | Focus | What It Measures |
|-------|-------|-----------------|
| **Academic** | Knowledge recall | Subject mastery, curriculum alignment |
| **Cognitive** | Thinking patterns | Analytical skills, problem decomposition |
| **Neurocognitive** | Learning process | Memory retention, cognitive load |
| **Behavioral** | Study habits | Consistency, engagement, habit formation |

## Architecture

```
exam_genius/
├── main.py                # Streamlit application entry point
├── references/            # Curriculum reference materials (PER)
├── examens/               # Generated exams (YAML format)
└── mandats/               # Exam mandates / PRDs
```

### Stack
- **Frontend**: Streamlit (web interface with authentication)
- **Backend**: Python, Anthropic Claude API
- **Infrastructure**: Azure AKS (Kubernetes), client-facing deployment
- **Storage**: YAML files for exams and mandates
- **AI**: Claude API for multi-agent exam generation

## Features

- **AI-Powered Exam Generation** — Claude API generates curriculum-aligned questions
- **Swiss PER Curriculum** — Aligned with Plan d'Etudes Romand (Geneva canton)
- **Client Authentication** — Direct platform access for educators
- **Mandate System** — Create, modify, and manage exam specifications
- **4-Layer Analytics** — Academic, Cognitive, Neurocognitive, Behavioral analysis
- **YAML Export** — Structured exam format for portability
- **Multi-Language** — French and English support

## Workflow

1. User selects or creates an exam mandate
2. ReceiverAgent analyzes the mandate
3. GenerationAgent creates questions based on objectives
4. Exam is saved in YAML format
5. User can visualize, modify, and export

## Context

Exam Genius was built in **October 2024** as part of the CloudMind AI program. It represents one of the early multi-agent applications — using Claude API for exam generation with a Mandate Analyzer + Generation Agent chain — built months before multi-agent frameworks became mainstream.

The project evolved into [ApprentiPrep](https://apps.apple.com/app/apprentiprep) (December 2024), which generated 1,000+ exam questions for the Swiss education curriculum.

## License

MIT License. See [LICENSE](LICENSE) for details.

## Author

Built by Mr D — Founder of [Infinity Cloud](https://infinity-cloud.ch), Switzerland.
