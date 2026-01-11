/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_alien_dlc3_vignettes.gsc
***********************************************/

main() {
  vignette_flag_init();

  while(!isDefined(level.players)) {
    wait 0.1;
  }

  vo_vignette_logic();
}

vignette_flag_init() {
  common_scripts\utility::flag_init("vanguard_taken");
  common_scripts\utility::flag_init("blocker_gate_damaged");
  common_scripts\utility::flag_init("intro_vo_done");
  common_scripts\utility::flag_init("ark_intro_vo_done");
  common_scripts\utility::flag_init("ark_encounter_begun");
  common_scripts\utility::flag_init("players_left_ark");
  common_scripts\utility::flag_init("area_2");
  common_scripts\utility::flag_init("area_3");
  common_scripts\utility::flag_init("entering_ark_flag");
  common_scripts\utility::flag_init("blocker_gate_1_init_vo_done");
  common_scripts\utility::flag_init("blocker_gate_1_vo_done");
  common_scripts\utility::flag_init("blocker_gate_2_vo_done");
  common_scripts\utility::flag_init("area_3_done");
  common_scripts\utility::flag_init("ark_cortex_pickedup");
  common_scripts\utility::flag_init("archer_3_vignette_ready");
  level thread set_flag_on_notify("vanguard_used", "vanguard_taken");
  level thread set_flag_on_notify("gate_damaged", "blocker_gate_damaged");
  level thread set_flag_on_notify("area_2_start", "area_2");
  level thread set_flag_on_notify("area_3_start", "area_3");
  level thread set_flag_on_notify("entering_ark", "entering_ark_flag");
}

vo_vignette_logic() {
  level thread area_1_vo();
  level thread area_2_vo();
  level thread area_3_vo();
}

area_1_vo() {
  if(common_scripts\utility::flag("area_2") || common_scripts\utility::flag("area_3")) {
    return;
  }
  level thread descent_intro_vo();
  level thread descent_cipher_desc();
  level thread descent_vo_after_first_hive();
  level thread descent_vo_if_looking_at_ark();
  level thread check_players_looking_at_ark();
  level thread descent_vo_before_first_blocker();
  level thread descent_vo_after_first_blocker();
  level thread send_notify_on_players_in_radius("area_2_start", (-1245, -2794, 1043), 300);
}

area_2_vo() {
  if(common_scripts\utility::flag("area_3")) {
    return;
  }
  common_scripts\utility::flag_wait("area_2");
  level thread descent_vo_area_2_start();
  level thread descent_vo_area_2_post_hive();
  level thread descent_vo_area_2_after_third_hive();
  level thread send_notify_on_players_in_radius("area_3_start", (-2628, 436, 1352), 300);
  level thread descent_vo_before_second_blocker();
  level thread descent_vo_after_second_blocker();
}

area_3_vo() {
  common_scripts\utility::flag_wait("area_3");
  level thread descent_vo_area_3_start();
  level thread descent_vo_area_3_post_hive();
  level thread send_notify_on_players_in_radius("entering_ark", (-225, 1878, 898), 300);
  level thread descent_vo_ark_combat_start();
  level thread descent_vo_ark_combat_end();
}

descent_intro_vo() {
  wait 5.0;

  if(common_scripts\utility::flag("intro_vo_done")) {
    return;
  }
  var_0 = ["descent_gdf_wevebeenfightingour"];
  play_descent_vignette_vo(var_0);
  var_0 = ["descent_gdf_theancestorswillbe"];
  play_descent_vignette_vo(var_0);
  level notify("intro_vo_done");
}

descent_cipher_desc() {
  level endon("drill_planted");
  level waittill("intro_vo_done");
  wait 1;

  if(common_scripts\utility::flag("intro_vo_done")) {
    return;
  }
  var_0 = ["descent_gdf_yourteamhasbeen"];
  play_descent_vignette_vo(var_0);
  wait 1.5;
  level thread descent_cipher_nag();
}

