/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_milehigh_hijack.gsc
***********************************************/

main() {
  fixsp();
  precacheeverything();
  _id_011C();
  _id_562F();
  maps\_load::main();
  maps\so_milehigh_hijack_slowmo_killswitch::init();
  level thread startambientvo();
  level thread _id_0128();
  level thread _id_0129();

  if(_id_011A()) {
    var_0 = getEntArray("so_commander", "script_noteworthy");

    foreach(var_2 in var_0) {}
    var_2.count = 0;
  }

  setupdifficulty();
  setupsp();
  setupenemies();
  setupplane();
  level thread setupstart();
  level thread setupplayers();
  level thread setupobjectives();
  level thread setupchallenge();
  level thread spawnenemies();
  level thread lowerplanerumble();
  level thread upperplanerumble();
  level thread setupdoors();
  level thread startdebate();
  level thread setupcounterbreach();
  level thread setupendcleanup();
  level thread watchplayeroverlap();
}

_id_562F() {
  foreach(var_2, var_1 in level.createfxent) {
    if(attachpath(var_1)) {
      level.createfxent[var_2] = undefined;
      var_1.v = undefined;
      continue;
    }

    var_1.script_specialops = 1;
  }

  level.createfxent = common_scripts\utility::array_removeundefined(level.createfxent);
}

attachpath(var_0) {
  if(var_0.v["type"] != "soundfx_interval" && var_0.v["type"] != "soundfx") {
    return 0;
  }
  if(var_0.v["origin"][2] < 6500) {
    return 1;
  }
  return 0;
}

_id_011A() {
  return isDefined(level.no_slowmo) && level.no_slowmo;
}

watchplayeroverlap() {
  level.planerumbleactive = 0;

  if(!maps\_utility::is_coop()) {
    return;
  }
  level endon("special_op_terminated");
  var_0 = level.players[0];
  var_1 = level.players[1];

  while(level.players.size > 1) {
    while(!level.planerumbleactive || !playeroverlap(var_0, var_1)) {
      wait 0.05;
    }
    var_2 = var_0 setcontents(0);
    var_3 = var_1 setcontents(0);

    while(playeroverlap(var_0, var_1)) {
      wait 0.05;
    }
    var_0 setcontents(var_2);
    var_1 setcontents(var_3);
  }
}

playeroverlap(var_0, var_1) {
  if(abs(var_0.origin[2] - var_1.origin[2]) > 70) {
    return 0;
  }
  var_2 = distance2d(var_0.origin, var_1.origin);

  if(var_2 > 30) {
    return 0;
  }
  return 1;
}

precacheeverything() {
  common_scripts\utility::flag_init("lower_floor_first_terrorists");
  common_scripts\utility::flag_init("so_upper_floor_last_chance");
  common_scripts\utility::flag_init("so_conference_room_terrorists");
  common_scripts\utility::flag_init("so_begin_debate_breach");
  common_scripts\utility::flag_init("so_president_spawned");
  common_scripts\utility::flag_init("so_president_captured");
  common_scripts\utility::flag_init("so_conference_room_hall");
  precacheminimapsentrycodeassets();
  _id_011B();
  maps\createart\hijack_art::main();
  maps\hijack_fx::main();
  maps\hijack_aud::main();
  maps\hijack_anim::main();
  maps\hijack_precache::main();
  _id_02FE::main();
  setupanims();
  maps\hijack::level_precache();
  maps\hijack::level_init_flags();
  maps\hijack::level_init_assets();
  maps\hijack_precache::main();
  _id_02A4::main();
}

_id_011B() {
  level.scr_radio["so_milehigh_fail_cowards"] = "so_milehigh_fail_cowards";
  level.scr_radio["so_milehigh_fail_no_defeat"] = "so_milehigh_fail_no_defeat";
  level.scr_radio["so_milehigh_fail_been_defeated"] = "so_milehigh_fail_been_defeated";
  level.scr_radio["so_milehigh_fail_next_fight"] = "so_milehigh_fail_next_fight";
  level.scr_radio["so_milehigh_fail_happen_again"] = "so_milehigh_fail_happen_again";
  level.scr_radio["so_milehigh_fail_objective"] = "so_milehigh_fail_objective";
  level.scr_radio["so_milehigh_win_served_well"] = "so_milehigh_win_served_well";
  level.scr_radio["so_milehigh_win_victory"] = "so_milehigh_win_victory";
  level.scr_radio["so_milehigh_win_enemy_defeated"] = "so_milehigh_win_enemy_defeated";
  level.scr_radio["so_milehigh_win_well_done"] = "so_milehigh_win_well_done";
  level.scr_radio["so_milehigh_win_victorious"] = "so_milehigh_win_victorious";
  level.scr_radio["so_milehigh_win_victory_ours"] = "so_milehigh_win_victory_ours";
  level.scr_radio["so_milehigh_win_jerk"] = "so_milehigh_win_jerk";
  level.scr_radio["so_milehigh_time_hurry"] = "so_milehigh_time_hurry";
  level.scr_radio["so_milehigh_time_generic"] = "so_milehigh_time_generic";
  level.scr_radio["so_milehigh_start_capture"] = "so_milehigh_start_capture";
  level.scr_radio["so_milehigh_start_defeat"] = "so_milehigh_start_defeat";
  level.scr_radio["so_milehigh_start_finish"] = "so_milehigh_start_finish";
}

_id_011C() {
  level.so_dialog_func_override = [];
  level.so_dialog_func_override["ready_up"] = ::_id_011E;
  level.so_dialog_func_override["success_best"] = ::_id_0125;
  level.so_dialog_func_override["success_generic"] = ::_id_0125;
  level.so_dialog_func_override["failed_generic"] = ::_id_0121;
  level.so_dialog_func_override["failed_time"] = ::_id_0124;
  level.so_dialog_func_override["failed_bleedout"] = ::_id_0121;
  level.so_dialog_func_override["time_low_normal"] = ::_id_011F;
  level.so_dialog_func_override["time_low_hurry"] = ::_id_0120;
  level.so_dialog_func_override["killing_civilians"] = ::_id_011D;
  level.so_dialog_func_override["progress_goal_status"] = ::_id_011D;
  level.so_dialog_func_override["time_status_late"] = ::_id_011D;
  level.so_dialog_func_override["time_status_good"] = ::_id_011D;
  level.so_dialog_func_override["progress"] = ::_id_011D;
}

_id_011D(var_0) {}

_id_011E() {
  maps\_specialops_code::so_dialog_play("so_milehigh_start_finish", 0, 1);
}

_id_011F() {
  maps\_specialops_code::so_dialog_play("so_milehigh_time_generic");
}

_id_0120() {
  maps\_specialops_code::so_dialog_play("so_milehigh_time_hurry");
}

