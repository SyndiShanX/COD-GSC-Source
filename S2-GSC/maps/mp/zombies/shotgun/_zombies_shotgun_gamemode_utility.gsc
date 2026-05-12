/*************************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility.gsc
*************************************************************************/

_________general_shotgun_objective_utils_________() {}

sg_obj_register(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(!isarray(param_02)) {
    param_02 = [param_02];
  }

  var_0A = 1;
  var_0B = 0;
  if(isDefined(level.zmb_sg_objectives[param_00])) {
    return;
  }

  var_0C = 0;
  level.zmb_sg_objectives[param_00] = spawnStruct();
  level.zmb_sg_objectives[param_00].var_502A = param_00;
  level.zmb_sg_objectives[param_00].var_1B9 = param_01;
  level.zmb_sg_objectives[param_00].valid_waves = [];
  foreach(var_0E in param_02) {
    level.zmb_sg_objectives[param_00].valid_waves = common_scripts\utility::func_F6F(level.zmb_sg_objectives[param_00].valid_waves, var_0E);
  }

  if(isDefined(level.zmb_sg_obj_basic_funcs[param_01])) {
    if(!isDefined(param_04) && isDefined(level.zmb_sg_obj_basic_funcs[param_01].default_callback)) {
      param_04 = level.zmb_sg_obj_basic_funcs[param_01].default_callback;
    }

    if(!isDefined(param_03) && isDefined(level.zmb_sg_obj_basic_funcs[param_01].default_timer)) {
      param_03 = level.zmb_sg_obj_basic_funcs[param_01].default_timer;
    }

    if(isDefined(level.zmb_sg_obj_basic_funcs[param_01].timeout_win)) {
      var_0C = level.zmb_sg_obj_basic_funcs[param_01].timeout_win;
    }

    if(!isDefined(param_08) && isDefined(level.zmb_sg_obj_basic_funcs[param_01].is_endless_wave)) {
      param_08 = level.zmb_sg_obj_basic_funcs[param_01].is_endless_wave;
    }
  }

  level.zmb_sg_objectives[param_00].var_9A07 = param_03;
  level.zmb_sg_objectives[param_00].event_func = param_04;
  level.zmb_sg_objectives[param_00].timeout_win = var_0C;
  level.zmb_sg_objectives[param_00].max_occurences = var_0A;
  level.zmb_sg_objectives[param_00].var_7734 = var_0B;
  level.zmb_sg_objectives[param_00].var_2A35 = param_05;
  level.zmb_sg_objectives[param_00].var_94D6 = param_06;
  level.zmb_sg_objectives[param_00].fail_func = param_07;
  level.zmb_sg_objectives[param_00].is_endless_wave = param_08;
  level.zmb_sg_objectives[param_00].extra_func = param_09;
  level.zmb_sg_objectives[param_00].times_selected = 0;
  return level.zmb_sg_objectives[param_00];
}

get_nice_name(param_00) {
  var_01 = param_00;
  switch (param_00) {
    case "defense_common":
      var_01 = "1. Keypoint Defend";
      break;

    case "extermination_common":
      var_01 = "2. Extermination";
      break;

    case "meuchler_common":
      var_01 = "3. Meuchler";
      break;

    case "keypoint_interact_repair_common":
      var_01 = "4. Repair";
      break;

    case "assassinate_common":
      var_01 = "5. Assassinate";
      break;

    case "escape_common":
      var_01 = "6. ^2Escape^3";
      break;
  }

  return var_01;
}

sg_obj_register_defaults(param_00, param_01, param_02, param_03, param_04) {
  level.zmb_sg_obj_basic_funcs[param_00] = spawnStruct();
  level.zmb_sg_obj_basic_funcs[param_00].default_callback = param_01;
  level.zmb_sg_obj_basic_funcs[param_00].default_timer = param_02;
  level.zmb_sg_obj_basic_funcs[param_00].timeout_win = param_03;
  level.zmb_sg_obj_basic_funcs[param_00].is_endless_wave = param_04;
}

sg_obj_add_required_flags(param_00, param_01) {
  if(isDefined(param_01)) {
    if(!isarray(param_01)) {
      param_01 = [param_01];
    }

    foreach(var_03 in param_01) {
      if(!common_scripts\utility::func_3C83(var_03)) {
        common_scripts\utility::func_3C87(var_03);
      }

      level.zmb_sg_objectives[param_00].required_flags = common_scripts\utility::func_F6F(level.zmb_sg_objectives[param_00].required_flags, var_03);
    }

    level.zmb_sg_objectives[param_00].required_flags = common_scripts\utility::func_F97(level.zmb_sg_objectives[param_00].required_flags);
  }
}

sg_obj_set_timeout_win(param_00, param_01) {
  if(isDefined(param_01)) {
    level.zmb_sg_objectives[param_00].timeout_win = param_01;
  }
}

sg_obj_set_endless_no_heavies(param_00, param_01) {
  if(isDefined(param_01)) {
    level.zmb_sg_objectives[param_00].endless_no_heavies = param_01;
  }
}

sg_obj_select() {
  var_00 = [];
  var_01 = undefined;
  foreach(var_03 in level.zmb_sg_objectives) {
    if(!sg_obj_check_flags(var_03)) {
      continue;
    }

    if(!sg_obj_check_occurence_count(var_03)) {
      continue;
    }

    if(!sg_obj_check_valid_for_this_round(var_03)) {
      continue;
    }

    if(sg_obj_check_is_banned(var_03)) {
      continue;
    }

    var_00 = common_scripts\utility::func_F6F(var_00, var_03);
  }

  if(var_00.size > 0) {
    if(var_00.size == 1) {
      var_01 = var_00[0];
    } else {
      var_01 = common_scripts\utility::func_7A33(var_00);
      foreach(var_03 in var_00) {
        if(var_03.var_7734 > var_01.var_7734) {
          var_01 = var_03;
        }
      }
    }

    var_01.times_selected++;
  }

  return var_01;
}

sg_obj_check_valid_for_this_round(param_00) {
  foreach(var_02 in param_00.valid_waves) {
    if(level.var_A980 == var_02) {
      return 1;
    }
  }

  return 0;
}

sg_obj_check_flags(param_00) {
  if(isDefined(param_00.required_flags)) {
    foreach(var_02 in param_00.required_flags) {
      if(!common_scripts\utility::func_3C77(var_02)) {
        return 0;
      }
    }
  }

  return 1;
}

sg_obj_check_occurence_count(param_00) {
  if(isDefined(param_00.max_occurences)) {
    if(isDefined(param_00.times_selected) && param_00.times_selected >= param_00.max_occurences) {
      return 0;
    }
  }

  return 1;
}

sg_obj_check_is_banned(param_00) {
  return common_scripts\utility::func_F79(level.zmb_sg_banned_objectives, param_00.var_502A);
}

____________basic_shotgun_objectives___________() {}

basic_boss_init() {
  sg_obj_register_defaults("type_boss", ::basic_boss_run, 120, 0, 1);
}

