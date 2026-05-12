/************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\sg_events_v1\interact_repair.gsc
************************************************************/

func_00D5() {
  basic_keypoint_interact_init_build();
  basic_keypoint_interact_init_repair();
  basic_keypoint_interact_init_bomb();
}

basic_keypoint_interact_init_build() {
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register_defaults("keypoint_interact_build", ::basic_keypoint_interact_run, 120, 0, 1);
}

basic_keypoint_interact_init_repair() {
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register_defaults("type_keypoint_interact_repair_common", ::basic_keypoint_interact_run, 120, 0, 1);
}

basic_keypoint_interact_init_bomb() {
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register_defaults("keypoint_interact_bomb", ::basic_keypoint_interact_run, 120, 0, 1);
}

basic_keypoint_interact_run(param_00) {
  maps\mp\zombies\sg_events_v1\_options::apply_option(param_00);
  level.kpishouldchain = 1;
  if(param_00 == "dnk_kpi_bomb_defusal") {
    maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::register_banned_objective("keypoint_interact_repair_common");
  }

  if(param_00 == "keypoint_interact_repair_common") {
    maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::register_banned_objective("dnk_kpi_bomb_defusal");
  }

  if(!isDefined(level.keypointinteracttool)) {
    switch (level.zmb_sg_objectives[param_00].var_1B9) {
      case "keypoint_interact_build":
        level.keypointinteracttool = "war_hammer_assemble_mp";
        break;

      case "type_keypoint_interact_repair_common":
        level.keypointinteracttool = "war_wrench_assemble_mp";
        break;

      case "keypoint_interact_bomb":
        level.keypointinteracttool = "war_dynamite_disarm_mp";
        break;

      default:
        level.keypointinteracttool = "war_hammer_assemble_mp";
        break;
    }
  }

  level.keypointinteractholdtime = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("type_keypoint_interact_repair_common_time");
  if(!isDefined(level.keypointinteractkeypoints)) {
    level.keypointinteractkeypoints = 3;
  }

  foreach(var_02 in level.var_744A) {
    var_02 setclientomnvar("ui_onevone_class_3", level.keypointinteractkeypoints);
    var_02 setclientomnvar("ui_onevone_class_4", 0);
  }

  var_04 = [];
  var_05 = getEntArray("keypoint_interact_trigger", "targetname");
  foreach(var_07 in var_05) {
    if((isDefined(var_07.var_165) && var_07.var_165 == param_00) || !isDefined(var_07.var_165)) {
      var_04 = common_scripts\utility::func_F6F(var_04, var_07);
    }
  }

  var_09 = [];
  if(var_04.size >= level.keypointinteractkeypoints) {
    while(var_09.size < level.keypointinteractkeypoints) {
      var_0A = randomintrange(0, var_04.size);
      if(!common_scripts\utility::func_F79(var_09, var_04[var_0A])) {
        var_09 = common_scripts\utility::func_F6F(var_09, var_04[var_0A]);
      }

      wait 0.05;
    }
  } else {
    foreach(var_07 in var_04) {
      var_09 = common_scripts\utility::func_F6F(var_09, var_07);
    }
  }

  var_0D = var_09.size;
  thread basic_keypoint_interact_trigger_listen(var_09);
  level.keypointsinteracted = 0;
  var_0E = basic_keypoint_interact_wait_for_complete_or_timeout(var_0D);
  if(common_scripts\utility::func_562E(var_0E)) {
    return 1;
  }

  return 0;
}

basic_keypoint_interact_trigger_listen(param_00) {
  foreach(var_05, var_02 in param_00) {
    if(!var_02 method_8562()) {
      var_02 makeusable();
    }

    var_02 thread basic_keypoint_interact_trigger_hints();
    level thread maps\mp\_utility::func_6F74(::basic_keypoint_interact_draw_waypoint, var_02);
    var_03 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("type_keypoint_interact_repair_common_guard_timing_info");
    var_04 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("type_keypoint_interact_repair_common_guard_min_objective_count");
    if(var_05 + 1 >= var_03 && level.objectivescompleted + 1 >= var_04) {
      level thread spawn_zombie_interact_defenders(var_02.var_116);
    }

    if(common_scripts\utility::func_562E(level.kpishouldchain)) {
      var_02 basic_keypoint_interact_trigger_use();
      continue;
    }

    var_02 thread basic_keypoint_interact_trigger_use();
  }
}

