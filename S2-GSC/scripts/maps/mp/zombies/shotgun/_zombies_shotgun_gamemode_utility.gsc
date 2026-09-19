/*********************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility.gsc
*********************************************************************************/

_________general_shotgun_objective_utils_________() {}

sg_obj_register(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!_func_0C0(var_2))
    var_2 = [var_2];

  var_10 = 1;
  var_11 = 0;

  if(isDefined(level.zmb_sg_objectives[var_0])) {
    return;
  }
  var_12 = 0;
  level.zmb_sg_objectives[var_0] = spawnStruct();
  level.zmb_sg_objectives[var_0]._id_502A = var_0;
  level.zmb_sg_objectives[var_0].type = var_1;
  level.zmb_sg_objectives[var_0].valid_waves = [];

  foreach(var_14 in var_2)
  level.zmb_sg_objectives[var_0].valid_waves = common_scripts\utility::_id_0F6F(level.zmb_sg_objectives[var_0].valid_waves, var_14);

  if(isDefined(level.zmb_sg_obj_basic_funcs[var_1])) {
    if(!isDefined(var_4) && isDefined(level.zmb_sg_obj_basic_funcs[var_1].default_callback))
      var_4 = level.zmb_sg_obj_basic_funcs[var_1].default_callback;

    if(!isDefined(var_3) && isDefined(level.zmb_sg_obj_basic_funcs[var_1].default_timer))
      var_3 = level.zmb_sg_obj_basic_funcs[var_1].default_timer;

    if(isDefined(level.zmb_sg_obj_basic_funcs[var_1].timeout_win))
      var_12 = level.zmb_sg_obj_basic_funcs[var_1].timeout_win;

    if(!isDefined(var_8) && isDefined(level.zmb_sg_obj_basic_funcs[var_1].is_endless_wave))
      var_8 = level.zmb_sg_obj_basic_funcs[var_1].is_endless_wave;
  }

  level.zmb_sg_objectives[var_0]._id_9A07 = var_3;
  level.zmb_sg_objectives[var_0].event_func = var_4;
  level.zmb_sg_objectives[var_0].timeout_win = var_12;
  level.zmb_sg_objectives[var_0].max_occurences = var_10;
  level.zmb_sg_objectives[var_0].priority = var_11;
  level.zmb_sg_objectives[var_0]._id_2A35 = var_5;
  level.zmb_sg_objectives[var_0]._id_94D6 = var_6;
  level.zmb_sg_objectives[var_0].fail_func = var_7;
  level.zmb_sg_objectives[var_0].is_endless_wave = var_8;
  level.zmb_sg_objectives[var_0].extra_func = var_9;
  level.zmb_sg_objectives[var_0].times_selected = 0;
  return level.zmb_sg_objectives[var_0];
}

get_nice_name(var_0) {
  var_1 = var_0;

  switch (var_0) {
    case "defense_common":
      var_1 = "1. Keypoint Defend";
      break;
    case "extermination_common":
      var_1 = "2. Extermination";
      break;
    case "meuchler_common":
      var_1 = "3. Meuchler";
      break;
    case "keypoint_interact_repair_common":
      var_1 = "4. Repair";
      break;
    case "assassinate_common":
      var_1 = "5. Assassinate";
      break;
    case "escape_common":
      var_1 = "6. ^2Escape^3";
      break;
  }

  return var_1;
}

sg_obj_register_defaults(var_0, var_1, var_2, var_3, var_4) {
  level.zmb_sg_obj_basic_funcs[var_0] = spawnStruct();
  level.zmb_sg_obj_basic_funcs[var_0].default_callback = var_1;
  level.zmb_sg_obj_basic_funcs[var_0].default_timer = var_2;
  level.zmb_sg_obj_basic_funcs[var_0].timeout_win = var_3;
  level.zmb_sg_obj_basic_funcs[var_0].is_endless_wave = var_4;
}

sg_obj_add_required_flags(var_0, var_1) {
  if(isDefined(var_1)) {
    if(!_func_0C0(var_1))
      var_1 = [var_1];

    foreach(var_3 in var_1) {
      if(!common_scripts\utility::_id_3C83(var_3))
        common_scripts\utility::flag_init(var_3);

      level.zmb_sg_objectives[var_0].required_flags = common_scripts\utility::_id_0F6F(level.zmb_sg_objectives[var_0].required_flags, var_3);
    }

    level.zmb_sg_objectives[var_0].required_flags = common_scripts\utility::_id_0F97(level.zmb_sg_objectives[var_0].required_flags);
  }
}

sg_obj_set_timeout_win(var_0, var_1) {
  if(isDefined(var_1))
    level.zmb_sg_objectives[var_0].timeout_win = var_1;
}

sg_obj_set_endless_no_heavies(var_0, var_1) {
  if(isDefined(var_1))
    level.zmb_sg_objectives[var_0].endless_no_heavies = var_1;
}

sg_obj_select() {
  var_0 = [];
  var_1 = undefined;

  foreach(var_3 in level.zmb_sg_objectives) {
    if(!sg_obj_check_flags(var_3)) {
      continue;
    }
    if(!sg_obj_check_occurence_count(var_3)) {
      continue;
    }
    if(!sg_obj_check_valid_for_this_round(var_3)) {
      continue;
    }
    if(sg_obj_check_is_banned(var_3)) {
      continue;
    }
    var_0 = common_scripts\utility::_id_0F6F(var_0, var_3);
  }

  if(var_0.size > 0) {
    if(var_0.size == 1)
      var_1 = var_0[0];
    else {
      var_1 = common_scripts\utility::random(var_0);

      foreach(var_3 in var_0) {
        if(var_3.priority > var_1.priority)
          var_1 = var_3;
      }
    }

    var_1.times_selected++;
  }

  return var_1;
}

sg_obj_check_valid_for_this_round(var_0) {
  foreach(var_2 in var_0.valid_waves) {
    if(level._id_A980 == var_2)
      return 1;
  }

  return 0;
}

sg_obj_check_flags(var_0) {
  if(isDefined(var_0.required_flags)) {
    foreach(var_2 in var_0.required_flags) {
      if(!common_scripts\utility::_id_3C77(var_2))
        return 0;
    }
  }

  return 1;
}

sg_obj_check_occurence_count(var_0) {
  if(isDefined(var_0.max_occurences)) {
    if(isDefined(var_0.times_selected) && var_0.times_selected >= var_0.max_occurences)
      return 0;
  }

  return 1;
}

sg_obj_check_is_banned(var_0) {
  return common_scripts\utility::_id_0F79(level.zmb_sg_banned_objectives, var_0._id_502A);
}

____________basic_shotgun_objectives___________() {}

basic_boss_init() {
  sg_obj_register_defaults("type_boss", ::basic_boss_run, 120, 0, 1);
}

