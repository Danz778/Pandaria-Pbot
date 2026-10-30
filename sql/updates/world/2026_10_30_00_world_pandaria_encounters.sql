-- Bind the repaired Pandaria encounters to their registered C++ scripts.
-- Existing templates only: do not fabricate creature stats, spawns or loot.
UPDATE `instance_template` SET `script` = 'instance_temple_of_jade_serpent' WHERE `map` = 960;
UPDATE `instance_template` SET `script` = 'instance_shadopan_monastery' WHERE `map` = 959;
UPDATE `instance_template` SET `script` = 'instance_mogu_shan_palace' WHERE `map` = 994;
UPDATE `instance_template` SET `script` = 'instance_siege_of_niuzao_temple' WHERE `map` = 1011;

UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_sha_of_doubt' WHERE `entry` = 56439;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_figment_of_doubt' WHERE `entry` = 56792;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_taran_zhu' WHERE `entry` = 56884;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_gekkan' WHERE `entry` = 61243;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_xin_the_weaponmaster' WHERE `entry` = 61398;

-- Replace exact pairs only, preserving other bindings on these spells.
DELETE FROM `spell_script_names`
WHERE (`spell_id` = 106112 AND `ScriptName` = 'spell_sod_release_doubt')
   OR (`spell_id` = 123916 AND `ScriptName` = 'spell_tjs_seed_of_doubt')
   OR (`spell_id` = 107085 AND `ScriptName` = 'spell_taran_zhu_hate')
   OR (`spell_id` = 107200 AND `ScriptName` = 'spell_taran_zhu_meditation');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(106112, 'spell_sod_release_doubt'),
(123916, 'spell_tjs_seed_of_doubt'),
(107085, 'spell_taran_zhu_hate'),
(107200, 'spell_taran_zhu_meditation');
