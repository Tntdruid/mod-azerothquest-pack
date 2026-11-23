# Quest pack: Eastern Plaguelands, levels 53-60. The Eastern Kingdoms guide opens only 7, 8 and 4 quests at levels 54,
# 55 and 56, where a level takes about 150,000 XP. Eight quests for both factions from Light's Hope Chapel's own
# givers (Carlin Redpath and Caretaker Alen: mod-individual-progression hides the others until later), on the level 53-58 Scourge and beasts no quest kills: Scourge Soldiers and Cursed Mages, Cannibal Ghouls
# and Torn Screamers in the north-west, Putrid Gargoyles, Hate Shriekers at Corin's Crossing, Living Decay, Plague
# Ravagers, Carrion Devourers and Stitched Horrors.
# Build: python -I tools/build_quest_pack.py tools/specs/eastern_plaguelands.py data/sql/db-world/azerothquest_pack_eastern_plaguelands.sql
import os
import runpy

quest = runpy.run_path(os.path.join(os.path.dirname(os.path.abspath(__file__)), "kalimdor.py"))["quest"]

TITLE = "Eastern Plaguelands, levels 53-60."
HEADER = [
    "",
    "8 quests for both factions from Light's Hope Chapel, for the gap at levels 54-56, from Carlin Redpath and",
    "Caretaker Alen (mod-individual-progression hides the chapel's other givers until later): Scourge Soldiers, Cursed Mages,",
    "Cannibal Ghouls, Torn Screamers, Putrid Gargoyles, Hate Shriekers, Living Decay, Plague Ravagers, Carrion",
    "Devourers and Stitched Horrors.",
]

PLAGUELANDS = 139

ITEMS = [
    (900029, "Sample of Living Decay", 21972, "It rots the glass it is kept in.",
     [(8606, 50, "Living Decay")]),
    (900030, "Ravager Plague Gland", 8940, "Swollen, and warm to the touch.",
     [(8520, 60, "Plague Ravager")]),
]

QUESTS = [
    quest(900093, 11063, "Carlin Redpath", "The Scourge Muster", PLAGUELANDS, 53, 60,
          log="Kill 10 Scourge Soldiers and 6 Cursed Mages in the north-west of the Eastern Plaguelands, then return to Carlin Redpath at Light's Hope Chapel.",
          text="The Scourge are gathering soldiers in the north-west, near Terrordale, and their cursed mages raise more every night. I saw what such an army did to Darrowshire.$B$BDo not let it grow, $N. Ten soldiers and six of their mages, and the muster will be broken before it marches.",
          ret="Return to Carlin Redpath at Light's Hope Chapel.",
          ask="Is the muster broken?", done="Well fought. No town will burn the way mine did, not to that army.",
          kill=[(8523, 10), (8524, 6)]),
    quest(900094, 11038, "Caretaker Alen", "Hunger in the Plaguewood", PLAGUELANDS, 53, 60,
          log="Kill 10 Cannibal Ghouls and 8 Torn Screamers in the north-west of the Eastern Plaguelands, then return to Caretaker Alen at Light's Hope Chapel.",
          text="I tend the dead here, $N, but in the north-west there are none left to tend. The cannibal ghouls devour the fallen before we can give them rest, and the torn screamers fill the air with their cries.$B$BTen ghouls and eight screamers, and some of the fallen may yet be buried.",
          ret="Return to Caretaker Alen at Light's Hope Chapel.",
          ask="Have the fallen been spared?", done="The Light thanks you, and so do the dead you spared.",
          kill=[(8530, 10), (8540, 8)]),
    quest(900095, 11063, "Carlin Redpath", "Stone Wings over Darrowshire", PLAGUELANDS, 54, 60,
          log="Kill 10 Putrid Gargoyles in the Eastern Plaguelands, then return to Carlin Redpath at Light's Hope Chapel.",
          text="My home is ash, $N, but the sky over it should at least be free of those putrid gargoyles. They circle the old roads looking for travellers.$B$BKill ten of them. Do it for Darrowshire.",
          ret="Return to Carlin Redpath at Light's Hope Chapel.",
          ask="Are the skies clear?", done="Thank you. It is a small thing, but it matters to me.",
          kill=[(8534, 10)]),
    quest(900096, 11063, "Carlin Redpath", "Corin's Crossing", PLAGUELANDS, 55, 60,
          log="Kill 10 Hate Shriekers at Corin's Crossing, then return to Carlin Redpath at Light's Hope Chapel.",
          text="Corin's Crossing was a town once, like Darrowshire. Now it is a Scourge stronghold in the heart of the plaguelands, and its hate shriekers drive off any who come near.$B$BWe will take it back one day. Today, kill ten of the shriekers, $N.",
          ret="Return to Carlin Redpath at Light's Hope Chapel.",
          ask="How fares Corin's Crossing?", done="Ten fewer. The day we retake it comes closer.",
          kill=[(8541, 10)]),
    quest(900097, 11038, "Caretaker Alen", "Samples of Living Decay", PLAGUELANDS, 55, 60,
          log="Bring 8 Samples of Living Decay to Caretaker Alen at Light's Hope Chapel.",
          text="The living decay south-east of here is the plague grown a body of its own, $N. If we understand how it rots the living, perhaps we can keep it from the wounded we tend.$B$BBring me eight samples. Keep them sealed.",
          ret="Return to Caretaker Alen at Light's Hope Chapel.",
          ask="Did you bring the samples?", done="Thank you. I will study them carefully, and far from the beds.",
          item=(900029, 8)),
    quest(900098, 11038, "Caretaker Alen", "The Ravagers' Plague", PLAGUELANDS, 55, 60,
          log="Bring 8 Ravager Plague Glands to Caretaker Alen at Light's Hope Chapel.",
          text="The plague ravagers in the south carry the plague in glands under their hide. If we can study them, the Argent Dawn may learn to cure what the ravagers spread.$B$BBring me eight glands, $N. Gently.",
          ret="Return to Caretaker Alen at Light's Hope Chapel.",
          ask="Do you have the glands?", done="Thank you. These will help more than you know.",
          item=(900030, 8)),
    quest(900099, 11063, "Carlin Redpath", "Devourers of the Dead", PLAGUELANDS, 56, 60,
          log="Kill 10 Carrion Devourers in the north of the Eastern Plaguelands, then return to Carlin Redpath at Light's Hope Chapel.",
          text="The carrion devourers in the north feed on the dead, $N, and what they eat comes back as more Scourge.$B$BKill ten of them. Every one is a body the Scourge will not get.",
          ret="Return to Carlin Redpath at Light's Hope Chapel.",
          ask="Are the devourers dealt with?", done="Good. The dead in the north can rest a little easier.",
          kill=[(8605, 10)]),
    quest(900100, 11038, "Caretaker Alen", "Stitched Together", PLAGUELANDS, 56, 60,
          log="Kill 8 Stitched Horrors in the north-west of the Eastern Plaguelands, then return to Caretaker Alen at Light's Hope Chapel.",
          text="The stitched horrors are an abomination, $N: our dead sewn together into something worse. They guard the Scourge's camps in the north-west.$B$BCut them apart. Eight of them, and let what was stitched together find rest.",
          ret="Return to Caretaker Alen at Light's Hope Chapel.",
          ask="Are the horrors undone?", done="Then those poor souls can be laid to rest at last. Thank you.",
          kill=[(8543, 8)]),
]