basic_boss_run(var_0) {
  level endon("sg_obj_timeout");
  level._id_1CC0 = undefined;
  var_1 = common_scripts\utility::_id_46B5("sg_boss_spawnpoint", "targetname");
  var_2 = _id_0564::_id_3C11(0, var_1, 0);
  var_2 _id_0547::_id_84CB();
  var_2 maps\mp\agents\_agent_common::_id_83FD(50000);
  var_2.sgboss = 1;
  var_2 maps\mp\zombies\sg_events_v1\_boss_util::set_zombie_boss_has_weapon_loot();
  var_3 = basic_boss_waitfor_defeated();

  if(!isDefined(var_3) || !var_3)
    return 0;
  else
    return 1;
}

basic_boss_waitfor_defeated() {
  level endon("sg_obj_timeout");
  var_0 = 0;

  for(;;) {
    wait 0.5;
    var_1 = _id_0547::_id_408F();
    var_0 = 1;

    foreach(var_3 in var_1) {
      if(common_scripts\utility::_id_562E(var_3.sgboss) && !common_scripts\utility::_id_562E(var_3.longdeath))
        var_0 = 0;
    }

    if(var_0) {
      break;
    }
  }

  return 1;
}

basic_escort_init() {
  sg_obj_register_defaults("type_escort", ::basic_escort_run, 30, 0, 1);
}

basic_escort_run(var_0) {
  var_1 = maps\mp\zombies\sg_events_v1\very_important_zombie::basic_vip_run(var_0, "type_escort");
  return common_scripts\utility::_id_562E(var_1);
}

basic_escort_skip_cleanup(var_0) {
  level endon("sg_obj_timeout");
  level endon("flag_sg_VIP_killed");
  level endon("flag_sg_VIP_complete");
  level endon("flag_sg_VIP_timeout");
  level waittill("skipWave");
  var_0 _id_0563::_id_AB99(undefined, undefined, 1000, undefined, "MOD_BULLET", "m1911_zm", var_0.origin, (0, 0, 0), "tag_origin", 0, "tag_weapon");
}

basic_collect_init() {
  level.sg_obj_collection_parts = getEntArray("collect_objective_part_object", "targetname");

  foreach(var_1 in level.sg_obj_collection_parts)
  var_1 _meth_805C();

  sg_obj_register_defaults("collect", ::basic_collect_run, 180, 0, 1);
}

basic_collect_run(var_0) {
  foreach(var_2 in level.players)
  var_2.sg_obj_collect_holding_parts = 0;

  var_4 = _func_18E("collect_objective_destination_object", "targetname");
  var_5 = ["zom_infantrya_bodywhole"];
  level.sg_obj_collection_parts = getEntArray("collect_objective_part_object", "targetname");
  var_6 = 600 / level.players.size;
  var_7 = level.sg_obj_collection_parts.size;
  level.total_parts = level.sg_obj_collection_parts.size;
  level.parts_required = 7;
  level.parts_collected = 0;
  level.parts_destroyed = 0;
  level.sg_obj_collection_parts = common_scripts\utility::array_randomize(level.sg_obj_collection_parts);

  for(var_8 = 0; var_8 < level.sg_obj_collection_parts.size; var_8++)
    level.sg_obj_collection_parts[var_8] thread basic_collect_part_think(var_8, var_5, var_4, var_6, var_7);

  foreach(var_2 in level.players)
  var_2 childthread basic_collect_additional_ui();

  while(level.parts_collected < level.parts_required) {
    var_11 = basic_collect_waitfor_collection_timeout_or_destroyed();

    if(var_11 == "sg_obj_collect_part_destroyed") {
      level.parts_destroyed++;
      level notify("sg_obj_collection_part_removed");

      if(level.parts_destroyed > level.total_parts - level.parts_required) {
        break;
      }
    } else {
      if(var_11 == "sg_obj_collect_part_collected") {
        level notify("sg_obj_collection_part_removed");
        continue;
      }

      break;
    }
  }

  basic_collect_cleanup();

  if(level.parts_collected >= level.parts_required)
    return 1;
  else
    return 0;
}

basic_collect_part_think(var_0, var_1, var_2, var_3, var_4) {
  self endon("obj_destroyed");
  level endon("sg_obj_collect_cleanup");
  var_5 = 0;
  var_6 = 0;

  while(!var_5) {
    if(var_0 - var_6 < var_4) {
      break;
    } else
      level waittill("sg_obj_collection_part_removed");

    var_6++;
    waitframe();
  }

  self _meth_805B();
  self.maxattackingzombies = 0;

  if(self.maxattackingzombies > 0) {
    foreach(var_8 in self._id_1171)
    var_8 linktosynchronizedparent(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  }

  common_scripts\utility::_id_3799("obj_destroyed");
  common_scripts\utility::_id_3799("obj_collected");

  if(self.maxattackingzombies > 0) {
    var_10 = ["zombie_generic"];
    var_11 = int(var_3);
    self.health = var_11;
    self.maxhealth = var_11;
    self._id_1171 = getEntArray(self.target, "targetname");
    thread maps\mp\mp_zombies_attack_object::create_inanimate_zombie_enemy(self.maxattackingzombies, var_11, "obj_destroyed", 99999, 110, maps\mp\zombies\sg_events_v1\keypoint_defense::basic_defense_on_finished, [], self._id_1171, var_10, ["zombie_is_passive", "zombie_is_crawler", "zombie_is_objective", "zombie_is_stunned"]);
    thread basic_collect_part_destruction_think();
  }

  _id_0547::_id_AC41(&"ZOMBIE_DLC3_OBJECT_PICKUP");

  foreach(var_13 in level.players)
  thread basic_collect_part_stencil_think(var_13);

  for(var_15 = _func_18E(var_2.target, "targetname"); !common_scripts\utility::_id_3794("obj_collected"); var_13.sg_obj_collect_holding_parts = 0) {
    self waittill("player_used", var_13);
    var_13.sg_obj_collect_holding_parts++;
    level notify("update_collect_obj_ui");

    if(var_13.sg_obj_collect_holding_parts == 1)
      var_15 _meth_8427(var_13, 2, 0);

    basic_collect_attach_part_to_player_think(self, var_13, var_2);
    var_15 _meth_8428(var_13);
    level.parts_collected = level.parts_collected + var_13.sg_obj_collect_holding_parts;
  }

  level notify("sg_obj_collect_part_collected");
  level notify("update_collect_obj_ui");
  basic_collect_part_cleanup();
}

basic_collect_attach_part_to_player_think(var_0, var_1, var_2) {
  var_0 endon("obj_destroyed");
  var_0 _id_0547::_id_AC40();
  var_0 _meth_805C();
  var_0.origin = var_1.origin + (0, 0, 50);
  var_0 linktosynchronizedparent(var_1, "tag_origin", (0, 0, 50), (0, 0, 0));

  if(var_0.maxattackingzombies > 0) {
    var_0.maxzombies = 0;
    var_0 maps\mp\mp_zombies_attack_object::clear_zombie_interest();
  }

  var_3 = var_0 basic_collect_waitfor_part_dropped_or_returned(var_2, var_1);

  if(isDefined(var_3) && var_3 == "returned")
    var_0 common_scripts\utility::_id_379A("obj_collected");
  else {
    var_0 _meth_8057();
    waitframe();
    var_0.origin = var_1.origin + (_func_0A4(-30, 30), _func_0A4(-30, 30), 0);
    var_0.origin = common_scripts\utility::_id_348B(var_0.origin, 1500);
    var_0.origin = var_0.origin + (0, 0, 10);
    waitframe();
    var_0 _meth_805B();
    var_0 _id_0547::_id_AC41(&"ZOMBIE_DLC3_OBJECT_PICKUP");

    if(var_0.maxattackingzombies > 0)
      var_0.maxzombies = var_0.maxattackingzombies;

    var_1.sg_obj_collect_holding_parts = 0;
    level notify("update_collect_obj_ui");
  }

  var_1 notify("player_finished_dropping_part");
}

basic_collect_give_part_weapon() {
  self.sg_obj_collect_current_primary = self _meth_8317();
  _id_0586::_id_078C("blimp_battery_zm");
  _id_0586::_id_078E("blimp_battery_zm");
  self _meth_8326();
  self _meth_8113(0);
  self _meth_8305(0);
  self waittill("weapon_change");

  while(self _meth_833B())
    waitframe();

  self _meth_8327();
}

basic_collect_take_part_weapon() {
  _id_0586::_id_0790("blimp_battery_zm");
  _id_0586::_id_078E(self.sg_obj_collect_current_primary);
  self _meth_8305(1);
  self _meth_8113(1);
}

basic_collect_waitfor_part_dropped_or_returned(var_0, var_1) {
  var_1 endon("enter_last_stand");

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(var_1 == var_2) {
      self notify("sg_obj_collect_part_collect_success");
      return "returned";
    }
  }
}

