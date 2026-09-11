/*********************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_layover\morales_objective\cp_morales_objective.gsc
*********************************************************************************/

function registermoralesobjectives() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("interactions_initialized");

  if(!scripts\engine\utility::flag_exist("morales_spawn_functions_registered")) {
    scripts\engine\utility::flag_init("morales_spawn_functions_registered");
  }

  scripts\cp\cp_objectives::registerobjective("morales_1", &initmorales_1, &startmorales_1, &completemorales_1, undefined, &debugmoralesobjectivesstart);
  scripts\cp\cp_objectives::registerobjective("morales_2", &initmorales_2, &startmorales_2, &completemorales_2, undefined, &debugmoralesobjectivesstart);
  scripts\cp\cp_objectives::registerobjective("morales_3", &initmorales_3, &startmorales_3, &completemorales_3, undefined, &debugmoralesobjectivesstart);
  scripts\cp\cp_objectives::registerobjective("morales_4", &initmorales_4, &startmorales_4, &completemorales_4, undefined, &debugmoralesobjectivesstart);
  scripts\cp\cp_objectives::registerobjective("morales_5", &initmorales_5, &startmorales_5, &completemorales_5, undefined, &debugmoralesobjectivesstart);
  scripts\cp\cp_objectives::registerobjective("morales_6", &initmorales_6, &startmorales_6, &completemorales_6, undefined, &debugmoralesobjectivesstart);
  thread initobjspawners();
  scripts\cp\cp_pickup_hostage::registerhvtscriptmodels();
  level thread scripts\cp\cp_hacking::hacking_init();

  if(!scripts\engine\utility::flag_exist("morales_registered")) {
    scripts\engine\utility::flag_init("morales_registered");
  }

  scripts\engine\utility::flag_set("morales_registered");
}

function watchformoralesnearstruct(var0, var1) {
  level endon("game_ended");
  var2 = scripts\engine\utility::getStruct(var0, "script_noteworthy");
  jumpiftrue(isDefined(level.moraleshostage)) LOC_00000026;
  initmoraleshvtmodel();

  for(;;) {
    var3 = 0;

    if(distance(level.moraleshostage.origin, var2.origin) <= var1) {
      var3 = 1;
    }

    if(var3) {
      break;
    }

    wait 0.5;
  }

  level notify("morales_near_" + var0);
}

function watchformoralesnearpointarray(var0, var1) {
  level endon("game_ended");
  var2 = scripts\engine\utility::getStructArray(var0, "script_noteworthy");

  if(var2.size < 1) {
    return;
  }

  jumpiftrue(isDefined(level.moraleshostage)) LOC_0000002f;
  initmoraleshvtmodel();

  for(;;) {
    var3 = 0;

    foreach(var5 in var2) {
      if(distance(level.moraleshostage.origin, var5.origin) <= var1) {
        var3 = 1;
      }
    }

    if(var3) {
      break;
    }

    wait 0.5;
  }

  level notify("morales_near_" + var0);
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

      if(distance(level.moraleshostage.origin, var0) <= var1) {
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

function initmoraleshvtmodel(var0) {
  if(!isDefined(var0)) {
    var0 = scripts\engine\utility::getStruct("morales_hvt_object", "script_noteworthy").origin;
  }

  level.moraleshostage = scripts\cp\cp_pickup_hostage::initdefaulthvtmodel(var0, "morales_hostage_fullbody", undefined, &"CP_BR_SYRK_OBJECTIVES/PICK_MORALES", "drop_morales_hostage", undefined, "hostage_morales", 1);
  level.moraleshostage.nowaypoint = 1;
  objective_setplayintro(level.moraleswid, 0);
  objective_state(level.moraleswid, "current");
  objective_icon(level.moraleswid, "icon_waypoint_objective_general");
  objective_onentity(level.moraleswid, level.moraleshostage);
  objective_setzoffset(level.moraleswid, 32);
  objective_setbackground(level.moraleswid, 2);
  objective_setlabel(level.moraleswid, "CP_BR_SYRK_OBJECTIVES/HVT");
  thread monitormoraleswaypoint();
  thread ref_144c0(level.moraleshostage);
  scripts\cp\cp_objectives::ref_11f80(level.moraleswid);
}

function monitormoraleswaypoint() {
  level endon("game_ended");
  level endon("morales_exfiled");
  self endon("exfil");
  self endon("death");

  for(;;) {
    self waittill("player_picked_up_hostage", var0);
    wait 0.5;
    objective_onentity(level.moraleswid, var0);
    self waittill("dropped");
    wait 0.5;
    objective_onentity(level.moraleswid, self);
  }
}

function initmoraleslaptop() {
  if(istrue(level.ref_11d26)) {
    return;
  }

  level.ref_11d26 = 1;
  var0 = scripts\engine\utility::getStruct("morales_laptop_interaction", "script_noteworthy");
  scripts\cp\cp_interaction::spawninteractionmodel(var0, scripts\engine\utility::getStruct(var0.target, "targetname"));
  var1 = spawn("script_model", var0.origin);
  var1 setModel("tag_origin");
  var1 setHintString(&"CP_OBJECTIVES/HACK");
  var1 setCursorHint("HINT_BUTTON");
  var1 sethintdisplayrange(200);
  var1 sethintdisplayfov(90);
  var1 setuserange(72);
  var1 setusefov(90);
  var1 sethintonobstruction("hide");
  var1 setuseholdduration("duration_short");
  thread ref_11d27();
}

function ref_11d27() {
  level endon("game_ended");
  level waittill("enable_morales_laptop_interaction");
  self makeusable();

  for(;;) {
    self waittill("trigger", var0);

    if(!var0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    self makeunusable();
    thread activationmoraleslaptop(self, var0);
    break;
  }
}

function activationmoraleslaptop(var0, var1) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var0);
  var2 = scripts\cp\cp_objectives::getobjectivestructfromref("morales_2");
  var0 notify("morales_hack_used");
  var2 notify("start_hacking_morales_laptop", var0);
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var1, "obj_device_set");
  level thread scripts\cp\utility::ref_123fe("mus_cp_armsrace_filescopied_1");
  scripts\cp\cp_objective_mechanics::starthackingdefense(var2, scripts\engine\utility::getStruct("obj1_HVT_hack_location", "script_noteworthy").origin + (0, 150, 50), 120, "morales_laptop_activated", 200);
}

