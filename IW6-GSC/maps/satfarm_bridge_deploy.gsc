/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\satfarm_bridge_deploy.gsc
******************************************/

bridge_deploy_init() {
  level.start_point = "bridge_deploy";
}

bridge_deploy_main() {
  setdvar("debug_sat_view_pip", "1");
  maps\satfarm_code::kill_spawners_per_checkpoint("bridge_deploy");
  common_scripts\utility::flag_init("bridge_deploy_kill_gaz");
  common_scripts\utility::flag_init("bridge_deploy_pre_end");
  level.player notify("remove_tow");

  if(level.start_point == "bridge_deploy")
    var_0 = common_scripts\utility::getstruct("bridge_deploy_player_in", "targetname");
  else {
    level.player unlink();
    var_0 = level.player;
  }

  level.player setorigin(var_0.origin);
  level.player setplayerangles(var_0.angles);
  thread bridge_deploy_begin();
  common_scripts\utility::flag_wait("bridge_deploy_end");
}

bridge_deploy_begin() {
  level.player thread tower_to_bridge_deploy();
}

tower_to_bridge_deploy_bink() {
  common_scripts\utility::waitframe();
  thread maps\satfarm_audio::overlord_trans2();

  if(level.start_point == "bridge_deploy")
    maps\_hud_util::fade_out(1);

  self freezecontrols(1);
  self enableinvulnerability();
  self disableweapons();
  self disableoffhandweapons();
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowsprint(0);
  level.player allowjump(0);
  level.player.ignoreme = 1;
  setsaveddvar("compass", 0);
  common_scripts\utility::waitframe();
  setdvar("paris_transition_movie", "1");
  setsaveddvar("ui_nextMission", "1");
  changelevel("satfarm_b");
}

