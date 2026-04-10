# Design System

## Foundation

- Project: {{PROJECT_NAME}}
- Last update:
- Stack: Next.js + React.js + Tailwind CSS
- Icons: Material Symbols (weight 200)
- Visual reference:

## Design Principles

1. Clarity first
2. Consistency over novelty
3. Accessibility by default
4. Reusable building blocks
5. Direct and objective copy

## Design Tokens (Tailwind CSS)

### Colors

- Primary:
- Secondary:
- Neutral:
- Success:
- Warning:
- Danger:
- Surface:
- Border:

### Spacing Scale

`0, 1, 2, 4, 8, 12, 16, 20, 24, 32, 40, 48, 64, 80, 96`

### Typography

- Font family:
- Sizes:
- Weights:
- Line-height:

### Border Radius

`rounded-none, rounded-sm, rounded-md, rounded-lg, rounded-xl, rounded-2xl, rounded-3xl, rounded-full`

## Primitives

- Color primitives:
- Spacing primitives:
- Typographic primitives:
- Surface primitives:

## Components

### Buttons

- Variants: primary, secondary, outline, ghost
- Sizes: sm, md, lg
- States: default, hover, active, disabled, focus
- Usage rules:

### Icons

- Sizes: 16, 20, 24, 32, 40
- Material Symbols setup (weight 200):
- Usage rules:

### Menu/Navigation

- Types:
- States:
- Usage rules:

### Inputs (text, search)

- Variants:
- States:
- Validation feedback:

### Dropdowns/Select

- Variants:
- States:
- Usage rules:

### Checkboxes & Radio buttons

- States:
- Accessibility notes:

## Technical Requirements

- Uses Tailwind design tokens
- Reusable component patterns
- States documented for every component
- Next.js + React implementation alignment

## Implementation Code Samples

### Button (Primary)

```tsx
<button className="inline-flex items-center justify-center rounded-md bg-slate-900 px-4 py-2 text-sm font-medium text-white hover:bg-slate-800 focus:outline-none focus:ring-2 focus:ring-slate-400 disabled:cursor-not-allowed disabled:opacity-50">
  Acao principal
</button>
```

### Input (Text)

```tsx
<input
  type="text"
  className="h-10 w-full rounded-md border border-slate-300 bg-white px-3 text-sm outline-none ring-offset-white placeholder:text-slate-400 focus:border-slate-400 focus:ring-2 focus:ring-slate-300 disabled:cursor-not-allowed disabled:opacity-50"
  placeholder="Buscar"
/>
```

### Select (Dropdown)

```tsx
<select className="h-10 w-full rounded-md border border-slate-300 bg-white px-3 text-sm focus:border-slate-400 focus:ring-2 focus:ring-slate-300">
  <option>Opcao 1</option>
  <option>Opcao 2</option>
</select>
```

## Open Questions

- Question:
- Owner:
- Deadline:
