-- Target database: acore_world
--
-- AzerothQuest quest pack: Kalimdor: Felwood, Azshara, Desolace, Thousand Needles, Stonetalon Mountains, Ashenvale (Horde).
--
-- 24 quests. Felwood and Azshara from neutral givers for both factions; Desolace and Thousand Needles from
-- neutral givers; Stonetalon Mountains for both factions (Alliance from Stonetalon Peak's and the goblins'
-- givers, Horde from Sun Rock Retreat); Ashenvale for the Horde, from Splintertree Post and Zoram'gar.
--
-- Built by tools/questpack/build_quest_pack.py: QuestLevel -1 with XP and money by the player's level,
-- MinLevel and MaxLevel within the zone's levels, quest-required multi-drop quest items copied from
-- Blasted Boar Lung with an existing display ID. Quests 900027-900050, items 900010-900016.
--
-- Safe to run twice. Restart the worldserver afterwards and delete the client's Cache folder.

-- ---------------------------------------------------------------- items
DELETE FROM `item_template` WHERE `entry` BETWEEN 900010 AND 900016;
DROP TEMPORARY TABLE IF EXISTS `aq_item`;
CREATE TEMPORARY TABLE `aq_item` SELECT * FROM `item_template` WHERE `entry` = 8392;  -- Blasted Boar Lung
UPDATE `aq_item` SET `entry` = 900010, `name` = 'Tainted Ooze Sample', `displayid` = 21972, `description` = 'It moves in the jar.' WHERE `entry` = 8392;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
UPDATE `aq_item` SET `entry` = 900011, `name` = 'Stagwing Feather', `displayid` = 19528, `description` = 'Light as air, and crackling.' WHERE `entry` = 900010;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
UPDATE `aq_item` SET `entry` = 900012, `name` = 'Coralshell Plate', `displayid` = 21363, `description` = 'Grown in the deep, hard as stone.' WHERE `entry` = 900011;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
UPDATE `aq_item` SET `entry` = 900013, `name` = 'Gritjaw Hide', `displayid` = 11164, `description` = 'Like leather over gravel.' WHERE `entry` = 900012;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
UPDATE `aq_item` SET `entry` = 900014, `name` = 'Sparkleshell Plate', `displayid` = 8914, `description` = 'It glitters even in the shade.' WHERE `entry` = 900013;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
UPDATE `aq_item` SET `entry` = 900015, `name` = 'Deepmoss Silk', `displayid` = 18597, `description` = 'Damp, strong, and faintly green.' WHERE `entry` = 900014;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
UPDATE `aq_item` SET `entry` = 900016, `name` = 'Shadowhorn Antler', `displayid` = 7999, `description` = 'Darker than any antler should be.' WHERE `entry` = 900015;
INSERT INTO `item_template` SELECT * FROM `aq_item`;
DROP TEMPORARY TABLE `aq_item`;
UPDATE `item_template` SET `class` = 12, `subclass` = 0, `Quality` = 1, `bonding` = 4, `stackable` = 20,
	`maxcount` = 0, `Flags` = 0x800, `BuyPrice` = 0, `SellPrice` = 0, `startquest` = 0
WHERE `entry` BETWEEN 900010 AND 900016;

-- ---------------------------------------------------------------- loot (quest required)
DELETE FROM `creature_loot_template` WHERE `Item` BETWEEN 900010 AND 900016;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(7092, 900010, 0, 50, 1, 1, 0, 1, 1, 'Tainted Ooze - Tainted Ooze Sample (AzerothQuest pack)'),
(7093, 900010, 0, 60, 1, 1, 0, 1, 1, 'Vile Ooze - Tainted Ooze Sample (AzerothQuest pack)'),
(6377, 900011, 0, 50, 1, 1, 0, 1, 1, 'Thunderhead Stagwing - Stagwing Feather (AzerothQuest pack)'),
(6352, 900012, 0, 50, 1, 1, 0, 1, 1, 'Coralshell Lurker - Coralshell Plate (AzerothQuest pack)'),
(4729, 900013, 0, 50, 1, 1, 0, 1, 1, 'Hulking Gritjaw Basilisk - Gritjaw Hide (AzerothQuest pack)'),
(4143, 900014, 0, 50, 1, 1, 0, 1, 1, 'Sparkleshell Snapper - Sparkleshell Plate (AzerothQuest pack)'),
(4142, 900014, 0, 40, 1, 1, 0, 1, 1, 'Sparkleshell Tortoise - Sparkleshell Plate (AzerothQuest pack)'),
(4006, 900015, 0, 50, 1, 1, 0, 1, 1, 'Deepmoss Webspinner - Deepmoss Silk (AzerothQuest pack)'),
(3817, 900016, 0, 45, 1, 1, 0, 1, 1, 'Shadowhorn Stag - Shadowhorn Antler (AzerothQuest pack)'),
(3818, 900016, 0, 50, 1, 1, 0, 1, 1, 'Elder Shadowhorn Stag - Shadowhorn Antler (AzerothQuest pack)');