tower_to_bridge_deploy() {
  maps\_hud_util::fade_out(0.05);
  thread spawn_allies_deploy();
  thread bridge_deploy_enemy_tanks_setup();
  level.bdcheck = 1;
  visionsetnaked("satfarm_b", 0.0);
  wait 2;
  self freezecontrols(1);
  self enableinvulnerability();
  self disableweapons();
  self disableoffhandweapons();
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowsprint(0);
  level.player allowjump(0);
  level.player.ignoreme = 1;
  setsaveddvar("compass", 0);
  common_scripts\utility::waitframe();
  var_0 = 1.75;
  var_1 = 15000;
  var_2 = 17.6;
  thread maps\satfarm_code::radio_dialog_add_and_go("satfarm_hqr_ghosthassecuredthe");
  level.player thread maps\_utility::play_sound_on_entity("satfarm_cu3_heavyfightinginsectors");
  thread maps\satfarm_code::radio_dialog_add_and_go("satfarm_hqr_forwardelementsofbcompany");
  var_3 = self.origin;
  self playersetstreamorigin(var_3);
  self.origin = var_3;
  var_4 = spawn("script_model", (0, 0, 0));
  var_4 setModel("tag_origin");
  var_4.origin = self.origin;
  var_4.angles = (0, 108, 0);
  var_4.angles = (var_4.angles[0], var_4.angles[1] + 180, var_4.angles[2]);
  self playerlinkto(var_4, undefined, 1, 0, 0, 0, 0);
  var_4.angles = (var_4.angles[0] + 89, var_4.angles[1], 0);
  thread maps\_hud_util::fade_in(1);
  var_4 moveto(var_3 + (0, 0, var_1), var_0, 0, 0.25);
  wait 0.05;
  thread maps\satfarm_audio::overlord_trans2();
  wait(var_0 - 0.25);

  if(getdvar("debug_sat_view_pip", "1") == "2") {
    level.player maps\satfarm_satellite_view::satellite_view_init_hud(1);
    visionsetnaked("satfarm_b", 0.0);
    wait 0.25;
  } else
    level.player maps\satfarm_satellite_view::satellite_view_init_hud(0);

  visionsetnaked("satfarm_b", 0.0);
  var_5 = common_scripts\utility::getstruct("a10_player_start", "targetname");
  var_6 = common_scripts\utility::spawn_tag_origin();
  var_6.origin = (var_5.origin[0], var_5.origin[1], var_5.origin[2]);
  var_6.angles = var_4.angles;
  var_4 rotateto(var_4.angles + (0, 0, 16), 32);
  var_6 rotateto(var_4.angles + (0, 0, 16), 32);
  var_7 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("bridge_deploy_amb");
  var_8 = common_scripts\utility::getstruct("bridge_deploy_ghost_start", "targetname");
  var_9 = common_scripts\utility::getstruct("bridge_deploy_ghost_end", "targetname");
  var_10 = 10;
  var_11 = common_scripts\utility::spawn_tag_origin();
  var_11 setModel("generic_prop_raven");
  var_11.origin = var_8.origin;
  var_11 moveto(var_9.origin, var_10);

  if(getdvar("debug_sat_view_pip", "1") != "2")
    thread maps\satfarm_satellite_view::target_enable_sat_view(var_11, "ac130_hud_friendly_vehicle_diamond_s_w", (0, 1, 0));

  wait 0.5;
  var_12 = self worldpointtoscreenpos(var_11.origin + (var_9.origin - var_8.origin) * 0.65 / var_10, getdvarfloat("cg_fov"));

  if(!isDefined(var_12))
    var_12 = (0, 0, 0);

  if(getdvar("debug_sat_view_pip", "1") != "2")
    thread maps\satfarm_satellite_view::satellite_view_type_anchored_text(&"SATFARM_LOCATED", (1, 1, 1), "left", "top", 1);

  maps\satfarm_satellite_view::satellite_view_move_to_point(var_12[0], var_12[1], undefined, undefined, 0.5);
  wait 0.75;
  var_13 = var_11.origin + (var_9.origin - var_8.origin) * 0.9 / var_10 - anglestoright(vectortoangles(var_9.origin - var_8.origin)) * 50;
  var_14 = var_13 - anglesToForward(var_4.angles) * (var_4.origin[2] - var_13[2]);
  var_4 moveto(var_14, 0.5);

  if(getdvar("debug_sat_view_pip", "1") != "2")
    thread maps\satfarm_satellite_view::satellite_view_type_anchored_text(&"SATFARM_TRACKING", (1, 1, 1), "right", "top", 1);

  maps\satfarm_satellite_view::satellite_view_move_to_point(0, 0, undefined, undefined, 0.5);
  wait 0.5;
  var_4 linkto(var_11);

  if(getdvar("debug_sat_view_pip", "1") != "2")
    level.player lerpfov(30, 0.25);

  thread maps\satfarm_satellite_view::satellite_view_zoom_in_sound(0.25);

  if(getdvar("debug_sat_view_pip", "1") != "2")
    thread maps\satfarm_satellite_view::satellite_view_type_multiline_text("right", & "SATFARM_ADAM_RORKE", & "SATFARM_GHOST_ONE");

  wait 1;
  thread maps\satfarm_code::radio_dialog_add_and_go("satfarm_hqr_theaagunswill");
  thread maps\satfarm_code::radio_dialog_add_and_go("satfarm_com_ourtanksaregoing");
  thread maps\satfarm_complex::missile_bases();
  var_15 = 2;

  switch (getdvar("debug_sat_view_pip", "1")) {
    case "1":
      thread maps\satfarm_satellite_view::satellite_view_corner_pip(var_6, "tag_origin", 200, -145);
      thread maps\satfarm_satellite_view::satellite_view_pip_display_name(&"SATFARM_FEED_3", 1);
      break;
    case "2":
      level.player playerlinktoabsolute(var_6, "tag_origin");
      break;
  }

  wait 1;

  if(getdvar("debug_sat_view_pip", "1") != "2")
    thread maps\satfarm_satellite_view::satellite_view_type_anchored_text(&"SATFARM_SWITCHING_FEEDS", (1, 1, 1), "left", "top", 1.5);

  thread spawn_a10s();
  wait 1;

  switch (getdvar("debug_sat_view_pip", "1")) {
    case "1":
      maps\satfarm_satellite_view::satellite_view_blink_pip_border();
      thread maps\satfarm_satellite_view::satellite_view_move_to_point(-888, 500, undefined, undefined, 1.5);
      maps\satfarm_satellite_view::satellite_view_pip_change_size(888, 500, 1, 1);
      break;
    default:
      wait 0.6;
      thread maps\satfarm_satellite_view::satellite_view_move_to_point(-888, 500, undefined, undefined, 1.5);
      break;
  }

  var_4 unlink();
  var_4.origin = var_6.origin;
  var_4.angles = var_6.angles;
  var_4 rotateto(var_4.angles + (0, 0, 16), 24);
  setsaveddvar("cg_fov", 65);
  wait 0.05;
  thread remove_bridge_deploy_tanks(var_7);

  if(getdvar("debug_sat_view_pip", "1") != "2")
    target_remove(var_11);

  var_11 delete();

  if(getdvar("debug_sat_view_pip", "1") == "1")
    thread maps\satfarm_satellite_view::satellite_view_pip_disable();
  else if(getdvar("debug_sat_view_pip", "1") == "2")
    level.player playerlinktoabsolute(var_4, "tag_origin");

  maps\satfarm_satellite_view::satellite_view_move_to_point(0, 0, 888, 500, 0);
  thread maps\satfarm_satellite_view::satellite_view_move_to_point(-10, 0, 240, 240, 0.5);
  thread mark_mantis_turrets(var_4);

  if(getdvar("debug_sat_view_pip", "1") != "2") {
    thread maps\satfarm_satellite_view::satellite_view_type_multiline_text_at_point(20, 20, & "SATFARM_OBJECTIVE", & "SATFARM_DESTROY_THE_LOKI", & "SATFARM_DEFENSE_SATELLITE");
    thread maps\satfarm_satellite_view::satellite_view_type_multiline_text("left", "Missile Incoming", "Time: 5:51", undefined, "satellite_view_missile_wireframe");
  }

  thread maps\satfarm_code::radio_dialog_add_and_go("satfarm_hqr_badgeroneonewhat");
  wait 8;
  level.allyheli[0] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("bridge_deploy_apache_ally1");
  level.allyheli[1] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("bridge_deploy_apache_ally2");
  level.allyheli[2] = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("bridge_deploy_apache_ally3");
  level.allyhelis = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("bridge_deploy_apache_ally");
  thread maps\satfarm_code::radio_dialog_add_and_go("satfarm_bgr_overlordweneedair");
  thread maps\satfarm_code::radio_dialog_add_and_go("satfarm_hqr_rogera10sareen");
  var_16 = common_scripts\utility::getstruct("bridge_loc", "targetname");
  var_17 = spawn("script_model", (var_16.origin[0], var_16.origin[1], var_4.origin[2]));
  var_17 setModel("tag_origin");
  var_17.angles = (90, 0, 0);
  var_17 linkto(level.playertank);
  var_4 moveto((var_16.origin[0], var_16.origin[1], self.origin[2]), 1);
  thread maps\satfarm_satellite_view::satellite_view_move_to_point(0, 0, 32, 32, 1);
  wait 1.5;

  if(getdvar("debug_sat_view_pip", "1") != "2")
    level.player lerpfov(30, 0.25);

  thread maps\satfarm_satellite_view::satellite_view_zoom_in_sound(0.25);
  wait 0.5;

  if(getdvar("debug_sat_view_pip", "1") != "2")
    thread maps\satfarm_satellite_view::satellite_view_type_anchored_text(&"SATFARM_ACQUIRING", (1, 1, 1), "left", "top", 2);

  thread bridge_deploy_enemy_a10_gun_dives();
  var_18 = 0;

  foreach(var_20 in level.enemytanksbri1) {
    var_12 = self worldpointtoscreenpos(var_20.origin, getdvarfloat("cg_fov"));
    var_21 = 0;

    if(isDefined(var_12)) {
      maps\satfarm_satellite_view::satellite_view_move_to_point(var_12[0], var_12[1], undefined, undefined, 0.1);
      wait 0.1;

      if(!var_21) {
        if(getdvar("debug_sat_view_pip", "1") != "2")
          maps\satfarm_satellite_view::satellite_view_reticle_color("red");
      }

      wait 0.1;

      if(getdvar("debug_sat_view_pip", "1") != "2")
        maps\satfarm_satellite_view::satellite_view_blink_corners(1, 0.1);
      else
        wait 0.2;

      wait 0.2;

      if(getdvar("debug_sat_view_pip", "1") != "2")
        thread maps\satfarm_satellite_view::target_enable_sat_view(var_20, "satellite_view_enemy_target", (1, 0, 0));

      thread common_scripts\utility::play_sound_in_space("satf_satellite_blip_2", level.player.origin);
      var_18++;

      if(var_18 >= 4) {
        break;
      }
    }
  }

  level.player lerpfov(40, 0.25);
  thread maps\satfarm_satellite_view::satellite_view_zoom_out_sound(0.25);
  level.player maps\satfarm_satellite_view::satellite_view_move_to_point(0, 0, undefined, undefined, 0.25);

  if(getdvar("debug_sat_view_pip", "1") != "2")
    maps\satfarm_satellite_view::satellite_view_reticle_color("white");

  wait 2.5;

  foreach(var_24 in level.allyheli) {
    if(getdvar("debug_sat_view_pip", "1") != "2")
      thread maps\satfarm_satellite_view::target_enable_sat_view(var_24, "satellite_view_friendly_target", (0, 1, 0));
  }

  var_26 = spawn("script_model", level.allyheli[1] gettagorigin("tag_passenger") + anglesToForward(level.allyheli[1].angles) * level.allyheli[1].veh_speed * 0.75 * var_2);
  var_26 setModel("tag_origin");
  var_26.angles = (90, 0, 0);
  var_26 linkto(level.playertank);
  thread maps\satfarm_code::radio_dialog_add_and_go("satfarm_com_keepmovingbadgerone");
  thread maps\satfarm_code::radio_dialog_add_and_go("satfarm_com_weonlyhaveone");

  if(getdvar("debug_sat_view_pip", "1") != "2")
    thread maps\satfarm_satellite_view::satellite_view_type_text_at_point(&"SATFARM_SYNCING", (1, 1, 1), 320, 50, 0.75);

  wait 0.25;
  wait 0.5;
  var_16 = common_scripts\utility::getstruct("bridge_deploy_tank_loc", "targetname");
  var_17 = spawn("script_model", (var_16.origin[0], var_16.origin[1], var_4.origin[2]));
  var_17 setModel("tag_origin");
  var_17.angles = (90, 0, 0);
  var_17 linkto(level.playertank);
  level.satellite_view.height = 32;
  level.satellite_view.width = 32;
  var_4 moveto((var_16.origin[0], var_16.origin[1], self.origin[2]), 3);
  maps\satfarm_satellite_view::satellite_view_move_to_point(var_16.origin[0], var_16.origin[1], undefined, undefined, 0.5);
  wait 4;
  var_27 = spawn("script_model", level.playertank gettagorigin("tag_player") + (0, 0, 60));
  var_27 setModel("tag_origin");
  var_27.angles = level.playertank.angles;
  var_27 linkto(level.playertank);
  var_4 moveto(var_27.origin, 0.45, 0.1);
  level.ent = var_4;
  thread maps\satfarm_satellite_view::satellite_view_chopper_fade_hud(0.5);
  self lerpfov(90, 0.1);
  wait 0.1;
  self lerpfov(40, 0.25);
  wait 0.2;
  common_scripts\utility::waitframe();

  if(getdvar("debug_sat_view_pip", "1") != "2")
    thread maps\satfarm_satellite_view::delete_temp_sat_view_targets();

  maps\satfarm_satellite_view::satellite_view_clear_hud();
  wait 0.11;
  var_4 = spawn("script_model", (0, 0, 0));
  var_4 setModel("tag_origin");
  var_4.origin = (31713.5, -9095.38, -2.49035);
  var_4.angles = level.playertank gettagangles("tag_barrel");
  self playerlinkto(var_4, undefined, 1, 0, 0, 0, 0);
  var_4 moveto(level.playertank gettagorigin("tag_turret") - (0, 0, 64), 0.15);
  wait 0.16;
  self unlink();
  self.origin = level.playertank gettagorigin("tag_player");
  self setplayerangles(level.playertank gettagangles("tag_turret"));
  self playerlinktoabsolute(level.playertank);
  self playSound("survival_slamzoom");
  self unlink();
  common_scripts\utility::flag_set("bridge_deploy_pre_end");
  kill_heli();
  common_scripts\utility::flag_set("bridge_deploy_player_mount_tank");
  self freezecontrols(0);
  self playerclearstreamorigin();
  level.player.ignoreme = 0;
  setsaveddvar("compass", 1);
  self lerpfov(65, 0.25);
  common_scripts\utility::waitframe();
  common_scripts\utility::flag_set("bridge_deploy_end");
  visionsetnaked("satfarm_b", 0);
}