_id_0121() {
  if(isDefined(level._id_0122) && level._id_0122) {
    return;
  }
  if(isDefined(level._id_0123) && level._id_0123) {
    maps\_specialops_code::so_dialog_play("so_milehigh_fail_objective");
    return;
  }

  var_0 = randomint(4);

  switch (var_0) {
    case 0:
      maps\_specialops_code::so_dialog_play("so_milehigh_fail_no_defeat");
      break;
    case 1:
      maps\_specialops_code::so_dialog_play("so_milehigh_fail_been_defeated");
      break;
    case 2:
      maps\_specialops_code::so_dialog_play("so_milehigh_fail_next_fight");
      break;
    case 3:
      maps\_specialops_code::so_dialog_play("so_milehigh_fail_happen_again");
      break;
  }
}

_id_0124() {
  level._id_0122 = 1;
  maps\_specialops_code::so_dialog_play("so_milehigh_fail_cowards");
}

_id_0125(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;

    if(level.gameskill >= 3) {
      if(maps\_specialops::has_been_played()) {
        var_0 = common_scripts\utility::cointoss();
      }
    }
  }

  if(var_0) {
    maps\_specialops_code::so_dialog_play("so_milehigh_win_jerk", 0.5, 1);
  } else {
    var_1 = randomint(6);

    switch (var_1) {
      case 0:
        maps\_specialops_code::so_dialog_play("so_milehigh_win_served_well", 0.5, 1);
        break;
      case 1:
        maps\_specialops_code::so_dialog_play("so_milehigh_win_victory", 0.5, 1);
        break;
      case 2:
        maps\_specialops_code::so_dialog_play("so_milehigh_win_enemy_defeated", 0.5, 1);
        break;
      case 3:
        maps\_specialops_code::so_dialog_play("so_milehigh_win_well_done", 0.5, 1);
        break;
      case 4:
        maps\_specialops_code::so_dialog_play("so_milehigh_win_victorious", 0.5, 1);
        break;
      case 5:
        maps\_specialops_code::so_dialog_play("so_milehigh_win_victory_ours", 0.5, 1);
        break;
    }
  }
}

fixsp() {
  var_0 = getEntArray();

  foreach(var_2 in var_0) {
    if(!issubstr(var_2.classname, "trigger")) {
      continue;
    }
    if(!isDefined(var_2.script_audio_zones) && !isDefined(var_2.audio_zones) && !isDefined(var_2.ambient) && (isDefined(var_2.script_audio_enter_msg) || isDefined(var_2.script_audio_exit_msg) || isDefined(var_2.script_audio_progress_msg) || isDefined(var_2.script_audio_enter_func) || isDefined(var_2.script_audio_exit_func) || isDefined(var_2.script_audio_progress_func) || isDefined(var_2.script_audio_point_func))) {
      var_2 delete();
    }
  }

  var_4 = getEnt("hijack_crash_model_exterior", "script_noteworthy");
  var_4 delete();
  var_5 = getEntArray("hijack_crash_plane_model", "targetname");

  foreach(var_7 in var_5) {
    if(var_7.model == "hijack_plane_crash_exterior_rear_shell") {
      var_7 delete();
      break;
    }
  }

  var_9 = getEntArray("trigger_multiple_visionset", "classname");

  foreach(var_11 in var_9) {
    if(isDefined(var_11.script_visionset)) {
      if(var_11.script_visionset == "hijack_cargo") {
        var_11 delete();
        continue;
      }

      if(var_11.script_visionset == "hijack_conference") {
        var_11 delete();
        continue;
      }

      if(var_11.script_visionset == "hijack_airplane_combat") {
        var_11 delete();
      }
    }
  }
}

setupsp() {
  precacheshellshock("hijack_airplane");
  precacheshellshock("hijack_minor");
  precacheshellshock("hijack_slowview");
  precacheshellshock("default");
  precacheshellshock("dcburning");
  precacheshellshock("hijack_door_explosion");
  precacheshellshock("hijack_engine_explosion");
  precacheshellshock("hijack_tail_explosion");
  precacheshellshock("hijack_end_scene");
  precacherumble("hijack_plane_low");
  precacherumble("hijack_plane_medium");
  precacherumble("hijack_plane_large");
  maps\_utility::battlechatter_off("axis");
  maps\_utility::battlechatter_off("allies");
  thread maps\_utility::set_vision_set("hijack_airplane", 1);
  level.debate_trigger = getEnt("player_debate_trigger", "script_noteworthy");
  level.debate_trigger common_scripts\utility::trigger_off();

  if(getDvar("airmasks") == "") {
    setDvar("airmasks", "1");
  }
  level.player setweaponammostock("fnfiveseven", 60);
  level.orig_phys_gravity = getDvar("phys_gravity");
  level.orig_ragdoll_gravity = getDvar("phys_gravity_ragdoll");
  level.orig_wakeupradius = getDvar("phys_gravityChangeWakeupRadius");
  level.orig_ragdoll_life = getDvar("ragdoll_max_life");
  level.orig_sundirection = (-14, 114, 0);
  level.org_view_roll = getEnt("org_view_roll", "targetname");
  level.player playersetgroundreferenceent(level.org_view_roll);
  level.arollers = [];
  level.arollers = maps\_utility::array_add(level.arollers, level.org_view_roll);
  level.conf_lights_off = getEntArray("conf_light_off", "targetname");
  common_scripts\utility::array_call(level.conf_lights_off, ::hide);
  var_0 = getEntArray("airmask", "targetname");
  common_scripts\utility::array_thread(var_0, maps\hijack_code::airmask_setup);
  level.seatbeltsigns = getEntArray("seatbelt_signs", "targetname");
  common_scripts\utility::array_call(level.seatbeltsigns, ::hide);
  level.crash_models = getEntArray("hijack_crash_plane_model", "targetname");
  thread maps\hijack::setup_volumetric_lights();
  thread maps\hijack::setup_object_mass();
  thread maps\hijack::no_grenade_death_hack();
  thread maps\hijack::setup_tarmac_triggers();
  thread maps\hijack::setup_hijack_specific_lights();
  thread maps\hijack::pause_inflight_fx();
  thread maps\hijack::pause_tarmac_fx();
  thread maps\hijack::pause_fuselage_fire_fx();
  thread maps\hijack::pause_wreckage_interior_fx();
}

setupplane() {
  maps/_slowmo_breach::slowmo_breach_init();
  maps/_slowmo_breach::add_breach_func(::breachstart);
  maps\_anim::addnotetrack_customfunction("active_breacher_rig", "slowmo", ::postslowmobegins);
  level thread maps\hijack::show_tail_models();
  level thread maps\hijack_crash_fx::pre_sled_light();
  level thread maps\hijack::setup_cloud_tunnel();
  level thread maps\hijack::setup_turbines();
  maps\_compass::setupminimap("compass_map_hijack_airplane", "airplane_upper_minimap_corner");
  setsaveddvar("compassmaxrange", 1500);
  level thread setupglass();
}

setupglass() {
  level endon("special_op_terminated");
  var_0 = getEnt("glass_blocking_clip", "targetname");
  level waittill("slowmo_breach_ending");
  wait 2;
  var_0 delete();
}

