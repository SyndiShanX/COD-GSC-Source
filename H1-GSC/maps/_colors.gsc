/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_colors.gsc
********************************/

init_color_grouping(var_0) {
  common_scripts\utility::flag_init("player_looks_away_from_spawner");
  common_scripts\utility::flag_init("friendly_spawner_locked");
  level.arrays_of_colorcoded_nodes = [];
  level.arrays_of_colorcoded_nodes["axis"] = [];
  level.arrays_of_colorcoded_nodes["allies"] = [];
  level.colorcoded_volumes = [];
  level.colorcoded_volumes["axis"] = [];
  level.colorcoded_volumes["allies"] = [];
  var_1 = [];
  var_1 = common_scripts\utility::array_combine(var_1, getentarray("trigger_multiple", "classname"));
  var_1 = common_scripts\utility::array_combine(var_1, getentarray("trigger_radius", "classname"));
  var_1 = common_scripts\utility::array_combine(var_1, getentarray("trigger_once", "classname"));
  var_2 = getentarray("info_volume", "classname");

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
    if(isdefined(var_0[var_3].script_color_allies))
      var_0[var_3] add_node_to_global_arrays(var_0[var_3].script_color_allies, "allies");

    if(isdefined(var_0[var_3].script_color_axis))
      var_0[var_3] add_node_to_global_arrays(var_0[var_3].script_color_axis, "axis");
  }

  for (var_3 = 0; var_3 < var_1.size; var_3++) {
    if(isdefined(var_1[var_3].script_color_allies))
      var_1[var_3] thread trigger_issues_orders(var_1[var_3].script_color_allies, "allies");

    if(isdefined(var_1[var_3].script_color_axis))
      var_1[var_3] thread trigger_issues_orders(var_1[var_3].script_color_axis, "axis");
  }

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    if(isdefined(var_2[var_3].script_color_allies))
      var_2[var_3] add_volume_to_global_arrays(var_2[var_3].script_color_allies, "allies");

    if(isdefined(var_2[var_3].script_color_axis))
      var_2[var_3] add_volume_to_global_arrays(var_2[var_3].script_color_allies, "axis");
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
  add_cover_node("Conceal Stand");
  add_cover_node("Conceal Crouch");
  add_cover_node("Conceal Prone");
  add_cover_node("Reacquire");
  add_cover_node("Balcony");
  add_cover_node("Scripted");
  add_cover_node("Begin");
  add_cover_node("End");
  add_cover_node("Turret");
  add_path_node("Guard");
  add_path_node("Path");
  level.colorlist = [];
  level.colorlist[level.colorlist.size] = "r";
  level.colorlist[level.colorlist.size] = "b";
  level.colorlist[level.colorlist.size] = "y";
  level.colorlist[level.colorlist.size] = "c";
  level.colorlist[level.colorlist.size] = "g";
  level.colorlist[level.colorlist.size] = "p";
  level.colorlist[level.colorlist.size] = "o";
  level.colorlist[level.colorlist.size] = "w";
  level.colorlist[level.colorlist.size] = "a";
  level.colorlist[level.colorlist.size] = "l";
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
  level.colorchecklist["white"] = "w";
  level.colorchecklist["w"] = "w";
  level.colorchecklist["aqua"] = "a";
  level.colorchecklist["a"] = "a";
  level.colorchecklist["lime"] = "l";
  level.colorchecklist["l"] = "l";
  level.currentcolorforced = [];
  level.currentcolorforced["allies"] = [];
  level.currentcolorforced["axis"] = [];
  level.lastcolorforced = [];
  level.lastcolorforced["allies"] = [];
  level.lastcolorforced["axis"] = [];

  for (var_3 = 0; var_3 < level.colorlist.size; var_3++) {
    level.arrays_of_colorforced_ai["allies"][level.colorlist[var_3]] = [];
    level.arrays_of_colorforced_ai["axis"][level.colorlist[var_3]] = [];
    level.currentcolorforced["allies"][level.colorlist[var_3]] = undefined;
    level.currentcolorforced["axis"][level.colorlist[var_3]] = undefined;
  }

  thread player_color_node();

  if(getdvar("shownodecolors") == "1")
    thread shownodecolors();
}

