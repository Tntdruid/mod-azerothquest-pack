-- Target database: acore_world
--
-- AzerothQuest quest pack: The Hinterlands, Tanaris, Deadwind Pass, Arathi Highlands and the Barrens.
--
-- 22 quests. The Hinterlands for both factions (Aerie Peak's Wildhammer for the Alliance, Revantusk Village for the
-- Horde) and from a neutral giver; Tanaris from Gadgetzan's goblins (neutral); Deadwind Pass from the Violet Eye
-- at Karazhan (neutral); Arathi Highlands from Refuge Pointe and Hammerfall, and Faldir's Cove (neutral); the
-- Barrens from Ratchet (neutral) and the Alliance's Northwatch and Theramore officers.
--
-- Built by tools/questpack/build_quest_pack.py: QuestLevel -1 with XP and money by the player's level,
-- MinLevel and MaxLevel within the zone's levels, quest-required multi-drop quest items copied from
-- Blasted Boar Lung with an existing display ID. Quests 900051-900072, items 900017-900022.
--
-- Safe to run twice. Restart the worldserver afterwards and delete the client's Cache folder.

-- ---------------------------------------------------------------- items
DELETE FROM `item_template` WHERE `entry` BETWEEN 900017 AND 900022;
DROP TEMPORARY TABLE IF EXISTS `aq_item`;
CREATE TEMPORARY TABLE `aq_item` SELECT * FROM `item_template` WHERE `entry` = 8392;  -- Blasted Boar Lung
UPDATE `aq_item` SET `entry` = 900017, `name` = 'Owlbeast Plumage', `displayid` = 19567, `description` = 'Coarse and oily.' WHERE `entry` = 8392;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
UPDATE `aq_item` SET `entry` = 900018, `name` = 'Fire Roc Feather', `displayid` = 19799, `description` = 'Warm, and glowing at the tip.' WHERE `entry` = 900017;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
UPDATE `aq_item` SET `entry` = 900019, `name` = 'Steeljaw Shell', `displayid` = 21363, `description` = 'A sword would bounce off it.' WHERE `entry` = 900018;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
UPDATE `aq_item` SET `entry` = 900020, `name` = 'Blisterpaw Haunch', `displayid` = 22193, `description` = 'Tough, stringy, and surprisingly tasty.' WHERE `entry` = 900019;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
UPDATE `aq_item` SET `entry` = 900021, `name` = 'Creeper Venom Sac', `displayid` = 4826, `description` = 'It throbs gently.' WHERE `entry` = 900020;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
UPDATE `aq_item` SET `entry` = 900022, `name` = 'Thunderhawk Plume', `displayid` = 19531, `description` = 'Your hair stands on end when you hold it.' WHERE `entry` = 900021;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
DROP TEMPORARY TABLE `aq_item`;
UPDATE `item_template` SET `class` = 12, `subclass` = 0, `Quality` = 1, `bonding` = 4, `stackable` = 20,
	`maxcount` = 0, `Flags` = 0x800, `BuyPrice` = 0, `SellPrice` = 0, `startquest` = 0
WHERE `entry` BETWEEN 900017 AND 900022;

-- ---------------------------------------------------------------- loot (quest required)
DELETE FROM `creature_loot_template` WHERE `Item` BETWEEN 900017 AND 900022;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(2927, 900017, 0, 50, 1, 1, 0, 1, 1, 'Vicious Owlbeast - Owlbeast Plumage (AzerothQuest pack)'),
(2928, 900017, 0, 50, 1, 1, 0, 1, 1, 'Primitive Owlbeast - Owlbeast Plumage (AzerothQuest pack)'),
(5428, 900018, 0, 45, 1, 1, 0, 1, 1, 'Roc - Fire Roc Feather (AzerothQuest pack)'),
(5429, 900018, 0, 50, 1, 1, 0, 1, 1, 'Fire Roc - Fire Roc Feather (AzerothQuest pack)'),
(14123, 900019, 0, 50, 1, 1, 0, 1, 1, 'Steeljaw Snapper - Steeljaw Shell (AzerothQuest pack)'),
(5425, 900020, 0, 45, 1, 1, 0, 1, 1, 'Starving Blisterpaw - Blisterpaw Haunch (AzerothQuest pack)'),
(5426, 900020, 0, 50, 1, 1, 0, 1, 1, 'Blisterpaw Hyena - Blisterpaw Haunch (AzerothQuest pack)'),
(2563, 900021, 0, 45, 1, 1, 0, 1, 1, 'Plains Creeper - Creeper Venom Sac (AzerothQuest pack)'),
(2565, 900021, 0, 50, 1, 1, 0, 1, 1, 'Giant Plains Creeper - Creeper Venom Sac (AzerothQuest pack)'),
(3249, 900022, 0, 50, 1, 1, 0, 1, 1, 'Greater Thunderhawk - Thunderhawk Plume (AzerothQuest pack)'),
(3247, 900022, 0, 40, 1, 1, 0, 1, 1, 'Thunderhawk Hatchling - Thunderhawk Plume (AzerothQuest pack)');