basic_boss_run(param_00) {
  level endon("sg_obj_timeout");
  level.var_1CC0 = undefined;
  var_01 = common_scripts\utility::func_46B5("sg_boss_spawnpoint", "targetname");
  var_02 = lib_0564::func_3C11(0, var_01, 0);
  var_02 lib_0547::func_84CB();
  var_02 maps\mp\agents\_agent_common::func_83FD(-15536);
  var_02.sgboss = 1;
  var_02 maps\mp\zombies\sg_events_v1\_boss_util::set_zombie_boss_has_weapon_loot();
  var_03 = basic_boss_waitfor_defeated();
  if(!isDefined(var_03) || !var_03) {
    return 0;
  }

  return 1;
}

basic_boss_waitfor_defeated() {
  level endon("sg_obj_timeout");
  var_00 = 0;
  for(;;) {
    wait(0.5);
    var_01 = lib_0547::func_408F();
    var_00 = 1;
    foreach(var_03 in var_01) {
      if(common_scripts\utility::func_562E(var_03.sgboss) && !common_scripts\utility::func_562E(var_03.longdeath)) {
        var_00 = 0;
      }
    }

    if(var_00) {
      break;
    }
  }

  return 1;
}

basic_escort_init() {
  sg_obj_register_defaults("type_escort", ::basic_escort_run, 30, 0, 1);
}

basic_escort_run(param_00) {
  var_01 = maps\mp\zombies\sg_events_v1\very_important_zombie::basic_vip_run(param_00, "type_escort");
  return common_scripts\utility::func_562E(var_01);
}

basic_escort_skip_cleanup(param_00) {
  level endon("sg_obj_timeout");
  level endon("flag_sg_VIP_killed");
  level endon("flag_sg_VIP_complete");
  level endon("flag_sg_VIP_timeout");
  level waittill("skipWave");
  param_00 lib_0563::func_AB99(undefined, undefined, 1000, undefined, "MOD_BULLET", "m1911_zm", param_00.var_116, (0, 0, 0), "tag_origin", 0, "tag_weapon");
}

basic_collect_init() {
  level.sg_obj_collection_parts = getEntArray("collect_objective_part_object", "targetname");
  foreach(var_01 in level.sg_obj_collection_parts) {
    var_01 method_805C();
  }

  sg_obj_register_defaults("collect", ::basic_collect_run, 180, 0, 1);
}

basic_collect_run(param_00) {
  foreach(var_02 in level.var_744A) {
    var_02.sg_obj_collect_holding_parts = 0;
  }

  var_04 = getent("collect_objective_destination_object", "targetname");
  var_05 = ["zom_infantrya_bodywhole"];
  level.sg_obj_collection_parts = getEntArray("collect_objective_part_object", "targetname");
  var_06 = 600 / level.var_744A.size;
  var_07 = level.sg_obj_collection_parts.size;
  level.total_parts = level.sg_obj_collection_parts.size;
  level.parts_required = 7;
  level.parts_collected = 0;
  level.parts_destroyed = 0;
  level.sg_obj_collection_parts = common_scripts\utility::func_F92(level.sg_obj_collection_parts);
  for(var_08 = 0; var_08 < level.sg_obj_collection_parts.size; var_08++) {
    level.sg_obj_collection_parts[var_08] thread basic_collect_part_think(var_08, var_05, var_04, var_06, var_07);
  }

  foreach(var_02 in level.var_744A) {
    var_02 childthread basic_collect_additional_ui();
  }

  while(level.parts_collected < level.parts_required) {
    var_0B = basic_collect_waitfor_collection_timeout_or_destroyed();
    if(var_0B == "sg_obj_collect_part_destroyed") {
      level.parts_destroyed++;
      level notify("sg_obj_collection_part_removed");
      if(level.parts_destroyed > level.total_parts - level.parts_required) {
        break;
      }

      continue;
    }

    if(var_0B == "sg_obj_collect_part_collected") {
      level notify("sg_obj_collection_part_removed");
      continue;
    }

    break;
  }

  basic_collect_cleanup();
  if(level.parts_collected >= level.parts_required) {
    return 1;
  }

  return 0;
}

basic_collect_part_think(param_00, param_01, param_02, param_03, param_04) {
  self endon("obj_destroyed");
  level endon("sg_obj_collect_cleanup");
  var_05 = 0;
  var_06 = 0;
  while(!var_05) {
    if(param_00 - var_06 < param_04) {
      break;
    } else {
      level waittill("sg_obj_collection_part_removed");
    }

    var_06++;
    wait 0.05;
  }

  self method_805B();
  self.maxattackingzombies = 0;
  if(self.maxattackingzombies > 0) {
    foreach(var_08 in self.var_1171) {
      var_08 method_8449(self, "tag_origin", (0, 0, 0), (0, 0, 0));
    }
  }

  common_scripts\utility::func_3799("obj_destroyed");
  common_scripts\utility::func_3799("obj_collected");
  if(self.maxattackingzombies > 0) {
    var_0A = ["zombie_generic"];
    var_0B = int(param_03);
    self.var_BC = var_0B;
    self.var_FB = var_0B;
    self.var_1171 = getEntArray(self.var_1A2, "targetname");
    thread maps\mp\mp_zombies_attack_object::create_inanimate_zombie_enemy(self.maxattackingzombies, var_0B, "obj_destroyed", 99999, 110, ::maps\mp\zombies\sg_events_v1\keypoint_defense::basic_defense_on_finished, [], self.var_1171, var_0A, ["zombie_is_passive", "zombie_is_crawler", "zombie_is_objective", "zombie_is_stunned"]);
    thread basic_collect_part_destruction_think();
  }

  lib_0547::func_AC41(&"ZOMBIE_DLC3_OBJECT_PICKUP");
  foreach(var_0D in level.var_744A) {
    thread basic_collect_part_stencil_think(var_0D);
  }

  var_0F = getent(param_02.var_1A2, "targetname");
  while(!common_scripts\utility::func_3794("obj_collected")) {
    self waittill("player_used", var_0D);
    var_0D.sg_obj_collect_holding_parts++;
    level notify("update_collect_obj_ui");
    if(var_0D.sg_obj_collect_holding_parts == 1) {
      var_0F hudoutlineenableforclient(var_0D, 2, 0);
    }

    basic_collect_attach_part_to_player_think(self, var_0D, param_02);
    var_0F hudoutlinedisableforclient(var_0D);
    level.parts_collected = level.parts_collected + var_0D.sg_obj_collect_holding_parts;
    var_0D.sg_obj_collect_holding_parts = 0;
  }

  level notify("sg_obj_collect_part_collected");
  level notify("update_collect_obj_ui");
  basic_collect_part_cleanup();
}

basic_collect_attach_part_to_player_think(param_00, param_01, param_02) {
  param_00 endon("obj_destroyed");
  param_00 lib_0547::func_AC40();
  param_00 method_805C();
  param_00.var_116 = param_01.var_116 + (0, 0, 50);
  param_00 method_8449(param_01, "tag_origin", (0, 0, 50), (0, 0, 0));
  if(param_00.maxattackingzombies > 0) {
    param_00.maxzombies = 0;
    param_00 maps\mp\mp_zombies_attack_object::clear_zombie_interest();
  }

  var_03 = param_00 basic_collect_waitfor_part_dropped_or_returned(param_02, param_01);
  if(isDefined(var_03) && var_03 == "returned") {
    param_00 common_scripts\utility::func_379A("obj_collected");
  } else {
    param_00 unlink();
    wait 0.05;
    param_00.var_116 = param_01.var_116 + (randomintrange(-30, 30), randomintrange(-30, 30), 0);
    param_00.var_116 = common_scripts\utility::func_348B(param_00.var_116, 1500);
    param_00.var_116 = param_00.var_116 + (0, 0, 10);
    wait 0.05;
    param_00 method_805B();
    param_00 lib_0547::func_AC41(&"ZOMBIE_DLC3_OBJECT_PICKUP");
    if(param_00.maxattackingzombies > 0) {
      param_00.maxzombies = param_00.maxattackingzombies;
    }

    param_01.sg_obj_collect_holding_parts = 0;
    level notify("update_collect_obj_ui");
  }

  param_01 notify("player_finished_dropping_part");
}