basic_collect_part_switched_think(var_0) {
  self endon("sg_obj_collect_part_collect_success");
  self endon("sg_obj_collect_part_dropped");
  var_0 endon("player_picking_up_new_part");

  while(!var_0 _meth_833B() && !var_0 _meth_84F1())
    waitframe();

  self notify("sg_obj_collect_part_dropped");
}

basic_collect_waitfor_collection_timeout_or_destroyed() {
  var_0 = level common_scripts\utility::_id_A715("sg_obj_collect_part_destroyed", "sg_obj_collect_part_collected", "sg_obj_timeout");
  return var_0;
}

basic_collect_part_destruction_think() {
  level endon("sg_obj_collect_cleanup");
  common_scripts\utility::_id_379C("obj_destroyed");
  level notify("sg_obj_collect_part_destroyed");
  basic_collect_part_cleanup();
}

basic_collect_part_stencil_think(var_0) {
  self endon("obj_destroyed");
  self endon("obj_collected");
  self endon("death");
  var_1 = 2;
  var_2 = 2;
  var_3 = 900;
  self _meth_8427(var_0, var_1, 0);

  while(isDefined(self)) {
    if(distance(self.origin, var_0.origin) > var_3) {
      self _meth_8428(var_0);
      var_2 = -1;

      while(distance(self.origin, var_0.origin) > var_3)
        waitframe();
    } else {
      if(self.maxattackingzombies > 0) {
        if(self.health < self.maxhealth * 0.3)
          var_1 = 1;
        else if(self.health < self.maxhealth * 0.65)
          var_1 = 0;
      } else
        var_1 = 2;

      if(var_1 != var_2) {
        var_2 = var_1;
        self _meth_8428(var_0);
        self _meth_8427(var_0, var_1, 0);
      }
    }

    waitframe();
  }
}

basic_collect_additional_ui() {
  wait 9.5;
  var_0 = common_scripts\utility::_id_40B5();
  var_1 = maps\mp\gametypes\_hud_util::createfontstring("bigfixed", 0.5);
  var_1 maps\mp\gametypes\_hud_util::setpoint("CENTER", "CENTER", 0, -10);
  var_1.label = &"ZOMBIE_DLC3_OBJ_COLLECT_COLLECTED";
  var_1 setvalue(level.parts_collected);
  var_1.alpha = 1;
  var_1.color = (1, 0, 0.07);
  var_1.fontscale = 0.5;
  var_1._id_00C6 = "left_adjustable";
  var_1._id_01CA = "top_adjustable";
  var_1.aligny = "top";
  var_1.alignx = "left";
  var_1.x = var_0._id_01D2 * 0.042;
  var_1.y = var_0._id_00BD * 0.055;
  var_2 = maps\mp\gametypes\_hud_util::createfontstring("bigfixed", 0.5);
  var_2 maps\mp\gametypes\_hud_util::setpoint("CENTER", "CENTER", 0, -10);
  var_2.label = &"ZOMBIE_DLC3_OBJ_COLLECT_HOLDING";
  var_2 setvalue(self.sg_obj_collect_holding_parts);
  var_2.alpha = 1;
  var_2.color = (1, 0, 0.07);
  var_2.fontscale = 0.5;
  var_2._id_00C6 = "left_adjustable";
  var_2._id_01CA = "top_adjustable";
  var_2.aligny = "top";
  var_2.alignx = "left";
  var_2.x = var_0._id_01D2 * 0.042;
  var_2.y = var_0._id_00BD * 0.068;
  childthread basic_collect_additional_ui_think(var_1, var_2);
  level waittill("round complete");
  basic_collect_additional_ui_cleanup(var_1, var_2);
}

basic_collect_additional_ui_think(var_0, var_1) {
  level endon("round complete");
  var_2 = self;

  for(;;) {
    level waittill("update_collect_obj_ui");
    var_1 setvalue(var_2.sg_obj_collect_holding_parts);
    var_0 setvalue(level.parts_collected);
  }
}

basic_collect_additional_ui_cleanup(var_0, var_1) {
  if(isDefined(var_0))
    var_0 maps\mp\gametypes\_hud_util::destroyelem();

  if(isDefined(var_1))
    var_1 maps\mp\gametypes\_hud_util::destroyelem();
}

basic_collect_cleanup() {
  level notify("sg_obj_collect_cleanup");

  foreach(var_1 in level.sg_obj_collection_parts)
  var_1 basic_collect_part_cleanup();
}

basic_collect_part_cleanup() {
  if(isDefined(self)) {
    level.sg_obj_collection_parts = common_scripts\utility::_id_0F93(level.sg_obj_collection_parts, self);
    var_0 = getEntArray(self.target, "targetname");

    if(isDefined(var_0) && var_0.size > 0) {
      foreach(var_2 in var_0)
      var_2 delete();
    }

    if(isDefined(self._id_9D65))
      self._id_9D65 delete();

    self delete();
  }
}

_______________general_utilities_______________() {}

single_ent_health_display_start(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  _id_0547::_id_A6F6();
  level thread single_ent_health_display_setup(var_0, var_1, var_2);
}

