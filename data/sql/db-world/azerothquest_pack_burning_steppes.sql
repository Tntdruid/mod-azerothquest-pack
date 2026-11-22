-- Target database: acore_world
--
-- AzerothQuest quest pack: Burning Steppes, levels 50-58. Only 15 quests in the zone's own levels; six new ones on
-- mobs no quest uses today, from NPCs already there:
--   Morgan's Vigil (Alliance): Marshal Maxwell, Jalinda Sprig, Helendis Riverhorn.
--   Flame Crest (neutral goblins and a mage, for both factions): Tinkee Steamboil, Mathredis Firestar,
--   Maxwort Uberglint.
--
-- Same build as the pilot pack: QuestLevel -1 with XP and money by the player's level, MinLevel and MaxLevel within
-- the zone's levels, quest-required multi-drop quest items copied from Blasted Boar Lung with an existing display
-- ID. IDs: quests 900015-900020, items 900007-900008.
--
-- Safe to run twice. Restart the worldserver afterwards and delete the client's Cache folder.

-- ---------------------------------------------------------------- items
DELETE FROM `item_template` WHERE `entry` BETWEEN 900007 AND 900008;
DROP TEMPORARY TABLE IF EXISTS `aq_item`;
CREATE TEMPORARY TABLE `aq_item` SELECT * FROM `item_template` WHERE `entry` = 8392;  -- Blasted Boar Lung
UPDATE `aq_item` SET `entry` = 900007, `name` = 'Venomtip Stinger', `displayid` = 7987,
	`description` = 'The tip still glistens.' WHERE `entry` = 8392;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
UPDATE `aq_item` SET `entry` = 900008, `name` = 'Obsidian Core', `displayid` = 20769,
	`description` = 'Heavy, and warm as a coal.' WHERE `entry` = 900007;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
DROP TEMPORARY TABLE `aq_item`;
UPDATE `item_template` SET `class` = 12, `subclass` = 0, `Quality` = 1, `bonding` = 4, `stackable` = 20,
	`maxcount` = 0, `Flags` = 0x800, `BuyPrice` = 0, `SellPrice` = 0, `startquest` = 0
WHERE `entry` BETWEEN 900007 AND 900008;

-- ---------------------------------------------------------------- loot (quest required)
DELETE FROM `creature_loot_template` WHERE `Item` BETWEEN 900007 AND 900008;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(9691, 900007, 0, 50, 1, 1, 0, 1, 1, 'Venomtip Scorpid - Venomtip Stinger (AzerothQuest pack)'),
(9695, 900007, 0, 50, 1, 1, 0, 1, 1, 'Deathlash Scorpid - Venomtip Stinger (AzerothQuest pack)'),
(7031, 900008, 0, 50, 1, 1, 0, 1, 1, 'Obsidian Elemental - Obsidian Core (AzerothQuest pack)'),
(7032, 900008, 0, 60, 1, 1, 0, 1, 1, 'Greater Obsidian Elemental - Obsidian Core (AzerothQuest pack)');

