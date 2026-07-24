/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\marsbase\marsbase_code.gsc
******************************************************/

_id_9809() {
  scripts\engine\utility::flag_init("obj_lead_assault");
  scripts\engine\utility::flag_init("obj_gain_access");
  scripts\engine\utility::flag_init("obj_aa_1");
  scripts\engine\utility::flag_init("obj_aa_2");
  scripts\engine\utility::flag_init("obj_aa_3");
  scripts\engine\utility::flag_init("obj_space_elevator");
  scripts\engine\utility::flag_init("flag_retreat_base_intro_1");
  scripts\engine\utility::flag_init("flag_retreat_base_intro_2");
  scripts\engine\utility::flag_init("flag_base_intro_atv_1_dead");
  scripts\engine\utility::flag_init("flag_base_intro_combat_end");
  scripts\engine\utility::flag_init("flag_dropship_leave");
  scripts\engine\utility::flag_init("flag_dropship2_leave");
  scripts\engine\utility::flag_init("flag_dropship3_leave");
  scripts\engine\utility::flag_init("flag_start_engineer_gate_open");
  scripts\engine\utility::flag_init("flag_salter_scene_done");
  scripts\engine\utility::flag_init("flag_obj_aa1_start");
  scripts\engine\utility::flag_init("flag_aa1_end");
  scripts\engine\utility::flag_init("gate_engineers_dead");
  scripts\engine\utility::flag_init("flag_gate_support_1_end");
  scripts\engine\utility::flag_init("flag_engineers_cleared_dropship2");
  scripts\engine\utility::flag_init("flag_obj_gh_infil_start");
  scripts\engine\utility::flag_init("flag_greenhouse_approach_end");
  scripts\engine\utility::flag_init("spawn_gate_c8");
  scripts\engine\utility::flag_init("flag_greenhouse_advance_1a");
  scripts\engine\utility::flag_init("flag_greenhouse_advance_1b");
  scripts\engine\utility::flag_init("flag_greenhouse_advance_2");
  scripts\engine\utility::flag_init("flag_greenhouse_advance_3");
  scripts\engine\utility::flag_init("flag_greenhouse_advance_4");
  scripts\engine\utility::flag_init("flag_greenhouse_advance_5");
  scripts\engine\utility::flag_init("flag_greenhouse_advance_6");
  scripts\engine\utility::flag_init("flag_greenhouse_retreat_1a");
  scripts\engine\utility::flag_init("flag_greenhouse_retreat_1b");
  scripts\engine\utility::flag_init("flag_greenhouse_retreat_2");
  scripts\engine\utility::flag_init("flag_greenhouse_retreat_3");
  scripts\engine\utility::flag_init("flag_greenhouse_retreat_4");
  scripts\engine\utility::flag_init("flag_greenhouse_retreat_5");
  scripts\engine\utility::flag_init("flag_greenhouse_retreat_6");
  scripts\engine\utility::flag_init("flag_greenhouse_droppod");
  scripts\engine\utility::flag_init("flag_greenhouse_combat_end");
  scripts\engine\utility::flag_init("flag_greenhouse_end_c8_dead");
  scripts\engine\utility::flag_init("flag_greenhouse_near_door");
  scripts\engine\utility::flag_init("flag_greenhouse_call_engineer");
  scripts\engine\utility::flag_init("flag_greenhouse_exit_end");
  scripts\engine\utility::flag_init("gator_death_start");
  scripts\engine\utility::flag_init("gator_death_end");
  scripts\engine\utility::flag_init("exitdoor_boss_dropship_started");
  scripts\engine\utility::flag_init("greenhouse_done");
  scripts\engine\utility::flag_init("player_and_heroes_in_aa2");
  scripts\engine\utility::flag_init("flag_obj_aa2_start");
  scripts\engine\utility::flag_init("flag_aa2_end");
  scripts\engine\utility::flag_init("aa2_destroyed");
  scripts\engine\utility::flag_init("flag_gate_support_2_end");
  scripts\engine\utility::flag_init("flag_caves_end");
  scripts\engine\utility::flag_init("flag_hill_allies_intro");
  scripts\engine\utility::flag_init("flag_hill_intro_end");
  scripts\engine\utility::flag_init("flag_monorail_fall_init");
  scripts\engine\utility::flag_init("flag_hill_combat_start");
  scripts\engine\utility::flag_init("flag_hill_retreat_1");
  scripts\engine\utility::flag_init("flag_hill_retreat_2");
  scripts\engine\utility::flag_init("flag_hill_retreat_3");
  scripts\engine\utility::flag_init("flag_hill_retreat_4");
  scripts\engine\utility::flag_init("flag_hill_retreat_left_shotgun");
  scripts\engine\utility::flag_init("flag_hill_retreat_left_droppod");
  scripts\engine\utility::flag_init("flag_hill_retreat_left_3");
  scripts\engine\utility::flag_init("flag_hill_combat_end");
  scripts\engine\utility::flag_init("flag_endgate_start");
  scripts\engine\utility::flag_init("flag_obj_aa3_start");
  scripts\engine\utility::flag_init("flag_aa3_end");
  scripts\engine\utility::flag_init("flag_killstreak_offline");
  scripts\engine\utility::flag_init("flag_mars_killstreak_offline");
  scripts\engine\utility::flag_init("flag_mars_killstreak_offline_message");
  scripts\engine\utility::flag_init("flag_proximity_hack_1_active");
  scripts\engine\utility::flag_init("flag_proximity_hack_2_active");
  scripts\engine\utility::flag_init("flag_proximity_hack_1_done");
  scripts\engine\utility::flag_init("flag_proximity_hack_2_done");
  scripts\engine\utility::flag_init("flag_endgate_player_right");
  scripts\engine\utility::flag_init("flag_endgate_player_center");
  scripts\engine\utility::flag_init("flag_endgate_player_left");
  scripts\engine\utility::flag_init("flag_endgate_end");
  scripts\engine\utility::flag_init("flag_hill_gate_jackals_weapons_loose");
  scripts\engine\utility::flag_init("flag_hill_gate_jackal_01_destroyed");
  scripts\engine\utility::flag_init("flag_hill_gate_jackal_02_hit");
  scripts\engine\utility::flag_init("flag_hill_gate_jackal_01_hit");
  scripts\engine\utility::flag_init("flag_hill_gate_jackal_ram_gun");
  scripts\engine\utility::flag_init("flag_hill_gate_sdf_retreat");
  scripts\engine\utility::flag_init("flag_gate_support_3_end");
  scripts\engine\utility::flag_init("flag_bridgewalk_start");
  scripts\engine\utility::flag_init("flag_bridgewalk_end");
}