function initobjspawners() {
  if(scripts\engine\utility::flag_exist("interactions_initialized")) {
    scripts\engine\utility::flag_wait("interactions_initialized");
  }

  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  if(scripts\engine\utility::flag_exist("introscreen_over")) {
    scripts\engine\utility::flag_wait("introscreen_over");
  }

  if(!scripts\engine\utility::flag_exist("cp_morales_cs_completed")) {
    scripts\engine\utility::flag_init("cp_morales_cs_completed");
  }

  scripts\engine\utility::flag_wait("cp_morales_cs_completed");
  var0 = &scripts\cp\cp_modular_spawning::registerambientgroup;
  [[var0]]("morales_infil_house_1", 6, 8, 8, 0.5, undefined, "morales_obj1", undefined, undefined, undefined);
  [[var0]]("morales_hack_laptop_2", 12, 20, 200, [ &waitbetweenspawnwaveswithtimeout, 0.1, 15], undefined, "morales_obj2", &watchforstopwaves, undefined, undefined);
  [[var0]]("morales_rescue_hvt_3_A", 4, 4, 6, 0.05, undefined, "morales_obj3_A", undefined, undefined, undefined);
  [[var0]]("morales_rescue_hvt_3_B", 4, 4, 6, 0.05, undefined, "morales_obj3_B", undefined, undefined, undefined);
  [[var0]]("morales_rescue_hvt_3_C", 4, 4, 6, 0.05, undefined, "morales_obj3_C", undefined, undefined, undefined);
  [[var0]]("morales_rescue_hvt_3_D", 4, 4, 6, 0.05, undefined, "morales_obj3_D", undefined, undefined, undefined);
  [[var0]]("morales_signal_heli_4", 9, 9, 9, 0.05, undefined, "morales_obj4", undefined, undefined, undefined);
  [[var0]]("morales_walk_ar_back", 3, 3, 3, 0.05, undefined, "morales_walk_ar_back", undefined, undefined, undefined);
  [[var0]]("morales_walk_ar_front", 4, 4, 4, 0.05, undefined, "morales_walk_ar_front", undefined, undefined, undefined);
  [[var0]]("morales_walk_sniper_back", 4, 4, 4, 0.05, undefined, "morales_walk_sniper_back", undefined, undefined, undefined);
  [[var0]]("morales_walk_sniper_front", 4, 4, 4, 0.05, undefined, "morales_walk_sniper_front", undefined, undefined, undefined);
  [[var0]]("morales_holdout_5", 0, 20, 200, 0.1, undefined, "morales_obj5", &watchforstopwaves, undefined, undefined);
  [[var0]]("morales_holdout_5_NW", 0, 6, 6, 0.1, undefined, "morales_obj5_NW", &watchforstopwaves, &getnextholdoutspawnmodule, undefined);
  [[var0]]("morales_holdout_5_SW", 0, 6, 6, 0.1, undefined, "morales_obj5_SW", &watchforstopwaves, &getnextholdoutspawnmodule, undefined);
  [[var0]]("morales_holdout_5_SE", 0, 6, 6, 0.1, undefined, "morales_obj5_SE", &watchforstopwaves, &getnextholdoutspawnmodule, undefined);
  [[var0]]("morales_holdout_5_OS", 0, 6, 6, 0.1, undefined, "morales_obj5_overseers", &watchforstopwaves, &getnextholdoutspawnmodule, undefined);
  [[var0]]("morales_holdout_5_Bombers", 1, 2, 200, &waitbetweenbomberwaves, undefined, "morales_obj5_bomber", &watchforstopwaves, undefined, undefined);
  [[var0]]("morales_slow_load_hvt_6", 5, 15, 15, [ &waitbetweenspawnwaves, 0.1, 0.1], undefined, "morales_slow_exfil", &watchforstopwaves, undefined, undefined);
  [[var0]]("morales_fast_load_hvt_6", 5, 15, 15, [ &waitbetweenspawnwaves, 0.1, 0.1], undefined, "morales_obj6_fast", &watchforstopwaves, undefined, undefined);
  [[var0]]("morales_heli_1", 0, 6, 6, 0.1, 0, "morales_heli_1", undefined, &reset_recharge_after_respawn, undefined);
  [[var0]]("morales_heli_2", 0, 6, 6, 0.1, 0, "morales_heli_2", undefined, &reset_recharge_after_respawn, undefined);
  [[var0]]("morales_heli_approach", 0, 6, 6, 0.1, 0, "morales_heli_approach", undefined, &reset_recharge_after_respawn, undefined);
  [[var0]]("morales_veh_1", 6, 6, 6, 0.1, undefined, "morales_veh_1", undefined, undefined, undefined);
  [[var0]]("morales_1_patrols", 0, 24, undefined, 0.1, &unset_pre_wave_spawning, "morales_patrol_structs", &init_pre_wave_spawning, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("morales_1_patrols", &scripts\cp\cp_modular_spawning::set_pre_wave_spawning_spawn_funcs);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("morales_rescue_hvt_3_A", &morales_guard_post_func);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("morales_rescue_hvt_3_B", &morales_guard_post_func);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("morales_rescue_hvt_3_C", &morales_guard_post_func);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("morales_rescue_hvt_3_D", &morales_guard_post_func);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("morales_walk_sniper_back", &watchforstep4chaseplayerstopool);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("morales_walk_sniper_front", &watchforstep4chaseplayerstopool);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("morales_walk_ar_front", &watchforstep4chaseplayerstopool);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("morales_walk_ar_back", &watchforstep4chaseplayerstopool);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("morales_holdout_5_NW", &watchforstep5rushplayertimer);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("morales_holdout_5_SW", &watchforstep5rushplayertimer);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("morales_holdout_5_SE", &watchforstep5rushplayertimer);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("morales_holdout_5_OS", &watchforstep5rushplayertimer);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("morales_holdout_5", &spawn_loot_pickups);

  if(!scripts\engine\utility::flag_exist("morales_spawn_functions_registered")) {
    scripts\engine\utility::flag_init("morales_spawn_functions_registered");
  }

  scripts\engine\utility::flag_set("morales_spawn_functions_registered");
}

function init_pre_wave_spawning(var0) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("cover_spawners_initialized");
  scripts\cp\cp_modular_spawning::add_global_spawn_function("axis", &scripts\cp\cp_modular_spawning::stay_passive_if_not_weapons_free);
  scripts\cp\cp_modular_spawning::add_global_spawn_function("axis", &scripts\cp\cp_modular_spawning::set_aggro_flag_on_enter_combat);
  scripts\cp\cp_modular_spawning::add_global_spawn_function("axis", &scripts\cp\cp_modular_spawning::watch_for_players, undefined, 1000000, 45);
}

