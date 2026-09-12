/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_alt_mode_eas.gsc
****************************************************/

function molotov_get_cast_level_data() {
  var_0 = getdvarint("scr_br_eas", 0) == 1;

  if(!var_0) {
    return;
  }

  thread aggro_player_weight();
}

function aggro_player_weight() {
  thread advanced_supply_drop_marker_sfx();
  var_0 = getdvarint("scr_br_eas_debug", 0) == 1;

  if(var_0) {
    thread afkroundcounted();
  }

  if(!scripts\mp\flags::levelflag("scriptables_ready")) {
    scripts\mp\flags::levelflagwait("scriptables_ready");
  }

  var_1 = getdvarint("scr_br_eas_wait_for_prematch", 1) == 1;

  if(var_1) {
    scripts\mp\flags::gameflagwait("prematch_done");
  }

  scripts\engine\scriptable::ref_12F5A(&ai_anim_relative);
  thread ai_ascender_animin();
}

function advanced_supply_drop_marker_sfx() {
  scripts\mp\utility\sound::besttime("br_mode_elf_and_seek");
}

function ai_ascender_animin() {
  level.monitor_waypoint_objective_on_front_truck = [];
  var_0 = aggressive_melee_charge_init();
  var_1 = level.mapname == "mp_br_mechanics";
  var_2 = getdvarint("scr_br_eas_force_use_data_positions", 0) == 1;

  if(var_1 && !var_2) {
    var_0 = aggressively_chase_down_target();
  }

  var_3 = var_0.size;
  var_4 = [];

  for(var_5 = 0; var_5 < var_3; var_5++) {
    var_4 = var_5;
  }

  var_6 = scripts\engine\utility::array_randomize(var_4);
  var_7 = [];

  for(var_5 = 0; var_5 < var_3; var_5++) {
    var_7 = [];

    for(var_8 = 0; var_8 < var_0[var_5].size; var_8++) {
      var_9 = var_7[var_5].size;
      var_7[var_9] = var_8;
    }

    var_7 = scripts\engine\utility::array_randomize(var_7[var_5]);
  }

  var_10 = getdvarint("scr_br_eas_max_num_elves", -1);
  var_11 = getdvarint("scr_br_eas_num_elf_regions_per_map", 13);
  var_12 = getdvarint("scr_br_eas_num_elf_buildings_per_region", 3);
  var_13 = 0;

  for(var_14 = 0; var_14 < var_12; var_14++) {
    for(var_15 = 0; var_15 < var_11; var_15++) {
      if(var_13 >= var_10 && var_10 != -1) {
        break;
      }

      if(var_15 >= var_6.size) {
        break;
      }

      var_16 = var_6[var_15];
      var_17 = var_7[var_16];

      if(var_14 >= var_17.size) {
        continue;
      }

      var_18 = var_7[var_16][var_14];
      level.monitor_waypoint_objective_on_front_truck[var_13] = spawnStruct();
      level.monitor_waypoint_objective_on_front_truck[var_13].monitor_player_plunder = var_13;
      level.monitor_waypoint_objective_on_front_truck[var_13].armsrace_c4_planter_attack = 0;
      level.monitor_waypoint_objective_on_front_truck[var_13].ref_12AD3 = var_16;
      level.monitor_waypoint_objective_on_front_truck[var_13].first_switch = var_18;
      var_13++;
    }
  }

  after_spawn_func("Spawning " + level.monitor_waypoint_objective_on_front_truck.size + " elves");

  foreach(var_20 in level.monitor_waypoint_objective_on_front_truck) {
    var_21 = var_0[var_20.ref_12AD3][var_20.first_switch];
    var_22 = scripts\engine\utility::array_randomize(var_21);
    var_23 = [];
    var_24 = getdvarint("scr_br_eas_num_lives", 3);

    for(var_25 = 0; var_25 < var_24; var_25++) {
      if(isDefined(var_22[var_25])) {
        var_23 = var_22[var_25];
      }
    }

    var_20.ref_13695 = var_23;
    var_20.interaction_get_cost = 0;
  }

  foreach(var_20 in level.monitor_waypoint_objective_on_front_truck) {
    thread ai_ascender_doanims(level);
  }
}