basic_collect_give_part_weapon() {
  self.sg_obj_collect_current_primary = self getcurrentprimaryweapon();
  lib_0586::func_78C("blimp_battery_zm");
  lib_0586::func_78E("blimp_battery_zm");
  self method_8326();
  self method_8113(0);
  self allowjump(0);
  self waittill("weapon_change");
  while(self method_833B()) {
    wait 0.05;
  }

  self method_8327();
}

basic_collect_take_part_weapon() {
  lib_0586::func_790("blimp_battery_zm");
  lib_0586::func_78E(self.sg_obj_collect_current_primary);
  self allowjump(1);
  self method_8113(1);
}

basic_collect_waitfor_part_dropped_or_returned(param_00, param_01) {
  param_01 endon("enter_last_stand");
  for(;;) {
    param_00 waittill("trigger", var_02);
    if(param_01 == var_02) {
      self notify("sg_obj_collect_part_collect_success");
      return "returned";
    }
  }
}

basic_collect_part_switched_think(param_00) {
  self endon("sg_obj_collect_part_collect_success");
  self endon("sg_obj_collect_part_dropped");
  param_00 endon("player_picking_up_new_part");
  while(!param_00 method_833B() && !param_00 method_84F1()) {
    wait 0.05;
  }

  self notify("sg_obj_collect_part_dropped");
}

basic_collect_waitfor_collection_timeout_or_destroyed() {
  var_00 = level common_scripts\utility::func_A715("sg_obj_collect_part_destroyed", "sg_obj_collect_part_collected", "sg_obj_timeout");
  return var_00;
}

basic_collect_part_destruction_think() {
  level endon("sg_obj_collect_cleanup");
  common_scripts\utility::func_379C("obj_destroyed");
  level notify("sg_obj_collect_part_destroyed");
  basic_collect_part_cleanup();
}

basic_collect_part_stencil_think(param_00) {
  self endon("obj_destroyed");
  self endon("obj_collected");
  self endon("death");
  var_01 = 2;
  var_02 = 2;
  var_03 = 900;
  self hudoutlineenableforclient(param_00, var_01, 0);
  while(isDefined(self)) {
    if(distance(self.var_116, param_00.var_116) > var_03) {
      self hudoutlinedisableforclient(param_00);
      var_02 = -1;
      while(distance(self.var_116, param_00.var_116) > var_03) {
        wait 0.05;
      }

      continue;
    }

    if(self.maxattackingzombies > 0) {
      if(self.var_BC < self.var_FB * 0.3) {
        var_01 = 1;
      } else if(self.var_BC < self.var_FB * 0.65) {
        var_01 = 0;
      }
    } else {
      var_01 = 2;
    }

    if(var_01 != var_02) {
      var_02 = var_01;
      self hudoutlinedisableforclient(param_00);
      self hudoutlineenableforclient(param_00, var_01, 0);
    }

    wait 0.05;
  }
}

basic_collect_additional_ui() {
  wait(9.5);
  var_00 = common_scripts\utility::func_40B5();
  var_01 = maps\mp\gametypes\_hud_util::func_27ED("bigfixed", 0.5);
  var_01 maps\mp\gametypes\_hud_util::func_8707("CENTER", "CENTER", 0, -10);
  var_01.var_E5 = &"ZOMBIE_DLC3_OBJ_COLLECT_COLLECTED";
  var_01 setvalue(level.parts_collected);
  var_01.var_18 = 1;
  var_01.var_56 = (1, 0, 0.07);
  var_01.var_9B = 0.5;
  var_01.var_C6 = "left_adjustable";
  var_01.var_1CA = "top_adjustable";
  var_01.var_11 = "top";
  var_01.accuracy = "left";
  var_01.maxsightdistsqrd = var_00.var_1D2 * 0.042;
  var_01.var_1D7 = var_00.var_BD * 0.055;
  var_02 = maps\mp\gametypes\_hud_util::func_27ED("bigfixed", 0.5);
  var_02 maps\mp\gametypes\_hud_util::func_8707("CENTER", "CENTER", 0, -10);
  var_02.var_E5 = &"ZOMBIE_DLC3_OBJ_COLLECT_HOLDING";
  var_02 setvalue(self.sg_obj_collect_holding_parts);
  var_02.var_18 = 1;
  var_02.var_56 = (1, 0, 0.07);
  var_02.var_9B = 0.5;
  var_02.var_C6 = "left_adjustable";
  var_02.var_1CA = "top_adjustable";
  var_02.var_11 = "top";
  var_02.accuracy = "left";
  var_02.maxsightdistsqrd = var_00.var_1D2 * 0.042;
  var_02.var_1D7 = var_00.var_BD * 0.068;
  childthread basic_collect_additional_ui_think(var_01, var_02);
  level waittill("round complete");
  basic_collect_additional_ui_cleanup(var_01, var_02);
}

basic_collect_additional_ui_think(param_00, param_01) {
  level endon("round complete");
  var_02 = self;
  for(;;) {
    level waittill("update_collect_obj_ui");
    param_01 setvalue(var_02.sg_obj_collect_holding_parts);
    param_00 setvalue(level.parts_collected);
  }
}

basic_collect_additional_ui_cleanup(param_00, param_01) {
  if(isDefined(param_00)) {
    param_00 maps\mp\gametypes\_hud_util::func_2DCC();
  }

  if(isDefined(param_01)) {
    param_01 maps\mp\gametypes\_hud_util::func_2DCC();
  }
}

basic_collect_cleanup() {
  level notify("sg_obj_collect_cleanup");
  foreach(var_01 in level.sg_obj_collection_parts) {
    var_01 basic_collect_part_cleanup();
  }
}

basic_collect_part_cleanup() {
  if(isDefined(self)) {
    level.sg_obj_collection_parts = common_scripts\utility::func_F93(level.sg_obj_collection_parts, self);
    var_00 = getEntArray(self.var_1A2, "targetname");
    if(isDefined(var_00) && var_00.size > 0) {
      foreach(var_02 in var_00) {
        var_02 delete();
      }
    }

    if(isDefined(self.var_9D65)) {
      self.var_9D65 delete();
    }

    self delete();
  }
}

_______________general_utilities_______________() {}

single_ent_health_display_start(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    return;
  }

  lib_0547::func_A6F6();
  level thread single_ent_health_display_setup(param_00, param_01, param_02);
}

show_sh_boss_health(param_00) {
  var_01 = self;
  level thread maps\mp\_utility::func_6F74(::set_waypoints_to_enemy, 3, "sg_VIP_finished");
  level thread single_ent_health_display_start(var_01, param_00, 1);
}

