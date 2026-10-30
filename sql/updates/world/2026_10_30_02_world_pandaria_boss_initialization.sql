-- Bind the repaired first-pull boss scripts and their raid controllers.
-- Existing template stats, spawns, loot and spell bindings are preserved.
UPDATE `instance_template` SET `script` = 'instance_heart_of_fear' WHERE `map` = 1009;
UPDATE `instance_template` SET `script` = 'instance_mogu_shan_vault' WHERE `map` = 1008;
UPDATE `instance_template` SET `script` = 'instance_terrace_of_endless_spring' WHERE `map` = 996;

UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_garalon' WHERE `entry` = 62164;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_zorlok' WHERE `entry` = 62980;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_elegon' WHERE `entry` = 60410;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_liu_flameheart' WHERE `entry` = 56732;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_sha_of_fear' WHERE `entry` = 60999;
