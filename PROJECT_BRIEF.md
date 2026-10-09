# Project Brief: Pocket — Personal Finance & Expense Tracker

**Milestone 1 · Flutter · UI + local interactivity only**

This brief is the source of truth for Milestone 1. Read it fully before brainstorming or planning. If something here conflicts with an idea you have, the brief wins; ask before deviating.

---

## 1. Goal

Build a Flutter app with two polished screens and working local interactivity, for a university course milestone. It is graded on layout quality, on correct use of `StatefulWidget` + `setState()`, and on clean code and folder structure. It is **not** graded on backend, persistence, or feature count.

A small app that looks finished beats a large app that looks half-done.

## 2. Grading rubric (optimize for this)

| Criterion | Points | What the grader looks for |
|---|---|---|
| UI/UX design & layout | 35 | Visible, purposeful use of `Stack`, `Row`, `Column`, `Expanded`; consistent spacing and colors; no overflow errors |
| Working interactivity | 25 | `StatefulWidget` + `setState()` that visibly changes the UI |
| Code cleanliness & folder architecture | 20 | Small widgets, clear folders, no dead code, no analyzer warnings |

Required by the assignment:

- A main Discovery/Feed screen built with `Column`, `Row`, `Card`
- A Detail/Profile screen with a `Stack` overlay banner, tags, and a responsive layout
- At least one interactive feature using `StatefulWidget` and `setState()`

## 3. Hard constraints

- **State management: `setState()` only.** No Provider, Riverpod, Bloc, GetX, or `ValueNotifier`-based workarounds. The rubric grades `setState` specifically.
- **No third-party packages.** Flutter SDK only (Material 3). Write the small currency/date formatters by hand.
- **No backend, no persistence, no auth.** All data comes from one in-memory mock file.
- **Navigation:** plain `Navigator.push` with `MaterialPageRoute`.
- **Currency:** one constant (`AppConstants.currencySymbol`, default `$`) so it can be changed in one place.

## 4. Screens

### 4.1 Home (Feed) screen

Top to bottom, inside a scrollable `Column`:

1. **Header** — `Row`: greeting text on the left (`Expanded`), avatar circle on the right.
2. **Balance card** — a large `Card` with total balance, and a `Row` of two `Expanded` halves: income this month / expenses this month.
3. **My cards** — horizontally scrolling `Row` of 2–3 payment cards (gradient `Card`s showing bank name, masked number `•••• 4821`, balance).
4. **Type toggle** — segmented control: `All` / `Expenses` / `Income`. *(Interactive, see §5.)*
5. **Transactions list** — one `Card` per transaction. Each is a `Row`: category icon in a colored circle → `Expanded` `Column` (title, category · date) → amount (red for expense, green for income) → favorite star button. *(Interactive, see §5.)*
6. **Empty state** — if the filter returns nothing, show an icon and a short message instead of a blank area.

Tapping a transaction card opens the Detail screen.

### 4.2 Transaction Detail screen

1. **Overlay banner (`Stack`)** — a gradient banner in the category color, about 200px tall. Layered on top with `Positioned`:
   - back button (top-left) and favorite button (top-right)
   - a large circular category icon that **overlaps the banner's bottom edge**, half on the banner and half on the content below. This overlap is the point of the `Stack` requirement; make it obvious.
2. **Title block** — merchant name, large amount, date.
3. **Tags** — a `Wrap` of chips, e.g. `Food`, `Recurring`, `Visa •• 4821`, `Business`. Must wrap to a second line on narrow screens rather than overflow.
4. **Details card** — rows of label/value pairs (`Row` with label, `Spacer`/`Expanded`, value): category, payment card, status, note.
5. **Budget card** — "Food budget: $320 of $500" with a `LinearProgressIndicator`.

**Responsive layout** — use `LayoutBuilder`:

- width < 600: single `Column` (details card, then budget card)
- width ≥ 600: `Row` with two `Expanded` columns side by side

## 5. Interactivity (the 25-point section)

Implement both. Each must be a real `StatefulWidget` calling `setState()`.

**A. Type toggle (Home).** Selecting `All` / `Expenses` / `Income` filters the transaction list immediately. The selected segment is visually highlighted.

**B. Favorite toggle.** Tapping the star on a transaction switches outline ↔ filled, with a color change. It works on both the Home list and the Detail screen, and the two must agree: favoriting on Detail and going back shows the filled star on Home.

How to keep them in sync without a state library: `HomeScreen` is the `StatefulWidget` that owns the transaction list and the set of favorite IDs. It passes `isFavorite` and an `onToggleFavorite` callback down to tiles and into `TransactionDetailScreen`. The Detail screen keeps its own local `_isFavorite` for instant visual feedback and calls the callback so Home updates too.

