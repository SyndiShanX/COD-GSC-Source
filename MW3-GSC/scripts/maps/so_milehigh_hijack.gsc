/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_milehigh_hijack.gsc
***********************************************/

main() {
  _id_5B4D();
  _id_5B4C();
  _id_011C();
  _id_562F();
  maps\_load::main();
  maps\so_milehigh_hijack_slowmo_killswitch::init();
  level thread _id_5B93();
  level thread _id_0128();
  level thread _id_0129();

  if(_id_011A()) {
    var_0 = getEntArray("so_commander", "script_noteworthy");

    foreach(var_2 in var_0) {}
    var_2.count = 0;
  }

  _id_5B66();
  _id_5B4E();
  _id_5B70();
  _id_5B4F();
  level thread _id_5B51();
  level thread _id_5B52();
  level thread _id_5B6A();
  level thread _id_5B6D();
  level thread _id_5B72();
  level thread _id_5B77();
  level thread _id_5B7D();
  level thread _id_5B7E();
  level thread _id_5B7F();
  level thread _id_5B8F();
  level thread _id_5B91();
  level thread watchplayeroverlap();
}

_id_562F() {
  foreach(var_2, var_1 in level.createfxent) {
    if(attachpath(var_1)) {
      level.createfxent[var_2] = undefined;
      var_1.v = undefined;
      continue;
    }

    var_1._id_1693 = 1;
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
  return isDefined(level._id_019F) && level._id_019F;
}

watchplayeroverlap() {
  level.planerumbleactive = 0;

  if(!maps\_utility::_id_12C1()) {
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

_id_5B4C() {
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
  _id_5B61();
  maps\hijack::_id_56FB();
  maps\hijack::_id_5A62();
  maps\hijack::_id_5A64();
  maps\hijack_precache::main();
  _id_02A4::main();
}

_id_011B() {
  level._id_11BB["so_milehigh_fail_cowards"] = "so_milehigh_fail_cowards";
  level._id_11BB["so_milehigh_fail_no_defeat"] = "so_milehigh_fail_no_defeat";
  level._id_11BB["so_milehigh_fail_been_defeated"] = "so_milehigh_fail_been_defeated";
  level._id_11BB["so_milehigh_fail_next_fight"] = "so_milehigh_fail_next_fight";
  level._id_11BB["so_milehigh_fail_happen_again"] = "so_milehigh_fail_happen_again";
  level._id_11BB["so_milehigh_fail_objective"] = "so_milehigh_fail_objective";
  level._id_11BB["so_milehigh_win_served_well"] = "so_milehigh_win_served_well";
  level._id_11BB["so_milehigh_win_victory"] = "so_milehigh_win_victory";
  level._id_11BB["so_milehigh_win_enemy_defeated"] = "so_milehigh_win_enemy_defeated";
  level._id_11BB["so_milehigh_win_well_done"] = "so_milehigh_win_well_done";
  level._id_11BB["so_milehigh_win_victorious"] = "so_milehigh_win_victorious";
  level._id_11BB["so_milehigh_win_victory_ours"] = "so_milehigh_win_victory_ours";
  level._id_11BB["so_milehigh_win_jerk"] = "so_milehigh_win_jerk";
  level._id_11BB["so_milehigh_time_hurry"] = "so_milehigh_time_hurry";
  level._id_11BB["so_milehigh_time_generic"] = "so_milehigh_time_generic";
  level._id_11BB["so_milehigh_start_capture"] = "so_milehigh_start_capture";
  level._id_11BB["so_milehigh_start_defeat"] = "so_milehigh_start_defeat";
  level._id_11BB["so_milehigh_start_finish"] = "so_milehigh_start_finish";
}

_id_011C() {
  level._id_01E0 = [];
  level._id_01E0["ready_up"] = ::_id_011E;
  level._id_01E0["success_best"] = ::_id_0125;
  level._id_01E0["success_generic"] = ::_id_0125;
  level._id_01E0["failed_generic"] = ::_id_0121;
  level._id_01E0["failed_time"] = ::_id_0124;
  level._id_01E0["failed_bleedout"] = ::_id_0121;
  level._id_01E0["time_low_normal"] = ::_id_011F;
  level._id_01E0["time_low_hurry"] = ::_id_0120;
  level._id_01E0["killing_civilians"] = ::_id_011D;
  level._id_01E0["progress_goal_status"] = ::_id_011D;
  level._id_01E0["time_status_late"] = ::_id_011D;
  level._id_01E0["time_status_good"] = ::_id_011D;
  level._id_01E0["progress"] = ::_id_011D;
}

_id_011D(var_0) {}

_id_011E() {
  maps\_specialops_code::_id_1873("so_milehigh_start_finish", 0, 1);
}

_id_011F() {
  maps\_specialops_code::_id_1873("so_milehigh_time_generic");
}

_id_0120() {
  maps\_specialops_code::_id_1873("so_milehigh_time_hurry");
}

_id_0121() {
  if(isDefined(level._id_0122) && level._id_0122) {
    return;
  }
  if(isDefined(level._id_0123) && level._id_0123) {
    maps\_specialops_code::_id_1873("so_milehigh_fail_objective");
    return;
  }

  var_0 = randomint(4);

  switch (var_0) {
    case 0:
      maps\_specialops_code::_id_1873("so_milehigh_fail_no_defeat");
      break;
    case 1:
      maps\_specialops_code::_id_1873("so_milehigh_fail_been_defeated");
      break;
    case 2:
      maps\_specialops_code::_id_1873("so_milehigh_fail_next_fight");
      break;
    case 3:
      maps\_specialops_code::_id_1873("so_milehigh_fail_happen_again");
      break;
  }
}

_id_0124() {
  level._id_0122 = 1;
  maps\_specialops_code::_id_1873("so_milehigh_fail_cowards");
}

_id_0125(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;

    if(level.gameskill >= 3) {
      if(maps\_specialops::_id_186E()) {
        var_0 = common_scripts\utility::cointoss();
      }
    }
  }

  if(var_0) {
    maps\_specialops_code::_id_1873("so_milehigh_win_jerk", 0.5, 1);
  } else {
    var_1 = randomint(6);

    switch (var_1) {
      case 0:
        maps\_specialops_code::_id_1873("so_milehigh_win_served_well", 0.5, 1);
        break;
      case 1:
        maps\_specialops_code::_id_1873("so_milehigh_win_victory", 0.5, 1);
        break;
      case 2:
        maps\_specialops_code::_id_1873("so_milehigh_win_enemy_defeated", 0.5, 1);
        break;
      case 3:
        maps\_specialops_code::_id_1873("so_milehigh_win_well_done", 0.5, 1);
        break;
      case 4:
        maps\_specialops_code::_id_1873("so_milehigh_win_victorious", 0.5, 1);
        break;
      case 5:
        maps\_specialops_code::_id_1873("so_milehigh_win_victory_ours", 0.5, 1);
        break;
    }
  }
}

_id_5B4D() {
  var_0 = getEntArray();

  foreach(var_2 in var_0) {
    if(!issubstr(var_2.classname, "trigger")) {
      continue;
    }
    if(!isDefined(var_2._id_1766) && !isDefined(var_2._id_1767) && !isDefined(var_2.ambient) && (isDefined(var_2._id_176E) || isDefined(var_2._id_1771) || isDefined(var_2._id_176F) || isDefined(var_2._id_1769) || isDefined(var_2._id_176A) || isDefined(var_2._id_176B) || isDefined(var_2._id_176C))) {
      var_2 delete();
    }
  }

  var_4 = getent("hijack_crash_model_exterior", "script_noteworthy");
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

_id_5B4E() {
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
  maps\_utility::_id_265A("axis");
  maps\_utility::_id_265A("allies");
  thread maps\_utility::set_vision_set("hijack_airplane", 1);
  level._id_5A65 = getent("player_debate_trigger", "script_noteworthy");
  level._id_5A65 common_scripts\utility::trigger_off();

  if(getdvar("airmasks") == "") {
    setdvar("airmasks", "1");

  }
  level.player setweaponammostock("fnfiveseven", 60);
  level._id_5A68 = getdvar("phys_gravity");
  level._id_5A69 = getdvar("phys_gravity_ragdoll");
  level._id_5A6A = getdvar("phys_gravityChangeWakeupRadius");
  level._id_5A6B = getdvar("ragdoll_max_life");
  level._id_5A6C = (-14, 114, 0);
  level._id_5960 = getent("org_view_roll", "targetname");
  level.player playersetgroundreferenceent(level._id_5960);
  level._id_5961 = [];
  level._id_5961 = maps\_utility::_id_0BC3(level._id_5961, level._id_5960);
  level._id_5A6D = getEntArray("conf_light_off", "targetname");
  common_scripts\utility::array_call(level._id_5A6D, ::hide);
  var_0 = getEntArray("airmask", "targetname");
  common_scripts\utility::array_thread(var_0, maps\hijack_code::_id_5969);
  level._id_5A6E = getEntArray("seatbelt_signs", "targetname");
  common_scripts\utility::array_call(level._id_5A6E, ::hide);
  level._id_5976 = getEntArray("hijack_crash_plane_model", "targetname");
  thread maps\hijack::_id_5A77();
  thread maps\hijack::_id_5A75();
  thread maps\hijack::_id_5A7A();
  thread maps\hijack::_id_5A76();
  thread maps\hijack::_id_5A6F();
  thread maps\hijack::_id_5A70();
  thread maps\hijack::_id_5A72();
  thread maps\hijack::_id_5A73();
  thread maps\hijack::_id_5A74();
}

_id_5B4F() {
  _id_4D78::_id_4CBC();
  _id_4D78::_id_4D36(::_id_5B5E);
  maps\_anim::_id_1264("active_breacher_rig", "slowmo", ::_id_5B5D);
  level thread maps\hijack::_id_5A8F();
  level thread maps\hijack_crash_fx::_id_597F();
  level thread maps\hijack::_id_5A17();
  level thread maps\hijack::_id_5A91();
  maps\_compass::setupminimap("compass_map_hijack_airplane", "airplane_upper_minimap_corner");
  setsaveddvar("compassmaxrange", 1500);
  level thread _id_5B50();
}

_id_5B50() {
  level endon("special_op_terminated");
  var_0 = getent("glass_blocking_clip", "targetname");
  level waittill("slowmo_breach_ending");
  wait 2;
  var_0 delete();
}

_id_5B51() {
  level endon("special_op_terminated");
  var_0 = getent("so_first_breach_trigger", "targetname");
  var_0 sethintstring("");
  _id_5B5C();
  var_0 notify("trigger", level.players[0]);
  level notify("so_players_ready");

  foreach(var_2 in level.players) {}
  var_2 freezecontrols(0);
}

_id_5B52() {
  foreach(var_1 in level.players) {
    var_1 playersetgroundreferenceent(level._id_5960);
    var_1 freezecontrols(1);
    var_1 thread _id_5B53();
    var_1 thread _id_5B58();
    var_1 thread _id_5B55();
  }
}

_id_5B53() {
  level endon("special_op_terminated");
  self._id_5B54 = 0;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);
    self._id_5B54++;
    self notify("milehigh_damage");
  }
}

_id_5B55() {
  level endon("special_op_terminated");
  var_0 = maps\_specialops::_id_185B();
  self._id_5B56 = maps\_specialops::_id_16B6(4, var_0, &"SO_MILEHIGH_HIJACK_ACCURACY_HUD", self);
  self._id_5B57 = maps\_specialops::_id_16B6(4, var_0, &"SO_MILEHIGH_HIJACK_ACCURACY_HUD_PERCENT", self);
  self._id_5B57.alignx = "left";
  thread maps\_specialops::_id_1866(self._id_5B56);
  thread maps\_specialops::_id_1866(self._id_5B57);
  var_1 = 100;

  for(;;) {
    var_2 = max(1, float(self.stats["shots_fired"]));
    var_3 = max(1, float(self.stats["shots_hit"]));
    var_1 = var_3 / var_2;
    var_1 = int(var_1 * 100);
    self._id_5B57 setvalue(var_1);
    wait 0.1;
  }
}

_id_5B58() {
  level endon("special_op_terminated");
  var_0 = maps\_specialops::_id_185B();
  self._id_5B59 = maps\_specialops::_id_16B6(3, var_0, &"SO_MILEHIGH_HIJACK_DAMAGED_HUD", self);
  self._id_5B5A = maps\_specialops::_id_16B6(3, var_0, undefined, self);
  self._id_5B5A settext(0);
  self._id_5B5A.alignx = "left";
  thread maps\_specialops::_id_1866(self._id_5B59);
  thread maps\_specialops::_id_1866(self._id_5B5A);
  thread _id_5B5B();

  for(;;) {
    self waittill("milehigh_damage");
    self._id_5B5A settext(self._id_5B54);
  }
}

_id_5B5B() {
  level endon("special_op_terminated");
  var_0 = int(15.0);
  var_1 = int(30.0);
  self._id_5B5A maps\_specialops::_id_16AE();
  self._id_5B59 maps\_specialops::_id_16AE();
  var_2 = "green";

  for(;;) {
    if(self._id_5B54 >= var_1) {
      self._id_5B5A maps\_specialops::_id_16AC();
      self._id_5B59 maps\_specialops::_id_16AC();
      break;
    } else if(var_2 != "yellow" && self._id_5B54 >= var_0) {
      self._id_5B5A maps\_specialops::_id_185F();
      self._id_5B59 maps\_specialops::_id_185F();
      var_2 = "yellow";
    }

    wait 0.1;
  }
}

_id_5B5C() {
  level endon("special_op_terminated");
  var_0 = 1;

  while(var_0) {
    if(level.players[0] isswitchingweapon() || level.players[0] _id_4D78::_id_4D66()) {
      common_scripts\utility::waitframe();
      continue;
    }

    if(level.players.size == 2 && (level.players[1] isswitchingweapon() || level.players[0] _id_4D78::_id_4D66())) {
      common_scripts\utility::waitframe();
      continue;
    }

    var_0 = 0;
  }
}

_id_5B5D(var_0) {
  setsaveddvar("bullet_penetration_damage", 1);
}

_id_5B5E(var_0) {
  level endon("special_op_terminated");

  if(!common_scripts\utility::flag("so_player_upstairs")) {
    common_scripts\utility::flag_set("lower_floor_first_terrorists");
    common_scripts\utility::flag_set("so_milehigh_hijack_start");
    maps\_audio::aud_send_msg("start_lower_level_combat");
    level thread _id_5B60();
    level waittill("slowmo_breach_ending", var_1);
    level._id_4BC4 = 2.5;
  } else {
    common_scripts\utility::flag_set("so_begin_debate_breach");
    common_scripts\utility::flag_set("door_breach");
    level._id_5AB8 delete();
    level waittill("slowmo_breach_ending", var_1);
    common_scripts\utility::flag_set("so_counter_breach");
  }

  var_2 = getaiarray();

  foreach(var_4 in var_2) {
    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "so_president") {
      continue;
    }
    if(var_4._id_20AF != 5000) {
      continue;
    }
    var_4.health = 150;
    var_4._id_20AF = level._id_5B5F;
  }
}

