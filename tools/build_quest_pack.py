"""Build a quest pack's SQL from a spec: new scaling quests for the AzerothCore server.

A spec (a .py file next to this one, such as kalimdor.py) defines:
  TITLE    a line for the file's header
  HEADER   the header's explanation (list of lines)
  ITEMS    [(entry, name, display ID, description, [(creature entry, chance %), ...]), ...]
  QUESTS   [dict(id, giver, title, sort, min, max, races, kill=[(creature, count), ...], item=(entry, count),
                 log, text, ask, done, emote), ...]

Every quest has QuestLevel -1 (the player's level), XP and money by RewardXPDifficulty and RewardMoneyDifficulty 5
(quest_money_reward, by level), MinLevel and quest_template_addon.MaxLevel for the zone's levels. Items are copies of
Blasted Boar Lung (a quest item) with their own name and display ID, quest-required loot with ITEM_FLAG_MULTI_DROP
(every group member with the quest loots their own, bots included). The SQL deletes before it inserts, so it can be
run twice, and ends with a revert block. The worldserver applies data/sql/db-world/ by itself.

Usage (from the module root):
    python -I tools/build_quest_pack.py tools/specs/kalimdor.py data/sql/db-world/azerothquest_pack_kalimdor.sql
"""
import runpy
import sys

TEMPLATE_ITEM = 8392  # Blasted Boar Lung


def sql(text):
    return "'" + text.replace("\\", "\\\\").replace("'", "''") + "'"


def ids_clause(column, ids):
    ids = sorted(ids)
    if ids == list(range(ids[0], ids[-1] + 1)):
        return "`%s` BETWEEN %d AND %d" % (column, ids[0], ids[-1]) if len(ids) > 1 else "`%s` = %d" % (column, ids[0])
    return "`%s` IN (%s)" % (column, ", ".join(map(str, ids)))


