-- Use the registered instance controllers and the repaired Stormstout boss AIs.
-- Only existing templates are updated; stats, spawns, loot and spell bindings stay intact.
UPDATE `instance_template` SET `script` = 'instance_gate_of_the_setting_sun' WHERE `map` = 962;
UPDATE `instance_template` SET `script` = 'instance_stormstout_brewery' WHERE `map` = 961;

UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_ook_ook' WHERE `entry` = 56637;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'boss_hoptallus' WHERE `entry` = 56717;