#using_animtree("animated_props");

_id_5B60() {
  level endon("special_op_terminated");

  foreach(var_1 in level._id_5976) {
    var_1._id_1032 = "generic";
    var_1 useanimtree(#animtree);
  }

  var_3 = getent("hijack_crash_model_front_interior", "script_noteworthy");
  maps\_audio::aud_send_msg("pre_crash_door");
  var_3 thread maps\_anim::_id_1246(var_3, "hijack_pre_plane_crash_door");
  var_4 = getent("crash_door_blocker", "targetname");
  var_4 delete();
  common_scripts\utility::waitframe();
  var_3 thread maps\_anim::_id_1280("hijack_pre_plane_crash_door", 0.99);
}

_id_5B61() {
  _id_5B62();
  _id_5B63();
}

#using_animtree("generic_human");

_id_5B62() {
  level._id_0C59["generic"]["payback_breach_react_soldier_4"] = % payback_breach_react_soldier_4;
  level._id_0C59["generic"]["payback_breach_crateguy"] = % payback_breach_crateguy;
  level._id_0C59["generic"]["payback_breach_doorguy"] = % payback_breach_doorguy;
  level._id_0C59["generic"]["ny_harbor_bulkhead_door_breach_stunned_guy1"] = % ny_harbor_bulkhead_door_breach_stunned_guy1;
  level._id_0C59["generic"]["ny_harbor_bulkhead_door_breach_stunned_guy2"] = % ny_harbor_bulkhead_door_breach_stunned_guy2;
  level._id_0C59["so_advisor"]["debate"] = % so_milehigh_breach_reaction_advisor_start;
  level._id_0C59["so_advisor"]["debate_cine_advisor_end_loop"][0] = % so_milehigh_breach_reaction_advisor_loop;
  level._id_0C59["so_agent2"]["debate"] = % so_milehigh_breach_reaction_agent2;
  level._id_0C59["so_commander"]["debate"] = % so_milehigh_breach_reaction_commander;
  level._id_0C59["so_hero_agent"]["debate"] = % so_milehigh_breach_reaction_hero_agent;
  level._id_0C59["so_flashbang_enemy"]["so_milehigh_breach_flashbang_toss"] = % so_milehigh_breach_flashbang_toss;
  level._id_0C59["so_advisor"]["couch_death"] = % so_milehigh_breach_advisor_death;
}

#using_animtree("multiplayer");

_id_5B63() {
  level._id_1245["player_slide_stumble"] = #animtree;
  level._id_1F90["player_slide_stumble"] = "viewmodel_base_viewhands";
  level._id_0C59["player_slide_stumble"]["pb_stumble_forward"] = % pb_stumble_forward;
  level._id_0C59["player_slide_stumble"]["pb_stumble_back"] = % pb_stumble_back;
  level._id_0C59["player_slide_stumble"]["pb_stumble_left"] = % pb_stumble_left;
  level._id_0C59["player_slide_stumble"]["pb_stumble_right"] = % pb_stumble_right;
  level._id_0C59["player_slide_stumble"]["root"] = % code;
}

_id_5B64(var_0) {
  level endon("special_op_terminated");

  if(!maps\_utility::_id_12C1()) {
    return;
  } else if(self getstance() == "stand") {
    self allowcrouch(0);
    self allowprone(0);
  } else {
    self allowstand(0);
    self allowprone(0);
  }

  self allowjump(0);
  var_1 = vectornormalize(var_0);
  var_2 = vectornormalize(anglesToForward(self.angles));
  var_3 = vectordot(var_1, var_2);
  var_4 = acos(var_3);
  var_5 = undefined;

  if(var_4 < 45) {
    var_5 = "pb_stumble_forward";
  } else if(var_4 > 135) {
    var_5 = "pb_stumble_back";
  } else {
    var_6 = _id_5B65(var_2, var_1);

    if(var_6) {
      var_5 = "pb_stumble_left";
    } else {
      var_5 = "pb_stumble_right";
    }
  }

  self._id_1032 = "player_slide_stumble";
  thread maps\_anim::_id_1246(self, var_5);
  common_scripts\utility::waitframe();
  self allowcrouch(1);
  self allowstand(1);
  self allowprone(1);
  self allowjump(1);
}

_id_5B65(var_0, var_1) {
  return var_0[0] * var_1[1] - var_0[1] * var_1[0] > 0;
}

_id_5B66() {
  maps\hijack_code::_id_5972();

  switch (level.gameskill) {
    case 1:
    case 0:
      _id_5B67();
      break;
    case 2:
      _id_5B68();
      break;
    case 3:
      _id_5B69();
      break;
  }

  if(maps\_utility::_id_12C1()) {
    level._id_0126 = 38;
  }
}

_id_5B67() {
  level._id_16C3 = 210;
  level._id_5B5F = 1;
  level._id_0126 = 26;
}

_id_5B68() {
  level._id_16C3 = 145;
  level._id_5B5F = 1;
  level._id_0126 = 31;
}

_id_5B69() {
  level._id_16C3 = 110;
  level._id_5B5F = 1;
  level._id_0126 = 36;
}

_id_5B6A() {
  level endon("special_op_terminated");
  var_0 = common_scripts\utility::getstruct("so_upstairs", "targetname");
  var_1 = common_scripts\utility::getstruct("so_obj_find_president", "targetname");
  objective_add(1, "current", &"SO_MILEHIGH_HIJACK_OBJECTIVE_FIND");
  objective_setpointertextoverride(1, "");
  objective_position(1, var_0.origin);
  common_scripts\utility::flag_wait("so_player_upstairs");
  objective_position(1, var_1.origin);
  common_scripts\utility::flag_wait("so_obj_find_president");
  maps\_utility::_id_2727(1);
  objective_add(2, "current", &"SO_MILEHIGH_HIJACK_OBJECTIVE_CAPTURE");
  _id_4D78::_id_4CDD(2, 2);
  common_scripts\utility::flag_wait("so_president_spawned");
  level._id_5B6B waittill("so_debate_anim_started");
  common_scripts\utility::waitframe();
  setsaveddvar("objectiveHide", 0);
  objective_setpointertextoverride(2, &"SO_MILEHIGH_HIJACK_CAPTURE");
  level._id_5B6B thread _id_5B6C();
  common_scripts\utility::flag_wait("so_president_captured");
  level._id_5B6B._id_1901 = 1;
  level._id_5B6B sethintstring("");
  common_scripts\utility::flag_set("so_milehigh_hijack_complete");
  maps\_utility::_id_2727(2);
}

_id_5B6C() {
  level endon("special_op_terminated");
  self endon("death");

  while(!common_scripts\utility::flag("so_president_captured")) {
    var_0 = self.origin + (0, 0, 32);
    objective_position(2, var_0);
    common_scripts\utility::waitframe();
  }
}

_id_5B6D() {
  level thread maps\_specialops::_id_1802("so_milehigh_hijack_start", "so_milehigh_hijack_complete");
  level thread maps\_specialops::_id_17F3(1.5, 1);
  level thread maps\_specialops::_id_17F5("so_milehigh_hijack_complete", 0);
  level._id_5B6E = 0;
  level._id_16BC = 1;
  level._id_16BD = ::_id_5B6F;
  level waittill("so_players_ready");
  common_scripts\utility::waitframe();

  foreach(var_1 in level.players) {}
  var_1 notify("force_challenge_timer");
}

_id_5B6F() {
  var_0 = int(min(level._id_16CE - level._id_16CF, 86400000));
  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in level.players) {
    var_4._id_16C6["damaged"] = var_4._id_5B54;
    var_5 = max(1, float(var_4.stats["shots_fired"]));
    var_6 = max(1, float(var_4.stats["shots_hit"]));
    var_7 = var_6 / var_5;
    var_8 = int(var_7 * 100);
    var_4._id_16C6["accuracy"] = var_8;
    var_1 = var_1 + var_7;
    var_2 = var_2 + var_4._id_16C6["damaged"];
  }

  var_10 = int(level._id_16D1 * 10000);
  level._id_16C4 = var_10;
  var_11 = 20000;
  var_12 = level._id_16C3 * 1000;
  var_13 = max(0, var_0 - var_11);
  var_14 = 0;

  if(var_0 < var_12) {
    var_14 = int((var_12 - var_13) / var_12 * 5000);

  }
  level._id_16C4 = level._id_16C4 + var_14;
  var_15 = 25 * level.players[0]._id_16C6["kills"];

  if(maps\_utility::_id_12C1()) {
    var_15 = var_15 + 25 * maps\_utility::_id_133A(level.players[0])._id_16C6["kills"];

  }
  level._id_16C4 = level._id_16C4 + var_15;
  var_16 = var_1 / level.players.size;
  var_17 = 2000 - level._id_0126 * 25;
  var_18 = int(var_17 * var_16);
  level._id_16C4 = level._id_16C4 + var_18;
  var_19 = var_2 / level.players.size;
  var_20 = min(100 * var_19, 3000);
  var_21 = int(3000 - var_20);
  level._id_16C4 = level._id_16C4 + var_21;

  foreach(var_4 in level.players) {}
  var_4 maps\_specialops::_id_17FE(level._id_16C4);

  var_24[0] = "@MENU_RECRUIT";
  var_24[1] = "@MENU_REGULAR";
  var_24[2] = "@MENU_HARDENED";
  var_24[3] = "@MENU_VETERAN";
  var_25 = undefined;
  var_26 = undefined;
  var_27 = undefined;
  var_28 = undefined;

  if(maps\_utility::_id_12C1()) {
    var_25 = "@SPECIAL_OPS_UI_TEAM_SCORE";
    var_26 = "@SPECIAL_OPS_PERFORMANCE_YOU";
    var_27 = "@SPECIAL_OPS_PERFORMANCE_PARTNER";
    var_28 = "@SPECIAL_OPS_POINTS";
  } else {
    var_25 = "@SPECIAL_OPS_UI_SCORE";
    var_26 = "";
    var_27 = "@SPECIAL_OPS_POINTS";
  }

  maps\_utility::_id_1E71();

  foreach(var_4 in level.players) {
    var_30 = var_4._id_16C6["accuracy"];
    var_31 = var_4._id_16C6["damaged"];
    var_32 = var_4._id_16C6["time"] * 0.001;
    var_33 = maps\_utility::_id_16D0(var_32, 1);
    var_34 = var_24[var_4._id_16C6["difficulty"]];
    var_35 = var_4._id_16C6["score"];
    var_36 = var_4._id_16C6["kills"];

    if(maps\_utility::_id_12C1()) {
      var_37 = maps\_utility::_id_133A(var_4)._id_16C6["accuracy"];
      var_38 = maps\_utility::_id_133A(var_4)._id_16C6["damaged"];
      var_39 = var_24[maps\_utility::_id_133A(var_4)._id_16C6["difficulty"]];
      var_40 = maps\_utility::_id_133A(var_4)._id_16C6["kills"];

      if(!level._id_16C9) {
        var_4 maps\_utility::_id_16C7("", var_26, var_27, var_28, 1);
        var_4 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_DIFFICULTY", var_34, var_39, var_10, 2);
        var_4 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_TIME", var_33, var_33, var_14, 3);
        var_4 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_KILLS", var_36, var_40, var_15, 4);
        var_4 maps\_utility::_id_16C7("@SO_MILEHIGH_HIJACK_ACCURACY", var_30 + "%", var_37 + "%", var_18, 5);
        var_4 maps\_utility::_id_16C7("@SO_MILEHIGH_HIJACK_DAMAGED", var_31, var_38, var_21, 6);

        if(!issplitscreen()) {
          var_4 maps\_utility::_id_16C8();

        }
        var_4 maps\_utility::_id_16C7(var_25, var_35, undefined, undefined);
      } else {
        var_4 maps\_utility::_id_16C7("", var_26, var_27, undefined, 1);
        var_4 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_DIFFICULTY", var_34, var_39, undefined, 2);
        var_4 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_TIME", var_33, var_33, undefined, 3);
        var_4 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_KILLS", var_36, var_40, undefined, 4);
      }

      continue;
    }

    if(!level._id_16C9) {
      var_4 maps\_utility::_id_16C7("", var_26, var_27, var_28, 1);
      var_4 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_DIFFICULTY", var_34, var_10, undefined, 2);
      var_4 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_TIME", var_33, var_14, undefined, 3);
      var_4 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_KILLS", var_36, var_15, undefined, 4);
      var_4 maps\_utility::_id_16C7("@SO_MILEHIGH_HIJACK_ACCURACY", var_30 + "%", var_18, undefined, 5);
      var_4 maps\_utility::_id_16C7("@SO_MILEHIGH_HIJACK_DAMAGED", var_31, var_21, undefined, 6);

      if(!issplitscreen()) {
        var_4 maps\_utility::_id_16C8();

      }
      var_4 maps\_utility::_id_16C7(var_25, var_35, undefined, undefined);
      continue;
    }

    var_4 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_DIFFICULTY", var_34, undefined, undefined, 1);
    var_4 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_TIME", var_33, undefined, undefined, 2);
    var_4 maps\_utility::_id_16C7("@SPECIAL_OPS_UI_KILLS", var_36, undefined, undefined, 3);
  }

  if(!level._id_16C9) {
    setdvar("ui_hide_hint", 1);
  } else {
    setdvar("ui_hide_hint", 0);
  }
}

