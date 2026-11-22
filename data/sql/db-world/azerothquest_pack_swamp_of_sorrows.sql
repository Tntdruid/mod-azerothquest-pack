-- Target database: acore_world
--
-- AzerothQuest quest pack: Swamp of Sorrows, levels 34-46. The thinnest zone for the Alliance in the Eastern
-- Kingdoms: 11 quests, most of the zone's quests are Stonard's (Horde). Five new quests on mobs no quest uses today,
-- from NPCs already standing in the swamp:
--   Watcher Biggs (Stormwind, the watch post on the western border), Anchorite Avuun (draenei, among the Lost Ones),
--   the Fallen Hero of the Horde (neutral) and Galen Goodward (neutral).
--
-- Same build as the pilot pack (2026-11-20_quest_pack_badlands_searing_blasted.sql): QuestLevel -1 with XP and money
-- by the player's level, MinLevel and MaxLevel within the zone's levels, quest-required multi-drop quest items
-- copied from Blasted Boar Lung with an existing display ID. IDs: quests 900010-900014, items 900005-900006.
--
-- Safe to run twice. Restart the worldserver afterwards and delete the client's Cache folder.

-- ---------------------------------------------------------------- items
DELETE FROM `item_template` WHERE `entry` BETWEEN 900005 AND 900006;
DROP TEMPORARY TABLE IF EXISTS `aq_item`;
CREATE TEMPORARY TABLE `aq_item` SELECT * FROM `item_template` WHERE `entry` = 8392;  -- Blasted Boar Lung
UPDATE `aq_item` SET `entry` = 900005, `name` = 'Sawtooth Fang', `displayid` = 2460,
	`description` = 'Serrated like a saw.' WHERE `entry` = 8392;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
UPDATE `aq_item` SET `entry` = 900006, `name` = 'Silt Crawler Carapace', `displayid` = 21363,
	`description` = 'Caked with swamp mud.' WHERE `entry` = 900005;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
DROP TEMPORARY TABLE `aq_item`;
UPDATE `item_template` SET `class` = 12, `subclass` = 0, `Quality` = 1, `bonding` = 4, `stackable` = 20,
	`maxcount` = 0, `Flags` = 0x800, `BuyPrice` = 0, `SellPrice` = 0, `startquest` = 0
WHERE `entry` BETWEEN 900005 AND 900006;

-- ---------------------------------------------------------------- loot (quest required)
DELETE FROM `creature_loot_template` WHERE `Item` BETWEEN 900005 AND 900006;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1082, 900005, 0, 40, 1, 1, 0, 1, 1, 'Sawtooth Crocolisk - Sawtooth Fang (AzerothQuest pack)'),
(1087, 900005, 0, 50, 1, 1, 0, 1, 1, 'Sawtooth Snapper - Sawtooth Fang (AzerothQuest pack)'),
(922, 900006, 0, 45, 1, 1, 0, 1, 1, 'Silt Crawler - Silt Crawler Carapace (AzerothQuest pack)'),
(1088, 900006, 0, 55, 1, 1, 0, 1, 1, 'Monstrous Crawler - Silt Crawler Carapace (AzerothQuest pack)');

