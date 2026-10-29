-- Dibuat dari DBErrors.log (Pandaria-Pbot). Jalankan pada database `world`.
-- WAJIB backup dulu:  mysqldump -u USER -p world > world_backup.sql
-- Jalankan dengan:    mysql --force -u USER -p world < FILE.sql
--   (--force = kalau ada nama kolom beda di schema kamu, statement itu gagal saja dan lanjut ke berikutnya)
-- Setelah selesai, restart worldserver dan cek DBErrors.log baru.
-- Perbaikan yang MENGUBAH perilaku (mengaktifkan quest/NPC/script). Baca dulu, jalankan sesukamu.
START TRANSACTION;

-- Quest yang diselesaikan lewat areatrigger/spell/SmartAI -> beri flag EXPLORATION_OR_EVENT (2)  [18 baris log]
INSERT INTO `quest_template_addon` (`ID`,`SpecialFlags`) VALUES (869,2),(13564,2),(14066,2),(14482,2),(25621,2),(25924,2),(26512,2),(26930,2),(27007,2),(27152,2),(27610,2),(29392,2),(29415,2),(29536,2),(29539,2),(30470,2),(32640,2),(32641,2)
ON DUPLICATE KEY UPDATE `SpecialFlags`=`SpecialFlags`|2;

-- NPC quest giver tanpa npcflag QUESTGIVER (2)
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (1362,58507,73136);

-- Creature punya smart_scripts tapi AIName bukan SmartAI
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry` IN (38526);

COMMIT;

-- ScriptName yang tidak ada di core (26 nama: battle_pay_*, wow_token_*, dll). Dikosongkan di semua tabel yang punya kolom ScriptName.
DROP PROCEDURE IF EXISTS `tmp_clear_scriptnames`;
DELIMITER $$
CREATE PROCEDURE `tmp_clear_scriptnames`()
BEGIN
  DECLARE done INT DEFAULT 0; DECLARE t VARCHAR(64);
  DECLARE cur CURSOR FOR SELECT TABLE_NAME FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA=DATABASE() AND COLUMN_NAME='ScriptName';
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=1;
  OPEN cur;
  lp: LOOP
    FETCH cur INTO t; IF done THEN LEAVE lp; END IF;
    IF t IN ('spell_script_names','areatrigger_scripts') THEN
      SET @q=CONCAT('DELETE FROM `',t,'` WHERE `ScriptName` IN ('achievement_im_on_a_boat','at_well_of_eternity_skip_illidan_intro','battle_pay_boost_profession','battle_pay_boost_profession_small','battle_pay_currency_conquest_1000','battle_pay_currency_honor_1000','battle_pay_currency_justice_1000','battle_pay_currency_valor_1000','battle_pay_gold_10k','battle_pay_gold_150k','battle_pay_gold_1k','battle_pay_gold_30k','battle_pay_gold_5k','battle_pay_gold_80k','battle_pay_service_change_faction','battle_pay_service_change_race','battle_pay_service_customize','battle_pay_service_level_90','battle_pay_service_rename','sat_icy_shadows','spell_howling_gale_howling_gale','spell_protection_of_elune','wow_token_1','wow_token_10','wow_token_2','wow_token_5')');
    ELSE
      SET @q=CONCAT('UPDATE `',t,'` SET `ScriptName`='''' WHERE `ScriptName` IN ('achievement_im_on_a_boat','at_well_of_eternity_skip_illidan_intro','battle_pay_boost_profession','battle_pay_boost_profession_small','battle_pay_currency_conquest_1000','battle_pay_currency_honor_1000','battle_pay_currency_justice_1000','battle_pay_currency_valor_1000','battle_pay_gold_10k','battle_pay_gold_150k','battle_pay_gold_1k','battle_pay_gold_30k','battle_pay_gold_5k','battle_pay_gold_80k','battle_pay_service_change_faction','battle_pay_service_change_race','battle_pay_service_customize','battle_pay_service_level_90','battle_pay_service_rename','sat_icy_shadows','spell_howling_gale_howling_gale','spell_protection_of_elune','wow_token_1','wow_token_10','wow_token_2','wow_token_5')');
    END IF;
    PREPARE s FROM @q; EXECUTE s; DEALLOCATE PREPARE s;
  END LOOP;
  CLOSE cur;
END$$
DELIMITER ;
CALL `tmp_clear_scriptnames`();
DROP PROCEDURE `tmp_clear_scriptnames`;