-- ---------------------------------------------------------------- quests
DELETE FROM `quest_template` WHERE `ID` BETWEEN 900051 AND 900072;
INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`,
	`RewardXPDifficulty`, `RewardMoney`, `RewardMoneyDifficulty`, `Flags`, `AllowableRaces`,
	`LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`,
	`RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`,
	`RequiredItemId1`, `RequiredItemCount1`, `VerifiedBuild`) VALUES
(900051, 2, -1, 40, 47, 0, 0, 5, 0, 5, 8, 1101, 'Witherbark Cruelty',
	'Kill 10 Witherbark Hideskinners and 8 Witherbark Sadists in the Hinterlands, then return to Gryphon Master Talonaxe at Aerie Peak.',
	'The Witherbark trolls take our gryphons when they can, $N, and what they do to them I will not repeat. Their hideskinners and sadists are the worst of the lot.$B$BTheir camps lie south-west of here. Make them pay.',
	'', 'Return to Gryphon Master Talonaxe at Aerie Peak in the Hinterlands.',
	2651, 2653, 10, 8, 0, 0, 0),
(900052, 2, -1, 40, 47, 0, 0, 5, 0, 5, 8, 690, 'Witherbark Cruelty',
	'Kill 10 Witherbark Hideskinners and 8 Witherbark Sadists in the Hinterlands, then return to Huntsman Markhor at Revantusk Village.',
	'The Witherbark are a disgrace to the trolls, mon. They skin what they catch, and they catch our hunters.$B$BTheir camps lie in the south-west. Bring them the Revantusk answer.',
	'', 'Return to Huntsman Markhor at Revantusk Village in the Hinterlands.',
	2651, 2653, 10, 8, 0, 0, 0),
(900053, 2, -1, 41, 47, 0, 0, 5, 0, 5, 8, 0, 'Owlbeast Plumage',
	'Bring 8 Owlbeast Plumage to Rhapsody Shindigger in the Hinterlands.',
	'Do you know what owlbeast plumage does in a stew? Neither do I! That is what makes it exciting!$B$BThe owlbeasts in the west of the Hinterlands have the finest feathers. Bring me eight bunches, and you will get the first bowl. Maybe.',
	'', 'Return to Rhapsody Shindigger in the Hinterlands.',
	0, 0, 0, 0, 900017, 8, 0),
(900054, 2, -1, 44, 47, 0, 0, 5, 0, 5, 8, 1101, 'Vilebranch Raiders',
	'Kill 8 Vilebranch Axe Throwers and 8 Vilebranch Witch Doctors in the Hinterlands, then return to Agnar Beastamer at Aerie Peak.',
	'The Vilebranch trolls in the south-east grow bolder by the week, $N. Their axe throwers knock our gryphons out of the sky, and their witch doctors curse the ones that make it home.$B$BCut them down, eight of each, and the skies will be ours again.',
	'', 'Return to Agnar Beastamer at Aerie Peak in the Hinterlands.',
	2639, 2640, 8, 8, 0, 0, 0),
(900055, 2, -1, 44, 47, 0, 0, 5, 0, 5, 8, 690, 'Vilebranch Raiders',
	'Kill 8 Vilebranch Axe Throwers and 8 Vilebranch Witch Doctors in the Hinterlands, then return to Otho Moji''ko at Revantusk Village.',
	'The Vilebranch serve dark loa, mon, and they want our village. Their axe throwers and witch doctors lead every raid.$B$BGo to the south-east and break their raiders. Eight of each.',
	'', 'Return to Otho Moji''ko at Revantusk Village in the Hinterlands.',
	2639, 2640, 8, 8, 0, 0, 0),
(900056, 2, -1, 43, 440, 0, 0, 5, 0, 5, 8, 0, 'Glasshide Gazers',
	'Kill 10 Glasshide Gazers in Tanaris, then return to Curgle Cranklehop in Gadgetzan.',
	'The Glasshide Gazers have turned three of my survey crew to stone this month. Stone! Do you know how hard it is to get paid by a statue?$B$BThin them out, $N. The gazers roam the middle of the desert. Ten should teach the rest some manners.',
	'', 'Return to Curgle Cranklehop in Gadgetzan.',
	5420, 0, 10, 0, 0, 0, 0),
(900057, 2, -1, 40, 440, 0, 0, 5, 0, 5, 8, 0, 'Fire Roc Feathers',
	'Bring 8 Fire Roc Feathers to Senior Surveyor Fizzledowser in Gadgetzan.',
	'Fire roc feathers burn for hours without going out. For a surveyor working at night, that is better than any lantern!$B$BThe rocs nest north and west of Gadgetzan. Bring me eight feathers, $N, and I will make it worth your while.',
	'', 'Return to Senior Surveyor Fizzledowser in Gadgetzan.',
	0, 0, 0, 0, 900018, 8, 0),
(900058, 2, -1, 40, 440, 0, 0, 5, 0, 5, 8, 0, 'Steeljaw Shells',
	'Bring 8 Steeljaw Shells to Trenton Lighthammer in Gadgetzan.',
	'The Steeljaw snappers on the east coast grow shells harder than half the steel I can buy around here. A smith can make a fine shield out of that.$B$BBring me eight shells, $N.',
	'', 'Return to Trenton Lighthammer in Gadgetzan.',
	0, 0, 0, 0, 900019, 8, 0),
(900059, 2, -1, 46, 440, 0, 0, 5, 0, 5, 8, 0, 'Hazzali Swarm',
	'Kill 10 Hazzali Workers and 8 Hazzali Tunnelers in Tanaris, then return to Marin Noggenfogger in Gadgetzan.',
	'The Hazzali silithid in the south dig closer to Gadgetzan every week. If their tunnels reach the town, I am going to have a very bad day, and so are you.$B$BKill their workers and tunnelers, $N, and their digging will slow.',
	'', 'Return to Marin Noggenfogger in Gadgetzan.',
	5452, 5453, 10, 8, 0, 0, 0),
(900060, 2, -1, 40, 440, 0, 0, 5, 0, 5, 8, 0, 'Blisterpaw Steaks',
	'Bring 8 Blisterpaw Haunches to Dirge Quikcleave in Gadgetzan.',
	'Hyena. Desert hyena. Tough as boot leather, but marinate it for a day and grill it over cactus wood... magnificent.$B$BThe Blisterpaw hyenas roam everywhere north of here. Bring me eight haunches, $N, and dinner is on me.',
	'', 'Return to Dirge Quikcleave in Gadgetzan.',
	0, 0, 0, 0, 900020, 8, 0),
(900061, 2, -1, 53, 41, 0, 0, 5, 0, 5, 8, 0, 'Ogres of Deadwind',
	'Kill 8 Deadwind Brutes and 6 Deadwind Ogre Mages in Deadwind Pass, then return to Archmage Alturus.',
	'The ogres of Deadwind Pass are drawn to Karazhan''s power the way moths are drawn to a flame, $N. Their mages dabble in what leaks from the tower, and their brutes guard them while they do.$B$BI would rather they did not. Drive them off.',
	'', 'Return to Archmage Alturus outside Karazhan in Deadwind Pass.',
	7369, 7379, 8, 6, 0, 0, 0),
(900062, 2, -1, 53, 41, 0, 0, 5, 0, 5, 8, 0, 'Sky Shadows',
	'Kill 10 Sky Shadows in Deadwind Pass, then return to Archmage Leryda.',
	'The Sky Shadows circle the pass day and night, feeding on whatever strays from the road. Lately they have been circling us.$B$BBring down ten of them, $N. We have work to do here, and I do not want to do it looking over my shoulder.',
	'', 'Return to Archmage Leryda outside Karazhan in Deadwind Pass.',
	7376, 0, 10, 0, 0, 0, 0),
(900063, 2, -1, 31, 45, 0, 0, 5, 0, 5, 8, 1101, 'Highland Hunt',
	'Kill 10 Highland Thrashers and 6 Highland Fleshstalkers in the Arathi Highlands, then return to Captain Nials at Refuge Pointe.',
	'The raptors of the Highlands hunt our patrols, $N. The thrashers run in packs, and the fleshstalkers wait until you are alone.$B$BCull them. Ten thrashers and six fleshstalkers.',
	'', 'Return to Captain Nials at Refuge Pointe in the Arathi Highlands.',
	2560, 2561, 10, 6, 0, 0, 0),
(900064, 2, -1, 31, 45, 0, 0, 5, 0, 5, 8, 690, 'Highland Hunt',
	'Kill 10 Highland Thrashers and 6 Highland Fleshstalkers in the Arathi Highlands, then return to Tor''gan at Hammerfall.',
	'The raptors of the Highlands think Hammerfall is their feeding ground, $N. The thrashers run in packs, and the fleshstalkers wait until you are alone.$B$BShow them they are wrong. Ten thrashers and six fleshstalkers.',
	'', 'Return to Tor''gan at Hammerfall in the Arathi Highlands.',
	2560, 2561, 10, 6, 0, 0, 0),
(900065, 2, -1, 33, 45, 0, 0, 5, 0, 5, 8, 1101, 'Drywhisker Diggers',
	'Kill 10 Drywhisker Kobolds and 6 Drywhisker Diggers in the Arathi Highlands, then return to Skuerto at Refuge Pointe.',
	'The Drywhisker kobolds dig in the east of the Highlands, and they dig up everything: ore, gems, and the roads our carts use.$B$BStop them, $N. Ten kobolds and six diggers should slow them down.',
	'', 'Return to Skuerto at Refuge Pointe in the Arathi Highlands.',
	2572, 2574, 10, 6, 0, 0, 0),
(900066, 2, -1, 33, 45, 0, 0, 5, 0, 5, 8, 690, 'Drywhisker Diggers',
	'Kill 10 Drywhisker Kobolds and 6 Drywhisker Diggers in the Arathi Highlands, then return to Drum Fel at Hammerfall.',
	'The Drywhisker kobolds dig too close to Hammerfall, $N. They steal our ore and undermine our walls.$B$BKill ten kobolds and six diggers.',
	'', 'Return to Drum Fel at Hammerfall in the Arathi Highlands.',
	2572, 2574, 10, 6, 0, 0, 0),
(900067, 2, -1, 31, 45, 0, 0, 5, 0, 5, 8, 0, 'Creeper Venom',
	'Bring 8 Creeper Venom Sacs to Doctor Draxlegauge at Faldir''s Cove.',
	'The plains creepers of Arathi carry a venom that stops a heart in seconds. In the right dose, it starts one. I am very close, $N. Very close.$B$BBring me eight venom sacs from the creepers on the plains.',
	'', 'Return to Doctor Draxlegauge at Faldir''s Cove in the Arathi Highlands.',
	0, 0, 0, 0, 900021, 8, 0),
(900068, 2, -1, 18, 17, 0, 0, 5, 0, 5, 8, 0, 'Silithid Swarm',
	'Kill 10 Silithid Creepers and 8 Silithid Swarmers in the Barrens, then return to Sputtervalve in Ratchet.',
	'Bugs! Big ones! They are coming up out of the ground in the south of the Barrens, and they eat everything. Including my survey equipment.$B$BKill ten creepers and eight swarmers, $N, before they reach Ratchet.',
	'', 'Return to Sputtervalve in Ratchet.',
	3250, 3252, 10, 8, 0, 0, 0),
(900069, 2, -1, 19, 17, 0, 0, 5, 0, 5, 8, 0, 'Thunderhawk Plumes',
	'Bring 8 Thunderhawk Plumes to Mebok Mizzyrix in Ratchet.',
	'Thunderhawk plumes hold a charge! A real electrical charge! Do you know what that means for my inventions? Neither do I yet!$B$BThe thunderhawks fly in the south of the Barrens. Bring me eight plumes, $N.',
	'', 'Return to Mebok Mizzyrix in Ratchet.',
	0, 0, 0, 0, 900022, 8, 0),
(900070, 2, -1, 20, 17, 0, 0, 5, 0, 5, 8, 1101, 'Razormane Raiders',
	'Kill 10 Razormane Stalkers and 8 Razormane Seers in the south of the Barrens, then return to Renn McGill.',
	'The Razormane quilboar in the south raid anyone who crosses the road, $N, and their seers see us coming before we see them.$B$BTake out ten stalkers and eight seers, and the road will be ours again.',
	'', 'Return to Renn McGill in the Barrens.',
	3457, 3458, 10, 8, 0, 0, 0),
(900071, 2, -1, 12, 17, 0, 0, 5, 0, 5, 8, 1101, 'Southsea Cutthroats',
	'Kill 10 Southsea Cutthroats and 8 Southsea Privateers on the Barrens coast, then return to Captain Darill.',
	'Pirates on the coast south of Ratchet, $N. The Southsea cutthroats and privateers raid our supply ships and slip away in the night.$B$BFind their camp and cut them down. Ten cutthroats and eight privateers.',
	'', 'Return to Captain Darill in the Barrens.',
	3383, 3384, 10, 8, 0, 0, 0),
(900072, 2, -1, 14, 17, 0, 0, 5, 0, 5, 8, 0, 'Witchwing Harpies',
	'Kill 10 Witchwing Slayers and 6 Witchwing Windcallers in the north of the Barrens, then return to Gazlowe in Ratchet.',
	'The Witchwing harpies in the north have been hitting my caravans, $N. Every crate they take comes out of my pocket, and I do not like an empty pocket.$B$BKill ten slayers and six windcallers. Business will thank you.',
	'', 'Return to Gazlowe in Ratchet.',
	3278, 3280, 10, 6, 0, 0, 0);

DELETE FROM `quest_template_addon` WHERE `ID` BETWEEN 900051 AND 900072;
INSERT INTO `quest_template_addon` (`ID`, `MaxLevel`) VALUES
(900051, 49),
(900052, 49),
(900053, 49),
(900054, 52),
(900055, 52),
(900056, 52),
(900057, 49),
(900058, 48),
(900059, 54),
(900060, 49),
(900061, 60),
(900062, 60),
(900063, 40),
(900064, 40),
(900065, 42),
(900066, 42),
(900067, 40),
(900068, 27),
(900069, 28),
(900070, 28),
(900071, 20),
(900072, 22);

DELETE FROM `quest_request_items` WHERE `ID` BETWEEN 900051 AND 900072;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`, `VerifiedBuild`) VALUES
(900051, 1, 1, 'Have they paid?', 0),
(900052, 1, 1, 'The Witherbark, mon?', 0),
(900053, 1, 1, 'Feathers! Did you get the feathers?', 0),
(900054, 1, 1, 'Are the skies clear?', 0),
(900055, 1, 1, 'The Vilebranch, mon?', 0),
(900056, 1, 1, 'Any more statues out there?', 0),
(900057, 1, 1, 'Got the feathers?', 0),
(900058, 1, 1, 'The shells?', 0),
(900059, 1, 1, 'Are they still digging?', 0),
(900060, 1, 1, 'Meat?', 0),
(900061, 1, 1, 'Are the ogres dealt with?', 0),
(900062, 1, 1, 'The Sky Shadows?', 0),
(900063, 1, 1, 'The raptors?', 0),
(900064, 1, 1, 'The raptors?', 0),
(900065, 1, 1, 'Have they stopped digging?', 0),
(900066, 1, 1, 'The kobolds?', 0),
(900067, 1, 1, 'The venom sacs?', 0),
(900068, 1, 1, 'The bugs?', 0),
(900069, 1, 1, 'Plumes?', 0),
(900070, 1, 1, 'The Razormane?', 0),
(900071, 1, 1, 'The pirates?', 0),
(900072, 1, 1, 'The harpies?', 0);