show_sh_boss_health(var_0) {
  var_1 = self;
  level thread maps\mp\_utility::_id_6F74(::set_waypoints_to_enemy, 3, "sg_VIP_finished");
  level thread single_ent_health_display_start(var_1, var_0, 1);
}

important_zombie_show_destination(var_0, var_1) {
  if(isDefined(self._id_1928)) {
    var_2 = self._id_1928;
    var_2._id_603C = var_0;
    var_2.waypoint_origin = var_1;
    var_2.waypoints = [];
    level thread maps\mp\_utility::_id_6F74(::draw_waypoint_on_struct, var_2);
  }
}

single_ent_health_display_setup(var_0, var_1, var_2) {
  _func_032("ui_zm_waypoint_ents_type", 1);
  var_3 = var_0 assign_health_bar("a");
}

double_ent_health_display_setup(var_0, var_1) {
  _func_032("ui_zm_waypoint_ents_type", 2);
  var_2 = var_0 assign_health_bar("a");
  var_3 = var_1 assign_health_bar("b");
}

assign_health_bar(var_0) {
  var_1 = common_scripts\utility::_id_8FFC();
  var_1 _meth_805B();
  var_1 linktosynchronizedparent(self, "tag_origin");
  var_1._id_3012 = "ui_zm_waypoint_ent_" + var_0;
  var_1._id_3013 = "ui_zm_waypoint_float_" + var_0;
  _func_032(var_1._id_3012, var_1 getentitynumber());
  _func_032(var_1._id_3013, 1.0);
  thread single_ent_health_display_update(var_1);
  return var_1;
}

draw_waypoint_on_struct(var_0, var_1) {
  if(!isDefined(level.zmb_event_waypoints))
    level.zmb_event_waypoints = [];

  if(!isDefined(var_0._id_95AB)) {
    var_0._id_95AB = var_0 common_scripts\utility::_id_8FFC();
    var_0._id_95AB _meth_805B();
    var_0._id_95AB.origin = var_0.waypoint_origin;
  }

  var_2 = self;
  var_3 = _func_19B(var_2);
  var_3 setshader(var_0._id_603C, 1, 1);
  var_3.alpha = 0;
  var_3.color = (1, 1, 1);
  var_3.x = var_0._id_95AB.origin[0];
  var_3.y = var_0._id_95AB.origin[1];
  var_3._id_01D9 = var_0._id_95AB.origin[2];
  var_3 _meth_80CB(0, 1, 0);
  var_3 fadeovertime(0.1);
  var_3.alpha = 1;
  var_0.waypoints = common_scripts\utility::_id_0F6F(var_0.waypoints, var_3);
  level.zmb_event_waypoints[level.zmb_event_waypoints.size] = var_0;
}

clear_all_waypoints() {
  foreach(var_1 in level.zmb_event_waypoints) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(isDefined(var_1._id_95AB))
      var_1._id_95AB delete();

    foreach(var_3 in var_1.waypoints)
    clear_waypoint_safe(var_3);
  }
}

clear_waypoint_safe(var_0) {
  if(isDefined(var_0) && !_func_279(var_0))
    var_0 destroy();
}

get_modified_boss_health(var_0) {
  var_0 = var_0 * level.zmb_global_zombie_health_multiplier;
  var_0 = var_0 * get_player_level_setting("type_boss_health_red_skull");
  return var_0;
}

single_ent_health_display_update(var_0) {
  self endon("death");
  self endon("entitydeleted");
  var_0 endon("entitydeleted");
  level notify(var_0._id_3013 + "_new_single_ent_health_display_update");
  level endon(var_0._id_3013 + "_new_single_ent_health_display_update");
  thread hide_waypoint_on_death(var_0);

  if(!isDefined(level.zmb_waypoint_ents))
    level.zmb_waypoint_ents = [];

  level.zmb_waypoint_ents[level.zmb_waypoint_ents.size] = var_0;

  for(;;) {
    if(isDefined(self.capture_health))
      var_1 = self.capture_health;
    else
      var_1 = self.health;

    _func_032(var_0._id_3013, var_1 / self.maxhealth);
    _id_0547::_id_A6F6();

    if(var_1 <= 0) {
      level notify("sg_defense_failed");

      if(!_func_1EF(self) && !isDefined(self.capture_health))
        self delete();
    }
  }
}

hide_waypoint_on_death(var_0) {}

_id_30D7(var_0) {}

set_waypoints_to_enemy(var_0) {
  var_1 = self;
  var_1 _meth_82FF("ui_zm_exo_slam", var_0);
}

spawn_player_reward(var_0, var_1, var_2, var_3) {
  var_4 = _id_0547::_id_5868(var_1);

  if(!common_scripts\utility::_id_0F79(get_berlin_melee_weapons(), var_1))
    var_1 = _id_0548::_id_454B(var_0, var_1);

  if(var_4)
    var_1 = var_0 _id_0586::_id_078B(_id_0547::_id_AAF9(var_1));

  var_5 = spawn_a_floating_weapon_award(var_1, var_2, var_0);
  var_6 = var_5.fx;
  var_3 common_scripts\utility::_id_9DA3();
  var_3.origin = var_5.origin + (0, 0, 30);
  var_7 = 0;
  var_8 = 0;
  var_9 = _id_0547::_id_AAF9(var_1, 1);
  var_3._id_2955 = var_7;
  var_3._id_A9C2 = var_7;
  var_3._id_2925 = var_8;
  var_3._id_0DB5 = var_8;
  var_3._id_9DA0 = 0;
  var_3._id_82EF = undefined;

  if(!isDefined(var_3._id_A9E0))
    var_3 initialize_weapon_pickup_trigger(var_0, var_9, 1);
  else {
    var_3._id_A9E0 = _id_0547::_id_AAF9(var_9, 1);
    var_3._id_A7D7 = 1;
    var_3._id_6C5C = var_3._id_A9E0;
    var_3._id_65DC._id_A9B4 = var_3._id_A9E0;
    var_3._id_65DC._id_A9A5 = 0;
    var_3._id_65DC._id_6642 = 1;
  }

  var_5 thread _id_A653(var_3, var_6, var_1);
}

spawn_player_rewards(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_4 getentitynumber();
  var_6 = common_scripts\utility::_id_46B7("shattered_weapon_spawn_point", "script_noteworthy");

  foreach(var_11, var_8 in var_1) {
    var_9 = _func_2E1(var_6[var_11].origin, var_4);
    var_10 = level.usa_carepackage_dz_triggers[var_11][var_5];
    thread spawn_player_reward(var_4, var_8, var_9, var_10);
  }
}

set_hidden_but_sent_to_player(var_0) {
  set_shown_only_to_player(var_0);
  self _meth_8511();
}

set_shown_only_to_player(var_0) {
  if(isDefined(var_0)) {
    self _meth_805C();
    self _meth_8005(var_0);
  } else
    self _meth_805B();
}

