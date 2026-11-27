-- Target database: acore_world
--
-- AzerothQuest quest pack: Searing Gorge and Blasted Lands, levels 46-55.
--
-- 5 quests for both factions, for the gap at levels 48-49: Searing Lava Spiders, Muck Splashes and the Blazing and
-- Inferno Elementals of Searing Gorge from Thorium Point, and the Redstone Crystalhides of the Blasted Lands from
-- Kum'isha the Collector.
--
-- Built by tools/questpack/build_quest_pack.py: QuestLevel -1 with XP and money by the player's level,
-- MinLevel and MaxLevel within the zone's levels, quest-required multi-drop quest items copied from
-- Blasted Boar Lung with an existing display ID. Quests 900101-900105, items 900031-900032.
--
-- Safe to run twice. Restart the worldserver afterwards and delete the client's Cache folder.

-- ---------------------------------------------------------------- items
DELETE FROM `item_template` WHERE `entry` BETWEEN 900031 AND 900032;
DROP TEMPORARY TABLE IF EXISTS `aq_item`;
CREATE TEMPORARY TABLE `aq_item` SELECT * FROM `item_template` WHERE `entry` = 8392;  -- Blasted Boar Lung
UPDATE `aq_item` SET `entry` = 900031, `name` = 'Smoldering Ember', `displayid` = 9116, `description` = 'It glows without burning, for now.' WHERE `entry` = 8392;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
UPDATE `aq_item` SET `entry` = 900032, `name` = 'Crystalhide Scale', `displayid` = 2874, `description` = 'Hard as stone, and faintly glittering.' WHERE `entry` = 900031;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
DROP TEMPORARY TABLE `aq_item`;
UPDATE `item_template` SET `class` = 12, `subclass` = 0, `Quality` = 1, `bonding` = 4, `stackable` = 20,
	`maxcount` = 0, `Flags` = 0x800, `BuyPrice` = 0, `SellPrice` = 0, `startquest` = 0
WHERE `entry` BETWEEN 900031 AND 900032;

-- ---------------------------------------------------------------- loot (quest required)
DELETE FROM `creature_loot_template` WHERE `Item` BETWEEN 900031 AND 900032;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5850, 900031, 0, 60, 1, 1, 0, 1, 1, 'Blazing Elemental - Smoldering Ember (AzerothQuest pack)'),
(5852, 900031, 0, 60, 1, 1, 0, 1, 1, 'Inferno Elemental - Smoldering Ember (AzerothQuest pack)'),
(5991, 900032, 0, 50, 1, 1, 0, 1, 1, 'Redstone Crystalhide - Crystalhide Scale (AzerothQuest pack)');

