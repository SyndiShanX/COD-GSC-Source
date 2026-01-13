/********************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zmb\cp_zmb_environment_scriptable.gsc
********************************************************************/

front_gate(var_0) {
  playsoundatpos((632, 2357, 334), "entrance_sign_power_on_build");
  wait(3);
  turn_on_global_light();
  wait(2);
  zmb_main_entrance_gate();
  wait(3);
  playsoundatpos((579, 2387, 374), "pa_speaker_power_on");
  playsoundatpos((634, 664, 255), "pa_speaker_power_on");
  wait(1);
  enablepaspeaker("starting_area");
  enablepaspeaker("cosmic_way");
  scripts\cp\cp_vo::add_to_nag_vo("dj_powerswitch_restore_nag", "zmb_dj_vo", 60, 15, 2, 1);
  scripts\cp\cp_vo::add_to_nag_vo("dj_quest_ufo_partsrecovery_start", "zmb_dj_vo", 180, 50, 1, 1);
  level thread scripts\cp\maps\cp_zmb\cp_zmb_dj::dj_quest_dialogue_vo();
  level notify("jukebox_start");
  level thread main_power_turned_on(var_0);
  level thread signs_mainst();
  set_nonstick();
}

set_nonstick() {
  var_0 = getEntArray("coaster_ice_monster", "targetname");
  var_1 = getEntArray("octonian", "targetname");
  var_2 = scripts\engine\utility::array_combine(var_0, var_1);
  foreach(var_4 in var_2) {
    var_4 setnonstick(1);
    scripts\engine\utility::waitframe();
  }
}

turn_on_global_light() {
  var_0 = getEntArray("global_light", "targetname");
  foreach(var_2 in var_0) {
    var_2 setscriptablepartstate("root", "on");
  }
}

zmb_main_entrance_gate() {
  turn_on_main_gate();
}

turn_on_main_gate() {
  var_0 = getEntArray("main_gate", "targetname");
  foreach(var_2 in var_0) {
    var_2 setscriptablepartstate("main_gate", "gate_on");
  }

  for(var_4 = 1; var_4 <= 5; var_4++) {
    var_5 = getent("gate_light_0" + var_4, "targetname");
    var_5 setscriptablepartstate("main_gate_light", "turning_on");
  }
}

hidden_room() {}

moon() {}

moon_outside_begin() {
  turn_on_sign("sign_cosmiccinema");
  turn_on_sign("sign_roverrampage");
  turn_on_sign("sign_starmission");
  turn_on_sign("sign_escapevelocity");
  turn_on_sign("sign_lunarterrace");
  turn_on_scriptable("rocket_diorama");
}

moon_rocket_space() {}

moon_second() {
  playsoundatpos((3548, 938, 275), "journey_power_on_build");
  wait(5.5);
  playsoundatpos((3850, 438, 328), "pa_speaker_power_on");
  wait(2);
  enablepaspeaker("journey");
}

moon_bridge() {}

arcade() {
  turn_on_sign("astrocade_signs");
  getent("bfp_cabinet", "targetname") setModel("zmb_game_bowling_for_planets_on");
  wait(1);
  getent("demon_group", "targetname") setscriptablepartstate("group", "all_on");
  level thread power_on_arcade_machines("arcade_demon");
  wait(1);
  getent("barnstorming_group", "targetname") setscriptablepartstate("group", "all_on");
  level thread power_on_arcade_machines("arcade_barnstorming");
  wait(1);
  getent("starmaster_group", "targetname") setscriptablepartstate("group", "all_on");
  level thread power_on_arcade_machines("arcade_starmaster");
  wait(1);
  getent("group_cosmicarc", "targetname") setscriptablepartstate("group", "all_on");
  level thread power_on_arcade_machines("arcade_cosmic");
  wait(1);
  getent("group_pitfall", "targetname") setscriptablepartstate("group", "all_on");
  level thread power_on_arcade_machines("arcade_pitfall");
  wait(1);
  getent("group_riverraid", "targetname") setscriptablepartstate("group", "all_on");
  level thread power_on_arcade_machines("arcade_riverraid");
  wait(1);
  getent("spider_arcade_group", "targetname") setscriptablepartstate("group", "all_on");
  level thread power_on_arcade_machines("arcade_spider");
  wait(1);
  getent("robottank_group", "targetname") setscriptablepartstate("group", "all_on");
  level thread power_on_arcade_machines("arcade_robottank");
}

