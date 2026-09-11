/**************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_br_syrk\objectives\cp_morales_objective.gsc
**************************************************************************/

function registermoralesobjectives() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\cp\cp_objectives::registerobjective("morales_infil_house_1", &initmoralesinfilobj, &startmoralesinfilobj, &completemoralesinfilobj, undefined, &debugmoralesobjectivesstart);
  scripts\cp\cp_objectives::registerobjective("morales_hack_laptop_2", &initmoraleshackobj, &startmoraleshackobj, &completemoraleshackobj, undefined, &debugmoralesobjectivesstart);
  scripts\cp\cp_objectives::registerobjective("morales_rescue_hvt_3", &initmoralesrescueobj, &startmoralesrescueobj, &completemoralesrescueobj, undefined, &debugmoralesobjectivesstart);
  scripts\cp\cp_objectives::registerobjective("morales_signal_heli_4", &initmoralessignalobj, &startmoralessignalobj, &completemoralessignalobj, undefined, &debugmoralesobjectivesstart);
  scripts\cp\cp_objectives::registerobjective("morales_holdout_5", &initmoralesholdoutobj, &startmoralesholdoutobj, &completemoralesholdoutobj, undefined, &debugmoralesobjectivesstart);
  scripts\cp\cp_objectives::registerobjective("morales_slow_load_hvt_6", &initmoralesslowloadobj, &startmoralesslowloadobj, &completemoralesslowloadobj, undefined, &debugmoralesobjectivesstart);
  scripts\cp\cp_objectives::registerobjective("morales_fast_load_hvt_6", &initmoralesfastloadobj, &startmoralesfastloadobj, &completemoralesfastloadobj, undefined, &debugmoralesobjectivesstart);
  scripts\cp\cp_interaction::registerinteraction("morales_laptop_interaction", &hintmoraleslaptop, &activationmoraleslaptop, &initmoraleslaptop, 0, "duration_long");
  initobjspawners();
  scripts\cp\cp_pickup_hostage::registerhvtscriptmodels();
}

function waitforoneplayernearpoint(var_0, var_1, var_2) {
  jumpiftrue(isDefined(var_2)) LOC_0000000c;
  var_2 = 0;

  for(;;) {
    var_3 = 0;
    var_4 = 0;

    foreach(var_6 in level.players) {
      if(distance(var_6.origin, var_0) <= var_1) {
        var_3 = 1;
      }
    }

    if(var_2) {
      if(!isDefined(level.moraleshostage)) {
        initmoraleshvtmodel();
      }

      if(distance(level.moraleshostage.origin, var_0) > var_1) {
        var_4 = 1;
      }

      if(var_3 && var_4) {
        break;
      }
    } else if(var_3) {
      break;
    }

    wait 0.5;
  }
}

function waitforallplayersnearpoint(var_0, var_1, var_2) {
  var_3 = 0;
  jumpiftrue(isDefined(var_2)) LOC_00000010;
  var_2 = 0;

  while(!var_3) {
    var_3 = 1;

    foreach(var_5 in level.players) {
      if(distance(var_5.origin, var_0) > var_1) {
        var_3 = 0;
      }
    }

    if(var_2) {
      if(distance(level.moraleshostage.origin, var_0) > var_1) {
        var_3 = 0;
      }
    }

    wait 0.5;
  }
}

function waitformoralesdropnearpoint(var_0, var_1, var_2) {
  level endon("game_ended");

  for(;;) {
    var_1 waittill("dropped");

    if(scripts\engine\utility::distance_2d_squared(var_1.origin, var_0) <= var_2 * var_2) {
      return 1;
    }

    waitframe();
  }
}

function initmoraleshvtmodel(var_0) {
  if(!isDefined(var_0)) {
    var_0 = scripts\engine\utility::getStruct("morales_hvt_object", "script_noteworthy").origin;
  }

  level.moraleshostage = scripts\cp\cp_pickup_hostage::initdefaulthvtmodel(var_0, "body_opforce_london_terrorist_1_bomb_vest", "head_female_bc_01", &"CP_BR_SYRK_OBJECTIVES/PICK_MORALES", "drop_morales_hostage");
}

function initmoraleslaptop(var_0) {
  if(var_0.size > 0) {
    level.morales_laptop_int_struct = var_0[0];
    level.morales_laptop_int_struct.laptopactive = 0;

    if(isDefined(level.objectivestabledata["morales_hack_laptop_2"])) {
      level.morales_laptop_int_struct.objectivestruct = level.objectivestabledata["morales_hack_laptop_2"];
      return;
    }

    return;
  }
}

function hintmoraleslaptop(var_0, var_1) {
  if(istrue(level.morales_laptop_int_struct.laptopactive)) {
    return &"CP_SURIVAL/HACK";
  }

  return "";
}

