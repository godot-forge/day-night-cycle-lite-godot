# Day/Night Cycle Lite — Godot 4

Free Godot 4 addon for a day/night clock — time advancement, 4 phases, save/load.

## Features (Lite — Free)

- `time_of_day` float (0.0–1.0), `day` counter
- `hour()` / `minute()` / `phase()` (DAWN/DAY/DUSK/NIGHT)
- `is_daytime()` / `set_time(hour, minute)`
- `speed` — how fast time passes (default=1.0)
- `pause_time()` / `resume_time()`
- `save_state()` / `load_state()`
- Signals: `phase_changed`, `hour_changed`, `day_changed`

## Quick Start

```gdscript
# Autoload: DayNight
DayNight.speed = 120.0  # 1 real second = 2 in-game hours
DayNight.phase_changed.connect(func(p): update_lighting(p))
DayNight.set_time(8, 0)
```

## Upgrade to PRO

[Day/Night Cycle PRO](https://godot-forge.itch.io/day-night-cycle-pro-godot) adds:
- Sky color gradient (sky_color() → Color for your WorldEnvironment)
- sun_angle() — perfect for DirectionalLight3D rotation
- Scheduled events (schedule_event at specific hours)
- set_speed() helper

---
Made with ♥ by [GodotForge](https://itch.io/profile/godot-forge)