_id_D83F() {
  scripts\sp\utility::_id_16EB("hint_door_locked", &"MARSBASE_HINT_DOORLOCKED");
  scripts\sp\utility::_id_16EB("hint_use_monsweapon", &"MARSBASE_USE_MONSWEAPON", scripts\sp\maps\marsbase\marsbase_intro::_id_9015);
  scripts\sp\utility::_id_16EB("hint_monsweapon_not_ready", &"MARSBASE_KILLSTREAK_NOT_READY_CENTER");
  scripts\sp\utility::_id_16EB("hint_use_left_stick", "[{left_stick_centered}]");
  precacheitem("mars_aa_projectile");
  precacherumble("mars_aa_gun");
  level.player notifyonplayercommand("mars_killstreak", "+actionslot 1");
  bug_test_move_startpoint("aa_gun_1_1");
  bug_test_move_startpoint("aa_gun_1_2");
  bug_test_move_startpoint("aa_gun_2");
  bug_test_move_startpoint("aa_gun_3");
  bug_test_move_startpoint("aa_gun_4");
}

_id_D704() {
  level._id_4487 = [0, 2, 10, 12, 20, 22, 30, 32, 40, 42, 52];
  _id_9677("vehicle_intro_atv_1");
  level.drone_cam_geo_filler = getEnt("drone_cam_geo_filler", "targetname");
  level.drone_cam_geo_filler notsolid();
  level.drone_cam_geo_filler hide();
  scripts\sp\maps\marsbase\marsbase_killstreak::_id_9676();
  level._id_8569 = level.doors["greenhouse_exit_doors"];
  level._id_8569 _id_0B1F::_id_5982(scripts\sp\maps\marsbase\marsbase_anim::_id_8558, scripts\sp\maps\marsbase\marsbase_anim::_id_855A, scripts\sp\maps\marsbase\marsbase_anim::_id_8559);
  level._id_8569 _id_0B1F::_id_59EB("scn_europa_bddy_door_open_grab", "scn_europa_bddy_door_open_start", "scn_europa_bddy_door_open_lp", "scn_europa_bddy_door_shut", "scn_europa_bddy_door_open_finish");
  level._id_8569._id_28B6 = "left_door_01";
  level._id_8569 scripts\sp\utility::_id_65E0("flag_greenhouse_unlock_door");
  thread _id_C600("gate_elevator_bridge_left", "gate_elevator_bridge_right", 1, undefined, 128);
  level._id_6055 = level.doors["elevator_final_gate"];
  level._id_6055 _id_0B1F::_id_5982(scripts\sp\maps\marsbase\marsbase_anim::_id_606F, scripts\sp\maps\marsbase\marsbase_anim::_id_6071, scripts\sp\maps\marsbase\marsbase_anim::_id_6070);
  level._id_6055 _id_0B1F::_id_59EB();
  level._id_6055._id_28B6 = "left_door_01";
  _id_95BF();
  scripts\engine\utility::array_call(getEntArray("temp_elevator_defend_soldiers", "script_noteworthy"), ::hide);
}

_id_B3A0() {
  level._id_10281["axis"] = "veh_mil_air_ca_jackal_drone_atmos_periph";
  level._id_10281["allies"] = "veh_mil_air_un_jackal_drone_atmos_periph";
  thread _id_0B0F::_id_10D23("intro_vista_skyambient");
  thread _id_0B0F::_id_10282("intro_vista_skyambient", "intro_droppods", 3);
  thread _id_0B0F::_id_10282("intro_vista_skyambient", "intro_dropships", 8);
}

_id_B39F() {
  thread _id_0B0F::_id_1103F("intro_vista_skyambient", 0);
}

_id_C2A9(var_0) {
  var_1 = scripts\engine\utility::getStruct("elevator_final_gate_interact", "script_noteworthy");
  var_2 = scripts\engine\utility::getStruct("interact_seat_player", "targetname");
  objective_add(scripts\sp\utility::_id_C264("MARSBASE_LEAD_ASSAULT"), "invisible", &"MARSBASE_LEAD_ASSAULT");
  objective_add(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_1"), "invisible", &"MARSBASE_AA_GUN_1");
  objective_add(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_2"), "invisible", &"MARSBASE_AA_GUN_2");
  objective_add(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_3"), "invisible", &"MARSBASE_AA_GUN_3");
  objective_add(scripts\sp\utility::_id_C264("MARSBASE_GAIN_ACCESS"), "invisible", &"MARSBASE_GAIN_ACCESS", var_1.origin);
  objective_add(scripts\sp\utility::_id_C264("MARSBASE_SPACE_ELEVATOR"), "invisible", &"MARSBASE_SPACE_ELEVATOR", var_2.origin);

  if(!isDefined(var_0))
    var_0 = level._id_10CDA;

  switch (level._id_10CDA) {
    case "aa2":
    case "greenhouse_enter":
    case "greenhouse_battle":
    case "greenhouse_approach":
    case "gate_support_1":
      scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_1"));
      break;
    case "hill_gate":
    case "hill_c8":
    case "hill_cargofall":
    case "hill_battle":
    case "hill_intro":
    case "burning_man":
    case "gate_support_2":
      scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_1"));
      scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_2"));
      break;
    case "elevator_igc":
    case "elevator_retreat":
    case "hill_gate_open":
      scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("MARSBASE_LEAD_ASSAULT"));
      scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_1"));
      scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_2"));
      scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_3"));
      break;
    case "elevator_load":
    case "elevator_enter":
      scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("MARSBASE_LEAD_ASSAULT"));
      scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_1"));
      scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_2"));
      scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_3"));
      scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("MARSBASE_GAIN_ACCESS"));
      break;
    case "elevator_move":
      scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("MARSBASE_LEAD_ASSAULT"));
      scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_1"));
      scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_2"));
      scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_3"));
      scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("MARSBASE_GAIN_ACCESS"));
      scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("MARSBASE_SPACE_ELEVATOR"));
      break;
  }
}

