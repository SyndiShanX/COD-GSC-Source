/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\odin_satellite.gsc
*****************************************************/

satellite_start() {
  maps\odin_util::move_player_to_start_point("start_odin_satellite_new");
  level.player thread maps\odin::give_weapons();
  wait 0.1;
  maps\odin_util::actor_teleport(level.ally, "sat_finale_ally_tp_node");
  thread maps\odin_spin::spin_sat_and_earth_mover(1);
  thread maps\odin_escape::manage_earth("delete");
  common_scripts\utility::flag_set("outline_rcs_lines");
  common_scripts\utility::flag_set("jumpTo_dialogue_skip");
  common_scripts\utility::flag_set("trigger_spacejump");
  common_scripts\utility::flag_set("disable_kyra_leader");
  common_scripts\utility::flag_set("landed_on_satellite");
  wait 5;
  level.ally setgoalpos(level.ally.origin);
}

section_precache() {
  precachemodel("odin_sat_section_04_a");
  precachemodel("odin_sat_section_04_b");
  precachemodel("odin_sat_section_04_c");
  precachemodel("odin_sat_section_04_d");
  precachemodel("us_space_a_body_cracked");
  precachemodel("odin_thruster_pipes_damaged");
  precachestring(&"ODIN_SATELLITE_TIMEOUT");
  precacherumble("light_1s");
  precacherumble("light_3s");
  level thread maps\odin_sat_section_02_solar_panels_destruction::vfxinit();
}

section_flag_init() {
  common_scripts\utility::flag_init("satellite_setup_complete");
  common_scripts\utility::flag_init("jumpTo_dialogue_skip");
  common_scripts\utility::flag_init("stop_wall_pushing");
  common_scripts\utility::flag_init("satellite_clear");
  common_scripts\utility::flag_init("outline_rcs_lines");
  common_scripts\utility::flag_init("satellite_end_anim_started");
  common_scripts\utility::flag_init("first_finale_stage_done");
  common_scripts\utility::flag_init("clear_to_fire_first_rog");
  common_scripts\utility::flag_init("ROG_FIRING");
  common_scripts\utility::flag_init("animated_sequence_complete");
  common_scripts\utility::flag_init("triggered_finale");
  common_scripts\utility::flag_init("player_has_fired");
  common_scripts\utility::flag_init("end_ally_loop_anims");
  common_scripts\utility::flag_init("hide_ally_finale_gun_prop");
  common_scripts\utility::flag_init("show_ally_finale_gun_prop");
  common_scripts\utility::flag_init("ally_at_sat");
  common_scripts\utility::flag_init("reset_ground_to_zip");
  common_scripts\utility::flag_init("ref_ent_for_explosion");
  common_scripts\utility::flag_init("stop_tweaking_player");
  common_scripts\utility::flag_init("damage_line_3");
  common_scripts\utility::flag_init("new_pod_opens");
}

section_hint_string_init() {
  maps\_utility::add_hint_string("ODIN_RCS_PROMPT", &"ODIN_RCS_PROMPT", ::odin_rcs_prompt);
  maps\_utility::add_hint_string("SATELLITE_TIMEOUT", &"ODIN_SATELLITE_TIMEOUT");
}

odin_rcs_prompt() {
  if(level.player usebuttonpressed())
    return 1;
  else
    return 0;
}

satellite_main() {
  common_scripts\utility::flag_set("trigger_spacejump");
  common_scripts\utility::flag_set("stop_wall_pushing");
  thread maps\_utility::autosave_by_name("satellite_begin");
  thread satellite_dialogue();
  thread ending_setup();
  thread thor_pod_opens();
  common_scripts\utility::flag_set("animated_sequence_complete");
  satellite_setup();
  common_scripts\utility::flag_wait("satellite_end_anim_started");
  level thread maps\odin_fx::fx_burnup();
  maps\_utility::delaythread(25, ::fade_out_show_title);
  wait 31.97;
  common_scripts\utility::flag_set("satellite_clear");

  if(!isDefined(level.prologue) || isDefined(level.prologue) && level.prologue == 0) {
    common_scripts\utility::flag_set("start_transition_to_youngblood");
    maps\_hud_util::fade_out(2.0, "white");
    maps\_utility::nextmission();
  }
}

fade_out_show_title() {
  if(!isDefined(level.prologue) || isDefined(level.prologue) && level.prologue == 0) {
    return;
  }
  thread maps\_hud_util::fade_out(7.0, "white");
  setblur(5, 6);
  var_0 = maps\_hud_util::get_optional_overlay("white");
  var_0.sort = 1;
  var_0.foreground = 0;
  wait 7.5;
  var_1 = getaiarray();
  common_scripts\utility::array_call(var_1, ::delete);
  var_2 = getEntArray("script_model", "classname");

  foreach(var_4 in var_2) {
    if(issubstr(var_4.model, "body_fed_space"))
      var_4 delete();
  }

  var_6 = getcorpsearray();

  foreach(var_8 in var_6)
  var_8 delete();

  level.player thread maps\_utility::play_sound_on_entity("logo_whoosh_lr");
  wait 0.25;
  setblur(0, 0.05);
  common_scripts\utility::flag_set("start_transition_to_youngblood");
}

satellite_setup() {
  thread maps\_space_player::player_location_check("exterior");
}

