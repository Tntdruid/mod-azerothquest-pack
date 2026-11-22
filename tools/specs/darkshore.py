# Quest pack: Darkshore, levels 12-22. Only 9 quests at levels 15-16 for the Alliance, against 10 at 14 and 7 at 17:
# six new ones on mobs no quest uses, from Auberdine's givers.
# Build: python -I tools/build_quest_pack.py tools/specs/darkshore.py data/sql/db-world/azerothquest_pack_darkshore.sql
import runpy
import os

quest = runpy.run_path(os.path.join(os.path.dirname(os.path.abspath(__file__)), "kalimdor.py"))["quest"]

TITLE = "Darkshore, levels 12-22."
HEADER = [
    "",
    "6 quests for the Alliance from Auberdine, for the gap at levels 15-16: the Stormscale naga, moonstalkers,",
    "the coastal frenzies, the Blackwood furbolgs, foreststriders and the Dark Strand cultists.",
]

ALLIANCE = 1101
DARKSHORE = 148

ITEMS = [
    (900023, "Moonstalker Pelt", 8794, "Soft, and silver in the moonlight.",
     [(2069, 50, "Moonstalker")]),
    (900024, "Foreststrider Plume", 19572, "Long, and the color of moss.",
     [(2322, 50, "Foreststrider")]),
]

QUESTS = [
    quest(900073, 2930, "Sentinel Glynda Nal'Shea", "Stormscale Raiders", DARKSHORE, 13, 21, races=ALLIANCE,
          log="Kill 8 Stormscale Wave Riders and 8 Stormscale Sirens on the coast north of Auberdine, then return to Sentinel Glynda Nal'Shea.",
          text="The Stormscale naga have come ashore north of Auberdine, $N. Their wave riders scout our coast, and their sirens sing our fishers into the sea.$B$BDrive them back into the water. Eight of each should make them think again.",
          ret="Return to Sentinel Glynda Nal'Shea in Auberdine.",
          ask="Are the naga driven back?", done="Elune guided your hand. The coast is safer tonight.",
          kill=[(2179, 8), (2180, 8)]),
    quest(900074, 3701, "Tharnariun Treetender", "Moonstalker Pelts", DARKSHORE, 12, 20, races=ALLIANCE,
          log="Bring 8 Moonstalker Pelts to Tharnariun Treetender in Auberdine.",
          text="The corruption reaches even the moonstalkers, $N. The ones in the south have grown sick and savage, and they suffer.$B$BEnd their suffering, and bring me their pelts. I will study them, so that one day we may save the others.",
          ret="Return to Tharnariun Treetender in Auberdine.",
          ask="Did you bring the pelts?", done="Thank you. Their suffering has meaning now, if I can learn from it.",
          item=(900023, 8)),
    quest(900075, 10216, "Gubber Blump", "Frenzy in the Water", DARKSHORE, 12, 20, races=ALLIANCE,
          log="Kill 10 Coastal Frenzies on the coast of Darkshore, then return to Gubber Blump in Auberdine.",
          text="Fish are biting, all right. Biting me! The coastal frenzies south of here have chewed through three of my nets and half my boot.$B$BGo thin them out, $N. Ten of the little monsters, and I can fish in peace again.",
          ret="Return to Gubber Blump in Auberdine.",
          ask="Did you get the frenzies?", done="Ha! My nets thank you. My boot thanks you. Here, have some coin.",
          kill=[(2174, 10)], emote=4),
    quest(900076, 3693, "Terenthis", "Blackwood Corruption", DARKSHORE, 14, 22, races=ALLIANCE,
          log="Kill 10 Blackwood Warriors in Darkshore, then return to Terenthis in Auberdine.",
          text="The Blackwood furbolgs were our friends once, $N. Now something corrupts them, and their warriors attack anyone who comes near their camps in the north-east.$B$BI wish there were another way. There is not. Ten of their warriors, and their camps will be quieter.",
          ret="Return to Terenthis in Auberdine.",
          ask="Is it done?", done="A sad task, but a needed one. Thank you, $N.",
          kill=[(2168, 10)]),
    quest(900077, 6301, "Gorbold Steelhand", "Foreststrider Plumes", DARKSHORE, 12, 20, races=ALLIANCE,
          log="Bring 8 Foreststrider Plumes to Gorbold Steelhand in Auberdine.",
          text="The night elves make the finest arrow fletchings out of foreststrider plumes, and I mean to learn how. A dwarf can always learn something new!$B$BThe foreststriders roam the hills in the north. Bring me eight plumes, $N.",
          ret="Return to Gorbold Steelhand in Auberdine.",
          ask="Plumes, lad?", done="Fine plumes! These will fly true. Here, for your trouble.",
          item=(900024, 8)),
    quest(900078, 2913, "Archaeologist Hollee", "Dark Strand Fanatics", DARKSHORE, 14, 22, races=ALLIANCE,
          log="Kill 10 Dark Strand Fanatics in the north of Darkshore, then return to Archaeologist Hollee in Auberdine.",
          text="The Dark Strand cultists dig in the old ruins of the north, and they are not looking for history. Whatever they hope to find, I do not want them to find it.$B$BTheir fanatics guard the digs. Ten of them, $N, and my own work can go on.",
          ret="Return to Archaeologist Hollee in Auberdine.",
          ask="Are the cultists dealt with?", done="Splendid! The ruins are ours again. Thank you, $N.",
          kill=[(2336, 10)]),
]