spawn_zombie_interact_defenders(param_00) {
  var_01 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("type_keypoint_interact_repair_common_guard_info");
  for(var_02 = 0; var_02 < var_01[0]; var_02++) {
    var_03 = lib_0547::get_closest_spawn_by_type(param_00, var_01[1]);
    var_04 = lib_054D::func_90BA(var_01[1], var_03, "event_forced_spawn", 0, 1, 0);
    wait 0.05;
    wait 0.05;
    wait 0.05;
  }
}

basic_keypoint_interact_wait_for_complete_or_timeout(param_00) {
  level endon("sg_obj_timeout");
  level endon("sg_obj_end");
  level endon("zombie_wave_ended");
  while(level.keypointsinteracted < param_00) {
    wait(0.1);
    if(level.keypointsinteracted >= param_00) {
      return 1;
    }
  }
}

basic_keypoint_interact_trigger_hints() {
  switch (level.keypointinteracttool) {
    case "war_hammer_assemble_mp":
      level.keypointinteracthint = &"ZOMBIE_DLC3_KEYPOINT_INTERACT_BUILD";
      break;

    case "war_wrench_assemble_mp":
      level.keypointinteracthint = &"ZOMBIE_DLC3_KEYPOINT_INTERACT_REPAIR";
      break;

    case "war_dynamite_disarm_mp":
      level.keypointinteracthint = &"ZOMBIE_DLC3_KEYPOINT_INTERACT_DEFUSE";
      break;
  }

  if(!isDefined(level.keypointinteracthint)) {
    level.keypointinteracthint = "ZOMBIE_DLC3_KEYPOINT_INTERACT_BUILD";
  }

  self sethintstring(level.keypointinteracthint);
}

basic_keypoint_interact_trigger_use() {
  var_00 = level.keypointinteractholdtime;
  self.var_28D5 = 0;
  self.var_A22B = 0;
  self.var_54F5 = 0;
  self.var_565F = 1;
  var_01 = self;
  if(isDefined(self.scriptableinitfunc)) {
    self thread[[self.scriptableinitfunc]]();
  }

  for(;;) {
    self waittill("trigger", var_02);
    if(common_scripts\utility::func_562E(var_02.hasdisposalkit) || !isDefined(var_02.hasdisposalkit)) {
      var_03 = var_02 basic_keypoint_interact_start_tool(var_01);
      var_04 = basic_keypoint_interact_hold_think(var_02, var_00 * 1000, ["sg_obj_timeout", "sg_obj_end"]);
      var_02 basic_keypoint_interact_stop_tool(var_03);
      if(common_scripts\utility::func_562E(var_04)) {
        self makeunusable();
        self sethintstring(&"ZOMBIES_EMPTY_STRING");
        if(isDefined(self.scriptableinitfunc)) {
          self thread[[self.scriptablerepairedfunc]]();
        }

        level.keypointsinteracted++;
        foreach(var_02 in level.var_744A) {
          var_02 setclientomnvar("ui_onevone_class_4", level.keypointsinteracted);
        }

        self.var_565F = 0;
        self notify("interact_completed");
        level notify("sg_keypoint_interact_completed");
        break;
      }
    }
  }
}

basic_keypoint_interact_create_hold_struct() {
  var_00 = spawnStruct();
  var_00.var_28D5 = 0;
  var_00.var_A22B = 0;
  var_00.var_54F5 = 0;
  return var_00;
}

basic_keypoint_interact_hold_think(param_00, param_01, param_02) {
  param_00 endon("disconnect");
  thread basic_keypoint_interact_cleanup(param_00, param_02);
  self.var_28D5 = 0;
  self.var_54F5 = 1;
  self.var_A22B = 0;
  var_03 = basic_keypoint_interact_think_loop(param_00, param_01);
  if(!common_scripts\utility::func_562E(var_03)) {
    level notify("sg_keypoint_interact_incompleted");
  }

  if(!isDefined(var_03)) {
    thread flicker_trigger();
  }

  if(!isDefined(self)) {
    return 0;
  }

  self notify("useHoldThinkLoopDone");
  param_00.radial_interact_active = undefined;
  param_00 luinotifyeventextraplayer(&"stop_progressive_interact", 0);
  param_00 luinotifyeventextraplayer(&"remove_progressive_interact", 0);
  self.var_54F5 = 0;
  self.var_28D5 = 0;
  return common_scripts\utility::func_562E(var_03);
}