satellite_dialogue() {
  wait 1;

  if(!common_scripts\utility::flag("jumpTo_dialogue_skip")) {
    maps\_utility::smart_radio_dialogue("odin_kyr_atlasmainhowmany");
    maps\_utility::smart_radio_dialogue("odin_atl_23degreesportor");
    maps\_utility::smart_radio_dialogue("odin_kyr_23degreeswelldumpthat");
  }

  common_scripts\utility::flag_wait("outline_rcs_lines");
  level.ally maps\_space_ai::smart_radio_dialogue_facial("odin_kyr_hurryandhelpme", "odin_kyr_hurryandhelpme");
  common_scripts\utility::flag_wait("triggered_finale");
  common_scripts\utility::flag_clear("hold_satellite_back_thrusters");
  wait 4;
  maps\_utility::smart_radio_dialogue("odin_kyr_coversoffhouston");
  maps\_utility::smart_radio_dialogue("odin_shq_ignitethosercsfuel");

  if(!common_scripts\utility::flag("player_has_fired"))
    level.ally maps\_space_ai::smart_radio_dialogue_facial("odin_kyr_youheardhimbud", "odin_kyr_youheardhimbud");

  common_scripts\utility::flag_wait("first_finale_stage_done");
  maps\_utility::smart_radio_dialogue("odin_kyr_shit");
  common_scripts\utility::flag_wait("satellite_end_anim_started");
  wait 0.4;
  maps\_utility::smart_radio_dialogue("odin_kyr_ughh");
  maps\_utility::smart_radio_dialogue("odin_shq_1523");
  maps\_utility::smart_radio_dialogue("odin_ho2_23degrees");
  wait 0.3;
  maps\_utility::smart_radio_dialogue("odin_shq_30degreesofaxis");
  wait 0.5;
  wait 0.5;
  maps\_utility::smart_radio_dialogue("odin_shq_specialistmosleykyra");
}

ally_movement_logic() {
  level.ally maps\_utility::set_goal_radius(8);
  var_0 = [];

  for(var_1 = 0; var_1 < 5; var_1++)
    var_0[var_1] = getnode("ally_sat_trail_" + var_1, "targetname");

  level.ally setgoalnode(var_0[0]);
  level.ally waittill("goal");
  level.ally setgoalnode(var_0[1]);
  common_scripts\utility::flag_wait("player_trail_0");
  level.ally setgoalnode(var_0[4]);
  level.ally waittill("goal");
}

player_movement_check() {}

tube_rip_sequence() {
  common_scripts\utility::flag_wait("animated_sequence_complete");
  level.player unlink();
  level.player enableweapons();
  thread push_player_back_from_thor();
}

push_player_back_from_thor() {
  var_0 = getent("player_tube_rip_node", "targetname");
  var_1 = 0;
  var_2 = getnode("ally_final_node", "targetname");
  level.ally maps\_utility::set_goal_node(var_2);

  while(var_1 == 0) {
    common_scripts\utility::flag_set("clear_to_tweak_player");
    var_3 = distance(level.player.origin, var_0.origin);

    if(var_3 >= 0 && var_3 <= 256)
      setsaveddvar("player_swimWaterCurrent", (6000, 0, 6000));

    if(var_3 >= 257 && var_3 <= 320)
      setsaveddvar("player_swimWaterCurrent", (5000, 0, 5000));

    if(var_3 >= 321 && var_3 <= 384)
      setsaveddvar("player_swimWaterCurrent", (4000, 0, 4000));

    if(var_3 >= 385 && var_3 <= 512)
      setsaveddvar("player_swimWaterCurrent", (3000, 0, 3000));

    if(var_3 >= 513 && var_3 <= 640)
      setsaveddvar("player_swimWaterCurrent", (1500, 0, 2000));

    if(var_3 >= 641) {
      setsaveddvar("player_swimWaterCurrent", (0, 0, 1000));
      wait 1;
      setsaveddvar("player_swimWaterCurrent", (0, 0, 0));
      common_scripts\utility::flag_clear("clear_to_tweak_player");
      var_1 = 1;
    }

    wait 0.1;
  }
}

thor_finale_movement(var_0) {
  var_1 = maps\odin_util::satellite_get_script_mover();
  var_1 unlink();
  var_2 = getent("sat_barrel_target", "script_noteworthy");
  var_2 unlink();
  var_3 = getEntArray("spacejump_sat", "targetname");
  var_4 = 700 - var_0 / 5;

  if(var_4 < 20)
    var_4 = 20;

  var_1 moveto(var_2.origin, var_4, 0, 0);
  var_1 rotateto((0, 30, 0), var_4 * 0.1, 0, 0);
  var_5 = 0 - var_0 * 2;
  common_scripts\utility::flag_set("clear_to_tweak_player");

  if(var_5 < -5000)
    var_5 = -5000;

  setsaveddvar("player_swimWaterCurrent", (var_5, 0, var_5));
}

sat_location_check(var_0) {
  level endon("start_transition_to_youngblood");
  var_1 = getent("sat_barrel_bottom", "script_noteworthy");
  var_2 = var_1.origin[2] - 3500;
  var_3 = var_1.origin[2] - 500;
  var_4 = var_1.origin[2] - 2000;
  var_5 = getEntArray("spacejump_sat", "targetname");
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;

  while(var_6 == 0) {
    if(var_3 > var_1.origin[2] && var_7 == 0) {
      var_9 = getEntArray("first_to_explode", "script_noteworthy");
      thread sat_exploder(var_9, 0.4);
      var_7 = 1;
      earthquake(0.05, 200, level.player.origin, 2000);
    }

    if(var_4 > var_1.origin[2] && var_8 == 0) {
      common_scripts\utility::flag_set("damage_line_3");
      var_8 = 1;
      earthquake(0.15, 200, level.player.origin, 2000);
      common_scripts\utility::flag_set("satellite_clear");
    }

    if(var_2 > var_1.origin[2]) {
      thread sat_exploder(var_5, 0);
      earthquake(0.25, 200, level.player.origin, 2000);
      var_6 = 1;
    }

    wait 0.25;
  }
}

