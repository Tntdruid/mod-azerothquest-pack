-- Target database: acore_world
--
-- AzerothQuest quest pack: Eastern Plaguelands, levels 53-60.
--
-- 8 quests for both factions from Light's Hope Chapel, for the gap at levels 54-56, from Carlin Redpath and
-- Caretaker Alen (mod-individual-progression hides the chapel's other givers until later): Scourge Soldiers, Cursed Mages,
-- Cannibal Ghouls, Torn Screamers, Putrid Gargoyles, Hate Shriekers, Living Decay, Plague Ravagers, Carrion
-- Devourers and Stitched Horrors.
--
-- Built by tools/questpack/build_quest_pack.py: QuestLevel -1 with XP and money by the player's level,
-- MinLevel and MaxLevel within the zone's levels, quest-required multi-drop quest items copied from
-- Blasted Boar Lung with an existing display ID. Quests 900093-900100, items 900029-900030.
--
-- Safe to run twice. Restart the worldserver afterwards and delete the client's Cache folder.

-- ---------------------------------------------------------------- items
DELETE FROM `item_template` WHERE `entry` BETWEEN 900029 AND 900030;
DROP TEMPORARY TABLE IF EXISTS `aq_item`;
CREATE TEMPORARY TABLE `aq_item` SELECT * FROM `item_template` WHERE `entry` = 8392;  -- Blasted Boar Lung
UPDATE `aq_item` SET `entry` = 900029, `name` = 'Sample of Living Decay', `displayid` = 21972, `description` = 'It rots the glass it is kept in.' WHERE `entry` = 8392;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
UPDATE `aq_item` SET `entry` = 900030, `name` = 'Ravager Plague Gland', `displayid` = 8940, `description` = 'Swollen, and warm to the touch.' WHERE `entry` = 900029;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
DROP TEMPORARY TABLE `aq_item`;
UPDATE `item_template` SET `class` = 12, `subclass` = 0, `Quality` = 1, `bonding` = 4, `stackable` = 20,
	`maxcount` = 0, `Flags` = 0x800, `BuyPrice` = 0, `SellPrice` = 0, `startquest` = 0
WHERE `entry` BETWEEN 900029 AND 900030;

-- ---------------------------------------------------------------- loot (quest required)
DELETE FROM `creature_loot_template` WHERE `Item` BETWEEN 900029 AND 900030;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(8606, 900029, 0, 50, 1, 1, 0, 1, 1, 'Living Decay - Sample of Living Decay (AzerothQuest pack)'),
(8520, 900030, 0, 60, 1, 1, 0, 1, 1, 'Plague Ravager - Ravager Plague Gland (AzerothQuest pack)');

-- ---------------------------------------------------------------- quests
DELETE FROM `quest_template` WHERE `ID` BETWEEN 900093 AND 900100;
INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`,
	`RewardXPDifficulty`, `RewardMoney`, `RewardMoneyDifficulty`, `Flags`, `AllowableRaces`,
	`LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`,
	`RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`,
	`RequiredItemId1`, `RequiredItemCount1`, `VerifiedBuild`) VALUES
(900093, 2, -1, 53, 139, 0, 0, 5, 0, 5, 8, 0, 'The Scourge Muster',
	'Kill 10 Scourge Soldiers and 6 Cursed Mages in the north-west of the Eastern Plaguelands, then return to Carlin Redpath at Light''s Hope Chapel.',
	'The Scourge are gathering soldiers in the north-west, near Terrordale, and their cursed mages raise more every night. I saw what such an army did to Darrowshire.$B$BDo not let it grow, $N. Ten soldiers and six of their mages, and the muster will be broken before it marches.',
	'', 'Return to Carlin Redpath at Light''s Hope Chapel.',
	8523, 8524, 10, 6, 0, 0, 0),
(900094, 2, -1, 53, 139, 0, 0, 5, 0, 5, 8, 0, 'Hunger in the Plaguewood',
	'Kill 10 Cannibal Ghouls and 8 Torn Screamers in the north-west of the Eastern Plaguelands, then return to Caretaker Alen at Light''s Hope Chapel.',
	'I tend the dead here, $N, but in the north-west there are none left to tend. The cannibal ghouls devour the fallen before we can give them rest, and the torn screamers fill the air with their cries.$B$BTen ghouls and eight screamers, and some of the fallen may yet be buried.',
	'', 'Return to Caretaker Alen at Light''s Hope Chapel.',
	8530, 8540, 10, 8, 0, 0, 0),
(900095, 2, -1, 54, 139, 0, 0, 5, 0, 5, 8, 0, 'Stone Wings over Darrowshire',
	'Kill 10 Putrid Gargoyles in the Eastern Plaguelands, then return to Carlin Redpath at Light''s Hope Chapel.',
	'My home is ash, $N, but the sky over it should at least be free of those putrid gargoyles. They circle the old roads looking for travellers.$B$BKill ten of them. Do it for Darrowshire.',
	'', 'Return to Carlin Redpath at Light''s Hope Chapel.',
	8534, 0, 10, 0, 0, 0, 0),
(900096, 2, -1, 55, 139, 0, 0, 5, 0, 5, 8, 0, 'Corin''s Crossing',
	'Kill 10 Hate Shriekers at Corin''s Crossing, then return to Carlin Redpath at Light''s Hope Chapel.',
	'Corin''s Crossing was a town once, like Darrowshire. Now it is a Scourge stronghold in the heart of the plaguelands, and its hate shriekers drive off any who come near.$B$BWe will take it back one day. Today, kill ten of the shriekers, $N.',
	'', 'Return to Carlin Redpath at Light''s Hope Chapel.',
	8541, 0, 10, 0, 0, 0, 0),
(900097, 2, -1, 55, 139, 0, 0, 5, 0, 5, 8, 0, 'Samples of Living Decay',
	'Bring 8 Samples of Living Decay to Caretaker Alen at Light''s Hope Chapel.',
	'The living decay south-east of here is the plague grown a body of its own, $N. If we understand how it rots the living, perhaps we can keep it from the wounded we tend.$B$BBring me eight samples. Keep them sealed.',
	'', 'Return to Caretaker Alen at Light''s Hope Chapel.',
	0, 0, 0, 0, 900029, 8, 0),
(900098, 2, -1, 55, 139, 0, 0, 5, 0, 5, 8, 0, 'The Ravagers'' Plague',
	'Bring 8 Ravager Plague Glands to Caretaker Alen at Light''s Hope Chapel.',
	'The plague ravagers in the south carry the plague in glands under their hide. If we can study them, the Argent Dawn may learn to cure what the ravagers spread.$B$BBring me eight glands, $N. Gently.',
	'', 'Return to Caretaker Alen at Light''s Hope Chapel.',
	0, 0, 0, 0, 900030, 8, 0),
(900099, 2, -1, 56, 139, 0, 0, 5, 0, 5, 8, 0, 'Devourers of the Dead',
	'Kill 10 Carrion Devourers in the north of the Eastern Plaguelands, then return to Carlin Redpath at Light''s Hope Chapel.',
	'The carrion devourers in the north feed on the dead, $N, and what they eat comes back as more Scourge.$B$BKill ten of them. Every one is a body the Scourge will not get.',
	'', 'Return to Carlin Redpath at Light''s Hope Chapel.',
	8605, 0, 10, 0, 0, 0, 0),
(900100, 2, -1, 56, 139, 0, 0, 5, 0, 5, 8, 0, 'Stitched Together',
	'Kill 8 Stitched Horrors in the north-west of the Eastern Plaguelands, then return to Caretaker Alen at Light''s Hope Chapel.',
	'The stitched horrors are an abomination, $N: our dead sewn together into something worse. They guard the Scourge''s camps in the north-west.$B$BCut them apart. Eight of them, and let what was stitched together find rest.',
	'', 'Return to Caretaker Alen at Light''s Hope Chapel.',
	8543, 0, 8, 0, 0, 0, 0);

DELETE FROM `quest_template_addon` WHERE `ID` BETWEEN 900093 AND 900100;
INSERT INTO `quest_template_addon` (`ID`, `MaxLevel`) VALUES
(900093, 60),
(900094, 60),
(900095, 60),
(900096, 60),
(900097, 60),
(900098, 60),
(900099, 60),
(900100, 60);

DELETE FROM `quest_request_items` WHERE `ID` BETWEEN 900093 AND 900100;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`, `VerifiedBuild`) VALUES
(900093, 1, 1, 'Is the muster broken?', 0),
(900094, 1, 1, 'Have the fallen been spared?', 0),
(900095, 1, 1, 'Are the skies clear?', 0),
(900096, 1, 1, 'How fares Corin''s Crossing?', 0),
(900097, 1, 1, 'Did you bring the samples?', 0),
(900098, 1, 1, 'Do you have the glands?', 0),
(900099, 1, 1, 'Are the devourers dealt with?', 0),
(900100, 1, 1, 'Are the horrors undone?', 0);