important_zombie_show_destination(param_00, param_01) {
  if(isDefined(self.var_1928)) {
    var_02 = self.var_1928;
    var_02.var_603C = param_00;
    var_02.waypoint_origin = param_01;
    var_02.waypoints = [];
    level thread maps\mp\_utility::func_6F74(::draw_waypoint_on_struct, var_02);
  }
}

single_ent_health_display_setup(param_00, param_01, param_02) {
  setomnvar("ui_zm_waypoint_ents_type", 1);
  var_03 = param_00 assign_health_bar("a");
}

double_ent_health_display_setup(param_00, param_01) {
  setomnvar("ui_zm_waypoint_ents_type", 2);
  var_02 = param_00 assign_health_bar("a");
  var_03 = param_01 assign_health_bar("b");
}

assign_health_bar(param_00) {
  var_01 = common_scripts\utility::func_8FFC();
  var_01 method_805B();
  var_01 method_8449(self, "tag_origin");
  var_01.var_3012 = "ui_zm_waypoint_ent_" + param_00;
  var_01.var_3013 = "ui_zm_waypoint_float_" + param_00;
  setomnvar(var_01.var_3012, var_01 getentitynumber());
  setomnvar(var_01.var_3013, 1);
  thread single_ent_health_display_update(var_01);
  return var_01;
}

draw_waypoint_on_struct(param_00, param_01) {
  if(!isDefined(level.zmb_event_waypoints)) {
    level.zmb_event_waypoints = [];
  }

  if(!isDefined(param_00.var_95AB)) {
    param_00.var_95AB = param_00 common_scripts\utility::func_8FFC();
    param_00.var_95AB method_805B();
    param_00.var_95AB.var_116 = param_00.waypoint_origin;
  }

  var_02 = self;
  var_03 = newclienthudelem(var_02);
  var_03 setshader(param_00.var_603C, 1, 1);
  var_03.var_18 = 0;
  var_03.var_56 = (1, 1, 1);
  var_03.maxsightdistsqrd = param_00.var_95AB.var_116[0];
  var_03.var_1D7 = param_00.var_95AB.var_116[1];
  var_03.var_1D9 = param_00.var_95AB.var_116[2];
  var_03 setwaypoint(0, 1, 0);
  var_03 fadeovertime(0.1);
  var_03.var_18 = 1;
  param_00.waypoints = common_scripts\utility::func_F6F(param_00.waypoints, var_03);
  level.zmb_event_waypoints[level.zmb_event_waypoints.size] = param_00;
}

clear_all_waypoints() {
  foreach(var_01 in level.zmb_event_waypoints) {
    if(!isDefined(var_01)) {
      continue;
    }

    if(isDefined(var_01.var_95AB)) {
      var_01.var_95AB delete();
    }

    foreach(var_03 in var_01.waypoints) {
      clear_waypoint_safe(var_03);
    }
  }
}

clear_waypoint_safe(param_00) {
  if(isDefined(param_00) && !function_0279(param_00)) {
    param_00 destroy();
  }
}

get_modified_boss_health(param_00) {
  param_00 = param_00 * level.zmb_global_zombie_health_multiplier;
  param_00 = param_00 * get_player_level_setting("type_boss_health_red_skull");
  return param_00;
}

single_ent_health_display_update(param_00) {
  self endon("death");
  self endon("entitydeleted");
  param_00 endon("entitydeleted");
  level notify(param_00.var_3013 + "_new_single_ent_health_display_update");
  level endon(param_00.var_3013 + "_new_single_ent_health_display_update");
  thread hide_waypoint_on_death(param_00);
  if(!isDefined(level.zmb_waypoint_ents)) {
    level.zmb_waypoint_ents = [];
  }

  level.zmb_waypoint_ents[level.zmb_waypoint_ents.size] = param_00;
  for(;;) {
    if(isDefined(self.capture_health)) {
      var_01 = self.capture_health;
    } else {
      var_01 = self.var_BC;
    }

    setomnvar(param_00.var_3013, var_01 / self.var_FB);
    lib_0547::func_A6F6();
    if(var_01 <= 0) {
      level notify("sg_defense_failed");
      if(!function_01EF(self) && !isDefined(self.capture_health)) {
        self delete();
      }
    }
  }
}

hide_waypoint_on_death(param_00) {}

func_30D7(param_00) {}

set_waypoints_to_enemy(param_00) {
  var_01 = self;
  var_01 setclientomnvar("ui_zm_exo_slam", param_00);
}

spawn_player_reward(param_00, param_01, param_02, param_03) {
  var_04 = lib_0547::func_5868(param_01);
  if(!common_scripts\utility::func_F79(get_berlin_melee_weapons(), param_01)) {
    param_01 = maps\mp\zombies\_zombies_magicbox::func_454B(param_00, param_01);
  }

  if(var_04) {
    param_01 = param_00 lib_0586::func_78B(lib_0547::func_AAF9(param_01));
  }

  var_05 = spawn_a_floating_weapon_award(param_01, param_02, param_00);
  var_06 = var_05.var_3F2F;
  param_03 common_scripts\utility::func_9DA3();
  param_03.var_116 = var_05.var_116 + (0, 0, 30);
  var_07 = 0;
  var_08 = 0;
  var_09 = lib_0547::func_AAF9(param_01, 1);
  param_03.var_2955 = var_07;
  param_03.lastmultikilltime = var_07;
  param_03.var_2925 = var_08;
  param_03.var_DB5 = var_08;
  param_03.var_9DA0 = 0;
  param_03.var_82EF = undefined;
  if(!isDefined(param_03.var_A9E0)) {
    param_03 initialize_weapon_pickup_trigger(param_00, var_09, 1);
  } else {
    param_03.var_A9E0 = lib_0547::func_AAF9(var_09, 1);
    param_03.var_A7D7 = 1;
    param_03.var_6C5C = param_03.var_A9E0;
    param_03.var_65DC.var_A9B4 = param_03.var_A9E0;
    param_03.var_65DC.var_A9A5 = 0;
    param_03.var_65DC.var_6642 = 1;
  }

  var_05 thread func_A653(param_03, var_06, param_01);
}

spawn_player_rewards(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_04 getentitynumber();
  var_06 = common_scripts\utility::func_46B7("shattered_weapon_spawn_point", "script_noteworthy");
  foreach(var_0B, var_08 in param_01) {
    var_09 = getclosestpointonnavmesh(var_06[var_0B].var_116, param_04);
    var_0A = level.usa_carepackage_dz_triggers[var_0B][var_05];
    thread spawn_player_reward(param_04, var_08, var_09, var_0A);
  }
}

set_hidden_but_sent_to_player(param_00) {
  set_shown_only_to_player(param_00);
  self method_8511();
}

set_shown_only_to_player(param_00) {
  if(isDefined(param_00)) {
    self method_805C();
    self showtoclient(param_00);
    return;
  }

  self method_805B();
}

