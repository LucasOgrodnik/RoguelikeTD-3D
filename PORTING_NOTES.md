# Porting Notes: 2D → 3D Conversion

## Overview

RoguelikeTD-3D is a clean rebuild of the 2D version with:
- **Reused:** Design docs, balance formulas, relic definitions, game logic
- **Rebuilt:** All code from scratch, adapted to 3D architecture
- **Changed:** Rendering (sprites → 3D models), coordinate system (Vector2 → Vector3)

## Key Differences from 2D

### Architecture
- **2D:** Node2D root + CanvasLayer UI on top
- **3D:** Node3D root with 3D scene, CanvasLayer UI overlay

### Entities
- **2D:** AnimatedSprite2D with frame-based animations
- **3D:** MeshInstance3D with placeholder geometry, later skeletal animations

### Coordinate System
- **2D:** Vector2 (x, y) in pixels
- **3D:** Vector3 (x, y, z) in world units; 1 unit ≈ 50 pixels

### Camera
- **2D:** Camera2D with zoom
- **3D:** Camera3D with orthographic projection, fixed isometric angle

### Pathfinding
- **2D:** Path2D following waypoints
- **3D:** Simple straight-line movement (MVP), Navigation3D available for future

## Systems Status

| System | Status | Notes |
|---|---|---|
| Damage Pipeline | ✅ Ported | Vector2 → Vector3 direction; crit/types unchanged |
| Reliques (35) | ✅ Ported | All logic reused; no rendering dependency |
| Economy | ✅ Ported | Gold, shop, bonuses unchanged |
| Wave Generation | ✅ Ported | Budget/composition logic unchanged; 3D spawn logic new |
| Heroes (3) | 🏗️ Rebuilding | New Vector3 positioning, placeholder animations |
| Enemies (8) | 🏗️ Rebuilding | New Vector3 positioning, health bars adapted |
| Meta-Progression | 🏗️ Rebuilding | Forge system, saves, unlocks being ported |
| UI | 🏗️ Rebuilding | CanvasLayer UI ported from 2D; layout may need tweaks |

## Known Deviations from 2D

### Intentional
- **Placeholder assets:** Blue/red cubes until artist delivers real 3D models
- **No animation:** Placeholder entities don't animate; will add when skeletal rigs arrive
- **Simple pathfinding:** Enemies walk straight to base entry (no obstacle avoidance)

### To Be Addressed
- **3D→2D projection:** Hero/enemy world positions projected to 2D canvas for HUD icons
- **Visual polish:** Dark fantasy shader materials, particle effects for special abilities
- **Balance validation:** Play-test to ensure 3D difficulty matches 2D

## Rollback Strategy

If significant issues arise:
1. All development is isolated in RoguelikeTD-3D/ (separate from 2D repo)
2. 2D version (RoguelikeTD/) remains untouched backup
3. Commits are atomic; easy to revert or cherry-pick fixes

## Timeline & Phases

See `.absolute-human/board.md` for detailed wave-by-wave execution plan.

- **Phase 0** (Waves 1-2): Scaffolding + 3D foundation
- **Phase 1** (Waves 3-4): Core state + entities
- **Phase 2** (Waves 5-7): First playable loop
- **Phase 3** (Waves 8-10): Full wave progression + economy
- **Phase 4** (Waves 11-13): Reliques + draft + abilities
- **Phase 5** (Waves 14-16): UI + assets
- **Phase 6** (Waves 17-19): Testing, animation, shipping

---

**Last Updated:** 2026-06-05  
**Version:** 1.0 (Initial)