setupstart() {
  level endon("special_op_terminated");
  var_0 = getEnt("so_first_breach_trigger", "targetname");
  var_0 setHintString("");
  waittillbothplayersweaponsareready();
  var_0 notify("trigger", level.players[0]);
  level notify("so_players_ready");

  foreach(var_2 in level.players) {}
  var_2 freezecontrols(0);
}

setupplayers() {
  foreach(var_1 in level.players) {
    var_1 playersetgroundreferenceent(level.org_view_roll);
    var_1 freezecontrols(1);
    var_1 thread playerdetectdamage();
    var_1 thread playershowdamagedhud();
    var_1 thread playershowaccuracyhud();
  }
}

playerdetectdamage() {
  level endon("special_op_terminated");
  self.num_times_damaged = 0;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);
    self.num_times_damaged++;
    self notify("milehigh_damage");
  }
}

playershowaccuracyhud() {
  level endon("special_op_terminated");
  var_0 = maps\_specialops::so_hud_ypos();
  self.hud_so_accuracy_msg = maps\_specialops::so_create_hud_item(4, var_0, &"SO_MILEHIGH_HIJACK_ACCURACY_HUD", self);
  self.hud_so_accuracy_count = maps\_specialops::so_create_hud_item(4, var_0, &"SO_MILEHIGH_HIJACK_ACCURACY_HUD_PERCENT", self);
  self.hud_so_accuracy_count.alignx = "left";
  thread maps\_specialops::info_hud_handle_fade(self.hud_so_accuracy_msg);
  thread maps\_specialops::info_hud_handle_fade(self.hud_so_accuracy_count);
  var_1 = 100;

  for(;;) {
    var_2 = max(1, float(self.stats["shots_fired"]));
    var_3 = max(1, float(self.stats["shots_hit"]));
    var_1 = var_3 / var_2;
    var_1 = int(var_1 * 100);
    self.hud_so_accuracy_count setvalue(var_1);
    wait 0.1;
  }
}

playershowdamagedhud() {
  level endon("special_op_terminated");
  var_0 = maps\_specialops::so_hud_ypos();
  self.hud_so_damaged_msg = maps\_specialops::so_create_hud_item(3, var_0, &"SO_MILEHIGH_HIJACK_DAMAGED_HUD", self);
  self.hud_so_damaged_count = maps\_specialops::so_create_hud_item(3, var_0, undefined, self);
  self.hud_so_damaged_count settext(0);
  self.hud_so_damaged_count.alignx = "left";
  thread maps\_specialops::info_hud_handle_fade(self.hud_so_damaged_msg);
  thread maps\_specialops::info_hud_handle_fade(self.hud_so_damaged_count);
  thread playerdamagedhudsetcolor();

  for(;;) {
    self waittill("milehigh_damage");
    self.hud_so_damaged_count settext(self.num_times_damaged);
  }
}

playerdamagedhudsetcolor() {
  level endon("special_op_terminated");
  var_0 = int(15.0);
  var_1 = int(30.0);
  self.hud_so_damaged_count maps\_specialops::set_hud_green();
  self.hud_so_damaged_msg maps\_specialops::set_hud_green();
  var_2 = "green";

  for(;;) {
    if(self.num_times_damaged >= var_1) {
      self.hud_so_damaged_count maps\_specialops::set_hud_red();
      self.hud_so_damaged_msg maps\_specialops::set_hud_red();
      break;
    } else if(var_2 != "yellow" && self.num_times_damaged >= var_0) {
      self.hud_so_damaged_count maps\_specialops::set_hud_yellow();
      self.hud_so_damaged_msg maps\_specialops::set_hud_yellow();
      var_2 = "yellow";
    }

    wait 0.1;
  }
}

waittillbothplayersweaponsareready() {
  level endon("special_op_terminated");
  var_0 = 1;

  while(var_0) {
    if(level.players[0] isswitchingweapon() || level.players[0] maps/_slowmo_breach::using_illegal_breach_weapon()) {
      common_scripts\utility::waitframe();
      continue;
    }

    if(level.players.size == 2 && (level.players[1] isswitchingweapon() || level.players[0] maps/_slowmo_breach::using_illegal_breach_weapon())) {
      common_scripts\utility::waitframe();
      continue;
    }

    var_0 = 0;
  }
}

postslowmobegins(var_0) {
  setsaveddvar("bullet_penetration_damage", 1);
}

breachstart(var_0) {
  level endon("special_op_terminated");

  if(!common_scripts\utility::flag("so_player_upstairs")) {
    common_scripts\utility::flag_set("lower_floor_first_terrorists");
    common_scripts\utility::flag_set("so_milehigh_hijack_start");
    maps\_audio::aud_send_msg("start_lower_level_combat");
    level thread opencargodoor();
    level waittill("slowmo_breach_ending", var_1);
    level.slomobreachduration = 2.5;
  } else {
    common_scripts\utility::flag_set("so_begin_debate_breach");
    common_scripts\utility::flag_set("door_breach");
    level.door4 delete();
    level waittill("slowmo_breach_ending", var_1);
    common_scripts\utility::flag_set("so_counter_breach");
  }

  var_2 = getaiarray();

  foreach(var_4 in var_2) {
    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "so_president") {
      continue;
    }
    if(var_4.baseaccuracy != 5000) {
      continue;
    }
    var_4.health = 150;
    var_4.baseaccuracy = level.new_enemy_accuracy;
  }
}

#using_animtree("animated_props");