DELETE FROM `quest_offer_reward` WHERE `ID` BETWEEN 900051 AND 900072;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `RewardText`, `VerifiedBuild`) VALUES
(900051, 1, 'The gryphons will rest easier tonight. Thank you, $N.', 0),
(900052, 1, 'Good hunting, mon. The Revantusk remember.', 0),
(900053, 4, 'Oh, these are perfect. Here, a little something for your trouble.', 0),
(900054, 1, 'Well done! The Wildhammer will drink to your name tonight.', 0),
(900055, 1, 'The village is safer. The loa smile on you.', 0),
(900056, 1, 'Wonderful! My crew can work again. Here, you have earned this.', 0),
(900057, 4, 'Still warm! These will light my way for weeks. Thank you!', 0),
(900058, 1, 'Fine shells. Fine shields, soon. Here is your pay.', 0),
(900059, 1, 'The ground stopped shaking. Good work, $N.', 0),
(900060, 4, 'Look at that marbling. Dinner is on me, friend.', 0),
(900061, 1, 'Good. One less meddler near the tower. The Violet Eye thanks you.', 0),
(900062, 1, 'The skies are quieter. Thank you, $N.', 0),
(900063, 1, 'The patrols thank you. So do I.', 0),
(900064, 1, 'Good hunting. Hammerfall is grateful.', 0),
(900065, 1, 'Good. The roads will hold a while longer.', 0),
(900066, 1, 'The walls are safer. Well done.', 0),
(900067, 4, 'Excellent. Science thanks you, and so do I.', 0),
(900068, 1, 'Oh, thank goodness. My equipment is safe. Here you go!', 0),
(900069, 4, 'Ow! Still charged. Perfect. Here you go!', 0),
(900070, 1, 'Good work. The road south is safer for it.', 0),
(900071, 1, 'That will keep them off our ships for a while. Well done.', 0),
(900072, 1, 'My caravans thank you. My pocket thanks you more.', 0);