flicker_trigger() {
  common_scripts\utility::func_9D9F();
  wait(0.8);
  common_scripts\utility::func_9DA3();
}

basic_keypoint_interact_cleanup(param_00, param_01) {
  param_00 endon("death");
  var_02 = ["death", "useHoldThinkLoopDone"];
  if(isDefined(param_01)) {
    if(isarray(param_01)) {
      var_02 = maps\mp\_utility::array_combine_no_dupes(var_02, param_01);
    } else {
      var_02[var_02.size] = param_01;
    }
  }

  var_03 = common_scripts\utility::func_A712(var_02);
}

basic_keypoint_interact_think_loop(param_00, param_01) {
  param_00 endon("disconnect");
  param_00 endon("damage");
  var_02 = 0;
  level notify("sg_keypoint_interact_start");
  while(isDefined(self) && maps\mp\_utility::func_57A0(param_00) && param_00 useButtonPressed() && param_00 istouching(self)) {
    self.var_28D5 = self.var_28D5 + self.var_A22B * 50;
    if(!common_scripts\utility::func_562E(param_00.radial_interact_active)) {
      param_00.radial_interact_active = 1;
    }

    if(!self.var_A22B) {
      self.var_A22B = 1;
    }

    var_03 = param_01 - self.var_28D5;
    if(var_03 <= 0) {
      return 1;
    } else if(!var_02) {
      var_02 = 1;
      param_00 luinotifyeventextraplayer(&"start_progressive_interact", 1, var_03);
      param_00.radial_interact_active = undefined;
    }

    wait 0.05;
  }

  return 0;
}

basic_keypoint_interact_start_tool(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  var_02 = var_01 getweaponslistprimaries();
  var_03 = var_01 getcurrentweapon();
  var_04 = var_02[0];
  foreach(var_06 in var_02) {
    if(common_scripts\utility::func_F79(var_02, var_03)) {
      var_04 = var_03;
    }
  }

  maps\mp\zombies\_zombies_magicbox::func_A7D6(var_01, level.keypointinteracttool);
  lib_0378::func_8D74("dlc3_player_repair_start", level.keypointinteracttool, param_00);
  var_01 method_8326();
  return var_04;
}

basic_keypoint_interact_stop_tool(param_00) {
  var_01 = self;
  var_01 method_8327();
  if(isDefined(param_00)) {
    var_01 lib_0586::func_78E(param_00);
  }

  var_01 lib_0586::func_790(level.keypointinteracttool);
  lib_0378::func_8D74("dlc3_player_repair_stop", level.keypointinteracttool);
}

basic_keypoint_interact_waitfor_interact_or_timeout() {
  var_00 = common_scripts\utility::func_A70F(1, level, "sg_keypoint_interact_completed", level, "sg_obj_timeout", level, "zombie_wave_ended");
  return var_00[1];
}

basic_keypoint_interact_draw_waypoint(param_00) {
  var_01 = level.zmb_sg_keypoint_interact_repair_icon;
  if(level.keypointinteracttool == "search_dstry_bomb_defuse_mp") {
    level waittill("sg_keypoint_interact_bomb_pickup");
    var_01 = level.zmb_sg_keypoint_interact_defuse_icon;
  }

  var_02 = self;
  var_03 = newclienthudelem(var_02);
  var_03 setshader(var_01, 1, 1);
  var_03.var_18 = 0;
  var_03.var_56 = (1, 1, 1);
  var_03.maxsightdistsqrd = param_00.var_116[0];
  var_03.var_1D7 = param_00.var_116[1];
  var_03.var_1D9 = param_00.var_116[2];
  var_03 setwaypoint(0, 1, 0);
  var_03 fadeovertime(0.1);
  var_03.var_18 = 1;
  param_00 common_scripts\utility::knock_off_battery("interact_completed", "sg_obj_timeout");
  var_03 setwaypoint(0, 0, 0);
  var_03 fadeovertime(0.5);
  var_03.var_18 = 0;
  wait(0.5);
  var_03 destroy();
}