function initmoralessignal(var_0) {
  if(var_0.size > 0) {
    level.morales_signal_struct = var_0[0];
    level.morales_signal_struct.available = 0;
    return;
  }
}

function hintmoralessignal(var_0, var_1) {
  if(istrue(level.morales_signal_struct.available)) {
    return &"CP_BR_SYRK_OBJECTIVES/SET_SIGNAL";
  }

  return "";
}

function activationmoralessignal(var_0, var_1) {
  if(!istrue(level.morales_signal_struct.available)) {
    return;
  }

  level notify("morales_signal_activated");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  level.morales_signal_struct.available = 0;
}

function activationmoraleslaptop(var_0, var_1) {
  if(!istrue(level.morales_laptop_int_struct.laptopactive)) {
    return;
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_0.objectivestruct notify("start_hacking_morales_laptop", var_0);
  scripts\cp\cp_objective_mechanics::starthackingdefense(var_0.objectivestruct, scripts\engine\utility::getStruct("obj1_HVT_hack_location", "script_noteworthy").origin + (0, 150, 50), 120, "morales_laptop_activated");
}

function initobjspawners() {
  var_0 = &scripts\cp\cp_modular_spawning::registerambientgroup;
  [[var_0]]("morales_infil_house_1", 6, 8, 8, 0.5, undefined, "morales_obj1", undefined, undefined, undefined);
  [[var_0]]("morales_hack_laptop_2", 8, 12, 200, [ &waitbetweenspawnwaveswithtimeout, 0.1, 15], undefined, "morales_obj2", &watchforstopwaves, undefined, undefined);
  [[var_0]]("morales_rescue_hvt_3_A", 3, 3, 6, 0.05, undefined, "morales_obj3_A", undefined, undefined, undefined);
  [[var_0]]("morales_rescue_hvt_3_B", 3, 3, 6, 0.05, undefined, "morales_obj3_B", undefined, undefined, undefined);
  [[var_0]]("morales_rescue_hvt_3_C", 3, 3, 6, 0.05, undefined, "morales_obj3_C", undefined, undefined, undefined);
  [[var_0]]("morales_rescue_hvt_3_D", 3, 3, 6, 0.05, undefined, "morales_obj3_D", undefined, undefined, undefined);
  [[var_0]]("morales_signal_heli_4", 6, 10, 10, 0.05, undefined, "morales_obj4", undefined, undefined, undefined);
  [[var_0]]("morales_holdout_5_NW", 2, 7, 7, [ &waitbetweenspawnwaveswithtimeout, 0.1, 7], undefined, "morales_obj5_NW", &watchforstopwaves, &getnextholdoutspawnmodule, undefined);
  [[var_0]]("morales_holdout_5_SW", 2, 7, 7, [ &waitbetweenspawnwaveswithtimeout, 0.1, 7], undefined, "morales_obj5_SW", &watchforstopwaves, &getnextholdoutspawnmodule, undefined);
  [[var_0]]("morales_holdout_5_SE", 2, 7, 7, [ &waitbetweenspawnwaveswithtimeout, 0.1, 7], undefined, "morales_obj5_SE", &watchforstopwaves, &getnextholdoutspawnmodule, undefined);
  [[var_0]]("morales_holdout_5_OS", 2, 7, 7, [ &waitbetweenspawnwaveswithtimeout, 0.1, 7], undefined, "morales_obj5_overseers", &watchforstopwaves, &getnextholdoutspawnmodule, undefined);
  [[var_0]]("morales_holdout_5_Bombers", 1, 2, 200, &waitbetweenbomberwaves, undefined, "morales_obj5_bomber", &watchforstopwaves, undefined, undefined);
  [[var_0]]("morales_slow_load_hvt_6", 5, 18, 200, [ &waitbetweenspawnwaves, 0.1, 0.1], undefined, "morales_slow_exfil", &watchforstopwaves, undefined, undefined);
  [[var_0]]("morales_fast_load_hvt_6", 5, 18, 200, [ &waitbetweenspawnwaves, 0.1, 0.1], undefined, "morales_obj6_fast", &watchforstopwaves, undefined, undefined);
}

function waitbetweenspawnwaves(var_0, var_1, var_2, var_3) {
  level endon("game_ended");

  if(var_0.activecount >= var_0.max_size) {
    while(var_0.activecount <= var_0.max_size && var_0.activecount) {
      wait 0.1;
    }

    wait 1;
  }

  if(var_0.activecount <= var_0.min_size) {
    return var_1;
  }

  return var_2;
}

function waitbetweenspawnwaveswithtimeout(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_4 = gettime();
  var_5 = var_4 + var_2 * 1000;

  if(var_0.activecount >= var_0.max_size) {
    while(var_0.activecount <= var_0.max_size && var_0.activecount && gettime() <= var_5) {
      wait 0.1;
    }

    wait 1;
  }

  return var_1;
}

function waitbetweenbomberwaves(var_0) {
  level endon("game_ended");
  var_1 = scripts\cp\cp_objectives::getobjectivestructfromref("morales_holdout_5");

  if(!isDefined(var_1.currentteam)) {
    return;
  }

  while(are_all_players_on_watchtower(var_1.currentteam)) {
    wait 2;
  }

  return randomint(10) + 5;
}

function are_all_players_on_watchtower(var_0) {
  var_1 = scripts\engine\utility::getStruct("tower1_upper_level", "script_noteworthy");

  if(!isDefined(var_1)) {
    return 0;
  }

  var_2 = scripts\cp\utility::getplayersinteam(var_0);
  var_3 = 1;

  foreach(var_5 in var_2) {
    if(distance(var_5.origin, var_1.origin) > 300) {
      var_3 = 0;
      break;
    }
  }

  return var_3;
}

function watchforstopwaves(var_0) {
  level endon("game_ended");
  thread _watchforstopwaves(level);

  if(var_0.group_name == "morales_holdout_5_OS") {
    thread watchforoverseerskilled(level);
    return;
  }

  if(issubstr(var_0.group_name, "morales_holdout_5")) {
    thread swapcoverselector(level);
    return;
  }
}

function swapcoverselector(var_0) {
  level endon("game_ended");
  level endon("spawn_module_" + var_0.moduleid + "_completed");

  for(;;) {
    if(!isDefined(var_0.ai_spawned)) {
      wait 3;
      continue;
    }

    foreach(var_2 in var_0.ai_spawned) {
      if(!istrue(var_2.swappedcoverselector)) {
        var_2.defaultcoverselector = "cover_shotgunner";
        var_2.swappedcoverselector = 1;
      }
    }

    wait 1;
  }
}

function _watchforstopwaves(var_0) {
  level endon("game_ended");
  level scripts\engine\utility::ref_143a7("morales_laptop_activated", "morales_holdout_finished", "morales_exfiled", "morales_heli_exfil_defense_done");
  level notify("spawn_module_" + var_0.moduleid + "_completed");
}

function watchforoverseerskilled(var_0) {
  level endon("morales_holdout_completed");
  level endon("stop_morales_hvt_objectives");

  while(var_0.currentmodulekills < 10) {
    wait 0.5;
  }

  if(isDefined(level.objectivestabledata["morales_holdout_5"])) {
    level.objectivestabledata["morales_holdout_5"].earnedfastexfil = 1;
    return;
  }
}

function blockedwaittillgrouptimerdone(var_0) {
  wait 5;
}

function getnextholdoutspawnmodule(var_0) {
  if(!istrue(level.inmoralesholdout)) {
    return undefined;
  }

  for(var_1 = 0; var_0.activecount > 3 && var_1 <= 10; var_1++) {
    wait 1;
  }

  var_2 = undefined;

  switch (var_0.group_name) {
    case "morales_holdout_5_NW":
      if(!areplayersnearspawnarea("morales_holdout_spawner_SW")) {
        var_2 = "morales_holdout_5_SW";
      } else if(!areplayersnearspawnarea("morales_holdout_spawner_SE")) {
        var_2 = "morales_holdout_5_SE";
      } else {
        var_2 = "morales_holdout_5_NW";
      }

      break;
    case "morales_holdout_5_SW":
      if(!areplayersnearspawnarea("morales_holdout_spawner_SE")) {
        var_2 = "morales_holdout_5_SE";
      } else if(!areplayersnearspawnarea("morales_holdout_spawner_NW")) {
        var_2 = "morales_holdout_5_NW";
      } else {
        var_2 = "morales_holdout_5_SW";
      }

      break;
    case "morales_holdout_5_SE":
      var_2 = "morales_holdout_5_OS";
      break;
    case "morales_holdout_5_OS":
      if(!areplayersnearspawnarea("morales_holdout_spawner_NW")) {
        var_2 = "morales_holdout_5_NW";
      } else if(!areplayersnearspawnarea("morales_holdout_spawner_SW")) {
        var_2 = "morales_holdout_5_SW";
      } else {
        var_2 = "morales_holdout_5_SE";
      }

      break;
    default:
      var_2 = undefined;
      break;
  }

  return var_2;
}

function areplayersnearspawnarea(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0, "script_noteworthy");

  if(!isDefined(var_1)) {
    return false;
  }

  var_2 = 300;

  foreach(var_4 in level.players) {
    if(scripts\engine\utility::distance_2d_squared(var_4.origin, var_1.origin) <= var_2 * var_2) {
      return true;
    }
  }

  return false;
}

