-- Target database: acore_world
--
-- Removes the AzerothQuest quest pack: quests 900001-900999, their items, loot and map areas.
-- Run it by hand after removing the module from modules/ (the database updater does not undo module SQL), then
-- restart the worldserver. Characters keep the quests in their logs until they abandon them.

DELETE FROM `creature_queststarter` WHERE `quest` BETWEEN 900001 AND 900999;
DELETE FROM `creature_questender` WHERE `quest` BETWEEN 900001 AND 900999;
DELETE FROM `quest_offer_reward` WHERE `ID` BETWEEN 900001 AND 900999;
DELETE FROM `quest_request_items` WHERE `ID` BETWEEN 900001 AND 900999;
DELETE FROM `quest_template_addon` WHERE `ID` BETWEEN 900001 AND 900999;
DELETE FROM `quest_poi_points` WHERE `QuestID` BETWEEN 900001 AND 900999;
DELETE FROM `quest_poi` WHERE `QuestID` BETWEEN 900001 AND 900999;
DELETE FROM `quest_template` WHERE `ID` BETWEEN 900001 AND 900999;
DELETE FROM `creature_loot_template` WHERE `Item` BETWEEN 900001 AND 900999;
DELETE FROM `item_template` WHERE `entry` BETWEEN 900001 AND 900999;
DELETE FROM `updates` WHERE `name` LIKE 'azerothquest_pack_%';