descent_cipher_nag() {
  level endon("drill_planted");
  var_0 = ["descent_gdf_thecipherusescross"];
  play_descent_vignette_vo(var_0);
}

descent_vo_after_first_hive() {
  if(!isDefined(level.first_hive_vo_done)) {
    level waittill("drill_planted");
  }

  while(!isDefined(level.drill)) {
    wait 0.1;
  }

  level.drill waittill("drill_complete");
  delay_vo_until_all_clear(15);
  var_0 = ["descent_gdf_goodworkwhenthe"];
  play_descent_vignette_vo(var_0);
}

descent_vo_before_first_blocker() {
  level waittill("vo_before_first_blocker");
  delay_vo_until_all_clear(15);
  var_0 = (174, -2735, 1252);
  level thread send_notify_on_players_in_radius("close_to_blocker_1", var_0, 500);
  level waittill("close_to_blocker_1");
  var_1 = ["descent_gdf_damnitthosegates"];
  play_descent_vignette_vo(var_1);

  if(!common_scripts\utility::flag("vanguard_taken")) {
    var_1 = ["descent_gdf_lookforawayto"];
    play_descent_vignette_vo(var_1);
    wait 20;
  }

  common_scripts\utility::flag_set("blocker_gate_1_init_vo_done");
}

descent_vo_after_first_blocker() {
  level waittill("vo_after_first_blocker");
  delay_vo_until_all_clear(30);
  var_0 = ["descent_gdf_niceworkcifone"];
  play_descent_vignette_vo(var_0);
  wait 5;
  var_0 = ["descent_gdf_24hoursagoarcher"];
  play_descent_vignette_vo(var_0);
  common_scripts\utility::flag_set("blocker_gate_1_vo_done");
}

descent_vo_if_looking_at_ark() {
  level endon("area_2");
  level waittill("player_looking_ark");

  if(randomint(2) == 0) {
    var_0 = ["descent_gdf_cif1wevedetecteda"];
  }
  else {
    var_0 = ["descent_gdf_cif1wevedetecteda2"];
  }

  play_descent_vignette_vo(var_0);
}

descent_vo_area_2_start() {
  common_scripts\utility::flag_wait("blocker_gate_1_vo_done");
  var_0 = ["descent_gdf_thehieroglyphicencryptionwill"];
  play_descent_vignette_vo(var_0);
}

descent_vo_area_2_post_hive() {
  wait_until_hive_is_done();
  delay_vo_until_all_clear(15);
  wait 5;
  var_0 = ["descent_gdf_thecortexisthe"];
  play_descent_vignette_vo(var_0);
}

descent_vo_area_2_after_third_hive() {
  wait_until_hive_is_done();
  wait_until_hive_is_done();
  wait_until_hive_is_done();
  var_0 = ["descent_gdf_gravimetric", "descent_gdf_differentworld"];
  play_descent_vignette_vo(var_0);
}

wait_until_hive_is_done() {
  level waittill("drill_planted");

  while(!isDefined(level.drill)) {
    wait 0.1;
  }

  level.drill waittill("drill_complete");
}

descent_vo_before_second_blocker() {
  level waittill("vo_before_second_blocker");
  var_0 = ["descent_gdf_archersassaultforcewas"];
  play_descent_vignette_vo(var_0);
}

descent_vo_after_second_blocker() {
  level waittill("vo_after_second_blocker");
  var_0 = ["descent_gdf_goodjobcif1youve"];
  play_descent_vignette_vo(var_0);
  wait 2.0;
  common_scripts\utility::flag_set("blocker_gate_2_vo_done");
}

descent_vo_area_3_start() {
  common_scripts\utility::flag_wait("blocker_gate_2_vo_done");
  var_0 = ["descent_gdf_3controltowers", "descent_gdf_extendabridge"];
  play_descent_vignette_vo(var_0);
}