spawn_allies_deploy() {
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("bridge_deploy_playertank");
  var_1 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("bridge_deploy_heros");
  level.playertank = var_0;
  level.allytanks = var_1;
  common_scripts\utility::flag_wait("bridge_deploy_pre_end");
  var_0 delete();

  foreach(var_3 in var_1) {
    if(isDefined(var_3))
      var_3 delete();
  }
}

bridge_deploy_enemy_tanks_setup() {
  maps\_utility::array_spawn_function_targetname("air_strip_bridge_enemies", maps\satfarm_code::npc_tank_combat_init);
  level.enemytanksbri1 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("air_strip_bridge_enemies");
  level.enemytanks = level.enemytanksbri1;
  common_scripts\utility::flag_wait("bridge_deploy_pre_end");

  foreach(var_1 in level.enemytanksbri1) {
    if(isDefined(var_1))
      var_1 delete();
  }
}

bridge_deploy_enemy_a10_gun_dives() {
  wait 2;
  maps\_vehicle::spawn_vehicle_from_targetname_and_drive("bridge_a10_gun_dive_2a");
  wait 0.5;
  maps\_vehicle::spawn_vehicle_from_targetname_and_drive("bridge_a10_gun_dive_2b");
  wait 2;

  foreach(var_1 in level.enemytanksbri1) {
    if(isDefined(var_1))
      var_1 thread maps\satfarm_code::handle_tank_death();

    wait(randomfloatrange(0.1, 0.5));
  }
}