convert_color_to_short_string() {
  self.script_forcecolor = level.colorchecklist[self.script_forcecolor];
}

ai_picks_destination(var_0) {
  if(isdefined(self.script_forcecolor)) {
    convert_color_to_short_string();
    self.currentcolorcode = var_0;
    var_1 = self.script_forcecolor;
    level.arrays_of_colorforced_ai[self.team][var_1] = common_scripts\utility::array_add(level.arrays_of_colorforced_ai[self.team][var_1], self);
    thread goto_current_colorindex();
    return;
  }
}

goto_current_colorindex() {
  if(!isdefined(self.currentcolorcode)) {
    return;
  }
  var_0 = level.arrays_of_colorcoded_nodes[self.team][self.currentcolorcode];
  left_color_node();

  if(!isalive(self)) {
    return;
  }
  if(!maps\_utility::has_color()) {
    return;
  }
  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(isalive(var_2.color_user) && var_2.color_user != level.player) {
      continue;
    }
    thread ai_sets_goal_with_delay(var_2);
    thread decrementcolorusers(var_2);
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
  var_0[var_0.size] = "w";
  var_0[var_0.size] = "a";
  var_0[var_0.size] = "l";
  return var_0;
}

get_colorcodes_from_trigger(var_0, var_1) {
  var_2 = strtok(var_0, " ");
  var_3 = [];
  var_4 = [];
  var_5 = [];
  var_6 = get_color_list();

  for (var_7 = 0; var_7 < var_2.size; var_7++) {
    var_8 = undefined;

    for (var_9 = 0; var_9 < var_6.size; var_9++) {
      if(issubstr(var_2[var_7], var_6[var_9])) {
        var_8 = var_6[var_9];
        break;
      }
    }

    if(!isdefined(level.arrays_of_colorcoded_nodes[var_1][var_2[var_7]])) {
      continue;
    }
    var_4[var_8] = var_2[var_7];
    var_3[var_3.size] = var_8;
    var_5[var_5.size] = var_2[var_7];
  }

  var_2 = var_5;
  var_10 = [];
  var_10["colorCodes"] = var_2;
  var_10["colorCodesByColorIndex"] = var_4;
  var_10["colors"] = var_3;
  return var_10;
}

trigger_issues_orders(var_0, var_1) {
  var_2 = get_colorcodes_from_trigger(var_0, var_1);
  var_3 = var_2["colorCodes"];
  var_4 = var_2["colorCodesByColorIndex"];
  var_5 = var_2["colors"];

  for (;;) {
    self waittill("trigger");

    if(isdefined(self.activated_color_trigger)) {
      self.activated_color_trigger = undefined;
      continue;
    }

    activate_color_trigger_internal(var_3, var_5, var_1, var_4);
  }
}

activate_color_trigger(var_0) {
  if(var_0 == "allies")
    thread get_colorcodes_and_activate_trigger(self.script_color_allies, var_0);
  else
    thread get_colorcodes_and_activate_trigger(self.script_color_axis, var_0);
}

get_colorcodes_and_activate_trigger(var_0, var_1) {
  var_2 = get_colorcodes_from_trigger(var_0, var_1);
  var_3 = var_2["colorCodes"];
  var_4 = var_2["colorCodesByColorIndex"];
  var_5 = var_2["colors"];
  activate_color_trigger_internal(var_3, var_5, var_1, var_4);
}