_id_5B70() {
  _id_5B74("so_conference_room_hall", ::_id_5B76);
  _id_5B74("so_conference_room_hall", ::_id_5B88);
  _id_5B74("so_conference_room_hall_flash_bang", ::_id_5B88);
  _id_5B74("lower_floor_first_terrorists", ::_id_5B75);
  _id_5B74("lower_floor_second_terrorists", ::_id_5B75);
  _id_5B74("lower_floor_terrorists", ::_id_5B75);
  _id_5B74("so_upper_floor_stairs", ::_id_5B75);
  _id_5B74("so_last_hallway_rush", ::_id_5B75);
  _id_5B74("so_upper_floor_hall", ::_id_5B75);
  _id_5B74("so_conference_room_hall", ::_id_5B75);
  _id_5B74("breach_enemy_spawner", ::_id_5B75);
  level thread _id_5B71();
}

_id_5B71() {
  while(!isDefined(anim._id_0D6B)) {
    wait 1;
    continue;
  }

  anim._id_0D6B = 999999;
}

_id_5B72() {
  level endon("special_op_terminated");
  common_scripts\utility::flag_wait("lower_floor_first_terrorists");

  if(_id_011A()) {
    wait 1;

  }
  _id_5B73("lower_floor_first_terrorists");
  common_scripts\utility::flag_wait("lower_floor_second_terrorists");
  _id_5B73("lower_floor_second_terrorists");
  common_scripts\utility::flag_wait("lower_floor_third_terrorists");
  _id_5B73("lower_floor_third_terrorists");
  common_scripts\utility::flag_wait("lower_floor_terrorists");
  _id_5B73("lower_floor_terrorists");
  common_scripts\utility::flag_wait("so_upper_floor_stairs");
  _id_5B73("so_upper_floor_stairs");
  common_scripts\utility::flag_wait("so_last_hallway_rush");
  _id_5B73("so_last_hallway_rush");
  common_scripts\utility::flag_wait("so_upper_floor_rumble");
  _id_5B73("so_upper_floor_hall");
  common_scripts\utility::flag_wait("so_conference_room_hall");

  if(_id_011A()) {
    wait 4;

  }
  _id_5B73("so_conference_room_hall");
}