function aggressively_chase_down_target() {
  var_0 = [];
  var_1 = 0;
  var_2 = 0;

  for(var_3 = 0; var_3 < 6; var_3++) {
    var_4 = var_1 + 1000 * var_3;
    var_5 = var_2 - 1000 * var_3;
    var_0 = [];
    var_0[0] = [];
    var_6 = 4;

    for(var_7 = 0; var_7 < var_6; var_7++) {
      var_8 = spawnStruct();
      var_8.ref_12812 = var_4 + 100 * var_7;
      var_8.ref_12813 = var_5 - 100 * var_7;
      var_8.ref_12814 = 100;
      var_8.building_roof_chopper_reenforce_watch = randomintrange(-180, 180);
      var_8.building_roof_jugg_behavior = randomintrange(-180, 180);
      var_8.building_roof_jugg_protect_roof_then_chase = randomintrange(-180, 180);
      var_8.busbpulledout = var_3;
      var_9 = var_0[var_3][0].size;
      var_0[0][var_9] = var_8;
    }
  }

  return var_0;
}

function aggressive_melee_charge_init() {
  var_0 = [];
  var_1 = 0;
  var_2 = 1;
  var_3 = 2;
  var_4 = 3;
  var_5 = 4;
  var_6 = 5;
  var_7 = 6;
  var_8 = 7;
  var_9 = 8;
  var_10 = 9;
  var_11 = "mp/br_eas_locations.csv";
  var_12 = tablelookupgetnumrows(var_11);

  for(var_13 = 0; var_13 < var_12; var_13++) {
    var_14 = int(tablelookupbyrow(var_11, var_13, var_1));
    var_15 = getdvarint("scr_br_eas_elf_pos_blacklist_" + var_14, 0) == 1;

    if(var_15) {
      continue;
    }

    var_16 = int(tablelookupbyrow(var_11, var_13, var_2));
    var_17 = getdvarint("scr_br_eas_elf_region_blacklist_" + var_16, 0) == 1;

    if(var_17) {
      continue;
    }

    if(!isDefined(var_0[var_16])) {
      var_0 = [];
    }

    var_18 = int(tablelookupbyrow(var_11, var_13, var_3));
    var_19 = getdvarint("scr_br_eas_elf_building_blacklist_" + var_16 + "_" + var_18, 0) == 1;

    if(var_17) {
      continue;
    }

    if(!isDefined(var_0[var_16][var_18])) {
      var_0[var_18] = [];
    }

    var_20 = spawnStruct();
    var_20.ref_12812 = int(tablelookupbyrow(var_11, var_13, var_4));
    var_20.ref_12813 = int(tablelookupbyrow(var_11, var_13, var_5));
    var_20.ref_12814 = int(tablelookupbyrow(var_11, var_13, var_6));
    var_20.building_roof_chopper_reenforce_watch = int(tablelookupbyrow(var_11, var_13, var_7));
    var_20.building_roof_jugg_behavior = int(tablelookupbyrow(var_11, var_13, var_8));
    var_20.building_roof_jugg_protect_roof_then_chase = int(tablelookupbyrow(var_11, var_13, var_9));
    var_20.busbpulledout = int(tablelookupbyrow(var_11, var_13, var_10));
    var_21 = var_0[var_16][var_18].size;
    var_0[var_18][var_21] = var_20;
  }

  return var_0;
}

function ai_anim_relative(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_2) || var_2.type != "gnome_collision") {
    return;
  }

  thread ai_array(level, level.monitor_waypoint_objective_on_front_truck[var_2.monitor_player_plunder], var_3);
}

function ai_array(var_0, var_1, var_2) {
  var_3 = var_0.collision;
  var_4 = getdvarint("scr_br_eas", 500);
  var_0.armsrace_c4_planter_attack += var_1;

  if(var_0.armsrace_c4_planter_attack > var_4) {
    var_0.interaction_get_cost++;
    var_0.scriptable setscriptablepartstate("sound_timer", "sound_off");

    if(isDefined(var_2) && isPlayer(var_2)) {
      scripts\mp\gametypes\br_analytics::destroy_vehicle_if_driver_dies(var_2, var_0.interaction_get_cost);
    }

    if(var_0.interaction_get_cost < var_0.ref_13695.size) {
      thread ai_ascender_doanims(level);
    } else {
      thread aggressive_melee_active(level, var_0.monitor_player_plunder);
    }
  }

  waitframe();
}

