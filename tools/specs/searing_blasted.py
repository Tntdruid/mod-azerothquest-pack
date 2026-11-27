# Quest pack: Searing Gorge and Blasted Lands, levels 46-55. The Eastern Kingdoms guide opens only 3 and 8 quests at
# levels 48 and 49, between the Badlands and Searing Gorge (47) and the Burning Steppes and Western Plaguelands (50).
# Five quests for both factions from neutral givers: Thorium Point's Hansel Heavyhands, Evonice Sootsmoker and
# Master Smith Burninate, and Kum'isha the Collector at the Dark Portal; on mobs no quest kills or loots for itself.
# Build: python -I tools/build_quest_pack.py tools/specs/searing_blasted.py data/sql/db-world/azerothquest_pack_searing_blasted_46_55.sql
import os
import runpy

quest = runpy.run_path(os.path.join(os.path.dirname(os.path.abspath(__file__)), "kalimdor.py"))["quest"]

TITLE = "Searing Gorge and Blasted Lands, levels 46-55."
HEADER = [
    "",
    "5 quests for both factions, for the gap at levels 48-49: Searing Lava Spiders, Muck Splashes and the Blazing and",
    "Inferno Elementals of Searing Gorge from Thorium Point, and the Redstone Crystalhides of the Blasted Lands from",
    "Kum'isha the Collector.",
]

SEARING, BLASTED = 51, 4

ITEMS = [
    (900031, "Smoldering Ember", 9116, "It glows without burning, for now.",
     [(5850, 60, "Blazing Elemental"), (5852, 60, "Inferno Elemental")]),
    (900032, "Crystalhide Scale", 2874, "Hard as stone, and faintly glittering.",
     [(5991, 50, "Redstone Crystalhide")]),
]

QUESTS = [
    quest(900101, 14627, "Hansel Heavyhands", "Spiders of the Gorge", SEARING, 46, 52,
          log="Kill 12 Searing Lava Spiders in the south of Searing Gorge, then return to Hansel Heavyhands at Thorium Point.",
          text="Our ore carts go south through the gorge, $N, and the searing lava spiders down there have taken a liking to our mules.$B$BThin them out. Twelve of them, and the carts can roll again.",
          ret="Return to Hansel Heavyhands at Thorium Point.",
          ask="Are the spiders dealt with?", done="Good work. The mules thank you, and so does the Brotherhood.",
          kill=[(5857, 12)]),
    quest(900102, 14628, "Evonice Sootsmoker", "Muck in the Water", SEARING, 47, 53,
          log="Kill 10 Muck Splashes at the lake in the west of Searing Gorge, then return to Evonice Sootsmoker at Thorium Point.",
          text="The only clean water in this gorge is the lake to the west, and something foul has crawled out of the muck there. Muck splashes, the miners call them.$B$BWe need that water, $N. Ten of them, and we can fill our barrels again.",
          ret="Return to Evonice Sootsmoker at Thorium Point.",
          ask="Is the lake clear?", done="Clean water at last! You have my thanks.",
          kill=[(8837, 10)]),
    quest(900103, 14624, "Master Smith Burninate", "Smoldering Embers", SEARING, 47, 53,
          log="Bring 8 Smoldering Embers from the Blazing and Inferno Elementals of Searing Gorge to Master Smith Burninate at Thorium Point.",
          text="An ember from a living flame burns hotter than any coal, $N, and a smith of the Brotherhood knows what to do with that.$B$BThe blazing and inferno elementals in the gorge carry such embers. Bring me eight.",
          ret="Return to Master Smith Burninate at Thorium Point.",
          ask="Have you the embers?", done="Feel that heat! These will make a fine blade or two.",
          item=(900031, 8)),
    quest(900104, 7363, "Kum'isha the Collector", "Crystalhide Scales", BLASTED, 48, 55,
          log="Bring 8 Crystalhide Scales from the Redstone Crystalhides of the Blasted Lands to Kum'isha the Collector.",
          text="The redstone crystalhides of this blasted land grow scales that glitter like gems, $N. A collector such as I cannot resist them.$B$BBring me eight. I will make it worth your while.",
          ret="Return to Kum'isha the Collector at the Dark Portal.",
          ask="Do you have the scales?", done="Beautiful! Look how they catch the light. A fine addition to my collection.",
          item=(900032, 8)),
    quest(900105, 14627, "Hansel Heavyhands", "Elementals of the Gorge", SEARING, 47, 53,
          log="Kill 5 Blazing Elementals and 5 Inferno Elementals in Searing Gorge, then return to Hansel Heavyhands at Thorium Point.",
          text="Fire walks the gorge on its own legs now, $N. The blazing and inferno elementals set our camps alight whenever they wander close.$B$BPut out five of each.",
          ret="Return to Hansel Heavyhands at Thorium Point.",
          ask="Are the fires out?", done="Hah! Doused like a forge at day's end. Well done.",
          kill=[(5850, 5), (5852, 5)]),
]