function playsmokeflarevisualmarker(var_0) {
  var_1 = scripts\engine\utility::drop_to_ground(var_0, 50, -200, (0, 0, 1));
  var_1 += (0, 0, 1);
  var_2 = spawn("script_model", var_1);
  var_2 setModel("offhand_wm_grenade_smoke");
  var_2.angles = (0, 90, 90);
  var_3 = spawn("script_model", var_1);
  var_3 setModel("ks_crate_marker_mp");
  var_3 setscriptablepartstate("smoke", "on", 0);
  thread watchfordeletesmokeflarevisualmarker(var_2, var_3);
  wait 20;
  self notify("stop_smoke_flare");
}

function watchfordeletesmokeflarevisualmarker(var_0, var_1) {
  self waittill("stop_smoke_flare");
  var_0 delete();
  var_1 delete();
}

function debugmoralesobjectivesstart(var_0) {
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "morales_debug_start_loc");
}

function glstopmoralesquest() {
  var_0 = ["morales_infil_house_1", "morales_hack_laptop_2", "morales_rescue_hvt_3", "morales_signal_heli_4", "morales_holdout_5", "morales_slow_load_hvt_6", "morales_fast_load_hvt_6"];

  foreach(var_2 in var_0) {
    var_3 = scripts\cp\cp_objectives::getobjectivestructfromref(var_2);
    scripts\cp\cp_objectives::overridenextstep(var_3, undefined);
  }

  thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_decision_pilot_10", "allies");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/MORALES_STOP");
  level.savedmorales = 0;
  level notify("stop_morales_hvt_objectives");
}