function aggressive_melee_active(var_0, var_1) {
  var_2 = level.monitor_waypoint_objective_on_front_truck[var_0];
  var_2.scriptable notify("elf_interaction");
  var_2.scriptable setscriptablepartstate("visuals", "hidden");
  var_2.collision setscriptablepartstate("vfx", "vfx_death");
  var_2.scriptable setscriptablepartstate("SOUND_IDLE", "SOUND_IDLE_OFF");

  if(isDefined(var_1) && isPlayer(var_1)) {
    var_1 scripts\cp\vehicles\vehicle_compass_cp::ref_1301E("eas_elf_defeated", 1);
  }

  waitframe();
  thread ai_ascender_animloop(level, var_2.scriptable.origin);
  var_3 = 6;
  wait var_3;
  var_2.scriptable freescriptable();
}

function ai_ascender_animloop(var_0, var_1) {
  var_2 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  var_3 = 10;
  var_4 = verifybunkercode("festive_fervor_ultra_crate", randomint(var_3));
  GscBinSkip0(0x2e, var_4.size, "brloot_plunder_cash_rare_1");
}

function apc_horn(var_0, var_1) {
  return (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
}

function ai_ascender_doanims(var_0) {
  var_1 = "vfx_enter";
  var_2 = "vfx_exit";
  var_3 = "hidden";
  var_4 = "hidden";
  var_5 = 0.25;
  var_6 = level.monitor_waypoint_objective_on_front_truck[var_0];

  if(isDefined(var_6.scriptable) &isDefined(var_6.collision)) {
    var_6.scriptable notify("elf_interaction");
    var_6.collision setscriptablepartstate("vfx", var_2);
    var_6.scriptable setscriptablepartstate("SOUND_IDLE", "SOUND_IDLE_OFF");
    var_7 = getdvarfloat("scr_br_eas_exit_delay", 0.25);
    wait var_7;
    var_6.scriptable setscriptablepartstate("visuals", var_4);
    var_8 = getdvarfloat("scr_br_eas_cleanup_delay", 3);
    wait var_8;
  }

  if(isDefined(var_6.scriptable)) {
    var_6.scriptable freescriptable();
  }

  if(isDefined(var_6.collision)) {
    var_6.collision freescriptable();
  }

  var_9 = var_6.ref_13695[var_6.interaction_get_cost];
  var_10 = var_9.ref_12812;
  var_11 = var_9.ref_12813;
  var_12 = var_9.ref_12814;
  var_13 = (var_10, var_11, var_12);
  var_14 = var_9.building_roof_chopper_reenforce_watch;
  var_15 = var_9.building_roof_jugg_behavior;
  var_16 = var_9.building_roof_jugg_protect_roof_then_chase;
  var_17 = (var_14, var_15, var_16);
  var_6.scriptable = easepower("gnome", var_13, var_17);
  var_6.scriptable setscriptablepartstate("visuals", var_4);
  var_6.armsrace_c4_planter_attack = 0;
  waitframe();
  var_18 = var_9.busbpulledout;
  var_19 = "anim_" + var_18;
  var_20 = [];
  GscBinSkip0(0x2e, 0, 20);
}

function advanced_supply_drop_refund_on_death(var_0) {
  level endon("game_ended");
  var_1 = level.monitor_waypoint_objective_on_front_truck[var_0];
  var_1.scriptable notify("elf_interaction");
  var_1.scriptable endon("elf_interaction");
  var_1.scriptable setscriptablepartstate("sound_timer", "sound_on");
  var_3 = getdvarint("scr_br_eas_vo_delay", 7);
  var_4 = getdvarint("scr_br_eas_countdown", 15);
  var_4 = max(var_4, var_3);
  wait var_3;
  var_5 = randomint(6);
  var_6 = "vo_" + var_5;
  var_1.scriptable setscriptablepartstate("sound_one_shot", var_6);
  var_7 = var_4 - var_3;
  wait var_7;
  var_1.scriptable setscriptablepartstate("sound_timer", "sound_off");
  thread ai_aggro_goal_shrink(var_0);
}

function ai_aggro_goal_shrink(var_0) {
  var_1 = level.monitor_waypoint_objective_on_front_truck[var_0];
  var_1.scriptable notify("elf_interaction");
  var_2 = [];
  GscBinSkip0(0x2e, var_2.size, "dx_brm_gnom_gnome_laugh_10");
}

function ai_ascender_animout(var_0) {
  level endon("game_ended");
  var_1 = level.monitor_waypoint_objective_on_front_truck[var_0];
  var_1.scriptable notify("elf_interaction");
  var_1.scriptable endon("elf_interaction");
  var_2 = 5;
  var_3 = randomint(var_2);
  wait var_3;

  for(;;) {
    wait var_2;
    var_4 = getdvarint("scr_br_eas_start_range", 90);
    var_5 = scripts\mp\utility\player::getplayersinradius(var_1.scriptable.origin, var_4);

    if(var_5.size > 0) {
      var_7 = [];
      GscBinSkip0(0x2e, var_7.size, "dx_brm_gnom_gnome_laugh_10");
    }
  }
}

function affect_hvt_healthdrain(var_0) {
  var_1 = spawnStruct();

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    switch (var_2) {
      case 0:
        break;
      case 1:
        var_1.ref_12812 = int(var_0[var_2]);
        break;
      case 2:
        var_1.ref_12813 = int(var_0[var_2]);
        break;
      case 3:
        var_1.ref_12814 = int(var_0[var_2]);
        break;
      case 4:
        break;
      case 5:
        var_1.building_roof_chopper_reenforce_watch = int(var_0[var_2]);
        break;
      case 6:
        var_1.building_roof_jugg_behavior = int(var_0[var_2]);
        break;
      case 7:
        var_1.building_roof_jugg_protect_roof_then_chase = int(var_0[var_2]);
        break;
      case 8:
        break;
      case 9:
        var_1.bunkeralt_playeridlewatch = int(var_0[var_2]);
        break;
    }
  }

  return var_1;
}

