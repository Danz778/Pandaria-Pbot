-- Dibuat dari DBErrors.log (Pandaria-Pbot). Jalankan pada database `world`.
-- WAJIB backup dulu:  mysqldump -u USER -p world > world_backup.sql
-- Jalankan dengan:    mysql -u USER -p world < FILE.sql
-- Periksa kecocokan schema sebelum menjalankan. Hentikan dan perbaiki jika ada error.
-- Setelah selesai, restart worldserver dan cek DBErrors.log baru.
-- Hanya menghapus/membenahi baris yang SUDAH diabaikan core (tidak mengubah gameplay).
START TRANSACTION;

-- waypoint_scripts rusak/yatim (talk text 0 atau tidak ada waypoint yang memakai)  [149 baris log]
UPDATE `waypoint_data` SET `action`=0 WHERE `action` IN (1,24,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,100,101,147,148,149,150,151,152,153,154,156,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,332,333,334,335,336,337,351,352,354,426,427,428,443,446,460,485,491,499,500,501,537,538,539,540,567,568,569,570,571,572);
DELETE FROM `waypoint_scripts` WHERE `id` IN (1,24,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,100,101,147,148,149,150,151,152,153,154,156,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,332,333,334,335,336,337,351,352,354,426,427,428,443,446,460,485,491,499,500,501,537,538,539,540,567,568,569,570,571,572);

-- SmartAI memakai creature_text yang tidak ada  [37 baris log]
DELETE FROM `smart_scripts` WHERE (`entryorguid`,`source_type`,`id`) IN ((-121192,0,0),(-84714,0,0),(-84709,0,0),(-84635,0,0),(1268,0,0),(6119,0,0),(7955,0,0),(8400,0,0),(8719,0,0),(9457,0,0),(15526,0,0),(16514,0,0),(17253,0,0),(18938,0,0),(19354,0,0),(23669,0,0),(24786,0,0),(25307,0,0),(25730,0,0),(30134,0,0),(30284,0,0),(30474,0,0),(35231,0,0),(37783,0,0),(45152,0,0),(46134,0,0),(46276,0,0),(46402,0,0),(46425,0,0),(48012,0,0),(54615,0,0),(54924,0,0),(54944,0,0),(55488,0,0),(57760,0,0),(69267,0,0),(69305,0,0));

-- SmartAI memakai spell yang tidak ada  [1 baris log]
DELETE FROM `smart_scripts` WHERE (`entryorguid`,`source_type`,`id`) IN ((14822,0,14));

-- SmartAI param min/max salah  [1 baris log]
DELETE FROM `smart_scripts` WHERE (`entryorguid`,`source_type`,`id`) IN ((3304100,9,0));

-- SmartAI action tidak didukung core  [1 baris log]
DELETE FROM `smart_scripts` WHERE (`entryorguid`,`source_type`,`id`) IN ((170600,9,9));

-- SmartAI action_type 0 (kosong)  [2 baris log]
DELETE FROM `smart_scripts` WHERE `action_type`=0 AND (`entryorguid`,`id`) IN ((31238,0),(31238,1));

-- SmartAI WaypointPath tidak ada  [2 baris log]
DELETE FROM `smart_scripts` WHERE `action_type`=53 AND (`entryorguid`,`id`) IN ((31432,2),(170600,10));

-- conditions spell-implicit-target yang diabaikan core  [41 baris log]
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND (`SourceEntry`,`SourceGroup`) IN ((77782,1),(77925,1),(77932,1),(77937,1),(80199,1),(86911,1),(87517,1),(92831,1),(96931,1),(109440,1),(114379,1),(122551,1),(126642,1),(136909,1),(139848,1),(143487,1),(147369,1),(147370,1),(80702,2),(74670,3),(78499,3),(85123,3),(85555,3),(89008,3),(100555,3),(116711,3),(119841,3),(126022,3),(134789,3),(137433,3),(137442,3),(137443,3),(137444,3),(64558,7),(68355,7),(89892,7),(100342,7),(100344,7),(100345,7),(137967,7),(60535,0));

-- conditions vehicle/spellclick ke creature yang tidak ada  [2 baris log]
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (16,18) AND `SourceEntry` IN (35431,35433);

-- conditions loot ke reference/item yang tidak ada  [2 baris log]
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=1 AND `SourceEntry` IN (-777,-738);

-- conditions ke creature_loot_template yang tidak ada  [1 baris log]
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=1 AND `SourceGroup` IN (60491);

-- conditions CONDITION_AURA dengan spell yang tidak ada
DELETE FROM `conditions` WHERE `ConditionTypeOrReference`=1 AND `ConditionValue1` IN (23770);

-- conditions OBJECT_ENTRY_GUID ke creature yang tidak ada
DELETE FROM `conditions` WHERE `ConditionTypeOrReference`=31 AND `ConditionValue1`=3 AND `ConditionValue2` IN (27754,31317,33906,33909,40684);