-- ---------------------------------------------------------------- quests
DELETE FROM `quest_template` WHERE `ID` BETWEEN 900101 AND 900105;
INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`,
	`RewardXPDifficulty`, `RewardMoney`, `RewardMoneyDifficulty`, `Flags`, `AllowableRaces`,
	`LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`,
	`RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`,
	`RequiredItemId1`, `RequiredItemCount1`, `VerifiedBuild`) VALUES
(900101, 2, -1, 46, 51, 0, 0, 5, 0, 5, 8, 0, 'Spiders of the Gorge',
	'Kill 12 Searing Lava Spiders in the south of Searing Gorge, then return to Hansel Heavyhands at Thorium Point.',
	'Our ore carts go south through the gorge, $N, and the searing lava spiders down there have taken a liking to our mules.$B$BThin them out. Twelve of them, and the carts can roll again.',
	'', 'Return to Hansel Heavyhands at Thorium Point.',
	5857, 0, 12, 0, 0, 0, 0),
(900102, 2, -1, 47, 51, 0, 0, 5, 0, 5, 8, 0, 'Muck in the Water',
	'Kill 10 Muck Splashes at the lake in the west of Searing Gorge, then return to Evonice Sootsmoker at Thorium Point.',
	'The only clean water in this gorge is the lake to the west, and something foul has crawled out of the muck there. Muck splashes, the miners call them.$B$BWe need that water, $N. Ten of them, and we can fill our barrels again.',
	'', 'Return to Evonice Sootsmoker at Thorium Point.',
	8837, 0, 10, 0, 0, 0, 0),
(900103, 2, -1, 47, 51, 0, 0, 5, 0, 5, 8, 0, 'Smoldering Embers',
	'Bring 8 Smoldering Embers from the Blazing and Inferno Elementals of Searing Gorge to Master Smith Burninate at Thorium Point.',
	'An ember from a living flame burns hotter than any coal, $N, and a smith of the Brotherhood knows what to do with that.$B$BThe blazing and inferno elementals in the gorge carry such embers. Bring me eight.',
	'', 'Return to Master Smith Burninate at Thorium Point.',
	0, 0, 0, 0, 900031, 8, 0),
(900104, 2, -1, 48, 4, 0, 0, 5, 0, 5, 8, 0, 'Crystalhide Scales',
	'Bring 8 Crystalhide Scales from the Redstone Crystalhides of the Blasted Lands to Kum''isha the Collector.',
	'The redstone crystalhides of this blasted land grow scales that glitter like gems, $N. A collector such as I cannot resist them.$B$BBring me eight. I will make it worth your while.',
	'', 'Return to Kum''isha the Collector at the Dark Portal.',
	0, 0, 0, 0, 900032, 8, 0),
(900105, 2, -1, 47, 51, 0, 0, 5, 0, 5, 8, 0, 'Elementals of the Gorge',
	'Kill 5 Blazing Elementals and 5 Inferno Elementals in Searing Gorge, then return to Hansel Heavyhands at Thorium Point.',
	'Fire walks the gorge on its own legs now, $N. The blazing and inferno elementals set our camps alight whenever they wander close.$B$BPut out five of each.',
	'', 'Return to Hansel Heavyhands at Thorium Point.',
	5850, 5852, 5, 5, 0, 0, 0);

DELETE FROM `quest_template_addon` WHERE `ID` BETWEEN 900101 AND 900105;
INSERT INTO `quest_template_addon` (`ID`, `MaxLevel`) VALUES
(900101, 52),
(900102, 53),
(900103, 53),
(900104, 55),
(900105, 53);

DELETE FROM `quest_request_items` WHERE `ID` BETWEEN 900101 AND 900105;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`, `VerifiedBuild`) VALUES
(900101, 1, 1, 'Are the spiders dealt with?', 0),
(900102, 1, 1, 'Is the lake clear?', 0),
(900103, 1, 1, 'Have you the embers?', 0),
(900104, 1, 1, 'Do you have the scales?', 0),
(900105, 1, 1, 'Are the fires out?', 0);

DELETE FROM `quest_offer_reward` WHERE `ID` BETWEEN 900101 AND 900105;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `RewardText`, `VerifiedBuild`) VALUES
(900101, 1, 'Good work. The mules thank you, and so does the Brotherhood.', 0),
(900102, 1, 'Clean water at last! You have my thanks.', 0),
(900103, 1, 'Feel that heat! These will make a fine blade or two.', 0),
(900104, 1, 'Beautiful! Look how they catch the light. A fine addition to my collection.', 0),
(900105, 1, 'Hah! Doused like a forge at day''s end. Well done.', 0);

-- ---------------------------------------------------------------- givers
DELETE FROM `creature_queststarter` WHERE `quest` BETWEEN 900101 AND 900105;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(14627, 900101),
(14628, 900102),
(14624, 900103),
(7363, 900104),
(14627, 900105);
DELETE FROM `creature_questender` WHERE `quest` BETWEEN 900101 AND 900105;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(14627, 900101),
(14628, 900102),
(14624, 900103),
(7363, 900104),
(14627, 900105);

-- Revert:
-- DELETE FROM `creature_queststarter` WHERE `quest` BETWEEN 900101 AND 900105;
-- DELETE FROM `creature_questender` WHERE `quest` BETWEEN 900101 AND 900105;
-- DELETE FROM `quest_offer_reward` WHERE `ID` BETWEEN 900101 AND 900105;
-- DELETE FROM `quest_request_items` WHERE `ID` BETWEEN 900101 AND 900105;
-- DELETE FROM `quest_template_addon` WHERE `ID` BETWEEN 900101 AND 900105;
-- DELETE FROM `quest_template` WHERE `ID` BETWEEN 900101 AND 900105;
-- DELETE FROM `creature_loot_template` WHERE `Item` BETWEEN 900031 AND 900032;
-- DELETE FROM `item_template` WHERE `entry` BETWEEN 900031 AND 900032;