opencargodoor() {
  level endon("special_op_terminated");

  foreach(var_1 in level.crash_models) {
    var_1.animname = "generic";
    var_1 useanimtree(#animtree);
  }

  var_3 = getEnt("hijack_crash_model_front_interior", "script_noteworthy");
  maps\_audio::aud_send_msg("pre_crash_door");
  var_3 thread maps\_anim::anim_single_solo(var_3, "hijack_pre_plane_crash_door");
  var_4 = getEnt("crash_door_blocker", "targetname");
  var_4 delete();
  common_scripts\utility::waitframe();
  var_3 thread maps\_anim::anim_self_set_time("hijack_pre_plane_crash_door", 0.99);
}

setupanims() {
  setupenemyanims();
  setupplayeranims();
}

#using_animtree("generic_human");

setupenemyanims() {
  level.scr_anim["generic"]["payback_breach_react_soldier_4"] = % payback_breach_react_soldier_4;
  level.scr_anim["generic"]["payback_breach_crateguy"] = % payback_breach_crateguy;
  level.scr_anim["generic"]["payback_breach_doorguy"] = % payback_breach_doorguy;
  level.scr_anim["generic"]["ny_harbor_bulkhead_door_breach_stunned_guy1"] = % ny_harbor_bulkhead_door_breach_stunned_guy1;
  level.scr_anim["generic"]["ny_harbor_bulkhead_door_breach_stunned_guy2"] = % ny_harbor_bulkhead_door_breach_stunned_guy2;
  level.scr_anim["so_advisor"]["debate"] = % so_milehigh_breach_reaction_advisor_start;
  level.scr_anim["so_advisor"]["debate_cine_advisor_end_loop"][0] = % so_milehigh_breach_reaction_advisor_loop;
  level.scr_anim["so_agent2"]["debate"] = % so_milehigh_breach_reaction_agent2;
  level.scr_anim["so_commander"]["debate"] = % so_milehigh_breach_reaction_commander;
  level.scr_anim["so_hero_agent"]["debate"] = % so_milehigh_breach_reaction_hero_agent;
  level.scr_anim["so_flashbang_enemy"]["so_milehigh_breach_flashbang_toss"] = % so_milehigh_breach_flashbang_toss;
  level.scr_anim["so_advisor"]["couch_death"] = % so_milehigh_breach_advisor_death;
}

#using_animtree("multiplayer");

setupplayeranims() {
  level.scr_animtree["player_slide_stumble"] = #animtree;
  level.scr_model["player_slide_stumble"] = "viewmodel_base_viewhands";
  level.scr_anim["player_slide_stumble"]["pb_stumble_forward"] = % pb_stumble_forward;
  level.scr_anim["player_slide_stumble"]["pb_stumble_back"] = % pb_stumble_back;
  level.scr_anim["player_slide_stumble"]["pb_stumble_left"] = % pb_stumble_left;
  level.scr_anim["player_slide_stumble"]["pb_stumble_right"] = % pb_stumble_right;
  level.scr_anim["player_slide_stumble"]["root"] = % code;
}

playerplaycoopslideanim(var_0) {
  level endon("special_op_terminated");

  if(!maps\_utility::is_coop()) {
    return;
  } else if(self getstance() == "stand") {
    self allowcrouch(0);
    self allowprone(0);
  } else {
    self allowstand(0);
    self allowprone(0);
  }

  self allowjump(0);
  var_1 = vectorNormalize(var_0);
  var_2 = vectorNormalize(anglesToForward(self.angles));
  var_3 = vectordot(var_1, var_2);
  var_4 = acos(var_3);
  var_5 = undefined;

  if(var_4 < 45) {
    var_5 = "pb_stumble_forward";
  } else if(var_4 > 135) {
    var_5 = "pb_stumble_back";
  } else {
    var_6 = isleft(var_2, var_1);

    if(var_6) {
      var_5 = "pb_stumble_left";
    } else {
      var_5 = "pb_stumble_right";
    }
  }

  self.animname = "player_slide_stumble";
  thread maps\_anim::anim_single_solo(self, var_5);
  common_scripts\utility::waitframe();
  self allowcrouch(1);
  self allowstand(1);
  self allowprone(1);
  self allowjump(1);
}

isleft(var_0, var_1) {
  return var_0[0] * var_1[1] - var_0[1] * var_1[0] > 0;
}

setupdifficulty() {
  maps\hijack_code::so_remove_entities_by_script_difficulty();

  switch (level.gameskill) {
    case 1:
    case 0:
      somilehighregular();
      break;
    case 2:
      somilehighhardened();
      break;
    case 3:
      somilehighveteran();
      break;
  }

  if(maps\_utility::is_coop()) {
    level._id_0126 = 38;
  }
}

somilehighregular() {
  level.challenge_time_limit = 210;
  level.new_enemy_accuracy = 1;
  level._id_0126 = 26;
}

somilehighhardened() {
  level.challenge_time_limit = 145;
  level.new_enemy_accuracy = 1;
  level._id_0126 = 31;
}

somilehighveteran() {
  level.challenge_time_limit = 110;
  level.new_enemy_accuracy = 1;
  level._id_0126 = 36;
}

setupobjectives() {
  level endon("special_op_terminated");
  var_0 = common_scripts\utility::getStruct("so_upstairs", "targetname");
  var_1 = common_scripts\utility::getStruct("so_obj_find_president", "targetname");
  objective_add(1, "current", &"SO_MILEHIGH_HIJACK_OBJECTIVE_FIND");
  objective_setpointertextoverride(1, "");
  objective_position(1, var_0.origin);
  common_scripts\utility::flag_wait("so_player_upstairs");
  objective_position(1, var_1.origin);
  common_scripts\utility::flag_wait("so_obj_find_president");
  maps\_utility::objective_complete(1);
  objective_add(2, "current", &"SO_MILEHIGH_HIJACK_OBJECTIVE_CAPTURE");
  maps/_slowmo_breach::objective_breach(2, 2);
  common_scripts\utility::flag_wait("so_president_spawned");
  level.so_president waittill("so_debate_anim_started");
  common_scripts\utility::waitframe();
  setsaveddvar("objectiveHide", 0);
  objective_setpointertextoverride(2, &"SO_MILEHIGH_HIJACK_CAPTURE");
  level.so_president thread presidentupdatecaptureobjective();
  common_scripts\utility::flag_wait("so_president_captured");
  level.so_president.so_no_mission_over_delete = 1;
  level.so_president setHintString("");
  common_scripts\utility::flag_set("so_milehigh_hijack_complete");
  maps\_utility::objective_complete(2);
}

presidentupdatecaptureobjective() {
  level endon("special_op_terminated");
  self endon("death");

  while(!common_scripts\utility::flag("so_president_captured")) {
    var_0 = self.origin + (0, 0, 32);
    objective_position(2, var_0);
    common_scripts\utility::waitframe();
  }
}

setupchallenge() {
  level thread maps\_specialops::enable_challenge_timer("so_milehigh_hijack_start", "so_milehigh_hijack_complete");
  level thread maps\_specialops::fade_challenge_in(1.5, 1);
  level thread maps\_specialops::fade_challenge_out("so_milehigh_hijack_complete", 0);
  level.milehigh_num_enemies = 0;
  level.custom_eog_no_defaults = 1;
  level.eog_summary_callback = ::customeogsummary;
  level waittill("so_players_ready");
  common_scripts\utility::waitframe();

  foreach(var_1 in level.players) {}
  var_1 notify("force_challenge_timer");
}

customeogsummary() {
  var_0 = int(min(level.challenge_end_time - level.challenge_start_time, 86400000));
  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in level.players) {
    var_4.so_eog_summary_data["damaged"] = var_4.num_times_damaged;
    var_5 = max(1, float(var_4.stats["shots_fired"]));
    var_6 = max(1, float(var_4.stats["shots_hit"]));
    var_7 = var_6 / var_5;
    var_8 = int(var_7 * 100);
    var_4.so_eog_summary_data["accuracy"] = var_8;
    var_1 = var_1 + var_7;
    var_2 = var_2 + var_4.so_eog_summary_data["damaged"];
  }

  var_10 = int(level.specops_reward_gameskill * 10000);
  level.session_score = var_10;
  var_11 = 20000;
  var_12 = level.challenge_time_limit * 1000;
  var_13 = max(0, var_0 - var_11);
  var_14 = 0;

  if(var_0 < var_12) {
    var_14 = int((var_12 - var_13) / var_12 * 5000);
  }
  level.session_score = level.session_score + var_14;
  var_15 = 25 * level.players[0].so_eog_summary_data["kills"];

  if(maps\_utility::is_coop()) {
    var_15 = var_15 + 25 * maps\_utility::get_other_player(level.players[0]).so_eog_summary_data["kills"];
  }
  level.session_score = level.session_score + var_15;
  var_16 = var_1 / level.players.size;
  var_17 = 2000 - level._id_0126 * 25;
  var_18 = int(var_17 * var_16);
  level.session_score = level.session_score + var_18;
  var_19 = var_2 / level.players.size;
  var_20 = min(100 * var_19, 3000);
  var_21 = int(3000 - var_20);
  level.session_score = level.session_score + var_21;

  foreach(var_4 in level.players) {}
  var_4 maps\_specialops::override_summary_score(level.session_score);

  var_24[0] = "@MENU_RECRUIT";
  var_24[1] = "@MENU_REGULAR";
  var_24[2] = "@MENU_HARDENED";
  var_24[3] = "@MENU_VETERAN";
  var_25 = undefined;
  var_26 = undefined;
  var_27 = undefined;
  var_28 = undefined;

  if(maps\_utility::is_coop()) {
    var_25 = "@SPECIAL_OPS_UI_TEAM_SCORE";
    var_26 = "@SPECIAL_OPS_PERFORMANCE_YOU";
    var_27 = "@SPECIAL_OPS_PERFORMANCE_PARTNER";
    var_28 = "@SPECIAL_OPS_POINTS";
  } else {
    var_25 = "@SPECIAL_OPS_UI_SCORE";
    var_26 = "";
    var_27 = "@SPECIAL_OPS_POINTS";
  }

  maps\_utility::clear_custom_eog_summary();

  foreach(var_4 in level.players) {
    var_30 = var_4.so_eog_summary_data["accuracy"];
    var_31 = var_4.so_eog_summary_data["damaged"];
    var_32 = var_4.so_eog_summary_data["time"] * 0.001;
    var_33 = maps\_utility::convert_to_time_string(var_32, 1);
    var_34 = var_24[var_4.so_eog_summary_data["difficulty"]];
    var_35 = var_4.so_eog_summary_data["score"];
    var_36 = var_4.so_eog_summary_data["kills"];

    if(maps\_utility::is_coop()) {
      var_37 = maps\_utility::get_other_player(var_4).so_eog_summary_data["accuracy"];
      var_38 = maps\_utility::get_other_player(var_4).so_eog_summary_data["damaged"];
      var_39 = var_24[maps\_utility::get_other_player(var_4).so_eog_summary_data["difficulty"]];
      var_40 = maps\_utility::get_other_player(var_4).so_eog_summary_data["kills"];

      if(!level.missionfailed) {
        var_4 maps\_utility::add_custom_eog_summary_line("", var_26, var_27, var_28, 1);
        var_4 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_DIFFICULTY", var_34, var_39, var_10, 2);
        var_4 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_TIME", var_33, var_33, var_14, 3);
        var_4 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_KILLS", var_36, var_40, var_15, 4);
        var_4 maps\_utility::add_custom_eog_summary_line("@SO_MILEHIGH_HIJACK_ACCURACY", var_30 + "%", var_37 + "%", var_18, 5);
        var_4 maps\_utility::add_custom_eog_summary_line("@SO_MILEHIGH_HIJACK_DAMAGED", var_31, var_38, var_21, 6);

        if(!issplitscreen()) {
          var_4 maps\_utility::add_custom_eog_summary_line_blank();
        }
        var_4 maps\_utility::add_custom_eog_summary_line(var_25, var_35, undefined, undefined);
      } else {
        var_4 maps\_utility::add_custom_eog_summary_line("", var_26, var_27, undefined, 1);
        var_4 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_DIFFICULTY", var_34, var_39, undefined, 2);
        var_4 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_TIME", var_33, var_33, undefined, 3);
        var_4 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_KILLS", var_36, var_40, undefined, 4);
      }

      continue;
    }

    if(!level.missionfailed) {
      var_4 maps\_utility::add_custom_eog_summary_line("", var_26, var_27, var_28, 1);
      var_4 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_DIFFICULTY", var_34, var_10, undefined, 2);
      var_4 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_TIME", var_33, var_14, undefined, 3);
      var_4 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_KILLS", var_36, var_15, undefined, 4);
      var_4 maps\_utility::add_custom_eog_summary_line("@SO_MILEHIGH_HIJACK_ACCURACY", var_30 + "%", var_18, undefined, 5);
      var_4 maps\_utility::add_custom_eog_summary_line("@SO_MILEHIGH_HIJACK_DAMAGED", var_31, var_21, undefined, 6);

      if(!issplitscreen()) {
        var_4 maps\_utility::add_custom_eog_summary_line_blank();
      }
      var_4 maps\_utility::add_custom_eog_summary_line(var_25, var_35, undefined, undefined);
      continue;
    }

    var_4 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_DIFFICULTY", var_34, undefined, undefined, 1);
    var_4 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_TIME", var_33, undefined, undefined, 2);
    var_4 maps\_utility::add_custom_eog_summary_line("@SPECIAL_OPS_UI_KILLS", var_36, undefined, undefined, 3);
  }

  if(!level.missionfailed) {
    setDvar("ui_hide_hint", 1);
  } else {
    setDvar("ui_hide_hint", 0);
  }
}