activate_color_trigger_internal(var_0, var_1, var_2, var_3) {
  for (var_4 = 0; var_4 < var_0.size; var_4++) {
    if(!isdefined(level.arrays_of_colorcoded_spawners[var_2][var_0[var_4]])) {
      continue;
    }
    level.arrays_of_colorcoded_spawners[var_2][var_0[var_4]] = common_scripts\utility::array_removeundefined(level.arrays_of_colorcoded_spawners[var_2][var_0[var_4]]);

    for (var_5 = 0; var_5 < level.arrays_of_colorcoded_spawners[var_2][var_0[var_4]].size; var_5++)
      level.arrays_of_colorcoded_spawners[var_2][var_0[var_4]][var_5].currentcolorcode = var_0[var_4];
  }

  for (var_4 = 0; var_4 < var_1.size; var_4++) {
    level.arrays_of_colorforced_ai[var_2][var_1[var_4]] = maps\_utility::array_removedead(level.arrays_of_colorforced_ai[var_2][var_1[var_4]]);
    level.lastcolorforced[var_2][var_1[var_4]] = level.currentcolorforced[var_2][var_1[var_4]];
    level.currentcolorforced[var_2][var_1[var_4]] = var_3[var_1[var_4]];
  }

  var_6 = [];

  for (var_4 = 0; var_4 < var_0.size; var_4++) {
    if(same_color_code_as_last_time(var_2, var_1[var_4])) {
      continue;
    }
    var_7 = var_0[var_4];

    if(!isdefined(level.arrays_of_colorcoded_ai[var_2][var_7])) {
      continue;
    }
    var_6[var_7] = issue_leave_node_order_to_ai_and_get_ai(var_7, var_1[var_4], var_2);
  }

  for (var_4 = 0; var_4 < var_0.size; var_4++) {
    var_7 = var_0[var_4];

    if(!isdefined(var_6[var_7])) {
      continue;
    }
    if(same_color_code_as_last_time(var_2, var_1[var_4])) {
      continue;
    }
    if(!isdefined(level.arrays_of_colorcoded_ai[var_2][var_7])) {
      continue;
    }
    issue_color_order_to_ai(var_7, var_1[var_4], var_2, var_6[var_7]);
  }
}

same_color_code_as_last_time(var_0, var_1) {
  if(!isdefined(level.lastcolorforced[var_0][var_1]))
    return 0;

  return level.lastcolorforced[var_0][var_1] == level.currentcolorforced[var_0][var_1];
}

process_cover_node_with_last_in_mind_allies(var_0, var_1) {
  if(issubstr(var_0.script_color_allies, var_1))
    self.cover_nodes_last[self.cover_nodes_last.size] = var_0;
  else
    self.cover_nodes_first[self.cover_nodes_first.size] = var_0;
}

process_cover_node_with_last_in_mind_axis(var_0, var_1) {
  if(issubstr(var_0.script_color_axis, var_1))
    self.cover_nodes_last[self.cover_nodes_last.size] = var_0;
  else
    self.cover_nodes_first[self.cover_nodes_first.size] = var_0;
}

process_cover_node(var_0, var_1) {
  self.cover_nodes_first[self.cover_nodes_first.size] = var_0;
}

process_path_node(var_0, var_1) {
  self.path_nodes[self.path_nodes.size] = var_0;
}

prioritize_colorcoded_nodes(var_0, var_1, var_2) {
  var_3 = level.arrays_of_colorcoded_nodes[var_0][var_1];
  var_4 = spawnstruct();
  var_4.path_nodes = [];
  var_4.cover_nodes_first = [];
  var_4.cover_nodes_last = [];
  var_5 = isdefined(level.lastcolorforced[var_0][var_2]);

  for (var_6 = 0; var_6 < var_3.size; var_6++) {
    var_7 = var_3[var_6];
    var_4[[level.color_node_type_function[var_7.type][var_5][var_0]]](var_7, level.lastcolorforced[var_0][var_2]);
  }

  var_4.cover_nodes_first = common_scripts\utility::array_randomize(var_4.cover_nodes_first);
  var_3 = var_4.cover_nodes_first;

  for (var_6 = 0; var_6 < var_4.cover_nodes_last.size; var_6++)
    var_3[var_3.size] = var_4.cover_nodes_last[var_6];

  for (var_6 = 0; var_6 < var_4.path_nodes.size; var_6++)
    var_3[var_3.size] = var_4.path_nodes[var_6];

  level.arrays_of_colorcoded_nodes[var_0][var_1] = var_3;
}

get_prioritized_colorcoded_nodes(var_0, var_1, var_2) {
  return level.arrays_of_colorcoded_nodes[var_0][var_1];
}

