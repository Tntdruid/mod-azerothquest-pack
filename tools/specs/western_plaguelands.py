# Quest pack: Western Plaguelands, levels 49-55. The Alliance guide had only 8 quests opening at 48-49 and Chillwind
# Camp's own quests open at 52-53: at 50 a hunter waited with nothing to do. Four quests for each faction, from
# Chillwind Camp and The Bulwark, on the level 50-53 mobs no quest uses: the Skeletal Sorcerers and Blighted Zombies
# of Felstone Field and the Dalson farm, the Diseased Black Bears and Venom Mist Lurkers in the west.
# Build: python -I tools/build_quest_pack.py tools/specs/western_plaguelands.py data/sql/db-world/azerothquest_pack_western_plaguelands.sql
import os
import runpy

quest = runpy.run_path(os.path.join(os.path.dirname(os.path.abspath(__file__)), "kalimdor.py"))["quest"]

TITLE = "Western Plaguelands, levels 49-55."
HEADER = [
    "",
    "8 quests, 4 for each faction, for the gap at levels 50-52: Chillwind Camp's quests open at 52-53. From",
    "Commander Ashlam Valorfist and Alchemist Arbington (Chillwind Camp), High Executor Derrington and Apothecary",
    "Dithers (The Bulwark): Skeletal Sorcerers, Blighted Zombies, Diseased Black Bears and Venom Mist Lurkers.",
]

ALLIANCE, HORDE = 1101, 690
PLAGUELANDS = 28

ITEMS = [
    (900025, "Blighted Bear Heart", 3422, "It still beats, slowly.",
     [(1815, 50, "Diseased Black Bear")]),
    (900026, "Venom Mist Gland", 8940, "It sweats a green mist.",
     [(1822, 50, "Venom Mist Lurker")]),
]

QUESTS = [
    quest(900079, 10838, "Commander Ashlam Valorfist", "Bones of Felstone", PLAGUELANDS, 49, 55, races=ALLIANCE,
          log="Kill 10 Skeletal Sorcerers around Felstone Field and the Dalson farm, then return to Commander Ashlam Valorfist at Chillwind Camp.",
          text="The Scourge raise their dead faster than we can burn them, $N, and the skeletal sorcerers in the farmlands are why.$B$BEvery one of them you put down is a dozen corpses that stay in the ground. Ten of them, and the fields north of here will be quieter for a while.",
          ret="Return to Commander Ashlam Valorfist at Chillwind Camp.",
          ask="Are the sorcerers dealt with?", done="Good work. Fewer of our fallen will rise to fight us.",
          kill=[(1784, 10)]),
    quest(900080, 10838, "Commander Ashlam Valorfist", "The Shambling Dead", PLAGUELANDS, 50, 55, races=ALLIANCE,
          log="Kill 10 Blighted Zombies in the fields of the Western Plaguelands, then return to Commander Ashlam Valorfist at Chillwind Camp.",
          text="Blighted zombies wander the roads between the farms, and every caravan we send north meets them.$B$BClear them out, $N. Ten should keep the road open long enough for our supplies to get through.",
          ret="Return to Commander Ashlam Valorfist at Chillwind Camp.",
          ask="Is the road clear?", done="The caravans will thank you, $N. So do I.",
          kill=[(4475, 10)]),
    quest(900081, 11056, "Alchemist Arbington", "Hearts of the Blight", PLAGUELANDS, 49, 55, races=ALLIANCE,
          log="Bring 8 Blighted Bear Hearts to Alchemist Arbington at Chillwind Camp.",
          text="The plague changes everything it touches, $N, even the bears. The diseased black bears in the west still have beating hearts, and those hearts carry the plague in its purest form.$B$BBring me eight. If I can learn how the plague keeps them alive, perhaps I can learn how to kill it.",
          ret="Return to Alchemist Arbington at Chillwind Camp.",
          ask="Do you have the hearts?", done="Careful, careful... yes, these will do nicely. My research thanks you.",
          item=(900025, 8)),
    quest(900082, 11056, "Alchemist Arbington", "Mist and Venom", PLAGUELANDS, 49, 55, races=ALLIANCE,
          log="Bring 8 Venom Mist Glands to Alchemist Arbington at Chillwind Camp.",
          text="The venom mist lurkers in the west breathe a poison the plague cannot touch. That makes their glands very interesting to me, $N.$B$BBring me eight of them. With luck, their venom is the start of a cure.",
          ret="Return to Alchemist Arbington at Chillwind Camp.",
          ask="The glands, $N?", done="Splendid! Now, if you will excuse me, I have a great deal of work to do.",
          item=(900026, 8)),
    quest(900083, 10837, "High Executor Derrington", "Bones of Felstone", PLAGUELANDS, 49, 55, races=HORDE,
          log="Kill 10 Skeletal Sorcerers around Felstone Field and the Dalson farm, then return to High Executor Derrington at The Bulwark.",
          text="The Scourge's skeletal sorcerers raise the dead of the farmlands as fast as we can cut them down.$B$BThe Dark Lady wants those fields quiet, $N. Kill ten of the sorcerers, and the Scourge will have fewer hands.",
          ret="Return to High Executor Derrington at The Bulwark.",
          ask="Have you dealt with the sorcerers?", done="Well done. The Dark Lady will hear of this.",
          kill=[(1784, 10)]),
    quest(900084, 10837, "High Executor Derrington", "The Shambling Dead", PLAGUELANDS, 50, 55, races=HORDE,
          log="Kill 10 Blighted Zombies in the fields of the Western Plaguelands, then return to High Executor Derrington at The Bulwark.",
          text="Blighted zombies crowd the roads to the farmlands. Our patrols waste their strength on them.$B$BThin them out, $N. Ten of them, and our patrols can get on with real work.",
          ret="Return to High Executor Derrington at The Bulwark.",
          ask="Are the roads clear?", done="Good. The patrols can push further now.",
          kill=[(4475, 10)]),
    quest(900085, 11057, "Apothecary Dithers", "Hearts of the Blight", PLAGUELANDS, 49, 55, races=HORDE,
          log="Bring 8 Blighted Bear Hearts to Apothecary Dithers at The Bulwark.",
          text="The diseased black bears in the west are a gift, $N. Their hearts carry the plague, still beating.$B$BThe Royal Apothecary Society wants to know how. Bring me eight hearts.",
          ret="Return to Apothecary Dithers at The Bulwark.",
          ask="The hearts?", done="Excellent. The Society will be very pleased.",
          item=(900025, 8)),
    quest(900086, 11057, "Apothecary Dithers", "Mist and Venom", PLAGUELANDS, 49, 55, races=HORDE,
          log="Bring 8 Venom Mist Glands to Apothecary Dithers at The Bulwark.",
          text="The venom mist lurkers in the west carry a poison that the plague leaves alone. I want to know why.$B$BBring me eight of their glands, $N.",
          ret="Return to Apothecary Dithers at The Bulwark.",
          ask="Do you have the glands?", done="Yes... yes, these are perfect. Thank you.",
          item=(900026, 8)),
]
