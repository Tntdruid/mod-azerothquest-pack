<p align="center"><img src="icon.png" width="160" alt="AzerothQuest Quest Pack"></p>

<h1 align="center">AzerothQuest Quest Pack</h1>

<p align="center">86 new quests for AzerothCore (WotLK 3.3.5a) in the zones where the levelling route runs thin.<br>
They scale with the player, stay within each zone's levels, and are themed after their zone and giver.</p>

---

## What it adds

- **86 quests** (IDs 900001-900086) in 19 zones of the Eastern Kingdoms and Kalimdor, for both factions where the
  zone has a hub for each, from quest givers already standing there.
- **Scaling**: every quest has the player's level (QuestLevel -1), with XP and money by level
  (`RewardXPDifficulty` 5, `RewardMoneyDifficulty` 5 from `quest_money_reward`). MinLevel and MaxLevel keep each
  quest within its zone's levels.
- **Group friendly quest items** (items 900001-900026): quest-required, and multi-drop, so everyone in the group
  with the quest loots their own from each kill. Playerbots included.
- **World map areas** (`quest_poi`): where to kill or loot, and where to hand in, as for the game's own quests.
- Only mobs no other quest uses (or uses only for a drop), so the pack adds content instead of competing with it.

## Installation

1. Clone the module into your AzerothCore `modules/` folder:
   ```
   cd modules
   git clone https://github.com/Tntdruid/mod-azerothquest-pack.git
   ```
2. Re-run CMake and rebuild the server (the module has an empty script loader, so AzerothCore can link it).
3. Start the worldserver: its database updater applies `data/sql/db-world/` to `acore_world` by itself.
4. Delete the client's `Cache` folder so it learns the new items and quests.

Without rebuilding, you can also run the files in `data/sql/db-world/` by hand on `acore_world` and restart the
worldserver. Every file is safe to run twice.

## Uninstall

Remove the module folder, run `sql/uninstall.sql` on `acore_world`, and restart the worldserver.

## Works with

- **AzerothCore** WotLK (3.3.5a, build 12340).
- **mod-individual-progression**: the pack uses its own ID ranges (quests and items from 900001), clear of the
  module's ranges.
- **mod-playerbots**: quest items are multi-drop, so bots in the group do not take the player's drops.
- **AzerothQuest** (a levelling guide addon): it offers the pack's quests in their zones' steps when the server has
  the pack, and leaves them out when it does not.

## Rebuilding the SQL

`tools/build_quest_pack.py` turns a spec (`tools/specs/*.py`: items, quests, texts) into a pack's SQL:

```
python tools/build_quest_pack.py tools/specs/western_plaguelands.py data/sql/db-world/azerothquest_pack_western_plaguelands.sql
```

## The quests