function unset_pre_wave_spawning(var0) {
  scripts\cp\cp_modular_spawning::remove_global_spawn_function("axis", &scripts\cp\cp_modular_spawning::stay_passive_if_not_weapons_free);
  scripts\cp\cp_modular_spawning::remove_global_spawn_function("axis", &scripts\cp\cp_modular_spawning::set_aggro_flag_on_enter_combat);
  scripts\cp\cp_modular_spawning::remove_global_spawn_function("axis", &scripts\cp\cp_modular_spawning::watch_for_players);
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
    while(var0.activecount >= var0.max_size && gettime() <= var5) {
      wait 0.1;
    }
  }

  return var1;
}

function waitbetweenbomberwaves(var0) {
  level endon("game_ended");
  var1 = scripts\cp\cp_objectives::getobjectivestructfromref("morales_5");

  if(!isDefined(var1.currentteam)) {
    return;
  }

  while(are_all_players_on_watchtower(var1.currentteam)) {
    wait 2;
  }

  return randomint(10) + 5;
}

function spawn_loot_pickups(var0) {
  self endon("death");
  self.goalradius = 1024;
  self.script_origin_other = scripts\engine\utility::getStruct("morales_pool_marker", "script_noteworthy").origin;
}

function are_all_players_on_watchtower(var0) {
  var1 = scripts\engine\utility::getStruct("tower1_upper_level", "script_noteworthy");

  if(!isDefined(var1)) {
    return 0;
  }

  var2 = 1;
  var3 = scripts\cp\utility::getplayersinteam(var0);

  foreach(var5 in var3) {
    if(distance(var5.origin, var1.origin) > 300) {
      var2 = 0;
      break;
    }
  }

  return var2;
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
  level notify(var0.moduleid + "_watch_for_stopwaves");
  level endon(var0.moduleid + "_watch_for_stopwaves");
  level scripts\engine\utility::ref_143a7("morales_laptop_activated", "morales_holdout_finished", "morales_exfiled", "morales_heli_exfil_defense_done");
  level notify("spawn_module_" + var0.moduleid + "_completed");
}