setupenemies() {
  addspawnfunctionbyname("so_conference_room_hall", ::enemycounterbreach);
  addspawnfunctionbyname("so_conference_room_hall", ::enemymustkilltocapture);
  addspawnfunctionbyname("so_conference_room_hall_flash_bang", ::enemymustkilltocapture);
  addspawnfunctionbyname("lower_floor_first_terrorists", ::enemybasicsetup);
  addspawnfunctionbyname("lower_floor_second_terrorists", ::enemybasicsetup);
  addspawnfunctionbyname("lower_floor_terrorists", ::enemybasicsetup);
  addspawnfunctionbyname("so_upper_floor_stairs", ::enemybasicsetup);
  addspawnfunctionbyname("so_last_hallway_rush", ::enemybasicsetup);
  addspawnfunctionbyname("so_upper_floor_hall", ::enemybasicsetup);
  addspawnfunctionbyname("so_conference_room_hall", ::enemybasicsetup);
  addspawnfunctionbyname("breach_enemy_spawner", ::enemybasicsetup);
  level thread disablerandomgrenadedeath();
}

disablerandomgrenadedeath() {
  while(!isDefined(anim.numdeathsuntilcornergrenadedeath)) {
    wait 1;
    continue;
  }

  anim.numdeathsuntilcornergrenadedeath = 999999;
}

