-- Target database: acore_world
--
-- AzerothQuest quest pack: Western Plaguelands, levels 49-55.
--
-- 8 quests, 4 for each faction, for the gap at levels 50-52: Chillwind Camp's quests open at 52-53. From
-- Commander Ashlam Valorfist and Alchemist Arbington (Chillwind Camp), High Executor Derrington and Apothecary
-- Dithers (The Bulwark): Skeletal Sorcerers, Blighted Zombies, Diseased Black Bears and Venom Mist Lurkers.
--
-- Built by tools/questpack/build_quest_pack.py: QuestLevel -1 with XP and money by the player's level,
-- MinLevel and MaxLevel within the zone's levels, quest-required multi-drop quest items copied from
-- Blasted Boar Lung with an existing display ID. Quests 900079-900086, items 900025-900026.
--
-- Safe to run twice. Restart the worldserver afterwards and delete the client's Cache folder.

-- ---------------------------------------------------------------- items
DELETE FROM `item_template` WHERE `entry` BETWEEN 900025 AND 900026;
DROP TEMPORARY TABLE IF EXISTS `aq_item`;
CREATE TEMPORARY TABLE `aq_item` SELECT * FROM `item_template` WHERE `entry` = 8392;  -- Blasted Boar Lung
UPDATE `aq_item` SET `entry` = 900025, `name` = 'Blighted Bear Heart', `displayid` = 3422, `description` = 'It still beats, slowly.' WHERE `entry` = 8392;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
UPDATE `aq_item` SET `entry` = 900026, `name` = 'Venom Mist Gland', `displayid` = 8940, `description` = 'It sweats a green mist.' WHERE `entry` = 900025;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
DROP TEMPORARY TABLE `aq_item`;
UPDATE `item_template` SET `class` = 12, `subclass` = 0, `Quality` = 1, `bonding` = 4, `stackable` = 20,
	`maxcount` = 0, `Flags` = 0x800, `BuyPrice` = 0, `SellPrice` = 0, `startquest` = 0
WHERE `entry` BETWEEN 900025 AND 900026;

-- ---------------------------------------------------------------- loot (quest required)
DELETE FROM `creature_loot_template` WHERE `Item` BETWEEN 900025 AND 900026;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1815, 900025, 0, 50, 1, 1, 0, 1, 1, 'Diseased Black Bear - Blighted Bear Heart (AzerothQuest pack)'),
(1822, 900026, 0, 50, 1, 1, 0, 1, 1, 'Venom Mist Lurker - Venom Mist Gland (AzerothQuest pack)');