power_on_arcade_machines(var_0) {
  var_1 = scripts\engine\utility::getstructarray(var_0, "script_noteworthy");
  foreach(var_3 in var_1) {
    scripts\engine\utility::waitframe();
    var_3.powered_on = 1;
    if(isDefined(var_3.script_index)) {
      var_4 = getent(var_3.name, "targetname");
      var_5 = var_3.script_index;
      var_4 setscriptablepartstate("cab" + var_5, "idle");
    }
  }
}

arcade_back() {
  playsoundatpos((2873, -1083, 357), "astrocade_power_on_build");
  wait(5.5);
  playsoundatpos((2794, -1428, 318), "pa_speaker_power_on");
  wait(2);
  enablepaspeaker("astrocade");
}

europa_tunnel() {
  signs_triton();
}

room_europa() {}

europa_2() {}

roller_coast_back() {
  playsoundatpos((-830, -3394, 604), "triton_power_on_build");
  wait(5.5);
  playsoundatpos((-1103, -3168, 601), "pa_speaker_power_on");
  wait(2);
  enablepaspeaker("triton");
}

swamp_stage() {}

mars_3() {
  signs_kepler();
}

mars() {
  playsoundatpos((-2168, 206, 668), "kepler_power_on_build");
  wait(5.5);
  playsoundatpos((-2034, -340, 534), "pa_speaker_power_on");
  playsoundatpos((-950, 1510, 428), "pa_speaker_power_on");
  wait(2);
  enablepaspeaker("kepler");
}

init() {
  level thread power_on_monitor();
}

is_all_power_on() {
  foreach(var_1 in level.generators) {
    if(!scripts\engine\utility::istrue(var_1.powered_on)) {
      return 0;
    }
  }

  return 1;
}

all_power_vo(var_0) {
  if(isDefined(var_0)) {
    if(var_0.vo_prefix == "p1_") {
      level thread scripts\cp\cp_vo::try_to_play_vo("poweron_final_valleygirl_1", "zmb_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      return;
    }

    if(var_0.vo_prefix == "p2_") {
      level thread scripts\cp\cp_vo::try_to_play_vo("poweron_final_nerd_1", "zmb_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      return;
    }

    if(var_0.vo_prefix == "p3_") {
      level thread scripts\cp\cp_vo::try_to_play_vo("poweron_final_rapper_1", "zmb_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      return;
    }

    if(var_0.vo_prefix == "p4_") {
      level thread scripts\cp\cp_vo::try_to_play_vo("poweron_final_jock_1", "zmb_dialogue_vo", "highest", 666, 0, 0, 0, 100);
      return;
    }

    return;
  }
}

power_on_monitor() {
  level endon("game_ended");
  var_0 = getent("main_portal_sun", "targetname");
  var_0 setModel("zmb_center_portal_sun_off");
  for(;;) {
    level waittill("power_on_scriptable_and_light", var_1, var_2);
    var_3 = is_all_power_on();
    if(var_3) {
      level thread all_power_vo(var_2);
    }

    var_4 = strtok(var_1, ",");
    foreach(var_6 in var_4) {
      switch (var_6) {
        case "front_gate":
          level thread front_gate(var_2);
          break;

        case "hidden_room":
          level thread hidden_room();
          break;

        case "moon":
          level thread moon();
          break;

        case "moon_outside_begin":
          level thread moon_outside_begin();
          break;

        case "moon_rocket_space":
          level thread moon_rocket_space();
          break;

        case "moon_second":
          level thread moon_second();
          break;

        case "moon_bridge":
          level thread moon_bridge();
          break;

        case "arcade":
          level thread arcade();
          break;

        case "arcade_back":
          level thread arcade_back();
          break;

        case "europa_tunnel":
          level thread europa_tunnel();
          break;

        case "room_europa":
          level thread room_europa();
          break;

        case "europa_2":
          level thread europa_2();
          break;

        case "roller_coast_back":
          level thread roller_coast_back();
          break;

        case "swamp_stage":
          level thread swamp_stage();
          break;

        case "mars_3":
          level thread mars_3();
          break;

        case "mars":
          level thread mars();
          break;
      }
    }
  }
}

main_power_turned_on(var_0) {
  if(var_0.vo_prefix == "p1_") {
    level thread scripts\cp\cp_vo::try_to_play_vo("poweron_first_valleygirl_1", "zmb_dialogue_vo", "highest", 666, 0, 0, 0, 100);
  } else if(var_0.vo_prefix == "p2_") {
    level thread scripts\cp\cp_vo::try_to_play_vo("poweron_first_nerd_1", "zmb_dialogue_vo", "highest", 666, 0, 0, 0, 100);
  } else if(var_0.vo_prefix == "p3_") {
    level thread scripts\cp\cp_vo::try_to_play_vo("poweron_first_rapper_1", "zmb_dialogue_vo", "highest", 666, 0, 0, 0, 100);
  } else if(var_0.vo_prefix == "p4_") {
    level thread scripts\cp\cp_vo::try_to_play_vo("poweron_first_jock_1", "zmb_dialogue_vo", "highest", 666, 0, 0, 0, 100);
  }

  level.power_on = 1;
  level scripts\cp\cp_vo::add_to_nag_vo("dj_fateandfort_replenish_nag", "zmb_dj_vo", 180, 30, 20, 1);
  level scripts\cp\cp_vo::add_to_nag_vo("dj_ticketbooths_use_nag", "zmb_dj_vo", 180, 60, 20, 1);
  level scripts\cp\cp_vo::add_to_nag_vo("dj_pap_cosmicway_nag", "zmb_dj_vo", 180, 25, 20, 1);
  level scripts\cp\cp_vo::add_to_nag_vo("dj_polarpeaks_use_nag", "zmb_dj_vo", 180, 90, 20, 1);
}

turn_on_light(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_intensity_01)) {
      var_4 = var_3.script_intensity_01;
      var_3 setlightintensity(var_4);
    }
  }
}

