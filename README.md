<p align="center"><img src="icon.png" width="160" alt="AzerothQuest Quest Pack"></p>

<h1 align="center">AzerothQuest Quest Pack</h1>

<p align="center">105 new quests for AzerothCore (WotLK 3.3.5a) in the zones where the levelling route runs thin.<br>
They scale with the player, stay within each zone's levels, and are themed after their zone and giver.</p>

<p align="center">
  <img src="https://img.shields.io/badge/AzerothCore-module-1f6feb" alt="AzerothCore module">
  <img src="https://img.shields.io/badge/WotLK-3.3.5a-8b5cf6" alt="WotLK 3.3.5a">
  <img src="https://img.shields.io/badge/quests-105-2f6b3a" alt="105 quests">
  <img src="https://img.shields.io/badge/license-AGPL--3.0-b8862b" alt="AGPL-3.0">
  <a href="https://github.com/Tntdruid"><img src="https://img.shields.io/badge/author-Tntdruid-c0392b?logo=github" alt="Author: Tntdruid"></a>
</p>

---
Author: Tntdruid

## What it adds

- **105 quests** (IDs 900001-900105) in 20 zones of the Eastern Kingdoms and Kalimdor, for both factions where the
  zone has a hub for each, from quest givers already standing there.
- **Scaling**: every quest has the player's level (QuestLevel -1), with XP and money by level
  (`RewardXPDifficulty` 5, `RewardMoneyDifficulty` 5 from `quest_money_reward`). MinLevel and MaxLevel keep each
  quest within its zone's levels.
- **Group friendly quest items** (items 900001-900032): quest-required, and multi-drop, so everyone in the group
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

🔵 Alliance &nbsp; 🔴 Horde &nbsp; 🟢 Both factions &nbsp; · &nbsp; Levels: the range a quest can be taken in (it scales to the player within it).

### Eastern Kingdoms (65 quests)

<details>
<summary><b>Alterac Mountains</b> &nbsp;·&nbsp; 6 quests &nbsp;·&nbsp; levels 31-42</summary>

| Quest | Giver | Faction | Levels |
|---|---|---|:---:|
| **Furs for the Frostwolf** <sub>900024</sub> | Corporal Teeka Bloodsnarl | 🔴 Horde | 31-40 |
| **Furs for the Stormpike** <sub>900021</sub> | Sergeant Durgen Stormpike | 🔵 Alliance | 31-40 |
| **Crushridge Raiders** <sub>900022</sub> | Prospector Stonehewer | 🔵 Alliance | 32-41 |
| **Crushridge Thieves** <sub>900025</sub> | Voggah Deathgrip | 🔴 Horde | 32-41 |
| **Blind the Syndicate** <sub>900026</sub> | Corporal Teeka Bloodsnarl | 🔴 Horde | 33-42 |
| **Eyes of the Syndicate** <sub>900023</sub> | Sergeant Durgen Stormpike | 🔵 Alliance | 33-42 |

</details>

<details>
<summary><b>Arathi Highlands</b> &nbsp;·&nbsp; 5 quests &nbsp;·&nbsp; levels 31-42</summary>

| Quest | Giver | Faction | Levels |
|---|---|---|:---:|
| **Creeper Venom** <sub>900067</sub> | Doctor Draxlegauge | 🟢 Both | 31-40 |
| **Highland Hunt** <sub>900063</sub> | Captain Nials | 🔵 Alliance | 31-40 |
| **Highland Hunt** <sub>900064</sub> | Tor\'gan | 🔴 Horde | 31-40 |
| **Drywhisker Diggers** <sub>900065</sub> | Skuerto | 🔵 Alliance | 33-42 |
| **Drywhisker Diggers** <sub>900066</sub> | Drum Fel | 🔴 Horde | 33-42 |

</details>

<details>
<summary><b>Swamp of Sorrows</b> &nbsp;·&nbsp; 5 quests &nbsp;·&nbsp; levels 34-47</summary>