sat_exploder(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_parameters) && var_3.script_parameters == "do_not_explode") {
      continue;
    }
    if(var_3.classname == "script_model" || var_3.classname == "script_brushmodel" && var_3.classname != "script_origin")
      var_3 unlink();
  }

  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_parameters) && var_3.script_parameters == "do_not_explode") {
      var_3 thread satellitepieceburnup(var_3);
      continue;
    }

    if(var_3.classname == "script_model" || var_3.classname == "script_brushmodel" && var_3.classname != "script_origin") {
      wait(randomfloatrange(0.1, 0.4));
      thread satellitepieceburnup(var_3);
      var_3 unlink();
      var_6 = randomfloatrange(-1000, 3000);
      var_7 = randomfloatrange(-3000, 3000);
      var_8 = randomfloatrange(2000, 10000);
      var_9 = var_3.origin[0] + var_6;
      var_10 = var_3.origin[1] + var_7;
      var_11 = var_3.origin[2] + var_8;
      var_12 = randomfloatrange(20, 40);
      var_13 = randomfloatrange(2, 4);
      var_14 = randomfloatrange(-1080, 1080);
      var_15 = randomintrange(1, 3);

      switch (var_15) {
        case 1:
          var_3 rotateroll(var_14, var_12, var_12 * 0.25, var_12 * 0.25);
          break;
        case 2:
          var_3 rotatepitch(var_14, var_12, var_12 * 0.25, var_12 * 0.25);
          break;
        case 3:
          var_3 rotateyaw(var_14, var_12, var_12 * 0.25, var_12 * 0.25);
          break;
        default:
          var_3 rotateroll(var_14, var_12, var_12 * 0.25, var_12 * 0.25);
          break;
      }

      var_3 moveto((var_9, var_10, var_11), var_12, 0, var_12 * 0.25);
      wait(var_1);
    }
  }
}

satellitepieceburnup(var_0) {
  if(var_0.classname != "script_brushmodel" && var_0.model != "iss_sail_center" && var_0.model != "fah_sidewalk_tubes_01" && var_0.model != "clk_fusebox_01") {
    thread maps\odin_audio::sfx_distant_explo(var_0);
    wait(randomfloatrange(1, 10));

    switch (randomintrange(0, 2)) {
      case 0:
        playFXOnTag(level._effect["spc_explosion_240"], var_0, "tag_origin");
        break;
      case 1:
        playFXOnTag(level._effect["spc_explosion_1200"], var_0, "tag_origin");
        break;
    }
  }
}

rod_firing_sfx() {
  var_0 = getent("origin_satellite_waypoint", "targetname");
  thread maps\odin_audio::sfx_odin_rog_close(var_0);
  thread maps\odin_audio::sfx_distant_explo(var_0);
  wait 0.6;
  thread maps\odin_audio::sfx_distant_explo(var_0);
  wait 0.5;
  thread maps\odin_audio::sfx_distant_explo(var_0);
  wait 0.4;
  thread maps\odin_audio::sfx_distant_explo(var_0);
  wait 0.3;
  thread maps\odin_audio::sfx_distant_explo(var_0);
  wait 0.2;
  thread maps\odin_audio::sfx_distant_explo(var_0);
  wait 0.1;
  thread maps\odin_audio::sfx_distant_explo(var_0);
  wait 0.3;
  thread maps\odin_audio::sfx_distant_explo(var_0);
  wait 0.3;
  thread maps\odin_audio::sfx_distant_explo(var_0);
  wait 0.3;
  thread maps\odin_audio::sfx_distant_explo(var_0);
  wait 0.3;
  thread maps\odin_audio::sfx_distant_explo(var_0);
  wait 0.3;
  thread maps\odin_audio::sfx_distant_explo(var_0);
}

thor_pod_opens() {
  level endon("start_transition_to_youngblood");
  var_0 = getEntArray("pod_that_opens_0", "script_noteworthy");
  var_1 = getEntArray("pod_that_opens_1", "script_noteworthy");
  var_2 = getEntArray("pod_that_opens_2", "script_noteworthy");
  var_3 = getent("pod_that_opens_origin_0", "script_noteworthy");
  var_4 = getent("pod_that_opens_origin_1", "script_noteworthy");
  var_5 = getent("pod_that_opens_origin_2", "script_noteworthy");
  var_6 = getent("pod_cover_target_0", "script_noteworthy");
  var_7 = getent("pod_cover_target_1", "script_noteworthy");
  var_8 = getent("pod_cover_target_2", "script_noteworthy");

  foreach(var_10 in var_0) {
    if(var_10.classname == "script_brushmodel")
      var_10 linkto(var_3);
  }

  foreach(var_10 in var_1) {
    if(var_10.classname == "script_brushmodel")
      var_10 linkto(var_4);
  }

  foreach(var_10 in var_2) {
    if(var_10.classname == "script_brushmodel")
      var_10 linkto(var_5);
  }

  common_scripts\utility::flag_wait("new_pod_opens");
  thread pod_two_spools_up();
  thread thor_pod_opens_fx();
  wait 3;
  var_3 moveto(var_6.origin, 15, 0, 10);
  var_4 moveto(var_7.origin, 15, 0, 10);
  var_5 moveto(var_8.origin, 15, 0, 10);
  var_5 rotatepitch(-30, 44, 0, 25);
  wait 6;
  var_3 moveto(var_6.origin, 40, 0, 25);
  var_4 moveto(var_7.origin, 40, 0, 25);
  var_5 moveto(var_7.origin, 40, 0, 25);
  var_3 rotateroll(-25, 44, 0, 25);
  var_4 rotateyaw(-30, 44, 0, 25);
}