_id_C2AC(var_0) {
  switch (var_0) {
    case "lead_assault":
      objective_state(scripts\sp\utility::_id_C264("MARSBASE_LEAD_ASSAULT"), "current");
      break;
    case "aa1":
      objective_state_nomessage(scripts\sp\utility::_id_C264("MARSBASE_LEAD_ASSAULT"), "active");
      objective_state(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_1"), "current");
      break;
    case "aa1_complete":
      objective_state_nomessage(scripts\sp\utility::_id_C264("MARSBASE_LEAD_ASSAULT"), "current");
      scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_1"));
      break;
    case "aa2":
      objective_state_nomessage(scripts\sp\utility::_id_C264("MARSBASE_LEAD_ASSAULT"), "active");
      objective_state_nomessage(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_1"), "done");
      objective_state(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_2"), "current");
      break;
    case "aa2_complete":
      objective_state_nomessage(scripts\sp\utility::_id_C264("MARSBASE_LEAD_ASSAULT"), "current");
      objective_state_nomessage(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_1"), "done");
      scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_2"));
      break;
    case "aa3":
      objective_state_nomessage(scripts\sp\utility::_id_C264("MARSBASE_LEAD_ASSAULT"), "active");
      objective_state_nomessage(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_1"), "done");
      objective_state_nomessage(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_2"), "done");
      objective_state(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_3"), "current");
      break;
    case "aa3_complete":
      scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("MARSBASE_LEAD_ASSAULT"));
      objective_state_nomessage(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_1"), "done");
      objective_state_nomessage(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_2"), "done");
      scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_3"));
      objective_state(scripts\sp\utility::_id_C264("MARSBASE_GAIN_ACCESS"), "current");
      break;
    case "gain_access_complete":
      objective_state_nomessage(scripts\sp\utility::_id_C264("MARSBASE_LEAD_ASSAULT"), "done");
      objective_state_nomessage(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_1"), "done");
      objective_state_nomessage(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_2"), "done");
      objective_state_nomessage(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_3"), "done");
      scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("MARSBASE_GAIN_ACCESS"));
      objective_state(scripts\sp\utility::_id_C264("MARSBASE_SPACE_ELEVATOR"), "current");
      break;
    case "space_elevator_complete":
      objective_state_nomessage(scripts\sp\utility::_id_C264("MARSBASE_LEAD_ASSAULT"), "done");
      objective_state_nomessage(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_1"), "done");
      objective_state_nomessage(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_2"), "done");
      objective_state_nomessage(scripts\sp\utility::_id_C264("MARSBASE_AA_GUN_3"), "done");
      objective_state_nomessage(scripts\sp\utility::_id_C264("MARSBASE_GAIN_ACCESS"), "done");
      scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("MARSBASE_SPACE_ELEVATOR"));
      break;
  }
}

_id_C600(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_1291("open", var_0, var_1, var_2, var_3, var_4);
}

_id_426B(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_1291("closed", var_0, var_1, var_2, var_3, var_4);
}

_id_1291(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 = tolower(var_0);
  var_7 = getEnt(var_1, "targetname");
  var_8 = getEnt(var_2, "targetname");
  var_9 = getEnt(var_1 + "_clip", "targetname");
  var_10 = getEnt(var_2 + "_clip", "targetname");

  if(isDefined(var_6)) {
    var_11 = [var_7, var_8, var_9, var_10];

    foreach(var_13 in var_11) {
      if(isDefined(var_13) && !isDefined(var_13._id_4048)) {
        var_13._id_4048 = 1;
        scripts\sp\utility::_id_16AE(var_13, var_6);
      }
    }
  }

  if(isDefined(var_9) && !var_9 islinked())
    var_9 linkTo(var_7);

  if(isDefined(var_10) && !var_10 islinked())
    var_10 linkTo(var_8);

  if(!isDefined(var_5))
    var_5 = float(var_7._id_EE52);

  if(!isDefined(var_3))
    var_3 = 0;

  if(!var_7 scripts\sp\utility::_id_65DF("gate_moving"))
    var_7 scripts\sp\utility::_id_65E0("gate_moving");

  var_7 scripts\sp\utility::_id_65E8("gate_moving");

  switch (var_0) {
    case "open":
      if(isDefined(var_7.script_parameters) && var_7.script_parameters == "open") {
        return;
      }
      var_5 = var_5 * -1;
      break;
    case "closed":
      if(isDefined(var_7.script_parameters) && var_7.script_parameters == "closed") {
        return;
      }
      break;
    default:
  }

  var_7 scripts\sp\utility::_id_65E1("gate_moving");

  if(!isDefined(var_4))
    var_4 = 3;

  var_15 = 1;

  if(var_3) {
    var_4 = 0.05;
    var_15 = 0.05;
  }

  var_7 moveTo(var_7.origin + (var_5, 0, 0), var_4, var_15, 0);
  var_8 moveTo(var_8.origin + (var_5 * -1, 0, 0), var_4, var_15, 0);

  if(!var_3) {
    var_7 playSound("mars_base_gate_start");
    var_7 playLoopSound("mars_base_gate_loop");
  }

  wait(var_4);

  if(var_0 == "open") {
    if(isDefined(var_9))
      var_9 connectpaths();
    else
      var_7 connectpaths();

    if(isDefined(var_10))
      var_10 connectpaths();
    else
      var_8 connectpaths();
  } else {
    if(isDefined(var_9))
      var_9 disconnectPaths();
    else
      var_7 disconnectPaths();

    if(isDefined(var_10))
      var_10 disconnectPaths();
    else
      var_8 disconnectPaths();
  }

  var_7.script_parameters = var_0;
  scripts\engine\utility::waitframe();
  var_7 scripts\sp\utility::_id_65DD("gate_moving");

  if(!var_3) {
    var_7 playSound("mars_base_gate_end");
    wait 1;
  }

  var_7 stoploopsound();
}

_id_C601(var_0, var_1, var_2, var_3) {
  _id_1292("up", var_0, var_1, var_2, var_3);
}

_id_426D(var_0, var_1, var_2, var_3) {
  _id_1292("down", var_0, var_1, var_2, var_3);
}

_id_1292(var_0, var_1, var_2, var_3, var_4) {
  var_0 = tolower(var_0);
  var_5 = getEnt(var_1, "targetname");

  if(!isDefined(var_4))
    var_4 = float(var_5._id_EE52);

  switch (var_0) {
    case "up":
      if(isDefined(var_5.script_parameters) && var_5.script_parameters == "up") {
        return;
      }
      break;
    case "down":
      if(isDefined(var_5.script_parameters) && var_5.script_parameters == "down") {
        return;
      }
      var_4 = var_4 * -1;
      break;
    default:
  }

  if(!var_5 scripts\sp\utility::_id_65DF("gate_moving"))
    var_5 scripts\sp\utility::_id_65E0("gate_moving");

  var_5 scripts\sp\utility::_id_65E8("gate_moving");
  var_5 scripts\sp\utility::_id_65E1("gate_moving");

  if(!isDefined(var_3))
    var_3 = 3;

  var_6 = 1;

  if(isDefined(var_2) && var_2) {
    var_3 = 0.05;
    var_6 = 0.05;
  }

  var_5 moveTo(var_5.origin + (0, 0, var_4), var_3, var_6, 0);
  var_5 playSound("mars_base_gate_start");
  var_5 playLoopSound("mars_base_gate_loop");
  wait(var_3);
  var_5 connectpaths();
  var_5.script_parameters = var_0;
  var_5 scripts\sp\utility::_id_65DD("gate_moving");
  var_5 playSound("mars_base_gate_end");
  wait 1;
  var_5 stoploopsound();
}

_id_1061E(var_0, var_1) {
  var_2 = _id_77E6(var_0, var_1);
  var_3 = scripts\sp\utility::_id_22C6(var_2, 1, 1);
  return var_3;
}

_id_77E6(var_0, var_1) {
  var_2 = scripts\sp\utility::_id_77DF(var_0);

  if(!isDefined(var_1))
    return var_2;

  var_3 = [];

  for(var_4 = 0; var_4 < var_1; var_4++)
    var_3 = scripts\engine\utility::array_add(var_3, var_2[var_4]);

  return var_3;
}

_id_77E5(var_0, var_1, var_2) {
  var_3 = scripts\sp\utility::_id_77DA(var_0);

  if(!isDefined(var_1))
    return var_3;

  var_4 = [];

  if(isDefined(var_2))
    var_3 = sortbydistance(var_3, var_2);

  for(var_5 = 0; var_5 < var_1; var_5++)
    var_4 = scripts\engine\utility::array_add(var_4, var_3[var_5]);

  return var_4;
}

_id_13780(var_0, var_1, var_2, var_3, var_4) {
  scripts\engine\utility::waitframe();
  var_5 = [];

  foreach(var_7 in var_0) {
    if(isstring(var_7)) {
      var_5 = scripts\engine\utility::array_combine(var_5, scripts\sp\utility::_id_77DA(var_7));
      continue;
    }

    var_5 = scripts\engine\utility::array_add(var_5, var_7);
  }

  _id_1377C(var_5, var_1, var_2, var_3, var_4);
}

_id_1377C(var_0, var_1, var_2, var_3, var_4) {
  scripts\engine\utility::waitframe();
  var_5 = "waittill_group";

  if(isstring(var_0)) {
    var_5 = var_5 + ("_" + var_0);
    var_0 = scripts\sp\utility::_id_77DA(var_0);
  }

  level notify(var_5);
  level endon(var_5);

  if(isDefined(var_4)) {
    var_4 = scripts\sp\maps\marsbase\marsbase_util::_id_2289(var_4);

    foreach(var_7 in var_4)
    self endon(var_7);
  }

  var_9 = 0;

  if(isDefined(var_1)) {
    var_9++;
    childthread _id_145C(var_0, var_1, var_5);
  }

  if(isDefined(var_3)) {
    var_9++;
    childthread _id_145D(var_0, var_3, var_5);
  }

  if(isDefined(var_2)) {
    if(var_9 == 0) {}

    childthread _id_145A(var_0, var_2, var_5);
  }

  if(var_9 == 0)
    childthread _id_145C(var_0, 0, var_5);

  level waittill(var_5);
}

_id_145D(var_0, var_1, var_2) {
  level endon(var_2 + "_timeout");
  wait(var_1);
  level notify(var_2);
}

_id_145A(var_0, var_1, var_2) {
  level endon(var_2 + "_num_killed");
  var_3 = 0;
  var_4 = level.player._id_10E53["kills"];

  while(level.player._id_10E53["kills"] - var_4 < var_1)
    scripts\engine\utility::waitframe();

  level notify(var_2);
}

_id_145C(var_0, var_1, var_2) {
  level endon(var_2 + "_num_left");

  for(;;) {
    var_0 = scripts\engine\utility::array_removeundefined(var_0);
    var_0 = scripts\sp\utility::_id_22B9(var_0);

    if(var_0.size <= var_1) {
      break;
    }

    wait 1;
  }

  level notify(var_2);
}

_id_F107(var_0) {
  var_0 = scripts\sp\maps\marsbase\marsbase_util::_id_2289(var_0);

  foreach(var_2 in var_0) {
    foreach(var_4 in scripts\sp\utility::_id_77DA(var_2)) {
      if(!isDefined(var_4._id_E87B))
        var_4 scripts\sp\utility::_id_D282();
    }
  }
}

_id_A657(var_0, var_1) {
  if(isDefined(var_1))
    var_1 = scripts\sp\maps\marsbase\marsbase_util::_id_2289(var_1);
  else
    var_1 = [self];

  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = var_4;

    if(isstring(var_5))
      var_5 = scripts\sp\utility::_id_77DA(var_5);

    if(isarray(var_5)) {
      var_2 = scripts\engine\utility::array_combine(var_2, var_5);
      continue;
    }

    var_2[var_2.size] = var_5;
  }

  scripts\engine\utility::array_thread(var_2, ::_id_A659, var_0);
}

_id_A659(var_0) {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  self endon("death");
  self._id_C3B1 = self._id_2894;
  var_0 = scripts\sp\maps\marsbase\marsbase_util::_id_2289(var_0);
  var_1 = 0;
  var_2 = undefined;

  for(;;) {
    var_3 = [];

    foreach(var_5 in var_0) {
      var_6 = var_5;

      if(isstring(var_6))
        var_6 = scripts\sp\utility::_id_77DA(var_6);

      if(isarray(var_6))
        var_3 = scripts\engine\utility::array_combine(var_3, var_6);
      else
        var_3[var_3.size] = var_6;

      if(!var_1) {
        scripts\sp\utility::_id_1938(var_3, 1024);
        var_1 = 1;
      }
    }

    var_3 = scripts\engine\utility::array_removeundefined(var_3);
    var_3 = scripts\sp\utility::_id_DFEB(var_3);

    foreach(var_9 in sortbydistance(var_3, self.origin)) {
      if(!isDefined(var_9) || !isalive(var_9)) {
        continue;
      }
      if(isDefined(var_9._id_A65E) && isDefined(var_2) && !var_2) {
        continue;
      }
      var_2 = 1;

      if(isDefined(var_9._id_B14F))
        var_9 scripts\sp\utility::_id_1101B();

      var_9._id_A65E = self;
      scripts\sp\utility::_id_F39C(var_9);
      scripts\sp\utility::_id_F2D8(10000);
      var_9 scripts\engine\utility::waittill_notify_or_timeout("death", randomfloatrange(2, 4));

      if(isDefined(var_9) && isalive(var_9))
        var_9 _meth_81D0(var_9.origin, self);
    }

    if(!isDefined(var_2))
      var_2 = 0;
    else
      var_2 = undefined;

    scripts\engine\utility::waitframe();
  }

  scripts\sp\utility::_id_F2D8(self._id_C3B1);
}

_id_A65C(var_0, var_1, var_2) {
  if(isstring(var_0))
    var_0 = scripts\sp\utility::_id_77DA(var_0);
  else {
    var_0 = scripts\sp\maps\marsbase\marsbase_util::_id_2289(var_0);
    var_0 = scripts\engine\utility::array_removeundefined(var_0);
    var_0 = scripts\sp\utility::_id_22B9(var_0);
  }

  if(!isDefined(var_2))
    var_2 = 0;

  var_0 = sortbydistance(var_0, level.player.origin);

  if(var_0.size < var_2)
    return [];

  var_3 = var_0.size - var_2;

  for(var_4 = 0; var_4 < var_3; var_4++)
    var_0[var_4] scripts\engine\utility::delaythread(randomfloatrange(0, 3), ::_id_54C9, var_1);

  thread _id_12FE(var_0, var_2);
  var_5 = [];

  for(var_4 = var_3; var_4 < var_0.size; var_4++)
    var_5 = scripts\engine\utility::array_add(var_5, var_0[var_4]);

  var_5 = scripts\engine\utility::array_removeundefined(var_5);
  var_5 = scripts\sp\utility::_id_22B9(var_5);
  return var_5;
}

_id_12FE(var_0, var_1) {
  for(;;) {
    var_0 = scripts\engine\utility::array_removeundefined(var_0);
    var_0 = scripts\sp\utility::_id_22B9(var_0);

    if(var_0.size > var_1) {
      break;
    }

    wait 1;
  }

  _id_11012(var_0);
}

_id_11012(var_0) {
  var_0 = scripts\sp\maps\marsbase\marsbase_util::_id_2289(var_0);
  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  var_0 = scripts\sp\utility::_id_22B9(var_0);

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_1631)) {
      if(isalive(var_2._id_1631)) {
        var_2._id_1631.favoriteenemy = undefined;
        var_2._id_1631._id_A658 = undefined;
        var_2._id_1631 scripts\sp\utility::_id_F2D8(var_2._id_1631._id_C3B1);
      }
    }

    var_2 notify("stop_dieByMyHand");
    var_2._id_A65B = undefined;
    var_2._id_1631 = undefined;
  }
}

_id_A65A(var_0, var_1) {
  var_2 = [];

  while(var_2.size < var_0) {
    self waittill("trigger", var_3);

    if(isDefined(var_3._id_A65B)) {
      if(!isDefined(scripts\engine\utility::array_find(var_2, var_3))) {
        var_3 scripts\engine\utility::delaythread(randomfloatrange(1, 6), ::_id_54C9, var_1);
        var_2 = scripts\engine\utility::array_add(var_2, var_3);
      }
    }
  }
}

_id_54C9(var_0) {
  if(!isalive(self)) {
    return;
  }
  self endon("death");
  self endon("stop_dieByMyHand");
  scripts\sp\maps\marsbase\marsbase_util::_id_1101C();
  var_1 = undefined;

  if(isDefined(var_0)) {
    var_0 = scripts\sp\maps\marsbase\marsbase_util::_id_2289(var_0);
    var_2 = [];

    foreach(var_1 in var_2) {
      if(!isDefined(var_1)) {
        continue;
      }
      if(isstring(var_0)) {
        var_4 = scripts\engine\utility::array_combine(var_2, scripts\sp\utility::_id_77DA(var_0));

        foreach(var_6 in var_4) {
          if(!isDefined(var_6.favoriteenemy))
            var_2 = scripts\engine\utility::array_add(var_2, var_6);
        }

        continue;
      }

      if(!isalive(var_1))
        continue;
      else if(isai(var_1) && !isDefined(var_1.favoriteenemy))
        var_2 = scripts\engine\utility::array_add(var_2, var_1);
    }

    var_9 = undefined;
    self._id_A65B = 1;

    foreach(var_1 in sortbydistance(var_2, self.origin)) {
      if(isDefined(var_1._id_A658)) {
        continue;
      }
      var_1._id_A658 = 1;
      var_1.favoriteenemy = self;
      self._id_1631 = var_1;
      var_9 = var_1;
      var_1._id_C3B1 = var_1._id_2894;
      var_1 scripts\sp\utility::_id_F2D8(1000);
      var_1 waittill("death");
    }
  }

  scripts\sp\maps\marsbase\marsbase_util::_id_4046(1);
}

_id_9677(var_0) {
  var_1 = "flag_vehicle_" + var_0;
  scripts\engine\utility::flag_init(var_1);
  var_2 = getEntArray(var_0, "script_noteworthy");
  var_3 = undefined;
  var_4 = undefined;

  foreach(var_6 in var_2) {
    if(isspawner(var_6)) {
      var_3 = var_6;
      continue;
    }

    if(var_6.classname == "script_brushmodel")
      var_4 = var_6;
  }

  var_8 = getnodearray(var_0, "script_noteworthy");
  var_4 connectpaths();
  var_4 notsolid();
  scripts\engine\utility::array_call(var_8, ::_meth_80AC);
  var_3 scripts\sp\utility::_id_1747(::_id_108C4, var_0, var_4, var_8, var_1);
}

_id_108C4(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level._id_1447))
    level._id_1447 = [];

  level._id_1447[var_0] = self;
  thread scripts\sp\maps\marsbase\marsbase_util::_id_C152("death", scripts\engine\utility::flag_set, var_3);
  self endon("death");
  var_1 connectpaths();

  if(isDefined(var_0) && var_0 == "vehicle_intro_atv_1") {
    var_5 = scripts\engine\utility::getStruct("iw7_fxanim_sp_mars_truck_01", "targetname");
    self setCanDamage(0);
    scripts\sp\utility::_id_23B7("base_intro_atv");
    var_5 scripts\sp\anim::_id_1F35(self, "fxanim_base_intro_atv");
    self notify("reached_dynamic_path_end");
    self setCanDamage(1);
    scripts\engine\utility::delaythread(0.25, ::_id_2562, self._id_E4FB, 1.75);
    self vehicle_setspeed(0, 20);
    scripts\sp\vehicle::_id_13253();
    scripts\sp\utility::_id_16AE(self, "aa1_gate_close");
  } else
    self waittill("reached_dynamic_path_end");

  var_1 solid();
  var_1 disconnectPaths();
  scripts\engine\utility::array_call(var_2, ::_meth_808B);
}

#using_animtree("generic_human");

_id_2562(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(isalive(var_3)) {
      var_3 _meth_82B1(%vh_org_4x4_atv_unload_front_guy1, var_1);
      var_3 _meth_82B1(%vh_org_4x4_atv_unload_front_guy2, var_1);
      var_3 _meth_82B1(%vh_org_4x4_atv_unload_rear_guy3, var_1);
    }
  }
}

_id_95BF() {
  foreach(var_1 in getEntArray("col_droppod", "targetname")) {
    var_1 connectpaths();
    var_1 notsolid();
  }
}

_id_106B2(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, "script_noteworthy");
  var_4 = [];
  var_5 = undefined;
  var_6 = undefined;

  foreach(var_8 in var_3) {
    if(issubstr(var_8.classname, "droppod")) {
      var_6 = var_8;
      var_6.count = 1;
      var_6.speed = 1500;

      if(isDefined(var_1))
        var_6.speed = var_1;
    }

    if(issubstr(var_8.classname, "node"))
      var_4 = scripts\engine\utility::array_add(var_4, var_8);

    if(issubstr(var_8.classname, "script_brushmodel"))
      var_5 = var_8;
  }

  thread _id_106B1(var_6, var_4, var_5, var_0, var_2);
}

_id_106B1(var_0, var_1, var_2, var_3, var_4) {
  wait(randomfloatrange(0, 1));
  var_5 = var_0 scripts\sp\utility::_id_10808();
  wait 0.05;

  if(isDefined(var_4))
    _id_106B4(var_5, var_0, var_2, var_4);

  var_5 waittill("landed");

  foreach(var_7 in var_5._id_E4FB)
  var_7 scripts\sp\utility::_id_B14F();

  wait 0.05;
  var_5 radiusdamage(var_5.origin, 55, 10000, 10000, var_5, "MOD_IMPACT");
  wait 0.05;

  foreach(var_7 in var_5._id_E4FB)
  var_7 scripts\sp\utility::_id_1101B();

  var_2 solid();
  var_2 disconnectPaths();
  wait 1;

  while(var_5._id_E4FB.size == 0)
    wait 1;

  level notify(var_3 + "_landed", var_5._id_E4FB);

  foreach(var_7 in var_5._id_E4FB) {
    if(isDefined(var_7._id_EDCF))
      var_7 scripts\sp\utility::_id_7226(level._id_8438[var_7._id_EDCF]);
  }

  thread _id_106B3(var_2);
}

_id_106B3(var_0) {
  var_1 = createnavobstaclebybounds(var_0.origin, (64, 64, 50), (0, 0, 0));

  if(!isDefined(var_0)) {
    destroynavobstacle(var_1);
    return;
  }

  var_0 waittill("death");
  destroynavobstacle(var_1);
}

_id_106B4(var_0, var_1, var_2, var_3) {
  scripts\sp\utility::_id_16AE(var_0, var_3);

  if(isDefined(var_1))
    scripts\sp\utility::_id_16AE(var_1, var_3);

  if(isDefined(var_2))
    scripts\sp\utility::_id_16AE(var_2, var_3);

  if(isDefined(var_0._id_226D)) {
    foreach(var_5 in var_0._id_226D)
    scripts\sp\utility::_id_16AE(var_5, var_3);
  }
}

_id_112BE(var_0, var_1, var_2, var_3) {
  var_2 = scripts\sp\maps\marsbase\marsbase_util::_id_2289(var_2);
  var_4 = getEnt(var_0, "targetname") scripts\sp\utility::_id_10808();

  for(var_5 = 0; var_5 < var_2.size; var_5++) {
    if(isstring(var_2[var_5]))
      var_2[var_5] = getEnt(var_2[var_5], "targetname");
  }

  var_4 thread _id_0BDC::_id_19AB(80);
  var_6 = scripts\engine\utility::getStruct(var_1, "targetname");
  var_4 thread _id_0BDC::_id_A1EC(var_6.origin, 1, 32);
  var_4 _id_0C20::_id_13912();
  var_4 waittill("goal");
  var_4 thread _id_0BDC::_id_19A4(1);
  var_4 thread _id_0BDC::_id_19B2("face angle", var_6.angles);
  wait 1;
  var_4 thread _id_0BDC::_id_B156(1, var_2[0], 0, 0);
  var_2[0] waittill("missile_hit");
  var_7 = var_2[0] scripts\engine\utility::spawn_tag_origin();
  playFXOnTag(scripts\engine\utility::getfx("aa_explosion"), var_7, "tag_origin");
  playworldsound("frag_grenade_explode", var_7.origin);
  scripts\engine\utility::array_call(var_2, ::connectpaths);
  scripts\engine\utility::array_call(var_2, ::delete);
  var_7 scripts\engine\utility::delaycall(0.05, ::delete);
  var_4 thread _id_0BDC::_id_19A4(0);
  var_4 thread _id_0BDC::_id_A1EF(scripts\sp\utility::_id_7C9A(var_3));
  var_4 thread _id_0C24::_id_517E();
}

bug_test_move_startpoint(var_0) {
  var_1 = spawnStruct();
  var_1._id_14E3 = [];
  var_2 = getEntArray(var_0, "targetname");

  foreach(var_4 in var_2) {
    if(isDefined(var_4.model) && var_4.model == "iw7_fxanim_sp_mars_aa_turret_gun_mod") {
      var_1.turret = var_4;
      var_1.turret hide();
      var_1.turret scripts\sp\utility::_id_23B7("animname_" + var_0);
    }

    if(isDefined(var_4.model) && var_4.model == "turret_tower_pmars_mid_tower") {
      var_1._id_129CC = var_4;
      var_1._id_129CC hide();
    }

    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "aa_gun_death_clip") {
      var_4 notsolid();
      var_1._id_14E3 = scripts\engine\utility::array_add(var_1._id_14E3, var_4);
    }
  }

  var_1._id_129E1 = _id_77C7(var_0);

  if(isDefined(var_1._id_129E1)) {
    var_1._id_129E1 hide();

    if(isDefined(var_1._id_129E1.target)) {
      var_6 = getEnt(var_1._id_129E1.target, "targetname");

      if(isDefined(var_6)) {
        var_6 notsolid();
        var_1._id_14E3 = scripts\engine\utility::array_add(var_1._id_14E3, var_6);
      }
    }
  }

  var_1 thread _id_14EC(var_0);
  level.gun[var_0] = var_1;
  return var_1;
}

_id_14EB(var_0) {
  if(isDefined(level.gun[var_0].turret))
    level.gun[var_0].turret show();

  if(isDefined(level.gun[var_0]._id_129CC))
    level.gun[var_0]._id_129CC show();
}

_id_14EC(var_0) {
  self.turret endon("death");

  if(!isDefined(self) || !isDefined(self.turret)) {
    return;
  }
  level waittill(var_0 + "_targeted");
  self.turret._id_2706 = 1;
  self.turret notify("stop_continuous_fire");
  self.turret notify("stop_firing");
  self.turret _meth_83A1();
  level.player scripts\sp\utility::_id_135F1("mars_killstreak_outro_black", 1);

  if(isDefined(self._id_129E1) && scripts\engine\utility::is_true(self._id_129E1._id_271D)) {
    self.turret.angles = (0, 0, 0);
    self.turret thread scripts\sp\anim::_id_1F35(self.turret, "fxanim_aa_gun_pre_death");
  } else if(isDefined(self._id_129E1)) {
    self._id_129E1 show();
    self._id_129E1 scripts\sp\utility::_id_23B7("animname_" + var_0 + "_death");
    self._id_129E1 scripts\sp\anim::_id_1EC3(self._id_129E1, "fxanim_" + var_0);
    self._id_129E1 hide();
    var_1 = self._id_129E1 gettagangles("turret_swivel_jnt") + (0, 135, 0);
    self.turret.angles = var_1;
  }
}

_id_DFB4(var_0, var_1) {
  if(scripts\engine\utility::is_true(var_1))
    wait 0.25;

  if(isDefined(level.gun[var_0])) {
    level.gun[var_0].turret delete();

    if(isDefined(level.gun[var_0]._id_129E1)) {
      level.gun[var_0]._id_129CC delete();

      if(scripts\engine\utility::is_true(var_1)) {
        level.gun[var_0]._id_129E1 show();
        level.gun[var_0]._id_129E1 scripts\sp\utility::_id_23B7("animname_" + var_0 + "_death");
        level.gun[var_0]._id_129E1 thread scripts\sp\anim::_id_1F35(level.gun[var_0]._id_129E1, "fxanim_" + var_0);
      } else {
        level.gun[var_0]._id_129E1 show();
        level.gun[var_0]._id_129E1 scripts\sp\utility::_id_23B7("animname_" + var_0 + "_death");
        level.gun[var_0]._id_129E1 thread scripts\sp\anim::_id_1EE0(level.gun[var_0]._id_129E1, "fxanim_" + var_0);
      }

      if(isDefined(level.gun[var_0]._id_14E3)) {
        foreach(var_3 in level.gun[var_0]._id_14E3) {
          var_3 solid();

          if(level.player istouching(var_3))
            level.player _meth_81D0();
        }
      }
    }

    level.gun[var_0] = undefined;
  }
}

_id_77C7(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "aa_gun_1_1":
      var_1 = getEnt("fxanim_sp_mars_aa_turret_explosion_01", "targetname");
      var_1._id_271D = 1;
      scripts\sp\utility::_id_16AE(var_1, "aa1");
      break;
    case "aa_gun_1_2":
      var_1 = getEnt("fxanim_sp_mars_aa_turret_explosion_02", "targetname");
      var_1._id_271D = 1;
      scripts\sp\utility::_id_16AE(var_1, "aa1");
      break;
    case "aa_gun_2":
      var_1 = getEnt("fxanim_sp_mars_aa_turret_explosion_03", "targetname");
      var_1._id_271D = 1;
      scripts\sp\utility::_id_16AE(var_1, "aa2");
      break;
    case "aa_gun_3":
      break;
    case "aa_gun_4":
      break;
    default:
      break;
  }

  return var_1;
}

#using_animtree("script_model");

_id_14E2(var_0, var_1, var_2) {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.turret)) {
    return;
  }
  if(scripts\engine\utility::is_true(self.turret._id_2706)) {
    return;
  }
  self.turret notify("stop_loop");
  self notify("stop_firing");
  self.turret notify("stop_firing");
  self endon("stop_firing");
  self endon("death");
  self.turret endon("death");
  self.turret endon("stop_continuous_fire");

  for(;;) {
    self.turret notify("stop_firing");
    self.turret thread scripts\sp\anim::_id_1EEA(self.turret, "fxanim_aa_gun_fire", "stop_firing");
    var_3 = getanimlength(%iw7_fxanim_sp_mars_aa_turret_gun_loop_anim);
    wait(var_3);
  }
}

