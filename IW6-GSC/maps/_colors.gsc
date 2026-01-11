/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_colors.gsc
*****************************************************/

init_color_grouping(var_0) {
  common_scripts\utility::flag_init("player_looks_away_from_spawner");
  common_scripts\utility::flag_init("friendly_spawner_locked");
  level.arrays_of_colorcoded_nodes = [];
  level.arrays_of_colorcoded_nodes["axis"] = [];
  level.arrays_of_colorcoded_nodes["allies"] = [];
  level.arrays_of_colorcoded_volumes = [];
  level.arrays_of_colorcoded_volumes["axis"] = [];
  level.arrays_of_colorcoded_volumes["allies"] = [];
  var_1 = [];
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("trigger_multiple", "code_classname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("trigger_radius", "code_classname"));
  var_1 = common_scripts\utility::array_combine(var_1, getEntArray("trigger_once", "code_classname"));
  level.color_teams = [];
  level.color_teams["allies"] = "allies";
  level.color_teams["axis"] = "axis";
  level.color_teams["team3"] = "axis";
  level.color_teams["neutral"] = "neutral";
  var_2 = getEntArray("info_volume", "code_classname");

  foreach(var_4 in var_0) {
    if(isDefined(var_4.script_color_allies)) {
      var_4 add_node_to_global_arrays(var_4.script_color_allies, "allies");
    }

    if(isDefined(var_4.script_color_axis)) {
      var_4 add_node_to_global_arrays(var_4.script_color_axis, "axis");
    }
  }

  foreach(var_7 in var_2) {
    if(isDefined(var_7.script_color_allies)) {
      var_7 add_volume_to_global_arrays(var_7.script_color_allies, "allies");
    }

    if(isDefined(var_7.script_color_axis)) {
      var_7 add_volume_to_global_arrays(var_7.script_color_axis, "axis");
    }
  }

  foreach(var_10 in var_1) {
    if(isDefined(var_10.script_color_allies)) {
      var_10 thread trigger_issues_orders(var_10.script_color_allies, "allies");
    }

    if(isDefined(var_10.script_color_axis)) {
      var_10 thread trigger_issues_orders(var_10.script_color_axis, "axis");
    }
  }

  level.color_node_type_function = [];
  add_cover_node("BAD NODE");
  add_cover_node("Cover Stand");
  add_cover_node("Cover Crouch");
  add_cover_node("Cover Prone");
  add_cover_node("Cover Crouch Window");
  add_cover_node("Cover Right");
  add_cover_node("Cover Left");
  add_cover_node("Cover Wide Left");
  add_cover_node("Cover Wide Right");
  add_cover_node("Cover Multi");
  add_cover_node("Conceal Stand");
  add_cover_node("Conceal Crouch");
  add_cover_node("Conceal Prone");
  add_cover_node("Reacquire");
  add_cover_node("Balcony");
  add_cover_node("Scripted");
  add_cover_node("Begin");
  add_cover_node("End");
  add_cover_node("Turret");
  add_path_node("Ambush");
  add_path_node("Guard");
  add_path_node("Path");
  add_path_node("Exposed");
  level.colorlist = [];
  level.colorlist[level.colorlist.size] = "r";
  level.colorlist[level.colorlist.size] = "b";
  level.colorlist[level.colorlist.size] = "y";
  level.colorlist[level.colorlist.size] = "c";
  level.colorlist[level.colorlist.size] = "g";
  level.colorlist[level.colorlist.size] = "p";
  level.colorlist[level.colorlist.size] = "o";
  level.colorchecklist["red"] = "r";
  level.colorchecklist["r"] = "r";
  level.colorchecklist["blue"] = "b";
  level.colorchecklist["b"] = "b";
  level.colorchecklist["yellow"] = "y";
  level.colorchecklist["y"] = "y";
  level.colorchecklist["cyan"] = "c";
  level.colorchecklist["c"] = "c";
  level.colorchecklist["green"] = "g";
  level.colorchecklist["g"] = "g";
  level.colorchecklist["purple"] = "p";
  level.colorchecklist["p"] = "p";
  level.colorchecklist["orange"] = "o";
  level.colorchecklist["o"] = "o";
  level.currentcolorforced = [];
  level.currentcolorforced["allies"] = [];
  level.currentcolorforced["axis"] = [];
  level.lastcolorforced = [];
  level.lastcolorforced["allies"] = [];
  level.lastcolorforced["axis"] = [];

  foreach(var_13 in level.colorlist) {
    level.arrays_of_colorforced_ai["allies"][var_13] = [];
    level.arrays_of_colorforced_ai["axis"][var_13] = [];
    level.currentcolorforced["allies"][var_13] = undefined;
    level.currentcolorforced["axis"][var_13] = undefined;
  }

  thread player_color_node();
  var_15 = getspawnerteamarray("allies");
  level._color_friendly_spawners = [];

  foreach(var_17 in var_15) {
    level._color_friendly_spawners[var_17.classname] = var_17;
  }
}

convert_color_to_short_string() {
  self.script_forcecolor = level.colorchecklist[self.script_forcecolor];
}

ai_picks_destination(var_0) {
  if(isDefined(self.script_forcecolor)) {
    convert_color_to_short_string();
    self.currentcolorcode = var_0;
    var_1 = self.script_forcecolor;
    level.arrays_of_colorforced_ai[get_team()][var_1] = common_scripts\utility::array_add(level.arrays_of_colorforced_ai[get_team()][var_1], self);
    thread goto_current_colorindex();
    return;
  }
}

goto_current_colorindex() {
  if(!isDefined(self.currentcolorcode)) {
    return;
  }
  var_0 = level.arrays_of_colorcoded_nodes[get_team()][self.currentcolorcode];
  left_color_node();

  if(!isalive(self)) {
    return;
  }
  if(!maps\_utility::has_color()) {
    return;
  }
  if(!isDefined(var_0)) {
    var_1 = level.arrays_of_colorcoded_volumes[get_team()][self.currentcolorcode];
    send_ai_to_colorvolume(var_1, self.currentcolorcode);
    return;
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(isalive(var_3.color_user) && !isplayer(var_3.color_user)) {
      continue;
    }
    thread ai_sets_goal_with_delay(var_3);
    thread decrementcolorusers(var_3);
    return;
  }

  no_node_to_go_to();
}

no_node_to_go_to() {}

get_color_list() {
  var_0 = [];
  var_0[var_0.size] = "r";
  var_0[var_0.size] = "b";
  var_0[var_0.size] = "y";
  var_0[var_0.size] = "c";
  var_0[var_0.size] = "g";
  var_0[var_0.size] = "p";
  var_0[var_0.size] = "o";
  return var_0;
}

array_remove_dupes(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_1[var_3] = 1;
  }

  var_5 = [];

  foreach(var_8, var_7 in var_1) {
    var_5[var_5.size] = var_8;
  }

  return var_5;
}

