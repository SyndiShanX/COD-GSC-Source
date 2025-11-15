/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks.gsc
*****************************************************/

main() {
  level.optimizedvehicletriggerprocess = 1;
  maps\oilrocks_hacks::main_pre_load();
  maps\oilrocks_apache_landing::_precache();
  maps\oilrocks_apache_code::apache_precache();
  maps\oilrocks_infantry_elevator::_precache();
  maps\oilrocks_slamzoom::precache_zoom();
  maps\oilrocks_infantry_panic_room::_precache();
  maps\oilrocks_infantry::_precache();
  maps\oilrocks_apache_starts::main();
  maps\oilrocks_infantry_starts::main();
  maps\oilrocks_infantry_upper_starts::main();
  maps\_utility::intro_screen_create(&"OILROCKS_INTROSCREEN_LEVELNAME", & "OILROCKS_INTROSCREEN_DATE", & "OILROCKS_INTROSCREEN_LOCATION", & "OILROCKS_INTROSCREEN_PLAYERNAME");
  maps\createart\oilrocks_art::main();
  maps\_utility::vision_set_fog_changes("", 0);
  maps\oilrocks_fx::main();
  maps\oilrocks_precache::main();
  maps\_load::main();
  maps\_utility::setsaveddvar_cg_ng("r_specularColorScale", 2.5, 7);

  if(level.xenon)
    setsaveddvar("r_texFilterProbeBilinear", 1);

  setdvar("music_enable", 1);
  maps\oilrocks_audio::main();
  thread maps\oilrocks_achievement::main();
}

new_dialogue() {
  maps\_utility::smart_radio_dialogue("oilrocks_hp5_targetsonthebridge");
  maps\_utility::smart_radio_dialogue("oilrocks_hp0_enemyaafireon");
  maps\_utility::smart_radio_dialogue("oilrocks_hp1_goodmissile");
  maps\_utility::smart_radio_dialogue("oilrocks_hp1_nice");
  maps\_utility::smart_radio_dialogue("oilrocks_hp1_goodimpact");
  maps\_utility::smart_radio_dialogue("oilrocks_hp1_werebeingtargetedlaunch");
  maps\_utility::smart_radio_dialogue("oilrocks_hp1_flaresout");
  maps\_utility::smart_radio_dialogue("oilrocks_hp1_flaring");
  maps\_utility::smart_radio_dialogue("oilrocks_hp1_flaresaway");
  maps\_utility::smart_radio_dialogue("oilrocks_hp2_fivezerowehaveenemy");
  maps\_utility::smart_radio_dialogue("oilrocks_hp5_alrightoneonegoahead");
  maps\_utility::smart_radio_dialogue("oilrocks_mrk_routesblockedgoleft");
  maps\_utility::smart_radio_dialogue("oilrocks_mrk_guysatthetop");
  maps\_utility::smart_radio_dialogue("oilrocks_hsh_deadend");
  maps\_utility::smart_radio_dialogue("oilrocks_mrk_thisway");
  maps\_utility::smart_radio_dialogue("oilrocks_hsh_placeisadamn");
}