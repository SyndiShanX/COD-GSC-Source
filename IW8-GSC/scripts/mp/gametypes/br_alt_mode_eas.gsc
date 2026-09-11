/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_alt_mode_eas.gsc
****************************************************/

function molotov_get_cast_level_data() {
  var0 = getdvarint("scr_br_eas", 0) == 1;

  if(!var0) {
    return;
  }

  thread aggro_player_weight();
}

function aggro_player_weight() {
  thread advanced_supply_drop_marker_sfx();
  var0 = getdvarint("scr_br_eas_debug", 0) == 1;

  if(var0) {
    thread afkroundcounted();
  }

  if(!scripts\mp\flags::levelflag("scriptables_ready")) {
    scripts\mp\flags::levelflagwait("scriptables_ready");
  }

  var1 = getdvarint("scr_br_eas_wait_for_prematch", 1) == 1;

  if(var1) {
    scripts\mp\flags::gameflagwait("prematch_done");
  }

  scripts\engine\scriptable::ref_12f5a(&ai_anim_relative);
  thread ai_ascender_animin();
}

function advanced_supply_drop_marker_sfx() {
  scripts\mp\utility\sound::besttime("br_mode_elf_and_seek");
}

function ai_ascender_animin() {
  level.monitor_waypoint_objective_on_front_truck = [];
  var0 = aggressive_melee_charge_init();
  var1 = level.mapname == "mp_br_mechanics";
  var2 = getdvarint("scr_br_eas_force_use_data_positions", 0) == 1;

  if(var1 && !var2) {
    var0 = aggressively_chase_down_target();
  }

  var3 = var0.size;
  var4 = [];

  for(var5 = 0; var5 < var3; var5++) {
    var4 = var5;
  }

  var6 = scripts\engine\utility::array_randomize(var4);
  var7 = [];

  for(var5 = 0; var5 < var3; var5++) {
    var7 = [];

    for(var8 = 0; var8 < var0[var5].size; var8++) {
      var9 = var7[var5].size;
      var7[var9] = var8;
    }

    var7 = scripts\engine\utility::array_randomize(var7[var5]);
  }

  var10 = getdvarint("scr_br_eas_max_num_elves", -1);
  var11 = getdvarint("scr_br_eas_num_elf_regions_per_map", 13);
  var12 = getdvarint("scr_br_eas_num_elf_buildings_per_region", 3);
  var13 = 0;

  for(var14 = 0; var14 < var12; var14++) {
    for(var15 = 0; var15 < var11; var15++) {
      if(var13 >= var10 && var10 != -1) {
        break;
      }

      if(var15 >= var6.size) {
        break;
      }

      var16 = var6[var15];
      var17 = var7[var16];

      if(var14 >= var17.size) {
        continue;
      }

      var18 = var7[var16][var14];
      level.monitor_waypoint_objective_on_front_truck[var13] = spawnStruct();
      level.monitor_waypoint_objective_on_front_truck[var13].monitor_player_plunder = var13;
      level.monitor_waypoint_objective_on_front_truck[var13].armsrace_c4_planter_attack = 0;
      level.monitor_waypoint_objective_on_front_truck[var13].ref_12ad3 = var16;
      level.monitor_waypoint_objective_on_front_truck[var13].first_switch = var18;
      var13++;
    }
  }

  after_spawn_func("Spawning " + level.monitor_waypoint_objective_on_front_truck.size + " elves");

  foreach(var20 in level.monitor_waypoint_objective_on_front_truck) {
    var21 = var0[var20.ref_12ad3][var20.first_switch];
    var22 = scripts\engine\utility::array_randomize(var21);
    var23 = [];
    var24 = getdvarint("scr_br_eas_num_lives", 3);

    for(var25 = 0; var25 < var24; var25++) {
      if(isDefined(var22[var25])) {
        var23 = var22[var25];
      }
    }

    var20.ref_13695 = var23;
    var20.interaction_get_cost = 0;
  }

  foreach(var20 in level.monitor_waypoint_objective_on_front_truck) {
    thread ai_ascender_doanims(level);
  }
}