-- ---------------------------------------------------------------- quests (QuestSortID 8: Swamp of Sorrows)
DELETE FROM `quest_template` WHERE `ID` BETWEEN 900010 AND 900014;
INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`,
	`RewardXPDifficulty`, `RewardMoney`, `RewardMoneyDifficulty`, `Flags`, `AllowableRaces`,
	`LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`,
	`RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`,
	`RequiredItemId1`, `RequiredItemCount1`, `VerifiedBuild`) VALUES
(900010, 2, -1, 37, 8, 0, 0, 5, 0, 5, 8, 0, 'Sawtooth Trouble',
	'Bring 8 Sawtooth Fangs to Watcher Biggs at the Swamp of Sorrows border.',
	'Every patrol I send along the water comes back short a boot or a leg, $N. The Sawtooth crocolisks and snappers have no fear of us anymore.$B$BBring me their fangs. When Stormwind asks why I need more men, I want something to put on the table.',
	'', 'Return to Watcher Biggs at the Swamp of Sorrows border.',
	0, 0, 0, 0, 900005, 8, 0),
(900011, 2, -1, 38, 8, 0, 0, 5, 0, 5, 8, 0, 'Choking Vines',
	'Destroy 10 Tangled Horrors in the south-east of the Swamp of Sorrows, then return to Watcher Biggs.',
	'Something in this swamp makes the very plants walk. The Tangled Horrors in the south-east grow thicker every season and strangle anything that stops to rest.$B$BCut them down, $C. Ten of them, and the road south might stay open a while longer.',
	'', 'Return to Watcher Biggs at the Swamp of Sorrows border.',
	766, 0, 10, 0, 0, 0, 0),
(900012, 2, -1, 34, 8, 0, 0, 5, 0, 5, 8, 1101, 'Rest for the Lost',
	'Free 8 Lost One Hunters and 8 Lost One Muckdwellers from their torment, then return to Anchorite Avuun.',
	'The Lost Ones were draenei once, $N, as I am. The corruption took their minds long ago, and what is left of them hunts in the north of this swamp.$B$BI cannot heal them. But I can ask you to give them peace. Do it quickly, and do it kindly, if you can.',
	'', 'Return to Anchorite Avuun in the Swamp of Sorrows.',
	759, 760, 8, 8, 0, 0, 0),
(900013, 2, -1, 38, 8, 0, 0, 5, 0, 5, 8, 0, 'Webs over the Dead',
	'Kill 12 Deathstrike Tarantulas in the Swamp of Sorrows, then return to the Fallen Hero of the Horde.',
	'My brothers fell in this swamp, mortal, and they do not rest. The Deathstrike Tarantulas spin their webs over the dead and feed where they lie.$B$BI cannot hold a blade anymore. You can. Kill the spiders, and let the fallen be.',
	'', 'Return to the Fallen Hero of the Horde in the Swamp of Sorrows.',
	769, 0, 12, 0, 0, 0, 0),
(900014, 2, -1, 39, 8, 0, 0, 5, 0, 5, 8, 0, 'Shells of the Northern Shore',
	'Bring 8 Silt Crawler Carapaces to Galen Goodward in the Swamp of Sorrows.',
	'If I ever get out of this swamp, I am not going home empty-handed. The crawlers on the northern shore have shells harder than any shield, and an armorer in Stormwind would pay well for them.$B$BBring me eight carapaces, $N, and I will share what they fetch.',
	'', 'Return to Galen Goodward in the Swamp of Sorrows.',
	0, 0, 0, 0, 900006, 8, 0);

DELETE FROM `quest_template_addon` WHERE `ID` BETWEEN 900010 AND 900014;
INSERT INTO `quest_template_addon` (`ID`, `MaxLevel`) VALUES
(900010, 46), (900011, 46), (900012, 42), (900013, 46), (900014, 47);

DELETE FROM `quest_request_items` WHERE `ID` BETWEEN 900010 AND 900014;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`, `VerifiedBuild`) VALUES
(900010, 1, 1, 'Fangs, $N?', 0),
(900011, 1, 1, 'Is the road south clear?', 0),
(900012, 1, 1, 'Have they found their peace?', 0),
(900013, 1, 1, 'Do the dead rest, mortal?', 0),
(900014, 1, 1, 'Got my shells?', 0);

DELETE FROM `quest_offer_reward` WHERE `ID` BETWEEN 900010 AND 900014;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `RewardText`, `VerifiedBuild`) VALUES
(900010, 1, 'That is a full set of teeth. Stormwind will listen now. Thank you, $N.', 0),
(900011, 2, 'The vines will grow back, they always do. But not today. Well done.', 0),
(900012, 1, 'Thank you, $N. May the Light take them where I could not.', 0),
(900013, 1, 'The webs are gone. My brothers sleep. You have the thanks of the fallen.', 0),
(900014, 4, 'Look at these! Hard as stone. Here, your share, as promised.', 0);

-- ---------------------------------------------------------------- givers
DELETE FROM `creature_queststarter` WHERE `quest` BETWEEN 900010 AND 900014;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(5476, 900010), (5476, 900011),  -- Watcher Biggs
(17127, 900012),                 -- Anchorite Avuun
(7572, 900013),                  -- Fallen Hero of the Horde
(5391, 900014);                  -- Galen Goodward
DELETE FROM `creature_questender` WHERE `quest` BETWEEN 900010 AND 900014;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(5476, 900010), (5476, 900011), (17127, 900012), (7572, 900013), (5391, 900014);

-- Revert:
-- DELETE FROM `creature_queststarter` WHERE `quest` BETWEEN 900010 AND 900014;
-- DELETE FROM `creature_questender` WHERE `quest` BETWEEN 900010 AND 900014;
-- DELETE FROM `quest_offer_reward` WHERE `ID` BETWEEN 900010 AND 900014;
-- DELETE FROM `quest_request_items` WHERE `ID` BETWEEN 900010 AND 900014;
-- DELETE FROM `quest_template_addon` WHERE `ID` BETWEEN 900010 AND 900014;
-- DELETE FROM `quest_template` WHERE `ID` BETWEEN 900010 AND 900014;
-- DELETE FROM `creature_loot_template` WHERE `Item` BETWEEN 900005 AND 900006;
-- DELETE FROM `item_template` WHERE `entry` BETWEEN 900005 AND 900006;