thor_pod_opens_fx() {
  common_scripts\utility::exploder("pod_open_warning");
  wait 3.0;
  common_scripts\utility::exploder("pod_open");
  maps\_utility::stop_exploder("pod_open_warning");
}

pod_two_spools_up() {
  var_0 = [];
  var_1 = [];
  var_2 = 0;

  for(var_3 = 0; var_3 < 16; var_3++) {
    var_4 = getent("second_firing_rod_array_" + var_3, "script_noteworthy");
    var_0[var_3] = var_4;
  }

  while(!common_scripts\utility::flag("damage_line_3")) {
    foreach(var_6 in var_0) {
      var_1[var_2] = var_6.origin;
      var_2 = var_2 + 1;
    }

    var_2 = 0;

    foreach(var_6 in var_0) {
      if(var_2 != 15) {
        var_9 = var_2 + 1;
        var_6 moveto(var_1[var_9], 8, 0, 0);
        var_2 = var_9;
        continue;
      }

      var_9 = 0;
      var_6 moveto(var_1[var_9], 8, 0, 0);
      var_2 = 0;
    }

    wait 8;
  }
}

stop_player_backtracking(var_0) {
  if(level.start_point == "odin_satellite")
    wait 3;

  common_scripts\utility::flag_wait("landed_on_satellite");

  while(!common_scripts\utility::flag("triggered_finale")) {
    var_1 = distance2d(level.player.origin, var_0.origin);

    if(var_1 >= 384) {
      var_2 = maps\odin_util::factor_value_min_max(0, 10000, maps\odin_util::normalize_value(0, 1024, var_1 - 384));
      var_2 = var_2 * -1;
      setsaveddvar("player_swimWaterCurrent", (var_2, 0, 0));
    } else
      setsaveddvar("player_swimWaterCurrent", (0, 0, 0));

    wait 0.1;
  }
}

ending_setup() {
  common_scripts\utility::flag_set("stop_tweaking_player");
  thread ally_finale_movement_setup();
  common_scripts\utility::flag_wait("lgt_flag_spin_over");
  var_0 = getent("sat_top_collision", "script_noteworthy");
  var_1 = level.odin_animnode;
  var_2 = maps\_utility::spawn_anim_model("player_rig");
  level.sat_ent_del[level.sat_ent_del.size] = var_2;
  var_3 = level.animated_sat_part["odin_sat_cover_01"];
  thread stop_player_backtracking(var_3);
  var_4 = [];
  var_4["player_rig"] = var_2;
  var_4["odin_ally"] = level.ally;
  wait 0.05;
  level.animated_sat_part["odin_sat_cover_01"] linkto(var_1);
  level.animated_sat_part["odin_sat_section_01"] linkto(var_1);
  common_scripts\utility::flag_wait("kickoff_player_finale");
  thread maps\odin_audio::sfx_sat_approach_plr();
  level.player freezecontrols(1);
  var_5 = 0;
  var_2 hide();
  level.player disableweapons();
  var_1 maps\_anim::anim_first_frame_solo(var_2, "satellite_end_start");
  level.player playerlinktoblend(var_2, "tag_player", 1.5, 0.5, 0);
  wait 1.5;
  level.player takeallweapons();
  level.player enableweapons();
  level.player playerlinktodelta(var_2, "tag_player", 1, var_5, var_5, var_5, var_5, 1);
  var_2 show();
  level notify("player_is_animating_to_sat");
  thread maps\odin_audio::sfx_sat_approach_kyra();
  var_1 maps\_anim::anim_single_solo(var_2, "satellite_end_start");
  thread give_player_new_ref_ent_look(var_2, 25, 1);
  var_1 thread maps\_anim::anim_loop_solo(var_2, "satellite_end_start_loop", "stop_loops");
  var_4["odin_top_cover"] = level.animated_sat_part["odin_sat_cover_01"];
  common_scripts\utility::flag_set("outline_rcs_lines");
  thread maps\odin_audio::sfx_switch_ambzone_to_end();
  common_scripts\utility::flag_set("end_ally_loop_anims");
  wait 0.05;
  level.ally linkto(var_1);
  thread player_took_too_long_to_open(var_3);
  common_scripts\utility::flag_wait("ally_at_sat");
  var_3 setcursorhint("HINT_NOICON");
  var_3 sethintstring(&"ODIN_RCS_PROMPT");
  var_3 makeusable();
  var_3 waittill("trigger", var_6);
  level.player springcamdisabled(3);
  thread maps\odin_audio::sfx_rcs_open();
  var_1 notify("stop_loops");
  var_5 = 0;
  level.player lerpviewangleclamp(3, 0, 0, var_5, var_5, var_5, var_5);
  common_scripts\utility::flag_set("triggered_finale");
  thread finale_always_be_reloading();
  var_3 makeunusable();
  var_0 delete();
  setsaveddvar("hud_showstance", 0);
  setsaveddvar("ammoCounterHide", 1);
  common_scripts\utility::flag_set("reset_ground_to_zip");
  var_1 maps\_anim::anim_single(var_4, "satellite_end_cover_lift");
  level.player playersetgroundreferenceent(undefined);
  thread odin_finale(var_3, var_2);
}