| Quest | Giver | Faction | Levels |
|---|---|---|:---:|
| **Rest for the Lost** <sub>900012</sub> | Anchorite Avuun | 🔵 Alliance | 34-42 |
| **Sawtooth Trouble** <sub>900010</sub> | Watcher Biggs | 🟢 Both | 37-46 |
| **Choking Vines** <sub>900011</sub> | Watcher Biggs | 🟢 Both | 38-46 |
| **Webs over the Dead** <sub>900013</sub> | Fallen Hero of the Horde | 🟢 Both | 38-46 |
| **Shells of the Northern Shore** <sub>900014</sub> | Galen Goodward | 🟢 Both | 39-47 |

</details>

<details>
<summary><b>Badlands</b> &nbsp;·&nbsp; 3 quests &nbsp;·&nbsp; levels 39-47</summary>

| Quest | Giver | Faction | Levels |
|---|---|---|:---:|
| **Dustbelcher Raiders** <sub>900003</sub> | Martek the Exiled | 🟢 Both | 39-47 |
| **Restless Stone** <sub>900002</sub> | Lotwil Veriatus | 🟢 Both | 40-47 |
| **Whelp Scales** <sub>900001</sub> | Garek | 🟢 Both | 40-47 |

</details>

<details>
<summary><b>The Hinterlands</b> &nbsp;·&nbsp; 5 quests &nbsp;·&nbsp; levels 40-52</summary>

| Quest | Giver | Faction | Levels |
|---|---|---|:---:|
| **Witherbark Cruelty** <sub>900051</sub> | Gryphon Master Talonaxe | 🔵 Alliance | 40-49 |
| **Witherbark Cruelty** <sub>900052</sub> | Huntsman Markhor | 🔴 Horde | 40-49 |
| **Owlbeast Plumage** <sub>900053</sub> | Rhapsody Shindigger | 🟢 Both | 41-49 |
| **Vilebranch Raiders** <sub>900054</sub> | Agnar Beastamer | 🔵 Alliance | 44-52 |
| **Vilebranch Raiders** <sub>900055</sub> | Otho Moji\'ko | 🔴 Horde | 44-52 |

</details>

<details>
<summary><b>Searing Gorge</b> &nbsp;·&nbsp; 8 quests &nbsp;·&nbsp; levels 42-53</summary>

| Quest | Giver | Faction | Levels |
|---|---|---|:---:|
| **Glass in the Webs** <sub>900004</sub> | Evonice Sootsmoker | 🟢 Both | 42-52 |
| **Searing Venom** <sub>900005</sub> | Master Smith Burninate | 🟢 Both | 43-52 |
| **Cooling the Forge** <sub>900006</sub> | Master Smith Burninate | 🟢 Both | 44-52 |
| **Blind the Lookouts** <sub>900007</sub> | Hansel Heavyhands | 🟢 Both | 45-52 |
| **Spiders of the Gorge** <sub>900101</sub> | Hansel Heavyhands | 🟢 Both | 46-52 |
| **Elementals of the Gorge** <sub>900105</sub> | Hansel Heavyhands | 🟢 Both | 47-53 |
| **Muck in the Water** <sub>900102</sub> | Evonice Sootsmoker | 🟢 Both | 47-53 |
| **Smoldering Embers** <sub>900103</sub> | Master Smith Burninate | 🟢 Both | 47-53 |

</details>

<details>
<summary><b>Blasted Lands</b> &nbsp;·&nbsp; 3 quests &nbsp;·&nbsp; levels 47-56</summary>

| Quest | Giver | Faction | Levels |
|---|---|---|:---:|
| **Felbeast Hides** <sub>900008</sub> | Kum\'isha the Collector | 🟢 Both | 47-56 |
| **Scorpok Menace** <sub>900009</sub> | Kum\'isha the Collector | 🟢 Both | 47-56 |
| **Crystalhide Scales** <sub>900104</sub> | Kum\'isha the Collector | 🟢 Both | 48-55 |

