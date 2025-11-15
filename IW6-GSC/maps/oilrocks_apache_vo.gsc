/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_apache_vo.gsc
***************************************/

apache_mission_vo_think(var_0) {
  level endon("FLAG_apache_crashing");
  [[var_0]]();
}

apache_mission_vo_player_crashing() {
  level endon("FLAG_transition_to_infantry_slamzoom_start");
  waittillframeend;
  common_scripts\utility::flag_wait("FLAG_apache_crashing");
  maps\_utility::radio_dialogue_stop();
}

apache_mission_vo_tutorial() {
  wait 6.0;
  maps\_utility::smart_radio_dialogue("oilrocks_hp1_piratefivezerothisis");
  maps\_utility::smart_radio_dialogue("oilrocks_hp5_rogeroneone");
  maps\_utility::smart_radio_dialogue("oilrocks_hp5_beadvisedwereseeing");
  maps\_utility::smart_radio_dialogue("oilrocks_hp0_confirmfivezerospotsout");
  common_scripts\utility::flag_wait("introscreen_complete");
  maps\_utility::smart_radio_dialogue("oilrocks_hp1_seeifweneed");
  maps\_utility::smart_radio_dialogue("oilrocks_hp5_imcheckingonthat");
  common_scripts\utility::flag_wait("FLAG_apache_tut_fly_quarter");
  maps\_utility::smart_radio_dialogue("oilrocks_hp1_tensecondsoutwe");
  maps\_utility::smart_radio_dialogue("oilrocks_hp0_comeoncomeon");
  wait 1;
  thread maps\_utility::autosave_by_name();
  maps\_utility::smart_radio_dialogue("oilrocks_hp5_alrightwereclearedto");
  maps\_utility::smart_radio_dialogue("oilrocks_hp1_fivezerodoyouwant");
  wait 0.5;
  maps\_utility::smart_radio_dialogue("oilrocks_hp5_everythingyougot");
  maps\_utility::smart_radio_dialogue("oilrocks_hp1_roger");
  maps\_utility::smart_radio_dialogue("oilrocks_hp0_onezerowillbeusing");
  common_scripts\utility::flag_wait("FLAG_apache_tut_fly_targets");
  common_scripts\utility::flag_set("FLAG_apache_tut_fly_dialogue_finished");
}

apache_mission_vo_factory() {
  common_scripts\utility::flag_wait("FLAG_apache_tut_fly_dialogue_finished");
  maps\_utility::smart_radio_dialogue("oilrocks_hp0_alrightboysletsgo");
  maps\_utility::smart_radio_dialogue("oilrocks_hp1_holyshitthatsa");
  maps\_utility::smart_radio_dialogue("oilrocks_hp0_lotsofmachinegun");
  wait 0.5;
  apache_mission_vo_factory_combat();
  wait 2.5;
  common_scripts\utility::flag_wait("FLAG_apache_factory_destroyed");
  common_scripts\utility::flag_wait_or_timeout("FLAG_apache_factory_finished", 3.0);
}

apache_mission_vo_factory_combat() {
  if(common_scripts\utility::flag("FLAG_apache_factory_destroyed")) {
    return;
  }
  level endon("FLAG_apache_factory_destroyed");
  maps\_utility::smart_radio_dialogue("oilrocks_hp5_wegotenemyfire");
  maps\_utility::smart_radio_dialogue("oilrocks_hp0_solidcopyonsmoke");
  maps\_utility::smart_radio_dialogue("oilrocks_hp0_oneoneyoutrackingall");
  maps\_utility::smart_radio_dialogue("oilrocks_hp1_oneoneisreengaging");
  maps\_utility::smart_radio_dialogue("oilrocks_hp5_theresmoretargetson");
  common_scripts\utility::flag_wait("FLAG_apache_factory_allies_close");
  wait 1.0;
  maps\_utility::smart_radio_dialogue("oilrocks_hp5_oneonewehaveenemy");
  maps\_utility::smart_radio_dialogue("oilrocks_hp0_onezeroisonthe");
  maps\_utility::smart_radio_dialogue("oilrocks_hp0_wereengagingthebuilding");
  maps\_utility::smart_radio_dialogue("oilrocks_hp5_enemybirdsnearthe");
  maps\_utility::smart_radio_dialogue("oilrocks_hp0_wehaveenemybirds");
  maps\_utility::smart_radio_dialogue("oilrocks_hp1_goteyesonem");
  maps\_utility::smart_radio_dialogue("oilrocks_hp5_continueengaging");
  maps\_utility::smart_radio_dialogue("oilrocks_hp0_oneoneonezeroflyin");
  maps\_utility::smart_radio_dialogue("oilrocks_hp0_onezeroiswinchesteron");
  maps\_utility::smart_radio_dialogue("oilrocks_hp5_copythatonezero");
  wait 10;
  maps\_utility::smart_radio_dialogue("oilrocks_hp5_werestilltakingenemy");
  maps\_utility::smart_radio_dialogue("oilrocks_hp5_oneonecanyouclean");
  maps\_utility::smart_radio_dialogue("oilrocks_hp1_rogerwellswingaround");
  common_scripts\utility::flag_wait("FLAG_apache_factory_hind_take_off_dead");
  common_scripts\utility::flag_wait("FLAG_apache_factory_player_close");
}