get_colorcodes_from_trigger(var_0, var_1) {
  return get_colorcodes(var_0, var_1);
}

get_colorcodes(var_0, var_1) {
  var_2 = strtok(var_0, " ");
  var_2 = array_remove_dupes(var_2);
  var_3 = [];
  var_4 = [];
  var_5 = [];
  var_6 = get_color_list();

  foreach(var_8 in var_2) {
    var_9 = undefined;

    foreach(var_9 in var_6) {
      if(issubstr(var_8, var_9)) {
        break;
      }
    }

    if(!colorcode_is_used_in_map(var_1, var_8)) {
      continue;
    }
    var_4[var_9] = var_8;
    var_3[var_3.size] = var_9;
    var_5[var_5.size] = var_8;
  }

  var_2 = var_5;
  var_13 = [];
  var_13["colorCodes"] = var_2;
  var_13["colorCodesByColorIndex"] = var_4;
  var_13["colors"] = var_3;
  return var_13;
}

colorcode_is_used_in_map(var_0, var_1) {
  if(isDefined(level.arrays_of_colorcoded_nodes[var_0][var_1])) {
    return 1;
  }

  return isDefined(level.arrays_of_colorcoded_volumes[var_0][var_1]);
}

trigger_issues_orders(var_0, var_1) {
  var_2 = get_colorcodes_from_trigger(var_0, var_1);
  var_3 = var_2["colorCodes"];
  var_4 = var_2["colorCodesByColorIndex"];
  var_5 = var_2["colors"];
  var_0 = undefined;
  self endon("death");

  for(;;) {
    self waittill("trigger");

    if(isDefined(self.activated_color_trigger)) {
      self.activated_color_trigger = undefined;
      continue;
    }

    activate_color_trigger_internal(var_3, var_5, var_1, var_4);

    if(isDefined(self.script_oneway) && self.script_oneway) {
      thread trigger_delete_target_chain();
    }
  }
}

trigger_delete_target_chain() {
  var_0 = [];
  var_1 = self;

  while(isDefined(var_1)) {
    var_0[var_0.size] = var_1;

    if(!isDefined(var_1.targetname)) {
      break;
    }

    var_2 = getEntArray(var_1.targetname, "target");
    var_1 = undefined;

    foreach(var_4 in var_2) {
      if(!isDefined(var_4.script_color_allies) && !isDefined(var_4.script_color_axis)) {
        continue;
      }
      var_1 = var_4;
    }
  }

  maps\_utility::array_delete(var_0);
}