function aggressively_chase_down_target() {
  var0 = [];
  var1 = 0;
  var2 = 0;

  for(var3 = 0; var3 < 6; var3++) {
    var4 = var1 + 1000 * var3;
    var5 = var2 - 1000 * var3;
    var0 = [];
    var0[0] = [];
    var6 = 4;

    for(var7 = 0; var7 < var6; var7++) {
      var8 = spawnStruct();
      var8.ref_12812 = var4 + 100 * var7;
      var8.ref_12813 = var5 - 100 * var7;
      var8.ref_12814 = 100;
      var8.building_roof_chopper_reenforce_watch = randomintrange(-180, 180);
      var8.building_roof_jugg_behavior = randomintrange(-180, 180);
      var8.building_roof_jugg_protect_roof_then_chase = randomintrange(-180, 180);
      var8.busbpulledout = var3;
      var9 = var0[var3][0].size;
      var0[0][var9] = var8;
    }
  }

  return var0;
}

function aggressive_melee_charge_init() {
  var0 = [];
  var1 = 0;
  var2 = 1;
  var3 = 2;
  var4 = 3;
  var5 = 4;
  var6 = 5;
  var7 = 6;
  var8 = 7;
  var9 = 8;
  var10 = 9;
  var11 = "mp/br_eas_locations.csv";
  var12 = tablelookupgetnumrows(var11);

  for(var13 = 0; var13 < var12; var13++) {
    var14 = int(tablelookupbyrow(var11, var13, var1));
    var15 = getdvarint("scr_br_eas_elf_pos_blacklist_" + var14, 0) == 1;

    if(var15) {
      continue;
    }

    var16 = int(tablelookupbyrow(var11, var13, var2));
    var17 = getdvarint("scr_br_eas_elf_region_blacklist_" + var16, 0) == 1;

    if(var17) {
      continue;
    }

    if(!isDefined(var0[var16])) {
      var0 = [];
    }

    var18 = int(tablelookupbyrow(var11, var13, var3));
    var19 = getdvarint("scr_br_eas_elf_building_blacklist_" + var16 + "_" + var18, 0) == 1;

    if(var17) {
      continue;
    }

    if(!isDefined(var0[var16][var18])) {
      var0[var18] = [];
    }

    var20 = spawnStruct();
    var20.ref_12812 = int(tablelookupbyrow(var11, var13, var4));
    var20.ref_12813 = int(tablelookupbyrow(var11, var13, var5));
    var20.ref_12814 = int(tablelookupbyrow(var11, var13, var6));
    var20.building_roof_chopper_reenforce_watch = int(tablelookupbyrow(var11, var13, var7));
    var20.building_roof_jugg_behavior = int(tablelookupbyrow(var11, var13, var8));
    var20.building_roof_jugg_protect_roof_then_chase = int(tablelookupbyrow(var11, var13, var9));
    var20.busbpulledout = int(tablelookupbyrow(var11, var13, var10));
    var21 = var0[var16][var18].size;
    var0[var18][var21] = var20;
  }

  return var0;
}

function ai_anim_relative(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  if(!isDefined(var2) || var2.type != "gnome_collision") {
    return;
  }

  thread ai_array(level, level.monitor_waypoint_objective_on_front_truck[var2.monitor_player_plunder], var3);
}

function ai_array(var0, var1, var2) {
  var3 = var0.collision;
  var4 = getdvarint("scr_br_eas", 500);
  var0.armsrace_c4_planter_attack += var1;

  if(var0.armsrace_c4_planter_attack > var4) {
    var0.interaction_get_cost++;
    var0.scriptable setscriptablepartstate("sound_timer", "sound_off");

    if(isDefined(var2) && isPlayer(var2)) {
      scripts\mp\gametypes\br_analytics::destroy_vehicle_if_driver_dies(var2, var0.interaction_get_cost);
    }

    if(var0.interaction_get_cost < var0.ref_13695.size) {
      thread ai_ascender_doanims(level);
    } else {
      thread aggressive_melee_active(level, var0.monitor_player_plunder);
    }
  }

  waitframe();
}