function agent_pickup_hostage_scene() {
  var_0 = level.istwohandedoffhand;
  var_1 = " Origin: " + var_0.ref_12812 + " " + var_0.ref_12813 + " " + var_0.ref_12814;
  var_1 += " Angles: " + var_0.building_roof_chopper_reenforce_watch + " " + var_0.building_roof_jugg_behavior + " " + var_0.building_roof_jugg_protect_roof_then_chase;
  var_1 += " AnimID: " + var_0.bunkeralt_playeridlewatch;
  iprintlnbold(var_1);
  var_1 = "set scr_br_eas_spawn" + var_1;
  var_1 = "############################################" + var_1;
  logstring(var_1);
}

function agentclasscallback() {
  if(!isDefined(level.players) || !isDefined(level.players[0])) {
    return;
  }

  level.isspecialcaseweapon = easepower("gnome_collision", level.players[0].origin, level.players[0].angles);
}

function agentsinsphere(var_0) {
  if(!isDefined(level.players) || !isDefined(level.players[0])) {
    return;
  }

  if(!isDefined(level.ref_13845)) {
    thread after_hit_by_emp_func();
    level.ref_13845 = 1;
  }

  var_1 = level.istwohandedoffhand;

  if(isDefined(var_0)) {
    var_2 = 10;
    var_3 = strtok(var_0, " ");

    if(var_3.size == var_2) {
      var_1 = affect_hvt_healthdrain(var_3);
    } else {
      iprintlnbold("Invalid Command, defaulting to player settings. Example: set scr_br_eas_spawnOrigin: 12 13 0Angles: 10 100 100AnimID: 1");
      var_1 = spawnStruct();
      var_1.ref_12812 = int(level.players[0].origin[0]);
      var_1.ref_12813 = int(level.players[0].origin[1]);
      var_1.ref_12814 = int(level.players[0].origin[2]) + 40;
      var_1.building_roof_chopper_reenforce_watch = int(level.players[0].angles[0]);
      var_1.building_roof_jugg_behavior = int(level.players[0].angles[1]);
      var_1.building_roof_jugg_protect_roof_then_chase = int(level.players[0].angles[2]);
      var_1.bunkeralt_playeridlewatch = 0;
    }
  }

  var_4 = (var_1.ref_12812, var_1.ref_12813, var_1.ref_12814);
  var_5 = (var_1.building_roof_chopper_reenforce_watch, var_1.building_roof_jugg_behavior, var_1.building_roof_jugg_protect_roof_then_chase);

  if(!isDefined(level.isspawningstopped)) {
    level.isspawningstopped = easepower("gnome", var_4, var_5);
  } else {
    level.isspawningstopped.origin = var_4;
    level.isspawningstopped.angles = var_5;
  }

  level.istwohandedoffhand = var_1;
  var_6 = "anim_" + var_1.bunkeralt_playeridlewatch;
  level.isspawningstopped setscriptablepartstate("visuals", var_6);
  agent_pickup_hostage_scene();
}