activate_color_trigger(var_0) {
  if(var_0 == "allies") {
    thread get_colorcodes_and_activate_trigger(self.script_color_allies, var_0);
  } else {
    thread get_colorcodes_and_activate_trigger(self.script_color_axis, var_0);
  }
}

get_colorcodes_and_activate_trigger(var_0, var_1) {
  var_2 = get_colorcodes_from_trigger(var_0, var_1);
  var_3 = var_2["colorCodes"];
  var_4 = var_2["colorCodesByColorIndex"];
  var_5 = var_2["colors"];
  activate_color_trigger_internal(var_3, var_5, var_1, var_4);
}

activate_color_trigger_internal(var_0, var_1, var_2, var_3) {
  return activate_color_code_internal(var_0, var_1, var_2, var_3);
}

activate_color_code_internal(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    if(!isDefined(level.arrays_of_colorcoded_spawners[var_2][var_0[var_4]])) {
      continue;
    }
    level.arrays_of_colorcoded_spawners[var_2][var_0[var_4]] = common_scripts\utility::array_removeundefined(level.arrays_of_colorcoded_spawners[var_2][var_0[var_4]]);

    for(var_5 = 0; var_5 < level.arrays_of_colorcoded_spawners[var_2][var_0[var_4]].size; var_5++) {
      level.arrays_of_colorcoded_spawners[var_2][var_0[var_4]][var_5].currentcolorcode = var_0[var_4];
    }
  }

  foreach(var_7 in var_1) {
    level.arrays_of_colorforced_ai[var_2][var_7] = maps\_utility::array_removedead(level.arrays_of_colorforced_ai[var_2][var_7]);
    level.lastcolorforced[var_2][var_7] = level.currentcolorforced[var_2][var_7];
    level.currentcolorforced[var_2][var_7] = var_3[var_7];
  }

  var_11 = [];

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    if(same_color_code_as_last_time(var_2, var_1[var_4])) {
      continue;
    }
    var_12 = var_0[var_4];

    if(!isDefined(level.arrays_of_colorcoded_ai[var_2][var_12])) {
      continue;
    }
    var_11[var_12] = issue_leave_node_order_to_ai_and_get_ai(var_12, var_1[var_4], var_2);
  }

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_12 = var_0[var_4];

    if(!isDefined(var_11[var_12])) {
      continue;
    }
    if(same_color_code_as_last_time(var_2, var_1[var_4])) {
      continue;
    }
    if(!isDefined(level.arrays_of_colorcoded_ai[var_2][var_12])) {
      continue;
    }
    issue_color_order_to_ai(var_12, var_1[var_4], var_2, var_11[var_12]);
  }
}

same_color_code_as_last_time(var_0, var_1) {
  if(!isDefined(level.lastcolorforced[var_0][var_1])) {
    return 0;
  }

  return level.lastcolorforced[var_0][var_1] == level.currentcolorforced[var_0][var_1];
}

process_cover_node_with_last_in_mind_allies(var_0, var_1) {
  if(issubstr(var_0.script_color_allies, var_1)) {
    self.cover_nodes_last[self.cover_nodes_last.size] = var_0;
  } else {
    self.cover_nodes_first[self.cover_nodes_first.size] = var_0;
  }
}

process_cover_node_with_last_in_mind_axis(var_0, var_1) {
  if(issubstr(var_0.script_color_axis, var_1)) {
    self.cover_nodes_last[self.cover_nodes_last.size] = var_0;
  } else {
    self.cover_nodes_first[self.cover_nodes_first.size] = var_0;
  }
}

process_cover_node(var_0, var_1) {
  self.cover_nodes_first[self.cover_nodes_first.size] = var_0;
}

process_path_node(var_0, var_1) {
  self.path_nodes[self.path_nodes.size] = var_0;
}

prioritize_colorcoded_nodes(var_0, var_1, var_2) {
  var_3 = level.arrays_of_colorcoded_nodes[var_0][var_1];
  var_4 = spawnStruct();
  var_4.path_nodes = [];
  var_4.cover_nodes_first = [];
  var_4.cover_nodes_last = [];
  var_5 = isDefined(level.lastcolorforced[var_0][var_2]);

  for(var_6 = 0; var_6 < var_3.size; var_6++) {
    var_7 = var_3[var_6];
    var_4[[level.color_node_type_function[var_7.type][var_5][var_0]]](var_7, level.lastcolorforced[var_0][var_2]);
  }

  var_4.cover_nodes_first = common_scripts\utility::array_randomize(var_4.cover_nodes_first);
  var_8 = [];
  var_3 = [];

  foreach(var_10, var_7 in var_4.cover_nodes_first) {
    if(isDefined(var_7.script_colorlast)) {
      var_8[var_8.size] = var_7;
      var_3[var_10] = undefined;
      continue;
    }

    var_3[var_3.size] = var_7;
  }

  for(var_6 = 0; var_6 < var_4.cover_nodes_last.size; var_6++) {
    var_3[var_3.size] = var_4.cover_nodes_last[var_6];
  }

  for(var_6 = 0; var_6 < var_4.path_nodes.size; var_6++) {
    var_3[var_3.size] = var_4.path_nodes[var_6];
  }

  foreach(var_7 in var_8) {
    var_3[var_3.size] = var_7;
  }

  level.arrays_of_colorcoded_nodes[var_0][var_1] = var_3;
}