function aggressive_melee_active(var0, var1) {
  var2 = level.monitor_waypoint_objective_on_front_truck[var0];
  var2.scriptable notify("elf_interaction");
  var2.scriptable setscriptablepartstate("visuals", "hidden");
  var2.collision setscriptablepartstate("vfx", "vfx_death");
  var2.scriptable setscriptablepartstate("SOUND_IDLE", "SOUND_IDLE_OFF");

  if(isDefined(var1) && isPlayer(var1)) {
    var1 scripts\cp\vehicles\vehicle_compass_cp::ref_1301e("eas_elf_defeated", 1);
  }

  waitframe();
  thread ai_ascender_animloop(level, var2.scriptable.origin);
  var3 = 6;
  wait var3;
  var2.scriptable freescriptable();
}

function ai_ascender_animloop(var0, var1) {
  var2 = scripts\mp\gametypes\br_pickups::test_ai_anim();
  var3 = 10;
  var4 = verifybunkercode("festive_fervor_ultra_crate", randomint(var3));
  GscBinSkip0(0x2e, var4.size, "brloot_plunder_cash_rare_1");
}

function apc_horn(var0, var1) {
  return (var0[0] * var1, var0[1] * var1, var0[2] * var1);
}

function ai_ascender_doanims(var0) {
  var1 = "vfx_enter";
  var2 = "vfx_exit";
  var3 = "hidden";
  var4 = "hidden";
  var5 = 0.25;
  var6 = level.monitor_waypoint_objective_on_front_truck[var0];

  if(isDefined(var6.scriptable) &isDefined(var6.collision)) {
    var6.scriptable notify("elf_interaction");
    var6.collision setscriptablepartstate("vfx", var2);
    var6.scriptable setscriptablepartstate("SOUND_IDLE", "SOUND_IDLE_OFF");
    var7 = getdvarfloat("scr_br_eas_exit_delay", 0.25);
    wait var7;
    var6.scriptable setscriptablepartstate("visuals", var4);
    var8 = getdvarfloat("scr_br_eas_cleanup_delay", 3);
    wait var8;
  }

  if(isDefined(var6.scriptable)) {
    var6.scriptable freescriptable();
  }

  if(isDefined(var6.collision)) {
    var6.collision freescriptable();
  }

  var9 = var6.ref_13695[var6.interaction_get_cost];
  var10 = var9.ref_12812;
  var11 = var9.ref_12813;
  var12 = var9.ref_12814;
  var13 = (var10, var11, var12);
  var14 = var9.building_roof_chopper_reenforce_watch;
  var15 = var9.building_roof_jugg_behavior;
  var16 = var9.building_roof_jugg_protect_roof_then_chase;
  var17 = (var14, var15, var16);
  var6.scriptable = easepower("gnome", var13, var17);
  var6.scriptable setscriptablepartstate("visuals", var4);
  var6.armsrace_c4_planter_attack = 0;
  waitframe();
  var18 = var9.busbpulledout;
  var19 = "anim_" + var18;
  var20 = [];
  GscBinSkip0(0x2e, 0, 20);
}

function advanced_supply_drop_refund_on_death(var0) {
  level endon("game_ended");
  var1 = level.monitor_waypoint_objective_on_front_truck[var0];
  var1.scriptable notify("elf_interaction");
  var1.scriptable endon("elf_interaction");
  var1.scriptable setscriptablepartstate("sound_timer", "sound_on");
  var3 = getdvarint("scr_br_eas_vo_delay", 7);
  var4 = getdvarint("scr_br_eas_countdown", 15);
  var4 = max(var4, var3);
  wait var3;
  var5 = randomint(6);
  var6 = "vo_" + var5;
  var1.scriptable setscriptablepartstate("sound_one_shot", var6);
  var7 = var4 - var3;
  wait var7;
  var1.scriptable setscriptablepartstate("sound_timer", "sound_off");
  thread ai_aggro_goal_shrink(var0);
}

function ai_aggro_goal_shrink(var0) {
  var1 = level.monitor_waypoint_objective_on_front_truck[var0];
  var1.scriptable notify("elf_interaction");
  var2 = [];
  GscBinSkip0(0x2e, var2.size, "dx_brm_gnom_gnome_laugh_10");
}

