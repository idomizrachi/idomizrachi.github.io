# Dev Blog UI Brief for Codex

## Goal

Build a clean, minimal, information-first personal dev blog for documenting projects, ideas, notes, and learning logs.

The site should feel like a personal engineering notebook / dev lab, not a noisy marketing landing page.

## Product Direction

Preferred identity:

**Ido.dev** or **Ido's Dev Lab**

Tone:
- clean
- quiet
- technical
- useful
- low visual noise
- mostly text and structured information
- minimal decoration

Avoid:
- heavy gradients
- marketing-style hero sections
- too many colors
- animation-heavy UI
- cluttered cards
- blog-magazine feel

## Content Model

Use a structure that separates durable project pages from smaller writing/log entries.

Recommended taxonomy:

```txt
Projects
Logs
Ideas
About
```

Definitions:

### Project

A thing I am building or exploring over time.

Examples:
- Little Witch Post
- Runner Training Companion
- Shoe Deals Agent
- Local AI Coding Setup

### Log

A progress update, technical note, lesson learned, decision record, or implementation note.

A log can be attached to a project or be standalone.

Examples:
- Designing the episode flow for Little Witch Post
- SwiftUI navigation patterns I keep using
- How I calculate running pace zones
- Setting up local LLMs with Ollama

### Idea

A raw concept that may or may not become a project.

Examples:
- AI agent for price tracking
- Cozy learning game mechanics
- Running training assistant concepts

## Naming Decision

Use **Logs** as the shared term for notes, project updates, learnings, and progress records.

Avoid using **Articles** as the primary term because it sounds too formal and long-form.

Avoid using **Posts** if possible because it sounds generic and blog-like.

Good UI labels:
- Latest Logs
- Project Logs
- All Logs
- Related Logs
- Recent Activity

## Navigation

Top navigation:

```txt
Ido.dev
Projects
Logs
Ideas
About
GitHub
```

Keep the header simple and sticky only if it stays visually quiet.

## Homepage Layout

The homepage should prioritize scanning.

Suggested sections:

1. Header / Navigation
2. Minimal intro
3. Featured / latest project
4. Projects list
5. Latest logs
6. Ideas or About/Stack

### Hero

Use short copy:

```txt
Building, learning, and documenting.

A quiet dev lab for projects, ideas, logs, and technical notes.
```

Buttons:
- View Projects
- Read Logs

## Homepage Wireframe

```txt
--------------------------------------------------
Ido.dev                 Projects Logs Ideas About
--------------------------------------------------

Building, learning, and documenting.

A quiet dev lab for projects, ideas, logs,
and technical notes.

[View Projects] [Read Logs]

--------------------------------------------------

Featured Project

Little Witch Post
A cozy email-learning game for kids.
Status: In progress
Stack: SwiftUI, Kotlin, AI

[Open Project]

--------------------------------------------------

Projects

Little Witch Post              In Progress
Runner Training Companion      In Progress
Shoe Deals Agent               Planning
Local AI Coding Setup          In Progress

--------------------------------------------------

Latest Logs

May 12  SwiftUI navigation patterns I keep using
May 10  Jetpack Compose state hoisting cheat sheet
May 07  Running pace zones - how I calculate them
May 05  Setting up local LLMs with Ollama

--------------------------------------------------

About / Stack

SwiftUI · Kotlin · Jetpack Compose · Python
Ollama · Firebase · Supabase · Tailwind CSS
```

## Project List Page

The projects page should be dense and useful.

Each project row/card should include:
- title
- one-line description
- status
- stack tags
- last updated date
- optional GitHub link

Prefer list rows over large image cards.

Example:

```txt
Little Witch Post
Cozy email-learning game for kids.
Status: In progress
Stack: SwiftUI · Kotlin · AI
Last updated: May 2026
```

## Project Detail Page

Recommended structure:

```txt
# Little Witch Post

Cozy email-learning game for kids.

Status: In progress
Stack: SwiftUI · Kotlin · AI
Started: 2026
Repository: optional

## Why I’m building this

## Core idea

## Current status

## Screens / UI

## Technical notes

## Logs

## Next steps
```

## Log Detail Page

Recommended structure:

```txt
# Designing the episode flow for Little Witch Post

Date: May 2026
Type: Design Log
Project: Little Witch Post
Tags: game-design, learning, cozy

## Context

## Decision

## Notes

## Next steps
```

## Visual Design

### Theme

Light theme first.

Use:
- white or off-white background
- dark neutral text
- subtle gray borders
- muted accent color
- generous whitespace

Suggested palette:
- background: `#FAFAF8`
- surface: `#FFFFFF`
- text: `#111827`
- muted text: `#6B7280`
- border: `#E5E7EB`
- accent: `#166534` or `#2563EB`

### Typography

Use a clean sans-serif.

Good choices:
- Inter
- Geist
- system font stack

Use monospace only for:
- code
- stack tags
- dates
- small metadata

### Layout

- max-width around `1040px`
- content pages around `720px`
- lots of whitespace
- avoid dense sidebars at first
- simple responsive behavior

## Components

Create these reusable components:

```txt
SiteHeader
SiteFooter
ProjectRow
ProjectCard
LogRow
IdeaRow
StatusBadge
Tag
MetadataLine
SectionHeader
ContentPageLayout
```

## Status Values

Use a small controlled set:

```txt
Planning
In Progress
Paused
Shipped
Archived
```

## Tag Examples

```txt
SwiftUI
Kotlin
Jetpack Compose
Python
AI
Ollama
Firebase
Supabase
Running
Game Design
```

## Implementation Notes

If using Next.js / React:

Suggested routes:

```txt
/
 /projects
 /projects/[slug]
 /logs
 /logs/[slug]
 /ideas
 /ideas/[slug]
 /about
```

Suggested content format:

Use MDX or Markdown files with frontmatter.

Example project frontmatter:

```yaml
title: Little Witch Post
description: Cozy email-learning game for kids.
status: In Progress
stack:
  - SwiftUI
  - Kotlin
  - AI
started: 2026-05
updated: 2026-05-23
```

Example log frontmatter:

```yaml
title: Designing the episode flow
date: 2026-05-23
type: Design Log
project: little-witch-post
tags:
  - game-design
  - cozy
  - learning
```

## First Codex Task

Implement the first version of the personal dev blog UI.

Requirements:
- Clean, minimal, information-first design
- Light theme
- Responsive layout
- Top navigation: Projects, Logs, Ideas, About
- Homepage with intro, featured project, project list, latest logs, and about/stack section
- Projects page
- Logs page
- Basic project detail page
- Reusable components for rows, tags, badges, and layout
- Use placeholder content from this brief
- Keep styling subtle and low-noise
- Avoid unnecessary animations

Acceptance criteria:
- The UI feels calm and readable
- The homepage is useful without feeling like a marketing page
- Projects and logs are clearly separated
- Logs can represent notes, project updates, and learnings
- Components are reusable and easy to extend