-- ---------------------------------------------------------------- quests
DELETE FROM `quest_template` WHERE `ID` BETWEEN 900027 AND 900050;
INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`,
	`RewardXPDifficulty`, `RewardMoney`, `RewardMoneyDifficulty`, `Flags`, `AllowableRaces`,
	`LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`,
	`RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`,
	`RequiredItemId1`, `RequiredItemCount1`, `VerifiedBuild`) VALUES
(900027, 2, -1, 47, 361, 0, 0, 5, 0, 5, 8, 0, 'Angerclaw Fury',
	'Kill 10 Angerclaw Maulers in Felwood, then return to Greta Mosshoof at the Emerald Sanctuary.',
	'The bears of Felwood were never gentle, $N, but the corruption has made the Angerclaw mad with rage. The maulers attack anything that moves, even each other.$B$BThere is no cure for that much fury. Give them rest: ten of the maulers, and the forest south of here will breathe easier.',
	'', 'Return to Greta Mosshoof at the Emerald Sanctuary in Felwood.',
	8958, 0, 10, 0, 0, 0, 0),
(900028, 2, -1, 48, 361, 0, 0, 5, 0, 5, 8, 0, 'Ironbeak Hunters',
	'Kill 10 Ironbeak Hunters in Felwood, then return to Jessir Moonbow at the Emerald Sanctuary.',
	'The Ironbeak owls hunt our scouts from the treetops, $C. They see everything, and they strike without a sound.$B$BThe hunters roost in the middle of the forest, around Jaedenar. Bring down ten of them, and our scouts can move again.',
	'', 'Return to Jessir Moonbow at the Emerald Sanctuary in Felwood.',
	7099, 0, 10, 0, 0, 0, 0),
(900029, 2, -1, 49, 361, 0, 0, 5, 0, 5, 8, 0, 'Tainted Ooze Samples',
	'Bring 8 Tainted Ooze Samples to Ivy Leafrunner at the Emerald Sanctuary.',
	'Everything the corruption touches turns to ooze in the end, $N. If I can learn what makes the oozes of Felwood, perhaps I can learn how to stop them.$B$BThe Tainted and Vile Oozes gather around Jaedenar and the Bloodvenom Falls. Bring me samples. In jars, please.',
	'', 'Return to Ivy Leafrunner at the Emerald Sanctuary in Felwood.',
	0, 0, 0, 0, 900010, 8, 0),
(900030, 2, -1, 51, 361, 0, 0, 5, 0, 5, 8, 0, 'Shadows of Jaedenar',
	'Kill 8 Jaedenar Darkweavers and 6 Jaedenar Warlocks in Felwood, then return to Eridan Bluewind at the Emerald Sanctuary.',
	'The Shadow Council in Jaedenar weaves its magic deeper into Felwood every day, $N. The darkweavers spin the shadows; the warlocks bind the demons that feed on them.$B$BCut both threads. Without them, the rest of the council will have to show its face.',
	'', 'Return to Eridan Bluewind at the Emerald Sanctuary in Felwood.',
	7118, 7120, 8, 6, 0, 0, 0),
(900031, 2, -1, 45, 16, 0, 0, 5, 0, 5, 8, 0, 'Spitelash Serpents',
	'Kill 10 Spitelash Serpent Guards and 6 Spitelash Screamers in Azshara, then return to Archmage Xylem.',
	'The Spitelash naga claim the western shores as if the old empire had never fallen. Their serpent guards hold the coast, and their screamers call more of their kind out of the sea.$B$BI have better things to do than watch my shores, $N. Drive them back for me.',
	'', 'Return to Archmage Xylem in Azshara.',
	6194, 6193, 10, 6, 0, 0, 0),
(900032, 2, -1, 46, 16, 0, 0, 5, 0, 5, 8, 0, 'Stagwing Feathers',
	'Bring 8 Stagwing Feathers to Ogtinc in Azshara.',
	'Ogtinc study storm, $N. Storm live in feathers of Thunderhead Stagwings. Feathers crackle! Ogtinc want to know why.$B$BStagwings fly in middle of Azshara. Bring eight feathers. Ogtinc make you something nice. Maybe.',
	'', 'Return to Ogtinc in Azshara.',
	0, 0, 0, 0, 900011, 8, 0),
(900033, 2, -1, 49, 16, 0, 0, 5, 0, 5, 8, 0, 'Legashi Corruption',
	'Kill 8 Legashi Satyrs and 6 Legashi Hellcallers in Azshara, then return to Loramus Thalipedes.',
	'I know what the satyrs are, $N, because I know what they were. The Legashi in the north-east still call to the demons that made them, and their hellcallers answer.$B$BSilence them. I cannot undo what was done here, but I can keep it from being done again.',
	'', 'Return to Loramus Thalipedes in Azshara.',
	6200, 6202, 8, 6, 0, 0, 0),
(900034, 2, -1, 50, 16, 0, 0, 5, 0, 5, 8, 0, 'Coralshell Plates',
	'Bring 8 Coralshell Plates to Kim''jael in Azshara.',
	'Business opportunity, friend! The Coralshell Lurkers on the eastern coast grow shells that would make a dwarf weep. Armor, shields, decorative bowls... the market is wide open.$B$BBring me eight plates and I will give you a share. A small share. A fair share!',
	'', 'Return to Kim''jael in Azshara.',
	0, 0, 0, 0, 900012, 8, 0),
(900035, 2, -1, 52, 16, 0, 0, 5, 0, 5, 8, 0, 'Storm Bay Unrest',
	'Kill 10 Storm Bay Oracles in Azshara, then return to Duke Hydraxis.',
	'The waters of Storm Bay grow restless, mortal. The murlocs there have found oracles who listen to things in the deep that should not be listened to.$B$BEnd their listening. Ten oracles, and the bay will quiet.',
	'', 'Return to Duke Hydraxis in Azshara.',
	6351, 0, 10, 0, 0, 0, 0),
(900036, 2, -1, 34, 405, 0, 0, 5, 0, 5, 8, 0, 'Thunder in the Valley',
	'Kill 10 Elder Thunder Lizards in Desolace, then return to Warug.',
	'The elder thunder lizards in the south shake the ground when they run, and lately they run into our camp. Twice this month!$B$BWarug is tired of rebuilding. Kill ten of the elders, $N, and the young ones will learn to stay away.',
	'', 'Return to Warug in Desolace.',
	4727, 0, 10, 0, 0, 0, 0),
(900037, 2, -1, 33, 405, 0, 0, 5, 0, 5, 8, 0, 'Gritjaw Hides',
	'Bring 8 Gritjaw Hides to Uthek the Wise in Desolace.',
	'The Gelkis make their war drums from the hides of the great Gritjaw basilisks, $N. The hide is tough as stone and sings when it is struck.$B$BBring me eight hides from the Hulking Gritjaw Basilisks in the middle of the valley, and the Gelkis will remember you.',
	'', 'Return to Uthek the Wise in Desolace.',
	0, 0, 0, 0, 900013, 8, 0),
(900038, 2, -1, 36, 405, 0, 0, 5, 0, 5, 8, 0, 'Restless Maraudine',
	'Kill 8 Maraudine Maulers and 6 Ghostly Marauders in Desolace, then return to the Centaur Pariah.',
	'I was cast out by my own kind, and still I would not wish on them what the Maraudine have become. Their maulers raid the west, and their dead do not lie still.$B$BPut them down, $N, the living and the dead. Perhaps then the valley will rest.',
	'', 'Return to the Centaur Pariah in Desolace.',
	4656, 11687, 8, 6, 0, 0, 0),
(900039, 2, -1, 37, 405, 0, 0, 5, 0, 5, 8, 0, 'Dread of the Valley',
	'Kill 8 Dread Rippers and 8 Scorpashi Venomlashers in the south of Desolace, then return to Willow.',
	'The south of the valley belongs to the scavengers, $N: the dread rippers circling above and the venomlashers waiting below. Anyone who stops to rest is food.$B$BThin them out. Eight of each should make the road south a little less deadly.',
	'', 'Return to Willow in Desolace.',
	4694, 4699, 8, 8, 0, 0, 0),
(900040, 2, -1, 29, 400, 0, 0, 5, 0, 5, 8, 0, 'Sparkleshell Plates',
	'Bring 8 Sparkleshell Plates to Pozzik at the Shimmering Flats.',
	'You want to know what makes a racer fast? Weight. Or the lack of it. The Sparkleshell turtles grow plates that are light as tin and twice as strong.$B$BBring me eight plates from the snappers and tortoises on the Flats, and my next car is going to fly.',
	'', 'Return to Pozzik at the Shimmering Flats in Thousand Needles.',
	0, 0, 0, 0, 900014, 8, 0),
(900041, 2, -1, 29, 400, 0, 0, 5, 0, 5, 8, 0, 'Scorpid Plague',
	'Kill 10 Scorpid Reavers and 6 Scorpid Terrors at the Shimmering Flats, then return to Trackmaster Zherin.',
	'The scorpids have taken a liking to my race track, $N. They hide in the sand and wait for a racer to slow down. Do you know how many drivers I have lost this season?$B$BClear the track. Ten reavers and six terrors, and we can race again.',
	'', 'Return to Trackmaster Zherin at the Shimmering Flats in Thousand Needles.',
	4140, 4139, 10, 6, 0, 0, 0),
(900042, 2, -1, 25, 400, 0, 0, 5, 0, 5, 8, 0, 'Cloud Serpents',
	'Kill 10 Elder Cloud Serpents in Thousand Needles, then return to Magus Tirth.',
	'The elder cloud serpents nest among the needles and dive on anything that walks the canyon floor. The caravans will not pass while they hunt.$B$BBring down ten of the elders, $N, and the canyon will be passable again.',
	'', 'Return to Magus Tirth at the Shimmering Flats in Thousand Needles.',
	4119, 0, 10, 0, 0, 0, 0),
(900043, 2, -1, 19, 406, 0, 0, 5, 0, 5, 8, 0, 'Windshear Diggers',
	'Kill 12 Windshear Diggers in the Stonetalon Mountains, then return to Ziz Fizziks.',
	'Kobolds! In my mine! Well, not my mine yet, but it will be, once the Windshear diggers are out of it.$B$BTwelve of them, $N. Get rid of them, and Ziz Fizziks will remember you when the gold starts flowing.',
	'', 'Return to Ziz Fizziks in the Stonetalon Mountains.',
	3999, 0, 12, 0, 0, 0, 0),
(900044, 2, -1, 17, 406, 0, 0, 5, 0, 5, 8, 1101, 'Deepmoss Silk',
	'Bring 8 Deepmoss Silk to Kaela Shadowspear in the Stonetalon Mountains.',
	'The Deepmoss spiders spin a silk that does not rot, $N, even in the damp of these mountains. Our sentinels need bowstrings and bandages that last.$B$BThe webspinners nest in the east. Bring me eight lengths of their silk.',
	'', 'Return to Kaela Shadowspear in the Stonetalon Mountains.',
	0, 0, 0, 0, 900015, 8, 0),
(900045, 2, -1, 17, 406, 0, 0, 5, 0, 5, 8, 690, 'Deepmoss Silk',
	'Bring 8 Deepmoss Silk to Tammra Windfield at Sun Rock Retreat.',
	'The Deepmoss spiders spin a silk that does not rot in the damp of the mountains, $N. Our hunters need bowstrings that last through the rains.$B$BThe webspinners nest in the east. Bring me eight lengths of their silk.',
	'', 'Return to Tammra Windfield at Sun Rock Retreat in the Stonetalon Mountains.',
	0, 0, 0, 0, 900015, 8, 0),
(900046, 2, -1, 19, 406, 0, 0, 5, 0, 5, 8, 1101, 'Pridewing Menace',
	'Kill 8 Pridewing Wyverns and 6 Pridewing Consorts in the Stonetalon Mountains, then return to Gaxim Rustfizzle.',
	'The Pridewing wyverns took one of my gyrocopters right out of the sky. Wings, $N! With teeth! Nobody told me about the teeth.$B$BThin out their nests in the middle of the mountains, before they take another one.',
	'', 'Return to Gaxim Rustfizzle in the Stonetalon Mountains.',
	4012, 4014, 8, 6, 0, 0, 0),
(900047, 2, -1, 19, 406, 0, 0, 5, 0, 5, 8, 690, 'Pridewing Menace',
	'Kill 8 Pridewing Wyverns and 6 Pridewing Consorts in the Stonetalon Mountains, then return to Mor''rogal at Sun Rock Retreat.',
	'The Pridewing wyverns hunt the paths to Sun Rock, $N. They have taken two of our runners this week.$B$BGo to their nests in the middle of the mountains and thin them out. Eight wyverns and six consorts.',
	'', 'Return to Mor''rogal at Sun Rock Retreat in the Stonetalon Mountains.',
	4012, 4014, 8, 6, 0, 0, 0),
(900048, 2, -1, 23, 331, 0, 0, 5, 0, 5, 8, 690, 'Shadethicket Uprising',
	'Destroy 8 Shadethicket Bark Rippers and 8 Shadethicket Stone Movers in the south of Ashenvale, then return to Senani Thunderheart at Splintertree Post.',
	'The forest itself fights us, $N. The Shadethicket elementals in the south tear down everything we build, stone and timber alike.$B$BBreak them. Eight bark rippers and eight stone movers, and our woodcutters can work again.',
	'', 'Return to Senani Thunderheart at Splintertree Post in Ashenvale.',
	3784, 3782, 8, 8, 0, 0, 0),
(900049, 2, -1, 20, 331, 0, 0, 5, 0, 5, 8, 690, 'Shadowhorn Antlers',
	'Bring 8 Shadowhorn Antlers to Mastok Wrilehiss at Splintertree Post.',
	'The night elves hunt the Shadowhorn stags and call them sacred. Good. Then their antlers will make fine trophies for the warriors of Splintertree.$B$BBring me eight antlers, $N, from the stags in the middle and east of Ashenvale.',
	'', 'Return to Mastok Wrilehiss at Splintertree Post in Ashenvale.',
	0, 0, 0, 0, 900016, 8, 0),
(900050, 2, -1, 18, 331, 0, 0, 5, 0, 5, 8, 690, 'Crawlers of Zoram',
	'Kill 10 Clattering Crawlers and 8 Spined Crawlers on the Zoram Strand, then return to Je''neu Sancrea at Zoram''gar Outpost.',
	'The crawlers on the Zoram Strand grow bolder every tide, $N. They snap at our fishers and drag the nets into the sea.$B$BClear the beach for us: ten clattering crawlers and eight spined ones.',
	'', 'Return to Je''neu Sancrea at Zoram''gar Outpost in Ashenvale.',
	3812, 3814, 10, 8, 0, 0, 0);

DELETE FROM `quest_template_addon` WHERE `ID` BETWEEN 900027 AND 900050;
INSERT INTO `quest_template_addon` (`ID`, `MaxLevel`) VALUES
(900027, 55),
(900028, 56),
(900029, 57),
(900030, 58),
(900031, 53),
(900032, 54),
(900033, 57),
(900034, 58),
(900035, 60),
(900036, 43),
(900037, 42),
(900038, 44),
(900039, 45),
(900040, 38),
(900041, 38),
(900042, 33),
(900043, 27),
(900044, 25),
(900045, 25),
(900046, 27),
(900047, 27),
(900048, 31),
(900049, 29),
(900050, 25);

DELETE FROM `quest_request_items` WHERE `ID` BETWEEN 900027 AND 900050;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`, `VerifiedBuild`) VALUES
(900027, 1, 1, 'Are the maulers at rest, $N?', 0),
(900028, 1, 1, 'Do the owls still hunt?', 0),
(900029, 1, 1, 'Did you bring the samples?', 0),
(900030, 1, 1, 'Is the council weakened?', 0),
(900031, 1, 1, 'Are the shores clear?', 0),
(900032, 1, 1, 'You have feathers?', 0),
(900033, 1, 1, 'Are the Legashi silent?', 0),
(900034, 1, 1, 'Shells! Did you get the shells?', 0),
(900035, 1, 1, 'The bay, mortal?', 0),
(900036, 1, 1, 'The lizards, $N?', 0),
(900037, 1, 1, 'Do you bring the hides?', 0),
(900038, 1, 1, 'Do they rest now?', 0),
(900039, 1, 1, 'Is the south safer?', 0),
(900040, 1, 1, 'Plates? Tell me you have plates.', 0),
(900041, 1, 1, 'Is the track clear?', 0),
(900042, 1, 1, 'The serpents?', 0),
(900043, 1, 1, 'Is my mine free?', 0),
(900044, 1, 1, 'Did you bring the silk?', 0),
(900045, 1, 1, 'Did you bring the silk?', 0),
(900046, 1, 1, 'Are the skies safe?', 0),
(900047, 1, 1, 'Are the paths safe?', 0),
(900048, 1, 1, 'Are the elementals broken?', 0),
(900049, 1, 1, 'You have the antlers?', 0),
(900050, 1, 1, 'Is the beach clear?', 0);