spawnenemies() {
  level endon("special_op_terminated");
  common_scripts\utility::flag_wait("lower_floor_first_terrorists");

  if(_id_011A()) {
    wait 1;
  }
  spawnenemiesbyname("lower_floor_first_terrorists");
  common_scripts\utility::flag_wait("lower_floor_second_terrorists");
  spawnenemiesbyname("lower_floor_second_terrorists");
  common_scripts\utility::flag_wait("lower_floor_third_terrorists");
  spawnenemiesbyname("lower_floor_third_terrorists");
  common_scripts\utility::flag_wait("lower_floor_terrorists");
  spawnenemiesbyname("lower_floor_terrorists");
  common_scripts\utility::flag_wait("so_upper_floor_stairs");
  spawnenemiesbyname("so_upper_floor_stairs");
  common_scripts\utility::flag_wait("so_last_hallway_rush");
  spawnenemiesbyname("so_last_hallway_rush");
  common_scripts\utility::flag_wait("so_upper_floor_rumble");
  spawnenemiesbyname("so_upper_floor_hall");
  common_scripts\utility::flag_wait("so_conference_room_hall");

  if(_id_011A()) {
    wait 4;
  }
  spawnenemiesbyname("so_conference_room_hall");
}

spawnenemiesbyname(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  if(var_1.size == 0) {
    return;
  }
  return maps\_utility::array_spawn(var_1, 1, 0);
}

addspawnfunctionbyname(var_0, var_1) {
  var_2 = getEntArray(var_0, "targetname");

  if(var_2.size == 0) {
    return;
  }
  maps\_utility::array_spawn_function(var_2, var_1);
}

enemybasicsetup() {
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "so_president") {
    return;
  }
  self.baseaccuracy = level.new_enemy_accuracy;
  self.grenadeammo = 0;
  self.disablereactionanims = 1;
  level.milehigh_num_enemies++;
}

enemycounterbreach() {
  level endon("special_op_terminated");
  self endon("death");
  maps\_utility::setflashbangimmunity(1);
  level common_scripts\utility::waittill_either("so_counter_breach_flash_activated", "flashbang_guy_killed");
  wait 1;
  maps\_utility::setflashbangimmunity(0);
}

lowerplanerumble() {
  level endon("special_op_terminated");
  common_scripts\utility::flag_wait("so_lower_floor_rumble");
  wait 2;
  common_scripts\utility::flag_set("stop_rocking");
  common_scripts\utility::flag_set("stop_constant_shake");
  maps\_audio::aud_send_msg("jet_roll_v01");
  maps\_audio::aud_send_msg("turbine_wind_a");
  earthquake(0.3, 5.5, level.player.origin, 80000);
  level.planerumbleactive = 1;
  var_0 = (7, 90, 0);
  slideplayers(var_0);
  thread animateplanetiltview();
  thread maps\hijack_airplane::enemies_stumble();
  wait 0.2;
  thread throwdiningroomitems();
  wait 1;
  stopslidingplayers();
  wait 1;
  thread putrollersbacktozero();
  wait 1;
  level.planerumbleactive = 0;
  common_scripts\utility::flag_clear("stop_constant_shake");
  thread maps\hijack_airplane::constant_rumble();
}

slideplayers(var_0) {
  level.custom_linkto_slide = 1;
  var_1 = anglesToForward(var_0);

  foreach(var_3 in level.players) {
    var_3 playRumbleOnEntity("hijack_plane_large");
    var_3 viewkick(127, var_3.origin + (0, 0, -220));
    var_3 setvelocity(var_1 * 110);
    var_3 playerplaycoopslideanim(var_1);
    var_3 maps\hijack_code::hjk_beginsliding();
  }
}

stopslidingplayers() {
  foreach(var_1 in level.players) {}
  var_1 maps\hijack_code::hjk_endsliding();
}

animateplanetiltview() {
  level endon("special_op_terminated");
  common_scripts\utility::flag_set("stop_rocking");
  maps\_audio::aud_send_msg("hallway_lurch", 0);
  var_0 = maps\_utility::spawn_anim_model("upperhall_roller", level.player.origin);
  var_0.angles = (0, 0, 0);
  var_0 maps\_anim::anim_first_frame_solo(var_0, "hallway_lurchcam");
  var_1 = [];
  var_2 = 0;

  foreach(var_4 in level.players) {
    var_1[var_2] = spawn("script_origin", var_4.origin);
    var_1[var_2].angles = (0, 0, 0);
    var_4 playersetgroundreferenceent(var_1[var_2]);
    var_1[var_2] linkTo(var_0, "J_prop_1");
    var_2++;
  }

  var_0 thread maps\_anim::anim_single_solo(var_0, "hallway_lurchcam");
  var_0 waittillmatch("single anim", "corpse_slump");
  thread maps\hijack_airplane::hallway_sun();
  common_scripts\utility::array_thread(level.arollers, maps\hijack_airplane::hallway_view_roll_obj);
  var_0 waittillmatch("single anim", "end");

  foreach(var_4 in level.players) {}
  var_4 playersetgroundreferenceent(level.org_view_roll);

  maps\_utility::array_delete(var_1);
  var_0 delete();
}

throwdiningroomitems() {
  var_0 = getEntArray("lower_level_room_1_objects", "targetname");

  foreach(var_2 in var_0) {}
  var_2 thread maps\hijack_code::launch_object(randomintrange(200, 240), (0, 1, 0));

  var_4 = getEntArray("bar_room_physics", "targetname");

  foreach(var_2 in var_4) {}
  var_2 thread maps\hijack_code::start_phys_explosion_on_delay(64, 64, 0.65);
}

putrollersbacktozero() {
  common_scripts\utility::array_thread(level.arollers, maps\hijack_code::rotate_rollers_to, (0, 0, 0), 1, 0, 0);
}

upperplanerumble() {
  level endon("special_op_terminated");
  common_scripts\utility::flag_wait("so_upper_floor_rumble");
  wait 0.7;
  common_scripts\utility::flag_set("stop_rocking");
  common_scripts\utility::flag_set("stop_constant_shake");
  earthquake(0.3, 5.5, level.player.origin, 80000);
  level.planerumbleactive = 1;
  var_0 = (0, 90, 0);
  slideplayers(var_0);
  thread animateplanetiltview();
  thread maps\hijack_airplane::hallway_props();
  maps\_audio::aud_send_msg("hallway_lurch", 0);
  thread maps\hijack_airplane::enemies_stumble();
  wait 1.2;
  stopslidingplayers();
  wait 1;
  thread putrollersbacktozero();
  wait 1;
  level.planerumbleactive = 0;
  common_scripts\utility::flag_clear("stop_constant_shake");
  thread maps\hijack_airplane::constant_rumble();
}

setupdoors() {
  level endon("special_op_terminated");
  level.intro_origin = common_scripts\utility::getStruct("pres_room_struct", "targetname");
  level thread maps\hijack_airplane::intro_doors();
  var_0 = getEnt("intro_door0", "targetname");
  var_0 movey(-51, 0.05);
  var_1 = getEnt("storage_door1", "targetname");
  var_1 movey(49, 1, 0, 0.25);
  level.door2 unlink();
  level.door2 movey(50, 1, 0, 0.25);
  var_2 = getEntArray("so_tactical_door", "targetname");

  foreach(var_4 in var_2) {
    var_4 hide();
    var_4 notsolid();
    var_4 connectpaths();
  }
}