give_player_new_ref_ent_look(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::spawn_tag_origin();
  level.player playersetgroundreferenceent(var_3);
  var_3 rotateto(var_0 gettagangles("tag_player"), var_2, 0, 0);
  wait(var_2);
  level.player freezecontrols(0);
  level.player playersetgroundreferenceent(var_3);
  var_3 linkto(var_0);
  level.player playerlinktodelta(var_0, "tag_player", 1, var_1, var_1, var_1, var_1, 1);
  wait 0.1;
  level.player springcamenabled(1.0, 3.2, 1.6);
  common_scripts\utility::flag_wait("reset_ground_to_zip");
  wait 3;
  var_3 unlink();
  var_3 rotateto((0, 0, 0), 1, 0, 0);
  common_scripts\utility::flag_wait("ref_ent_for_explosion");
  var_3.angles = level.player getplayerangles();
  level.player playersetgroundreferenceent(var_3);
  var_3 rotateto(var_0 gettagangles("tag_player"), var_2, 0, 0);
  wait(var_2);
  var_3 linkto(var_0);
  common_scripts\utility::flag_wait("mus_atmosphere");
  var_3 unlink();

  while(!common_scripts\utility::flag("start_transition_to_youngblood")) {
    var_3.angles = var_0 gettagangles("tag_player");
    wait 0.05;
  }

  level.player playersetgroundreferenceent(undefined);
}

finale_always_be_reloading() {
  while(!common_scripts\utility::flag("satellite_end_anim_started")) {
    level.player setweaponammostock(level.player.weapon_exterior, 0);
    level.player setweaponammoclip(level.player.weapon_exterior, 32);
    wait 0.5;
  }
}

ally_finale_movement_setup() {
  thread ally_gun();
  level.ally maps\_utility::set_goal_radius(1);
  common_scripts\utility::flag_wait("disable_kyra_leader");
  level.ally.moveplaybackrate = 1;
  level.ally maps\_utility::disable_ai_color();
  level.ally setgoalpos((-9912, -3792, 65746));
  ally_first_frame_check();
  level.odin_animnode maps\_anim::anim_single_solo(level.ally, "satellite_end_start");
  common_scripts\utility::flag_set("ally_at_sat");
  level.odin_animnode maps\_anim::anim_loop_solo(level.ally, "satellite_end_start_loop", "stop_loops");
}

ally_first_frame_check() {
  level endon("player_is_animating_to_sat");
  level.ally waittill("goal");
  level.ally.moveplaybackrate = 1;
  level.odin_animnode maps\_anim::anim_reach_solo(level.ally, "satellite_end_start");
}

ally_gun() {
  common_scripts\utility::flag_wait("show_ally_finale_gun_prop");
  var_0 = level.odin_animnode;
  var_1 = maps\_utility::spawn_anim_model("finale_gun");
  level.sat_ent_del[level.sat_ent_del.size] = var_1;
  var_0 maps\_anim::anim_first_frame_solo(var_1, "satellite_end_start");
  var_0 maps\_anim::anim_single_solo(var_1, "satellite_end_start");
  var_0 thread maps\_anim::anim_loop_solo(var_1, "satellite_end_start_gun_loop", "stop_gun");
  common_scripts\utility::flag_wait("hide_ally_finale_gun_prop");
  var_1 hide();
  var_0 notify("stop_gun");
  wait 0.05;
  var_1 delete();
}

ally_gun_hide(var_0) {
  common_scripts\utility::flag_set("hide_ally_finale_gun_prop");
  level.ally maps\_utility::gun_recall();
}

ally_gun_show(var_0) {
  common_scripts\utility::flag_set("show_ally_finale_gun_prop");
  level.ally maps\_utility::gun_remove();
}

ally_finale_logic(var_0) {
  var_1 = getent("ally_shooting_target", "script_noteworthy");
  wait 2;

  while(!common_scripts\utility::flag("first_finale_stage_done")) {
    var_2 = randomfloatrange(0.1, 0.4);
    level.ally shoot(1, var_1.origin, 1);
    wait 0.05;
    level.ally shoot(1, var_1.origin, 1);
    wait 0.05;
    level.ally shoot(1, var_1.origin, 1);
    wait(var_2);
  }
}