def build(spec):
    items, quests = spec["ITEMS"], spec["QUESTS"]
    item_ids = [item[0] for item in items]
    quest_ids = [quest["id"] for quest in quests]
    out = ["-- Target database: acore_world", "--", "-- AzerothQuest quest pack: " + spec["TITLE"]]
    out += ["-- " + line if line else "--" for line in spec["HEADER"]]
    out += ["--",
            "-- Built by tools/questpack/build_quest_pack.py: QuestLevel -1 with XP and money by the player's level,",
            "-- MinLevel and MaxLevel within the zone's levels, quest-required multi-drop quest items copied from",
            "-- Blasted Boar Lung with an existing display ID. Quests %d-%d, items %s." % (
                min(quest_ids), max(quest_ids), "%d-%d" % (min(item_ids), max(item_ids)) if item_ids else "none"),
            "--", "-- Safe to run twice. Restart the worldserver afterwards and delete the client's Cache folder.", ""]
    if items:
        out += ["-- ---------------------------------------------------------------- items",
                "DELETE FROM `item_template` WHERE %s;" % ids_clause("entry", item_ids),
                "DROP TEMPORARY TABLE IF EXISTS `aq_item`;",
                "CREATE TEMPORARY TABLE `aq_item` SELECT * FROM `item_template` WHERE `entry` = %d;  -- Blasted Boar Lung"
                % TEMPLATE_ITEM]
        previous = TEMPLATE_ITEM
        for entry, name, display, description, _ in items:
            out.append("UPDATE `aq_item` SET `entry` = %d, `name` = %s, `displayid` = %d, `description` = %s WHERE `entry` = %d;"
                       % (entry, sql(name), display, sql(description), previous))
            out.append("INSERT INTO `item_template` SELECT * FROM `aq_item`;")
            previous = entry
        out += ["DROP TEMPORARY TABLE `aq_item`;",
                "UPDATE `item_template` SET `class` = 12, `subclass` = 0, `Quality` = 1, `bonding` = 4, `stackable` = 20,",
                "\t`maxcount` = 0, `Flags` = 0x800, `BuyPrice` = 0, `SellPrice` = 0, `startquest` = 0",
                "WHERE %s;" % ids_clause("entry", item_ids), "",
                "-- ---------------------------------------------------------------- loot (quest required)",
                "DELETE FROM `creature_loot_template` WHERE %s;" % ids_clause("Item", item_ids),
                "INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, "
                "`GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES"]
        loot = []
        for entry, name, _, _, sources in items:
            for creature, chance, creature_name in sources:
                loot.append("(%d, %d, 0, %d, 1, 1, 0, 1, 1, %s)" % (
                    creature, entry, chance, sql("%s - %s (AzerothQuest pack)" % (creature_name, name))))
        out += [",\n".join(loot) + ";", ""]
    out += ["-- ---------------------------------------------------------------- quests",
            "DELETE FROM `quest_template` WHERE %s;" % ids_clause("ID", quest_ids),
            "INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, "
            "`SuggestedGroupNum`,",
            "\t`RewardXPDifficulty`, `RewardMoney`, `RewardMoneyDifficulty`, `Flags`, `AllowableRaces`,",
            "\t`LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`,",
            "\t`RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`,",
            "\t`RequiredItemId1`, `RequiredItemCount1`, `VerifiedBuild`) VALUES"]
    rows = []
    for quest in quests:
        kills = quest.get("kill", []) + [(0, 0)] * (2 - len(quest.get("kill", [])))
        item, count = quest.get("item", (0, 0))
        # No comments between the rows: a name with an apostrophe (Mor'rogal) in one can confuse HeidiSQL's split.
        rows.append("(%d, 2, -1, %d, %d, 0, 0, 5, 0, 5, 8, %d, %s,\n\t%s,\n\t%s,\n\t'', %s,\n\t%d, %d, %d, %d, %d, %d, 0)" % (
            quest["id"], quest["min"], quest["sort"], quest.get("races", 0),
            sql(quest["title"]), sql(quest["log"]), sql(quest["text"]), sql(quest["return"]),
            kills[0][0], kills[1][0], kills[0][1], kills[1][1], item, count))
    out += [",\n".join(rows) + ";", "",
            "DELETE FROM `quest_template_addon` WHERE %s;" % ids_clause("ID", quest_ids),
            "INSERT INTO `quest_template_addon` (`ID`, `MaxLevel`) VALUES",
            ",\n".join("(%d, %d)" % (quest["id"], quest["max"]) for quest in quests) + ";", "",
            "DELETE FROM `quest_request_items` WHERE %s;" % ids_clause("ID", quest_ids),
            "INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`, `VerifiedBuild`) VALUES",
            ",\n".join("(%d, 1, 1, %s, 0)" % (quest["id"], sql(quest["ask"])) for quest in quests) + ";", "",
            "DELETE FROM `quest_offer_reward` WHERE %s;" % ids_clause("ID", quest_ids),
            "INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `RewardText`, `VerifiedBuild`) VALUES",
            ",\n".join("(%d, %d, %s, 0)" % (quest["id"], quest.get("emote", 1), sql(quest["done"])) for quest in quests) + ";", "",
            "-- ---------------------------------------------------------------- givers",
            "DELETE FROM `creature_queststarter` WHERE %s;" % ids_clause("quest", quest_ids),
            "INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES",
            ",\n".join("(%d, %d)" % (quest["giver"], quest["id"]) for quest in quests) + ";",
            "DELETE FROM `creature_questender` WHERE %s;" % ids_clause("quest", quest_ids),
            "INSERT INTO `creature_questender` (`id`, `quest`) VALUES",
            ",\n".join("(%d, %d)" % (quest["giver"], quest["id"]) for quest in quests) + ";", "",
            "-- Revert:",
            "-- DELETE FROM `creature_queststarter` WHERE %s;" % ids_clause("quest", quest_ids),
            "-- DELETE FROM `creature_questender` WHERE %s;" % ids_clause("quest", quest_ids),
            "-- DELETE FROM `quest_offer_reward` WHERE %s;" % ids_clause("ID", quest_ids),
            "-- DELETE FROM `quest_request_items` WHERE %s;" % ids_clause("ID", quest_ids),
            "-- DELETE FROM `quest_template_addon` WHERE %s;" % ids_clause("ID", quest_ids),
            "-- DELETE FROM `quest_template` WHERE %s;" % ids_clause("ID", quest_ids)]
    if items:
        out += ["-- DELETE FROM `creature_loot_template` WHERE %s;" % ids_clause("Item", item_ids),
                "-- DELETE FROM `item_template` WHERE %s;" % ids_clause("entry", item_ids)]
    return "\n".join(out) + "\n"


if __name__ == "__main__":
    spec = runpy.run_path(sys.argv[1])
    with open(sys.argv[2], "w", encoding="utf-8", newline="\n") as handle:
        handle.write(build(spec))
    print("Wrote %s: %d quests, %d items" % (sys.argv[2], len(spec["QUESTS"]), len(spec["ITEMS"])), file=sys.stderr)