_id_5B73(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  if(var_1.size == 0) {
    return;
  }
  return maps\_utility::_id_272B(var_1, 1, 0);
}

_id_5B74(var_0, var_1) {
  var_2 = getEntArray(var_0, "targetname");

  if(var_2.size == 0) {
    return;
  }
  maps\_utility::_id_27C9(var_2, var_1);
}

_id_5B75() {
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "so_president") {
    return;
  }
  self._id_20AF = level._id_5B5F;
  self.grenadeammo = 0;
  self._id_0F2D = 1;
  level._id_5B6E++;
}

_id_5B76() {
  level endon("special_op_terminated");
  self endon("death");
  maps\_utility::_id_1058(1);
  level common_scripts\utility::waittill_either("so_counter_breach_flash_activated", "flashbang_guy_killed");
  wait 1;
  maps\_utility::_id_1058(0);
}

_id_5B77() {
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
  _id_5B78(var_0);
  thread _id_5B7A();
  thread maps\hijack_airplane::_id_5B31();
  wait 0.2;
  thread _id_5B7B();
  wait 1;
  _id_5B79();
  wait 1;
  thread _id_5B7C();
  wait 1;
  level.planerumbleactive = 0;
  common_scripts\utility::flag_clear("stop_constant_shake");
  thread maps\hijack_airplane::_id_5AED();
}