_id_F563(var_0) {
  self.turret notify("stop_firing");
  scripts\engine\utility::waitframe();
  self.turret _meth_83A1();

  if(isDefined(var_0)) {
    var_1 = self.turret.origin - var_0.origin;
    var_1 = vectortoangles(var_1);
    var_2 = var_1[1];
    self.turret rotateYaw(var_2, 2);
    self.turret scripts\sp\utility::_id_135F1("rotatedone", 3);
  }
}

_id_F287(var_0) {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.turret)) {
    return;
  }
  thread _id_1155(var_0);
}

_id_1155(var_0) {
  self notify("change_targets");
  self endon("change_targets");
  self endon("death");
  self.turret endon("death");
  var_1 = undefined;

  if(isent(var_0)) {
    var_0 endon("death");
    var_1 = var_0.origin;
  } else if(isvector(var_0))
    var_1 = var_0;
  else if(isstruct(var_0))
    var_1 = var_0.origin;
  else
    return;

  var_2 = 0.5;

  while(isDefined(var_1)) {
    var_3 = self.turret.origin - var_1;
    var_3 = vectortoangles(var_3);
    self.turret rotateTo((0, var_3[1], 0), var_2);
    self.turret waittill("rotatedone");
    self notify("found_target");
    scripts\engine\utility::waitframe();
  }
}