-- achievement_reward / locale untuk achievement yang tidak ada
DELETE FROM `achievement_reward_locale` WHERE `ID` IN (1681,1682,2145,3656,4784,4785);
DELETE FROM `achievement_reward` WHERE `entry` IN (1681,1682,2145,3656,4784,4785);

-- achievement_criteria_data tidak didukung / SCRIPT tanpa ScriptName  [21 baris log]
DELETE FROM `achievement_criteria_data` WHERE (`criteria_id`,`type`) IN ((6803,12),(7315,12),(7318,12),(7319,12),(7320,12),(7361,12),(7363,12),(7579,12),(7583,12),(7587,12),(7590,12),(7593,12),(7598,12),(11789,12),(12752,12),(12976,12),(12993,12),(7231,11),(7321,11),(16081,11),(16848,11));

-- quest_poi tanpa quest_poi_points  [16 baris log]
DELETE FROM `quest_poi` WHERE (`QuestID`,`id`) IN ((3379,1),(6922,0),(6922,1),(8306,1),(10216,1),(11078,6),(13892,0),(24591,2),(27228,2),(27316,0),(28170,1),(29151,0),(29178,0),(29763,1),(29861,0),(32944,1));

-- item_loot_template tanpa pemilik  [10 baris log]
DELETE FROM `item_loot_template` WHERE `Entry` IN (89125,93146,93147,93148,93149,94207,98095,98134,98546,104014);

-- gameobject_loot_template tanpa pemilik  [4 baris log]
DELETE FROM `gameobject_loot_template` WHERE `Entry` IN (218197,218577,220196,221776);

-- creature_loot_template tanpa pemilik  [2 baris log]
DELETE FROM `creature_loot_template` WHERE `Entry` IN (60491,62346);

-- spell_linked_spell ke spell yang tidak ada
DELETE FROM `spell_linked_spell` WHERE ABS(`spell_trigger`) IN (200002,200003,203754) OR ABS(`spell_effect`) IN (200002,200003,203754);

-- spell_area dengan quest_start yang tidak valid
DELETE FROM `spell_area` WHERE (`spell`,`quest_start`) IN ((67789,40328),(67789,40329));

-- spell_target_position tanpa TARGET_DEST_DB
DELETE FROM `spell_target_position` WHERE (`id`,`effIndex`) IN ((49986,1),(65042,2),(66836,0),(66925,0),(100679,2),(105002,0));

-- spell_scripts efek tidak cocok
DELETE FROM `spell_scripts` WHERE (`id`,`effIndex`) IN ((130973,0));

-- creature_queststarter ke quest yang tidak ada
DELETE FROM `creature_queststarter` WHERE (`id`,`quest`) IN ((69782,32592));

-- creature_questender ke quest yang tidak ada
DELETE FROM `creature_questender` WHERE (`id`,`quest`) IN ((69782,32592));

-- quest emote yang tidak ada di Emotes.dbc -> 0  [3 baris log]
UPDATE `quest_details` SET `Emote3`=0 WHERE `ID`=1242 AND `Emote3`=9;
UPDATE `quest_offer_reward` SET `Emote2`=0 WHERE `ID`=1242 AND `Emote2`=9;
UPDATE `quest_offer_reward` SET `Emote2`=0 WHERE `ID`=1244 AND `Emote2`=9;

-- gameobject_template: linkedTrap menunjuk ke GO yang bukan trap -> 0  [13 baris log]
UPDATE `gameobject_template` SET `data2`=0 WHERE `entry`=126337 AND `type`=8;
UPDATE `gameobject_template` SET `data2`=0 WHERE `entry`=126338 AND `type`=8;
UPDATE `gameobject_template` SET `data2`=0 WHERE `entry`=126339 AND `type`=8;
UPDATE `gameobject_template` SET `data2`=0 WHERE `entry`=126340 AND `type`=8;
UPDATE `gameobject_template` SET `data2`=0 WHERE `entry`=126341 AND `type`=8;
UPDATE `gameobject_template` SET `data2`=0 WHERE `entry`=126342 AND `type`=8;
UPDATE `gameobject_template` SET `data2`=0 WHERE `entry`=126345 AND `type`=8;
UPDATE `gameobject_template` SET `data12`=0 WHERE `entry`=181168 AND `type`=10;
UPDATE `gameobject_template` SET `data12`=0 WHERE `entry`=181169 AND `type`=10;
UPDATE `gameobject_template` SET `data12`=0 WHERE `entry`=181575 AND `type`=10;
UPDATE `gameobject_template` SET `data12`=0 WHERE `entry`=181576 AND `type`=10;
UPDATE `gameobject_template` SET `data12`=0 WHERE `entry`=181577 AND `type`=10;
UPDATE `gameobject_template` SET `data12`=0 WHERE `entry`=181578 AND `type`=10;

COMMIT;