-- ---------------------------------------------------------------- givers
DELETE FROM `creature_queststarter` WHERE `quest` BETWEEN 900051 AND 900072;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(5636, 900051),
(14741, 900052),
(5634, 900053),
(9660, 900054),
(14738, 900055),
(7763, 900056),
(7724, 900057),
(7804, 900058),
(7564, 900059),
(8125, 900060),
(17613, 900061),
(18253, 900062),
(2700, 900063),
(2706, 900064),
(2789, 900065),
(2771, 900066),
(2774, 900067),
(3442, 900068),
(3446, 900069),
(23569, 900070),
(23568, 900071),
(3391, 900072);
DELETE FROM `creature_questender` WHERE `quest` BETWEEN 900051 AND 900072;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(5636, 900051),
(14741, 900052),
(5634, 900053),
(9660, 900054),
(14738, 900055),
(7763, 900056),
(7724, 900057),
(7804, 900058),
(7564, 900059),
(8125, 900060),
(17613, 900061),
(18253, 900062),
(2700, 900063),
(2706, 900064),
(2789, 900065),
(2771, 900066),
(2774, 900067),
(3442, 900068),
(3446, 900069),
(23569, 900070),
(23568, 900071),
(3391, 900072);

-- Revert:
-- DELETE FROM `creature_queststarter` WHERE `quest` BETWEEN 900051 AND 900072;
-- DELETE FROM `creature_questender` WHERE `quest` BETWEEN 900051 AND 900072;
-- DELETE FROM `quest_offer_reward` WHERE `ID` BETWEEN 900051 AND 900072;
-- DELETE FROM `quest_request_items` WHERE `ID` BETWEEN 900051 AND 900072;
-- DELETE FROM `quest_template_addon` WHERE `ID` BETWEEN 900051 AND 900072;
-- DELETE FROM `quest_template` WHERE `ID` BETWEEN 900051 AND 900072;
-- DELETE FROM `creature_loot_template` WHERE `Item` BETWEEN 900017 AND 900022;
-- DELETE FROM `item_template` WHERE `entry` BETWEEN 900017 AND 900022;
