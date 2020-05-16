UPDATE lectures SET unlocks_ids = 'HIRAGANA_KA' where set_lesson_id = 'HIRAGANA_A';

update words set lesson_id = 'HIRAGANA_KA' where id >= 5 and id < 9;

update words set set_lesson_id = 'HIRAGANA_GA' where id >= 9 and id < 14;
update words set set_lesson_id = 'HIRAGANA_SA' where id >= 14 and id < 19;
update words set set_lesson_id = 'HIRAGANA_ZA' where id >= 19 and id < 24;
update words set set_lesson_id = 'HIRAGANA_TA' where id >= 24 and id < 29;
update words set set_lesson_id = 'HIRAGANA_DA' where id >= 29 and id < 32;
update words set set_lesson_id = 'HIRAGANA_NA' where id >= 32 and id < 36;
update words set set_lesson_id = 'HIRAGANA_N' where id >= 36 and id < 39;
update words set set_lesson_id = 'HIRAGANA_HA' where id >= 39 and id < 44;
update words set set_lesson_id = 'HIRAGANA_BA' where id >= 44 and id < 49;
update words set set_lesson_id = 'HIRAGANA_MA' where id >= 49 and id < 54;
update words set set_lesson_id = 'HIRAGANA_WA' where id >= 54 and id < 56;
update words set set_lesson_id = 'HIRAGANA_YA' where id >= 56 and id < 59;
update words set set_lesson_id = 'HIRAGANA_LYA' where id >= 59 and id < 63;
update words set set_lesson_id = 'HIRAGANA_RA' where id >= 63 and id < 68;
update words set set_lesson_id = 'HIRAGANA_PA' where id >= 68 and id < 73;
update words set set_lesson_id = 'HIRAGANA_WA' where id = 73;