function glstarthelidownevent() {
  scripts\cp\cp_objectives_events::try_start_event("objective_heli_down_start", "scripts/cp/maps/cp_br_syrk/cp_br_syrk_objectives_events2.csv", 1);
}

function glstophelidownevent() {
  scripts\cp\cp_objectives_events::stop_event("objective_heli_down_start");
  scripts\cp\cp_objectives_events::disable_repeating_event("objective_heli_down_start");
  thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_decision_hvi_10", "allies");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/PILOT_STOP");
  level.savedmorales = 1;

  if(isDefined(level.escort_vip)) {
    level.escort_vip setCanDamage(1);
    level.escort_vip dodamage(level.escort_vip.health + 100, level.escort_vip.origin);
  }

  level notify("objective_heli_down_kill_hvt");
  level notify("stop_helidown_event");
}

function waittostarthelidown() {
  wait 5;
  level thread scripts\cp\maps\cp_br_syrk\cp_br_syrk_objective_convoy::convoy_go_to_helidown_location();
  glstarthelidownevent();
  level waittill("heli_crashing");
  thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_decision_update_10", "allies");
  wait 2;
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/HELI_DOWN");
  wait 1;
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/HELI_DOWN_1");
  wait 1;
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/HELI_DOWN_2");
  wait 3;
  scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_BR_SYRK_GL_DIALOGUE/PICK_OBJECTIVE_GL", "allies", 5);
}

function initmoralesinfilobj(var_0, var_1) {}

function threadedbcloop() {}

function startmoralesinfilobj(var_0, var_1) {
  level endon("stop_morales_hvt_objectives");
  level thread scripts\cp\maps\cp_br_syrk\cp_br_syrk_objective_convoy::spawn_convoy_and_drive();

  if(getdvarint("scr_convoy_roam", 0) != 0) {
    glstopmoralesquest();
    return;
  }

  level notify("stop_safehouse_vo");
  thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_hvi_update_10", "allies");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/MORALES_1");
  wait 2;
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/MORALES_2");
  thread waittostarthelidown();
  waitforoneplayernearpoint(var_0.iconpos[0], 3000, 0);
  thread scripts\cp\cp_modular_spawning::run_spawn_module("morales_infil_house_1");
  waitforoneplayernearpoint(var_0.iconpos[0], 500, 0);
  thread glstophelidownevent();
  wait 2;
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/MORALES_3");
  wait 2;
}

function changetomorales2() {
  scripts\cp\cp_objectives::update_objective(self.ref, "current", (0, 0, 0), "CP_BR_SYRK_OBJECTIVES/MORALES_2", "CP_OBJECTIVES/HACK", 2, "icon_waypoint_marker", 1, 1, 1);
}

function changetomorales3() {
  scripts\cp\cp_objectives::update_objective(self.ref, "current", (4000, 0, 0), &"CP_BR_SYRK_OBJECTIVES/MORALES_3", &"CP_BR_SYRK_OBJECTIVES/FIND_MORALES", 3, "icon_waypoint_marker", 1, 1, 1);
}

function completemoralesinfilobj(var_0) {}

function initmoraleshackobj(var_0, var_1) {
  if(isDefined(level.morales_laptop_int_struct)) {
    level.morales_laptop_int_struct.laptopactive = 1;
    return;
  }
}