_id_14E6(var_0) {
  _id_14E1("top");
}

_id_14E5(var_0) {
  _id_14E1("bottom");
}

_id_14E1(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = [];
  var_4 = 35000;
  var_5 = 3000;

  if(var_0 == "top") {
    var_1[0] = self gettagorigin("fx_barrel_1_jnt");
    var_1[1] = self gettagorigin("fx_barrel_2_jnt");
    var_3[0] = self gettagangles("fx_barrel_1_jnt");
    var_3[1] = self gettagangles("fx_barrel_2_jnt");
  } else {
    var_1[0] = self gettagorigin("fx_barrel_3_jnt");
    var_1[1] = self gettagorigin("fx_barrel_4_jnt");
    var_3[0] = self gettagangles("fx_barrel_3_jnt");
    var_3[1] = self gettagangles("fx_barrel_4_jnt");
  }

  var_1[0] = var_1[0] + anglesToForward(var_3[0]) * 20;
  var_2[0] = var_1[0] + anglesToForward(var_3[0]) * var_4;
  var_1[1] = var_1[1] + anglesToForward(var_3[1]) * 20;
  var_2[1] = var_1[1] + anglesToForward(var_3[1]) * var_4;
  var_6 = magicbullet("mars_aa_projectile", var_1[0], var_2[0]);
  var_7 = magicbullet("mars_aa_projectile", var_1[0], var_2[0]);

  if(isDefined(var_6) && isDefined(var_7)) {
    self playSound("mars_aa_fire_single");
    self playRumbleOnEntity("mars_aa_gun");
    earthquake(0.3, 0.5, self.origin, var_5);
    self notify("fired_projectile");
    var_8 = 45;
    var_9 = 5000;

    if(isDefined(level._id_14A3)) {
      level._id_14A3 = scripts\sp\utility::_id_22B9(level._id_14A3);
      var_10 = [];

      foreach(var_12 in level._id_14A3) {
        if(scripts\engine\utility::within_fov(self.origin, self gettagangles("fx_barrel_1_jnt"), var_12.origin, cos(var_8)) && distance(self.origin, var_12.origin) < var_9 && var_12.team == "allies")
          var_10 = scripts\engine\utility::array_add(var_10, var_12);
      }

      var_14 = scripts\sp\utility::_id_78BB(self.origin, var_10, var_9);

      if(isalive(var_14))
        var_14 thread scripts\sp\maps\marsbase\marsbase_sky_cowbell::_id_A1B9(0.05);
    }
  }
}