get_prioritized_colorcoded_nodes(var_0, var_1, var_2) {
  return level.arrays_of_colorcoded_nodes[var_0][var_1];
}

get_colorcoded_volume(var_0, var_1) {
  return level.arrays_of_colorcoded_volumes[var_0][var_1];
}

issue_leave_node_order_to_ai_and_get_ai(var_0, var_1, var_2) {
  level.arrays_of_colorcoded_ai[var_2][var_0] = maps\_utility::array_removedead(level.arrays_of_colorcoded_ai[var_2][var_0]);
  var_3 = level.arrays_of_colorcoded_ai[var_2][var_0];
  var_3 = common_scripts\utility::array_combine(var_3, level.arrays_of_colorforced_ai[var_2][var_1]);
  var_4 = [];

  foreach(var_6 in var_3) {
    if(isDefined(var_6.currentcolorcode) && var_6.currentcolorcode == var_0) {
      continue;
    }
    var_4[var_4.size] = var_6;
  }

  var_3 = var_4;

  if(!var_3.size) {
    return;
  }
  common_scripts\utility::array_thread(var_3, ::left_color_node);
  return var_3;
}

send_ai_to_colorvolume(var_0, var_1) {
  self notify("stop_color_move");
  self.currentcolorcode = var_1;

  if(isDefined(var_0.target)) {
    var_2 = getnode(var_0.target, "targetname");

    if(isDefined(var_2)) {
      self setgoalnode(var_2);
    }
  }

  self.fixednode = 0;
  self setgoalvolumeauto(var_0);
}

issue_color_order_to_ai(var_0, var_1, var_2, var_3) {
  var_4 = var_3;
  var_5 = [];

  if(isDefined(level.arrays_of_colorcoded_nodes[var_2][var_0])) {
    prioritize_colorcoded_nodes(var_2, var_0, var_1);
    var_5 = get_prioritized_colorcoded_nodes(var_2, var_0, var_1);
  } else {
    var_6 = get_colorcoded_volume(var_2, var_0);
    common_scripts\utility::array_thread(var_3, ::send_ai_to_colorvolume, var_6, var_0);
  }

  var_7 = 0;
  var_8 = var_3.size;

  for(var_9 = 0; var_9 < var_5.size; var_9++) {
    var_10 = var_5[var_9];

    if(isalive(var_10.color_user)) {
      continue;
    }
    var_11 = common_scripts\utility::getclosest(var_10.origin, var_3);
    var_3 = common_scripts\utility::array_remove(var_3, var_11);
    var_11 take_color_node(var_10, var_0, self, var_7);
    var_7++;

    if(!var_3.size) {
      return;
    }
  }
}

take_color_node(var_0, var_1, var_2, var_3) {
  self notify("stop_color_move");
  self.currentcolorcode = var_1;
  thread process_color_order_to_ai(var_0, var_2, var_3);
}

player_color_node() {
  for(;;) {
    var_0 = undefined;

    if(!isDefined(level.player.node)) {
      wait 0.05;
      continue;
    }

    var_1 = level.player.node.color_user;
    var_0 = level.player.node;
    var_0.color_user = level.player;

    for(;;) {
      if(!isDefined(level.player.node)) {
        break;
      }

      if(level.player.node != var_0) {
        break;
      }

      wait 0.05;
    }

    var_0.color_user = undefined;
    var_0 color_node_finds_a_user();
  }
}

color_node_finds_a_user() {
  if(isDefined(self.script_color_allies)) {
    color_node_finds_user_from_colorcodes(self.script_color_allies, "allies");
  }

  if(isDefined(self.script_color_axis)) {
    color_node_finds_user_from_colorcodes(self.script_color_axis, "axis");
  }
}

color_node_finds_user_from_colorcodes(var_0, var_1) {
  if(isDefined(self.color_user)) {
    return;
  }
  var_2 = strtok(var_0, " ");
  var_2 = array_remove_dupes(var_2);
  common_scripts\utility::array_levelthread(var_2, ::color_node_finds_user_for_colorcode, var_1);
}