DELETE FROM `quest_offer_reward` WHERE `ID` BETWEEN 900093 AND 900100;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `RewardText`, `VerifiedBuild`) VALUES
(900093, 1, 'Well fought. No town will burn the way mine did, not to that army.', 0),
(900094, 1, 'The Light thanks you, and so do the dead you spared.', 0),
(900095, 1, 'Thank you. It is a small thing, but it matters to me.', 0),
(900096, 1, 'Ten fewer. The day we retake it comes closer.', 0),
(900097, 1, 'Thank you. I will study them carefully, and far from the beds.', 0),
(900098, 1, 'Thank you. These will help more than you know.', 0),
(900099, 1, 'Good. The dead in the north can rest a little easier.', 0),
(900100, 1, 'Then those poor souls can be laid to rest at last. Thank you.', 0);

-- ---------------------------------------------------------------- givers
DELETE FROM `creature_queststarter` WHERE `quest` BETWEEN 900093 AND 900100;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(11063, 900093),
(11038, 900094),
(11063, 900095),
(11063, 900096),
(11038, 900097),
(11038, 900098),
(11063, 900099),
(11038, 900100);
DELETE FROM `creature_questender` WHERE `quest` BETWEEN 900093 AND 900100;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(11063, 900093),
(11038, 900094),
(11063, 900095),
(11063, 900096),
(11038, 900097),
(11038, 900098),
(11063, 900099),
(11038, 900100);

-- Revert:
-- DELETE FROM `creature_queststarter` WHERE `quest` BETWEEN 900093 AND 900100;
-- DELETE FROM `creature_questender` WHERE `quest` BETWEEN 900093 AND 900100;
-- DELETE FROM `quest_offer_reward` WHERE `ID` BETWEEN 900093 AND 900100;
-- DELETE FROM `quest_request_items` WHERE `ID` BETWEEN 900093 AND 900100;
-- DELETE FROM `quest_template_addon` WHERE `ID` BETWEEN 900093 AND 900100;
-- DELETE FROM `quest_template` WHERE `ID` BETWEEN 900093 AND 900100;
-- DELETE FROM `creature_loot_template` WHERE `Item` BETWEEN 900029 AND 900030;
-- DELETE FROM `item_template` WHERE `entry` BETWEEN 900029 AND 900030;