startdebate() {
  var_0 = 1231.0;
  var_1 = var_0 / 1609;
  var_2 = var_0 / 1560;
  var_3 = var_0 / 1531;
  var_4 = var_3;
  maps\_utility::array_spawn_function_noteworthy("so_commander", ::enemymustkilltocapture);
  maps\_utility::array_spawn_function_noteworthy("so_hero_agent_01", ::enemymustkilltocapture);
  maps\_utility::array_spawn_function_noteworthy("so_intro_agent2", ::enemymustkilltocapture);
  maps\_utility::array_spawn_function_noteworthy("so_intro_agent1", ::enemymustkilltocapture);
  maps\_utility::array_spawn_function_noteworthy("so_president", ::enemypostspawndebate, "president", "debate", var_1, undefined);
  maps\_utility::array_spawn_function_noteworthy("so_commander", ::enemypostspawndebate, "so_commander", "debate", 0, undefined);
  maps\_utility::array_spawn_function_noteworthy("so_advisor", ::enemypostspawndebate, "so_advisor", "debate", 0, undefined);
  maps\_utility::array_spawn_function_noteworthy("so_hero_agent_01", ::enemypostspawndebate, "so_hero_agent", "debate", 0, undefined);
  maps\_utility::array_spawn_function_noteworthy("so_secretary", ::enemypostspawndebate, "secretary", "debate", var_2, undefined);
  maps\_utility::array_spawn_function_noteworthy("so_polit_1", ::enemypostspawndebate, "polit_1", "debate", var_3, undefined);
  maps\_utility::array_spawn_function_noteworthy("so_polit_2", ::enemypostspawndebate, "polit_2", "debate", var_4, undefined);
  maps\_utility::array_spawn_function_noteworthy("so_intro_agent2", ::enemypostspawndebate, "so_agent2", "debate", 0, undefined);
  maps\_utility::array_spawn_function_noteworthy("so_intro_agent1", ::enemypostspawndebate);
  maps\_utility::array_spawn_function_noteworthy("so_president", ::presidentobjective);
  maps\_utility::array_spawn_function_noteworthy("so_president", ::presidentdeath);
  maps\_utility::array_spawn_function_noteworthy("so_polit_1", ::enemyremovegun);
  maps\_utility::array_spawn_function_noteworthy("so_polit_2", ::enemyremovegun);
  maps\_utility::array_spawn_function_noteworthy("so_secretary", ::enemyremovegun);
  maps\_utility::array_spawn_function_noteworthy("so_advisor", ::enemyremovegun);
  maps\_utility::array_spawn_function_noteworthy("so_commander", ::enemycounterbreach);
  maps\_utility::array_spawn_function_noteworthy("so_intro_agent2", ::enemycounterbreach);
  maps\_utility::array_spawn_function_noteworthy("so_intro_agent1", ::enemycounterbreach);
  maps\_utility::array_spawn_function_noteworthy("so_hero_agent_01", ::enemycounterbreach);
  maps\_utility::array_spawn_function_noteworthy("so_president", ::enemyplayendloopinganimation, "debate_cine_president_end_loop", "stop_pres_debate_loop");
  maps\_utility::array_spawn_function_noteworthy("so_advisor", ::enemyplayendloopinganimation, "debate_cine_advisor_end_loop", "stop_debate_advisor_loop");
  maps\_utility::array_spawn_function_noteworthy("so_secretary", ::enemydienoragdoll, "start_ragdoll");
  maps\_utility::array_spawn_function_noteworthy("so_polit_1", ::enemydienoragdoll, "start_ragdoll");
  maps\_utility::array_spawn_function_noteworthy("so_polit_2", ::enemydienoragdoll, "start_ragdoll");
  maps\_utility::array_spawn_function_noteworthy("so_advisor", ::advisorsetup);
  maps\_utility::array_spawn_function_noteworthy("so_commander", ::commandersetup);
  maps\_utility::array_spawn_function_targetname("breach_enemy_spawner", ::_id_0127);
  level.intro_origin = common_scripts\utility::getStruct("pres_room_struct", "targetname");
  chairsetup("chair1", "debate_chair1");
  chairsetup("chair2", "debate_chair2");
  chairsetup("chair3", "debate_chair3");
  chairsetup("chair4", "debate_chair4");
  chairsetup("chair5", "debate_chair5");
  chairsetup("chair6", "debate_chair6");
  chairsetup("chair8", "debate_chair8");
  chairdestroy();
  debateroomitemsduringbreach();
}

debateroomitemsduringbreach() {
  level endon("special_op_terminated");
  var_0 = getEntArray("conf_room_physics", "targetname");

  foreach(var_2 in var_0) {}
  physicsexplosionsphere(var_2.origin, 64, 32, 0.6);

  var_4 = getEntArray("conf_room_junk", "targetname");

  foreach(var_2 in var_4) {}
  var_2 thread maps\hijack_code::launch_object(randomintrange(120, 170), (0, -1, 0.05));

  thread maps\hijack_airplane::debate_paper_chaos();
  thread maps\hijack_airplane::debate_picture();
  common_scripts\utility::flag_wait("door_breach");
  var_7 = getEnt("tv_destructor", "targetname");
  var_8 = getEnt("tv_destructor2", "targetname");
  magicbullet("ak74u", var_7.origin, var_8.origin);
}

chairsetup(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");
  var_2.animname = "conf_chair";
  var_2 maps\_anim::setanimtree();
  level.intro_origin maps\_anim::anim_first_frame_solo(var_2, var_1);
  common_scripts\utility::waitframe();
  level.intro_origin thread maps\_anim::anim_single_solo(var_2, var_1);
  common_scripts\utility::waitframe();
  var_2 thread maps\_anim::anim_self_set_time(var_1, 1);
}

chairdestroy() {
  var_0 = getEnt("chair_destroy_top", "targetname");
  var_1 = getEnt("chair_destroy_base", "targetname");
  var_2 = maps\_utility::spawn_anim_model("destroy_chair");
  waittillframeend;
  level.intro_origin maps\_anim::anim_first_frame_solo(var_2, "debate_cine_end_chair");
  var_0 linkTo(var_2, "J_prop_1");
  var_1 linkTo(var_2, "J_prop_2");
  level.intro_origin thread maps\_anim::anim_single_solo(var_2, "debate_cine_end_chair");
  common_scripts\utility::waitframe();
  var_2 maps\_anim::anim_self_set_time("debate_cine_end_chair", 1);
  common_scripts\utility::waitframe();
  var_0 unlink();
  var_1 unlink();
  var_2 delete();
}

enemydienoragdoll(var_0) {
  self endon("death");
  self.noragdoll = 1;
  self.a.nodeath = 1;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.diequietly = 1;
  self.no_ai = 1;
  self.combatmode = "no_cover";
  self.deathanim = undefined;
  self waittillmatch("single anim", var_0);
  self invisiblenotsolid();
  self notify("stop_loop");
  self notify("single anim", "end");
  self notify("looping anim", "end");
  self kill();
}