descent_vo_area_3_post_hive() {
  wait_until_hive_is_done();
  delay_vo_until_all_clear(15);
  var_0 = ["descent_gdf_cif1theressomethingelse2"];

  if(!common_scripts\utility::flag("area_3_done")) {
    play_descent_vignette_vo(var_0);
  }
}

descent_vo_area_3_end() {
  var_0 = ["descent_gdf_deadweight"];

  if(!common_scripts\utility::flag("area_3_done")) {
    play_descent_vignette_vo(var_0);
  }
}

descent_vo_entering_ark() {
  var_0 = ["descent_gdf_rememberthisisnta", "descent_crs_youretoolatetoo", "descent_gdf_crossarcherwasright", "descent_crs_itstimeyoupulled"];
  play_descent_vignette_vo(var_0);
}

descent_vo_inside_ark(var_0, var_1) {
  level endon("ark_encounter_begun");
  thread ark_intro_music();
  var_0 scriptmodelplayanimdeltamotion("alien_descent_vignette_dialogue_1");
  var_1 scriptmodelplayanim("alien_descent_vignette_dialogue_1");
  wait 1;
  play_archer_vo("descent_arc_youagain", "ark_encounter_begun");
  var_2 = ["descent_gdf_securethecortexand", "descent_crs_listentomethe"];
  play_descent_vignette_vo(var_2, "ark_encounter_begun");
  play_archer_vo("descent_arc_sheslying", "ark_encounter_begun");
  wait 0.1;
  var_2 = ["descent_crs_thereactordrawsheat"];
  play_descent_vignette_vo(var_2, "ark_encounter_begun");
  play_archer_vo("descent_arc_dontlistentothat", "ark_encounter_begun");
  wait 0.1;
  var_2 = ["descent_crs_getthecortexand"];
  play_descent_vignette_vo(var_2, "ark_encounter_begun");
  common_scripts\utility::flag_set("ark_intro_vo_done");
}

ark_intro_music() {
  foreach(var_1 in level.players) {
    if(common_scripts\utility::flag("alien_music_playing")) {
      var_1 stoplocalsound("mp_suspense_01");
      var_1 stoplocalsound("mp_suspense_02");
      var_1 stoplocalsound("mp_suspense_03");
      var_1 stoplocalsound("mp_suspense_04");
      var_1 stoplocalsound("mp_suspense_05");
      var_1 stoplocalsound("mp_suspense_06");
      var_1 stoplocalsound("mus_alien_newwave");
      common_scripts\utility::flag_clear("alien_music_playing");
    }

    common_scripts\utility::flag_set("alien_music_playing");

    if(maps\mp\_utility::isreallyalive(var_1)) {
      var_1 playlocalsound("mus_alien_dlc3_ark_intro");
    }
  }
}

play_archer_vo(var_0, var_1) {
  if(isDefined(var_1)) {
    level endon(var_1);
  }

  while(!isDefined(level.archer)) {
    wait 0.1;
  }

  if(soundexists(var_0)) {
    var_2 = lookupsoundlength(var_0);
    var_2 = var_2 / 1000;
    playsoundatpos(level.archer.origin, var_0);
    wait(var_2);
    return var_2;
  }

  return 0;
}

descent_vo_ark_combat_start() {
  common_scripts\utility::flag_wait("ark_intro_vo_done");
  wait 2.0;
  var_0 = ["descent_crs_protecttheterminals"];
  play_descent_vignette_vo(var_0);
}

descent_vo_ark_combat_halfway() {
  var_0 = ["descent_crs_itshalfwaythere"];
  play_descent_vignette_vo(var_0);
}

descent_vo_ark_combat_almost_done() {
  var_0 = ["descent_crs_thereactorsalmostcritical"];
  play_descent_vignette_vo(var_0);
}