color_node_finds_user_for_colorcode(var_0, var_1) {
  var_2 = var_0[0];

  if(!isDefined(level.currentcolorforced[var_1][var_2])) {
    return;
  }
  if(level.currentcolorforced[var_1][var_2] != var_0) {
    return;
  }
  var_3 = maps\_utility::get_force_color_guys(var_1, var_2);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_3[var_4];

    if(var_5 occupies_colorcode(var_0)) {
      continue;
    }
    var_5 take_color_node(self, var_0);
    return;
  }
}

occupies_colorcode(var_0) {
  if(!isDefined(self.currentcolorcode)) {
    return 0;
  }

  return self.currentcolorcode == var_0;
}

ai_sets_goal_with_delay(var_0) {
  self endon("death");
  self endon("stop_color_move");
  my_current_node_delays();
  thread ai_sets_goal(var_0);
}

ai_sets_goal(var_0) {
  self notify("stop_going_to_node");
  set_goal_and_volume(var_0);
  var_1 = level.arrays_of_colorcoded_volumes[get_team()][self.currentcolorcode];

  if(isDefined(self.script_careful)) {
    thread careful_logic(var_0, var_1);
  }
}

set_goal_and_volume(var_0) {
  if(isDefined(self.colornode_func)) {
    self thread[[self.colornode_func]](var_0);
  }

  if(isDefined(self._colors_go_line)) {
    thread maps\_anim::anim_single_queue(self, self._colors_go_line);
    self._colors_go_line = undefined;
  }

  if(isDefined(self.colornode_setgoal_func)) {
    self thread[[self.colornode_setgoal_func]](var_0);
  } else {
    self setgoalnode(var_0);
  }

  if(is_using_forcegoal_radius(var_0)) {
    thread forcegoal_radius(var_0);
  } else if(isDefined(var_0.radius) && var_0.radius > 0) {
    self.goalradius = var_0.radius;
  }

  var_1 = level.arrays_of_colorcoded_volumes[get_team()][self.currentcolorcode];

  if(isDefined(var_1)) {
    self setfixednodesafevolume(var_1);
  } else {
    self clearfixednodesafevolume();
  }

  if(isDefined(var_0.fixednodesaferadius)) {
    self.fixednodesaferadius = var_0.fixednodesaferadius;
  } else if(isDefined(level.fixednodesaferadius_default)) {
    self.fixednodesaferadius = level.fixednodesaferadius_default;
  } else {
    self.fixednodesaferadius = 64;
  }
}

is_using_forcegoal_radius(var_0) {
  if(!isDefined(self.script_forcegoal)) {
    return 0;
  }

  if(!self.script_forcegoal) {
    return 0;
  }

  if(!isDefined(var_0.fixednodesaferadius)) {
    return 0;
  }

  if(self.fixednode) {
    return 0;
  } else {
    return 1;
  }
}

forcegoal_radius(var_0) {
  self endon("death");
  self endon("stop_going_to_node");
  self.goalradius = var_0.fixednodesaferadius;
  common_scripts\utility::waittill_either("goal", "damage");

  if(isDefined(var_0.radius) && var_0.radius > 0) {
    self.goalradius = var_0.radius;
  }
}

careful_logic(var_0, var_1) {
  self endon("death");
  self endon("stop_being_careful");
  self endon("stop_going_to_node");
  thread recover_from_careful_disable(var_0);

  for(;;) {
    wait_until_an_enemy_is_in_safe_area(var_0, var_1);
    use_big_goal_until_goal_is_safe(var_0, var_1);
    self.fixednode = 1;
    set_goal_and_volume(var_0);
  }
}

recover_from_careful_disable(var_0) {
  self endon("death");
  self endon("stop_going_to_node");
  self waittill("stop_being_careful");
  self.fixednode = 1;
  set_goal_and_volume(var_0);
}

use_big_goal_until_goal_is_safe(var_0, var_1) {
  self setgoalpos(self.origin);
  self.goalradius = 1024;
  self.fixednode = 0;

  if(isDefined(var_1)) {
    for(;;) {
      wait 1;

      if(self isknownenemyinradius(var_0.origin, self.fixednodesaferadius)) {
        continue;
      }
      if(self isknownenemyinvolume(var_1)) {
        continue;
      }
      return;
    }
  } else {
    for(;;) {
      if(!isknownenemyinradius_tmp(var_0.origin, self.fixednodesaferadius)) {
        return;
      }
      wait 1;
    }
  }
}

isknownenemyinradius_tmp(var_0, var_1) {
  var_2 = getaiarray("axis");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(distance2d(var_2[var_3].origin, var_0) < var_1) {
      return 1;
    }
  }

  return 0;
}

wait_until_an_enemy_is_in_safe_area(var_0, var_1) {
  if(isDefined(var_1)) {
    for(;;) {
      if(self isknownenemyinradius(var_0.origin, self.fixednodesaferadius)) {
        return;
      }
      if(self isknownenemyinvolume(var_1)) {
        return;
      }
      wait 1;
    }
  } else {
    for(;;) {
      if(isknownenemyinradius_tmp(var_0.origin, self.fixednodesaferadius)) {
        return;
      }
      wait 1;
    }
  }
}