function ai_ascender_animout(var0) {
  level endon("game_ended");
  var1 = level.monitor_waypoint_objective_on_front_truck[var0];
  var1.scriptable notify("elf_interaction");
  var1.scriptable endon("elf_interaction");
  var2 = 5;
  var3 = randomint(var2);
  wait var3;

  for(;;) {
    wait var2;
    var4 = getdvarint("scr_br_eas_start_range", 90);
    var5 = scripts\mp\utility\player::getplayersinradius(var1.scriptable.origin, var4);

    if(var5.size > 0) {
      var7 = [];
      GscBinSkip0(0x2e, var7.size, "dx_brm_gnom_gnome_laugh_10");
    }
  }
}

function affect_hvt_healthdrain(var0) {
  var1 = spawnStruct();

  for(var2 = 0; var2 < var0.size; var2++) {
    switch (var2) {
      case 0:
        break;
      case 1:
        var1.ref_12812 = int(var0[var2]);
        break;
      case 2:
        var1.ref_12813 = int(var0[var2]);
        break;
      case 3:
        var1.ref_12814 = int(var0[var2]);
        break;
      case 4:
        break;
      case 5:
        var1.building_roof_chopper_reenforce_watch = int(var0[var2]);
        break;
      case 6:
        var1.building_roof_jugg_behavior = int(var0[var2]);
        break;
      case 7:
        var1.building_roof_jugg_protect_roof_then_chase = int(var0[var2]);
        break;
      case 8:
        break;
      case 9:
        var1.bunkeralt_playeridlewatch = int(var0[var2]);
        break;
    }
  }

  return var1;
}

function agent_pickup_hostage_scene() {
  var0 = level.istwohandedoffhand;
  var1 = " Origin: " + var0.ref_12812 + " " + var0.ref_12813 + " " + var0.ref_12814;
  var1 += " Angles: " + var0.building_roof_chopper_reenforce_watch + " " + var0.building_roof_jugg_behavior + " " + var0.building_roof_jugg_protect_roof_then_chase;
  var1 += " AnimID: " + var0.bunkeralt_playeridlewatch;
  iprintlnbold(var1);
  var1 = "set scr_br_eas_spawn" + var1;
  var1 = "############################################" + var1;
  logstring(var1);
}

function agentclasscallback() {
  if(!isDefined(level.players) || !isDefined(level.players[0])) {
    return;
  }

  level.isspecialcaseweapon = easepower("gnome_collision", level.players[0].origin, level.players[0].angles);
}

function agentsinsphere(var0) {
  if(!isDefined(level.players) || !isDefined(level.players[0])) {
    return;
  }

  if(!isDefined(level.ref_13845)) {
    thread after_hit_by_emp_func();
    level.ref_13845 = 1;
  }

  var1 = level.istwohandedoffhand;

  if(isDefined(var0)) {
    var2 = 10;
    var3 = strtok(var0, " ");

    if(var3.size == var2) {
      var1 = affect_hvt_healthdrain(var3);
    } else {
      iprintlnbold("Invalid Command, defaulting to player settings. Example: set scr_br_eas_spawnOrigin: 12 13 0Angles: 10 100 100AnimID: 1");
      var1 = spawnStruct();
      var1.ref_12812 = int(level.players[0].origin[0]);
      var1.ref_12813 = int(level.players[0].origin[1]);
      var1.ref_12814 = int(level.players[0].origin[2]) + 40;
      var1.building_roof_chopper_reenforce_watch = int(level.players[0].angles[0]);
      var1.building_roof_jugg_behavior = int(level.players[0].angles[1]);
      var1.building_roof_jugg_protect_roof_then_chase = int(level.players[0].angles[2]);
      var1.bunkeralt_playeridlewatch = 0;
    }
  }

  var4 = (var1.ref_12812, var1.ref_12813, var1.ref_12814);
  var5 = (var1.building_roof_chopper_reenforce_watch, var1.building_roof_jugg_behavior, var1.building_roof_jugg_protect_roof_then_chase);

  if(!isDefined(level.isspawningstopped)) {
    level.isspawningstopped = easepower("gnome", var4, var5);
  } else {
    level.isspawningstopped.origin = var4;
    level.isspawningstopped.angles = var5;
  }

  level.istwohandedoffhand = var1;
  var6 = "anim_" + var1.bunkeralt_playeridlewatch;
  level.isspawningstopped setscriptablepartstate("visuals", var6);
  agent_pickup_hostage_scene();
}