descent_vo_ark_combat_end() {
  common_scripts\utility::flag_wait("ark_console_cycle_over");
  level thread check_players_in_ark();
  level thread descent_vo_archer_end_vignette();
  var_0 = ["descent_crs_youdiditthe"];
  play_descent_vignette_vo(var_0);
  var_0 = ["descent_crs_burnyouevilsongsofbitches"];
  play_descent_vignette_vo(var_0);
  wait 3.0;
  var_0 = ["descent_crs_thedoorsareopening"];
  play_descent_vignette_vo(var_0);

  while(maps\mp\alien\_utility::is_true(level.archer_end_vo)) {
    wait 0.1;
  }

  if(!common_scripts\utility::flag("ark_cortex_pickedup")) {
    var_0 = ["descent_crs_takethecortexyoull"];
    play_descent_vignette_vo(var_0);
  }

  common_scripts\utility::flag_wait("players_left_ark");
  descent_vo_archer_death();
  wait 2;
  descent_vo_escape();
}

descent_vo_archer_end_vignette() {
  common_scripts\utility::flag_wait("ark_cortex_pickedup");
  var_0 = 22.33;
  wait 3.76;
  var_0 = var_0 - 3.76;
  level.archer_end_vo = 1;

  if(!common_scripts\utility::flag("players_left_ark")) {
    var_1 = play_archer_vo("descent_arc_waityoucantleave");
    var_0 = var_0 - var_1;
  }

  wait 0.1;
  var_0 = var_0 - 0.1;
  level.archer_end_vo = 0;
  wait 2;
  var_0 = var_0 - 2;
  level.archer_end_vo = 1;

  if(!common_scripts\utility::flag("players_left_ark")) {
    var_1 = play_archer_vo("descent_arc_youneedme");
    var_0 = var_0 - var_1;
  }

  wait 0.1;
  var_0 = var_0 - 0.1;
  level.archer_end_vo = 0;
  wait 3;
  var_0 = var_0 - 3;
  level.archer_end_vo = 1;

  if(!common_scripts\utility::flag("players_left_ark")) {
    var_1 = play_archer_vo("descent_arc_takemewithyou");
    var_0 = var_0 - var_1;
  }

  wait 0.1;
  var_0 = var_0 - 0.1;
  level.archer_end_vo = 0;

  if(var_0 > 0) {
    wait(var_0);
  }

  level notify("archer_dialogue_3_done");
}

descent_vo_archer_death() {
  wait 2;
  play_archer_vo("descent_arc_illseeyouin");
  wait 0.1;
  playsoundatpos(level.archer.origin, "scn_dsnt_archer_collapse");
  wait 0.8;
  play_archer_vo("descent_arc_dieshorribly");
}

descent_vo_ark_defenses() {
  var_0 = ["descent_crs_arksdefenses"];
  play_descent_vignette_vo(var_0);
}

ark_cortex_help() {
  var_0 = ["descent_crs_deathofliving"];
  var_1 = randomint(3);

  switch (var_1) {
    case 0:
      var_0 = ["descent_crs_deathofliving"];
      break;
    case 1:
      var_0 = ["descent_crs_psychokinetcbattery"];
      break;
    case 2:
      var_0 = ["descent_crs_killingcryptids"];
      break;
  }

  play_descent_vignette_vo(var_0);
}

descent_vo_escape() {
  var_0 = ["descent_gdf_seismicreadings", "descent_gdf_cavernentrance"];
  play_descent_vignette_vo(var_0);
}

descent_vo_escape_cortex_nag() {
  var_0 = ["descent_crs_placeneargateway"];
  play_descent_vignette_vo(var_0);
}

descent_vo_escape_cortex_charge_50(var_0) {
  if(var_0 > 2) {
    return;
  }
  var_1 = ["descent_crs_keepkilling"];

  if(var_0 == 2) {
    var_1 = ["descent_crs_halfwaycharged"];
  }

  play_descent_vignette_vo(var_1);
}

descent_vo_escape_cortex_ready(var_0) {
  if(var_0 > 2) {
    return;
  }
  var_1 = ["descent_crs_triggerthecortex"];

  if(var_0 == 2) {
    var_1 = ["descent_crs_activatethecortex"];
  }

  play_descent_vignette_vo(var_1);
}

