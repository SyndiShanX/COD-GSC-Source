/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\homecoming_audio.gsc
*****************************************************/

main() {
  soundsettimescalefactor("music", 0);
  soundsettimescalefactor("effects2d1", 0);
  soundsettimescalefactor("effects2d2", 0);
  soundsettimescalefactor("ambient", 0);
}

sfx_scn_recruitment() {
  level.player playSound("scn_hc_recruitment_amb_lr");
}

sfx_scn_recruitment_riley_growl() {
  wait 4.6;
  self playSound("scn_hc_recruitment_riley_growl");
}

recruits_pilot_flavorbursts() {
  level.pilot maps\_utility::delaythread(2.0, maps\_utility::play_sound_on_entity, "homcom_hp1_ihavevisualsbreaking");
  level.pilot maps\_utility::delaythread(6.0, maps\_utility::play_sound_on_entity, "homcom_hp1_negativenagativeairspace");
  level.pilot maps\_utility::delaythread(13.0, maps\_utility::play_sound_on_entity, "homcom_hp2_enteringdropzoneweve");
  level.pilot maps\_utility::delaythread(24.0, maps\_utility::play_sound_on_entity, "homcom_hp2_weveclearedenemyaa");
  level.pilot maps\_utility::delaythread(29.0, maps\_utility::play_sound_on_entity, "homcom_hp2_goodruncomingback");
  level.pilot maps\_utility::delaythread(33.0, maps\_utility::play_sound_on_entity, "homcom_hp2_thisistitanthreeone");
  level.pilot maps\_utility::delaythread(39.0, maps\_utility::play_sound_on_entity, "homcom_hp2_titanthreeonecomingin");
  level.pilot maps\_utility::delaythread(45.0, maps\_utility::play_sound_on_entity, "homcom_hp2_enginetwoisout");
}