DELETE FROM `quest_offer_reward` WHERE `ID` BETWEEN 900027 AND 900050;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `RewardText`, `VerifiedBuild`) VALUES
(900027, 1, 'It is a sad thing to do, but a kind one. Thank you.', 0),
(900028, 1, 'The skies are clearer already. Well done, $N.', 0),
(900029, 4, 'Eight samples, all still wriggling. This will keep me busy for weeks. Thank you!', 0),
(900030, 1, 'The shadows over Jaedenar are thinner tonight. Thank you, $C.', 0),
(900031, 1, 'Adequate. More than adequate, in fact. Here, for your trouble.', 0),
(900032, 4, 'Feathers crackle! Ogtinc happy. Here, take shiny.', 0),
(900033, 1, 'Good. Every voice that stops calling is one less door opened.', 0),
(900034, 4, 'Beautiful. Your share, as promised. Pleasure doing business!', 0),
(900035, 1, 'The waters are calmer. The Hydraxian Waterlords take note of your deeds.', 0),
(900036, 1, 'Quiet ground at last. Warug thanks you.', 0),
(900037, 1, 'These will make fine drums. The Gelkis thank you, outsider.', 0),
(900038, 1, 'Thank you. Not every centaur is your enemy, $N. Remember that.', 0),
(900039, 1, 'You are braver than most who pass through here. Thank you.', 0),
(900040, 4, 'Look at these! Light as a feather. Race day is going to be something.', 0),
(900041, 1, 'Clear track, happy drivers. Here, you have earned this.', 0),
(900042, 1, 'The canyon is safer for it. Well done.', 0),
(900043, 1, 'Wonderful! Here is a little advance on the profits.', 0),
(900044, 1, 'Strong and clean. Our sentinels will thank you.', 0),
(900045, 1, 'Strong and clean. The hunters of Sun Rock thank you.', 0),
(900046, 1, 'Splendid! My next gyrocopter thanks you, in advance.', 0),
(900047, 1, 'The runners will be glad. You have done well.', 0),
(900048, 1, 'The forest is quieter. Splintertree thanks you.', 0),
(900049, 2, 'Fine trophies. The warriors will wear them proudly.', 0),
(900050, 1, 'The fishers will be glad. Well done, $N.', 0);