function watchforstep5rushplayertimer(var0) {
  level endon("game_ended");
  self endon("death");
  var1 = 0;

  while(var1 <= 10) {
    var1++;
    wait 1;
  }

  thread scripts\cp\cp_modular_spawning::set_script_origin_other_to_center_of_players();
}

function watchforstep4chaseplayerstopool(var0) {
  level endon("game_ended");
  self endon("death");
  level waittill("morales_near_morales_obj_close_to_pool");
  thread scripts\cp\cp_modular_spawning::set_script_origin_other_to_center_of_players();
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

function getnextholdoutspawnmodule(var0) {
  if(!istrue(level.inmoralesholdout)) {
    return undefined;
  }

  var1 = 0;

  for(var2 = getaiarray("axis").size; var2 > 20; var2 = getaiarray("axis").size) {
    wait 1;
  }

  var3 = undefined;

  switch (var0.group_name) {
    case "morales_holdout_5_NW":
      var3 = "morales_holdout_5_SW";
      break;
    case "morales_holdout_5_SW":
      var3 = "morales_holdout_5_SE";
      break;
    case "morales_holdout_5_SE":
      var3 = "morales_holdout_5_OS";
      break;
    case "morales_holdout_5_OS":
      var3 = "morales_holdout_5_NW";
      break;
    default:
      var3 = undefined;
      break;
  }

  return var3;
}

function reset_recharge_after_respawn(var0) {
  if(!istrue(level.inmoralesholdout)) {
    return undefined;
  }

  wait 10;

  while(var0.activecount > 1) {
    wait 1;
  }

  if(!istrue(level.inmoralesholdout)) {
    return undefined;
  }

  var1 = var0.group_name;

  switch (var0.group_name) {
    case "morales_heli_approach":
      var1 = "morales_heli_1";
      break;
    case "morales_heli_1":
      var1 = "morales_heli_2";
      break;
    case "morales_heli_2":
      var1 = "morales_heli_approach";
      break;
  }

  return var1;
}

function debugmoralesobjectivesstart(var0) {
  scripts\engine\utility::flag_set("cp_morales_cs");
  scripts\engine\utility::flag_wait("cp_morales_cs_completed");
  scripts\engine\utility::flag_wait("objectives_registered");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "morales_debug_start_loc");
}

