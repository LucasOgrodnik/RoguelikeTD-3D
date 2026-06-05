# RoguelikeTD-3D

A complete 3D isometric tower defense roguelike conversion. This is a ground-up rebuild of the original 2D RoguelikeTD, porting all game mechanics to Godot 4.4.1 with 3D rendering while maintaining full feature parity.

## Project Status

🏗️ **In Development** — Absolute-Human AI-native development lifecycle. See `.absolute-human/board.md` for detailed task progress.

## Quick Start

1. **Requirements:** Godot 4.4.1, Git
2. **Setup:** Clone this repo, open project in Godot editor
3. **Main scene:** `scenes/main/hud.tscn`

## Architecture

**3D Rendering:**
- Fixed isometric camera (orthographic projection)
- Placeholder assets during development; real 3D models swap in as artist deliverables arrive
- All entities are Node3D with MeshInstance3D

**Game Systems:**
- Clean rebuild of 2D logic (damage pipeline, relics, economy, wave generation)
- Full feature parity: 3 heroes, 2 enemy races, 35 reliques, meta-progression

## Development

Progress tracked in `.absolute-human/board.md` (local, not git-tracked).

For architecture details, see `docs/ARCHITECTURE.md` (added during Phase 5).

## License

Same as original RoguelikeTD project.