signs_mainst() {
  var_0 = getent("main_portal_sun", "targetname");
  var_0.angles = (0, 0, 0);
  var_1 = getent("triton_skull_light", "targetname");
  var_2 = getent("triton_sign_light", "targetname");
  level thread rotate_center_portal_sun();
  wait(3);
  var_1 setscriptablepartstate("light", "on");
  var_2 setscriptablepartstate("light", "on");
  turn_on_scriptable("main_street_ball_lights");
  turn_on_scriptable("space_depot_main_sign");
  turn_on_scriptable("spacedepot_neon_upper");
  turn_on_scriptable("spacedepot_neon_lower");
  turn_on_scriptable("pitstop_main_sign");
  turn_on_scriptable("pitstop_neon_upper");
  turn_on_scriptable("pitstop_neon_lower");
  turn_on_scriptable("saturn_sundaes_main_sign");
  turn_on_scriptable("saturn_sundaes_neon_upper");
  turn_on_scriptable("crater_cakes_main_sign");
  turn_on_scriptable("crater_cakes_neon_upper");
  level thread scripts\cp\maps\cp_zmb\cp_zmb_coaster::turn_on_coaster_anims();
  var_3 = getent("main_street_monster", "targetname");
  var_3 setscriptablepartstate("main", "idle2");
}

rotate_center_portal_sun() {
  var_0 = getent("main_portal_sun", "targetname");
  var_0 setModel("zmb_center_portal_sun");
  for(;;) {
    var_0 rotateyaw(360, 10);
    wait(9.95);
  }
}

turn_on_sign(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  foreach(var_3 in var_1) {
    wait(randomfloatrange(0.15, 0.25));
    var_3 setscriptablepartstate("sign", "powered_on");
  }
}

turn_on_scriptable(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  foreach(var_3 in var_1) {
    wait(randomfloatrange(0.25, 0.5));
    var_3 setscriptablepartstate("neon_tube", "on");
  }
}

signs_triton() {
  turn_on_scriptable("triton_ceiling_neon");
}

signs_kepler() {
  turn_on_sign("moonlight_cafe_signs");
  turn_on_sign("sign_hyperslopes");
  turn_on_sign("sign_conelord");
  turn_on_sign("chromosphere_sign");
  turn_on_sign("shooting_gallery_sign");
  turn_on_sign("sign_spaceshipsplash");
  getent("chromosphere_mike", "targetname") setscriptablepartstate("main", "on");
  var_0 = getEntArray("octonian", "targetname");
  foreach(var_2 in var_0) {
    var_2 setscriptablepartstate("body", "on");
  }
}