prespawn_a_floating_award(param_00, param_01, param_02) {
  if(isDefined(param_02) && issubstr(param_00, "_pap_")) {
    var_03 = param_02 lib_0586::func_78B(lib_0547::func_AAF9(param_00));
  } else {
    var_03 = param_01;
  }

  var_04 = spawn("weapon_" + var_03, getclosestpointonnavmesh(param_01) + (0, 0, 8));
  var_04.var_1D = (var_04.var_1D[0] - 30, randomint(360), var_04.var_1D[2]);
  var_04 makeunusable();
  var_04 set_hidden_but_sent_to_player(param_02);
  var_05 = var_04 common_scripts\utility::func_8FFC();
  var_05.var_116 = var_05.var_116 + (0, 0, 8);
  var_05 set_hidden_but_sent_to_player(param_02);
  var_04.var_116 = var_05.var_116;
  var_04 method_8449(var_05, "tag_origin");
  var_04.linkent = var_05;
  var_05 rotateyaw(-29536, 850);
  var_06 = spawnStruct();
  var_06.var_116 = var_04.var_116;
  if(issubstr(param_00, "_pap_")) {
    var_07 = lib_0547::func_8FBA(var_06, "zmb_ber_gun_cone_glow_pap");
  } else {
    var_07 = lib_0547::func_8FBA(var_07, "zmb_ber_gun_cone_glow");
  }

  var_07.var_116 = var_06.var_116;
  var_04.var_3F2F = var_07;
  var_07 set_hidden_but_sent_to_player(param_02);
  return var_04;
}

show_prespawned_floating_award(param_00) {
  set_shown_only_to_player(param_00);
  self.var_3F2F set_shown_only_to_player(param_00);
  triggerfx(self.var_3F2F);
}

spawn_a_floating_weapon_award(param_00, param_01, param_02) {
  var_03 = prespawn_a_floating_award(param_00, param_01, param_02);
  var_04 = 10000;
  var_05 = gettime() + var_04;
  while(gettime() < var_05) {
    if(isDefined(param_02)) {
      var_06 = [param_02];
    } else {
      var_06 = level.var_744A;
    }

    var_07 = 1;
    foreach(var_09 in var_06) {
      if(!var_09 method_8530(param_00)) {
        var_07 = 0;
      }
    }

    if(var_07) {
      break;
    }

    wait 0.05;
  }

  var_03 show_prespawned_floating_award(param_02);
  return var_03;
}

initialize_weapon_pickup_trigger(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    var_03 = level.var_744A;
  } else {
    var_03 = [param_01];
  }

  var_04 = self;
  var_04 usetriggerrequirelookat(1);
  var_04.var_A9E0 = lib_0547::func_AAF9(param_01, 1);
  var_04.var_6C5C = var_04.var_A9E0;
  foreach(var_06 in var_03) {
    var_07 = lib_0552::func_7BFE(var_06, var_04, param_02);
    var_04.var_65DC = var_07;
  }

  var_04.var_65DC.var_A9B4 = var_04.var_6C5C;
  var_04.var_65DC.var_A9A5 = 0;
  var_04.var_65DC.var_6642 = 1;
  var_04.var_A7D7 = 1;
}

should_activate_redskull_mode(param_00) {
  var_01 = 0;
  if(common_scripts\utility::func_562E(param_00) && !is_redskull_activation_round()) {
    return 0;
  }

  foreach(var_03 in level.var_744A) {
    if(common_scripts\utility::func_562E(var_03.optedintohc)) {
      var_01++;
    }
  }

  if(var_01 == 4) {
    return 1;
  }

  if(function_0371()) {
    return var_01 == level.var_744A.size;
  }

  if(!function_0371() && common_scripts\utility::func_562E(param_00)) {
    return var_01 == level.var_744A.size;
  }

  return 0;
}

run_perk_powerup(param_00) {
  var_01 = wait_for_powerup_taken(param_00, "dlc_pickup_zombies_01_blitz_random");
  foreach(var_01 in level.var_744A) {
    var_03 = var_01 lib_056A::givefreemachineperks(0, 2, level.zmb_sg_desired_perk_order);
    foreach(var_05 in var_03) {
      var_01 thread maps\mp\gametypes\_hud_message::func_9102(get_perk_splash(var_05));
    }
  }
}

get_perk_splash(param_00) {
  var_01 = "";
  switch (param_00) {
    case "fastreload":
      var_01 = "zm_collectible_splash_1";
      break;

    case "punchperk":
      var_01 = "zm_collectible_splash_2";
      break;

    case "runperk":
      var_01 = "zm_collectible_splash_3";
      break;

    case "quickrevive":
      var_01 = "zm_collectible_splash_4";
      break;

    case "electriccherry":
      var_01 = "zm_collectible_splash_5";
      break;

    case "doubletap":
      var_01 = "zm_collectible_splash_6";
      break;
  }

  return var_01;
}

run_mini_monies(param_00, param_01, param_02) {
  param_00 endon("disconnect");
  var_03 = wait_for_powerup_taken(param_02, "dlc_pickup_zombies_01_money_gj_2", param_00);
  if(isDefined(param_00)) {
    param_00 maps\mp\gametypes\zombies::func_4798(int(param_01 / 4));
  }
}

run_armor_powerup(param_00) {
  var_01 = wait_for_powerup_taken(param_00, "zmi_max_armor_vfx");
  foreach(var_01 in level.var_744A) {
    var_01 thread maps\mp\gametypes\_hud_message::func_9102("zm_shattered_maxarmor_splash");
    var_01 lib_056A::cp_zmb_escape_init();
    maps\mp\gametypes\zombies::extra_report_powerup_collected(var_01);
  }

  level notify("zmb_players_took_airdrop_armor");
}

wait_for_powerup_taken(param_00, param_01, param_02) {
  var_03 = spawn_fake_powerup(param_00, param_01);
  if(isDefined(param_02)) {
    param_02 endon("disconnect");
    foreach(var_05 in level.var_744A) {
      if(var_05 != param_02) {
        var_03[0] hidefromclient(var_05);
      }
    }

    for(var_07 = undefined; !lib_0547::func_5565(var_07, param_02); var_07 = var_03[1] wait_for_player_close_or_timeout(20)) {}
  } else {
    var_07 = var_07[1] wait_for_player_close_or_timeout(20);
  }

  clear_powerup(var_03, var_07);
  return var_07;
}

clear_powerup(param_00, param_01) {
  if(isDefined(param_01)) {
    param_01 method_8615("zmb_pickup_general");
  }

  foreach(var_03 in param_00) {
    var_03 delete();
  }
}

spawn_fake_powerup(param_00, param_01) {
  var_02 = spawn("script_model", param_00);
  var_02 setModel("tag_origin");
  param_01 = spawnlinkedfx(common_scripts\utility::func_44F5(param_01), var_02, "tag_origin");
  triggerfx(param_01);
  var_02.var_116 = getclosestpointonnavmesh(param_01.var_116 + (128 - randomint(64), 32 - randomint(64), 0));
  return [param_01, var_02];
}

wait_for_player_close_or_timeout(param_00) {
  wait(0.45);
  var_01 = 0.1;
  var_02 = 0;
  while(var_02 < param_00) {
    foreach(var_04 in level.var_744A) {
      if(distance(var_04.var_116, self.var_116) < 48) {
        return var_04;
      }
    }

    var_02 = var_02 + var_01;
    wait(var_01);
  }

  return undefined;
}

get_cp_offset(param_00, param_01, param_02) {
  return 30 + pow(-1, randomint(2)) * param_00 * randomint(int(param_01 / param_02));
}

