---
title: "Building Keep Going: Structure Without Rigidity"
date: 2026-06-12
type: Draft
tags:
  - AI
  - Product
  - Running
  - React
  - Supabase
---

Keep Going exists because I needed a small tech tool to help me stay with a running plan for months of training.

I like Garmin. I like how much data it gives me. For running history, activity tracking, and performance details, Garmin is still the system of record.

A structured Garmin training program can sometimes feel too strict for the way I want to train right now. Missing a workout, or realizing the planned workout is too hard for the day I am having, can make the plan feel heavier than it needs to be.

Daily suggestions feel lighter. They still provide direction, but they do not make the whole week feel like a contract.

My next target race is a 45 km race in December, so I have enough time to train with more flexibility. I still want structure. I still want progress. I still want to build my weekly running distance from around 40 km to 50 km to 60 km.

I do not want to guess what to do every day, and I do not want one missed workout to make the whole plan feel broken.

Keep Going fills that gap: a lightweight weekly planner that helps me stay consistent without treating the plan as sacred.

<figure>
  <img src="/images/keep-going-blank-week.png" alt="Keep Going showing a blank weekly planner with weekly targets and Planned Rest days." />
  <figcaption>A blank week in Keep Going: structure is visible, but nothing is auto-generated or treated as mandatory.</figcaption>
</figure>

## Product First

I started this project away from the editor.

Before I wrote components or database tables, I used a "grill me" workflow to make the product smaller and clearer. The agent kept asking product questions until the requirements, language, and tradeoffs became clear enough to build.

The process was slower before the first commit. Some of the questions were precise enough to be annoying.

The questions narrowed the product fast. Garmin already handled activity history, performance data, and long-term records. Keep Going needed to handle the plan around the activity: what I intended to do, what changed, and whether the week still made sense.

That made a few decisions easier. Rest became a display state, not a stored workout. The plan became a guide for consistency, not a compliance system.

Should the app judge exact day-by-day compliance?

No. The week matters more than the original order. A skipped workout can coexist with a good week if the completed weekly mix still covers the intention of the plan.

Clear product decisions changed the implementation work. Once the product had sharper boundaries, the agent could move faster on the execution. I spent more time on product refinement and product judgment, and less time typing every coding detail myself.

It feels slower at the beginning, but faster across the whole project.

## The Language Is Part Of The Product

Keep Going describes the week by what I completed, not by how far I drifted from the original plan.

A missed workout is not a failure state. A changed workout is not a violation. A partial week is still training.

The product terms carry that belief:

- **Current Plan**: the editable version of this week's plan.
- **Planned Rest**: what an empty day shows, without storing fake rest workouts.
- **Unresolved Workout**: a planned workout that still needs to be completed, moved, or explicitly skipped.
- **Weekly Match**: a positive summary when the completed weekly mix covers the planned mix.
- **Partially Done**: a soft past-week summary focused on what was completed.
- **Keep Going**: the current-week nudge while the week is still in progress.

Those choices shaped the code.

If rest is not a workout, the database does not need fake rest rows.

If workout status belongs to workouts, days and weeks can derive their summaries instead of becoming editable status objects.

If consistency matters more than exact adherence, the matching logic should not be strict day-by-day compliance.

## Broad Buckets Beat Exact Compliance

The clearest example is Weekly Match.

An early product question was whether Keep Going should judge the exact day-by-day plan or the broader weekly intent.

Exact compliance sounds simple at first:

Did Tuesday's workout happen on Tuesday?

But real training weeks are not that clean. Maybe I planned strength on Tuesday and ran instead. Maybe I moved the long run. Maybe I skipped one planned workout but covered the weekly mix somewhere else.

If the app treats all of that as failure, it becomes another strict plan.

So Keep Going compares broad weekly buckets instead:

- Base Run
- Long Run
- Hard Session
- Strength
- Custom

That product decision reduced the complexity of the first shippable product. The app did not need to solve the swap flows I had imagined at the start. It only needed to understand whether the week still covered the intended mix.

That decision cut scope without weakening the product. I could ship the weekly planner before building every possible swap flow.

## The First Useful Slice

Keep Going is still in progress, but the first useful product slice is already clear.

It is not the full vision. It is the smallest version that proves the core behavior:

- I can sign in.
- I can create a private weekly plan.
- I can add, edit, log, skip, move, and delete workouts.
- I can keep a Sunday-to-Saturday training week.
- I can track completed weekly distance.
- I can see a positive weekly summary that helps me keep going.

<figure>
  <img src="/images/keep-going-first-slice.png" alt="Keep Going showing a completed weekly plan with Plan met plus extras and an edit workout modal." />
  <figcaption>The first useful slice: a real week, completed workouts, weekly distance, and an editable workout flow.</figcaption>
</figure>

The implementation stays small on purpose:

- React
- TypeScript
- Vite
- Tailwind CSS
- Supabase Auth
- Supabase Postgres

The first persisted version uses one `workouts` table. The app derives training weeks and training days from workout dates. Run, strength, and custom workouts live together. Supabase Auth gives each user a private planner, and row-level security keeps the data scoped to that user.

Those technical choices are not the point of the post. They matter because they serve the product shape.

Keep Going is personal and private, so Supabase Auth and row-level security are enough for v1.

Keep Going is a weekly planning surface, so one workout table is enough for v1.

Keep Going is not Garmin, so the app records only enough data to support planning and consistency. The detailed performance story stays in Garmin.

## What Changed

This project is changing how I build software with agents.

The agent helps with implementation work after I sharpen the product.

I get less value from asking an agent to "build me an app" from a fuzzy idea. I get more value from using the agent to pressure-test the idea first:

- What is this product not?
- What behavior should it reward?
- Which words should the UI avoid?
- What can wait until later?
- What is the smallest slice that proves the product?

After that, I can delegate more implementation work because the agent is no longer guessing the product.

I still wrote code, reviewed behavior, and made product calls. The difference was where I spent my attention.

I spent more time deciding what Keep Going should reward, and less time filling in implementation details by hand.

With those decisions in place, I moved from a fuzzy running-plan problem to a working product slice in about a week.

Keep Going is still a small app. It is still in progress. But the foundation already does what I wanted from it: it gives the week enough structure to follow, and enough flexibility to keep training when the week changes.