descent_vo_escape_barrier_down(var_0) {
  if(var_0 > 2) {
    return;
  }
  var_1 = ["descent_crs_moveforward"];

  if(var_0 == 2) {
    var_1 = ["descent_gdf_cortexbacktosurface"];
  }

  play_descent_vignette_vo(var_1);
}

descent_vo_escape_cortex_left_behind() {
  var_0 = ["descent_gdf_retrievethecortex"];
  play_descent_vignette_vo(var_0);
}

check_players_in_ark() {
  var_0 = 1;
  var_1 = 1900;

  while(var_0) {
    var_0 = 0;

    foreach(var_3 in level.players) {
      if(distance(var_3.origin, (3564, 1887, 976)) < var_1) {
        var_0 = 1;
      }
    }

    if(isDefined(level.cortex) && distance(level.cortex.origin, (3564, 1887, 976)) < var_1) {
      var_0 = 1;
    }

    wait 0.1;
  }

  common_scripts\utility::flag_set("players_left_ark");
}

check_players_looking_at_ark() {
  level endon("area_2_start");
  var_0 = 0;
  var_1 = cos(25);
  var_2 = (1815, 744, 3000);
  var_3 = (1467, -2230, 1121);
  var_4 = 400;
  var_5 = var_4 * var_4;

  while(!var_0) {
    while(common_scripts\utility::flag("drill_drilling")) {
      wait 0.25;
    }

    foreach(var_7 in level.players) {
      if(distancesquared(var_7.origin, var_3) < var_5) {
        var_8 = var_7 getplayerangles();

        if(common_scripts\utility::within_fov(var_7.origin, var_8, var_2, var_1)) {
          var_0 = 1;
        }
      }
    }

    wait 0.1;
  }

  level notify("player_looking_ark");
}

play_descent_vignette_vo(var_0, var_1) {
  thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);

  foreach(var_3 in var_0) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(!soundexists(var_3)) {
      continue;
    }
    if(isDefined(var_1) && common_scripts\utility::flag(var_1)) {
      break;
    }

    if(!maps\mp\alien\_utility::is_true(level.archer_end_vo)) {
      maps\mp\mp_alien_dlc3::play_global_vo(var_3);
    }

    var_4 = lookupsoundlength(var_3) / 1000;
    wait(var_4 + 0.1);
  }

  thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
}

delay_vo_until_all_clear(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 30;
  }

  var_1 = gettime() - var_0 * 1000;
  var_2 = gettime();

  while(var_1 <= var_2) {
    var_1 = gettime() - var_0 * 1000;
    var_3 = 0;
    var_4 = level.agentarray;

    foreach(var_6 in var_4) {
      if(isDefined(var_6)) {
        if(isalive(var_6) || var_6.model == "alien_spore") {
          if(var_6.team == "axis" && isDefined(var_6.alien_type) && var_6.alien_type != "spider" || var_6.model == "alien_spore" && var_6.team == "axis") {
            var_3 = 1;
            break;
          }
        }
      }
    }

    if(var_3 == 0) {
      wait(randomfloatrange(1, 3.5));
      return;
    }

    wait 0.5;
  }
}

set_flag_on_notify(var_0, var_1) {
  self waittill(var_0);

  if(!common_scripts\utility::flag(var_1)) {
    common_scripts\utility::flag_set(var_1);
  }
}

send_notify_on_players_in_radius(var_0, var_1, var_2) {
  while(!common_scripts\utility::flag_exist("drill_drilling")) {
    wait 0.25;
  }

  var_3 = 0;
  var_4 = var_2 * var_2;

  while(!var_3) {
    while(common_scripts\utility::flag("drill_drilling")) {
      wait 0.25;
    }

    foreach(var_6 in level.players) {
      if(distancesquared(var_6.origin, var_1) < var_4) {
        var_3 = 1;
      }
    }

    wait 0.1;
  }

  level notify(var_0);
}