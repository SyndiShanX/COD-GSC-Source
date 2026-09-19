/********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\sg_events_v1\interact_repair.gsc
********************************************************************/

init() {
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

basic_keypoint_interact_run(var_0) {
  maps\mp\zombies\sg_events_v1\_options::apply_option(var_0);
  level.kpishouldchain = 1;

  if(var_0 == "dnk_kpi_bomb_defusal")
    maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::register_banned_objective("keypoint_interact_repair_common");

  if(var_0 == "keypoint_interact_repair_common")
    maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::register_banned_objective("dnk_kpi_bomb_defusal");

  if(!isDefined(level.keypointinteracttool)) {
    switch (level.zmb_sg_objectives[var_0].type) {
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

  if(!isDefined(level.keypointinteractkeypoints))
    level.keypointinteractkeypoints = 3;

  foreach(var_2 in level.players) {
    var_2 setclientomnvar("ui_onevone_class_3", level.keypointinteractkeypoints);
    var_2 setclientomnvar("ui_onevone_class_4", 0);
  }

  var_4 = [];
  var_5 = getEntArray("keypoint_interact_trigger", "targetname");

  foreach(var_7 in var_5) {
    if(isDefined(var_7._id_0165) && var_7._id_0165 == var_0 || !isDefined(var_7._id_0165))
      var_4 = common_scripts\utility::_id_0F6F(var_4, var_7);
  }

  var_9 = [];

  if(var_4.size >= level.keypointinteractkeypoints) {
    while(var_9.size < level.keypointinteractkeypoints) {
      var_10 = _randomintrange(0, var_4.size);

      if(!common_scripts\utility::_id_0F79(var_9, var_4[var_10]))
        var_9 = common_scripts\utility::_id_0F6F(var_9, var_4[var_10]);

      waitframe();
    }
  } else {
    foreach(var_7 in var_4)
    var_9 = common_scripts\utility::_id_0F6F(var_9, var_7);
  }

  var_13 = var_9.size;
  thread basic_keypoint_interact_trigger_listen(var_9);
  level.keypointsinteracted = 0;
  var_14 = basic_keypoint_interact_wait_for_complete_or_timeout(var_13);

  if(common_scripts\utility::_id_562E(var_14))
    return 1;
  else
    return 0;
}

basic_keypoint_interact_trigger_listen(var_0) {
  foreach(var_5, var_2 in var_0) {
    if(!var_2 _meth_8562())
      var_2 makeusable();

    var_2 thread basic_keypoint_interact_trigger_hints();
    level thread maps\mp\_utility::_id_6F74(::basic_keypoint_interact_draw_waypoint, var_2);
    var_3 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("type_keypoint_interact_repair_common_guard_timing_info");
    var_4 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("type_keypoint_interact_repair_common_guard_min_objective_count");

    if(var_5 + 1 >= var_3 && level.objectivescompleted + 1 >= var_4)
      level thread spawn_zombie_interact_defenders(var_2.origin);

    if(common_scripts\utility::_id_562E(level.kpishouldchain)) {
      var_2 basic_keypoint_interact_trigger_use();
      continue;
    }

    var_2 thread basic_keypoint_interact_trigger_use();
  }
}

spawn_zombie_interact_defenders(var_0) {
  var_1 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("type_keypoint_interact_repair_common_guard_info");

  for(var_2 = 0; var_2 < var_1[0]; var_2++) {
    var_3 = _id_0547::get_closest_spawn_by_type(var_0, var_1[1]);
    var_4 = _id_054D::_id_90BA(var_1[1], var_3, "event_forced_spawn", 0, 1, 0);
    waitframe();
    waitframe();
    waitframe();
  }
}

basic_keypoint_interact_wait_for_complete_or_timeout(var_0) {
  level endon("sg_obj_timeout");
  level endon("sg_obj_end");
  level endon("zombie_wave_ended");

  while(level.keypointsinteracted < var_0) {
    wait 0.1;

    if(level.keypointsinteracted >= var_0)
      return 1;
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

  if(!isDefined(level.keypointinteracthint))
    level.keypointinteracthint = "ZOMBIE_DLC3_KEYPOINT_INTERACT_BUILD";

  self sethintstring(level.keypointinteracthint);
}

basic_keypoint_interact_trigger_use() {
  var_0 = level.keypointinteractholdtime;
  self._id_28D5 = 0;
  self._id_A22B = 0;
  self._id_54F5 = 0;
  self._id_565F = 1;
  var_1 = self;

  if(isDefined(self.scriptableinitfunc))
    self thread[[self.scriptableinitfunc]]();

  for(;;) {
    self waittill("trigger", var_2);

    if(common_scripts\utility::_id_562E(var_2.hasdisposalkit) || !isDefined(var_2.hasdisposalkit)) {
      var_3 = var_2 basic_keypoint_interact_start_tool(var_1);
      var_4 = basic_keypoint_interact_hold_think(var_2, var_0 * 1000, ["sg_obj_timeout", "sg_obj_end"]);
      var_2 basic_keypoint_interact_stop_tool(var_3);

      if(common_scripts\utility::_id_562E(var_4)) {
        self makeunusable();
        self sethintstring(&"ZOMBIES_EMPTY_STRING");

        if(isDefined(self.scriptableinitfunc))
          self thread[[self.scriptablerepairedfunc]]();

        level.keypointsinteracted++;

        foreach(var_2 in level.players)
        var_2 setclientomnvar("ui_onevone_class_4", level.keypointsinteracted);

        self._id_565F = 0;
        self notify("interact_completed");
        level notify("sg_keypoint_interact_completed");
        break;
      }
    }
  }
}

basic_keypoint_interact_create_hold_struct() {
  var_0 = spawnStruct();
  var_0._id_28D5 = 0;
  var_0._id_A22B = 0;
  var_0._id_54F5 = 0;
  return var_0;
}

basic_keypoint_interact_hold_think(var_0, var_1, var_2) {
  var_0 endon("disconnect");
  thread basic_keypoint_interact_cleanup(var_0, var_2);
  self._id_28D5 = 0;
  self._id_54F5 = 1;
  self._id_A22B = 0;
  var_3 = basic_keypoint_interact_think_loop(var_0, var_1);

  if(!common_scripts\utility::_id_562E(var_3))
    level notify("sg_keypoint_interact_incompleted");

  if(!isDefined(var_3))
    thread flicker_trigger();

  if(!isDefined(self))
    return 0;

  self notify("useHoldThinkLoopDone");
  var_0.radial_interact_active = undefined;
  var_0 _meth_866C(&"stop_progressive_interact", 0);
  var_0 _meth_866C(&"remove_progressive_interact", 0);
  self._id_54F5 = 0;
  self._id_28D5 = 0;
  return common_scripts\utility::_id_562E(var_3);
}

flicker_trigger() {
  common_scripts\utility::_id_9D9F();
  wait 0.8;
  common_scripts\utility::_id_9DA3();
}

basic_keypoint_interact_cleanup(var_0, var_1) {
  var_0 endon("death");
  var_2 = ["death", "useHoldThinkLoopDone"];

  if(isDefined(var_1)) {
    if(_isarray(var_1))
      var_2 = maps\mp\_utility::array_combine_no_dupes(var_2, var_1);
    else
      var_2[var_2.size] = var_1;
  }

  var_3 = common_scripts\utility::_id_A712(var_2);
}

basic_keypoint_interact_think_loop(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("damage");
  var_2 = 0;
  level notify("sg_keypoint_interact_start");

  while(isDefined(self) && maps\mp\_utility::isreallyalive(var_0) && var_0 usebuttonpressed() && var_0 istouching(self)) {
    self._id_28D5 = self._id_28D5 + self._id_A22B * 50;

    if(!common_scripts\utility::_id_562E(var_0.radial_interact_active))
      var_0.radial_interact_active = 1;

    if(!self._id_A22B)
      self._id_A22B = 1;

    var_3 = var_1 - self._id_28D5;

    if(var_3 <= 0)
      return 1;
    else if(!var_2) {
      var_2 = 1;
      var_0 _meth_866C(&"start_progressive_interact", 1, var_3);
      var_0.radial_interact_active = undefined;
    }

    waitframe();
  }

  return 0;
}

basic_keypoint_interact_start_tool(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_2 = var_1 getweaponlistprimaries();
  var_3 = var_1 getcurrentweapon();
  var_4 = var_2[0];

  foreach(var_6 in var_2) {
    if(common_scripts\utility::_id_0F79(var_2, var_3))
      var_4 = var_3;
  }

  _id_0548::_id_A7D6(var_1, level.keypointinteracttool);
  _id_0378::_id_8D74("dlc3_player_repair_start", level.keypointinteracttool, var_0);
  var_1 disableweaponswitch();
  return var_4;
}

basic_keypoint_interact_stop_tool(var_0) {
  var_1 = self;
  var_1 enableweaponswitch();

  if(isDefined(var_0))
    var_1 _id_0586::_id_078E(var_0);

  var_1 _id_0586::_id_0790(level.keypointinteracttool);
  _id_0378::_id_8D74("dlc3_player_repair_stop", level.keypointinteracttool);
}

basic_keypoint_interact_waitfor_interact_or_timeout() {
  var_0 = common_scripts\utility::_id_A70F(1, level, "sg_keypoint_interact_completed", level, "sg_obj_timeout", level, "zombie_wave_ended");
  return var_0[1];
}

basic_keypoint_interact_draw_waypoint(var_0) {
  var_1 = level.zmb_sg_keypoint_interact_repair_icon;

  if(level.keypointinteracttool == "search_dstry_bomb_defuse_mp") {
    level waittill("sg_keypoint_interact_bomb_pickup");
    var_1 = level.zmb_sg_keypoint_interact_defuse_icon;
  }

  var_2 = self;
  var_3 = _newclienthudelem(var_2);
  var_3 setshader(var_1, 1, 1);
  var_3.alpha = 0;
  var_3.color = (1, 1, 1);
  var_3.x = var_0.origin[0];
  var_3.y = var_0.origin[1];
  var_3._id_01D9 = var_0.origin[2];
  var_3 setwaypoint(0, 1, 0);
  var_3 fadeovertime(0.1);
  var_3.alpha = 1;
  var_0 common_scripts\utility::_id_A70A("interact_completed", "sg_obj_timeout");
  var_3 setwaypoint(0, 0, 0);
  var_3 fadeovertime(0.5);
  var_3.alpha = 0;
  wait 0.5;
  var_3 destroy();
}