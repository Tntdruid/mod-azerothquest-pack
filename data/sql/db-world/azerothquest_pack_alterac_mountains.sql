-- Target database: acore_world
--
-- AzerothQuest quest pack: Alterac Mountains, levels 32-40. Only 12 quests in the zone; three new ones on mobs no
-- quest uses today (yetis, Crushridge ogres, Syndicate spies and sentries), for each faction from the Alterac Valley
-- outposts already in the mountains:
--   Alliance (900021-900023): Sergeant Durgen Stormpike and Prospector Stonehewer (Stormpike Guard).
--   Horde (900024-900026): Corporal Teeka Bloodsnarl and Voggah Deathgrip (Frostwolf Clan).
--
-- Same build as the pilot pack: QuestLevel -1 with XP and money by the player's level, MinLevel and MaxLevel within
-- the zone's levels, a quest-required multi-drop quest item copied from Blasted Boar Lung with an existing display
-- ID (900009).
--
-- Safe to run twice. Restart the worldserver afterwards and delete the client's Cache folder.

-- ---------------------------------------------------------------- item
DELETE FROM `item_template` WHERE `entry` = 900009;
DROP TEMPORARY TABLE IF EXISTS `aq_item`;
CREATE TEMPORARY TABLE `aq_item` SELECT * FROM `item_template` WHERE `entry` = 8392;  -- Blasted Boar Lung
UPDATE `aq_item` SET `entry` = 900009, `name` = 'Shaggy Yeti Fur', `displayid` = 21366,
	`description` = 'Warm, thick, and smells terrible.' WHERE `entry` = 8392;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
DROP TEMPORARY TABLE `aq_item`;
UPDATE `item_template` SET `class` = 12, `subclass` = 0, `Quality` = 1, `bonding` = 4, `stackable` = 20,
	`maxcount` = 0, `Flags` = 0x800, `BuyPrice` = 0, `SellPrice` = 0, `startquest` = 0
WHERE `entry` = 900009;

-- ---------------------------------------------------------------- loot (quest required)
DELETE FROM `creature_loot_template` WHERE `Item` = 900009;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2250, 900009, 0, 50, 1, 1, 0, 1, 1, 'Mountain Yeti - Shaggy Yeti Fur (AzerothQuest pack)'),
(2251, 900009, 0, 55, 1, 1, 0, 1, 1, 'Giant Yeti - Shaggy Yeti Fur (AzerothQuest pack)');