_id_5B78(var_0) {
  level._id_27A4 = 1;
  var_1 = anglesToForward(var_0);

  foreach(var_3 in level.players) {
    var_3 playrumbleonentity("hijack_plane_large");
    var_3 viewkick(127, var_3.origin + (0, 0, -220));
    var_3 setvelocity(var_1 * 110);
    var_3 _id_5B64(var_1);
    var_3 maps\hijack_code::_id_595C();
  }
}

_id_5B79() {
  foreach(var_1 in level.players) {}
  var_1 maps\hijack_code::_id_595E();
}

_id_5B7A() {
  level endon("special_op_terminated");
  common_scripts\utility::flag_set("stop_rocking");
  maps\_audio::aud_send_msg("hallway_lurch", 0);
  var_0 = maps\_utility::_id_1287("upperhall_roller", level.player.origin);
  var_0.angles = (0, 0, 0);
  var_0 maps\_anim::_id_11CF(var_0, "hallway_lurchcam");
  var_1 = [];
  var_2 = 0;

  foreach(var_4 in level.players) {
    var_1[var_2] = spawn("script_origin", var_4.origin);
    var_1[var_2].angles = (0, 0, 0);
    var_4 playersetgroundreferenceent(var_1[var_2]);
    var_1[var_2] linkto(var_0, "J_prop_1");
    var_2++;
  }

  var_0 thread maps\_anim::_id_1246(var_0, "hallway_lurchcam");
  var_0 waittillmatch("single anim", "corpse_slump");
  thread maps\hijack_airplane::_id_5AE9();
  common_scripts\utility::array_thread(level._id_5961, maps\hijack_airplane::_id_5AE8);
  var_0 waittillmatch("single anim", "end");

  foreach(var_4 in level.players) {}
  var_4 playersetgroundreferenceent(level._id_5960);

  maps\_utility::_id_135B(var_1);
  var_0 delete();
}