-- ---------------------------------------------------------------- givers
DELETE FROM `creature_queststarter` WHERE `quest` BETWEEN 900027 AND 900050;
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(10922, 900027),
(11019, 900028),
(10924, 900029),
(9116, 900030),
(8379, 900031),
(8405, 900032),
(7783, 900033),
(8420, 900034),
(13278, 900035),
(5398, 900036),
(5397, 900037),
(13717, 900038),
(13656, 900039),
(4630, 900040),
(4629, 900041),
(6548, 900042),
(4201, 900043),
(4080, 900044),
(11864, 900045),
(4077, 900046),
(11861, 900047),
(12696, 900048),
(12737, 900049),
(12736, 900050);
DELETE FROM `creature_questender` WHERE `quest` BETWEEN 900027 AND 900050;
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(10922, 900027),
(11019, 900028),
(10924, 900029),
(9116, 900030),
(8379, 900031),
(8405, 900032),
(7783, 900033),
(8420, 900034),
(13278, 900035),
(5398, 900036),
(5397, 900037),
(13717, 900038),
(13656, 900039),
(4630, 900040),
(4629, 900041),
(6548, 900042),
(4201, 900043),
(4080, 900044),
(11864, 900045),
(4077, 900046),
(11861, 900047),
(12696, 900048),
(12737, 900049),
(12736, 900050);

-- Revert:
-- DELETE FROM `creature_queststarter` WHERE `quest` BETWEEN 900027 AND 900050;
-- DELETE FROM `creature_questender` WHERE `quest` BETWEEN 900027 AND 900050;
-- DELETE FROM `quest_offer_reward` WHERE `ID` BETWEEN 900027 AND 900050;
-- DELETE FROM `quest_request_items` WHERE `ID` BETWEEN 900027 AND 900050;
-- DELETE FROM `quest_template_addon` WHERE `ID` BETWEEN 900027 AND 900050;
-- DELETE FROM `quest_template` WHERE `ID` BETWEEN 900027 AND 900050;
-- DELETE FROM `creature_loot_template` WHERE `Item` BETWEEN 900010 AND 900016;
-- DELETE FROM `item_template` WHERE `entry` BETWEEN 900010 AND 900016;
