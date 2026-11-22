-- Target database: acore_world
--
-- AzerothQuest quest pack: Darkshore, levels 12-22.
--
-- 6 quests for the Alliance from Auberdine, for the gap at levels 15-16: the Stormscale naga, moonstalkers,
-- the coastal frenzies, the Blackwood furbolgs, foreststriders and the Dark Strand cultists.
--
-- Built by tools/questpack/build_quest_pack.py: QuestLevel -1 with XP and money by the player's level,
-- MinLevel and MaxLevel within the zone's levels, quest-required multi-drop quest items copied from
-- Blasted Boar Lung with an existing display ID. Quests 900073-900078, items 900023-900024.
--
-- Safe to run twice. Restart the worldserver afterwards and delete the client's Cache folder.

-- ---------------------------------------------------------------- items
DELETE FROM `item_template` WHERE `entry` BETWEEN 900023 AND 900024;
DROP TEMPORARY TABLE IF EXISTS `aq_item`;
CREATE TEMPORARY TABLE `aq_item` SELECT * FROM `item_template` WHERE `entry` = 8392;  -- Blasted Boar Lung
UPDATE `aq_item` SET `entry` = 900023, `name` = 'Moonstalker Pelt', `displayid` = 8794, `description` = 'Soft, and silver in the moonlight.' WHERE `entry` = 8392;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
UPDATE `aq_item` SET `entry` = 900024, `name` = 'Foreststrider Plume', `displayid` = 19572, `description` = 'Long, and the color of moss.' WHERE `entry` = 900023;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
DROP TEMPORARY TABLE `aq_item`;
UPDATE `item_template` SET `class` = 12, `subclass` = 0, `Quality` = 1, `bonding` = 4, `stackable` = 20,
	`maxcount` = 0, `Flags` = 0x800, `BuyPrice` = 0, `SellPrice` = 0, `startquest` = 0
WHERE `entry` BETWEEN 900023 AND 900024;

-- ---------------------------------------------------------------- loot (quest required)
DELETE FROM `creature_loot_template` WHERE `Item` BETWEEN 900023 AND 900024;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2069, 900023, 0, 50, 1, 1, 0, 1, 1, 'Moonstalker - Moonstalker Pelt (AzerothQuest pack)'),
(2322, 900024, 0, 50, 1, 1, 0, 1, 1, 'Foreststrider - Foreststrider Plume (AzerothQuest pack)');