issue_leave_node_order_to_ai_and_get_ai(var_0, var_1, var_2) {
  level.arrays_of_colorcoded_ai[var_2][var_0] = maps\_utility::array_removedead(level.arrays_of_colorcoded_ai[var_2][var_0]);
  var_3 = level.arrays_of_colorcoded_ai[var_2][var_0];
  var_3 = common_scripts\utility::array_combine(var_3, level.arrays_of_colorforced_ai[var_2][var_1]);
  var_4 = [];

  for (var_5 = 0; var_5 < var_3.size; var_5++) {
    if(isdefined(var_3[var_5].currentcolorcode) && var_3[var_5].currentcolorcode == var_0) {
      continue;
    }
    var_4[var_4.size] = var_3[var_5];
  }

  var_3 = var_4;

  if(!var_3.size) {
    return;
  }
  for (var_5 = 0; var_5 < var_3.size; var_5++)
    var_3[var_5] left_color_node();

  return var_3;
}

issue_color_order_to_ai(var_0, var_1, var_2, var_3) {
  if(!var_3.size) {
    return;
  }
  var_4 = var_3;
  prioritize_colorcoded_nodes(var_2, var_0, var_1);
  var_5 = get_prioritized_colorcoded_nodes(var_2, var_0, var_1);

  if(!var_5.size) {
    return;
  }
  var_6 = maps\_utility::getdvarintdefault("ai_color_squadAssignmentOverride", 0);
  var_7 = var_6 > 0;

  if(var_6 == 0) {
    var_8 = var_3[0] should_assign_nodes_intelligently_for_squad();

    foreach(var_10 in var_3) {
      var_11 = var_10 should_assign_nodes_intelligently_for_squad();

      if(var_11)
        var_7 = 1;
    }

    var_13 = var_5[0] should_assign_nodes_intelligently_for_squad();

    foreach(var_15 in var_5) {
      var_16 = var_15 should_assign_nodes_intelligently_for_squad();

      if(var_16)
        var_7 = 1;
    }
  }

  var_18 = 0;
  var_19 = var_3.size;

  if(var_7) {
    var_18 = 1;
    var_20 = (0, 0, 0);

    foreach(var_15 in var_5)
    var_20 = var_20 + var_15.origin;

    var_20 = var_20 / var_5.size;
    var_23 = (0, 0, 0);

    foreach(var_10 in var_3)
    var_23 = var_23 + var_10.origin;

    var_23 = var_23 / var_3.size;
    var_3 = sortbydistance(var_3, var_20);
    var_5 = sortbydistance(var_5, var_23);
  }

  for (var_26 = 0; var_26 < var_5.size; var_26++) {
    var_15 = var_5[var_26];

    if(isalive(var_15.color_user)) {
      continue;
    }
    var_27 = undefined;
    var_28 = var_18;

    if(var_7) {
      var_27 = var_3[var_3.size - 1];
      var_28 = var_19 - var_18;
    } else
      var_27 = common_scripts\utility::getclosest(var_15.origin, var_3);

    var_3 = common_scripts\utility::array_remove(var_3, var_27);
    var_27 take_color_node(var_15, var_0, self, var_28);
    var_18++;

    if(!var_3.size)
      return;
  }
}

take_color_node(var_0, var_1, var_2, var_3) {
  self notify("stop_color_move");
  self.currentcolorcode = var_1;
  thread process_color_order_to_ai(var_0, var_2, var_3);
}

assign_nodes_intelligently_for_squad(var_0) {
  if(var_0)
    self.script_color_assign_intelligently = 1;
  else
    self.script_color_assign_intelligently = undefined;
}

assign_nodes_intelligently_for_team(var_0, var_1) {
  if(!isdefined(level.team_assign_nodes_intelligently))
    level.team_assign_nodes_intelligently = [];

  level.team_assign_nodes_intelligently[var_0] = var_1;
  var_2 = getaiarray(var_0);

  for (var_3 = 0; var_3 < var_2.size; var_3++)
    var_2[var_3].script_color_assign_intelligently = var_1;
}

