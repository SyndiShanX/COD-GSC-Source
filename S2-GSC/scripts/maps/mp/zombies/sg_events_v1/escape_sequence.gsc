/********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\sg_events_v1\escape_sequence.gsc
********************************************************************/

init() {
  initialize_markers();
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register_defaults("type_escape_common", ::run_escape, undefined, undefined, 1);
}

initialize_markers() {
  level.zmf_shattered_hardpoint_structs = common_scripts\utility::_id_46B7("zmf_shattered_hardpoint_marker", "targetname");
  level.zmf_shattered_hardpoint_markers = [];
  var_0 = 16;

  foreach(var_2 in level.zmf_shattered_hardpoint_structs) {
    var_3 = bulletTrace(var_2.origin + (0, 0, var_0), var_2.origin - (0, 0, var_0), 0);

    if(distance(var_2.origin, var_3["position"]) > var_0) {
      continue;
    }
    var_2.origin = var_3["position"] + (0, 0, 0.25);
  }
}

hide_markers() {
  foreach(var_1 in level.zmf_shattered_hardpoint_markers) {
    var_1 hide();
  }
}

show_markers() {
  foreach(var_1 in level.zmf_shattered_hardpoint_structs) {
    if(isDefined(var_1.fx)) {
      var_1.fx show();
      continue;
    }

    var_1.fx = _id_0547::_id_8FBA(var_1, "hp_neutral");
    level.zmf_shattered_hardpoint_markers = common_scripts\utility::_id_0F6F(level.zmf_shattered_hardpoint_markers, var_1.fx);
    _triggerfx(var_1.fx);
  }
}

run_escape(var_0) {
  level endon("game_over");
  var_1 = common_scripts\utility::_id_46B5("dom_flag_pole_b", "targetname");
  var_2 = common_scripts\utility::_id_46B5(var_1.target, "targetname");
  var_3 = spawn("script_model", var_1.origin);
  var_3 setModel("ctf_flag_pole_with_supports");
  var_4 = spawn("script_model", var_2.origin);
  var_4 setModel("usa_ctf_flag_anim");
  var_4 scriptmodelplayanim("ctf_flag_flap");

  if(isDefined(var_1.angles)) {
    var_3.angles = var_1.angles;
  }

  if(isDefined(var_2.angles)) {
    var_4.angles = var_4.angles;
  }

  var_3.capture_health = 100;
  var_3.health = 100;
  var_3.maxhealth = 100;
  var_3.anim_flag = var_4;
  var_4 ghost();
  var_3 setModel("tag_origin");
  var_5 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("type_escape_common_delay");
  var_6 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("type_escape_common_capture_time");
  var_7 = spawnStruct();
  var_7 thread maps\mp\mp_zombie_nest_ee_wave_manipulation::enforce_zombie_limit("escape_started", 8);
  var_7 thread ramp_value(var_5);
  _id_0378::_id_8D74("dlc3_start_escape_music");
  var_8 = var_3;
  var_8._id_603C = "zm_hud_type_escape_common_icon";
  var_8.waypoint_origin = var_8.origin + (0, 0, 80);
  var_8.waypoints = [];
  level thread maps\mp\_utility::_id_6F74(maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::draw_waypoint_on_struct, var_8);
  level thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode::sg_obj_timer(int(var_5 + var_6));
  wait_escape_intro(var_5);
  show_markers();
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::clear_all_waypoints();
  var_7 notify("escape_started");
  _id_0378::_id_8D74("dlc3_stop_escape_music", 80);
  return capture_escape_point(var_3, var_6);
}

wait_escape_intro(var_0) {
  wait(var_0);
}

capture_escape_point(var_0, var_1) {
  var_2 = var_0.origin;
  var_3 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("type_escape_common_capture_radius");
  var_4 = 1;
  var_5 = 0;
  var_6 = var_0.anim_flag;

  while(isDefined(var_0) && var_0.capture_health > 0) {
    var_5 = var_5 + var_4;
    var_0.capture_health = int(max(0, var_0.maxhealth - int(var_0.maxhealth * (var_5 / var_1))));
    wait(var_4);
  }

  var_6 delete();
  _id_0378::_id_8D74("dlc3_stop_escape_music", 0);
  var_7 = 0;

  foreach(var_9 in level.players) {
    var_9._id_480F = 1;
  }

  foreach(var_9 in level.players) {
    if(isalive(var_9) && _distance2d(var_9.origin, var_2) < var_3) {
      maps\mp\zombies\shotgun\_zombies_shotgun_exp_events::individual_escape_bonus(var_9);
      var_7++;
    }
  }

  if(var_7 > 0) {
    maps\mp\zombies\shotgun\_zombies_shotgun_gamemode::set_game_won();
  }

  if(var_7 >= level.players.size) {
    maps\mp\zombies\shotgun\_zombies_shotgun_exp_events::group_escape_bonus();
  }

  wait 3.5;
  return 1;
}

ramp_value(var_0) {
  self.zombie_count = 1;

  for(;;) {
    self.zombie_count = self.zombie_count + 1;
    wait(int(var_0 / 18));
  }
}