_id_14E4(var_0) {
  var_1 = undefined;

  if(isent(var_0)) {
    var_0 endon("death");
    var_1 = var_0.origin;
  } else if(isvector(var_0))
    var_1 = var_0;
  else if(isstruct(var_0))
    var_1 = var_0.origin;
  else
    return;

  if(isDefined(var_0) && isDefined(self._id_38D6)) {
    var_2 = self._id_38D6 gettagorigin("tag_flash_1");
    var_3 = self._id_38D6 gettagorigin("tag_flash_2");
    var_4 = self._id_38D6 gettagorigin("tag_flash_3");
    var_5 = self._id_38D6 gettagorigin("tag_flash_4");

    if(distance2d(level.player.origin, self._id_38D6.origin) < 200)
      scripts\sp\utility::_id_5FC7(self._id_38D6.origin);

    var_6 = magicbullet("mars_aa_projectile", var_2, var_1 + _id_14EA());
    wait(randomfloatrange(0, 0.15));
    var_6 = magicbullet("mars_aa_projectile", var_3, var_1 + _id_14EA());
    wait(randomfloatrange(0, 0.15));
    var_6 = magicbullet("mars_aa_projectile", var_4, var_1 + _id_14EA());
    wait(randomfloatrange(0, 0.15));
    var_6 = magicbullet("mars_aa_projectile", var_5, var_1 + _id_14EA());
    wait(randomfloatrange(0, 0.15));
  }
}