odin_finale(var_0, var_1) {
  thread solar_panel_handling();
  level.ally maps\_utility::stop_magic_bullet_shield();
  var_2 = level.odin_animnode;
  var_2 notify("stop_loop");
  var_3 = level.odin_animnode;
  var_4 = maps\_utility::spawn_anim_model("finale_gun");
  level.sat_ent_del[level.sat_ent_del.size] = var_4;
  var_5 = 25;
  var_6 = getent("sat_thruster_pipe_target", "script_noteworthy");
  level.ally maps\_utility::disable_ai_color();
  level.ally unlink();
  var_7 = [];
  var_7["player_rig"] = var_1;
  var_7["odin_ally"] = level.ally;
  var_7["odin_top_cover"] = level.animated_sat_part["odin_sat_cover_01"];
  var_7["odin_top"] = level.animated_sat_part["odin_sat_section_01"];
  var_8 = [];
  var_8["finale_gun"] = var_4;
  thread damage_fx_handling();
  thread ally_finale_logic(var_0);
  level.player giveweapon(level.player.weapon_exterior);
  level.player switchtoweaponimmediate(level.player.weapon_exterior);
  level.player playerlinktodelta(var_1, "tag_player", 1, var_5, var_5, 16, 8, 1);
  var_2 thread maps\_anim::anim_loop(var_7, "satellite_end_shoot_01", "stop_loop");
  waittill_damage_done(1800, 15);
  var_2 notify("stop_loop");
  var_7["wires"] = maps\_utility::spawn_anim_model("wires");
  level.sat_ent_del[level.sat_ent_del.size] = var_7["wires"];
  var_7["wires2"] = maps\_utility::spawn_anim_model("wires2");
  level.sat_ent_del[level.sat_ent_del.size] = var_7["wire2"];
  var_7["wires3"] = maps\_utility::spawn_anim_model("wires3");
  level.sat_ent_del[level.sat_ent_del.size] = var_7["wires3"];
  var_7["wires4"] = maps\_utility::spawn_anim_model("wires4");
  level.sat_ent_del[level.sat_ent_del.size] = var_7["wires4"];
  var_7["wires5"] = maps\_utility::spawn_anim_model("wires5");
  level.sat_ent_del[level.sat_ent_del.size] = var_7["wires5"];
  level.ally notify("styptic");
  var_6 setModel("odin_thruster_pipes_damaged");
  thread explosion_1();
  var_4 hide();
  level.player takeallweapons();
  level.ally maps\_utility::gun_remove();
  wait 0.05;
  common_scripts\utility::flag_set("first_finale_stage_done");
  thread first_explosion_fx();
  thread maps\odin_audio::sfx_sat_first_explosion();
  common_scripts\utility::flag_set("ref_ent_for_explosion");
  var_2 maps\_anim::anim_single(var_7, "satellite_end_explosion_01");
  level.player giveweapon(level.player.weapon_exterior);
  level.player switchtoweaponimmediate(level.player.weapon_exterior);
  level.player playerlinktodelta(var_1, "tag_player", 1, 20, -15, 40, 40, 1);
  var_2 thread maps\_anim::anim_loop(var_7, "satellite_end_shoot_02", "stop_loop");
  waittill_damage_done(900, 5);
  thread maps\odin_audio::sfx_sat_second_explosion();
  var_2 notify("stop_loop");
  level.ally setModel("us_space_a_body_cracked");
  thread fx_for_kyra_helmet_cracking();
  thread explosion_1();
  common_scripts\utility::flag_set("mus_atmosphere");
  maps\_utility::autosave_by_name_silent("Odin_completed");
  var_9 = getEntArray("sat_ROGS", "script_noteworthy");
  var_9[0] hide();
  var_10 = getEntArray("spacejump_sat", "targetname");

  foreach(var_12 in var_9)
  var_12 linkto(level.animated_sat_part["odin_sat_section_04_base"]);

  foreach(var_15 in var_10)
  var_15 linkto(level.animated_sat_part["odin_sat_section_04_base"]);

  thread handle_finale_shakes_and_rumbles(var_1);
  var_4 show();
  var_0 hide();
  level.player takeallweapons();
  var_2 thread maps\_anim::anim_single(var_8, "satellite_end_explosion_01_gun");
  var_2 thread maps\_anim::anim_single(var_7, "satellite_end_explosion_02");
  var_17 = maps\_utility::spawn_anim_model("sat_body");
  level.sat_ent_del[level.sat_ent_del.size] = var_17;
  var_17 hide();
  var_5 = 30;
  level.player playerlinktodelta(var_1, "tag_player", 1, var_5, 0, var_5, 20, 1);
  level.player springcamenabled(1.0, 3.2, 1.6);
  var_2 maps\_anim::anim_first_frame_solo(var_17, "satellite_end_explosion_02_Sat");
  wait 0.05;
  level.odin_animnode notify("stop_sat_loops");
  level.animated_sat_part["odin_sat_section_03_rot"] = getent("odin_sat_section_03_rot", "script_noteworthy");
  var_2 maps\_anim::anim_first_frame(level.animated_sat_part, "satellite_end_explosion_02");
  wait 0.05;
  var_2 thread maps\_anim::anim_single(level.animated_sat_part, "satellite_end_explosion_02");
  var_2 thread maps\_anim::anim_single_solo(var_17, "satellite_end_explosion_02_Sat");
  thread finale_fx_handling(var_17);
  common_scripts\utility::flag_set("satellite_end_anim_started");
  level notify("finale_completed");
  var_18 = maps\odin_util::earth_get_script_mover();
  var_19 = getent("space_mover", "targetname");
  var_19 linkto(var_18);
  var_18 unlink();
  var_18 movex(1200, 15, 5, 0);
  wait 10;
  var_18 movex(3500, 15, 5, 0);
}

fx_for_kyra_helmet_cracking() {
  playFXOnTag(level._effect["vfx_kyra_impact_head_space_blood"], level.ally, "tag_eye");
  wait 0.2;
  playFXOnTag(level._effect["vfx_kyra_impact_head_space_blood"], level.ally, "tag_eye");
  wait 0.2;
  playFXOnTag(level._effect["vfx_kyra_impact_head_space_blood"], level.ally, "tag_eye");
  wait 0.2;
  playFXOnTag(level._effect["vfx_kyra_impact_head_space_blood"], level.ally, "tag_eye");
  wait 0.2;
  playFXOnTag(level._effect["vfx_kyra_impact_head_space_blood"], level.ally, "tag_eye");
  wait 0.8;
  playFXOnTag(level._effect["vfx_kyra_impact_head_space_blood"], level.ally, "tag_eye");
  wait 0.5;

  for(var_0 = 0; var_0 < 30; var_0++) {
    playFXOnTag(level._effect["vfx_kyra_impact_head_space"], level.ally, "tag_eye");
    wait(randomfloatrange(0.05, 0.13));
  }
}