_id_5B7B() {
  var_0 = getEntArray("lower_level_room_1_objects", "targetname");

  foreach(var_2 in var_0) {}
  var_2 thread maps\hijack_code::_id_5966(randomintrange(200, 240), (0, 1, 0));

  var_4 = getEntArray("bar_room_physics", "targetname");

  foreach(var_2 in var_4) {}
  var_2 thread maps\hijack_code::_id_5968(64, 64, 0.65);
}

_id_5B7C() {
  common_scripts\utility::array_thread(level._id_5961, maps\hijack_code::_id_595A, (0, 0, 0), 1, 0, 0);
}

_id_5B7D() {
  level endon("special_op_terminated");
  common_scripts\utility::flag_wait("so_upper_floor_rumble");
  wait 0.7;
  common_scripts\utility::flag_set("stop_rocking");
  common_scripts\utility::flag_set("stop_constant_shake");
  earthquake(0.3, 5.5, level.player.origin, 80000);
  level.planerumbleactive = 1;
  var_0 = (0, 90, 0);
  _id_5B78(var_0);
  thread _id_5B7A();
  thread maps\hijack_airplane::_id_5AEC();
  maps\_audio::aud_send_msg("hallway_lurch", 0);
  thread maps\hijack_airplane::_id_5B31();
  wait 1.2;
  _id_5B79();
  wait 1;
  thread _id_5B7C();
  wait 1;
  level.planerumbleactive = 0;
  common_scripts\utility::flag_clear("stop_constant_shake");
  thread maps\hijack_airplane::_id_5AED();
}

_id_5B7E() {
  level endon("special_op_terminated");
  level._id_59A0 = common_scripts\utility::getstruct("pres_room_struct", "targetname");
  level thread maps\hijack_airplane::_id_5AB3();
  var_0 = getent("intro_door0", "targetname");
  var_0 movey(-51, 0.05);
  var_1 = getent("storage_door1", "targetname");
  var_1 movey(49, 1, 0, 0.25);
  level._id_5AB6 unlink();
  level._id_5AB6 movey(50, 1, 0, 0.25);
  var_2 = getEntArray("so_tactical_door", "targetname");

  foreach(var_4 in var_2) {
    var_4 hide();
    var_4 notsolid();
    var_4 connectpaths();
  }
}