function startmoraleshackobj(var_0, var_1) {
  level endon("stop_morales_hvt_objectives");
  thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_hvi_laptop_10", "allies");
  thread nag_player_for_laptop(var_0);
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/MORALES_4");
  var_0 waittill("start_hacking_morales_laptop");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("morales_hack_laptop_2");
  var_0 waittill("morales_laptop_activated");
  level notify("morales_laptop_activated");
  wait 2;
}

function completemoraleshackobj(var_0) {}

function nag_player_for_laptop(var_0) {
  level endon("game_ended");
  var_0 endon("start_hacking_morales_laptop");

  for(;;) {
    wait 30;
    thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_hvi_laptop_20", "allies");
  }
}

function initmoralesrescueobj(var_0, var_1) {
  var_2 = randomint(2);
  var_3 = undefined;

  switch (var_2) {
    case 0:
    default:
      var_3 = "A";
      break;
    case 1:
      var_3 = "B";
      break;
  }

  var_4 = scripts\engine\utility::getStructArray("morales_hvt_loc", "script_noteworthy");
  var_5 = undefined;

  foreach(var_7 in var_4) {
    if(var_7.targetname == var_3) {
      var_5 = var_7;
      break;
    }
  }

  var_0.spawngroup = var_3;
  initmoraleshvtmodel(var_5.origin);
  objective_onentity(var_0.objectiveindex, level.moraleshostage);
}

function startmoralesrescueobj(var_0, var_1) {
  level endon("stop_morales_hvt_objectives");
  thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_hvi_laptop_30", "allies");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/MORALES_5");
  waitforoneplayernearpoint(level.moraleshostage.origin, 3000, 0);
  thread scripts\cp\cp_modular_spawning::run_spawn_module("morales_rescue_hvt_3_" + var_0.spawngroup);
  level waittill("player_picked_up_hostage", var_2);
  var_2 thread scripts\cp\cp_vo::try_to_play_vo("dx_cps_drjm_rescue_hvi_found_20", "cp_comment_vo");
  wait scripts\cp\cp_vo::get_sound_length("dx_cps_drjm_rescue_hvi_found_20");
  thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_hvi_found_10", "allies");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/MORALES_6");
}

function completemoralesrescueobj(var_0) {}

function initmoralessignalobj(var_0, var_1) {
  if(!isDefined(level.moraleshostage)) {
    initmoraleshvtmodel((-1962.19, -8728.35, 300.997));
  }

  var_0.customwaypointid = scripts\cp\cp_objectives::requestworldid("morales_signal_4", 15);
  var_2 = scripts\engine\utility::getStruct("obj1_HVT_defend_tower", "script_noteworthy");
  objective_setplayintro(var_0.customwaypointid, 1);
  objective_setplayoutro(var_0.customwaypointid, 1);
  objective_state(var_0.customwaypointid, "current");
  objective_position(var_0.customwaypointid, var_2.origin);
  objective_setdescription(var_0.customwaypointid, &"CP_BR_SYRK_OBJECTIVES/MORALES_4");
  objective_setlabel(var_0.customwaypointid, &"CP_BR_SYRK_OBJECTIVES/DROP_HOSTAGE");
  objective_icon(var_0.customwaypointid, "icon_waypoint_objective_general");
  objective_setbackground(var_0.customwaypointid, 1);
}

function startmoralessignalobj(var_0, var_1) {
  level endon("stop_morales_hvt_objectives");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("morales_signal_heli_4");
  var_2 = scripts\engine\utility::getStruct("obj1_HVT_defend_tower", "script_noteworthy");
  waitformoralesdropnearpoint(var_2.origin, level.moraleshostage, 300);

  if(isDefined(level.moraleshostage)) {
    level.moraleshostage scripts\cp\cp_pickup_hostage::togglehvtusable(0);
  }

  var_3 = scripts\engine\utility::getStruct("obj1_HVT_signal_exfil", "script_noteworthy");
  objective_state(var_0.customwaypointid, "done");
  wait 1;
  objective_position(var_0.customwaypointid, var_3.origin);
  objective_state(var_0.customwaypointid, "current");
  objective_setlabel(var_0.customwaypointid, &"CP_BR_SYRK_OBJECTIVES/SIGNAL_EXFIL");

  if(isDefined(level.morales_signal_struct)) {
    level.morales_signal_struct.available = 1;
  }

  level waittill("morales_signal_activated");
  thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_hvi_defend_10", "allies");
  var_4 = scripts\engine\utility::getStruct("canister_placeholder", "script_noteworthy");

  if(isDefined(var_4)) {
    thread playsmokeflarevisualmarker(level);
  }

  level notify("spawn_module_morales_signal_heli_4_completed");
  objective_delete(var_0.customwaypointid);
  scripts\cp\cp_objectives::freeworldid("morales_signal_4");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/MORALES_7");
  wait 1;
}