advisorsetup() {
  level endon("special_op_terminated");
  self waittillmatch("single anim", "end");
  self.noragdoll = 1;
  self.a.nodeath = 1;
  self.allowdeath = 0;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.diequietly = 1;
  self.health = 10000;
  self.no_ai = 1;
  self.combatmode = "no_cover";
  self.deathanim = undefined;
  self waittill("damage", var_0, var_1, var_2, var_3, var_4);
  self invisiblenotsolid();
  level.intro_origin notify("stop_debate_advisor_loop");
  level.intro_origin maps\_anim::anim_single_solo(self, "couch_death");
  self.allowdeath = 1;
  self kill(self.origin, var_1);
}

commandersetup() {
  level endon("special_op_terminated");
  self endon("death");
  var_0 = self.weapon;
  self waittillmatch("single anim", "dropgun");
  common_scripts\utility::waitframe();
  animscripts\shared::placeweaponon(var_0, "right", 1);
}

enemyremovegun() {
  maps\_utility::gun_remove();
}

enemyplayendloopinganimation(var_0, var_1) {
  self waittillmatch("single anim", "end");
  level.intro_origin thread maps\_anim::anim_loop_solo(self, var_0, var_1);
}

enemymustkilltocapture() {
  self.combatmode = "no_cover";

  if(!isDefined(level.mustkilltocapture)) {
    level.mustkilltocapture = [];
  }
  level.mustkilltocapture[level.mustkilltocapture.size] = self;
}

enemypostspawndebate(var_0, var_1, var_2, var_3) {
  level endon("special_op_terminated");
  self.team = "axis";
  self.disablereactionanims = 1;

  if(!isDefined(var_0)) {
    return;
  }
  self.animname = var_0;
  level waittill("breach_enemy_anims");
  common_scripts\utility::waitframe();
  level.intro_origin thread anim_play_at_time(self, var_1, var_2, var_3);
  self notify("so_debate_anim_started");
}

anim_play_at_time(var_0, var_1, var_2, var_3) {
  thread maps\_anim::anim_single_solo(var_0, var_1, undefined, var_3);
  common_scripts\utility::waitframe();
  var_0 thread maps\_anim::anim_self_set_time(var_1, var_2);
}

presidentobjective() {
  level endon("special_op_terminated");
  level.so_president = self;
  common_scripts\utility::flag_set("so_president_spawned");

  while(!cancapturepresident()) {
    wait 0.1;
  }
  self setCursorHint("HINT_NOICON");
  self setHintString(&"SO_MILEHIGH_HIJACK_USE_PRESIDENT");
  self makeusable();
  self waittill("trigger");
  common_scripts\utility::flag_set("so_president_captured");
}

cancapturepresident() {
  if(isDefined(level.mustkilltocapture)) {
    var_0 = getEnt("near_president_vol", "targetname");

    foreach(var_2 in level.mustkilltocapture) {
      if(isalive(var_2) && !var_2 maps\_utility::doinglongdeath() && var_2 istouching(var_0)) {
        return 0;
      }
    }
  }

  return 1;
}

presidentdeath() {
  level endon("special_op_terminated");
  self waittill("death");
  level.challenge_end_time = gettime();
  level._id_0123 = 1;
  maps\_specialops::so_force_deadquote("@SO_MILEHIGH_HIJACK_PRESIDENT_KILLED");
  maps\_utility::missionfailedwrapper();
}

setupcounterbreach() {
  level endon("special_op_terminated");
  level endon("flashbang_guy_killed");
  var_0 = common_scripts\utility::getStruct("so_flash_grenade_start", "targetname");
  var_1 = common_scripts\utility::getStruct("so_flash_grenade_end", "targetname");
  common_scripts\utility::flag_wait("so_counter_breach");
  level thread spawnflashbangenemy();
  common_scripts\utility::flag_set("so_conference_room_hall");
  level.door3 unlink();
  level.door3 movey(-50, 0.5, 0, 0.1);
  wait 0.4;
  var_2 = magicgrenade("flash_grenade", var_0.origin, var_1.origin, 1);
  level notify("flashbang_out");

  while(isDefined(var_2)) {
    common_scripts\utility::waitframe();
  }
  level notify("so_counter_breach_flash_activated");
}

spawnflashbangenemy() {
  level endon("flashbang_out");
  var_0 = getEnt("so_conference_room_hall_flash_bang", "targetname");
  var_1 = var_0 maps\_utility::spawn_ai(1, 0);
  var_1.animname = "so_flashbang_enemy";
  level.intro_origin maps\_anim::anim_single_solo(var_1, "so_milehigh_breach_flashbang_toss");
  var_2 = common_scripts\utility::getStruct("so_flashbang_guy_goal", "targetname");
  var_1 setgoalpos(var_2.origin);
  var_1 waittill("death");
  level notify("flashbang_guy_killed");
}

setupendcleanup() {
  level waittill("special_op_terminated");
  common_scripts\utility::flag_set("stop_constant_shake");
}

startambientvo() {
  level endon("special_op_terminated");
  level thread playlinesbehindconferencedoor();
  var_0 = getEnt("so_ambient_vo_hijackers_speaker", "targetname");
  common_scripts\utility::flag_wait("so_ambient_vo_hijackers");
  var_0 playSound("hijack_fso3_hijackerstaking");
}

playlinesbehindconferencedoor() {
  level endon("special_op_terminated");
  var_0 = getEnt("so_lines_behind_door", "targetname");
  level waittill("breaching_number_2");
  var_0 playSound("hijack_cmd_everyonedown", "conference_line_complete");
  var_0 waittill("conference_line_complete");
  var_0 playSound("hijack_cmd_allteams", "conference_line_complete");
  common_scripts\utility::flag_wait("so_begin_debate_breach");
  wait 1;
  var_0 stopsounds();
  common_scripts\utility::waitframe();
  var_0 delete();
}

_id_0127() {
  self.donotcleanup = 1;
}

_id_0128() {
  level endon("special_op_terminated");
  level waittill("breaching_number_2");
  wait 0.3;
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.donotcleanup) || !var_2.donotcleanup) {
      var_2 delete();
    }
  }
}

_id_0129() {
  level endon("special_op_terminated");
  level.slowmo_breach_disable_stancemod = 1;

  for(;;) {
    level waittill("breaching");

    foreach(var_1 in level.players) {
      var_1 enableinvulnerability();
      var_1 disableweaponswitch();
      var_1 disableoffhandweapons();
      var_1 allowcrouch(0);
      var_1 allowprone(0);
      var_1 allowsprint(0);
      var_1 allowjump(0);
    }

    level waittill("sp_slowmo_breachanim_done");

    foreach(var_1 in level.players) {
      var_1 disableinvulnerability();
      var_1 enableweaponswitch();
      var_1 allowcrouch(1);
      var_1 allowprone(1);
      var_1 allowsprint(1);
      var_1 allowjump(1);
    }

    common_scripts\utility::flag_waitopen("breaching_on");

    foreach(var_1 in level.players) {}
    var_1 enableoffhandweapons();
  }
}