prespawn_a_floating_award(var_0, var_1, var_2) {
  if(isDefined(var_2) && issubstr(var_0, "_pap_"))
    var_3 = var_2 _id_0586::_id_078B(_id_0547::_id_AAF9(var_0));
  else
    var_3 = var_0;

  var_4 = spawn("weapon_" + var_3, _func_2E1(var_1) + (0, 0, 8));
  var_4.angles = (var_4.angles[0] - 30, randomint(360), var_4.angles[2]);
  var_4 _meth_80B3();
  var_4 set_hidden_but_sent_to_player(var_2);
  var_5 = var_4 common_scripts\utility::_id_8FFC();
  var_5.origin = var_5.origin + (0, 0, 8);
  var_5 set_hidden_but_sent_to_player(var_2);
  var_4.origin = var_5.origin;
  var_4 linktosynchronizedparent(var_5, "tag_origin");
  var_4.linkent = var_5;
  var_5 _meth_82BA(36000, 850);
  var_6 = spawnStruct();
  var_6.origin = var_4.origin;

  if(issubstr(var_0, "_pap_"))
    var_7 = _id_0547::_id_8FBA(var_6, "zmb_ber_gun_cone_glow_pap");
  else
    var_7 = _id_0547::_id_8FBA(var_6, "zmb_ber_gun_cone_glow");

  var_7.origin = var_6.origin;
  var_4.fx = var_7;
  var_7 set_hidden_but_sent_to_player(var_2);
  return var_4;
}

show_prespawned_floating_award(var_0) {
  set_shown_only_to_player(var_0);
  self.fx set_shown_only_to_player(var_0);
  _func_14C(self.fx);
}

spawn_a_floating_weapon_award(var_0, var_1, var_2) {
  var_3 = prespawn_a_floating_award(var_0, var_1, var_2);
  var_4 = 10000;
  var_5 = gettime() + var_4;

  while(gettime() < var_5) {
    if(isDefined(var_2))
      var_6 = [var_2];
    else
      var_6 = level.players;

    var_7 = 1;

    foreach(var_9 in var_6) {
      if(!var_9 _meth_8530(var_0))
        var_7 = 0;
    }

    if(var_7) {
      break;
    }

    waitframe();
  }

  var_3 show_prespawned_floating_award(var_2);
  return var_3;
}

initialize_weapon_pickup_trigger(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    var_3 = level.players;
  else
    var_3 = [var_0];

  var_4 = self;
  var_4 _meth_8177(1);
  var_4._id_A9E0 = _id_0547::_id_AAF9(var_1, 1);
  var_4._id_6C5C = var_4._id_A9E0;

  foreach(var_6 in var_3) {
    var_7 = _id_0552::_id_7BFE(var_6, var_4, var_2);
    var_4._id_65DC = var_7;
  }

  var_4._id_65DC._id_A9B4 = var_4._id_6C5C;
  var_4._id_65DC._id_A9A5 = 0;
  var_4._id_65DC._id_6642 = 1;
  var_4._id_A7D7 = 1;
}

should_activate_redskull_mode(var_0) {
  var_1 = 0;

  if(common_scripts\utility::_id_562E(var_0) && !is_redskull_activation_round())
    return 0;

  foreach(var_3 in level.players) {
    if(common_scripts\utility::_id_562E(var_3.optedintohc))
      var_1++;
  }

  if(var_1 == 4)
    return 1;

  if(_func_371())
    return var_1 == level.players.size;

  if(!_func_371() && common_scripts\utility::_id_562E(var_0))
    return var_1 == level.players.size;

  return 0;
}

run_perk_powerup(var_0) {
  var_1 = wait_for_powerup_taken(var_0, "dlc_pickup_zombies_01_blitz_random");

  foreach(var_1 in level.players) {
    var_3 = var_1 _id_056A::givefreemachineperks(0, 2, level.zmb_sg_desired_perk_order);

    foreach(var_5 in var_3)
    var_1 thread maps\mp\gametypes\_hud_message::_id_9102(get_perk_splash(var_5));
  }
}

get_perk_splash(var_0) {
  var_1 = "";

  switch (var_0) {
    case "fastreload":
      var_1 = "zm_collectible_splash_1";
      break;
    case "punchperk":
      var_1 = "zm_collectible_splash_2";
      break;
    case "runperk":
      var_1 = "zm_collectible_splash_3";
      break;
    case "quickrevive":
      var_1 = "zm_collectible_splash_4";
      break;
    case "electriccherry":
      var_1 = "zm_collectible_splash_5";
      break;
    case "doubletap":
      var_1 = "zm_collectible_splash_6";
      break;
  }

  return var_1;
}

run_mini_monies(var_0, var_1, var_2) {
  var_0 endon("disconnect");
  var_3 = wait_for_powerup_taken(var_2, "dlc_pickup_zombies_01_money_gj_2", var_0);

  if(isDefined(var_0))
    var_0 maps\mp\gametypes\zombies::_id_4798(int(var_1 / 4));
}

run_armor_powerup(var_0) {
  var_1 = wait_for_powerup_taken(var_0, "zmi_max_armor_vfx");

  foreach(var_1 in level.players) {
    var_1 thread maps\mp\gametypes\_hud_message::_id_9102("zm_shattered_maxarmor_splash");
    var_1 _id_056A::_id_4775();
    maps\mp\gametypes\zombies::extra_report_powerup_collected(var_1);
  }

  level notify("zmb_players_took_airdrop_armor");
}

wait_for_powerup_taken(var_0, var_1, var_2) {
  var_3 = spawn_fake_powerup(var_0, var_1);

  if(isDefined(var_2)) {
    var_2 endon("disconnect");

    foreach(var_5 in level.players) {
      if(var_5 != var_2)
        var_3[0] _meth_8006(var_5);
    }

    for(var_7 = undefined; !_id_0547::_id_5565(var_7, var_2); var_7 = var_3[1] wait_for_player_close_or_timeout(20)) {}
  } else
    var_7 = var_3[1] wait_for_player_close_or_timeout(20);

  clear_powerup(var_3, var_7);
  return var_7;
}

clear_powerup(var_0, var_1) {
  if(isDefined(var_1))
    var_1 playlocalsound("zmb_pickup_general");

  foreach(var_3 in var_0)
  var_3 delete();
}

spawn_fake_powerup(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2 setModel("tag_origin");
  var_1 = _func_2A8(common_scripts\utility::_id_44F5(var_1), var_2, "tag_origin");
  _func_14C(var_1);
  var_2.origin = _func_2E1(var_1.origin + (128 - randomint(64), 32 - randomint(64), 0));
  return [var_1, var_2];
}

wait_for_player_close_or_timeout(var_0) {
  wait 0.45;
  var_1 = 0.1;
  var_2 = 0;

  while(var_2 < var_0) {
    foreach(var_4 in level.players) {
      if(distance(var_4.origin, self.origin) < 48)
        return var_4;
    }

    var_2 = var_2 + var_1;
    wait(var_1);
  }

  return undefined;
}

get_cp_offset(var_0, var_1, var_2) {
  return 30 + _func_1E2(-1, randomint(2)) * var_0 * randomint(int(var_1 / var_2));
}