-- ---------------------------------------------------------------- quests (QuestSortID 46: Burning Steppes)
DELETE FROM `quest_template` WHERE `ID` BETWEEN 900015 AND 900020;
INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`,
	`RewardXPDifficulty`, `RewardMoney`, `RewardMoneyDifficulty`, `Flags`, `AllowableRaces`,
	`LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`,
	`RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`,
	`RequiredItemId1`, `RequiredItemCount1`, `VerifiedBuild`) VALUES
(900015, 2, -1, 52, 46, 0, 0, 5, 0, 5, 8, 1101, 'Blackrock Vanguard',
	'Kill 10 Blackrock Soldiers and 8 Blackrock Sorcerers in the Burning Steppes, then return to Marshal Maxwell at Morgan''s Vigil.',
	'The Blackrock orcs are massing in the heart of the Steppes, $N. Every week their patrols come a little closer to Morgan''s Vigil, and every week I lose scouts to them.$B$BBreak their vanguard. Their soldiers hold the line and their sorcerers keep it burning: take out both, and the rest will think twice.',
	'', 'Return to Marshal Maxwell at Morgan''s Vigil in the Burning Steppes.',
	7025, 7026, 10, 8, 0, 0, 0),
(900016, 2, -1, 50, 46, 0, 0, 5, 0, 5, 8, 1101, 'Stingers of the Steppes',
	'Bring 8 Venomtip Stingers to Jalinda Sprig at Morgan''s Vigil.',
	'Oh, you would not believe what the venom of these scorpids does to a gnomish antidote! It makes it better. Much better. I need more of it.$B$BThe Venomtip and Deathlash Scorpids roam the east and the middle of the Steppes. Bring me their stingers, and mind the pointy end!',
	'', 'Return to Jalinda Sprig at Morgan''s Vigil in the Burning Steppes.',
	0, 0, 0, 0, 900007, 8, 0),
(900017, 2, -1, 50, 46, 0, 0, 5, 0, 5, 8, 1101, 'Unbound Flame',
	'Put out 8 Flamekin Spitters and 8 Flamekin Sprites in the east of the Burning Steppes, then return to Helendis Riverhorn at Morgan''s Vigil.',
	'The fire in this land does not burn out, $C. It walks. The Flamekin of the east are flame given a will, and they spread the burning wherever they go.$B$BI cannot heal a land that keeps catching fire. Put them out, and give the earth a chance to breathe.',
	'', 'Return to Helendis Riverhorn at Morgan''s Vigil in the Burning Steppes.',
	9776, 9777, 8, 8, 0, 0, 0),
(900018, 2, -1, 51, 46, 0, 0, 5, 0, 5, 8, 0, 'Obsidian Cores',
	'Bring 6 Obsidian Cores to Tinkee Steamboil at Flame Crest.',
	'Obsidian elementals! Big, slow, and full of the most marvelous cores. Heat-proof, pressure-proof, practically everything-proof. Do you know what I could build with those?$B$BThe elementals wander east of here and around the middle of the Steppes. Bring me six cores, $N, and I will cut you in on the profits. Probably.',
	'', 'Return to Tinkee Steamboil at Flame Crest in the Burning Steppes.',
	0, 0, 0, 0, 900008, 6, 0),
(900019, 2, -1, 51, 46, 0, 0, 5, 0, 5, 8, 0, 'Broodling Menace',
	'Kill 10 Scalding Broodlings in the Burning Steppes, then return to Mathredis Firestar at Flame Crest.',
	'The black dragonflight lets its young hunt the Steppes, $N, to grow strong on whatever they catch. Lately, what they catch is us.$B$BThe Scalding Broodlings north of the road are the boldest. Cull them, before they grow into something we cannot handle.',
	'', 'Return to Mathredis Firestar at Flame Crest in the Burning Steppes.',
	7048, 0, 10, 0, 0, 0, 0),
(900020, 2, -1, 52, 46, 0, 0, 5, 0, 5, 8, 0, 'Reaver Scrap',
	'Destroy 8 War Reavers in the Burning Steppes, then return to Maxwort Uberglint at Flame Crest.',
	'The Dark Irons build those War Reavers out of good steel and better engineering, and then they let them wander about smashing things. What a waste!$B$BTake them apart for me, $N. Eight should do. I will send someone for the pieces.',
	'', 'Return to Maxwort Uberglint at Flame Crest in the Burning Steppes.',
	7039, 0, 8, 0, 0, 0, 0);

DELETE FROM `quest_template_addon` WHERE `ID` BETWEEN 900015 AND 900020;
INSERT INTO `quest_template_addon` (`ID`, `MaxLevel`) VALUES
(900015, 58), (900016, 57), (900017, 57), (900018, 58), (900019, 57), (900020, 58);

DELETE FROM `quest_request_items` WHERE `ID` BETWEEN 900015 AND 900020;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`, `VerifiedBuild`) VALUES
(900015, 1, 1, 'Is their vanguard broken, $N?', 0),
(900016, 1, 1, 'Stingers! Did you get the stingers?', 0),
(900017, 1, 1, 'Do the Flamekin still walk?', 0),
(900018, 1, 1, 'Cores? Tell me you have cores.', 0),
(900019, 1, 1, 'Are the broodlings dealt with?', 0),
(900020, 1, 1, 'How many reavers did you take apart?', 0);

DELETE FROM `quest_offer_reward` WHERE `ID` BETWEEN 900015 AND 900020;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `RewardText`, `VerifiedBuild`) VALUES
(900015, 2, 'Good work, $N. That will keep them off the Vigil''s doorstep for a while.', 0),
(900016, 4, 'Wonderful! Look at that venom. My antidote is going to be famous!', 0),
(900017, 1, 'I can feel the land cool already. Thank you, $C.', 0),
(900018, 4, 'Oh, these are beautiful! As promised, your cut. Probably the biggest cut I have ever given anyone.', 0),
(900019, 1, 'The skies are a little quieter. The Flame Crest thanks you.', 0),
(900020, 4, 'Eight! Scrap for a dozen inventions. Here, you have earned this.', 0);

-- ---------------------------------------------------------------- givers
DELETE FROM `creature_queststarter` WHERE `quest` BETWEEN 900015 AND 900020;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(9560, 900015),   -- Marshal Maxwell
(9561, 900016),   -- Jalinda Sprig
(9562, 900017),   -- Helendis Riverhorn
(10267, 900018),  -- Tinkee Steamboil
(9836, 900019),   -- Mathredis Firestar
(9536, 900020);   -- Maxwort Uberglint
DELETE FROM `creature_questender` WHERE `quest` BETWEEN 900015 AND 900020;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(9560, 900015), (9561, 900016), (9562, 900017), (10267, 900018), (9836, 900019), (9536, 900020);

-- Revert:
-- DELETE FROM `creature_queststarter` WHERE `quest` BETWEEN 900015 AND 900020;
-- DELETE FROM `creature_questender` WHERE `quest` BETWEEN 900015 AND 900020;
-- DELETE FROM `quest_offer_reward` WHERE `ID` BETWEEN 900015 AND 900020;
-- DELETE FROM `quest_request_items` WHERE `ID` BETWEEN 900015 AND 900020;
-- DELETE FROM `quest_template_addon` WHERE `ID` BETWEEN 900015 AND 900020;
-- DELETE FROM `quest_template` WHERE `ID` BETWEEN 900015 AND 900020;
-- DELETE FROM `creature_loot_template` WHERE `Item` BETWEEN 900007 AND 900008;
-- DELETE FROM `item_template` WHERE `entry` BETWEEN 900007 AND 900008;