function completemoralessignalobj(var_0) {}

function initmoralesholdoutobj(var_0, var_1) {
  var_0.earnedfastexfil = 0;
}

function startmoralesholdoutobj(var_0, var_1) {
  level endon("stop_morales_hvt_objectives");
  level.inmoralesholdout = 1;
  thread scripts\cp\cp_modular_spawning::run_spawn_module("morales_holdout_5_SW");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("morales_holdout_5_Bombers");
  thread moralesholdoutmagicgrenadewatcher(level);

  if(true) {
    wait 60;
  }

  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/MORALES_8");
  thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_hvi_defend_60sec_10", "allies");
  wait 30;
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/MORALES_9");
  thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_hvi_defend_30sec_10", "allies");
  wait 30;
  thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_hvi_secondary_10", "allies");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/MORALES_11");
  scripts\cp\cp_objectives::overridenextstep(var_0, "morales_slow_load_hvt_6");
  level.inmoralesholdout = undefined;

  if(isDefined(level.moraleshostage)) {
    level.moraleshostage scripts\cp\cp_pickup_hostage::togglehvtusable(1);
  }

  level notify("morales_holdout_finished");
}

function completemoralesholdoutobj(var_0) {
  level notify("morales_holdout_completed");
}

function moralesholdoutmagicgrenadewatcher(var_0) {
  level endon("morales_holdout_completed");
  level endon("stop_morales_hvt_objectives");
  level endon("game_ended");
  var_1 = scripts\engine\utility::getStruct("tower1_upper_level", "script_noteworthy");
  var_2 = scripts\engine\utility::getStruct("tower1_grenade_origin", "script_noteworthy");
  jumpiffalse(!isDefined(var_1) || !isDefined(var_2)) LOC_00000047;
  return;
}

function initmoralesslowloadobj(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct("morales_slow_heli_B", "targetname");
  var_3 = scripts\engine\utility::getStruct("morales_debug_hvt_slow_spawn", "script_noteworthy");
  var_0.exfilstruct = var_2;

  if(!isDefined(level.moraleshostage)) {
    initmoraleshvtmodel(var_3.origin);
    return;
  }
}

function startmoralesslowloadobj(var_0, var_1) {
  level endon("stop_morales_hvt_objectives");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/MORALES_12");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("morales_slow_load_hvt_6");
  thread exfil_morales(level.moraleshostage, var_0);
  level waittill("morales_exfiled");

  foreach(var_3 in level.players) {
    var_3 thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("hvt_saved");
  }

  thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_hvi_exfil_10", "allies");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/MORALES_13");
  wait scripts\cp\cp_vo::get_sound_length("dx_cps_ovl_rescue_hvi_exfil_10");
}

function completemoralesslowloadobj(var_0) {}

function initmoralesfastloadobj(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct("morales_debug_hvt_fast_spawn", "script_noteworthy");
  var_3 = scripts\engine\utility::getStruct("morales_fast_heli_B", "targetname");
  var_0.exfilstruct = var_3;

  if(!isDefined(level.moraleshostage)) {
    initmoraleshvtmodel(scripts\engine\utility::drop_to_ground(var_2.origin));
    return;
  }
}

function startmoralesfastloadobj(var_0, var_1) {
  level endon("stop_morales_hvt_objectives");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("morales_fast_load_hvt_6");
  thread exfil_morales(level.moraleshostage, var_0);
  level waittill("morales_exfiled");

  foreach(var_3 in level.players) {
    var_3 thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("hvt_saved");
  }

  thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_hvi_exfil_10", "allies");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/MORALES_13");
  wait scripts\cp\cp_vo::get_sound_length("dx_cps_ovl_rescue_hvi_exfil_10");
}

function completemoralesfastloadobj(var_0) {}