_id_5B7F() {
  var_0 = 1231.0;
  var_1 = var_0 / 1609;
  var_2 = var_0 / 1560;
  var_3 = var_0 / 1531;
  var_4 = var_3;
  maps\_utility::_id_27CB("so_commander", ::_id_5B88);
  maps\_utility::_id_27CB("so_hero_agent_01", ::_id_5B88);
  maps\_utility::_id_27CB("so_intro_agent2", ::_id_5B88);
  maps\_utility::_id_27CB("so_intro_agent1", ::_id_5B88);
  maps\_utility::_id_27CB("so_president", ::_id_5B8A, "president", "debate", var_1, undefined);
  maps\_utility::_id_27CB("so_commander", ::_id_5B8A, "so_commander", "debate", 0, undefined);
  maps\_utility::_id_27CB("so_advisor", ::_id_5B8A, "so_advisor", "debate", 0, undefined);
  maps\_utility::_id_27CB("so_hero_agent_01", ::_id_5B8A, "so_hero_agent", "debate", 0, undefined);
  maps\_utility::_id_27CB("so_secretary", ::_id_5B8A, "secretary", "debate", var_2, undefined);
  maps\_utility::_id_27CB("so_polit_1", ::_id_5B8A, "polit_1", "debate", var_3, undefined);
  maps\_utility::_id_27CB("so_polit_2", ::_id_5B8A, "polit_2", "debate", var_4, undefined);
  maps\_utility::_id_27CB("so_intro_agent2", ::_id_5B8A, "so_agent2", "debate", 0, undefined);
  maps\_utility::_id_27CB("so_intro_agent1", ::_id_5B8A);
  maps\_utility::_id_27CB("so_president", ::_id_5B8C);
  maps\_utility::_id_27CB("so_president", ::_id_5B8E);
  maps\_utility::_id_27CB("so_polit_1", ::_id_5B86);
  maps\_utility::_id_27CB("so_polit_2", ::_id_5B86);
  maps\_utility::_id_27CB("so_secretary", ::_id_5B86);
  maps\_utility::_id_27CB("so_advisor", ::_id_5B86);
  maps\_utility::_id_27CB("so_commander", ::_id_5B76);
  maps\_utility::_id_27CB("so_intro_agent2", ::_id_5B76);
  maps\_utility::_id_27CB("so_intro_agent1", ::_id_5B76);
  maps\_utility::_id_27CB("so_hero_agent_01", ::_id_5B76);
  maps\_utility::_id_27CB("so_president", ::_id_5B87, "debate_cine_president_end_loop", "stop_pres_debate_loop");
  maps\_utility::_id_27CB("so_advisor", ::_id_5B87, "debate_cine_advisor_end_loop", "stop_debate_advisor_loop");
  maps\_utility::_id_27CB("so_secretary", ::_id_5B83, "start_ragdoll");
  maps\_utility::_id_27CB("so_polit_1", ::_id_5B83, "start_ragdoll");
  maps\_utility::_id_27CB("so_polit_2", ::_id_5B83, "start_ragdoll");
  maps\_utility::_id_27CB("so_advisor", ::_id_5B84);
  maps\_utility::_id_27CB("so_commander", ::_id_5B85);
  maps\_utility::_id_27CA("breach_enemy_spawner", ::_id_0127);
  level._id_59A0 = common_scripts\utility::getstruct("pres_room_struct", "targetname");
  _id_5B81("chair1", "debate_chair1");
  _id_5B81("chair2", "debate_chair2");
  _id_5B81("chair3", "debate_chair3");
  _id_5B81("chair4", "debate_chair4");
  _id_5B81("chair5", "debate_chair5");
  _id_5B81("chair6", "debate_chair6");
  _id_5B81("chair8", "debate_chair8");
  _id_5B82();
  _id_5B80();
}

_id_5B80() {
  level endon("special_op_terminated");
  var_0 = getEntArray("conf_room_physics", "targetname");

  foreach(var_2 in var_0) {}
  physicsexplosionsphere(var_2.origin, 64, 32, 0.6);

  var_4 = getEntArray("conf_room_junk", "targetname");

  foreach(var_2 in var_4) {}
  var_2 thread maps\hijack_code::_id_5966(randomintrange(120, 170), (0, -1, 0.05));

  thread maps\hijack_airplane::_id_5ACE();
  thread maps\hijack_airplane::_id_5ACF();
  common_scripts\utility::flag_wait("door_breach");
  var_7 = getent("tv_destructor", "targetname");
  var_8 = getent("tv_destructor2", "targetname");
  magicbullet("ak74u", var_7.origin, var_8.origin);
}

_id_5B81(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_2._id_1032 = "conf_chair";
  var_2 maps\_anim::_id_1244();
  level._id_59A0 maps\_anim::_id_11CF(var_2, var_1);
  common_scripts\utility::waitframe();
  level._id_59A0 thread maps\_anim::_id_1246(var_2, var_1);
  common_scripts\utility::waitframe();
  var_2 thread maps\_anim::_id_1280(var_1, 1);
}

_id_5B82() {
  var_0 = getent("chair_destroy_top", "targetname");
  var_1 = getent("chair_destroy_base", "targetname");
  var_2 = maps\_utility::_id_1287("destroy_chair");
  waittillframeend;
  level._id_59A0 maps\_anim::_id_11CF(var_2, "debate_cine_end_chair");
  var_0 linkto(var_2, "J_prop_1");
  var_1 linkto(var_2, "J_prop_2");
  level._id_59A0 thread maps\_anim::_id_1246(var_2, "debate_cine_end_chair");
  common_scripts\utility::waitframe();
  var_2 maps\_anim::_id_1280("debate_cine_end_chair", 1);
  common_scripts\utility::waitframe();
  var_0 unlink();
  var_1 unlink();
  var_2 delete();
}