function initmorales_1(var0, var1) {
  if(!istrue(scripts\engine\utility::flag("cp_morales_cs"))) {
    scripts\engine\utility::flag_set("cp_morales_cs");
  }

  scripts\engine\utility::flag_wait("cp_morales_cs_completed");
  scripts\engine\utility::flag_wait("morales_spawn_functions_registered");
  level.initlocationcircle = "morales_1";
  level.initlethalmaxoffsetmap = "morales_1";
  scripts\cp\utility::skydivestreamhintdvars("morales");

  if(!isDefined(level.moraleswid)) {
    level.moraleswid = scripts\cp\cp_objectives::requestworldid("morales_HVT_WID");
  }

  thread initmoraleslaptop();
  thread scripts\cp\cp_modular_spawning::run_spawn_module("morales_1_patrols");
  level thread scripts\cp\utility::ref_123fe("mus_cp_armsrace_start");
  level.little_bird_mg_handleflarerecharge = 1;
  scripts\cp\cp_objectives::ref_11f80(var0.objectiveindex);
}

function startmorales_1(var0, var1) {
  level endon("stop_morales_hvt_objectives");
  var2 = scripts\engine\utility::getStruct("obj1_HVT_first_loc", "script_noteworthy");
  waitforoneplayernearpoint(var2.origin, 3000, 0);
  thread scripts\cp\cp_modular_spawning::run_spawn_module("morales_infil_house_1");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_rescue_hvi_morales_nag_10", "allies");
  waitforoneplayernearpoint(var2.origin, 700, 0);
  wait 2;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_rescue_hvi_morales_nag_20", "allies");
  wait 2;
}

function completemorales_1(var0) {
  scripts\cp\cp_objectives::overridenextstep(var0, "morales_2");
}

function initmorales_2(var0, var1) {
  if(!istrue(scripts\engine\utility::flag("cp_morales_cs"))) {
    scripts\engine\utility::flag_set("cp_morales_cs");
  }

  scripts\engine\utility::flag_wait("cp_morales_cs_completed");
  scripts\engine\utility::flag_wait("morales_spawn_functions_registered");
  level.initlocationcircle = "morales_1";
  level.initlethalmaxoffsetmap = "morales_1";
  scripts\cp\utility::skydivestreamhintdvars("morales");
  initmoraleslaptop(level);
  level notify("enable_morales_laptop_interaction");

  if(!isDefined(level.moraleswid)) {
    level.moraleswid = scripts\cp\cp_objectives::requestworldid("morales_HVT_WID");
  }

  scripts\cp\cp_objectives::ref_11f80(var0.objectiveindex);
}

function startmorales_2(var0, var1) {
  level endon("stop_morales_hvt_objectives");
  thread nag_player_for_laptop(var0);
  var0 waittill("start_hacking_morales_laptop");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("morales_hack_laptop_2");
  level waittill("cpu_hacking_done");
  wait 2;
  level notify("morales_laptop_activated");
  level thread scripts\cp\utility::ref_123fe("");
  wait 2;
}

function completemorales_2(var0) {
  scripts\cp\cp_objectives::overridenextstep(var0, "morales_3");
}

function nag_player_for_laptop(var0) {
  level endon("game_ended");
  var0 endon("start_hacking_morales_laptop");

  for(;;) {
    wait 30;
    level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_rescue_hvi_morales_nag_30", "allies");
  }
}

function initmorales_3(var0, var1) {
  if(!istrue(scripts\engine\utility::flag("cp_morales_cs"))) {
    scripts\engine\utility::flag_set("cp_morales_cs");
  }

  scripts\engine\utility::flag_wait("cp_morales_cs_completed");
  scripts\engine\utility::flag_wait("morales_spawn_functions_registered");
  level.initlocationcircle = "morales_1";
  level.initlethalmaxoffsetmap = "morales_1";
  scripts\cp\utility::skydivestreamhintdvars("morales");
  var2 = randomintrange(1, 3);
  var3 = undefined;

  switch (var2) {
    case 0:
    default:
      var3 = "A";
      break;
    case 1:
      var3 = "B";
      break;
    case 2:
      var3 = "C";
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

  if(!isDefined(level.moraleswid)) {
    level.moraleswid = scripts\cp\cp_objectives::requestworldid("morales_HVT_WID");
  }

  initmoraleshvtmodel(var5.origin);
  var0 scripts\cp\cp_objectives::ref_1317e(var0, level.moraleshostage.origin);
}

function startmorales_3(var0, var1) {
  level endon("stop_morales_hvt_objectives");
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_rescue_hvi_laptop_success_30", "allies");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("morales_rescue_hvt_3_" + var0.spawngroup);
  thread domoralestiedanim(level.moraleshostage);
  waitforoneplayernearpoint(level.moraleshostage.origin, 200, 0);
  level.moraleshostage thread scripts\cp\utility::playsoundatpos_safe(level.moraleshostage.origin, "dx_cps_drjm_rescue_hvi_found_callout_10");
  level waittill("player_picked_up_hostage", var2);
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var2, "obj_package");
  level thread scripts\cp\utility::ref_123fe("mus_cp_armsrace_morales_pickup");
  wait 4;
  level.moraleshostage thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_drjm_rescue_hvi_pickup_20", "allies");
}