function agentthink(var_0, var_1) {
  var_2 = 4;
  var_3 = 15;

  switch (var_0) {
    case "posX":
      level.istwohandedoffhand.ref_12812 += var_2 * var_1;
      break;
    case "posY":
      level.istwohandedoffhand.ref_12813 += var_2 * var_1;
      break;
    case "posZ":
      level.istwohandedoffhand.ref_12814 += var_2 * var_1;
      break;
    case "anglesX":
      level.istwohandedoffhand.building_roof_chopper_reenforce_watch += var_3 * var_1;
      break;
    case "anglesY":
      level.istwohandedoffhand.building_roof_jugg_behavior += var_3 * var_1;
      break;
    case "anglesZ":
      level.istwohandedoffhand.building_roof_jugg_protect_roof_then_chase += var_3 * var_1;
      break;
    case "animID":
      level.istwohandedoffhand.bunkeralt_playeridlewatch += var_1;

      if(level.istwohandedoffhand.bunkeralt_playeridlewatch == -1) {
        level.istwohandedoffhand.bunkeralt_playeridlewatch = 5;
      }

      level.istwohandedoffhand.bunkeralt_playeridlewatch %= 6;
      break;
  }

  agentsinsphere();
}

function agenttargetloadout(var_0) {
  var_1 = ["posX", "posY", "posZ", "anglesX", "anglesY", "anglesZ", "animID"];
  level.istutorial += var_0;

  if(level.istutorial == -1) {
    level.istutorial = var_1.size - 1;
  }

  level.istutorial %= var_1.size;
  level.istripwiredamagetype = var_1[level.istutorial];
  iprintlnbold("Active Parameter: " + level.istripwiredamagetype);
}

function after_hit_by_emp_func() {
  level endon("game_ended");
  var_0 = self;
  var_0 notifyonplayercommand("rb", "+frag");
  var_0 notifyonplayercommand("lb", "+smoke");
  var_0 notifyonplayercommand("dpad_down", "+actionslot 2");
  var_0 notifyonplayercommand("dpad_left", "+actionslot 3");

  for(;;) {
    var_1 = var_0 scripts\engine\utility::waittill_any_in_array_return(["rb", "lb", "dpad_down", "dpad_left"]);

    switch (var_1) {
      case "rb":
        agentthink(level.istripwiredamagetype, 1);
        break;
      case "lb":
        agentthink(level.istripwiredamagetype, -1);
        break;
      case "dpad_down":
        agenttargetloadout(1);
        break;
      case "dpad_left":
        agenttargetloadout(-1);
        break;
    }
  }
}

function agentsnear() {
  if(!isDefined(level.players) || !isDefined(level.players[0])) {
    return;
  }

  ai_ascender_animloop(level.players[0].origin, level.players[0].angles);
}

function agent_pickup_hostage_scene_body() {
  if(!isDefined(level.monitor_waypoint_objective_on_front_truck)) {
    return;
  }

  var_0 = 100;
  var_1 = (1, 0, 0);
  var_2 = 10;

  foreach(var_4 in level.monitor_waypoint_objective_on_front_truck) {
    var_5 = var_4.ref_13695[var_4.interaction_get_cost];

    if(!isDefined(var_5) || !isDefined(var_4.scriptable)) {
      continue;
    }

    var_6 = var_5.ref_12812;
    var_7 = var_5.ref_12813;
    var_8 = var_5.ref_12814;
    var_9 = (var_6, var_7, var_8);
    thread scripts\mp\utility\debug::drawsphere(var_9, var_0, var_2, var_1);
  }
}

function after_spawn_func(var_0) {
  var_1 = getdvarint("scr_br_eas_debug", 0) == 1;

  if(var_1) {
    iprintlnbold(var_0);
    logprint(var_0);
    return;
  }
}

function afkroundcounted() {
  level endon("game_ended");
  level.istripwiredamagetype = "posX";
  level.istutorial = 0;

  for(;;) {
    var_0 = getDvar("scr_br_eas_spawn", "");

    if(var_0 != "") {
      agentsinsphere(var_0);
    }

    var_1 = getDvar("scr_br_eas_spawn_collision", "");

    if(var_1 != "") {
      agentclasscallback();
    }

    var_2 = getDvar("scr_br_eas_spawn_loot", "");

    if(var_2 != "") {
      agentsnear();
    }

    var_3 = getDvar("scr_br_eas_show_locations", "");

    if(var_3 != "") {
      agent_pickup_hostage_scene_body();
    }

    var_4 = getDvar("scr_br_eas_kill", "");

    if(var_4 != "" && isDefined(level.monitor_waypoint_objective_on_front_truck) && isDefined(level.monitor_waypoint_objective_on_front_truck[0])) {
      ai_array(level.monitor_waypoint_objective_on_front_truck[0], 99999);
    }

    waitframe();
  }
}