</details>

<details>
<summary><b>Western Plaguelands</b> &nbsp;·&nbsp; 14 quests &nbsp;·&nbsp; levels 49-58</summary>

| Quest | Giver | Faction | Levels |
|---|---|---|:---:|
| **Bones of Felstone** <sub>900079</sub> | Commander Ashlam Valorfist | 🔵 Alliance | 49-55 |
| **Bones of Felstone** <sub>900083</sub> | High Executor Derrington | 🔴 Horde | 49-55 |
| **Hearts of the Blight** <sub>900081</sub> | Alchemist Arbington | 🔵 Alliance | 49-55 |
| **Hearts of the Blight** <sub>900085</sub> | Apothecary Dithers | 🔴 Horde | 49-55 |
| **Mist and Venom** <sub>900082</sub> | Alchemist Arbington | 🔵 Alliance | 49-55 |
| **Mist and Venom** <sub>900086</sub> | Apothecary Dithers | 🔴 Horde | 49-55 |
| **The Shambling Dead** <sub>900080</sub> | Commander Ashlam Valorfist | 🔵 Alliance | 50-55 |
| **The Shambling Dead** <sub>900084</sub> | High Executor Derrington | 🔴 Horde | 50-55 |
| **Fangs of the Carrion Lurkers** <sub>900088</sub> | High Priestess MacDonnell | 🔵 Alliance | 51-56 |
| **Fangs of the Carrion Lurkers** <sub>900090</sub> | Apothecary Dithers | 🔴 Horde | 51-56 |
| **Rest for the Fallen** <sub>900087</sub> | Commander Ashlam Valorfist | 🔵 Alliance | 51-56 |
| **Rest for the Fallen** <sub>900089</sub> | High Executor Derrington | 🔴 Horde | 51-56 |
| **The Weeping Cave** <sub>900091</sub> | Alchemist Arbington | 🔵 Alliance | 52-58 |
| **The Weeping Cave** <sub>900092</sub> | Apothecary Dithers | 🔴 Horde | 52-58 |

</details>

<details>
<summary><b>Burning Steppes</b> &nbsp;·&nbsp; 6 quests &nbsp;·&nbsp; levels 50-58</summary>

| Quest | Giver | Faction | Levels |
|---|---|---|:---:|
| **Stingers of the Steppes** <sub>900016</sub> | Jalinda Sprig | 🔵 Alliance | 50-57 |
| **Unbound Flame** <sub>900017</sub> | Helendis Riverhorn | 🔵 Alliance | 50-57 |
| **Broodling Menace** <sub>900019</sub> | Mathredis Firestar | 🟢 Both | 51-57 |
| **Obsidian Cores** <sub>900018</sub> | Tinkee Steamboil | 🟢 Both | 51-58 |
| **Blackrock Vanguard** <sub>900015</sub> | Marshal Maxwell | 🔵 Alliance | 52-58 |
| **Reaver Scrap** <sub>900020</sub> | Maxwort Uberglint | 🟢 Both | 52-58 |

</details>

<details>
<summary><b>Eastern Plaguelands</b> &nbsp;·&nbsp; 8 quests &nbsp;·&nbsp; levels 53-60</summary>

| Quest | Giver | Faction | Levels |
|---|---|---|:---:|
| **Hunger in the Plaguewood** <sub>900094</sub> | Caretaker Alen | 🟢 Both | 53-60 |
| **The Scourge Muster** <sub>900093</sub> | Carlin Redpath | 🟢 Both | 53-60 |
| **Stone Wings over Darrowshire** <sub>900095</sub> | Carlin Redpath | 🟢 Both | 54-60 |
| **Corin's Crossing** <sub>900096</sub> | Carlin Redpath | 🟢 Both | 55-60 |
| **Samples of Living Decay** <sub>900097</sub> | Caretaker Alen | 🟢 Both | 55-60 |
| **The Ravagers' Plague** <sub>900098</sub> | Caretaker Alen | 🟢 Both | 55-60 |
| **Devourers of the Dead** <sub>900099</sub> | Carlin Redpath | 🟢 Both | 56-60 |
| **Stitched Together** <sub>900100</sub> | Caretaker Alen | 🟢 Both | 56-60 |