spawn_a10s() {
  thread spawn_a10_gun_dive_entrance("deploy_a10_gun_dive_entrance1a");
  thread spawn_a10_gun_dive_entrance("deploy_a10_gun_dive_entrance1b");
  wait 0.5;
  thread spawn_a10_gun_dive_entrance("deploy_a10_gun_dive_entrance2a");
  thread spawn_a10_gun_dive_entrance("deploy_a10_gun_dive_entrance2b");
}

spawn_a10_gun_dive_entrance(var_0) {
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(var_0);
  wait(randomfloatrange(4, 5));
  playFXOnTag(level._effect["aerial_explosion_mig29"], var_1, "tag_origin");
  wait 0.1;
  var_1 maps\_vehicle::godoff();
  var_1 kill();
  wait 0.75;

  if(isDefined(var_1))
    var_1 delete();
}

mark_mantis_turrets(var_0) {
  wait 0.2;
  var_1 = getEntArray("complex_mantis_turrets", "script_noteworthy");
  var_2 = 0;
  var_3 = 0.3;
  var_4 = 0;
  var_5 = var_1[0];
  var_6 = var_5 common_scripts\utility::spawn_tag_origin();
  var_7 = common_scripts\utility::spawn_tag_origin();
  var_7.origin = var_6.origin + anglesToForward(var_5.angles) * 750 + (0, 0, 250);
  var_7.angles = vectortoangles(var_6.origin - var_7.origin);
  var_7 linkto(var_6);
  var_6 rotateyaw(15, 5);

  if(getdvar("debug_sat_view_pip", "1") == "1")
    thread maps\satfarm_satellite_view::satellite_view_corner_pip(var_7, "tag_origin", 220, -145, 100, 100);
  else if(getdvar("debug_sat_view_pip", "1") == "2")
    level.player playerlinktoabsolute(var_7, "tag_origin");

  foreach(var_5 in var_1) {
    var_9 = level.player worldpointtoscreenpos(var_5.origin, getdvarfloat("cg_fov"));

    if(!isDefined(var_9)) {
      continue;
    }
    if(getdvar("debug_sat_view_pip", "1") != "2")
      thread maps\satfarm_satellite_view::satellite_view_zoom_box(var_5.origin, 15, 2, 0.25, 2.5 - var_3 * var_4);

    var_2++;

    if(var_2 >= 2) {
      var_2 = 0;
      wait(var_3);
      var_4++;
    }
  }

  wait 2.5;

  if(getdvar("debug_sat_view_pip", "1") == "1")
    thread maps\satfarm_satellite_view::satellite_view_pip_disable();
  else
    level.player playerlinktoabsolute(var_0, "tag_origin");

  var_7 unlink();
  var_7 delete();
  var_6 delete();
}

remove_bridge_deploy_tanks(var_0) {
  foreach(var_2 in var_0) {
    var_2 delete();
    wait 0.05;
  }
}

kill_heli() {
  level.allyheli[0] delete();
  level.allyheli[1] delete();
  level.allyheli[2] delete();

  foreach(var_1 in level.allyhelis) {
    if(isDefined(var_1))
      var_1 delete();
  }
}