my_current_node_delays() {
  if(!isDefined(self.node)) {
    return 0;
  }

  if(isDefined(self.script_color_delay_override)) {
    wait(self.script_color_delay_override);
    return 1;
  }

  return self.node maps\_utility::script_delay();
}

process_color_order_to_ai(var_0, var_1, var_2) {
  thread decrementcolorusers(var_0);
  self endon("stop_color_move");
  self endon("death");

  if(isDefined(var_1)) {
    var_1 maps\_utility::script_delay();
  }

  if(!my_current_node_delays()) {
    if(isDefined(var_2)) {
      wait(var_2 * randomfloatrange(0.2, 0.35));
    }
  }

  ai_sets_goal(var_0);
  self.color_ordered_node_assignment = var_0;

  for(;;) {
    self waittill("node_taken", var_3);

    if(isplayer(var_3)) {
      wait 0.05;
    }

    var_0 = get_best_available_new_colored_node();

    if(isDefined(var_0)) {
      if(isalive(self.color_node.color_user) && self.color_node.color_user == self) {
        self.color_node.color_user = undefined;
      }

      self.color_node = var_0;
      var_0.color_user = self;
      ai_sets_goal(var_0);
    }
  }
}

get_best_available_colored_node() {
  var_0 = level.currentcolorforced[get_team()][self.script_forcecolor];
  var_1 = get_prioritized_colorcoded_nodes(get_team(), var_0, self.script_forcecolor);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!isalive(var_1[var_2].color_user)) {
      return var_1[var_2];
    }
  }
}

get_best_available_new_colored_node() {
  var_0 = level.currentcolorforced[get_team()][self.script_forcecolor];
  var_1 = get_prioritized_colorcoded_nodes(get_team(), var_0, self.script_forcecolor);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] == self.color_node) {
      continue;
    }
    if(!isalive(var_1[var_2].color_user)) {
      return var_1[var_2];
    }
  }
}

process_stop_short_of_node(var_0) {
  self endon("stopScript");
  self endon("death");

  if(isDefined(self.node)) {
    return;
  }
  if(distance(var_0.origin, self.origin) < 32) {
    reached_node_but_could_not_claim_it(var_0);
    return;
  }

  var_1 = gettime();
  wait_for_killanimscript_or_time(1);
  var_2 = gettime();

  if(var_2 - var_1 >= 1000) {
    reached_node_but_could_not_claim_it(var_0);
  }
}

wait_for_killanimscript_or_time(var_0) {
  self endon("killanimscript");
  wait(var_0);
}

reached_node_but_could_not_claim_it(var_0) {
  var_1 = getaiarray();
  var_2 = undefined;

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(!isDefined(var_1[var_3].node)) {
      continue;
    }
    if(var_1[var_3].node != var_0) {
      continue;
    }
    var_1[var_3] notify("eject_from_my_node");
    wait 1;
    self notify("eject_from_my_node");
    return 1;
  }

  return 0;
}

decrementcolorusers(var_0) {
  var_0.color_user = self;
  self.color_node = var_0;
  self endon("stop_color_move");
  self waittill("death");
  self.color_node.color_user = undefined;
}

colorislegit(var_0) {
  for(var_1 = 0; var_1 < level.colorlist.size; var_1++) {
    if(var_0 == level.colorlist[var_1]) {
      return 1;
    }
  }

  return 0;
}

add_volume_to_global_arrays(var_0, var_1) {
  var_2 = strtok(var_0, " ");
  var_2 = array_remove_dupes(var_2);

  foreach(var_4 in var_2) {
    level.arrays_of_colorcoded_volumes[var_1][var_4] = self;
    level.arrays_of_colorcoded_ai[var_1][var_4] = [];
    level.arrays_of_colorcoded_spawners[var_1][var_4] = [];
  }
}

add_node_to_global_arrays(var_0, var_1) {
  self.color_user = undefined;
  var_2 = strtok(var_0, " ");
  var_2 = array_remove_dupes(var_2);

  foreach(var_4 in var_2) {
    if(isDefined(level.arrays_of_colorcoded_nodes[var_1]) && isDefined(level.arrays_of_colorcoded_nodes[var_1][var_4])) {
      level.arrays_of_colorcoded_nodes[var_1][var_4] = common_scripts\utility::array_add(level.arrays_of_colorcoded_nodes[var_1][var_4], self);
      continue;
    }

    level.arrays_of_colorcoded_nodes[var_1][var_4][0] = self;
    level.arrays_of_colorcoded_ai[var_1][var_4] = [];
    level.arrays_of_colorcoded_spawners[var_1][var_4] = [];
  }
}