function completemorales_3(var0) {
  scripts\cp\cp_objectives::overridenextstep(var0, "morales_4");
}

function initmorales_4(var0, var1) {
  if(!istrue(scripts\engine\utility::flag("cp_morales_cs"))) {
    scripts\engine\utility::flag_set("cp_morales_cs");
  }

  scripts\engine\utility::flag_wait("cp_morales_cs_completed");
  scripts\engine\utility::flag_wait("morales_spawn_functions_registered");
  level.initlocationcircle = "morales_1";
  level.initlethalmaxoffsetmap = "morales_1";
  scripts\cp\utility::skydivestreamhintdvars("morales");
  var2 = scripts\engine\utility::getStruct("morales_debug_hvt_slow_spawn", "script_noteworthy");

  if(!isDefined(level.moraleswid)) {
    level.moraleswid = scripts\cp\cp_objectives::requestworldid("morales_HVT_WID");
  }

  if(!isDefined(level.moraleshostage)) {
    initmoraleshvtmodel(var2.origin);
  }

  var0.customwaypointid = scripts\cp\cp_objectives::requestworldid("morales_signal_4", 15);
  var3 = scripts\engine\utility::getStruct("morales_move_to_ambush", "script_noteworthy");
  objective_setplayintro(var0.customwaypointid, 1);
  objective_setplayoutro(var0.customwaypointid, 1);
  objective_state(var0.customwaypointid, "current");
  objective_position(var0.customwaypointid, var3.origin);
  objective_setdescription(var0.customwaypointid, &"CP_BR_SYRK_OBJECTIVES/MOVE_LZ");
  objective_setlabel(var0.customwaypointid, &"CP_BR_SYRK_OBJECTIVES/MOVE_LZ");
  objective_icon(var0.customwaypointid, "icon_waypoint_objective_general");
  objective_setbackground(var0.customwaypointid, 0);
  scripts\cp\cp_objectives::ref_11f80(var0.customwaypointid);
  var0 scripts\cp\cp_objectives::ref_1317e(var0, var3.origin);
}

function startmorales_4(var0, var1) {
  level endon("stop_morales_hvt_objectives");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_rescue_hvi_pickup_10", "allies");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("morales_walk_sniper_back");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("morales_walk_ar_back");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("morales_walk_sniper_front");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("morales_walk_ar_front");
  thread watchformoralesnearpointarray(level, "morales_obj_close_to_pool");
  thread watchformoralesnearstruct(level, "morales_pool_marker");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("morales_signal_heli_4");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("morales_heli_approach");
  level waittill("morales_near_morales_pool_marker");
  level notify("spawn_module_morales_signal_heli_4_completed");
  objective_delete(var0.customwaypointid);
  scripts\cp\cp_objectives::freeworldid("morales_signal_4");
  var2 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("allies"));
  wait level scripts\cp\cp_player_battlechatter::trysaylocalsound(var2, "obj_holding");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_rescue_hvi_success_10", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_rescue_hvi_defend_10", "allies");
  wait 1;
}

function completemorales_4(var0) {
  scripts\cp\cp_objectives::overridenextstep(var0, "morales_5");
}

function initmorales_5(var0, var1) {
  if(!istrue(scripts\engine\utility::flag("cp_morales_cs"))) {
    scripts\engine\utility::flag_set("cp_morales_cs");
  }

  scripts\engine\utility::flag_wait("cp_morales_cs_completed");
  scripts\engine\utility::flag_wait("morales_spawn_functions_registered");
  level.initlocationcircle = "morales_1";
  level.initlethalmaxoffsetmap = "morales_1";
  scripts\cp\utility::skydivestreamhintdvars("morales");
  var2 = scripts\engine\utility::getStruct("morales_debug_hvt_slow_spawn", "script_noteworthy");

  if(!isDefined(level.moraleswid)) {
    level.moraleswid = scripts\cp\cp_objectives::requestworldid("morales_HVT_WID");
  }

  if(!isDefined(level.moraleshostage)) {
    initmoraleshvtmodel(var2.origin);
    return;
  }
}

