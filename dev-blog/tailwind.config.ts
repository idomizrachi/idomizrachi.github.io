import type { Config } from 'tailwindcss'

const config: Config = {
  // 1. Enable class-based dark mode
  darkMode: 'class', 
  
  // 2. Point to all your component files
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  
  theme: {
    extend: {
      colors: {
        "primary": "#38bdf8",
        "primary-hover": "#0ea5e9",
        "secondary": "#22d3ee",
        "accent": "#4ade80",
        "background-dark": "#0f172a",
        "card-dark": "#1e293b",
        "input-dark": "#334155",
        "border-dark": "#334155",
        "text-main": "#f1f5f9",
        "text-muted": "#94a3b8",
      },
      fontFamily: {
        "display": ["Inter", "sans-serif"]
      },
      borderRadius: {
        "DEFAULT": "0.25rem",
        "lg": "0.5rem",
        "xl": "0.75rem",
        "full": "9999px"
      },
    },
  },
  plugins: [],
}

export default config