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

function waitforoneplayernearpoint(var0, var1, var2) {
  jumpiftrue(isDefined(var2)) LOC_0000000c;
  var2 = 0;

  for(;;) {
    var3 = 0;
    var4 = 0;

    foreach(var6 in level.players) {
      if(distance(var6.origin, var0) <= var1) {
        var3 = 1;
      }
    }

    if(var2) {
      if(!isDefined(level.moraleshostage)) {
        initmoraleshvtmodel();
      }

      if(distance(level.moraleshostage.origin, var0) > var1) {
        var4 = 1;
      }

      if(var3 && var4) {
        break;
      }
    } else if(var3) {
      break;
    }

    wait 0.5;
  }
}

function waitforallplayersnearpoint(var0, var1, var2) {
  var3 = 0;
  jumpiftrue(isDefined(var2)) LOC_00000010;
  var2 = 0;

  while(!var3) {
    var3 = 1;

    foreach(var5 in level.players) {
      if(distance(var5.origin, var0) > var1) {
        var3 = 0;
      }
    }

    if(var2) {
      if(distance(level.moraleshostage.origin, var0) > var1) {
        var3 = 0;
      }
    }

    wait 0.5;
  }
}

function waitformoralesdropnearpoint(var0, var1, var2) {
  level endon("game_ended");

  for(;;) {
    var1 waittill("dropped");

    if(scripts\engine\utility::distance_2d_squared(var1.origin, var0) <= var2 * var2) {
      return 1;
    }

    waitframe();
  }
}

function initmoraleshvtmodel(var0) {
  if(!isDefined(var0)) {
    var0 = scripts\engine\utility::getStruct("morales_hvt_object", "script_noteworthy").origin;
  }

  level.moraleshostage = scripts\cp\cp_pickup_hostage::initdefaulthvtmodel(var0, "body_opforce_london_terrorist_1_bomb_vest", "head_female_bc_01", &"CP_BR_SYRK_OBJECTIVES/PICK_MORALES", "drop_morales_hostage");
}

function initmoraleslaptop(var0) {
  if(var0.size > 0) {
    level.morales_laptop_int_struct = var0[0];
    level.morales_laptop_int_struct.laptopactive = 0;

    if(isDefined(level.objectivestabledata["morales_hack_laptop_2"])) {
      level.morales_laptop_int_struct.objectivestruct = level.objectivestabledata["morales_hack_laptop_2"];
      return;
    }

    return;
  }
}

function hintmoraleslaptop(var0, var1) {
  if(istrue(level.morales_laptop_int_struct.laptopactive)) {
    return &"CP_SURIVAL/HACK";
  }

  return "";
}

function initmoralessignal(var0) {
  if(var0.size > 0) {
    level.morales_signal_struct = var0[0];
    level.morales_signal_struct.available = 0;
    return;
  }
}

function hintmoralessignal(var0, var1) {
  if(istrue(level.morales_signal_struct.available)) {
    return &"CP_BR_SYRK_OBJECTIVES/SET_SIGNAL";
  }

  return "";
}

function activationmoralessignal(var0, var1) {
  if(!istrue(level.morales_signal_struct.available)) {
    return;
  }

  level notify("morales_signal_activated");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var0);
  level.morales_signal_struct.available = 0;
}