function exfil_morales(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("bleedout");

  if(!isDefined(var_1.exfilstruct)) {
    var_1.exfilstruct = scripts\engine\utility::getStruct("morales_fast_heli_B", "targetname");
  }

  var_2 = var_1.exfilstruct;
  objective_setlabel(var_1.objectiveindex, "CP_BR_SYRK_OBJECTIVES/EXFIL_MORALES");
  objective_setshowprogress(var_1.objectiveindex, 0);
  objective_icon(var_1.objectiveindex, "icon_waypoint_extract");
  objective_position(var_1.objectiveindex, var_2.origin + (0, 0, -100));
  var_3 = spawn_evac_chopper(var_2);
  var_3.godmode = 1;
  var_3.health = 10000;
  var_3.maxhealth = 10000;
  vehicle_anims();
  script_model_anims(var_3);
  scripts\cp\cp_pickup_hostage::init_anims();
  var_3 scripts\cp\maps\cp_br_syrk\cp_br_syrk_objective_helidown::spawnhelihvtexfilactors();
  thread leave_if_vip_dies(var_3, var_0);
  thread start_nag_for_morales_exfil(var_1);

  for(;;) {
    var_4 = 0;

    foreach(var_6 in level.players) {
      if(!isDefined(var_6.hostagecarried)) {
        continue;
      }

      if(distancesquared(var_6.origin, var_3.exfil_struct.origin) < 6250000) {
        var_4 = 1;
        LOC_0000013c:
      }
      LOC_0000013c:
    }

    wait 1;
  }

  LOC_00000157:
    var_1 notify("stop_morales_exfil_nags");
  thread defend_while_chopper_arrives(var_1);
  var_1 waittill("defend_done");
  level notify("helidown_done");
  var_3 scripts\cp\infilexfil\blima_exfil::go_to_exfil_location(var_3.exfil_struct, 1);
  var_8 = anglesToForward(var_3.angles);
  var_9 = anglestoleft(var_3.angles);
  var_10 = var_3.origin;
  var_11 = var_10 + var_8 * 10 + var_9 * 64 + (0, 0, -110);
  objective_position(var_1.objectiveindex, var_11);
  objective_setlabel(var_1.objectiveindex, "CP_BR_SYRK_OBJECTIVES/EXFIL_MORALES");
  var_12 = spawn("trigger_radius", var_11 + (0, 0, -200), 0, 64, 500);

  for(;;) {
    var_12 waittill("trigger", var_6);

    if(!isDefined(var_6.hostagecarried)) {
      continue;
    }

    var_13 = var_6.hostagecarried;
    var_13 notify("stop_bleedout_timer");
    scripts\cp\cp_pickup_hostage::load_hvt(var_6, var_3);
    wait 1;
    break;
  }

  thread evac_hvt(level, var_3);
}

function start_nag_for_morales_exfil(var_0) {
  level endon("game_ended");
  var_0 endon("stop_morales_exfil_nags");

  for(;;) {
    wait 30;
    thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_hvi_exfil_nag_10", "allies");
  }
}

#using_animtree("mp_vehicles_always_loaded");

function spawn_evac_chopper(var_0) {
  var_1 = scripts\common\vehicle::vehicle_spawn(scripts\engine\utility::getStruct("player_exfil", "targetname"));
  var_1.vehicle_skipdeathmodel = 1;
  var_1.script_disconnectpaths = 0;
  var_1.death_fx_on_self = 1;
  var_1.exfil_struct = var_0;
  var_1 vehicleplayanim(%est_blima_doors_open);
  var_0.smoke_canister = scripts\cp\cp_objective_mechanics::smoke_canister_spawn(var_0.origin, 1);
  scripts\cp\infilexfil\blima_exfil::spawn_vehicle_actors(var_1);
  var_1 scripts\cp\infilexfil\blima_exfil::heli_mg_create();
  return var_1;
}

#using_animtree("");

function vehicle_anims() {
  level.scr_animtree["exfil_chopper"] = #animtree;
}

function evac_hvt(var_0, var_1) {
  var_0 vehicle_setspeed(5, 10);
  var_0 cleartargetyaw();
  var_0 setvehgoalpos(var_0.origin + (0, 0, 800), 1);
  wait 4;
  level notify("morales_exfiled");
  wait 4;
  var_0 vehicle_setspeed(90, 10);
  var_0 setvehgoalpos(var_0.origin + (10000, 10000, 500));
  wait 20;

  if(isDefined(var_1)) {
    var_1 scripts\cp\cp_pickup_hostage::deletepickuphostage();
  }

  if(isDefined(var_0.minigun)) {
    var_0.minigun delete();
  }

  if(isDefined(var_0.vmhvt)) {
    if(isDefined(var_0.vmhvt.head)) {
      var_0.vmhvt.head delete();
    }

    var_0.vmhvt delete();
  }

  if(isDefined(var_0.vmexfilally)) {
    if(isDefined(var_0.vmexfilally.head)) {
      var_0.vmexfilally.head delete();
    }

    var_0.vmexfilally delete();
  }

  var_0 delete();
}

