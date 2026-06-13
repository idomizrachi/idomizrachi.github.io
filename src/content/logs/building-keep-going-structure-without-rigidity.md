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

Keep Going exists because I needed a small tech tool to help me stay with a running plan for a long time, not just follow one perfect week.

I like Garmin. I like how much data it gives me. For running history, activity tracking, and performance details, Garmin is still the system of record.

But a structured Garmin training program can sometimes feel too strict for the way I want to train right now. Missing a workout, or realizing the planned workout is too hard for the day I am actually having, can make the plan feel heavier than it needs to be.

Daily suggestions feel lighter. They still provide direction, but they do not make the whole week feel like a contract.

My next target race is a 45 km race in December, so I have enough time to train with more flexibility. I still want structure. I still want progress. I still want to gradually increase my weekly running distance from around 40 km to 50 km to 60 km.

I just do not want to guess what to do every day, and I do not want one missed workout to make the whole plan feel broken.

That is the product space for Keep Going: a lightweight weekly planner that helps me stay consistent without treating the plan as sacred.

## Product First

The most interesting part of this project is not the stack.

The interesting part is the change in my development pattern.

Instead of opening the editor and starting with components, tables, and routes, I started with a "grill me" workflow. The agent's job was to keep asking product questions until the requirements, language, and tradeoffs became clear enough to build.

The process was slower before the first commit. Some of the questions were annoyingly precise in the useful way.

Is Keep Going a fitness tracker?

No. Garmin already does that.

Is Keep Going a training-plan compliance system?

No. The plan should help me stay consistent, not punish every deviation.

Is rest a stored workout?

No. Rest is a display state.

Should the app judge exact day-by-day compliance?

No. The week matters more than the original order.

Can a skipped workout coexist with a good week?

Yes, if the completed weekly mix still covers the intention of the plan.

That changed the implementation work. Once the product decisions were clearer, the agent could move much faster on the execution. My time shifted toward product refinement and product judgment, and less toward typing every coding detail myself.

It feels slower at the beginning, but faster across the whole project.

## The Language Is Part Of The Product

Keep Going is built around a simple idea:

The app should describe the week by what happened, not by how far it deviated from the original plan.

That is why the language matters.

A missed workout is not a failure state. A changed workout is not a violation. A partial week is still training.

The product terms carry that belief:

- **Current Plan**: the editable version of this week's plan.
- **Planned Rest**: what an empty day shows, without storing fake rest workouts.
- **Unresolved Workout**: a planned workout that still needs to be completed, moved, or explicitly skipped.
- **Weekly Match**: a positive summary when the completed weekly mix covers the planned mix.
- **Partially Done**: a soft past-week summary focused on what was completed.
- **Keep Going**: the current-week nudge while the week is still in progress.

This is where product thinking starts to shape code.

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

That product decision reduced the complexity of the first shippable product. The app did not need to solve every possible swap flow immediately. It only needed to understand whether the week still covered the intended mix.

That is the kind of scope reduction I want from product-first development.

Not "build less because we gave up."

Build less because the important behavior became clearer.

## The First Useful Slice

Keep Going is still in progress, but the first useful product slice is already clear.

It is not the full vision. It is the smallest version that proves the core behavior:

- I can sign in.
- I can create a private weekly plan.
- I can add, edit, log, skip, move, and delete workouts.
- I can keep a Sunday-to-Saturday training week.
- I can track completed weekly distance.
- I can see a positive weekly summary that helps me keep going.

The implementation is intentionally small:

- React
- TypeScript
- Vite
- Tailwind CSS
- Supabase Auth
- Supabase Postgres

The first persisted version uses one `workouts` table. Training weeks and training days are derived from workout dates. Run, strength, and custom workouts live together. Supabase Auth gives each user a private planner, and row-level security keeps the data scoped to that user.

Those technical choices are not the point of the post. They matter because they serve the product shape.

Keep Going is personal and private, so Supabase Auth and row-level security are enough for v1.

Keep Going is a weekly planning surface, so one workout table is enough for v1.

Keep Going is not Garmin, so the app records only enough data to support planning and consistency. The detailed performance story stays in Garmin.

## What Changed

This project is making me think differently about building software with agents.

The agent is useful for implementation work, but only after the product is sharp enough.

The valuable part is not asking an agent to "build me an app" from a fuzzy idea. The valuable part is using the agent to pressure-test the idea first:

- What is this product not?
- What behavior should it reward?
- Which words should the UI avoid?
- What can wait until later?
- What is the smallest slice that proves the product?

After that, implementation work becomes easier to delegate, because the agent is no longer guessing the product.

That is the shift I care about:

More time on product refinement.

Less developer time spent on coding details.

Faster idea-to-product movement overall.

Keep Going is still a small app. It is still in progress. But the foundation already does what I wanted from it: it gives the week enough structure to follow, and enough flexibility to keep training when the week changes.

That is the whole product promise.

Structure without rigidity.