solar_panel_handling() {
  level thread maps\odin_sat_section_02_solar_panels_destruction::spawnsolarpanelsinit(1);
  common_scripts\utility::flag_wait("mus_atmosphere");
  var_0 = getEntArray("dummy_starter_solar", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 hide();

  foreach(var_5 in level.frames) {
    foreach(var_2 in var_5.panel_array)
    var_2 show();
  }

  wait 2;
  level thread maps\odin_sat_section_02_solar_panels_destruction::destructisolarpanelsinit("odin_sat_section_02_solar_wing_04", 4, 0);
  wait 1;
  level thread maps\odin_sat_section_02_solar_panels_destruction::destructisolarpanelsinit("odin_sat_section_02_solar_wing_02", 4, 0);
  wait 0.5;
  level thread maps\odin_sat_section_02_solar_panels_destruction::destructisolarpanelsinit("odin_sat_section_02_solar_wing_01", 4, 0);
  wait 1.5;
  level thread maps\odin_sat_section_02_solar_panels_destruction::destructisolarpanelsinit("odin_sat_section_02_solar_wing_03", 26, 1);
}

explosion_1() {
  level.player playrumbleonentity("heavy_1s");
}

#using_animtree("player");

handle_finale_shakes_and_rumbles(var_0) {
  level endon("start_transition_to_youngblood");
  var_1 = 0;

  for(;;) {
    var_2 = var_0 getanimtime( % odin_satellite_end_explosion_02_player);

    if(var_2 >= 0 && var_2 < 0.25) {
      var_3 = randomfloatrange(1, 5);

      if(var_3 <= 2) {
        level.player playrumbleonentity("light_1s");
        wait(randomfloatrange(0.5, 0.9));
      }

      earthquake(0.025, 1, level.player.origin, 2000);
    }

    if(var_2 >= 0.25 && var_2 < 0.5) {
      var_3 = randomfloatrange(1, 5);

      if(var_3 <= 2) {
        level.player playrumbleonentity("light_1s");
        wait(randomfloatrange(0.5, 0.9));
      }

      earthquake(0.05, 1, level.player.origin, 2000);
    }

    if(var_2 >= 0.5 && var_2 < 0.75) {
      var_3 = randomfloatrange(1, 5);

      if(var_1 <= 10)
        var_3 = 4;

      if(var_3 == 3) {
        level.player playrumbleonentity("heavy_1s");
        wait 0.75;
      } else if(var_3 == 1)
        wait 0.55;
      else
        level.player playrumbleonentity("light_1s");

      earthquake(0.1, 1, level.player.origin, 2000);
      var_1 = var_1 + 1;
    }

    if(var_2 >= 0.75 && var_2 < 1) {
      var_3 = randomfloatrange(1, 5);

      if(var_3 == 3 || var_3 == 4) {
        level.player playrumbleonentity("heavy_1s");
        wait 0.75;
      } else if(var_3 == 1)
        wait 0.55;
      else
        level.player playrumbleonentity("light_1s");

      earthquake(0.15, 1, level.player.origin, 2000);
    }

    if(var_2 == 1) {
      break;
    }

    wait 0.25;
  }
}

first_explosion_fx() {
  maps\odin_fx::fx_sat_rcs_damage_kill();
  var_0 = getent("ally_shooting_target", "script_noteworthy");
  var_1 = var_0.origin;
  var_2 = anglesToForward(var_0.angles);
  var_3 = anglestoup(var_0.angles);
  playFX(level._effect["spc_explosion_240"], var_1);
  wait 1;
  var_4 = spawnfx(level._effect["odin_sat_rcs_fuel_fire"], var_1, var_2, var_3);
  triggerfx(var_4);
  common_scripts\utility::flag_wait("satellite_end_anim_started");
  var_4 delete();

  for(var_5 = 1; var_5 < 4; var_5++) {
    playFX(level._effect["spc_explosion_1200"], var_1 + common_scripts\utility::randomvector(150));
    wait(randomfloatrange(0.5, 1.2));
  }
}

finale_nags() {
  var_0 = gettime();
  var_1 = var_0 - 900;
  var_2 = 0;
  var_3 = randomfloatrange(5000, 10000);
  var_4 = [];
  var_4[0] = "Just shoot the RCS Module, Bud!";
  var_4[1] = "Ensign!Shoot that module or there wont be anything left!";
  var_4[2] = "Shoot the RCS!Hurry!";
  var_4[3] = "It's going to fire that second payload if we don't destabilize it first!!";
  var_4[4] = "Keep shooting, it's almost destabilized!";
  var_4[5] = "We're too late... The second Payload is firing.";

  while(!common_scripts\utility::flag("first_finale_stage_done")) {
    var_1 = gettime() - var_3;

    if(var_1 >= var_0) {
      var_5 = randomintrange(0, 3);

      if(var_2 == var_5)
        var_5 = randomintrange(0, 3);
      else {
        var_2 = var_5;
        iprintlnbold("Kyra: " + var_4[var_5]);
        var_0 = gettime();
        var_3 = randomfloatrange(5000, 10000);
        var_1 = var_0 - var_3;
      }
    }

    wait 0.01;
  }

  wait 3;
  iprintlnbold("Kyra: " + var_4[4]);
  wait 3;
  var_3 = randomfloatrange(5000, 10000);

  while(!common_scripts\utility::flag("satellite_end_anim_started")) {
    var_1 = gettime() - var_3;

    if(var_1 >= var_0) {
      var_5 = randomintrange(0, 3);

      if(var_2 == var_5)
        var_5 = randomintrange(0, 3);
      else {
        var_2 = var_5;
        iprintlnbold("Kyra: " + var_4[var_5]);
        var_0 = gettime();
        var_3 = randomfloatrange(5000, 10000);
        var_1 = var_0 - var_3;
      }
    }

    wait 0.01;
  }
}

waittill_damage_done(var_0, var_1) {
  level endon("next_finale_stage");
  level endon("thrusters_fully_damaged");
  level endon("start_transition_to_youngblood");
  thread finale_timer(var_1);
  var_2 = 0;
  var_3 = getent("sat_thruster_pipe_target", "script_noteworthy");
  var_4 = getent("ally_shooting_target", "script_noteworthy");
  var_3 setCanDamage(1);

  while(!common_scripts\utility::flag("satellite_end_anim_started")) {
    var_3 waittill("damage", var_5, var_6, var_7, var_8, var_9);

    if(var_6 == level.player) {
      common_scripts\utility::flag_set("player_has_fired");
      var_2 = var_2 + var_5;

      if(var_2 >= var_0) {
        level notify("next_finale_stage");
        common_scripts\utility::flag_clear("player_has_fired");
        return;
      }
    }
  }
}

finale_timer(var_0) {
  level endon("next_finale_stage");
  level endon("start_transition_to_youngblood");
  var_1 = gettime();
  var_2 = gettime() - var_0 * 1000;

  for(;;) {
    var_2 = gettime() - var_0 * 1000;

    if(var_2 >= var_1) {
      break;
    }

    wait 0.05;
  }

  level notify("next_finale_stage");
}

damage_fx_handling() {
  level endon("start_transition_to_youngblood");
  level thread maps\odin_fx::fx_sat_thrusters_damage();
  var_0 = getent("sat_thruster_pipe_target", "script_noteworthy");
  var_1 = getent("ally_shooting_target", "script_noteworthy");
  var_2 = common_scripts\utility::spawn_tag_origin();
  level.sat_ent_del[level.sat_ent_del.size] = var_2;
  var_2.origin = var_1.origin;
  var_0 setCanDamage(1);
  level.fx_sat_rcs_damage = [];
  var_3 = 1;
  var_4 = 1;

  while(!common_scripts\utility::flag("satellite_end_anim_started")) {
    var_0 waittill("damage", var_5, var_6, var_7, var_8, var_9);

    if(!common_scripts\utility::flag("rcs_is_damaged"))
      common_scripts\utility::flag_set("rcs_is_damaged");

    if(var_4 == 7) {
      maps\odin_fx::fx_sat_rcs_damage(var_3);
      var_3 = var_3 + 1;
      var_4 = 1;
    } else
      var_4 = var_4 + 1;

    if(var_6 == level.player) {
      if(common_scripts\utility::flag("first_finale_stage_done")) {
        maps\odin_fx::fx_sat_rcs_damage_kill();
        thread stop_finale_flames(var_2);
        break;
      }
    }
  }
}

stop_finale_flames(var_0) {
  common_scripts\utility::flag_wait("satellite_end_anim_started");
  wait 3;
  stopFXOnTag(common_scripts\utility::getfx("spc_fire_puff_bigger_light"), var_0, "tag_origin");
}

finale_fx_handling(var_0) {
  level thread maps\odin_fx::fx_sat_explosion(var_0);
  var_1 = getEntArray("finale_fx_point", "script_noteworthy");
  var_2 = [];

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_4 = common_scripts\utility::spawn_tag_origin();
    level.sat_ent_del[level.sat_ent_del.size] = var_4;
    var_2[var_3] = var_4;
    var_4.origin = var_1[var_3].origin;
    var_4.angles = var_1[var_3].angles;
    var_4 unlink();
    var_4 linkto(var_0);
  }

  foreach(var_4 in var_1)
  var_4 delete();

  var_7 = 3;
  var_8 = [];
  var_8[0] = "spc_explosion_1200";
  var_8[1] = "spc_explosion_240";

  while(!common_scripts\utility::flag("satellite_clear")) {
    var_9 = randomintrange(0, var_2.size);
    var_10 = randomintrange(0, var_8.size);
    var_11 = randomfloatrange(0.1, var_7);
    playFXOnTag(common_scripts\utility::getfx(var_8[var_10]), var_2[var_9], "tag_origin");

    if(var_10 == 0) {}

    wait(var_11);

    if(var_7 >= 0.75)
      var_7 = var_7 - 0.5;
  }

  foreach(var_4 in var_2) {
    foreach(var_14 in var_8)
    stopFXOnTag(common_scripts\utility::getfx(var_14), var_4, "tag_origin");
  }
}