function agentthink(var0, var1) {
  var2 = 4;
  var3 = 15;

  switch (var0) {
    case "posX":
      level.istwohandedoffhand.ref_12812 += var2 * var1;
      break;
    case "posY":
      level.istwohandedoffhand.ref_12813 += var2 * var1;
      break;
    case "posZ":
      level.istwohandedoffhand.ref_12814 += var2 * var1;
      break;
    case "anglesX":
      level.istwohandedoffhand.building_roof_chopper_reenforce_watch += var3 * var1;
      break;
    case "anglesY":
      level.istwohandedoffhand.building_roof_jugg_behavior += var3 * var1;
      break;
    case "anglesZ":
      level.istwohandedoffhand.building_roof_jugg_protect_roof_then_chase += var3 * var1;
      break;
    case "animID":
      level.istwohandedoffhand.bunkeralt_playeridlewatch += var1;

      if(level.istwohandedoffhand.bunkeralt_playeridlewatch == -1) {
        level.istwohandedoffhand.bunkeralt_playeridlewatch = 5;
      }

      level.istwohandedoffhand.bunkeralt_playeridlewatch %= 6;
      break;
  }

  agentsinsphere();
}

function agenttargetloadout(var0) {
  var1 = ["posX", "posY", "posZ", "anglesX", "anglesY", "anglesZ", "animID"];
  level.istutorial += var0;

  if(level.istutorial == -1) {
    level.istutorial = var1.size - 1;
  }

  level.istutorial %= var1.size;
  level.istripwiredamagetype = var1[level.istutorial];
  iprintlnbold("Active Parameter: " + level.istripwiredamagetype);
}

function after_hit_by_emp_func() {
  level endon("game_ended");
  var0 = self;
  var0 notifyonplayercommand("rb", "+frag");
  var0 notifyonplayercommand("lb", "+smoke");
  var0 notifyonplayercommand("dpad_down", "+actionslot 2");
  var0 notifyonplayercommand("dpad_left", "+actionslot 3");

  for(;;) {
    var1 = var0 scripts\engine\utility::waittill_any_in_array_return(["rb", "lb", "dpad_down", "dpad_left"]);

    switch (var1) {
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

  var0 = 100;
  var1 = (1, 0, 0);
  var2 = 10;

  foreach(var4 in level.monitor_waypoint_objective_on_front_truck) {
    var5 = var4.ref_13695[var4.interaction_get_cost];

    if(!isDefined(var5) || !isDefined(var4.scriptable)) {
      continue;
    }

    var6 = var5.ref_12812;
    var7 = var5.ref_12813;
    var8 = var5.ref_12814;
    var9 = (var6, var7, var8);
    thread scripts\mp\utility\debug::drawsphere(var9, var0, var2, var1);
  }
}

function after_spawn_func(var0) {
  var1 = getdvarint("scr_br_eas_debug", 0) == 1;

  if(var1) {
    iprintlnbold(var0);
    logprint(var0);
    return;
  }
}

function afkroundcounted() {
  level endon("game_ended");
  level.istripwiredamagetype = "posX";
  level.istutorial = 0;

  for(;;) {
    var0 = getDvar("scr_br_eas_spawn", "");

    if(var0 != "") {
      agentsinsphere(var0);
    }

    var1 = getDvar("scr_br_eas_spawn_collision", "");

    if(var1 != "") {
      agentclasscallback();
    }

    var2 = getDvar("scr_br_eas_spawn_loot", "");

    if(var2 != "") {
      agentsnear();
    }

    var3 = getDvar("scr_br_eas_show_locations", "");

    if(var3 != "") {
      agent_pickup_hostage_scene_body();
    }

    var4 = getDvar("scr_br_eas_kill", "");

    if(var4 != "" && isDefined(level.monitor_waypoint_objective_on_front_truck) && isDefined(level.monitor_waypoint_objective_on_front_truck[0])) {
      ai_array(level.monitor_waypoint_objective_on_front_truck[0], 99999);
    }

    waitframe();
  }
}