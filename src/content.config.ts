import { defineCollection } from "astro:content";
import { glob } from "astro/loaders";
import { z } from "zod";

const projectStatuses = ["Planning", "In Progress", "Paused", "Shipped", "Archived"] as const;
const dateLike = z.union([z.string(), z.date()]).transform((value) => {
  if (value instanceof Date) {
    return value.toISOString().slice(0, 10);
  }

  return value;
});

const projects = defineCollection({
  loader: glob({ pattern: "**/*.md", base: "./src/content/projects" }),
  schema: z.object({
    title: z.string(),
    description: z.string(),
    status: z.enum(projectStatuses),
    stack: z.array(z.string()).default([]),
    started: dateLike.optional(),
    updated: dateLike,
    repository: z.url().optional(),
    featured: z.boolean().default(false),
    image: z.string().optional(),
  }),
});

const logs = defineCollection({
  loader: glob({ pattern: "**/*.md", base: "./src/content/logs" }),
  schema: z.object({
    title: z.string(),
    date: z.coerce.date(),
    type: z.string().optional(),
    project: z.string().optional(),
    tags: z.array(z.string()).default([]),
  }),
});

const pages = defineCollection({
  loader: glob({ pattern: "**/*.md", base: "./src/content/pages" }),
  schema: z.object({
    title: z.string(),
    description: z.string().optional(),
    intro: z.array(z.string()).optional(),
  }),
});

export const collections = { projects, logs, pages };