function activationmoraleslaptop(var0, var1) {
  if(!istrue(level.morales_laptop_int_struct.laptopactive)) {
    return;
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(var0);
  var0.objectivestruct notify("start_hacking_morales_laptop", var0);
  scripts\cp\cp_objective_mechanics::starthackingdefense(var0.objectivestruct, scripts\engine\utility::getStruct("obj1_HVT_hack_location", "script_noteworthy").origin + (0, 150, 50), 120, "morales_laptop_activated");
}

function initobjspawners() {
  var0 = &scripts\cp\cp_modular_spawning::registerambientgroup;
  [[var0]]("morales_infil_house_1", 6, 8, 8, 0.5, undefined, "morales_obj1", undefined, undefined, undefined);
  [[var0]]("morales_hack_laptop_2", 8, 12, 200, [ &waitbetweenspawnwaveswithtimeout, 0.1, 15], undefined, "morales_obj2", &watchforstopwaves, undefined, undefined);
  [[var0]]("morales_rescue_hvt_3_A", 3, 3, 6, 0.05, undefined, "morales_obj3_A", undefined, undefined, undefined);
  [[var0]]("morales_rescue_hvt_3_B", 3, 3, 6, 0.05, undefined, "morales_obj3_B", undefined, undefined, undefined);
  [[var0]]("morales_rescue_hvt_3_C", 3, 3, 6, 0.05, undefined, "morales_obj3_C", undefined, undefined, undefined);
  [[var0]]("morales_rescue_hvt_3_D", 3, 3, 6, 0.05, undefined, "morales_obj3_D", undefined, undefined, undefined);
  [[var0]]("morales_signal_heli_4", 6, 10, 10, 0.05, undefined, "morales_obj4", undefined, undefined, undefined);
  [[var0]]("morales_holdout_5_NW", 2, 7, 7, [ &waitbetweenspawnwaveswithtimeout, 0.1, 7], undefined, "morales_obj5_NW", &watchforstopwaves, &getnextholdoutspawnmodule, undefined);
  [[var0]]("morales_holdout_5_SW", 2, 7, 7, [ &waitbetweenspawnwaveswithtimeout, 0.1, 7], undefined, "morales_obj5_SW", &watchforstopwaves, &getnextholdoutspawnmodule, undefined);
  [[var0]]("morales_holdout_5_SE", 2, 7, 7, [ &waitbetweenspawnwaveswithtimeout, 0.1, 7], undefined, "morales_obj5_SE", &watchforstopwaves, &getnextholdoutspawnmodule, undefined);
  [[var0]]("morales_holdout_5_OS", 2, 7, 7, [ &waitbetweenspawnwaveswithtimeout, 0.1, 7], undefined, "morales_obj5_overseers", &watchforstopwaves, &getnextholdoutspawnmodule, undefined);
  [[var0]]("morales_holdout_5_Bombers", 1, 2, 200, &waitbetweenbomberwaves, undefined, "morales_obj5_bomber", &watchforstopwaves, undefined, undefined);
  [[var0]]("morales_slow_load_hvt_6", 5, 18, 200, [ &waitbetweenspawnwaves, 0.1, 0.1], undefined, "morales_slow_exfil", &watchforstopwaves, undefined, undefined);
  [[var0]]("morales_fast_load_hvt_6", 5, 18, 200, [ &waitbetweenspawnwaves, 0.1, 0.1], undefined, "morales_obj6_fast", &watchforstopwaves, undefined, undefined);
}

function waitbetweenspawnwaves(var0, var1, var2, var3) {
  level endon("game_ended");

  if(var0.activecount >= var0.max_size) {
    while(var0.activecount <= var0.max_size && var0.activecount) {
      wait 0.1;
    }

    wait 1;
  }

  if(var0.activecount <= var0.min_size) {
    return var1;
  }

  return var2;
}

function waitbetweenspawnwaveswithtimeout(var0, var1, var2, var3) {
  level endon("game_ended");
  var4 = gettime();
  var5 = var4 + var2 * 1000;

  if(var0.activecount >= var0.max_size) {
    while(var0.activecount <= var0.max_size && var0.activecount && gettime() <= var5) {
      wait 0.1;
    }

    wait 1;
  }

  return var1;
}

function waitbetweenbomberwaves(var0) {
  level endon("game_ended");
  var1 = scripts\cp\cp_objectives::getobjectivestructfromref("morales_holdout_5");

  if(!isDefined(var1.currentteam)) {
    return;
  }

  while(are_all_players_on_watchtower(var1.currentteam)) {
    wait 2;
  }

  return randomint(10) + 5;
}

function are_all_players_on_watchtower(var0) {
  var1 = scripts\engine\utility::getStruct("tower1_upper_level", "script_noteworthy");

  if(!isDefined(var1)) {
    return 0;
  }

  var2 = scripts\cp\utility::getplayersinteam(var0);
  var3 = 1;

  foreach(var5 in var2) {
    if(distance(var5.origin, var1.origin) > 300) {
      var3 = 0;
      break;
    }
  }

  return var3;
}

function watchforstopwaves(var0) {
  level endon("game_ended");
  thread _watchforstopwaves(level);

  if(var0.group_name == "morales_holdout_5_OS") {
    thread watchforoverseerskilled(level);
    return;
  }

  if(issubstr(var0.group_name, "morales_holdout_5")) {
    thread swapcoverselector(level);
    return;
  }
}

function swapcoverselector(var0) {
  level endon("game_ended");
  level endon("spawn_module_" + var0.moduleid + "_completed");

  for(;;) {
    if(!isDefined(var0.ai_spawned)) {
      wait 3;
      continue;
    }

    foreach(var2 in var0.ai_spawned) {
      if(!istrue(var2.swappedcoverselector)) {
        var2.defaultcoverselector = "cover_shotgunner";
        var2.swappedcoverselector = 1;
      }
    }

    wait 1;
  }
}

function _watchforstopwaves(var0) {
  level endon("game_ended");
  level scripts\engine\utility::ref_143a7("morales_laptop_activated", "morales_holdout_finished", "morales_exfiled", "morales_heli_exfil_defense_done");
  level notify("spawn_module_" + var0.moduleid + "_completed");
}

function watchforoverseerskilled(var0) {
  level endon("morales_holdout_completed");
  level endon("stop_morales_hvt_objectives");

  while(var0.currentmodulekills < 10) {
    wait 0.5;
  }

  if(isDefined(level.objectivestabledata["morales_holdout_5"])) {
    level.objectivestabledata["morales_holdout_5"].earnedfastexfil = 1;
    return;
  }
}

function blockedwaittillgrouptimerdone(var0) {
  wait 5;
}

function getnextholdoutspawnmodule(var0) {
  if(!istrue(level.inmoralesholdout)) {
    return undefined;
  }

  for(var1 = 0; var0.activecount > 3 && var1 <= 10; var1++) {
    wait 1;
  }

  var2 = undefined;

  switch (var0.group_name) {
    case "morales_holdout_5_NW":
      if(!areplayersnearspawnarea("morales_holdout_spawner_SW")) {
        var2 = "morales_holdout_5_SW";
      } else if(!areplayersnearspawnarea("morales_holdout_spawner_SE")) {
        var2 = "morales_holdout_5_SE";
      } else {
        var2 = "morales_holdout_5_NW";
      }

      break;
    case "morales_holdout_5_SW":
      if(!areplayersnearspawnarea("morales_holdout_spawner_SE")) {
        var2 = "morales_holdout_5_SE";
      } else if(!areplayersnearspawnarea("morales_holdout_spawner_NW")) {
        var2 = "morales_holdout_5_NW";
      } else {
        var2 = "morales_holdout_5_SW";
      }

      break;
    case "morales_holdout_5_SE":
      var2 = "morales_holdout_5_OS";
      break;
    case "morales_holdout_5_OS":
      if(!areplayersnearspawnarea("morales_holdout_spawner_NW")) {
        var2 = "morales_holdout_5_NW";
      } else if(!areplayersnearspawnarea("morales_holdout_spawner_SW")) {
        var2 = "morales_holdout_5_SW";
      } else {
        var2 = "morales_holdout_5_SE";
      }

      break;
    default:
      var2 = undefined;
      break;
  }

  return var2;
}

function areplayersnearspawnarea(var0) {
  var1 = scripts\engine\utility::getStruct(var0, "script_noteworthy");

  if(!isDefined(var1)) {
    return false;
  }

  var2 = 300;

  foreach(var4 in level.players) {
    if(scripts\engine\utility::distance_2d_squared(var4.origin, var1.origin) <= var2 * var2) {
      return true;
    }
  }

  return false;
}

function playsmokeflarevisualmarker(var0) {
  var1 = scripts\engine\utility::drop_to_ground(var0, 50, -200, (0, 0, 1));
  var1 += (0, 0, 1);
  var2 = spawn("script_model", var1);
  var2 setModel("offhand_wm_grenade_smoke");
  var2.angles = (0, 90, 90);
  var3 = spawn("script_model", var1);
  var3 setModel("ks_crate_marker_mp");
  var3 setscriptablepartstate("smoke", "on", 0);
  thread watchfordeletesmokeflarevisualmarker(var2, var3);
  wait 20;
  self notify("stop_smoke_flare");
}

function watchfordeletesmokeflarevisualmarker(var0, var1) {
  self waittill("stop_smoke_flare");
  var0 delete();
  var1 delete();
}

function debugmoralesobjectivesstart(var0) {
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "morales_debug_start_loc");
}