-- ---------------------------------------------------------------- quests (QuestSortID 36: Alterac Mountains)
DELETE FROM `quest_template` WHERE `ID` BETWEEN 900021 AND 900026;
INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`,
	`RewardXPDifficulty`, `RewardMoney`, `RewardMoneyDifficulty`, `Flags`, `AllowableRaces`,
	`LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`,
	`RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`,
	`RequiredItemId1`, `RequiredItemCount1`, `VerifiedBuild`) VALUES
-- Alliance: Stormpike Guard
(900021, 2, -1, 31, 36, 0, 0, 5, 0, 5, 8, 1101, 'Furs for the Stormpike',
	'Bring 8 Shaggy Yeti Furs to Sergeant Durgen Stormpike in the Alterac Mountains.',
	'The Stormpike guard these passes winter and summer, $N, and winter up here never really ends. The yetis in the southern caves wear the warmest coats in the mountains.$B$BBring me their furs. Eight should keep a few more of my dwarves alive until the thaw.',
	'', 'Return to Sergeant Durgen Stormpike in the Alterac Mountains.',
	0, 0, 0, 0, 900009, 8, 0),
(900022, 2, -1, 32, 36, 0, 0, 5, 0, 5, 8, 1101, 'Crushridge Raiders',
	'Kill 10 Crushridge Ogres and 6 Crushridge Brutes in the Alterac Mountains, then return to Prospector Stonehewer.',
	'The Crushridge ogres raid our supply lines as soon as a cart leaves the valley. They take the food, the tools, and the drivers, if they can catch them.$B$BTeach them that the Stormpike bite back, $N. Their camps lie in the middle of the mountains.',
	'', 'Return to Prospector Stonehewer in the Alterac Mountains.',
	2252, 2253, 10, 6, 0, 0, 0),
(900023, 2, -1, 33, 36, 0, 0, 5, 0, 5, 8, 1101, 'Eyes of the Syndicate',
	'Kill 8 Syndicate Spies and 8 Syndicate Sentries in the Alterac Mountains, then return to Sergeant Durgen Stormpike.',
	'The Syndicate sells everything it sees, and lately it sees a lot of us. Their spies watch the roads around Alterac and their sentries keep the rest of us out of the ruins.$B$BPut out their eyes, $N. What they cannot see, they cannot sell.',
	'', 'Return to Sergeant Durgen Stormpike in the Alterac Mountains.',
	2242, 2243, 8, 8, 0, 0, 0),
-- Horde: Frostwolf Clan
(900024, 2, -1, 31, 36, 0, 0, 5, 0, 5, 8, 690, 'Furs for the Frostwolf',
	'Bring 8 Shaggy Yeti Furs to Corporal Teeka Bloodsnarl in the Alterac Mountains.',
	'The Frostwolves have lived in these mountains for generations, $N, and we know what keeps a warrior alive in the snow: good fur. The yetis in the southern caves have the best.$B$BBring me eight of their furs.',
	'', 'Return to Corporal Teeka Bloodsnarl in the Alterac Mountains.',
	0, 0, 0, 0, 900009, 8, 0),
(900025, 2, -1, 32, 36, 0, 0, 5, 0, 5, 8, 690, 'Crushridge Thieves',
	'Kill 10 Crushridge Ogres and 6 Crushridge Brutes in the Alterac Mountains, then return to Voggah Deathgrip.',
	'The Crushridge ogres steal from anyone weaker than themselves, and they think that is everyone. They have taken our meat and our wolves.$B$BShow them their mistake, $N. Their camps lie in the middle of the mountains.',
	'', 'Return to Voggah Deathgrip in the Alterac Mountains.',
	2252, 2253, 10, 6, 0, 0, 0),
(900026, 2, -1, 33, 36, 0, 0, 5, 0, 5, 8, 690, 'Blind the Syndicate',
	'Kill 8 Syndicate Spies and 8 Syndicate Sentries in the Alterac Mountains, then return to Corporal Teeka Bloodsnarl.',
	'Human thieves in black, everywhere in these mountains. The Syndicate spies on us and sells what it learns to the Stormpike dwarves.$B$BKill their spies and their sentries, $N. Let them sell silence.',
	'', 'Return to Corporal Teeka Bloodsnarl in the Alterac Mountains.',
	2242, 2243, 8, 8, 0, 0, 0);

DELETE FROM `quest_template_addon` WHERE `ID` BETWEEN 900021 AND 900026;
INSERT INTO `quest_template_addon` (`ID`, `MaxLevel`) VALUES
(900021, 40), (900022, 41), (900023, 42), (900024, 40), (900025, 41), (900026, 42);

DELETE FROM `quest_request_items` WHERE `ID` BETWEEN 900021 AND 900026;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`, `VerifiedBuild`) VALUES
(900021, 1, 1, 'Furs, $N?', 0),
(900022, 1, 1, 'Have the ogres learned anything?', 0),
(900023, 1, 1, 'Is the Syndicate blind yet?', 0),
(900024, 1, 1, 'Do you have the furs?', 0),
(900025, 1, 1, 'Are the thieves dead?', 0),
(900026, 1, 1, 'Are their eyes closed?', 0);

DELETE FROM `quest_offer_reward` WHERE `ID` BETWEEN 900021 AND 900026;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `RewardText`, `VerifiedBuild`) VALUES
(900021, 1, 'Fine furs, and plenty of them. The Stormpike thank you, $N.', 0),
(900022, 2, 'Ha! That will keep the carts rolling for a while. Well fought.', 0),
(900023, 1, 'Blind and deaf. Good. The Stormpike will not forget this.', 0),
(900024, 1, 'Warm furs for the Frostwolves. You have done well, $N.', 0),
(900025, 2, 'They will think twice before stealing from the Frostwolves again.', 0),
(900026, 1, 'Good. Let them sell that.', 0);

-- ---------------------------------------------------------------- givers
DELETE FROM `creature_queststarter` WHERE `quest` BETWEEN 900021 AND 900026;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(13777, 900021), (13816, 900022), (13777, 900023),  -- Sergeant Durgen Stormpike, Prospector Stonehewer
(13776, 900024), (13817, 900025), (13776, 900026);  -- Corporal Teeka Bloodsnarl, Voggah Deathgrip
DELETE FROM `creature_questender` WHERE `quest` BETWEEN 900021 AND 900026;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(13777, 900021), (13816, 900022), (13777, 900023), (13776, 900024), (13817, 900025), (13776, 900026);

-- Revert:
-- DELETE FROM `creature_queststarter` WHERE `quest` BETWEEN 900021 AND 900026;
-- DELETE FROM `creature_questender` WHERE `quest` BETWEEN 900021 AND 900026;
-- DELETE FROM `quest_offer_reward` WHERE `ID` BETWEEN 900021 AND 900026;
-- DELETE FROM `quest_request_items` WHERE `ID` BETWEEN 900021 AND 900026;
-- DELETE FROM `quest_template_addon` WHERE `ID` BETWEEN 900021 AND 900026;
-- DELETE FROM `quest_template` WHERE `ID` BETWEEN 900021 AND 900026;
-- DELETE FROM `creature_loot_template` WHERE `Item` = 900009;
-- DELETE FROM `item_template` WHERE `entry` = 900009;
