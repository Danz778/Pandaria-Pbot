# Pandaria encounter repairs

## Scope

These repairs address confirmed lifecycle, targeting and persistence defects. They
do not certify every dungeon/raid as retail complete. A matching world database
and client data for build 18414 are required for server and combat verification.

| Encounter | Repair |
| --- | --- |
| Sha of Doubt | Wither Will selects up to two distinct players. Bounds of Reality tracks actual summoned figments, ignores duplicate death/despawn notifications, and ends when the last figment disappears. Reset clears the aura and player-owned summons. Dead players and GMs do not generate figments. |
| Gekkan | Start/death use BossAI transitions; entourage is refreshed on pull; evade updates the correct legacy event slot. Treasure and barriers restore correctly when objects load after boss completion. |
| Xin the Weaponmaster | Initialization resets the fresh boss state and initializes its intro flag. Start uses BossAI; both room doors follow encounter state and reopen on wipe. |
| Trial of the King | The controller owns fresh start, failure and completion states while champion IDs remain separate. Wipes preserve the existing champion order/retry sequence and cannot clear a completed encounter. |
| Mogu'shan Palace saves | The existing fourteen-number format is retained. BossAI states are written into the existing Trial/Gekkan/Xin slots and restored on load; in-progress encounters reset. Other eleven slots retain their existing meanings. |
| Taran Zhu / Shado-Pan | Hatred starts clean, is restored for entering participants, and is cleared on wipe/completion/exit. GMs are excluded. Initial fractional-second timers retain their intended milliseconds. Empty archer sets and duplicate novice/miniboss notifications are safe. |
| Niuzao Temple | Completed Vo'jak/Pa'valak barriers also disappear when game objects load after the saved encounter state. The Vo'jak bombing outro retains control of its separate door. |
| Archimonde | Protection of Elune uses a registered AuraScript loader and its exact spell binding is restored. |

The spell registration cleanup also removes six redundant raw allocations whose
registered wrappers already existed; this does not add six new mechanics.

## Retail references and limits

- [Sha of Doubt Dungeon Journal, MoP Classic](https://www.wowhead.com/mop-classic/npc=56439): two random Wither Will targets, Bounds of Reality immunity, and player figments. Classic also contains newer encounter variants; their extra spells and tuning are not imported here.
- [Wither Will tooltip history](https://www.wowhead.com/spell=106736&xml): historical tooltips also describe two targets. The core explicitly converts the spell to an explicit enemy target in SpellMgr, so C++ selects two distinct players.
- [Taran Zhu Dungeon Journal](https://www.wowhead.com/npc=56884): hatred, Haze of Hate and Meditate. Modern retail damage values are not used for MoP tuning.

Targeting/phase repairs use those mechanics. Door, save and reset repairs follow
the existing instance/BossAI contracts. Existing spell IDs, damage, loot and spawn
positions are retained. Encounter timings have not been comprehensively verified
against 5.4.8 combat logs.

## World database updates

Apply through the normal world updater with the matching rebuilt core:

- `2026_10_29_00_world_protection_of_elune.sql`: restores only spell 38528's
  Protection of Elune binding.
- `2026_10_30_00_world_pandaria_encounters.sql`: assigns the four repaired
  instances and five creature templates to their registered C++ scripts, clears
  competing AIName values on those five templates, and restores four exact spell
  bindings. Other spell bindings, template stats, spawns and loot are preserved.

Updates modify existing templates; they do not supply a missing base world DB.
The optional cleanup remains a manual operation under `sql/optional/`; follow its
README. The removed aggregate duplicated historical migrations and must not be
imported again.

## Validation and in-game checklist

Changed translation units pass syntax/template compilation with PLAYERBOTS and
modules enabled. Extracted-method C++ regressions cover summon lifecycle, Wither
targets, save/load, both object creation orders, doors, hatred and archer events.
MySQL 8.0 fixtures verify reruns and preservation of unrelated data. These checks
do not execute the full spell engine or prove a linked/running worldserver.

Before declaring retail parity, test normal, heroic and challenge modes with the
actual world DB: wipe/re-pull each encounter, disconnect during figments/hatred,
kill/expire/despawn every figment, reload completed instances, check both Xin
doors and both Gekkan chest difficulties, and verify loot, achievements and LFG
completion. Review fresh DBErrors/worldserver logs for missing bindings or data.