player_took_too_long_to_open(var_0) {
  var_1 = gettime();
  var_2 = gettime() - 9000;
  var_3 = 0;
  var_4 = 4000;
  var_5 = [];
  var_5[0] = "odin_kyr_comeonbud";
  var_5[1] = "odin_kyr_whatthehellare";
  var_5[2] = "odin_kyr_budineedyour";

  while(!common_scripts\utility::flag("triggered_finale")) {
    var_2 = gettime() - var_4;

    if(var_2 >= var_1) {
      if(var_3 > 2) {
        var_0 hudoutlinedisable();
        var_0 makeunusable();
        thread maps\_utility::smart_radio_dialogue("odin_shq_youretoolatebegin");
        wait 2.5;
        level notify("new_quote_string");
        setdvar("ui_deadquote", "@ODIN_SATELLITE_TIMEOUT");
        maps\_utility::missionfailedwrapper();
        return;
      }

      level.ally maps\_space_ai::smart_radio_dialogue_facial(var_5[var_3], var_5[var_3]);
      var_1 = gettime();
      var_4 = var_4 + 2200;
      var_2 = gettime() - var_4;
      var_3 = var_3 + 1;
    }

    wait 0.01;
  }
}

cover_lift_rumble_1(var_0) {
  level.player playrumbleonentity("light_1s");
}

cover_lift_rumble_2(var_0) {
  level.player playrumbleonentity("light_3s");
}

satellite_cleanup(var_0) {
  if(var_0 == 0) {
    common_scripts\utility::flag_wait("clear_for_sat_clean");

    if(isDefined(level.sat_ent_del)) {
      foreach(var_2 in level.sat_ent_del) {
        if(isDefined(var_2))
          var_2 delete();
      }
    }
  }
}