function script_model_anims() {
  level.scr_animtree["exfil_guy"] = #animtree;
  level.scr_anim["exfil_guy"]["helidown_exfil"] = $cp_exfil_blima_hvt_lf_price;
  level.scr_animname["exfil_guy"]["helidown_exfil"] = "cp_exfil_blima_hvt_lf_price";
  level.scr_anim["exfil_guy"]["helidown_exfil_idle"] = % cp_exfil_blima_hvt_lf_price_idle;
  level.scr_animname["exfil_guy"]["helidown_exfil_idle"] = "cp_exfil_blima_hvt_lf_price_idle";
  level.scr_animtree["hvt"] = #animtree;
  level.scr_anim["hvt"]["helidown_exfil"] = % cp_exfil_blima_hvt_lf_hvt;
  level.scr_animname["hvt"]["helidown_exfil"] = "cp_exfil_blima_hvt_lf_hvt";
  level.scr_anim["hvt"]["helidown_exfil_idle"] = % cp_exfil_blima_hvt_lf_hvt_idle;
  level.scr_animname["hvt"]["helidown_exfil_idle"] = "cp_exfil_blima_hvt_lf_hvt_idle";
  level.scr_animtree["exfil_chopper"] = #animtree;
  level.scr_anim["exfil_chopper"]["blima_drop_l"] = % sdr_cp_hostage_dropoff_blima_l_blima;
  level.scr_animname["exfil_chopper"]["blima_drop_l"] = "sdr_cp_hostage_dropoff_blima_L_blima";
  level.scr_anim["exfil_chopper"]["blima_drop_r"] = % sdr_cp_hostage_dropoff_blima_r_blima;
  level.scr_animname["exfil_chopper"]["blima_drop_r"] = "sdr_cp_hostage_dropoff_blima_R_blima";
}

function spawnactors() {
  if(!isDefined(self.exfil_helpers)) {
    self.exfil_helpers = [];
  }

  self.exfil_helpers[self.exfil_helpers.size] = spawn_anim_model("exfil_guy", "body_animate_jnt", "fullbody_hero_price_urban");
}

function spawn_anim_model(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", (0, 0, 0));
  var_4 setModel(var_2);

  if(isDefined(var_3)) {
    var_5 = spawn("script_model", (0, 0, 0));
    var_5 setModel(var_3);
    var_5 linkTo(var_4, "j_spine4", (0, 0, 0), (0, 0, 0));
    var_4.head = var_5;
    var_4 thread scripts\engine\utility::delete_on_death(var_5);
  }

  var_4.animname = var_0;
  var_4 useanimtree(level.scr_animtree[var_4.animname]);

  if(isDefined(var_1)) {
    thread scripts\engine\utility::delete_on_death(var_4);
    var_4 linkTo(self, var_1, (0, 0, 0), (0, 0, 0));
  }

  return var_4;
}

function actor_animloop(var_0, var_1, var_2, var_3) {
  self endon(var_2);
  self endon("death");

  for(;;) {
    scripts\common\anim::anim_single(var_0, var_1, var_3);
    var_4 = getanimlength(level.scr_anim[var_0[0].animname][var_1]);
    wait var_4;
  }
}

function hostage_price_idle(var_0) {
  var_0 endon("death");
  self endon("death");

  for(;;) {
    var_0 scriptmodelplayanim(level.scr_anim[var_0.animname]["helidown_exfil_idle"]);

    if(isDefined(var_0.head)) {
      var_0.head scriptmodelplayanim(level.scr_anim[var_0.head.animname]["helidown_exfil_idle"]);
    }

    self.exfil_helpers[0] scriptmodelplayanim(level.scr_anim[self.exfil_helpers[0].animname]["helidown_exfil_idle"]);
    var_1 = getanimlength(level.scr_anim[self.exfil_helpers[0].animname]["helidown_exfil_idle"]);
    wait var_1;
  }
}

function defend_while_chopper_arrives(var_0) {
  objective_setlabel(var_0.objectiveindex, &"CP_BR_SYRK_OBJECTIVES/EXFIL_ENROUTE");
  objective_setshowprogress(var_0.objectiveindex, 1);
  objective_setprogress(var_0.objectiveindex, 0);
  var_1 = 20;
  var_2 = 20;

  for(;;) {
    wait 1;
    var_2--;
    objective_setprogress(var_0.objectiveindex, var_2 / var_1);

    if(var_2 <= 15) {
      var_0 notify("defend_done");
      level notify("morales_heli_exfil_defense_done");
    }

    if(var_2 <= 0) {
      return;
    }
  }
}

function leave_if_vip_dies(var_0, var_1) {
  level endon("game_ended");
  level endon("morales_exfiled");
  var_0 endon("exfil");
  var_2 = scripts\engine\utility::waittill_any_ents_return(var_1, "vip_died", var_0, "bleedout");
  self notify("stop_marker");

  if(self vehicle_getspeed() > 1) {
    self waittill("goal");
  }

  if(istrue(self.going_to_exfil)) {
    thread evac_hvt(self);
    return;
  }

  if(isDefined(var_0) && isalive(var_0)) {
    var_0.nocorpse = 1;
    var_0 dodamage(var_0.health + 100, var_0.origin);
  }

  self delete();
}