left_color_node() {
  if(!isDefined(self.color_node)) {
    return;
  }
  if(isDefined(self.color_node.color_user) && self.color_node.color_user == self) {
    self.color_node.color_user = undefined;
  }

  self.color_node = undefined;
  self notify("stop_color_move");
}

getcolornumberarray() {
  var_0 = [];

  if(issubstr(self.classname, "axis") || issubstr(self.classname, "enemy") || issubstr(self.classname, "team3")) {
    var_0["team"] = "axis";
    var_0["colorTeam"] = self.script_color_axis;
  }

  if(issubstr(self.classname, "ally") || self.type == "civilian") {
    var_0["team"] = "allies";
    var_0["colorTeam"] = self.script_color_allies;
  }

  if(!isDefined(var_0["colorTeam"])) {
    var_0 = undefined;
  }

  return var_0;
}

removespawnerfromcolornumberarray() {
  var_0 = getcolornumberarray();

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0["team"];
  var_2 = var_0["colorTeam"];
  var_3 = strtok(var_2, " ");
  var_3 = array_remove_dupes(var_3);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    level.arrays_of_colorcoded_spawners[var_1][var_3[var_4]] = common_scripts\utility::array_remove(level.arrays_of_colorcoded_spawners[var_1][var_3[var_4]], self);
  }
}

add_cover_node(var_0) {
  level.color_node_type_function[var_0][1]["allies"] = ::process_cover_node_with_last_in_mind_allies;
  level.color_node_type_function[var_0][1]["axis"] = ::process_cover_node_with_last_in_mind_axis;
  level.color_node_type_function[var_0][0]["allies"] = ::process_cover_node;
  level.color_node_type_function[var_0][0]["axis"] = ::process_cover_node;
}

add_path_node(var_0) {
  level.color_node_type_function[var_0][1]["allies"] = ::process_path_node;
  level.color_node_type_function[var_0][0]["allies"] = ::process_path_node;
  level.color_node_type_function[var_0][1]["axis"] = ::process_path_node;
  level.color_node_type_function[var_0][0]["axis"] = ::process_path_node;
}

colornode_spawn_reinforcement(var_0, var_1) {
  level endon("kill_color_replacements");
  level endon("kill_hidden_reinforcement_waiting");
  var_2 = spawn_hidden_reinforcement(var_0, var_1);

  if(isDefined(level.friendly_startup_thread)) {
    var_2 thread[[level.friendly_startup_thread]]();
  }

  var_2 thread colornode_replace_on_death();
}

colornode_replace_on_death() {
  level endon("kill_color_replacements");
  self endon("_disable_reinforcement");

  if(isDefined(self.replace_on_death)) {
    return;
  }
  self.replace_on_death = 1;
  var_0 = self.classname;
  var_1 = self.script_forcecolor;
  waittillframeend;

  if(isalive(self)) {
    self waittill("death");
  }

  var_2 = level.current_color_order;

  if(!isDefined(self.script_forcecolor)) {
    return;
  }
  thread colornode_spawn_reinforcement(var_0, self.script_forcecolor);

  if(isDefined(self) && isDefined(self.script_forcecolor)) {
    var_1 = self.script_forcecolor;
  }

  if(isDefined(self) && isDefined(self.origin)) {
    var_3 = self.origin;
  }

  for(;;) {
    if(get_color_from_order(var_1, var_2) == "none") {
      return;
    }
    var_4 = maps\_utility::get_force_color_guys("allies", var_2[var_1]);

    if(!isDefined(level.color_doesnt_care_about_heroes)) {
      var_4 = maps\_utility::remove_heroes_from_array(var_4);
    }

    if(!isDefined(level.color_doesnt_care_about_classname)) {
      var_4 = maps\_utility::remove_without_classname(var_4, var_0);
    }

    if(!var_4.size) {
      wait 2;
      continue;
    }

    var_5 = common_scripts\utility::getclosest(level.player.origin, var_4);
    waittillframeend;

    if(!isalive(var_5)) {
      continue;
    }
    var_5 maps\_utility::set_force_color(var_1);

    if(isDefined(level.friendly_promotion_thread)) {
      var_5[[level.friendly_promotion_thread]](var_1);
    }

    var_1 = var_2[var_1];
  }
}

get_color_from_order(var_0, var_1) {
  if(!isDefined(var_0)) {
    return "none";
  }

  if(!isDefined(var_1)) {
    return "none";
  }

  if(!isDefined(var_1[var_0])) {
    return "none";
  }

  return var_1[var_0];
}