_id_A653(var_0, var_1, var_2, var_3) {
  self endon("entitydeleted");
  childthread delete_in_time(35, var_0, var_1, var_3);
  var_0 waittill("trigger", var_4);

  if(common_scripts\utility::_id_562E(var_3)) {
    level endon("wustling_weapon_pickup");
    level notify("wustling_weapon_pickup", var_4);
    return;
  }

  if(common_scripts\utility::_id_0F79(get_berlin_melee_weapons(), var_2) || issubstr(var_2, "zom_dlc3_5")) {
    var_4.special_melee_weapon = var_2;
    var_4 _id_0586::_id_078C(var_2);
    var_4 _id_0586::_id_078E(var_2);
  } else if(_id_0547::_id_5565(var_2, "jack_in_box_decoy_zm"))
    var_4 _id_057D::_id_4766();
  else {
    if(_id_0547::_id_73F9(var_4, var_2))
      var_4 _id_0586::_id_0790(var_2);

    _id_0548::_id_A7D6(var_4, var_2);
  }

  remove_weapon_pickup(var_0, var_1);
}

assign1() {}

turn_off_care_package_trigger() {
  self._id_7AC4 = self.origin;
  common_scripts\utility::_id_9D9F();
}

delete_in_time(var_0, var_1, var_2, var_3) {
  self endon("entitydeleted");
  var_4 = 0.25;
  var_5 = 1;
  var_6 = 6.5;
  self _meth_83FE(0, 0);

  for(var_7 = 0; var_7 < var_0; var_7 = var_7 + var_4) {
    if(var_7 >= var_0 - var_6 && var_5) {
      var_5 = 0;
      childthread blink_weap_expiring();
    }

    wait(var_4);
  }

  if(common_scripts\utility::_id_562E(var_3))
    level notify("wustling_weapon_pickup");

  remove_weapon_pickup(var_1, var_2);
}

remove_weapon_pickup(var_0, var_1) {
  var_0 turn_off_care_package_trigger();
  delete_usable(var_1);
}

register_care_package_reward(var_0, var_1, var_2, var_3, var_4) {
  level.zmb_shotgun_carepackage_rewards["level_" + var_0] = spawnStruct();
  level.zmb_shotgun_carepackage_rewards["level_" + var_0].normals = var_1;
  level.zmb_shotgun_carepackage_rewards["level_" + var_0]._id_90C5 = common_scripts\utility::random(var_2);
  level.zmb_shotgun_carepackage_rewards["level_" + var_0].melees = var_3;
  level.zmb_shotgun_carepackage_rewards["level_" + var_0].upgrades = var_4;
}

delete_usable(var_0) {
  if(isDefined(self.linkent)) {
    self _meth_8057();
    self.linkent delete();
  }

  if(isDefined(var_0))
    var_0 delete();

  if(isDefined(self))
    self delete();
}

blink_weap_expiring() {
  for(;;) {
    self _meth_83FF();
    wait 0.5;
    self _meth_83FE(0, 0);
    wait 0.5;
  }
}

run_player_carepackage_reward() {
  var_0 = self;
  var_0 thread run_ingame_cinematic("carepackage_camera");
}

run_ingame_cinematic(var_0) {
  var_1 = self;
  var_2 = var_0[0];
  var_3 = var_0[1];
  var_4 = var_0[2];
  var_5 = var_0[3];
  var_6 = !common_scripts\utility::_id_562E(var_0[4]);
  var_7 = common_scripts\utility::_id_562E(var_0[5]);
  var_8 = _id_0547::_id_5565(var_6, 0);
  var_9 = 0.1;
  var_10 = 0.8;

  if(isDefined(var_5)) {
    var_9 = var_5;
    var_10 = var_5;
  }

  var_1 endon("disconnect");
  var_11 = 0.55;
  var_12 = -120;

  if(_func_031(var_2)) {
    var_13 = common_scripts\utility::_id_46B7(var_2, "targetname");
    var_14 = common_scripts\utility::random(var_13);
  } else
    var_14 = var_2;

  var_15 = common_scripts\utility::_id_46B7(var_14.target, "targetname");
  var_16 = common_scripts\utility::random(var_15);

  if(isDefined(var_14.dest))
    var_16 = var_14.dest;

  var_17 = spawn("script_model", var_14.origin);
  var_17 setModel("tag_player");

  if(isDefined(var_14.angles))
    var_17.angles = var_14.angles;

  var_18 = var_17.origin + (var_1.origin - var_1 getEye());
  var_19 = var_1.angles;

  if(common_scripts\utility::_id_562E(var_7)) {
    var_1 = self;
    var_1 _meth_81E2(var_17, "tag_player");
  } else {
    if(isDefined(var_17.angles))
      var_1 _meth_833E(var_17.angles, 1);
    else
      var_1 _meth_833E((0, 0, 0), 1);

    var_1 setOrigin(var_18, 1);
    var_1 _meth_8077(var_17, "tag_player", 1.0, 0, 0, 0, 0, 1);
  }

  var_17 _meth_82B1(var_16.origin, var_4, 0, var_11);
  var_1 childthread do_fade_in_and_out(var_4, var_9, var_10);

  if(!common_scripts\utility::_id_562E(var_1.incinematicmode))
    var_1 childthread _id_0547::set_player_cinematic_mode(!common_scripts\utility::_id_562E(var_7));

  wait_for_move_done(var_4, var_3, var_10, var_9);

  if(var_8) {
    var_1 _id_0547::unset_player_cinematic_mode(!common_scripts\utility::_id_562E(var_7));

    if(!common_scripts\utility::_id_562E(var_7))
      var_1 _meth_833E(var_19);

    var_1 childthread animscripts\notetracks_common::do_fade_from_black(var_10);
  }
}

wait_for_move_done(var_0, var_1, var_2, var_3) {
  var_4 = self;
  var_4 endon("disconnect");
  wait(var_0 + var_1 - var_2 + var_3);
}

do_fade_in_and_out(var_0, var_1, var_2) {
  var_3 = self;
  var_3 notify("new_intro_fade");
  var_3 endon("new_intro_fade");
  var_3 childthread animscripts\notetracks_common::do_fade_from_black(var_2);
  wait(var_0 - var_2);
  var_3 childthread animscripts\notetracks_common::_id_30B4(var_1);
}

outro_zombie_taunt(var_0) {
  self endon("death");
  self _meth_83A2(1);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "cinematic taunt");
  var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35("board_taunt_base");

  if(isDefined(var_0)) {
    for(var_2 = 0; var_2 < var_0; var_2++)
      maps\mp\agents\_scripted_agent_anim_util::_id_71FA("board_taunt_base", var_1, 1.0, "taunt_anim");
  } else {
    for(;;)
      maps\mp\agents\_scripted_agent_anim_util::_id_71FA("board_taunt_base", var_1, 1.0, "taunt_anim");
  }

  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "cinematic taunt");
  self _meth_83A2(0);
}

