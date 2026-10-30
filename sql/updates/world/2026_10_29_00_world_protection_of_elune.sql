-- Restore Archimonde's Protection of Elune binding after the script loader repair.
-- Earlier manual cleanup could remove this binding while the loader was missing.
-- Preserve any other scripts attached to the same spell.
DELETE FROM `spell_script_names`
WHERE `spell_id` = 38528 AND `ScriptName` = 'spell_protection_of_elune';

INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(38528, 'spell_protection_of_elune');