func_A653(param_00, param_01, param_02, param_03) {
  self endon("entitydeleted");
  childthread delete_in_time(35, param_00, param_01, param_03);
  param_00 waittill("trigger", var_04);
  if(common_scripts\utility::func_562E(param_03)) {
    level endon("wustling_weapon_pickup");
    level notify("wustling_weapon_pickup", var_04);
    return;
  }

  if(common_scripts\utility::func_F79(get_berlin_melee_weapons(), param_02) || issubstr(param_02, "zom_dlc3_5")) {
    var_04.special_melee_weapon = param_02;
    var_04 lib_0586::func_78C(param_02);
    var_04 lib_0586::func_78E(param_02);
  } else if(lib_0547::func_5565(param_02, "jack_in_box_decoy_zm")) {
    var_04 lib_057D::func_4766();
  } else {
    if(lib_0547::func_73F9(var_04, param_02)) {
      var_04 lib_0586::func_790(param_02);
    }

    maps\mp\zombies\_zombies_magicbox::func_A7D6(var_04, param_02);
  }

  remove_weapon_pickup(param_00, param_01);
}

assign1() {}

turn_off_care_package_trigger() {
  self.var_7AC4 = self.var_116;
  common_scripts\utility::func_9D9F();
}

delete_in_time(param_00, param_01, param_02, param_03) {
  self endon("entitydeleted");
  var_04 = 0.25;
  var_05 = 1;
  var_06 = 6.5;
  self hudoutlineenable(0, 0);
  for(var_07 = 0; var_07 < param_00; var_07 = var_07 + var_04) {
    if(var_07 >= param_00 - var_06 && var_05) {
      var_05 = 0;
      childthread blink_weap_expiring();
    }

    wait(var_04);
  }

  if(common_scripts\utility::func_562E(param_03)) {
    level notify("wustling_weapon_pickup");
  }

  remove_weapon_pickup(param_01, param_02);
}

remove_weapon_pickup(param_00, param_01) {
  param_00 turn_off_care_package_trigger();
  delete_usable(param_01);
}

register_care_package_reward(param_00, param_01, param_02, param_03, param_04) {
  level.zmb_shotgun_carepackage_rewards["level_" + param_00] = spawnStruct();
  level.zmb_shotgun_carepackage_rewards["level_" + param_00].normals = param_01;
  level.zmb_shotgun_carepackage_rewards["level_" + param_00].var_90C5 = common_scripts\utility::func_7A33(param_02);
  level.zmb_shotgun_carepackage_rewards["level_" + param_00].melees = param_03;
  level.zmb_shotgun_carepackage_rewards["level_" + param_00].upgrades = param_04;
}

delete_usable(param_00) {
  if(isDefined(self.linkent)) {
    self unlink();
    self.linkent delete();
  }

  if(isDefined(param_00)) {
    param_00 delete();
  }

  if(isDefined(self)) {
    self delete();
  }
}

blink_weap_expiring() {
  for(;;) {
    self hudoutlinedisable();
    wait(0.5);
    self hudoutlineenable(0, 0);
    wait(0.5);
  }
}

run_player_carepackage_reward() {
  var_00 = self;
  var_00 thread run_ingame_cinematic("carepackage_camera");
}

run_ingame_cinematic(param_00) {
  var_01 = self;
  var_02 = param_00[0];
  var_03 = param_00[1];
  var_04 = param_00[2];
  var_05 = param_00[3];
  var_06 = !common_scripts\utility::func_562E(param_00[4]);
  var_07 = common_scripts\utility::func_562E(param_00[5]);
  var_08 = lib_0547::func_5565(var_06, 0);
  var_09 = 0.1;
  var_0A = 0.8;
  if(isDefined(var_05)) {
    var_09 = var_05;
    var_0A = var_05;
  }

  var_01 endon("disconnect");
  var_0B = 0.55;
  var_0C = -120;
  if(isstring(var_02)) {
    var_0D = common_scripts\utility::func_46B7(var_02, "targetname");
    var_0E = common_scripts\utility::func_7A33(var_0D);
  } else {
    var_0E = var_03;
  }

  var_0F = common_scripts\utility::func_46B7(var_0E.var_1A2, "targetname");
  var_10 = common_scripts\utility::func_7A33(var_0F);
  if(isDefined(var_0E.dest)) {
    var_10 = var_0E.dest;
  }

  var_11 = spawn("script_model", var_0E.var_116);
  var_11 setModel("tag_player");
  if(isDefined(var_0E.var_1D)) {
    var_11.var_1D = var_0E.var_1D;
  }

  var_12 = var_11.var_116 + var_01.var_116 - var_01 getEye();
  var_13 = var_01.var_1D;
  if(common_scripts\utility::func_562E(var_07)) {
    var_01 = self;
    var_01 method_81E2(var_11, "tag_player");
  } else {
    if(isDefined(var_11.var_1D)) {
      var_01 setangles(var_11.var_1D, 1);
    } else {
      var_01 setangles((0, 0, 0), 1);
    }

    var_01 setorigin(var_12, 1);
    var_01 playerlinkto(var_11, "tag_player", 1, 0, 0, 0, 0, 1);
  }

  var_11 moveto(var_10.var_116, var_04, 0, var_0B);
  var_01 childthread do_fade_in_and_out(var_04, var_09, var_0A);
  if(!common_scripts\utility::func_562E(var_01.incinematicmode)) {
    var_01 childthread lib_0547::set_player_cinematic_mode(!common_scripts\utility::func_562E(var_07));
  }

  wait_for_move_done(var_04, var_03, var_0A, var_09);
  if(var_08) {
    var_01 lib_0547::unset_player_cinematic_mode(!common_scripts\utility::func_562E(var_07));
    if(!common_scripts\utility::func_562E(var_07)) {
      var_01 setangles(var_13);
    }

    var_01 childthread animscripts\notetracks_common::do_fade_from_black(var_0A);
  }
}

wait_for_move_done(param_00, param_01, param_02, param_03) {
  var_04 = self;
  var_04 endon("disconnect");
  wait(param_00 + param_01 - param_02 + param_03);
}

do_fade_in_and_out(param_00, param_01, param_02) {
  var_03 = self;
  var_03 notify("new_intro_fade");
  var_03 endon("new_intro_fade");
  var_03 childthread animscripts\notetracks_common::do_fade_from_black(param_02);
  wait(param_00 - param_02);
  var_03 childthread animscripts\notetracks_common::func_30B4(param_01);
}

outro_zombie_taunt(param_00) {
  self endon("death");
  self scragentsetscripted(1);
  maps\mp\agents\_scripted_agent_anim_util::func_8732(1, "cinematic taunt");
  var_01 = maps\mp\agents\_scripted_agent_anim_util::func_7A35("board_taunt_base");
  if(isDefined(param_00)) {
    for(var_02 = 0; var_02 < param_00; var_02++) {
      maps\mp\agents\_scripted_agent_anim_util::func_71FA("board_taunt_base", var_01, 1, "taunt_anim");
    }
  } else {
    maps\mp\agents\_scripted_agent_anim_util::func_71FA("board_taunt_base", var_01, 1, "taunt_anim");
  }

  maps\mp\agents\_scripted_agent_anim_util::func_8732(0, "cinematic taunt");
  self scragentsetscripted(0);
}