_id_5B83(var_0) {
  self endon("death");
  self._id_0EC6 = 1;
  self.a._id_0D55 = 1;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.diequietly = 1;
  self._id_10EF = 1;
  self.combatmode = "no_cover";
  self._id_0D50 = undefined;
  self waittillmatch("single anim", var_0);
  self invisiblenotsolid();
  self notify("stop_loop");
  self notify("single anim", "end");
  self notify("looping anim", "end");
  self kill();
}

_id_5B84() {
  level endon("special_op_terminated");
  self waittillmatch("single anim", "end");
  self._id_0EC6 = 1;
  self.a._id_0D55 = 1;
  self.allowdeath = 0;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.diequietly = 1;
  self.health = 10000;
  self._id_10EF = 1;
  self.combatmode = "no_cover";
  self._id_0D50 = undefined;
  self waittill("damage", var_0, var_1, var_2, var_3, var_4);
  self invisiblenotsolid();
  level._id_59A0 notify("stop_debate_advisor_loop");
  level._id_59A0 maps\_anim::_id_1246(self, "couch_death");
  self.allowdeath = 1;
  self kill(self.origin, var_1);
}

_id_5B85() {
  level endon("special_op_terminated");
  self endon("death");
  var_0 = self.weapon;
  self waittillmatch("single anim", "dropgun");
  common_scripts\utility::waitframe();
  animscripts\shared::_id_0C9B(var_0, "right", 1);
}

_id_5B86() {
  maps\_utility::_id_24F5();
}

_id_5B87(var_0, var_1) {
  self waittillmatch("single anim", "end");
  level._id_59A0 thread maps\_anim::_id_124E(self, var_0, var_1);
}

_id_5B88() {
  self.combatmode = "no_cover";

  if(!isDefined(level._id_5B89)) {
    level._id_5B89 = [];

  }
  level._id_5B89[level._id_5B89.size] = self;
}

_id_5B8A(var_0, var_1, var_2, var_3) {
  level endon("special_op_terminated");
  self.team = "axis";
  self._id_0F2D = 1;

  if(!isDefined(var_0)) {
    return;
  }
  self._id_1032 = var_0;
  level waittill("breach_enemy_anims");
  common_scripts\utility::waitframe();
  level._id_59A0 thread _id_5B8B(self, var_1, var_2, var_3);
  self notify("so_debate_anim_started");
}

_id_5B8B(var_0, var_1, var_2, var_3) {
  thread maps\_anim::_id_1246(var_0, var_1, undefined, var_3);
  common_scripts\utility::waitframe();
  var_0 thread maps\_anim::_id_1280(var_1, var_2);
}

_id_5B8C() {
  level endon("special_op_terminated");
  level._id_5B6B = self;
  common_scripts\utility::flag_set("so_president_spawned");

  while(!_id_5B8D()) {
    wait 0.1;

  }
  self setcursorhint("HINT_NOICON");
  self sethintstring(&"SO_MILEHIGH_HIJACK_USE_PRESIDENT");
  self makeusable();
  self waittill("trigger");
  common_scripts\utility::flag_set("so_president_captured");
}

_id_5B8D() {
  if(isDefined(level._id_5B89)) {
    var_0 = getent("near_president_vol", "targetname");

    foreach(var_2 in level._id_5B89) {
      if(isalive(var_2) && !var_2 maps\_utility::_id_0D69() && var_2 istouching(var_0)) {
        return 0;
      }
    }
  }

  return 1;
}

_id_5B8E() {
  level endon("special_op_terminated");
  self waittill("death");
  level._id_16CE = gettime();
  level._id_0123 = 1;
  maps\_specialops::_id_183F("@SO_MILEHIGH_HIJACK_PRESIDENT_KILLED");
  maps\_utility::_id_1826();
}

_id_5B8F() {
  level endon("special_op_terminated");
  level endon("flashbang_guy_killed");
  var_0 = common_scripts\utility::getstruct("so_flash_grenade_start", "targetname");
  var_1 = common_scripts\utility::getstruct("so_flash_grenade_end", "targetname");
  common_scripts\utility::flag_wait("so_counter_breach");
  level thread _id_5B90();
  common_scripts\utility::flag_set("so_conference_room_hall");
  level._id_58C4 unlink();
  level._id_58C4 movey(-50, 0.5, 0, 0.1);
  wait 0.4;
  var_2 = magicgrenade("flash_grenade", var_0.origin, var_1.origin, 1);
  level notify("flashbang_out");

  while(isDefined(var_2)) {
    common_scripts\utility::waitframe();

  }
  level notify("so_counter_breach_flash_activated");
}

_id_5B90() {
  level endon("flashbang_out");
  var_0 = getent("so_conference_room_hall_flash_bang", "targetname");
  var_1 = var_0 maps\_utility::_id_166F(1, 0);
  var_1._id_1032 = "so_flashbang_enemy";
  level._id_59A0 maps\_anim::_id_1246(var_1, "so_milehigh_breach_flashbang_toss");
  var_2 = common_scripts\utility::getstruct("so_flashbang_guy_goal", "targetname");
  var_1 setgoalpos(var_2.origin);
  var_1 waittill("death");
  level notify("flashbang_guy_killed");
}

_id_5B91() {
  level waittill("special_op_terminated");
  common_scripts\utility::flag_set("stop_constant_shake");
}

_id_5B93() {
  level endon("special_op_terminated");
  level thread _id_5B94();
  var_0 = getent("so_ambient_vo_hijackers_speaker", "targetname");
  common_scripts\utility::flag_wait("so_ambient_vo_hijackers");
  var_0 playSound("hijack_fso3_hijackerstaking");
}

_id_5B94() {
  level endon("special_op_terminated");
  var_0 = getent("so_lines_behind_door", "targetname");
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
  self._id_5335 = 1;
}

_id_0128() {
  level endon("special_op_terminated");
  level waittill("breaching_number_2");
  wait 0.3;
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2._id_5335) || !var_2._id_5335) {
      var_2 delete();
    }
  }
}

_id_0129() {
  level endon("special_op_terminated");
  level._id_4D11 = 1;

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