function glstopmoralesquest() {
  var0 = ["morales_infil_house_1", "morales_hack_laptop_2", "morales_rescue_hvt_3", "morales_signal_heli_4", "morales_holdout_5", "morales_slow_load_hvt_6", "morales_fast_load_hvt_6"];

  foreach(var2 in var0) {
    var3 = scripts\cp\cp_objectives::getobjectivestructfromref(var2);
    scripts\cp\cp_objectives::overridenextstep(var3, undefined);
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

function initmoralesinfilobj(var0, var1) {}

function threadedbcloop() {}

function startmoralesinfilobj(var0, var1) {
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
  waitforoneplayernearpoint(var0.iconpos[0], 3000, 0);
  thread scripts\cp\cp_modular_spawning::run_spawn_module("morales_infil_house_1");
  waitforoneplayernearpoint(var0.iconpos[0], 500, 0);
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

function completemoralesinfilobj(var0) {}

function initmoraleshackobj(var0, var1) {
  if(isDefined(level.morales_laptop_int_struct)) {
    level.morales_laptop_int_struct.laptopactive = 1;
    return;
  }
}

function startmoraleshackobj(var0, var1) {
  level endon("stop_morales_hvt_objectives");
  thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_hvi_laptop_10", "allies");
  thread nag_player_for_laptop(var0);
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/MORALES_4");
  var0 waittill("start_hacking_morales_laptop");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("morales_hack_laptop_2");
  var0 waittill("morales_laptop_activated");
  level notify("morales_laptop_activated");
  wait 2;
}

function completemoraleshackobj(var0) {}

function nag_player_for_laptop(var0) {
  level endon("game_ended");
  var0 endon("start_hacking_morales_laptop");

  for(;;) {
    wait 30;
    thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_hvi_laptop_20", "allies");
  }
}

function initmoralesrescueobj(var0, var1) {
  var2 = randomint(2);
  var3 = undefined;

  switch (var2) {
    case 0:
    default:
      var3 = "A";
      break;
    case 1:
      var3 = "B";
      break;
  }

  var4 = scripts\engine\utility::getStructArray("morales_hvt_loc", "script_noteworthy");
  var5 = undefined;

  foreach(var7 in var4) {
    if(var7.targetname == var3) {
      var5 = var7;
      break;
    }
  }

  var0.spawngroup = var3;
  initmoraleshvtmodel(var5.origin);
  objective_onentity(var0.objectiveindex, level.moraleshostage);
}

function startmoralesrescueobj(var0, var1) {
  level endon("stop_morales_hvt_objectives");
  thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_hvi_laptop_30", "allies");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/MORALES_5");
  waitforoneplayernearpoint(level.moraleshostage.origin, 3000, 0);
  thread scripts\cp\cp_modular_spawning::run_spawn_module("morales_rescue_hvt_3_" + var0.spawngroup);
  level waittill("player_picked_up_hostage", var2);
  var2 thread scripts\cp\cp_vo::try_to_play_vo("dx_cps_drjm_rescue_hvi_found_20", "cp_comment_vo");
  wait scripts\cp\cp_vo::get_sound_length("dx_cps_drjm_rescue_hvi_found_20");
  thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_hvi_found_10", "allies");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/MORALES_6");
}

function completemoralesrescueobj(var0) {}

function initmoralessignalobj(var0, var1) {
  if(!isDefined(level.moraleshostage)) {
    initmoraleshvtmodel((-1962.19, -8728.35, 300.997));
  }

  var0.customwaypointid = scripts\cp\cp_objectives::requestworldid("morales_signal_4", 15);
  var2 = scripts\engine\utility::getStruct("obj1_HVT_defend_tower", "script_noteworthy");
  objective_setplayintro(var0.customwaypointid, 1);
  objective_setplayoutro(var0.customwaypointid, 1);
  objective_state(var0.customwaypointid, "current");
  objective_position(var0.customwaypointid, var2.origin);
  objective_setdescription(var0.customwaypointid, &"CP_BR_SYRK_OBJECTIVES/MORALES_4");
  objective_setlabel(var0.customwaypointid, &"CP_BR_SYRK_OBJECTIVES/DROP_HOSTAGE");
  objective_icon(var0.customwaypointid, "icon_waypoint_objective_general");
  objective_setbackground(var0.customwaypointid, 1);
}

function startmoralessignalobj(var0, var1) {
  level endon("stop_morales_hvt_objectives");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("morales_signal_heli_4");
  var2 = scripts\engine\utility::getStruct("obj1_HVT_defend_tower", "script_noteworthy");
  waitformoralesdropnearpoint(var2.origin, level.moraleshostage, 300);

  if(isDefined(level.moraleshostage)) {
    level.moraleshostage scripts\cp\cp_pickup_hostage::togglehvtusable(0);
  }

  var3 = scripts\engine\utility::getStruct("obj1_HVT_signal_exfil", "script_noteworthy");
  objective_state(var0.customwaypointid, "done");
  wait 1;
  objective_position(var0.customwaypointid, var3.origin);
  objective_state(var0.customwaypointid, "current");
  objective_setlabel(var0.customwaypointid, &"CP_BR_SYRK_OBJECTIVES/SIGNAL_EXFIL");

  if(isDefined(level.morales_signal_struct)) {
    level.morales_signal_struct.available = 1;
  }

  level waittill("morales_signal_activated");
  thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_hvi_defend_10", "allies");
  var4 = scripts\engine\utility::getStruct("canister_placeholder", "script_noteworthy");

  if(isDefined(var4)) {
    thread playsmokeflarevisualmarker(level);
  }

  level notify("spawn_module_morales_signal_heli_4_completed");
  objective_delete(var0.customwaypointid);
  scripts\cp\cp_objectives::freeworldid("morales_signal_4");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/MORALES_7");
  wait 1;
}

function completemoralessignalobj(var0) {}

function initmoralesholdoutobj(var0, var1) {
  var0.earnedfastexfil = 0;
}

function startmoralesholdoutobj(var0, var1) {
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
  scripts\cp\cp_objectives::overridenextstep(var0, "morales_slow_load_hvt_6");
  level.inmoralesholdout = undefined;

  if(isDefined(level.moraleshostage)) {
    level.moraleshostage scripts\cp\cp_pickup_hostage::togglehvtusable(1);
  }

  level notify("morales_holdout_finished");
}

function completemoralesholdoutobj(var0) {
  level notify("morales_holdout_completed");
}

function moralesholdoutmagicgrenadewatcher(var0) {
  level endon("morales_holdout_completed");
  level endon("stop_morales_hvt_objectives");
  level endon("game_ended");
  var1 = scripts\engine\utility::getStruct("tower1_upper_level", "script_noteworthy");
  var2 = scripts\engine\utility::getStruct("tower1_grenade_origin", "script_noteworthy");
  jumpiffalse(!isDefined(var1) || !isDefined(var2)) LOC_00000047;
  return;
}

function initmoralesslowloadobj(var0, var1) {
  var2 = scripts\engine\utility::getStruct("morales_slow_heli_B", "targetname");
  var3 = scripts\engine\utility::getStruct("morales_debug_hvt_slow_spawn", "script_noteworthy");
  var0.exfilstruct = var2;

  if(!isDefined(level.moraleshostage)) {
    initmoraleshvtmodel(var3.origin);
    return;
  }
}

function startmoralesslowloadobj(var0, var1) {
  level endon("stop_morales_hvt_objectives");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/MORALES_12");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("morales_slow_load_hvt_6");
  thread exfil_morales(level.moraleshostage, var0);
  level waittill("morales_exfiled");

  foreach(var3 in level.players) {
    var3 thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("hvt_saved");
  }

  thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_hvi_exfil_10", "allies");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/MORALES_13");
  wait scripts\cp\cp_vo::get_sound_length("dx_cps_ovl_rescue_hvi_exfil_10");
}