_id_14EA() {
  if(scripts\engine\utility::cointoss())
    var_0 = (randomfloatrange(-2, 2), randomfloatrange(-2, 2), randomfloatrange(-2, 2));
  else
    var_0 = (0, 0, 0);

  return var_0;
}

_id_14E8(var_0, var_1) {
  scripts\engine\utility::flag_init(var_0 + "_destroyed");
  thread scripts\sp\maps\marsbase\marsbase_killstreak::_id_B262(var_0);
  var_2 = [];
  var_2["aa_gun_1_1"] = "vfx_exp_turret_one";
  var_2["aa_gun_1_2"] = "vfx_exp_turret_two";
  var_2["aa_gun_2"] = "vfx_exp_turret_three";
  var_2["aa_gun_3"] = "vfx_exp_turret_five";
  var_2["aa_gun_4"] = "vfx_exp_turret_four";

  for(;;) {
    level waittill("aagun_destroyed", var_3);

    if(var_3 == var_0) {
      break;
    }
  }

  scripts\engine\utility::flag_set(var_0 + "_destroyed");
  level notify(var_0 + "_destroyed");
  scripts\engine\utility::exploder(var_2[var_0]);
  playworldsound("mars_base_jackal_scr_explo", level.gun[var_0].turret.origin);
  _id_DFB4(var_0, var_1);
}