</details>

<details>
<summary><b>Deadwind Pass</b> &nbsp;·&nbsp; 2 quests &nbsp;·&nbsp; levels 53-60</summary>

| Quest | Giver | Faction | Levels |
|---|---|---|:---:|
| **Ogres of Deadwind** <sub>900061</sub> | Archmage Alturus | 🟢 Both | 53-60 |
| **Sky Shadows** <sub>900062</sub> | Archmage Leryda | 🟢 Both | 53-60 |

</details>

### Kalimdor (40 quests)

<details>
<summary><b>Darkshore</b> &nbsp;·&nbsp; 6 quests &nbsp;·&nbsp; levels 12-22</summary>

| Quest | Giver | Faction | Levels |
|---|---|---|:---:|
| **Foreststrider Plumes** <sub>900077</sub> | Gorbold Steelhand | 🔵 Alliance | 12-20 |
| **Frenzy in the Water** <sub>900075</sub> | Gubber Blump | 🔵 Alliance | 12-20 |
| **Moonstalker Pelts** <sub>900074</sub> | Tharnariun Treetender | 🔵 Alliance | 12-20 |
| **Stormscale Raiders** <sub>900073</sub> | Sentinel Glynda Nal\'Shea | 🔵 Alliance | 13-21 |
| **Blackwood Corruption** <sub>900076</sub> | Terenthis | 🔵 Alliance | 14-22 |
| **Dark Strand Fanatics** <sub>900078</sub> | Archaeologist Hollee | 🔵 Alliance | 14-22 |

</details>

<details>
<summary><b>The Barrens</b> &nbsp;·&nbsp; 5 quests &nbsp;·&nbsp; levels 12-28</summary>

| Quest | Giver | Faction | Levels |
|---|---|---|:---:|
| **Southsea Cutthroats** <sub>900071</sub> | Captain Darill | 🔵 Alliance | 12-20 |
| **Witchwing Harpies** <sub>900072</sub> | Gazlowe | 🟢 Both | 14-22 |
| **Silithid Swarm** <sub>900068</sub> | Sputtervalve | 🟢 Both | 18-27 |
| **Thunderhawk Plumes** <sub>900069</sub> | Mebok Mizzyrix | 🟢 Both | 19-28 |
| **Razormane Raiders** <sub>900070</sub> | Renn McGill | 🔵 Alliance | 20-28 |

</details>

<details>
<summary><b>Stonetalon Mountains</b> &nbsp;·&nbsp; 5 quests &nbsp;·&nbsp; levels 17-27</summary>

| Quest | Giver | Faction | Levels |
|---|---|---|:---:|
| **Deepmoss Silk** <sub>900044</sub> | Kaela Shadowspear | 🔵 Alliance | 17-25 |
| **Deepmoss Silk** <sub>900045</sub> | Tammra Windfield | 🔴 Horde | 17-25 |
| **Pridewing Menace** <sub>900046</sub> | Gaxim Rustfizzle | 🔵 Alliance | 19-27 |
| **Pridewing Menace** <sub>900047</sub> | Mor\'rogal | 🔴 Horde | 19-27 |
| **Windshear Diggers** <sub>900043</sub> | Ziz Fizziks | 🟢 Both | 19-27 |

</details>

<details>
<summary><b>Ashenvale</b> &nbsp;·&nbsp; 3 quests &nbsp;·&nbsp; levels 18-31</summary>

| Quest | Giver | Faction | Levels |
|---|---|---|:---:|
| **Crawlers of Zoram** <sub>900050</sub> | Je\'neu Sancrea | 🔴 Horde | 18-25 |
| **Shadowhorn Antlers** <sub>900049</sub> | Mastok Wrilehiss | 🔴 Horde | 20-29 |
| **Shadethicket Uprising** <sub>900048</sub> | Senani Thunderheart | 🔴 Horde | 23-31 |