add_difficulty_setting(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(level.zmb_sg_difficulty_settings))
    level.zmb_sg_difficulty_settings = [];

  if(!isDefined(level.zmb_sg_difficulty_settings_debugname))
    level.zmb_sg_difficulty_settings_debugname = [];

  level.zmb_sg_difficulty_settings_debugname[var_1] = var_0;
  var_8 = 4;
  level.zmb_sg_difficulty_settings[var_1] = [];

  if(!isDefined(var_4))
    var_4 = 1;

  if(!isDefined(var_5))
    var_5 = 1;

  if(_func_0C0(var_2)) {
    if(var_2.size < var_8) {
      var_9 = var_2.size;

      for(var_10 = var_9; var_10 < var_8; var_10++)
        var_2[var_10] = var_2[var_9 - 1];
    }

    for(var_11 = 0; var_11 < 5; var_11++) {
      var_12 = [];

      for(var_13 = 0; var_13 < var_2.size; var_13++) {
        var_14 = var_2[var_13] * return_high_round_modifier(var_4, var_5, var_11);
        var_12[var_12.size] = var_14;
      }

      level.zmb_sg_difficulty_settings[var_1][var_11] = var_12;
    }

    return;
  } else if(isDefined(var_6)) {
    level.zmb_sg_difficulty_settings[var_1] = spawnStruct();
    level.zmb_sg_difficulty_settings[var_1].minval = var_2;
    level.zmb_sg_difficulty_settings[var_1].maxval = var_3;
    level.zmb_sg_difficulty_settings[var_1]._id_3F02 = var_6;
    level.zmb_sg_difficulty_settings[var_1]._id_6E5C = var_7;
    level.zmb_sg_difficulty_settings[var_1].low_round_mult = var_4;
    level.zmb_sg_difficulty_settings[var_1].high_round_mult = var_5;
  } else {
    for(var_11 = 0; var_11 < 5; var_11++) {
      for(var_13 = 0; var_13 < var_8; var_13++) {
        var_15 = get_player_frac(var_13 + 1);
        var_14 = _func_2CA(var_2, var_3, var_15);
        var_14 = var_14 * return_high_round_modifier(var_4, var_5, var_11);
        level.zmb_sg_difficulty_settings[var_1][var_11][var_13] = var_14;
      }
    }
  }
}

add_player_level_setting(var_0, var_1, var_2) {
  if(!isDefined(level.zmb_sg_player_rank_modifiers[var_1]))
    level.zmb_sg_player_rank_modifiers[var_1] = [];

  if(!isDefined(level.zmb_sg_player_rank_modifier_debug_names))
    level.zmb_sg_player_rank_modifier_debug_names = [];

  level.zmb_sg_player_rank_modifier_debug_names[var_1] = var_0;

  for(var_3 = 0; var_3 < var_2.size - 1; var_3 = var_3 + 2) {
    var_4 = spawnStruct();
    var_4._id_627D = var_2[var_3 + 1];
    var_4.min_level = var_2[var_3];
    level.zmb_sg_player_rank_modifiers[var_1] = common_scripts\utility::_id_0F6F(level.zmb_sg_player_rank_modifiers[var_1], var_4);
  }
}

get_player_level_setting(var_0, var_1) {
  var_2 = get_current_team_level();
  var_3 = get_player_level_percentage(var_2);

  if(common_scripts\utility::_id_562E(level.zmb_red_skull_mode_activated))
    var_3 = 200;

  var_4 = level.zmb_sg_player_rank_modifiers[var_0][0];

  foreach(var_6 in level.zmb_sg_player_rank_modifiers[var_0]) {
    if(var_3 >= var_6.min_level)
      var_4 = var_6;
  }

  return var_4._id_627D;
}

get_player_level_percentage(var_0) {
  return int(100 * (var_0 / level.zmshotgunmaxlevel));
}

get_current_team_level() {
  var_0 = 0;

  foreach(var_2 in level.players)
  var_0 = var_0 + int(var_2 maps\mp\zombies\_zombies_progression::get_zm_shotgun_player_level());

  var_0 = var_0 / level.players.size;
  return var_0;
}

return_high_round_modifier(var_0, var_1, var_2) {
  if(var_2 >= 2)
    var_3 = 1;
  else
    var_3 = var_2 / 3;

  return _func_2CA(var_0, var_1, var_3);
}

get_difficulty_setting(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.zmb_sg_difficulty_settings))
    return undefined;

  var_4 = level.zmb_sg_difficulty_settings[var_0];
  var_5 = undefined;
  var_6 = 1;

  if(isDefined(level.players) && level.players.size > 0)
    var_6 = level.players.size;

  var_7 = level.objectivescompleted;

  if(common_scripts\utility::_id_562E(level.zmb_red_skull_mode_activated))
    var_7 = var_7 + 1;

  var_8 = 4;

  if(var_7 > var_8)
    var_7 = var_8;

  if(isDefined(var_4)) {
    if(_func_0C0(var_4))
      var_5 = var_4[var_7][var_6 - 1];
    else {
      var_9 = _func_2CA(var_4.minval, var_4.maxval, get_player_frac(var_6 - 1));
      var_5 = var_9 * [[var_4._id_3F02]](var_4._id_6E5C);
      var_5 = var_5 * return_high_round_modifier(var_4.low_round_mult, var_4.high_round_mult, var_7);
    }
  }

  if(var_5 < 1 && var_5 > 0)
    return var_5;
  else
    return int(var_5);
}

_id_7F2C(var_0, var_1) {
  if(var_1 == 0)
    return var_0;

  var_2 = _func_0AE(var_0) % var_1;

  if(var_2 == 0)
    return var_0;

  if(var_0 < 0)
    return -1 * (_func_0AE(var_0) - var_2);
  else
    return var_0 + var_1 - var_2;
}

get_player_frac(var_0) {
  var_1 = 4;
  return (var_0 - 1) / (var_1 - 1);
}

current_fodder_zombie_health(var_0) {
  if(level._id_A980 < var_0)
    var_1 = var_0;
  else
    var_1 = level._id_A980;

  return maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51("zombie_generic"), var_1);
}

altered_state_init() {}

