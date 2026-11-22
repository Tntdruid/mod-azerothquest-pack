-- Target database: acore_world
--
-- AzerothQuest quest pack, pilot: nine new quests for levels 40-56 in the Badlands, Searing Gorge and the Blasted
-- Lands, where the Eastern Kingdoms route ran dry and waited for levels (46-50). Each uses mobs no quest uses today
-- and an NPC already standing in the zone as giver, so no new creatures are needed.
--
-- * Scaling: QuestLevel -1 (always the player's level, never grey), XP by RewardXPDifficulty and money by
--   RewardMoneyDifficulty (quest_money_reward, by the player's level). MinLevel and quest_template_addon.MaxLevel
--   keep each quest to its zone's levels, so the mobs stay a fair fight.
-- * Quest items 900001-900004: copies of Blasted Boar Lung (a quest item) with their own name and icon (an existing
--   display ID; AzerothQuest's ItemIcons, built in from CustomItemFix, shows it in the bags). Quest-required loot with
--   ITEM_FLAG_MULTI_DROP: everyone in the group with the quest gets their own, the bots included.
-- * IDs: quests and items 900001-900009, free on the server (mod-individual-progression uses 108743+, test quests
--   90000-99999).
--
-- Safe to run twice: everything is deleted before it is inserted. Restart the worldserver afterwards
-- (item_template is not reloaded by .reload), and delete the client's Cache folder.

-- ---------------------------------------------------------------- items
DELETE FROM `item_template` WHERE `entry` BETWEEN 900001 AND 900004;
DROP TEMPORARY TABLE IF EXISTS `aq_item`;
CREATE TEMPORARY TABLE `aq_item` SELECT * FROM `item_template` WHERE `entry` = 8392;  -- Blasted Boar Lung
UPDATE `aq_item` SET `entry` = 900001, `name` = 'Scalding Whelp Scale', `displayid` = 6629,
	`description` = 'Still warm to the touch.' WHERE `entry` = 8392;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
UPDATE `aq_item` SET `entry` = 900002, `name` = 'Glassweb Silk', `displayid` = 18597,
	`description` = 'Spun through the heat of the Gorge WHERE `entry` = 900001; it does not burn.';
INSERT INTO `item_template` SELECT * FROM `aq_item`;
UPDATE `aq_item` SET `entry` = 900003, `name` = 'Searing Venom Gland', `displayid` = 4826,
	`description` = 'It smokes faintly.' WHERE `entry` = 900002;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
UPDATE `aq_item` SET `entry` = 900004, `name` = 'Felbeast Hide', `displayid` = 8952,
	`description` = 'Scarred by fel fire.' WHERE `entry` = 900003;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
DROP TEMPORARY TABLE `aq_item`;
-- Quest items: stack of 20, bound as quest items, every group member with the quest loots their own.
UPDATE `item_template` SET `class` = 12, `subclass` = 0, `Quality` = 1, `bonding` = 4, `stackable` = 20,
	`maxcount` = 0, `Flags` = 0x800, `BuyPrice` = 0, `SellPrice` = 0, `startquest` = 0
WHERE `entry` BETWEEN 900001 AND 900004;

-- ---------------------------------------------------------------- loot (quest required)
DELETE FROM `creature_loot_template` WHERE `Item` BETWEEN 900001 AND 900004;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2725, 900001, 0, 45, 1, 1, 0, 1, 1, 'Scalding Whelp - Scalding Whelp Scale (AzerothQuest pack)'),
(5856, 900002, 0, 45, 1, 1, 0, 1, 1, 'Glassweb Spider - Glassweb Silk (AzerothQuest pack)'),
(5857, 900003, 0, 40, 1, 1, 0, 1, 1, 'Searing Lava Spider - Searing Venom Gland (AzerothQuest pack)'),
(8675, 900004, 0, 50, 1, 1, 0, 1, 1, 'Felbeast - Felbeast Hide (AzerothQuest pack)');

-- ---------------------------------------------------------------- quests
DELETE FROM `quest_template` WHERE `ID` BETWEEN 900001 AND 900009;
INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`,
	`RewardXPDifficulty`, `RewardMoney`, `RewardMoneyDifficulty`, `Flags`, `AllowableRaces`,
	`LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`,
	`RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`,
	`RequiredItemId1`, `RequiredItemCount1`, `VerifiedBuild`) VALUES
-- Badlands (QuestSortID 3)
(900001, 2, -1, 40, 3, 0, 0, 5, 0, 5, 8, 0, 'Whelp Scales',
	'Bring 8 Scalding Whelp Scales to Garek in the Badlands.',
	'The whelps in Lethlor Ravine are getting bolder, $N. Every week there are more of them, and every week they come closer to my camp.$B$BThe dragonflight behind them wants to know how strong we are. Let them learn. Thin out the Scalding Whelps and bring me their scales; I want to know what we are dealing with.',
	'', 'Return to Garek in the Badlands.',
	0, 0, 0, 0, 900001, 8, 0),
(900002, 2, -1, 40, 3, 0, 0, 5, 0, 5, 8, 0, 'Restless Stone',
	'Destroy 10 Enraged Rock Elementals in the south of the Badlands, then return to Lotwil Veriatus.',
	'The earth of the Badlands is angry, $C. My readings are off the scale in the south: the rock elementals there have gone wild, and they smash everything that moves.$B$BI need them calmed before I can measure anything. And by calmed, I mean broken into gravel. Destroy the Enraged Rock Elementals in the south and come back to me.',
	'', 'Return to Lotwil Veriatus in the Badlands.',
	2791, 0, 10, 0, 0, 0, 0),
(900003, 2, -1, 39, 3, 0, 0, 5, 0, 5, 8, 0, 'Dustbelcher Raiders',
	'Kill 10 Dustbelcher Maulers and 6 Dustbelcher Shamans in the south-west of the Badlands, then return to Martek the Exiled.',
	'The Dustbelcher ogres raid this camp whenever they are hungry, and they are always hungry.$B$BI was a warrior once, $N, before I was sent out here. I know how to break a raid: you take away the brutes who lead it and the shamans who stir them up. Go to their dens in the south-west and do it for me.',
	'', 'Return to Martek the Exiled in the Badlands.',
	2717, 2718, 10, 6, 0, 0, 0),
-- Searing Gorge (QuestSortID 51)
(900004, 2, -1, 42, 51, 0, 0, 5, 0, 5, 8, 0, 'Glass in the Webs',
	'Bring 8 Glassweb Silk to Evonice Sootsmoker at Thorium Point.',
	'The Glassweb Spiders spin their webs through the heat of the Gorge, and the silk does not burn. Do you know what a smith would give for gloves that do not burn?$B$BThe spiders nest east of here. Bring me their silk, and the Brotherhood''s forges will thank you.',
	'', 'Return to Evonice Sootsmoker at Thorium Point.',
	0, 0, 0, 0, 900002, 8, 0),
(900005, 2, -1, 43, 51, 0, 0, 5, 0, 5, 8, 0, 'Searing Venom',
	'Bring 6 Searing Venom Glands to Master Smith Burninate at Thorium Point.',
	'A blade quenched in venom holds an edge like nothing else, $N. The Searing Lava Spiders in the south of the Gorge carry a venom hot enough to temper steel.$B$BBring me their venom glands. Carefully.',
	'', 'Return to Master Smith Burninate at Thorium Point.',
	0, 0, 0, 0, 900003, 6, 0),
(900006, 2, -1, 44, 51, 0, 0, 5, 0, 5, 8, 0, 'Cooling the Forge',
	'Destroy 12 Magma Elementals in Searing Gorge, then return to Master Smith Burninate at Thorium Point.',
	'The Dark Irons have been calling up the fire beneath the Gorge, and the Magma Elementals it brings up wander right to our doorstep. My forges run hot enough without them.$B$BPut them out, $N. Twelve should teach the rest to keep their distance.',
	'', 'Return to Master Smith Burninate at Thorium Point.',
	5855, 0, 12, 0, 0, 0, 0),
(900007, 2, -1, 45, 51, 0, 0, 5, 0, 5, 8, 0, 'Blind the Lookouts',
	'Kill 10 Dark Iron Lookouts in Searing Gorge, then return to Hansel Heavyhands at Thorium Point.',
	'Every time the Brotherhood moves, the Dark Irons know about it before we are halfway there. It is their lookouts, posted on every ridge between here and the Cauldron.$B$BBlind them, $N. Without their eyes, they cannot see us coming.',
	'', 'Return to Hansel Heavyhands at Thorium Point.',
	8566, 0, 10, 0, 0, 0, 0),
-- Blasted Lands (QuestSortID 4)
(900008, 2, -1, 47, 4, 0, 0, 5, 0, 5, 8, 0, 'Felbeast Hides',
	'Bring 6 Felbeast Hides to Kum''isha the Collector in the Blasted Lands.',
	'Kum''isha collects many things, traveler, and pays well for them. The felbeasts that prowl the Blasted Lands have hides scarred by fel fire, and certain buyers ask for them by name.$B$BBring me six, and Kum''isha will make it worth your while.',
	'', 'Return to Kum''isha the Collector in the Blasted Lands.',
	0, 0, 0, 0, 900004, 6, 0),
(900009, 2, -1, 47, 4, 0, 0, 5, 0, 5, 8, 0, 'Scorpok Menace',
	'Kill 10 Scorpok Stingers in the north of the Blasted Lands, then return to Kum''isha the Collector.',
	'The Scorpok Stingers in the north have grown fat on travelers, and travelers are my customers. Dead customers buy nothing.$B$BCut their numbers down, $N. Ten of them, and the road will be safer for all of us.',
	'', 'Return to Kum''isha the Collector in the Blasted Lands.',
	5988, 0, 10, 0, 0, 0, 0);

-- Each quest stays within its zone's levels.
DELETE FROM `quest_template_addon` WHERE `ID` BETWEEN 900001 AND 900009;
INSERT INTO `quest_template_addon` (`ID`, `MaxLevel`) VALUES
(900001, 47), (900002, 47), (900003, 47),
(900004, 52), (900005, 52), (900006, 52), (900007, 52),
(900008, 56), (900009, 56);

DELETE FROM `quest_request_items` WHERE `ID` BETWEEN 900001 AND 900009;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`, `VerifiedBuild`) VALUES
(900001, 1, 1, 'Did you find the whelps, $N?', 0),
(900002, 1, 1, 'Are the readings any calmer?', 0),
(900003, 1, 1, 'Have the Dustbelchers learned their lesson?', 0),
(900004, 1, 1, 'Did you bring the silk?', 0),
(900005, 1, 1, 'The venom glands, $N?', 0),
(900006, 1, 1, 'Is the fire out yet?', 0),
(900007, 1, 1, 'Are the ridges clear?', 0),
(900008, 1, 1, 'You have the hides?', 0),
(900009, 1, 1, 'Is the road safer?', 0);

DELETE FROM `quest_offer_reward` WHERE `ID` BETWEEN 900001 AND 900009;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `RewardText`, `VerifiedBuild`) VALUES
(900001, 1, 'These scales are still warm. Black dragonflight blood, no doubt about it. Thank you, $N; now I know what to tell the others.', 0),
(900002, 4, 'My readings are already settling! Well, mostly. Good work, $C.', 0),
(900003, 2, 'Ha! That will keep them hungry somewhere else for a while. You fight well, $N.', 0),
(900004, 1, 'Look at that: not even singed. The forges will put this to good use.', 0),
(900005, 1, 'Careful with those... yes, these will temper a fine blade. Well done.', 0),
(900006, 4, 'I can feel the difference already. The Brotherhood thanks you, $N.', 0),
(900007, 2, 'Blind and deaf. Now we move when we want to. Well done.', 0),
(900008, 1, 'Fine hides, fine hides. Kum''isha keeps her word; here is your payment.', 0),
(900009, 1, 'The road thanks you, and so does Kum''isha.', 0);