-- ---------------------------------------------------------------- quests
DELETE FROM `quest_template` WHERE `ID` BETWEEN 900079 AND 900086;
INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`,
	`RewardXPDifficulty`, `RewardMoney`, `RewardMoneyDifficulty`, `Flags`, `AllowableRaces`,
	`LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`,
	`RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`,
	`RequiredItemId1`, `RequiredItemCount1`, `VerifiedBuild`) VALUES
(900079, 2, -1, 49, 28, 0, 0, 5, 0, 5, 8, 1101, 'Bones of Felstone',
	'Kill 10 Skeletal Sorcerers around Felstone Field and the Dalson farm, then return to Commander Ashlam Valorfist at Chillwind Camp.',
	'The Scourge raise their dead faster than we can burn them, $N, and the skeletal sorcerers in the farmlands are why.$B$BEvery one of them you put down is a dozen corpses that stay in the ground. Ten of them, and the fields north of here will be quieter for a while.',
	'', 'Return to Commander Ashlam Valorfist at Chillwind Camp.',
	1784, 0, 10, 0, 0, 0, 0),
(900080, 2, -1, 50, 28, 0, 0, 5, 0, 5, 8, 1101, 'The Shambling Dead',
	'Kill 10 Blighted Zombies in the fields of the Western Plaguelands, then return to Commander Ashlam Valorfist at Chillwind Camp.',
	'Blighted zombies wander the roads between the farms, and every caravan we send north meets them.$B$BClear them out, $N. Ten should keep the road open long enough for our supplies to get through.',
	'', 'Return to Commander Ashlam Valorfist at Chillwind Camp.',
	4475, 0, 10, 0, 0, 0, 0),
(900081, 2, -1, 49, 28, 0, 0, 5, 0, 5, 8, 1101, 'Hearts of the Blight',
	'Bring 8 Blighted Bear Hearts to Alchemist Arbington at Chillwind Camp.',
	'The plague changes everything it touches, $N, even the bears. The diseased black bears in the west still have beating hearts, and those hearts carry the plague in its purest form.$B$BBring me eight. If I can learn how the plague keeps them alive, perhaps I can learn how to kill it.',
	'', 'Return to Alchemist Arbington at Chillwind Camp.',
	0, 0, 0, 0, 900025, 8, 0),
(900082, 2, -1, 49, 28, 0, 0, 5, 0, 5, 8, 1101, 'Mist and Venom',
	'Bring 8 Venom Mist Glands to Alchemist Arbington at Chillwind Camp.',
	'The venom mist lurkers in the west breathe a poison the plague cannot touch. That makes their glands very interesting to me, $N.$B$BBring me eight of them. With luck, their venom is the start of a cure.',
	'', 'Return to Alchemist Arbington at Chillwind Camp.',
	0, 0, 0, 0, 900026, 8, 0),
(900083, 2, -1, 49, 28, 0, 0, 5, 0, 5, 8, 690, 'Bones of Felstone',
	'Kill 10 Skeletal Sorcerers around Felstone Field and the Dalson farm, then return to High Executor Derrington at The Bulwark.',
	'The Scourge''s skeletal sorcerers raise the dead of the farmlands as fast as we can cut them down.$B$BThe Dark Lady wants those fields quiet, $N. Kill ten of the sorcerers, and the Scourge will have fewer hands.',
	'', 'Return to High Executor Derrington at The Bulwark.',
	1784, 0, 10, 0, 0, 0, 0),
(900084, 2, -1, 50, 28, 0, 0, 5, 0, 5, 8, 690, 'The Shambling Dead',
	'Kill 10 Blighted Zombies in the fields of the Western Plaguelands, then return to High Executor Derrington at The Bulwark.',
	'Blighted zombies crowd the roads to the farmlands. Our patrols waste their strength on them.$B$BThin them out, $N. Ten of them, and our patrols can get on with real work.',
	'', 'Return to High Executor Derrington at The Bulwark.',
	4475, 0, 10, 0, 0, 0, 0),
(900085, 2, -1, 49, 28, 0, 0, 5, 0, 5, 8, 690, 'Hearts of the Blight',
	'Bring 8 Blighted Bear Hearts to Apothecary Dithers at The Bulwark.',
	'The diseased black bears in the west are a gift, $N. Their hearts carry the plague, still beating.$B$BThe Royal Apothecary Society wants to know how. Bring me eight hearts.',
	'', 'Return to Apothecary Dithers at The Bulwark.',
	0, 0, 0, 0, 900025, 8, 0),
(900086, 2, -1, 49, 28, 0, 0, 5, 0, 5, 8, 690, 'Mist and Venom',
	'Bring 8 Venom Mist Glands to Apothecary Dithers at The Bulwark.',
	'The venom mist lurkers in the west carry a poison that the plague leaves alone. I want to know why.$B$BBring me eight of their glands, $N.',
	'', 'Return to Apothecary Dithers at The Bulwark.',
	0, 0, 0, 0, 900026, 8, 0);

DELETE FROM `quest_template_addon` WHERE `ID` BETWEEN 900079 AND 900086;
INSERT INTO `quest_template_addon` (`ID`, `MaxLevel`) VALUES
(900079, 55),
(900080, 55),
(900081, 55),
(900082, 55),
(900083, 55),
(900084, 55),
(900085, 55),
(900086, 55);

DELETE FROM `quest_request_items` WHERE `ID` BETWEEN 900079 AND 900086;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`, `VerifiedBuild`) VALUES
(900079, 1, 1, 'Are the sorcerers dealt with?', 0),
(900080, 1, 1, 'Is the road clear?', 0),
(900081, 1, 1, 'Do you have the hearts?', 0),
(900082, 1, 1, 'The glands, $N?', 0),
(900083, 1, 1, 'Have you dealt with the sorcerers?', 0),
(900084, 1, 1, 'Are the roads clear?', 0),
(900085, 1, 1, 'The hearts?', 0),
(900086, 1, 1, 'Do you have the glands?', 0);

DELETE FROM `quest_offer_reward` WHERE `ID` BETWEEN 900079 AND 900086;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `RewardText`, `VerifiedBuild`) VALUES
(900079, 1, 'Good work. Fewer of our fallen will rise to fight us.', 0),
(900080, 1, 'The caravans will thank you, $N. So do I.', 0),
(900081, 1, 'Careful, careful... yes, these will do nicely. My research thanks you.', 0),
(900082, 1, 'Splendid! Now, if you will excuse me, I have a great deal of work to do.', 0),
(900083, 1, 'Well done. The Dark Lady will hear of this.', 0),
(900084, 1, 'Good. The patrols can push further now.', 0),
(900085, 1, 'Excellent. The Society will be very pleased.', 0),
(900086, 1, 'Yes... yes, these are perfect. Thank you.', 0);

-- ---------------------------------------------------------------- givers
DELETE FROM `creature_queststarter` WHERE `quest` BETWEEN 900079 AND 900086;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(10838, 900079),
(10838, 900080),
(11056, 900081),
(11056, 900082),
(10837, 900083),
(10837, 900084),
(11057, 900085),
(11057, 900086);
DELETE FROM `creature_questender` WHERE `quest` BETWEEN 900079 AND 900086;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(10838, 900079),
(10838, 900080),
(11056, 900081),
(11056, 900082),
(10837, 900083),
(10837, 900084),
(11057, 900085),
(11057, 900086);

-- Revert:
-- DELETE FROM `creature_queststarter` WHERE `quest` BETWEEN 900079 AND 900086;
-- DELETE FROM `creature_questender` WHERE `quest` BETWEEN 900079 AND 900086;
-- DELETE FROM `quest_offer_reward` WHERE `ID` BETWEEN 900079 AND 900086;
-- DELETE FROM `quest_request_items` WHERE `ID` BETWEEN 900079 AND 900086;
-- DELETE FROM `quest_template_addon` WHERE `ID` BETWEEN 900079 AND 900086;
-- DELETE FROM `quest_template` WHERE `ID` BETWEEN 900079 AND 900086;
-- DELETE FROM `creature_loot_template` WHERE `Item` BETWEEN 900025 AND 900026;
-- DELETE FROM `item_template` WHERE `entry` BETWEEN 900025 AND 900026;