function completemoralesslowloadobj(var0) {}

function initmoralesfastloadobj(var0, var1) {
  var2 = scripts\engine\utility::getStruct("morales_debug_hvt_fast_spawn", "script_noteworthy");
  var3 = scripts\engine\utility::getStruct("morales_fast_heli_B", "targetname");
  var0.exfilstruct = var3;

  if(!isDefined(level.moraleshostage)) {
    initmoraleshvtmodel(scripts\engine\utility::drop_to_ground(var2.origin));
    return;
  }
}

function startmoralesfastloadobj(var0, var1) {
  level endon("stop_morales_hvt_objectives");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("morales_fast_load_hvt_6");
  thread exfil_morales(level.moraleshostage, var0);
  level waittill("morales_exfiled");

  foreach(var3 in level.players) {
    var3 thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("hvt_saved");
  }

  thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_hvi_exfil_10", "allies");
  thread scripts\cp\utility::cp_add_dialogue_line(&"CP_BR_SYRK_GL_DIALOGUE/MORALES_13");
  wait scripts\cp\cp_vo::get_sound_length("dx_cps_ovl_rescue_hvi_exfil_10");
}

function completemoralesfastloadobj(var0) {}

function exfil_morales(var0, var1) {
  var0 endon("death");
  var0 endon("bleedout");

  if(!isDefined(var1.exfilstruct)) {
    var1.exfilstruct = scripts\engine\utility::getStruct("morales_fast_heli_B", "targetname");
  }

  var2 = var1.exfilstruct;
  objective_setlabel(var1.objectiveindex, "CP_BR_SYRK_OBJECTIVES/EXFIL_MORALES");
  objective_setshowprogress(var1.objectiveindex, 0);
  objective_icon(var1.objectiveindex, "icon_waypoint_extract");
  objective_position(var1.objectiveindex, var2.origin + (0, 0, -100));
  var3 = spawn_evac_chopper(var2);
  var3.godmode = 1;
  var3.health = 10000;
  var3.maxhealth = 10000;
  vehicle_anims();
  script_model_anims(var3);
  scripts\cp\cp_pickup_hostage::init_anims();
  var3 scripts\cp\maps\cp_br_syrk\cp_br_syrk_objective_helidown::spawnhelihvtexfilactors();
  thread leave_if_vip_dies(var3, var0);
  thread start_nag_for_morales_exfil(var1);

  for(;;) {
    var4 = 0;

    foreach(var6 in level.players) {
      if(!isDefined(var6.hostagecarried)) {
        continue;
      }

      if(distancesquared(var6.origin, var3.exfil_struct.origin) < 6250000) {
        var4 = 1;
        LOC_0000013c:
      }
      LOC_0000013c:
    }

    wait 1;
  }

  LOC_00000157:
    var1 notify("stop_morales_exfil_nags");
  thread defend_while_chopper_arrives(var1);
  var1 waittill("defend_done");
  level notify("helidown_done");
  var3 scripts\cp\infilexfil\blima_exfil::go_to_exfil_location(var3.exfil_struct, 1);
  var8 = anglesToForward(var3.angles);
  var9 = anglestoleft(var3.angles);
  var10 = var3.origin;
  var11 = var10 + var8 * 10 + var9 * 64 + (0, 0, -110);
  objective_position(var1.objectiveindex, var11);
  objective_setlabel(var1.objectiveindex, "CP_BR_SYRK_OBJECTIVES/EXFIL_MORALES");
  var12 = spawn("trigger_radius", var11 + (0, 0, -200), 0, 64, 500);

  for(;;) {
    var12 waittill("trigger", var6);

    if(!isDefined(var6.hostagecarried)) {
      continue;
    }

    var13 = var6.hostagecarried;
    var13 notify("stop_bleedout_timer");
    scripts\cp\cp_pickup_hostage::load_hvt(var6, var3);
    wait 1;
    break;
  }

  thread evac_hvt(level, var3);
}