function startmorales_5(var0, var1) {
  level endon("stop_morales_hvt_objectives");
  level thread scripts\cp\utility::ref_123fe("mus_cp_armsrace_doctor_exfil");
  level.inmoralesholdout = 1;
  thread mark_as_bomb_vest_controller_holder(0);
  waitframe();
  thread scripts\cp\cp_modular_spawning::run_spawn_module("morales_holdout_5");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("morales_heli_1");
  scripts\cp\crate_drops\cp_crate_drops::ref_12c40("morales_1");

  if(true) {
    wait 60;
  }

  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_rescue_hvi_defend_60sec_20", "allies");
  wait 30;
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_rescue_hvi_defend_30sec_20", "allies");
  wait 15;
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_rescue_hvi_defend_15sec_20", "allies");
  wait 15;
  level thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_rescue_hvi_secondary_10", "allies");
  togglewavespawning(0);
  level.inmoralesholdout = undefined;
  level notify("morales_holdout_finished");
  level thread scripts\cp\utility::ref_123fe("");
}

function completemorales_5(var0) {
  level notify("morales_holdout_completed");
  scripts\cp\cp_objectives::overridenextstep(var0, "morales_6");
}

function initmorales_6(var0, var1) {
  if(!istrue(scripts\engine\utility::flag("cp_morales_cs"))) {
    scripts\engine\utility::flag_set("cp_morales_cs");
  }

  scripts\engine\utility::flag_wait("cp_morales_cs_completed");
  scripts\engine\utility::flag_wait("morales_spawn_functions_registered");
  level.initlocationcircle = "morales_1";
  level.initlethalmaxoffsetmap = "morales_1";
  scripts\cp\utility::skydivestreamhintdvars("morales");
  var2 = scripts\engine\utility::getStruct("morales_slow_heli_B", "targetname");
  var3 = scripts\engine\utility::getStruct("morales_debug_hvt_slow_spawn", "script_noteworthy");
  var0.exfilstruct = var2;

  if(!isDefined(level.moraleswid)) {
    level.moraleswid = scripts\cp\cp_objectives::requestworldid("morales_HVT_WID");
  }

  if(!isDefined(level.moraleshostage)) {
    initmoraleshvtmodel(var3.origin);
  }

  scripts\cp\cp_objectives::ref_11f80(var0.objectiveindex);
}

function startmorales_6(var0, var1) {
  level endon("stop_morales_hvt_objectives");
  var2 = scripts\engine\utility::getStruct("morales_heli_spawn", "targetname");
  var3 = scripts\engine\utility::getStruct("morales_heli_trip_start", "targetname");
  var2.vehicletype = "blima_cp";
  thread scripts\cp\cp_modular_spawning::run_spawn_module("morales_slow_load_hvt_6");
  thread ref_13019();
  level.computer_debugtestloop = 1;
  thread scripts\cp\vehicles\cp_heli_trip::start_heli_trip_sequence(var2, var0.exfilstruct, var3, 1);
  thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_rescue_hvi_exfil_nag_10", "allies");
  level.heli_trip_vehicle waittill("player_boarded_heli");
  thread mark_as_bomb_vest_controller_holder(5);
  objective_state(level.moraleswid, "invisible");
  objective_delete(level.moraleswid);
  thread ref_1432d();
  level waittill("heli_trip_took_off");
  thread maxlootleadermarkcount();
  thread ref_143ff();
  wait 3;
}

function completemorales_6(var0) {
  if(isDefined(level.moraleswid)) {
    scripts\cp\cp_objectives::freeworldid("morales_HVT_WID");
  }

  scripts\mp\brclientmatchdata::getprophealth("apce_p1");
  level.little_bird_mg_handleflarerecharge = 0;
  thread scripts\cp\cp_objectives::screenent_c("major_objective");
}

function ref_1432d() {
  level endon("game_ended");
  level waittill("cp_heli_trip_obj_secured_vo_done");
  level.moraleshostage thread scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_drjm_rescue_hvi_exfil_10", "allies");
  level thread scripts\cp\utility::ref_123fe("mus_cp_armsrace_doctor_exfil_complete");
}

function ref_13019() {
  level endon("game_ended");
  var0 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(var2 in var0) {
    var2.goal_radius = 256;
    var2.script_origin_other = scripts\cp\utility::get_center_point_of_array(level.players);
  }
}

function mark_as_bomb_vest_controller_holder(var0) {
  level endon("game_ended");
  wait var0;
  var1 = scripts\engine\utility::getStruct("morales_ai_mass_escape", "targetname");
  var2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(var4 in var2) {
    thread ref_12cd0(var4);
  }
}