friendly_spawner_vision_checker() {
  level.friendly_respawn_vision_checker_thread = 1;
  var_0 = 0;

  for(;;) {
    for(;;) {
      if(!respawn_friendlies_without_vision_check()) {
        break;
      }

      wait 0.05;
    }

    wait 1;

    if(!isDefined(level.respawn_spawner_org)) {
      continue;
    }
    var_1 = level.player.origin - level.respawn_spawner_org;

    if(length(var_1) < 200) {
      player_sees_spawner();
      continue;
    }

    var_2 = anglesToForward((0, level.player getplayerangles()[1], 0));
    var_3 = vectornormalize(var_1);
    var_4 = vectordot(var_2, var_3);

    if(var_4 < 0.2) {
      player_sees_spawner();
      continue;
    }

    var_0++;

    if(var_0 < 3) {
      continue;
    }
    common_scripts\utility::flag_set("player_looks_away_from_spawner");
  }
}

get_color_spawner(var_0) {
  if(isDefined(var_0)) {
    if(!isDefined(level._color_friendly_spawners[var_0])) {
      var_1 = getspawnerteamarray("allies");

      foreach(var_3 in var_1) {
        if(var_3.classname != var_0) {
          continue;
        }
        level._color_friendly_spawners[var_0] = var_3;
        break;
      }
    }
  }

  if(!isDefined(var_0)) {
    var_3 = common_scripts\utility::random(level._color_friendly_spawners);

    if(!isDefined(var_3)) {
      var_1 = [];

      foreach(var_6, var_3 in level._color_friendly_spawners) {
        if(isDefined(var_3)) {
          var_1[var_6] = var_3;
        }
      }

      level._color_friendly_spawners = var_1;
      return common_scripts\utility::random(level._color_friendly_spawners);
    }

    return var_3;
  }

  return level._color_friendly_spawners[var_0];
}

respawn_friendlies_without_vision_check() {
  if(isDefined(level.respawn_friendlies_force_vision_check)) {
    return 0;
  }

  return common_scripts\utility::flag("respawn_friendlies");
}

wait_until_vision_check_satisfied_or_disabled() {
  if(common_scripts\utility::flag("player_looks_away_from_spawner")) {
    return;
  }
  level endon("player_looks_away_from_spawner");

  for(;;) {
    if(respawn_friendlies_without_vision_check()) {
      return;
    }
    wait 0.05;
  }
}

spawn_hidden_reinforcement(var_0, var_1) {
  level endon("kill_color_replacements");
  level endon("kill_hidden_reinforcement_waiting");
  var_2 = undefined;

  for(;;) {
    if(!respawn_friendlies_without_vision_check()) {
      if(!isDefined(level.friendly_respawn_vision_checker_thread)) {
        thread friendly_spawner_vision_checker();
      }

      for(;;) {
        wait_until_vision_check_satisfied_or_disabled();
        common_scripts\utility::flag_waitopen("friendly_spawner_locked");

        if(common_scripts\utility::flag("player_looks_away_from_spawner") || respawn_friendlies_without_vision_check()) {
          break;
        }
      }

      common_scripts\utility::flag_set("friendly_spawner_locked");
    }

    var_3 = get_color_spawner(var_0);
    var_3.count = 1;
    var_4 = var_3.origin;
    var_3.origin = level.respawn_spawner_org;
    var_2 = var_3 stalingradspawn();
    var_3.origin = var_4;

    if(maps\_utility::spawn_failed(var_2)) {
      thread lock_spawner_for_awhile();
      wait 1;
      continue;
    }

    level notify("reinforcement_spawned", var_2);
    break;
  }

  for(;;) {
    if(!isDefined(var_1)) {
      break;
    }

    if(get_color_from_order(var_1, level.current_color_order) == "none") {
      break;
    }

    var_1 = level.current_color_order[var_1];
  }

  if(isDefined(var_1)) {
    var_2 maps\_utility::set_force_color(var_1);
  }

  thread lock_spawner_for_awhile();
  return var_2;
}

lock_spawner_for_awhile() {
  common_scripts\utility::flag_set("friendly_spawner_locked");

  if(isDefined(level.friendly_respawn_lock_func)) {
    [[level.friendly_respawn_lock_func]]();
  } else {
    wait 2;
  }

  common_scripts\utility::flag_clear("friendly_spawner_locked");
}

player_sees_spawner() {
  var_0 = 0;
  common_scripts\utility::flag_clear("player_looks_away_from_spawner");
}

kill_color_replacements() {
  common_scripts\utility::flag_clear("friendly_spawner_locked");
  level notify("kill_color_replacements");
  var_0 = getaiarray();
  common_scripts\utility::array_thread(var_0, ::remove_replace_on_death);
}

remove_replace_on_death() {
  self.replace_on_death = undefined;
}

get_team(var_0) {
  if(isDefined(self.team) && !isDefined(var_0)) {
    var_0 = self.team;
  }

  return level.color_teams[var_0];
}