function start_nag_for_morales_exfil(var0) {
  level endon("game_ended");
  var0 endon("stop_morales_exfil_nags");

  for(;;) {
    wait 30;
    thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_ovl_rescue_hvi_exfil_nag_10", "allies");
  }
}

#using_animtree("mp_vehicles_always_loaded");

function spawn_evac_chopper(var0) {
  var1 = scripts\common\vehicle::vehicle_spawn(scripts\engine\utility::getStruct("player_exfil", "targetname"));
  var1.vehicle_skipdeathmodel = 1;
  var1.script_disconnectpaths = 0;
  var1.death_fx_on_self = 1;
  var1.exfil_struct = var0;
  var1 vehicleplayanim(%est_blima_doors_open);
  var0.smoke_canister = scripts\cp\cp_objective_mechanics::smoke_canister_spawn(var0.origin, 1);
  scripts\cp\infilexfil\blima_exfil::spawn_vehicle_actors(var1);
  var1 scripts\cp\infilexfil\blima_exfil::heli_mg_create();
  return var1;
}

#using_animtree("");

function vehicle_anims() {
  level.scr_animtree["exfil_chopper"] = #animtree;
}

function evac_hvt(var0, var1) {
  var0 vehicle_setspeed(5, 10);
  var0 cleartargetyaw();
  var0 setvehgoalpos(var0.origin + (0, 0, 800), 1);
  wait 4;
  level notify("morales_exfiled");
  wait 4;
  var0 vehicle_setspeed(90, 10);
  var0 setvehgoalpos(var0.origin + (10000, 10000, 500));
  wait 20;

  if(isDefined(var1)) {
    var1 scripts\cp\cp_pickup_hostage::deletepickuphostage();
  }

  if(isDefined(var0.minigun)) {
    var0.minigun delete();
  }

  if(isDefined(var0.vmhvt)) {
    if(isDefined(var0.vmhvt.head)) {
      var0.vmhvt.head delete();
    }

    var0.vmhvt delete();
  }

  if(isDefined(var0.vmexfilally)) {
    if(isDefined(var0.vmexfilally.head)) {
      var0.vmexfilally.head delete();
    }

    var0.vmexfilally delete();
  }

  var0 delete();
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

function spawn_anim_model(var0, var1, var2, var3) {
  var4 = spawn("script_model", (0, 0, 0));
  var4 setModel(var2);

  if(isDefined(var3)) {
    var5 = spawn("script_model", (0, 0, 0));
    var5 setModel(var3);
    var5 linkTo(var4, "j_spine4", (0, 0, 0), (0, 0, 0));
    var4.head = var5;
    var4 thread scripts\engine\utility::delete_on_death(var5);
  }

  var4.animname = var0;
  var4 useanimtree(level.scr_animtree[var4.animname]);

  if(isDefined(var1)) {
    thread scripts\engine\utility::delete_on_death(var4);
    var4 linkTo(self, var1, (0, 0, 0), (0, 0, 0));
  }

  return var4;
}

function actor_animloop(var0, var1, var2, var3) {
  self endon(var2);
  self endon("death");

  for(;;) {
    scripts\common\anim::anim_single(var0, var1, var3);
    var4 = getanimlength(level.scr_anim[var0[0].animname][var1]);
    wait var4;
  }
}

function hostage_price_idle(var0) {
  var0 endon("death");
  self endon("death");

  for(;;) {
    var0 scriptmodelplayanim(level.scr_anim[var0.animname]["helidown_exfil_idle"]);

    if(isDefined(var0.head)) {
      var0.head scriptmodelplayanim(level.scr_anim[var0.head.animname]["helidown_exfil_idle"]);
    }

    self.exfil_helpers[0] scriptmodelplayanim(level.scr_anim[self.exfil_helpers[0].animname]["helidown_exfil_idle"]);
    var1 = getanimlength(level.scr_anim[self.exfil_helpers[0].animname]["helidown_exfil_idle"]);
    wait var1;
  }
}

function defend_while_chopper_arrives(var0) {
  objective_setlabel(var0.objectiveindex, &"CP_BR_SYRK_OBJECTIVES/EXFIL_ENROUTE");
  objective_setshowprogress(var0.objectiveindex, 1);
  objective_setprogress(var0.objectiveindex, 0);
  var1 = 20;
  var2 = 20;

  for(;;) {
    wait 1;
    var2--;
    objective_setprogress(var0.objectiveindex, var2 / var1);

    if(var2 <= 15) {
      var0 notify("defend_done");
      level notify("morales_heli_exfil_defense_done");
    }

    if(var2 <= 0) {
      return;
    }
  }
}

function leave_if_vip_dies(var0, var1) {
  level endon("game_ended");
  level endon("morales_exfiled");
  var0 endon("exfil");
  var2 = scripts\engine\utility::waittill_any_ents_return(var1, "vip_died", var0, "bleedout");
  self notify("stop_marker");

  if(self vehicle_getspeed() > 1) {
    self waittill("goal");
  }

  if(istrue(self.going_to_exfil)) {
    thread evac_hvt(self);
    return;
  }

  if(isDefined(var0) && isalive(var0)) {
    var0.nocorpse = 1;
    var0 dodamage(var0.health + 100, var0.origin);
  }

  self delete();
}