altered_state_apply(var_0, var_1, var_2) {
  var_3 = self;
  level endon("game_ended");
  var_3 endon("disconnect");
  var_3 endon("death");

  if(common_scripts\utility::_id_562E(var_3.in_altered_state)) {
    return;
  }
  var_3 altered_state_fade();

  if(!isDefined(var_1))
    var_1 = 30;

  var_3.in_altered_state = 1;
  var_3 notify("altered_state_start");
  var_4 = _id_0547::is_zm_shattered_thule_map();
  var_5 = _id_0547::is_zm_shattered_dnk_map();
  var_6 = "dlc_zmb_dig02_hallucination_01";

  if(level._id_258F) {
    if(_id_0547::_id_5565(var_2, 1))
      var_6 = "dlc_zmb_dig02_hallucination_01";
    else if(_id_0547::_id_5565(var_2, 2))
      var_6 = "dlc_zmb_dig02_hallucination_02";
    else if(_id_0547::_id_5565(var_2, 3))
      var_6 = "dlc_zmb_dig02_hallucination_03";
  }

  var_3.altered_state_fx = _func_2A9(common_scripts\utility::_id_44F5(var_6), var_3, "tag_origin", var_3);
  _func_14C(var_3.altered_state_fx);
  var_3 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_3.altered_state_fx);
  var_3 _id_0378::_id_8D74("dlc3_altered_state_apply", var_2, "altered_state_end");
  var_3 _meth_866F(10.5, 0.1, 0.25);
  var_3 childthread altered_state_set_fov();
  var_3 thread altered_state_death_listener();
  var_3 childthread altered_state_cleanup_listener();

  if(!common_scripts\utility::_id_562E(var_0)) {
    var_3.altered_state_time = var_1;

    while(var_3.altered_state_time > 0) {
      var_3.altered_state_time--;
      wait 1;
    }

    var_3 notify("altered_state_end");
  }
}

altered_state_cycle_shock() {
  var_0 = self;
  var_0 endon("altered_state_end");
  var_0 endon("disconnect");
  var_1 = 2;

  for(;;) {
    wait(_func_0A4(14, 20));
    var_0 _meth_8182("zm_dig_altered", var_1);
    var_0 _meth_8036(1.4, 1);
    var_0 common_scripts\utility::_id_2CBE(var_1, ::_meth_8036, 1.4, 1.5);
  }
}

altered_state_set_fov() {
  var_0 = self;
  var_0 _meth_8036(1.4, 1.5);
}

altered_state_fade() {
  var_0 = self;
  var_0 endon("disconnect");

  if(!isDefined(var_0.altered_state_overlay_fade))
    var_0.altered_state_overlay_fade = altered_state_create_client_overlay("white", 1, var_0);

  var_1 = 1;
  var_2 = 0.25;
  var_0.altered_state_overlay_fade.alpha = 0;
  var_0.altered_state_overlay_fade fadeovertime(var_1);
  var_0.altered_state_overlay_fade.alpha = 1;
  var_0 _id_0378::_id_8D74("dlc3_altered_state_fade");
  wait(var_1);
  var_0.altered_state_overlay_fade.alpha = 1;
  var_0.altered_state_overlay_fade fadeovertime(var_2);
  var_0.altered_state_overlay_fade.alpha = 0;
}

altered_state_end_overlay(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_2 = _id_0547::is_zm_shattered_thule_map();
  var_3 = _id_0547::is_zm_shattered_dnk_map();
  var_4 = "dlc_zmb_dig02_hallucination_01";

  if(var_2) {} else if(var_3) {}

  if(isDefined(var_1.altered_state_fx))
    var_1.altered_state_fx delete();

  var_1 _meth_866F(1, 0, 1);
  var_1.in_altered_state = 0;
  var_1 _meth_8036(1, 1.5);
}

altered_state_cleanup_listener() {
  var_0 = self;
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 waittill("altered_state_end");
  var_0 altered_state_fade();
  var_0 altered_state_end_overlay(1);
}

altered_state_death_listener() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0 endon("altered_state_end");
  var_0 waittill("death");
  var_0 altered_state_fade();
  var_0 altered_state_end_overlay(0);
}

altered_state_create_client_overlay(var_0, var_1, var_2, var_3) {
  var_4 = 1;

  if(isDefined(var_3))
    var_4 = var_3;

  if(isDefined(var_2))
    var_5 = _func_19B(var_2);
  else
    var_5 = newhudelem();

  var_5.x = 0;
  var_5.y = 0;
  var_5 setshader(var_0, 640, 480);
  var_5.alignx = "left";
  var_5.aligny = "top";
  var_5.sort = 1;
  var_5._id_00C6 = "fullscreen";
  var_5._id_01CA = "fullscreen";
  var_5.alpha = var_1;
  var_5.foreground = var_4;
  return var_5;
}

get_berlin_melee_weapons() {
  return ["zom_dlc2_1_zm", "zom_dlc2_3_zm", "zom_dlc2_2_zm"];
}

special_melee_get_weapon_name(var_0) {
  var_1 = undefined;

  if(isDefined(var_0)) {
    switch (var_0) {
      case "bat":
        var_1 = "zom_dlc2_1hc_zm";
        break;
      case "pickaxe":
        var_1 = "zom_dlc2_3hc_zm";
        break;
      case "dagger":
        var_1 = "zom_dlc2_2hc_zm";
        break;
      case "sword":
        var_1 = "zom_dlc2_4_zm";
        break;
      case "bat_casual":
        var_1 = "zom_dlc2_1_zm";
        break;
      case "pickaxe_casual":
        var_1 = "zom_dlc2_3_zm";
        break;
      case "dagger_casual":
        var_1 = "zom_dlc2_2_zm";
        break;
      case "shovel_casual":
        var_1 = "shovel_zm";
        break;
    }
  }

  return var_1;
}

register_banned_objective(var_0) {
  if(!isDefined(level.zmb_sg_banned_objectives))
    level.zmb_sg_banned_objectives = [];

  level.zmb_sg_banned_objectives = common_scripts\utility::_id_0F6F(level.zmb_sg_banned_objectives, var_0);
}

spawn_extra_redskull_assassins(var_0) {
  var_1 = int(get_difficulty_setting("type_boss_health_assassin_red_skull"));
  var_2 = common_scripts\utility::_id_46B7("zmb_assassin_spawnpoint_leader_boss_fight", "targetname");

  foreach(var_4 in var_2) {
    var_5 = maps\mp\zombies\sg_events_v1\assassin_squad::spawn_sh_assassin(var_0, var_1, var_4);
    var_5.isfireassassin = 1;
  }
}

try_activate_redskull_mode(var_0) {
  if(common_scripts\utility::_id_562E(level.zmb_red_skull_mode_activated))
    return 0;

  if(common_scripts\utility::_id_562E(var_0) && is_redskull_activation_round())
    remove_redskull_mode_activation();

  if(should_activate_redskull_mode(var_0))
    maps\mp\zombies\shotgun\_zombies_shotgun_gamemode::activate_redskull_mode();
}

remove_redskull_mode_activation() {
  level.redskull_mode_unavailable = 1;
  level notify("zmb_darkened_path_unavailable");
  remove_redskull_visuals();
}

is_redskull_activation_round() {
  return level._id_A980 == 3;
}

remove_redskull_visuals() {
  if(isDefined(level.shattered_opt_in_ents)) {
    level.shattered_opt_in_ents = common_scripts\utility::_id_0F97(level.shattered_opt_in_ents);
    level.shattered_opt_in_ents = common_scripts\utility::_id_0FA0(level.shattered_opt_in_ents);

    foreach(var_1 in level.shattered_opt_in_ents)
    var_1 delete();
  }
}

not_the_final_objective() {
  return level.objectivescompleted < 2;
}