add_difficulty_setting(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(!isDefined(level.zmb_sg_difficulty_settings)) {
    level.zmb_sg_difficulty_settings = [];
  }

  if(!isDefined(level.zmb_sg_difficulty_settings_debugname)) {
    level.zmb_sg_difficulty_settings_debugname = [];
  }

  level.zmb_sg_difficulty_settings_debugname[param_01] = param_00;
  var_08 = 4;
  level.zmb_sg_difficulty_settings[param_01] = [];
  if(!isDefined(param_04)) {
    param_04 = 1;
  }

  if(!isDefined(param_05)) {
    param_05 = 1;
  }

  if(isarray(param_02)) {
    if(param_02.size < var_08) {
      var_09 = param_02.size;
      for(var_0A = var_09; var_0A < var_08; var_0A++) {
        param_02[var_0A] = param_02[var_09 - 1];
      }
    }

    for(var_0B = 0; var_0B < 5; var_0B++) {
      var_0C = [];
      for(var_0D = 0; var_0D < param_02.size; var_0D++) {
        var_0E = param_02[var_0D] * return_high_round_modifier(param_04, param_05, var_0B);
        var_0C[var_0C.size] = var_0E;
      }

      level.zmb_sg_difficulty_settings[param_01][var_0B] = var_0C;
    }

    return;
  }

  if(isDefined(var_0C)) {
    level.zmb_sg_difficulty_settings[param_05] = spawnStruct();
    level.zmb_sg_difficulty_settings[param_05].minval = param_06;
    level.zmb_sg_difficulty_settings[param_05].maxval = param_07;
    level.zmb_sg_difficulty_settings[param_05].var_3F02 = var_0C;
    level.zmb_sg_difficulty_settings[param_05].var_6E5C = var_0D;
    level.zmb_sg_difficulty_settings[param_05].low_round_mult = var_08;
    level.zmb_sg_difficulty_settings[param_05].high_round_mult = var_0B;
    return;
  }

  var_0B = 0;
  while(var_0C < 5) {
    for(var_0D = 0; var_0D < var_0B; var_0D++) {
      var_0E = get_player_frac(var_0D + 1);
      var_0F = lerp(param_03, param_04, var_0E);
      var_0F = var_0F * return_high_round_modifier(param_05, param_06, var_0C);
      level.zmb_sg_difficulty_settings[param_02][var_0C][var_0D] = var_0F;
    }

    var_0C++;
  }
}

add_player_level_setting(param_00, param_01, param_02) {
  if(!isDefined(level.zmb_sg_player_rank_modifiers[param_01])) {
    level.zmb_sg_player_rank_modifiers[param_01] = [];
  }

  if(!isDefined(level.zmb_sg_player_rank_modifier_debug_names)) {
    level.zmb_sg_player_rank_modifier_debug_names = [];
  }

  level.zmb_sg_player_rank_modifier_debug_names[param_01] = param_00;
  for(var_03 = 0; var_03 < param_02.size - 1; var_03 = var_03 + 2) {
    var_04 = spawnStruct();
    var_04.var_627D = param_02[var_03 + 1];
    var_04.min_level = param_02[var_03];
    level.zmb_sg_player_rank_modifiers[param_01] = common_scripts\utility::func_F6F(level.zmb_sg_player_rank_modifiers[param_01], var_04);
  }
}

get_player_level_setting(param_00, param_01) {
  var_02 = get_current_team_level();
  var_03 = get_player_level_percentage(var_02);
  if(common_scripts\utility::func_562E(level.zmb_red_skull_mode_activated)) {
    var_03 = 200;
  }

  var_04 = level.zmb_sg_player_rank_modifiers[param_00][0];
  foreach(var_06 in level.zmb_sg_player_rank_modifiers[param_00]) {
    if(var_03 >= var_06.min_level) {
      var_04 = var_06;
    }
  }

  return var_04.var_627D;
}

get_player_level_percentage(param_00) {
  return int(100 * param_00 / level.zmshotgunmaxlevel);
}

get_current_team_level() {
  var_00 = 0;
  foreach(var_02 in level.var_744A) {
    var_00 = var_00 + int(var_02 maps\mp\zombies\_zombies_progression::get_zm_shotgun_player_level());
  }

  var_00 = var_00 / level.var_744A.size;
  return var_00;
}

return_high_round_modifier(param_00, param_01, param_02) {
  if(param_02 >= 2) {
    var_03 = 1;
  } else {
    var_03 = var_03 / 3;
  }

  return lerp(param_00, param_01, var_03);
}

get_difficulty_setting(param_00, param_01, param_02, param_03) {
  if(!isDefined(level.zmb_sg_difficulty_settings)) {
    return undefined;
  }

  var_04 = level.zmb_sg_difficulty_settings[param_00];
  var_05 = undefined;
  var_06 = 1;
  if(isDefined(level.var_744A) && level.var_744A.size > 0) {
    var_06 = level.var_744A.size;
  }

  var_07 = level.objectivescompleted;
  if(common_scripts\utility::func_562E(level.zmb_red_skull_mode_activated)) {
    var_07 = var_07 + 1;
  }

  var_08 = 4;
  if(var_07 > var_08) {
    var_07 = var_08;
  }

  if(isDefined(var_04)) {
    if(isarray(var_04)) {
      var_05 = var_04[var_07][var_06 - 1];
    } else {
      var_09 = lerp(var_04.minval, var_04.maxval, get_player_frac(var_06 - 1));
      var_05 = var_09 * [[var_04.var_3F02]](var_04.var_6E5C);
      var_05 = var_05 * return_high_round_modifier(var_04.low_round_mult, var_04.high_round_mult, var_07);
    }
  }

  if(var_05 < 1 && var_05 > 0) {
    return var_05;
  }

  return int(var_05);
}

func_7F2C(param_00, param_01) {
  if(param_01 == 0) {
    return param_00;
  }

  var_02 = abs(param_00) % param_01;
  if(var_02 == 0) {
    return param_00;
  }

  if(param_00 < 0) {
    return -1 * abs(param_00) - var_02;
  }

  return param_00 + param_01 - var_02;
}

get_player_frac(param_00) {
  var_01 = 4;
  return param_00 - 1 / var_01 - 1;
}

current_fodder_zombie_health(param_00) {
  if(level.var_A980 < param_00) {
    var_01 = param_00;
  } else {
    var_01 = level.var_A980;
  }

  return maps\mp\gametypes\zombies::func_1E59(lib_0547::func_A51("zombie_generic"), var_01);
}

altered_state_init() {}