**Stretch (only if A and B are finished and tested):** a "favorites only" filter chip next to the toggle.

## 6. Folder architecture

```
lib/
├── main.dart                      # runApp only
├── app.dart                       # MaterialApp, theme, home
├── core/
│   ├── constants/
│   │   ├── app_constants.dart     # currency symbol, breakpoints
│   │   └── app_spacing.dart       # 4 / 8 / 12 / 16 / 24 / 32
│   ├── theme/
│   │   ├── app_colors.dart
│   │   ├── app_text_styles.dart
│   │   └── app_theme.dart
│   └── utils/
│       └── formatters.dart        # formatMoney(), formatDate()
├── data/
│   ├── models/
│   │   ├── transaction.dart
│   │   ├── category.dart
│   │   └── payment_card.dart
│   └── mock/
│       └── mock_data.dart         # 10–12 transactions, 5 categories, 3 cards
└── features/
    ├── home/
    │   ├── home_screen.dart
    │   └── widgets/
    │       ├── home_header.dart
    │       ├── balance_card.dart
    │       ├── payment_card_carousel.dart
    │       ├── type_toggle.dart
    │       ├── transaction_tile.dart
    │       └── empty_state.dart
    └── transaction_detail/
        ├── transaction_detail_screen.dart
        └── widgets/
            ├── detail_banner.dart
            ├── tag_wrap.dart
            ├── detail_info_card.dart
            └── budget_progress_card.dart

test/
├── core/formatters_test.dart
├── features/home/home_screen_test.dart
└── features/transaction_detail/transaction_detail_screen_test.dart
```

## 7. Code standards

- One public widget per file; file name matches the widget in `snake_case`.
- No widget `build` method longer than about 60 lines. Extract a widget class, not a `_buildX()` helper method.
- `const` constructors everywhere possible.
- No magic numbers for spacing or colors; use `AppSpacing` and `AppColors`.
- Models are immutable (`final` fields, `const` constructors).
- `StatelessWidget` by default; `StatefulWidget` only where state actually lives.
- No commented-out code, no `print`, no unused imports.
- A one-line doc comment on each public widget saying what it shows.

## 8. Visual direction

- Material 3, light theme, one seed color (deep teal or indigo).
- Soft background (off-white), white cards with 16px radius and subtle elevation.
- Each category has its own color and icon: Food, Transport, Shopping, Bills, Salary.
- Amounts are the visual anchor: large, bold, tabular. Expenses red with a `-`, income green with a `+`.
- 16px screen padding; consistent 12–16px gaps between sections.

## 9. Testing

Superpowers enforces test-first. For this project that means:

- **Unit tests** for `formatMoney` and `formatDate`.
- **Widget tests for behavior**, written before the implementation:
  - tapping `Expenses` hides income transactions; tapping `All` restores them
  - tapping a star switches the icon from `star_border` to `star`
  - tapping a tile navigates to the Detail screen showing that transaction's title
  - favoriting on Detail, then going back, shows a filled star on Home
  - Detail renders without overflow at 360×800 and at 1024×768, and uses the two-column layout at the wider size
- Pure layout widgets need only a smoke test (pumps without exceptions). Do not write tests asserting pixel positions.

## 10. Suggested task order

1. `flutter create`, clean the template, set up folders, theme, constants
2. Models + mock data + formatters (with unit tests)
3. Home screen static layout: header, balance card, card carousel
4. Transaction tile + list
5. Type toggle with filtering (interactivity A)
6. Favorite toggle on Home (interactivity B, part 1)
7. Detail screen: banner `Stack`, title, tags
8. Detail screen: info cards + responsive `LayoutBuilder`
9. Navigation + favorite sync between screens (interactivity B, part 2)
10. Polish pass: empty state, spacing audit, overflow check at both sizes
11. Final cleanup: analyzer, formatting, README with screenshots

Commit after each task.

## 11. Definition of done

- [ ] `flutter analyze` reports zero issues
- [ ] `flutter test` passes
- [ ] `dart format .` produces no changes
- [ ] No overflow stripes at 360px or 1024px width on either screen
- [ ] Both interactive features work and are implemented with `setState()`
- [ ] `Stack`, `Row`, `Column`, `Expanded`, `Card` are each used in an obvious, defensible place
- [ ] Folder structure matches §6
- [ ] README explains the app, lists which widgets satisfy which requirement, and includes screenshots of both screens

## 12. Out of scope for Milestone 1

Adding/editing transactions, charts, persistence, dark mode, localization, animations beyond Flutter defaults, onboarding, settings. Do not build these even if time allows; spend spare time on polish instead.
