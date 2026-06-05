# Game Balance — RoguelikeTD-3D

Ported from 2D version with no changes to formulas or values.

## Damage Formula

```
D_final = (D_base × M_type) × (1 − R_armor)
```

- `D_base` = Hero attack damage (before crit)
- `M_type` = Type multiplier (Weakness ×1.5, Neutral ×1.0, Resistance ×0.75)
- `R_armor` = Armor reduction (e.g., 0.20 = −20%)
- **Fire ignores armor** (R_armor = 0 for Fire damage)

**Crit:** `D_base × 1.5` if `randf() < crit_chance`

## Wave Generation

| Formula | Value |
|---|---|
| Budget | `floor(40 × 1.15^(w−1))` |
| HP Scaling | `1.05^(w−1)` |
| Max Enemies/Wave | 30 |
| Boss Waves | 5, 10, 15, 20 |

## Economy

| Item | Value |
|---|---|
| Starting Gold | 80 |
| Wave Bonus | `10 + wave × 2` |

### Hero Costs
- Bladedancer: 50 gold
- Stormshard: 55 gold
- Pyromancer: 65 gold

### Enemy Gold Rewards

**Skeletons:**
- Warrior: 10 gold
- Rogue: 8 gold
- Knight: 25 gold
- Bonelord (boss): 80 gold

**Orcs:**
- Warrior: 12 gold
- Worg: 10 gold
- Berserker: 30 gold
- Warchief (boss): 90 gold

## Type Matchups

| Enemy | Armor | Weakness | Resistance |
|---|---|---|---|
| Skeleton | 0% | Magic, Fire | Piercing, Slashing |
| Orc | 15% | Fire, Magic | Piercing, Slashing |

## Gems (Meta-Progression)

| Source | Amount |
|---|---|
| Per Wave | 5 gems |
| Victory Bonus | 50 gems |