altered_state_apply(param_00, param_01, param_02) {
  var_03 = self;
  level endon("game_ended");
  var_03 endon("disconnect");
  var_03 endon("death");
  if(common_scripts\utility::func_562E(var_03.in_altered_state)) {
    return;
  }

  var_03 altered_state_fade();
  if(!isDefined(param_01)) {
    param_01 = 30;
  }

  var_03.in_altered_state = 1;
  var_03 notify("altered_state_start");
  var_04 = lib_0547::is_zm_shattered_thule_map();
  var_05 = lib_0547::is_zm_shattered_dnk_map();
  var_06 = "dlc_zmb_dig02_hallucination_01";
  if(level.var_258F) {
    if(lib_0547::func_5565(param_02, 1)) {
      var_06 = "dlc_zmb_dig02_hallucination_01";
    } else if(lib_0547::func_5565(param_02, 2)) {
      var_06 = "dlc_zmb_dig02_hallucination_02";
    } else if(lib_0547::func_5565(param_02, 3)) {
      var_06 = "dlc_zmb_dig02_hallucination_03";
    }
  }

  var_03.altered_state_fx = spawnlinkedfxforclient(common_scripts\utility::func_44F5(var_06), var_03, "tag_origin", var_03);
  triggerfx(var_03.altered_state_fx);
  var_03 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_03.altered_state_fx);
  var_03 lib_0378::func_8D74("dlc3_altered_state_apply", param_02, "altered_state_end");
  var_03 setscriptmotionblurparams(10.5, 0.1, 0.25);
  var_03 childthread altered_state_set_fov();
  var_03 thread altered_state_death_listener();
  var_03 childthread altered_state_cleanup_listener();
  if(!common_scripts\utility::func_562E(param_00)) {
    var_03.altered_state_time = param_01;
    while(var_03.altered_state_time > 0) {
      var_03.altered_state_time--;
      wait(1);
    }

    var_03 notify("altered_state_end");
  }
}

altered_state_cycle_shock() {
  var_00 = self;
  var_00 endon("altered_state_end");
  var_00 endon("disconnect");
  var_01 = 2;
  for(;;) {
    wait(randomintrange(14, 20));
    var_00 shellshock("zm_dig_altered", var_01);
    var_00 method_8036(1.4, 1);
    var_00 common_scripts\utility::func_2CBE(var_01, ::method_8036, 1.4, 1.5);
  }
}

altered_state_set_fov() {
  var_00 = self;
  var_00 method_8036(1.4, 1.5);
}

altered_state_fade() {
  var_00 = self;
  var_00 endon("disconnect");
  if(!isDefined(var_00.altered_state_overlay_fade)) {
    var_00.altered_state_overlay_fade = altered_state_create_client_overlay("white", 1, var_00);
  }

  var_01 = 1;
  var_02 = 0.25;
  var_00.altered_state_overlay_fade.var_18 = 0;
  var_00.altered_state_overlay_fade fadeovertime(var_01);
  var_00.altered_state_overlay_fade.var_18 = 1;
  var_00 lib_0378::func_8D74("dlc3_altered_state_fade");
  wait(var_01);
  var_00.altered_state_overlay_fade.var_18 = 1;
  var_00.altered_state_overlay_fade fadeovertime(var_02);
  var_00.altered_state_overlay_fade.var_18 = 0;
}

altered_state_end_overlay(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  var_02 = lib_0547::is_zm_shattered_thule_map();
  var_03 = lib_0547::is_zm_shattered_dnk_map();
  var_04 = "dlc_zmb_dig02_hallucination_01";
  if(var_02) {} else if(var_03) {}

  if(isDefined(var_01.altered_state_fx)) {
    var_01.altered_state_fx delete();
  }

  var_01 setscriptmotionblurparams(1, 0, 1);
  var_01.in_altered_state = 0;
  var_01 method_8036(1, 1.5);
}

altered_state_cleanup_listener() {
  var_00 = self;
  var_00 endon("death");
  var_00 endon("disconnect");
  var_00 waittill("altered_state_end");
  var_00 altered_state_fade();
  var_00 altered_state_end_overlay(1);
}

altered_state_death_listener() {
  var_00 = self;
  var_00 endon("disconnect");
  var_00 endon("altered_state_end");
  var_00 waittill("death");
  var_00 altered_state_fade();
  var_00 altered_state_end_overlay(0);
}

altered_state_create_client_overlay(param_00, param_01, param_02, param_03) {
  var_04 = 1;
  if(isDefined(param_03)) {
    var_04 = param_03;
  }

  if(isDefined(param_02)) {
    var_05 = newclienthudelem(param_02);
  } else {
    var_05 = newhudelem();
  }

  var_05.maxsightdistsqrd = 0;
  var_05.var_1D7 = 0;
  var_05 setshader(param_00, 640, 480);
  var_05.accuracy = "left";
  var_05.var_11 = "top";
  var_05.ignoreme = 1;
  var_05.var_C6 = "fullscreen";
  var_05.var_1CA = "fullscreen";
  var_05.var_18 = param_01;
  var_05.var_A0 = var_04;
  return var_05;
}

get_berlin_melee_weapons() {
  return ["zom_dlc2_1_zm", "zom_dlc2_3_zm", "zom_dlc2_2_zm"];
}

special_melee_get_weapon_name(param_00) {
  var_01 = undefined;
  if(isDefined(param_00)) {
    switch (param_00) {
      case "bat":
        var_01 = "zom_dlc2_1hc_zm";
        break;

      case "pickaxe":
        var_01 = "zom_dlc2_3hc_zm";
        break;

      case "dagger":
        var_01 = "zom_dlc2_2hc_zm";
        break;

      case "sword":
        var_01 = "zom_dlc2_4_zm";
        break;

      case "bat_casual":
        var_01 = "zom_dlc2_1_zm";
        break;

      case "pickaxe_casual":
        var_01 = "zom_dlc2_3_zm";
        break;

      case "dagger_casual":
        var_01 = "zom_dlc2_2_zm";
        break;

      case "shovel_casual":
        var_01 = "shovel_zm";
        break;
    }
  }

  return var_01;
}

register_banned_objective(param_00) {
  if(!isDefined(level.zmb_sg_banned_objectives)) {
    level.zmb_sg_banned_objectives = [];
  }

  level.zmb_sg_banned_objectives = common_scripts\utility::func_F6F(level.zmb_sg_banned_objectives, param_00);
}

spawn_extra_redskull_assassins(param_00) {
  var_01 = int(get_difficulty_setting("type_boss_health_assassin_red_skull"));
  var_02 = common_scripts\utility::func_46B7("zmb_assassin_spawnpoint_leader_boss_fight", "targetname");
  foreach(var_04 in var_02) {
    var_05 = maps\mp\zombies\sg_events_v1\assassin_squad::spawn_sh_assassin(param_00, var_01, var_04);
    var_05.isfireassassin = 1;
  }
}

try_activate_redskull_mode(param_00) {
  if(common_scripts\utility::func_562E(level.zmb_red_skull_mode_activated)) {
    return 0;
  }

  if(common_scripts\utility::func_562E(param_00) && is_redskull_activation_round()) {
    remove_redskull_mode_activation();
  }

  if(should_activate_redskull_mode(param_00)) {
    maps\mp\zombies\shotgun\_zombies_shotgun_gamemode::activate_redskull_mode();
  }
}

remove_redskull_mode_activation() {
  level.redskull_mode_unavailable = 1;
  level notify("zmb_darkened_path_unavailable");
  remove_redskull_visuals();
}

is_redskull_activation_round() {
  return level.var_A980 == 3;
}

remove_redskull_visuals() {
  if(isDefined(level.shattered_opt_in_ents)) {
    level.shattered_opt_in_ents = common_scripts\utility::func_F97(level.shattered_opt_in_ents);
    level.shattered_opt_in_ents = common_scripts\utility::func_FA0(level.shattered_opt_in_ents);
    foreach(var_01 in level.shattered_opt_in_ents) {
      var_01 delete();
    }
  }
}

not_the_final_objective() {
  return level.objectivescompleted < 2;
}