### Eastern Kingdoms'
'
| Zone | Quest | Giver | Faction | Levels |'
|---|---|---|---|---|'
| Alterac Mountains | Furs for the Stormpike (900021) | Sergeant Durgen Stormpike | Alliance | 31-40 |'
| Alterac Mountains | Furs for the Frostwolf (900024) | Corporal Teeka Bloodsnarl | Horde | 31-40 |'
| Alterac Mountains | Crushridge Raiders (900022) | Prospector Stonehewer | Alliance | 32-41 |'
| Alterac Mountains | Crushridge Thieves (900025) | Voggah Deathgrip | Horde | 32-41 |'
| Alterac Mountains | Eyes of the Syndicate (900023) | Sergeant Durgen Stormpike | Alliance | 33-42 |'
| Alterac Mountains | Blind the Syndicate (900026) | Corporal Teeka Bloodsnarl | Horde | 33-42 |'
| Arathi Highlands | Highland Hunt (900063) | Captain Nials | Alliance | 31-40 |'
| Arathi Highlands | Highland Hunt (900064) | Tor'gan | Horde | 31-40 |'
| Arathi Highlands | Creeper Venom (900067) | Doctor Draxlegauge | Both | 31-40 |'
| Arathi Highlands | Drywhisker Diggers (900065) | Skuerto | Alliance | 33-42 |'
| Arathi Highlands | Drywhisker Diggers (900066) | Drum Fel | Horde | 33-42 |'
| Badlands | Dustbelcher Raiders (900003) | Martek the Exiled | Both | 39-47 |'
| Badlands | Whelp Scales (900001) | Garek | Both | 40-47 |'
| Badlands | Restless Stone (900002) | Lotwil Veriatus | Both | 40-47 |'
| Blasted Lands | Felbeast Hides (900008) | Kum'isha the Collector | Both | 47-56 |'
| Blasted Lands | Scorpok Menace (900009) | Kum'isha the Collector | Both | 47-56 |'
| Burning Steppes | Stingers of the Steppes (900016) | Jalinda Sprig | Alliance | 50-57 |'
| Burning Steppes | Unbound Flame (900017) | Helendis Riverhorn | Alliance | 50-57 |'
| Burning Steppes | Obsidian Cores (900018) | Tinkee Steamboil | Both | 51-58 |'
| Burning Steppes | Broodling Menace (900019) | Mathredis Firestar | Both | 51-57 |'
| Burning Steppes | Blackrock Vanguard (900015) | Marshal Maxwell | Alliance | 52-58 |'
| Burning Steppes | Reaver Scrap (900020) | Maxwort Uberglint | Both | 52-58 |'
| Deadwind Pass | Ogres of Deadwind (900061) | Archmage Alturus | Both | 53-60 |'
| Deadwind Pass | Sky Shadows (900062) | Archmage Leryda | Both | 53-60 |'
| Searing Gorge | Glass in the Webs (900004) | Evonice Sootsmoker | Both | 42-52 |'
| Searing Gorge | Searing Venom (900005) | Master Smith Burninate | Both | 43-52 |'
| Searing Gorge | Cooling the Forge (900006) | Master Smith Burninate | Both | 44-52 |'
| Searing Gorge | Blind the Lookouts (900007) | Hansel Heavyhands | Both | 45-52 |'
| Swamp of Sorrows | Rest for the Lost (900012) | Anchorite Avuun | Alliance | 34-42 |'
| Swamp of Sorrows | Sawtooth Trouble (900010) | Watcher Biggs | Both | 37-46 |'
| Swamp of Sorrows | Choking Vines (900011) | Watcher Biggs | Both | 38-46 |'
| Swamp of Sorrows | Webs over the Dead (900013) | Fallen Hero of the Horde | Both | 38-46 |'
| Swamp of Sorrows | Shells of the Northern Shore (900014) | Galen Goodward | Both | 39-47 |'
| The Hinterlands | Witherbark Cruelty (900051) | Gryphon Master Talonaxe | Alliance | 40-49 |'
| The Hinterlands | Witherbark Cruelty (900052) | Huntsman Markhor | Horde | 40-49 |'
| The Hinterlands | Owlbeast Plumage (900053) | Rhapsody Shindigger | Both | 41-49 |'
| The Hinterlands | Vilebranch Raiders (900054) | Agnar Beastamer | Alliance | 44-52 |'
| The Hinterlands | Vilebranch Raiders (900055) | Otho Moji'ko | Horde | 44-52 |'
| Western Plaguelands | Bones of Felstone (900079) | Commander Ashlam Valorfist | Alliance | 49-55 |'
| Western Plaguelands | Hearts of the Blight (900081) | Alchemist Arbington | Alliance | 49-55 |'
| Western Plaguelands | Mist and Venom (900082) | Alchemist Arbington | Alliance | 49-55 |'
| Western Plaguelands | Bones of Felstone (900083) | High Executor Derrington | Horde | 49-55 |'
| Western Plaguelands | Hearts of the Blight (900085) | Apothecary Dithers | Horde | 49-55 |'
| Western Plaguelands | Mist and Venom (900086) | Apothecary Dithers | Horde | 49-55 |'
| Western Plaguelands | The Shambling Dead (900080) | Commander Ashlam Valorfist | Alliance | 50-55 |'
| Western Plaguelands | The Shambling Dead (900084) | High Executor Derrington | Horde | 50-55 |'
'
### Kalimdor'
'
| Zone | Quest | Giver | Faction | Levels |'
|---|---|---|---|---|'
| Ashenvale | Crawlers of Zoram (900050) | Je'neu Sancrea | Horde | 18-25 |'
| Ashenvale | Shadowhorn Antlers (900049) | Mastok Wrilehiss | Horde | 20-29 |'
| Ashenvale | Shadethicket Uprising (900048) | Senani Thunderheart | Horde | 23-31 |'
| Azshara | Spitelash Serpents (900031) | Archmage Xylem | Both | 45-53 |'
| Azshara | Stagwing Feathers (900032) | Ogtinc | Both | 46-54 |'
| Azshara | Legashi Corruption (900033) | Loramus Thalipedes | Both | 49-57 |'
| Azshara | Coralshell Plates (900034) | Kim'jael | Both | 50-58 |'
| Azshara | Storm Bay Unrest (900035) | Duke Hydraxis | Both | 52-60 |'
| Darkshore | Moonstalker Pelts (900074) | Tharnariun Treetender | Alliance | 12-20 |'
| Darkshore | Frenzy in the Water (900075) | Gubber Blump | Alliance | 12-20 |'
| Darkshore | Foreststrider Plumes (900077) | Gorbold Steelhand | Alliance | 12-20 |'
| Darkshore | Stormscale Raiders (900073) | Sentinel Glynda Nal'Shea | Alliance | 13-21 |'
| Darkshore | Blackwood Corruption (900076) | Terenthis | Alliance | 14-22 |'
| Darkshore | Dark Strand Fanatics (900078) | Archaeologist Hollee | Alliance | 14-22 |'
| Desolace | Gritjaw Hides (900037) | Uthek the Wise | Both | 33-42 |'
| Desolace | Thunder in the Valley (900036) | Warug | Both | 34-43 |'
| Desolace | Restless Maraudine (900038) | Centaur Pariah | Both | 36-44 |'
| Desolace | Dread of the Valley (900039) | Willow | Both | 37-45 |'
| Felwood | Angerclaw Fury (900027) | Greta Mosshoof | Both | 47-55 |'
| Felwood | Ironbeak Hunters (900028) | Jessir Moonbow | Both | 48-56 |'
| Felwood | Tainted Ooze Samples (900029) | Ivy Leafrunner | Both | 49-57 |'
| Felwood | Shadows of Jaedenar (900030) | Eridan Bluewind | Both | 51-58 |'
| Stonetalon Mountains | Deepmoss Silk (900044) | Kaela Shadowspear | Alliance | 17-25 |'
| Stonetalon Mountains | Deepmoss Silk (900045) | Tammra Windfield | Horde | 17-25 |'
| Stonetalon Mountains | Windshear Diggers (900043) | Ziz Fizziks | Both | 19-27 |'
| Stonetalon Mountains | Pridewing Menace (900046) | Gaxim Rustfizzle | Alliance | 19-27 |'
| Stonetalon Mountains | Pridewing Menace (900047) | Mor'rogal | Horde | 19-27 |'
| Tanaris | Fire Roc Feathers (900057) | Senior Surveyor Fizzledowser | Both | 40-49 |'
| Tanaris | Steeljaw Shells (900058) | Trenton Lighthammer | Both | 40-48 |'
| Tanaris | Blisterpaw Steaks (900060) | Dirge Quikcleave | Both | 40-49 |'
| Tanaris | Glasshide Gazers (900056) | Curgle Cranklehop | Both | 43-52 |'
| Tanaris | Hazzali Swarm (900059) | Marin Noggenfogger | Both | 46-54 |'
| The Barrens | Southsea Cutthroats (900071) | Captain Darill | Alliance | 12-20 |'
| The Barrens | Witchwing Harpies (900072) | Gazlowe | Both | 14-22 |'
| The Barrens | Silithid Swarm (900068) | Sputtervalve | Both | 18-27 |'
| The Barrens | Thunderhawk Plumes (900069) | Mebok Mizzyrix | Both | 19-28 |'
| The Barrens | Razormane Raiders (900070) | Renn McGill | Alliance | 20-28 |'
| Thousand Needles | Cloud Serpents (900042) | Magus Tirth | Both | 25-33 |'
| Thousand Needles | Sparkleshell Plates (900040) | Pozzik | Both | 29-38 |'
| Thousand Needles | Scorpid Plague (900041) | Trackmaster Zherin | Both | 29-38 |'
'
## License

GNU AGPL v3, as AzerothCore. See [LICENSE](LICENSE).