</details>

<details>
<summary><b>Thousand Needles</b> &nbsp;·&nbsp; 3 quests &nbsp;·&nbsp; levels 25-38</summary>

| Quest | Giver | Faction | Levels |
|---|---|---|:---:|
| **Cloud Serpents** <sub>900042</sub> | Magus Tirth | 🟢 Both | 25-33 |
| **Scorpid Plague** <sub>900041</sub> | Trackmaster Zherin | 🟢 Both | 29-38 |
| **Sparkleshell Plates** <sub>900040</sub> | Pozzik | 🟢 Both | 29-38 |

</details>

<details>
<summary><b>Desolace</b> &nbsp;·&nbsp; 4 quests &nbsp;·&nbsp; levels 33-45</summary>

| Quest | Giver | Faction | Levels |
|---|---|---|:---:|
| **Gritjaw Hides** <sub>900037</sub> | Uthek the Wise | 🟢 Both | 33-42 |
| **Thunder in the Valley** <sub>900036</sub> | Warug | 🟢 Both | 34-43 |
| **Restless Maraudine** <sub>900038</sub> | Centaur Pariah | 🟢 Both | 36-44 |
| **Dread of the Valley** <sub>900039</sub> | Willow | 🟢 Both | 37-45 |

</details>

<details>
<summary><b>Tanaris</b> &nbsp;·&nbsp; 5 quests &nbsp;·&nbsp; levels 40-54</summary>

| Quest | Giver | Faction | Levels |
|---|---|---|:---:|
| **Blisterpaw Steaks** <sub>900060</sub> | Dirge Quikcleave | 🟢 Both | 40-49 |
| **Fire Roc Feathers** <sub>900057</sub> | Senior Surveyor Fizzledowser | 🟢 Both | 40-49 |
| **Steeljaw Shells** <sub>900058</sub> | Trenton Lighthammer | 🟢 Both | 40-48 |
| **Glasshide Gazers** <sub>900056</sub> | Curgle Cranklehop | 🟢 Both | 43-52 |
| **Hazzali Swarm** <sub>900059</sub> | Marin Noggenfogger | 🟢 Both | 46-54 |

</details>

<details>
<summary><b>Azshara</b> &nbsp;·&nbsp; 5 quests &nbsp;·&nbsp; levels 45-60</summary>

| Quest | Giver | Faction | Levels |
|---|---|---|:---:|
| **Spitelash Serpents** <sub>900031</sub> | Archmage Xylem | 🟢 Both | 45-53 |
| **Stagwing Feathers** <sub>900032</sub> | Ogtinc | 🟢 Both | 46-54 |
| **Legashi Corruption** <sub>900033</sub> | Loramus Thalipedes | 🟢 Both | 49-57 |
| **Coralshell Plates** <sub>900034</sub> | Kim\'jael | 🟢 Both | 50-58 |
| **Storm Bay Unrest** <sub>900035</sub> | Duke Hydraxis | 🟢 Both | 52-60 |

</details>

<details>
<summary><b>Felwood</b> &nbsp;·&nbsp; 4 quests &nbsp;·&nbsp; levels 47-58</summary>

| Quest | Giver | Faction | Levels |
|---|---|---|:---:|
| **Angerclaw Fury** <sub>900027</sub> | Greta Mosshoof | 🟢 Both | 47-55 |
| **Ironbeak Hunters** <sub>900028</sub> | Jessir Moonbow | 🟢 Both | 48-56 |
| **Tainted Ooze Samples** <sub>900029</sub> | Ivy Leafrunner | 🟢 Both | 49-57 |
| **Shadows of Jaedenar** <sub>900030</sub> | Eridan Bluewind | 🟢 Both | 51-58 |

</details>

## License

GNU AGPL v3, as AzerothCore. See [LICENSE](LICENSE).