apache_mission_vo_antiair() {
  wait 0.5;
  wait 3.0;
  wait 0.25;
  common_scripts\utility::flag_set("FLAG_apache_chase_vo_done");
}

apache_mission_vo_chopper() {
  wait 1.0;
  maps\_utility::smart_radio_dialogue("oilrocks_hp0_enemybirdsnorthside");
  maps\_utility::smart_radio_dialogue("oilrocks_hp5_wehaveenemybirds");
  maps\_utility::smart_radio_dialogue("oilrocks_hp5_keepsomedistanceand");
  wait 0.8;
  wait 1.5;
  common_scripts\utility::flag_set("FLAG_apache_chopper_vo_take_it_done");
  common_scripts\utility::flag_wait("FLAG_apache_chopper_hind_destroyed_two");
  maps\_utility::smart_radio_dialogue("oilrocks_hp0_shitmantheygot");
  maps\_utility::smart_radio_dialogue("oilrocks_hp5_flaresflares");
  maps\_utility::smart_radio_dialogue("oilrocks_hp1_goodhitgoodhit");
  maps\_utility::smart_radio_dialogue("oilrocks_hp1_yougothim");
  wait 1.0;
  common_scripts\utility::flag_wait("FLAG_apache_chopper_hind_remaining_three");
  maps\_utility::smart_radio_dialogue("oilrocks_hp1_goodengagement");
  wait 1.0;
  maps\_utility::smart_radio_dialogue("oilrocks_hp1_scantothewest");
  maps\_utility::smart_radio_dialogue("oilrocks_hp1_enemybirdsarestill");
  wait 0.5;
  common_scripts\utility::flag_wait("FLAG_apache_chopper_hind_remaining_one");
  common_scripts\utility::flag_set("FLAG_apache_chopper_vo_done");
  common_scripts\utility::flag_wait("FLAG_apache_chopper_finished");
  maps\_utility::smart_radio_dialogue("oilrocks_hp5_airspaceisclear");
}

apache_mission_vo_finale() {
  wait 1.0;
  maps\_utility::smart_radio_dialogue("oilrocks_hp5_outlawtwooneyoureclear");
  maps\_utility::smart_radio_dialogue("oilrocks_hp2_colidcopyfivezerowere");
  wait 3;
  maps\_utility::smart_radio_dialogue("oilrocks_hp5_uhhhwegotmultiple");
  wait 0.5;
  maps\_utility::smart_radio_dialogue("oilrocks_hp0_rightbelowus");
  wait 0.3;
  maps\_utility::smart_radio_dialogue("oilrocks_hp1_rogergotem");
  wait 3;
  maps\_utility::smart_radio_dialogue("oilrocks_hp5_focusonthosemovers");
  wait 2;
  maps\_utility::smart_radio_dialogue("oilrocks_hp1_weengagedseveralmovers");
  maps\_utility::smart_radio_dialogue("oilrocks_hp0_okrogerthatswinging");
  maps\_utility::smart_radio_dialogue("oilrocks_hp2_shit");
}