function ref_12cd0(var0) {
  level endon("game_ended");
  self endon("death");
  self notify("received_retreat_order");
  self.ignoreall = 1;
  self.goalradius = 64;
  self setgoalpos(var0);
  scripts\engine\utility::waittill_notify_or_timeout("goal", 40);
  self dodamage(self.health + 100, self.origin);
}

function ref_143ff() {
  level endon("death");
  scripts\engine\utility::flag_set("cp_payloadobjective_cs");
  scripts\engine\utility::flag_wait("cp_payloadobjective_cs_completed");
  scripts\engine\utility::flag_wait("payload_spawn_functions_registered");
  thread scripts\cp\cp_objectives::run_objective("obj_payload", "primary");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("escort_intro_rpg");
}

function maxlootleadermarkcount() {
  level endon("game_ended");
  level.ref_139b5 = 1;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_rescue_hvi_exfil_20", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_drjm_rescue_hvi_exfil_30", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_apc_brief_10", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_drjm_apc_brief_20", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_apc_brief_30", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_apc_brief_40", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_apc_brief_50", "allies");
  wait 2;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_apc_brief_60", "allies");
  wait 2;
  level.ref_139b5 = 0;
  level notify("morales_outro_vo_done");
}

function togglewavespawning(var0) {}

function morales_guard_post_func(var0) {
  waitframe();
  self.maxfaceenemydist = 768;
  self.dontevershoot = 1;
  self.ignoreall = 1;
  thread dorandomguardanim(self);
  thread watchforguardclosetoplayers(self, "allies");
  thread watchfordamage(self);
  thread waitformoralesguardgoinghot(self);
}

function dorandomguardanim(var0) {
  level endon("game_ended");
  var0 endon("death");
  level endon("morales_guards_went_hot");
  var1 = "cp_guard_standing_idle_01";
  var0 scripts\asm\shared\mp\utility::bunkerinteriorkeypads(var1);
}

function watchforguardclosetoplayers(var0, var1) {
  level endon("game_ended");
  var0 endon("death");
  level endon("morales_guards_went_hot");
  var2 = 2250000;

  for(;;) {
    var3 = scripts\cp\utility::getplayersinteam(var1);
    var4 = 0;

    foreach(var6 in var3) {
      if(scripts\engine\utility::distance_2d_squared(var6.origin, var0.origin) <= var2 && var0 cansee(var6)) {
        var4 = 1;
      }
    }

    if(var4) {
      level notify("morales_guards_went_hot");
    }

    wait 0.5;
  }
}

function watchfordamage(var0) {
  level endon("game_ended");
  level endon("morales_guards_went_hot");
  var0 scripts\engine\utility::ref_143a8("death", "alerted", "damage", "explode", "large_explosion");
  level notify("morales_guards_went_hot");
}

function waitformoralesguardgoinghot(var0) {
  level endon("game_ended");
  var0 endon("death");
  level waittill("morales_guards_went_hot");
  var0.dontevershoot = 0;
  var0.ignoreall = 0;
  var0.scripted_mode = 0;
  var0 scripts\asm\shared\mp\utility::bunkercounteruav();
}

function domoralestiedanim(var0) {
  level endon("game_ended");
  var0 endon("death");
  var0.body scriptmodelplayanim("cp_morales_tied_down");
  level waittill("morales_guards_went_hot");
  var0.body scriptmodelplayanim("sdr_cp_hostage_dropoff_ground_idle_pilot");
}

function markedentitieslifeindices() {
  level endon("game_ended");
  level endon("player_picked_up_hostage");

  for(;;) {
    wait 15;
    level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_rescue_hvi_pickup_" + randomintrange(1, 6) + "0", "allies");
  }
}

function ref_144c0(var0) {
  level endon("game_ended");
  level endon("morales_exfiled");
  var0 endon("exfil");
  var0 endon("death");

  for(;;) {
    level waittill("player_picked_up_hostage", var1);
    thread ref_144c1(var1, var1);
  }
}

function ref_144c1(var0, var1) {
  level endon("morales_exfiled");
  level endon("game_ended");
  var1 endon("exfil");
  var1 endon("death");
  var1 endon("dropped");

  for(;;) {
    var0 waittill("damage");
    level.moraleshostage scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_drjm_rescue_hvi_shot_react_" + randomintrange(1, 7) + "0", "allies");
    wait 10;
  }
}