-- ---------------------------------------------------------------- givers
DELETE FROM `creature_queststarter` WHERE `quest` BETWEEN 900001 AND 900009;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(2888, 900001),   -- Garek
(2921, 900002),   -- Lotwil Veriatus
(4618, 900003),   -- Martek the Exiled
(14628, 900004),  -- Evonice Sootsmoker
(14624, 900005),  -- Master Smith Burninate
(14624, 900006),
(14627, 900007),  -- Hansel Heavyhands
(7363, 900008),   -- Kum'isha the Collector
(7363, 900009);
DELETE FROM `creature_questender` WHERE `quest` BETWEEN 900001 AND 900009;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(2888, 900001), (2921, 900002), (4618, 900003), (14628, 900004), (14624, 900005), (14624, 900006),
(14627, 900007), (7363, 900008), (7363, 900009);

-- Revert:
-- DELETE FROM `creature_queststarter` WHERE `quest` BETWEEN 900001 AND 900009;
-- DELETE FROM `creature_questender` WHERE `quest` BETWEEN 900001 AND 900009;
-- DELETE FROM `quest_offer_reward` WHERE `ID` BETWEEN 900001 AND 900009;
-- DELETE FROM `quest_request_items` WHERE `ID` BETWEEN 900001 AND 900009;
-- DELETE FROM `quest_template_addon` WHERE `ID` BETWEEN 900001 AND 900009;
-- DELETE FROM `quest_template` WHERE `ID` BETWEEN 900001 AND 900009;
-- DELETE FROM `creature_loot_template` WHERE `Item` BETWEEN 900001 AND 900004;
-- DELETE FROM `item_template` WHERE `entry` BETWEEN 900001 AND 900004;