_id_2876(var_0, var_1, var_2) {
  var_3 = _id_0BBF::_id_106B8(undefined, var_1, undefined, var_0, undefined, var_2);
  var_3 _id_0BBF::_id_F457();
  var_3._id_5971 = 1;
  var_3 scripts\sp\utility::_id_65E0("ent_flag_open_door");
  var_3 scripts\sp\utility::_id_65E0("ent_flag_landed");
  var_3 thread _id_2877();
  var_3 _id_0BBF::_id_5E02(var_1);
  var_3 scripts\sp\utility::_id_65E3("ent_flag_open_door");
  var_3 playSound("mars_base_dropship_door_open");
  var_3 _id_0BBC::_id_C5F1("back");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\marsbase\marsbase_util::_id_9312);
  return var_3;
}

_id_2877() {
  wait 0.1;
  self playSound("mars_base_dropship3_flyin");
}

_id_2879(var_0) {
  self._id_5971 = 1;
  self._id_4D94._id_4348 unlink();
  self._id_4D94._id_4348 _meth_80AF();

  if(isDefined(var_0)) {
    self._id_BE6D = [];
    self vehicle_setspeedimmediate(0, 100, 100);

    foreach(var_2 in var_0) {
      var_3 = getnode(var_2[0], "script_noteworthy");
      var_3 _id_F444();
      var_4 = getnode(var_2[1], "script_noteworthy");
      self._id_BE6D = scripts\engine\utility::array_add(self._id_BE6D, var_2[0]);
      createnavlink(var_2[0], var_3.origin, var_4.origin, var_3);
    }
  }
}

_id_F444() {
  self._id_10DCE = self.angles;
  self._id_A4C9 = self._id_A4C8 - self.origin;
  self._id_126D4 = self._id_A4C8[2];
  self._id_126D5 = self._id_A4C8[2] - self.origin[2];
}

_id_2878(var_0, var_1, var_2) {
  if(isDefined(self._id_BE6D)) {
    foreach(var_4 in self._id_BE6D)
    destroynavlink(var_4);
  }

  self._id_4D94._id_4348 _meth_83C9();
  self._id_4D94._id_4348 linkTo(self);
  _id_0BBC::_id_4265();

  if(scripts\engine\utility::flag_exist(var_0))
    scripts\engine\utility::flag_set(var_0);
  else {
    scripts\engine\utility::flag_init(var_0);
    scripts\engine\utility::flag_set(var_0);
  }

  if(isDefined(var_1) && isDefined(var_2))
    var_2 scripts\sp\anim::_id_1F35(self, var_1);
  else
    self waittill("reached_dynamic_path_end");

  self delete();
}