setup_nodes_intelligently_from_team() {
  if(!isdefined(level.team_assign_nodes_intelligently)) {
    return;
  }
  if(!isdefined(level.team_assign_nodes_intelligently[self.team])) {
    return;
  }
  self.script_color_assign_intelligently = level.team_assign_nodes_intelligently[self.team];
}

should_assign_nodes_intelligently_for_squad() {
  return isdefined(self.script_color_assign_intelligently) && self.script_color_assign_intelligently;
}

player_color_node() {
  for (;;) {
    var_0 = undefined;

    if(!isdefined(level.player.node)) {
      wait 0.05;
      continue;
    }

    var_1 = level.player.node.color_user;
    var_0 = level.player.node;
    var_0.color_user = level.player;

    for (;;) {
      if(!isdefined(level.player.node)) {
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
  if(isdefined(self.script_color_allies))
    color_node_finds_user_from_colorcodes(self.script_color_allies, "allies");

  if(isdefined(self.script_color_axis))
    color_node_finds_user_from_colorcodes(self.script_color_axis, "axis");
}

color_node_finds_user_from_colorcodes(var_0, var_1) {
  if(isdefined(self.color_user)) {
    return;
  }
  var_2 = strtok(var_0, " ");
  common_scripts\utility::array_levelthread(var_2, ::color_node_finds_user_for_colorcode, var_1);
}

color_node_finds_user_for_colorcode(var_0, var_1) {
  var_2 = var_0[0];

  if(!isdefined(level.currentcolorforced[var_1][var_2])) {
    return;
  }
  if(level.currentcolorforced[var_1][var_2] != var_0) {
    return;
  }
  var_3 = maps\_utility::get_force_color_guys(var_1, var_2);

  if(!var_3.size) {
    return;
  }
  for (var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_3[var_4];

    if(var_5 occupies_colorcode(var_0)) {
      continue;
    }
    var_5 take_color_node(self, var_0);
    return;
  }
}

occupies_colorcode(var_0) {
  if(!isdefined(self.currentcolorcode))
    return 0;

  return self.currentcolorcode == var_0;
}

ai_sets_goal_with_delay(var_0) {
  self endon("death");
  var_1 = my_current_node_delays();

  if(var_1) {
    self endon("stop_color_move");
    wait(var_1);
  }

  thread ai_sets_goal(var_0);
}

ai_sets_goal(var_0) {
  self notify("stop_going_to_node");
  set_goal_and_volume(var_0);
  var_1 = level.colorcoded_volumes[self.team][self.currentcolorcode];

  if(isdefined(self.script_careful))
    thread careful_logic(var_0, var_1);
}

set_goal_and_volume(var_0) {
  if(isdefined(self._colors_go_line)) {
    thread maps\_anim::anim_single_queue(self, self._colors_go_line);
    self._colors_go_line = undefined;
  }

  self setgoalnode(var_0);

  if(!self.fixednode)
    self.goalradius = var_0.radius;
  else if(isdefined(var_0.radius))
    self.goalradius = var_0.radius;

  var_1 = level.colorcoded_volumes[self.team][self.currentcolorcode];

  if(isdefined(var_1))
    self setfixednodesafevolume(var_1);
  else
    self clearfixednodesafevolume();

  if(isdefined(var_0.fixednodesaferadius))
    self.fixednodesaferadius = var_0.fixednodesaferadius;
  else
    self.fixednodesaferadius = 64;
}

careful_logic(var_0, var_1) {
  self endon("death");
  self endon("stop_being_careful");
  self endon("stop_going_to_node");
  thread recover_from_careful_disable(var_0);

  for (;;) {
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

  if(isdefined(var_1)) {
    for (;;) {
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
    for (;;) {
      if(!isknownenemyinradius_tmp(var_0.origin, self.fixednodesaferadius)) {
        return;
      }
      wait 1;
    }
  }
}

isknownenemyinradius_tmp(var_0, var_1) {
  var_2 = getaiarray("axis");

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    if(distance2d(var_2[var_3].origin, var_0) < var_1)
      return 1;
  }

  return 0;
}

wait_until_an_enemy_is_in_safe_area(var_0, var_1) {
  if(isdefined(var_1)) {
    for (;;) {
      if(self isknownenemyinradius(var_0.origin, self.fixednodesaferadius)) {
        return;
      }
      if(self isknownenemyinvolume(var_1)) {
        return;
      }
      wait 1;
    }
  } else {
    for (;;) {
      if(isknownenemyinradius_tmp(var_0.origin, self.fixednodesaferadius)) {
        return;
      }
      wait 1;
    }
  }
}

my_current_node_delays() {
  if(!isdefined(self.node))
    return 0;

  return self.node maps\_utility::script_delay();
}

process_color_order_to_ai(var_0, var_1, var_2) {
  thread decrementcolorusers(var_0);
  self endon("stop_color_move");
  self endon("death");

  if(isdefined(var_1)) {
    var_1 maps\_utility::script_delay();

    if(isdefined(var_1.colordelayinfo)) {
      var_3 = getarraykeys(var_1.colordelayinfo);

      if(common_scripts\utility::array_contains(var_3, self.script_forcecolor))
        wait(var_1.colordelayinfo[self.script_forcecolor]);
    }
  }

  if(!my_current_node_delays()) {
    if(isdefined(var_2))
      wait(var_2 * randomfloatrange(0.2, 0.35));
  }

  ai_sets_goal(var_0);
  self.color_ordered_node_assignment = var_0;

  for (;;) {
    self waittill("node_taken", var_4);

    if(var_4 == level.player)
      wait 0.05;

    var_0 = get_best_available_new_colored_node();

    if(isdefined(var_0)) {
      if(isalive(self.color_node.color_user) && self.color_node.color_user == self)
        self.color_node.color_user = undefined;

      self.color_node = var_0;
      var_0.color_user = self;
      ai_sets_goal(var_0);
    }
  }
}

get_best_available_colored_node() {
  var_0 = level.currentcolorforced[self.team][self.script_forcecolor];
  var_1 = get_prioritized_colorcoded_nodes(self.team, var_0, self.script_forcecolor);

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!isalive(var_1[var_2].color_user))
      return var_1[var_2];
  }
}

get_best_available_new_colored_node() {
  var_0 = level.currentcolorforced[self.team][self.script_forcecolor];
  var_1 = get_prioritized_colorcoded_nodes(self.team, var_0, self.script_forcecolor);

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] == self.color_node) {
      continue;
    }
    if(!isalive(var_1[var_2].color_user))
      return var_1[var_2];
  }
}