-- ---------------------------------------------------------------- quests
DELETE FROM `quest_template` WHERE `ID` BETWEEN 900073 AND 900078;
INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`,
	`RewardXPDifficulty`, `RewardMoney`, `RewardMoneyDifficulty`, `Flags`, `AllowableRaces`,
	`LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`,
	`RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`,
	`RequiredItemId1`, `RequiredItemCount1`, `VerifiedBuild`) VALUES
(900073, 2, -1, 13, 148, 0, 0, 5, 0, 5, 8, 1101, 'Stormscale Raiders',
	'Kill 8 Stormscale Wave Riders and 8 Stormscale Sirens on the coast north of Auberdine, then return to Sentinel Glynda Nal''Shea.',
	'The Stormscale naga have come ashore north of Auberdine, $N. Their wave riders scout our coast, and their sirens sing our fishers into the sea.$B$BDrive them back into the water. Eight of each should make them think again.',
	'', 'Return to Sentinel Glynda Nal''Shea in Auberdine.',
	2179, 2180, 8, 8, 0, 0, 0),
(900074, 2, -1, 12, 148, 0, 0, 5, 0, 5, 8, 1101, 'Moonstalker Pelts',
	'Bring 8 Moonstalker Pelts to Tharnariun Treetender in Auberdine.',
	'The corruption reaches even the moonstalkers, $N. The ones in the south have grown sick and savage, and they suffer.$B$BEnd their suffering, and bring me their pelts. I will study them, so that one day we may save the others.',
	'', 'Return to Tharnariun Treetender in Auberdine.',
	0, 0, 0, 0, 900023, 8, 0),
(900075, 2, -1, 12, 148, 0, 0, 5, 0, 5, 8, 1101, 'Frenzy in the Water',
	'Kill 10 Coastal Frenzies on the coast of Darkshore, then return to Gubber Blump in Auberdine.',
	'Fish are biting, all right. Biting me! The coastal frenzies south of here have chewed through three of my nets and half my boot.$B$BGo thin them out, $N. Ten of the little monsters, and I can fish in peace again.',
	'', 'Return to Gubber Blump in Auberdine.',
	2174, 0, 10, 0, 0, 0, 0),
(900076, 2, -1, 14, 148, 0, 0, 5, 0, 5, 8, 1101, 'Blackwood Corruption',
	'Kill 10 Blackwood Warriors in Darkshore, then return to Terenthis in Auberdine.',
	'The Blackwood furbolgs were our friends once, $N. Now something corrupts them, and their warriors attack anyone who comes near their camps in the north-east.$B$BI wish there were another way. There is not. Ten of their warriors, and their camps will be quieter.',
	'', 'Return to Terenthis in Auberdine.',
	2168, 0, 10, 0, 0, 0, 0),
(900077, 2, -1, 12, 148, 0, 0, 5, 0, 5, 8, 1101, 'Foreststrider Plumes',
	'Bring 8 Foreststrider Plumes to Gorbold Steelhand in Auberdine.',
	'The night elves make the finest arrow fletchings out of foreststrider plumes, and I mean to learn how. A dwarf can always learn something new!$B$BThe foreststriders roam the hills in the north. Bring me eight plumes, $N.',
	'', 'Return to Gorbold Steelhand in Auberdine.',
	0, 0, 0, 0, 900024, 8, 0),
(900078, 2, -1, 14, 148, 0, 0, 5, 0, 5, 8, 1101, 'Dark Strand Fanatics',
	'Kill 10 Dark Strand Fanatics in the north of Darkshore, then return to Archaeologist Hollee in Auberdine.',
	'The Dark Strand cultists dig in the old ruins of the north, and they are not looking for history. Whatever they hope to find, I do not want them to find it.$B$BTheir fanatics guard the digs. Ten of them, $N, and my own work can go on.',
	'', 'Return to Archaeologist Hollee in Auberdine.',
	2336, 0, 10, 0, 0, 0, 0);

DELETE FROM `quest_template_addon` WHERE `ID` BETWEEN 900073 AND 900078;
INSERT INTO `quest_template_addon` (`ID`, `MaxLevel`) VALUES
(900073, 21),
(900074, 20),
(900075, 20),
(900076, 22),
(900077, 20),
(900078, 22);

DELETE FROM `quest_request_items` WHERE `ID` BETWEEN 900073 AND 900078;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`, `VerifiedBuild`) VALUES
(900073, 1, 1, 'Are the naga driven back?', 0),
(900074, 1, 1, 'Did you bring the pelts?', 0),
(900075, 1, 1, 'Did you get the frenzies?', 0),
(900076, 1, 1, 'Is it done?', 0),
(900077, 1, 1, 'Plumes, lad?', 0),
(900078, 1, 1, 'Are the cultists dealt with?', 0);

DELETE FROM `quest_offer_reward` WHERE `ID` BETWEEN 900073 AND 900078;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `RewardText`, `VerifiedBuild`) VALUES
(900073, 1, 'Elune guided your hand. The coast is safer tonight.', 0),
(900074, 1, 'Thank you. Their suffering has meaning now, if I can learn from it.', 0),
(900075, 4, 'Ha! My nets thank you. My boot thanks you. Here, have some coin.', 0),
(900076, 1, 'A sad task, but a needed one. Thank you, $N.', 0),
(900077, 1, 'Fine plumes! These will fly true. Here, for your trouble.', 0),
(900078, 1, 'Splendid! The ruins are ours again. Thank you, $N.', 0);

-- ---------------------------------------------------------------- givers
DELETE FROM `creature_queststarter` WHERE `quest` BETWEEN 900073 AND 900078;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(2930, 900073),
(3701, 900074),
(10216, 900075),
(3693, 900076),
(6301, 900077),
(2913, 900078);
DELETE FROM `creature_questender` WHERE `quest` BETWEEN 900073 AND 900078;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(2930, 900073),
(3701, 900074),
(10216, 900075),
(3693, 900076),
(6301, 900077),
(2913, 900078);

-- Revert:
-- DELETE FROM `creature_queststarter` WHERE `quest` BETWEEN 900073 AND 900078;
-- DELETE FROM `creature_questender` WHERE `quest` BETWEEN 900073 AND 900078;
-- DELETE FROM `quest_offer_reward` WHERE `ID` BETWEEN 900073 AND 900078;
-- DELETE FROM `quest_request_items` WHERE `ID` BETWEEN 900073 AND 900078;
-- DELETE FROM `quest_template_addon` WHERE `ID` BETWEEN 900073 AND 900078;
-- DELETE FROM `quest_template` WHERE `ID` BETWEEN 900073 AND 900078;
-- DELETE FROM `creature_loot_template` WHERE `Item` BETWEEN 900023 AND 900024;
-- DELETE FROM `item_template` WHERE `entry` BETWEEN 900023 AND 900024;