process_stop_short_of_node(var_0) {
  self endon("stopScript");
  self endon("death");

  if(isdefined(self.node)) {
    return;
  }
  if(distance(var_0.origin, self.origin) < 32) {
    reached_node_but_could_not_claim_it(var_0);
    return;
  }

  var_1 = gettime();
  wait_for_killanimscript_or_time(1);
  var_2 = gettime();

  if(var_2 - var_1 >= 1000)
    reached_node_but_could_not_claim_it(var_0);
}

wait_for_killanimscript_or_time(var_0) {
  self endon("killanimscript");
  wait(var_0);
}

reached_node_but_could_not_claim_it(var_0) {
  var_1 = getaiarray();
  var_2 = undefined;

  for (var_3 = 0; var_3 < var_1.size; var_3++) {
    if(!isdefined(var_1[var_3].node)) {
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
  for (var_1 = 0; var_1 < level.colorlist.size; var_1++) {
    if(var_0 == level.colorlist[var_1])
      return 1;
  }

  return 0;
}

add_volume_to_global_arrays(var_0, var_1) {
  var_2 = strtok(var_0, " ");

  for (var_3 = 0; var_3 < var_2.size; var_3++)
    level.colorcoded_volumes[var_1][var_2[var_3]] = self;
}

add_node_to_global_arrays(var_0, var_1) {
  self.color_user = undefined;
  var_2 = strtok(var_0, " ");

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    if(isdefined(level.arrays_of_colorcoded_nodes[var_1]) && isdefined(level.arrays_of_colorcoded_nodes[var_1][var_2[var_3]])) {
      level.arrays_of_colorcoded_nodes[var_1][var_2[var_3]] = common_scripts\utility::array_add(level.arrays_of_colorcoded_nodes[var_1][var_2[var_3]], self);
      continue;
    }

    level.arrays_of_colorcoded_nodes[var_1][var_2[var_3]][0] = self;
    level.arrays_of_colorcoded_ai[var_1][var_2[var_3]] = [];
    level.arrays_of_colorcoded_spawners[var_1][var_2[var_3]] = [];
  }
}

shownodecolors() {
  common_scripts\utility::array_thread(getallnodes(), ::nodethink);
}

nodethink() {
  var_0 = "";
  var_1 = "gg-";

  if(isdefined(self.script_color_allies))
    var_0 = self.script_color_allies;
  else if(isdefined(self.script_color_axis)) {
    var_0 = self.script_color_axis;
    var_1 = "bg-";
  }

  if(var_0 == "") {
    return;
  }
  for (;;) {
    var_2 = maps\_utility::get_script_palette();
    var_3 = strtok(var_0, " ");

    if(var_3.size > 1) {

    } else {

    }

    if(randomint(100) > 70) {

    }

    waitframe();
  }
}

left_color_node() {
  if(!isdefined(self.color_node)) {
    return;
  }
  if(isdefined(self.color_node.color_user) && self.color_node.color_user == self)
    self.color_node.color_user = undefined;

  self.color_node = undefined;
  self notify("stop_color_move");
}

getcolornumberarray() {
  var_0 = [];

  if(issubstr(self.classname, "axis") || issubstr(self.classname, "enemy")) {
    var_0["team"] = "axis";
    var_0["colorTeam"] = self.script_color_axis;
  }

  if(issubstr(self.classname, "ally") || issubstr(self.classname, "civilian")) {
    var_0["team"] = "allies";
    var_0["colorTeam"] = self.script_color_allies;
  }

  if(!isdefined(var_0["colorTeam"]))
    var_0 = undefined;

  return var_0;
}

removespawnerfromcolornumberarray() {
  var_0 = getcolornumberarray();

  if(!isdefined(var_0)) {
    return;
  }
  var_1 = var_0["team"];
  var_2 = var_0["colorTeam"];
  var_3 = strtok(var_2, " ");

  for (var_4 = 0; var_4 < var_3.size; var_4++)
    level.arrays_of_colorcoded_spawners[var_1][var_3[var_4]] = common_scripts\utility::array_remove(level.arrays_of_colorcoded_spawners[var_1][var_3[var_4]], self);
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
  var_2 = spawn_hidden_reinforcement(var_0, var_1);

  if(isdefined(level.friendly_startup_thread))
    var_2 thread[[level.friendly_startup_thread]]();

  var_2 thread colornode_replace_on_death();
}

colornode_replace_on_death() {
  level endon("kill_color_replacements");
  self endon("_disable_reinforcement");

  if(isdefined(self.replace_on_death)) {
    return;
  }
  self.replace_on_death = 1;
  var_0 = self.classname;
  var_1 = self.script_forcecolor;
  waittillframeend;

  if(isalive(self))
    self waittill("death");

  var_2 = level.current_color_order;

  if(!isdefined(self.script_forcecolor)) {
    return;
  }
  thread colornode_spawn_reinforcement(var_0, self.script_forcecolor);

  if(isdefined(self) && isdefined(self.script_forcecolor))
    var_1 = self.script_forcecolor;

  if(isdefined(self) && isdefined(self.origin))
    var_3 = self.origin;

  for (;;) {
    if(get_color_from_order(var_1, var_2) == "none") {
      return;
    }
    var_4 = maps\_utility::get_force_color_guys("allies", var_2[var_1]);
    var_4 = maps\_utility::remove_heroes_from_array(var_4);
    var_4 = maps\_utility::remove_without_classname(var_4, var_0);

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

    if(isdefined(level.friendly_promotion_thread))
      var_5[[level.friendly_promotion_thread]](var_1);

    var_1 = var_2[var_1];
  }
}

get_color_from_order(var_0, var_1) {
  if(!isdefined(var_0))
    return "none";

  if(!isdefined(var_1))
    return "none";

  if(!isdefined(var_1[var_0]))
    return "none";

  return var_1[var_0];
}

friendly_spawner_vision_checker() {
  level.friendly_respawn_vision_checker_thread = 1;
  var_0 = 0;

  for (;;) {
    common_scripts\utility::flag_waitopen("respawn_friendlies");
    wait 1;

    if(!isdefined(level.respawn_spawner)) {
      continue;
    }
    var_1 = level.respawn_spawner;
    var_2 = level.player.origin - var_1.origin;

    if(length(var_2) < 200) {
      player_sees_spawner();
      continue;
    }

    var_3 = anglestoforward((0, level.player getplayerangles()[1], 0));
    var_4 = vectornormalize(var_2);
    var_5 = vectordot(var_3, var_4);

    if(var_5 < 0.2) {
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
  if(!isdefined(var_0))
    return level.respawn_spawner;

  var_1 = getentarray("color_spawner", "targetname");
  var_2 = [];

  for (var_3 = 0; var_3 < var_1.size; var_3++)
    var_2[var_1[var_3].classname] = var_1[var_3];

  var_4 = undefined;
  var_5 = getarraykeys(var_2);

  for (var_3 = 0; var_3 < var_5.size; var_3++) {
    if(!issubstr(var_2[var_5[var_3]].classname, var_0)) {
      continue;
    }
    var_4 = var_2[var_5[var_3]];
    break;
  }

  if(!isdefined(var_4))
    return level.respawn_spawner;

  var_4.origin = level.respawn_spawner.origin;
  return var_4;
}

spawn_hidden_reinforcement(var_0, var_1) {
  level endon("kill_color_replacements");
  var_2 = undefined;

  for (;;) {
    if(!common_scripts\utility::flag("respawn_friendlies")) {
      if(!isdefined(level.friendly_respawn_vision_checker_thread))
        thread friendly_spawner_vision_checker();

      for (;;) {
        common_scripts\utility::flag_wait_either("player_looks_away_from_spawner", "respawn_friendlies");
        common_scripts\utility::flag_waitopen("friendly_spawner_locked");

        if(common_scripts\utility::flag("player_looks_away_from_spawner") || common_scripts\utility::flag("respawn_friendlies")) {
          break;
        }
      }

      common_scripts\utility::flag_set("friendly_spawner_locked");
    }

    var_3 = get_color_spawner(var_0);
    var_3.count = 1;
    var_2 = var_3 stalingradspawn();

    if(maps\_utility::spawn_failed(var_2)) {
      thread lock_spawner_for_awhile();
      wait 1;
      continue;
    }

    level notify("reinforcement_spawned", var_2);
    break;
  }

  for (;;) {
    if(!isdefined(var_1)) {
      break;
    }

    if(get_color_from_order(var_1, level.current_color_order) == "none") {
      break;
    }

    var_1 = level.current_color_order[var_1];
  }

  if(isdefined(var_1))
    var_2 maps\_utility::set_force_color(var_1);

  var_2 setup_nodes_intelligently_from_team();
  thread lock_spawner_for_awhile();
  return var_2;
}

lock_spawner_for_awhile() {
  common_scripts\utility::flag_set("friendly_spawner_locked");
  wait 2;
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

init_color_delay_info(var_0) {
  if(!isdefined(var_0.script_parameters)) {
    return;
  }
  if(!issubstr(var_0.script_parameters, "color_delays")) {
    return;
  }
  var_1 = strtok(var_0.script_parameters, ":, ");
  var_2 = [];

  for (var_3 = 0; var_3 < var_1.size; var_3++) {
    if(var_1[var_3] == "color_delays") {
      continue;
    }
    if(!isdefined(var_1[var_3 + 1])) {
      return;
    }
    var_2[var_1[var_3]] = float(var_1[var_3 + 1]);
    var_3++;
  }

  var_0.colordelayinfo = var_2;
}