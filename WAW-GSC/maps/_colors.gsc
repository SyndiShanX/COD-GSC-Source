/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_colors.gsc
*****************************************************/

#include maps\_utility;
#include maps\_spawner;
#include common_scripts\utility;

init_color_grouping(nodes) {
  flag_init("player_looks_away_from_spawner");
  flag_init("friendly_spawner_locked");
  level.arrays_of_colorCoded_nodes = [];
  level.arrays_of_colorCoded_nodes["axis"] = [];
  level.arrays_of_colorCoded_nodes["allies"] = [];
  level.colorCoded_volumes = [];
  level.colorCoded_volumes["axis"] = [];
  level.colorCoded_volumes["allies"] = [];
  triggers = [];
  triggers = array_combine(triggers, getentarray("trigger_multiple", "classname"));
  triggers = array_combine(triggers, getentarray("trigger_radius", "classname"));
  triggers = array_combine(triggers, getentarray("trigger_once", "classname"));
  volumes = getentarray("info_volume", "classname");
  for (i = 0; i < nodes.size; i++) {
    if(isDefined(nodes[i].script_color_allies))
      nodes[i] add_node_to_global_arrays(nodes[i].script_color_allies, "allies");
    if(isDefined(nodes[i].script_color_axis))
      nodes[i] add_node_to_global_arrays(nodes[i].script_color_axis, "axis");
  }
  for (i = 0; i < triggers.size; i++) {
    if(isDefined(triggers[i].script_color_allies))
      triggers[i] thread trigger_issues_orders(triggers[i].script_color_allies, "allies");
    if(isDefined(triggers[i].script_color_axis))
      triggers[i] thread trigger_issues_orders(triggers[i].script_color_axis, "axis");
  }
  for (i = 0; i < volumes.size; i++) {
    if(isDefined(volumes[i].script_color_allies))
      volumes[i] add_volume_to_global_arrays(volumes[i].script_color_allies, "allies");
    if(isDefined(volumes[i].script_color_axis))
      volumes[i] add_volume_to_global_arrays(volumes[i].script_color_allies, "axis");
  }
  level.colorNodes_debug_array = [];
  level.colorNodes_debug_array["allies"] = [];
  level.colorNodes_debug_array["axis"] = [];
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
  level.colorList = [];
  level.colorList[level.colorList.size] = "r";
  level.colorList[level.colorList.size] = "b";
  level.colorList[level.colorList.size] = "y";
  level.colorList[level.colorList.size] = "c";
  level.colorList[level.colorList.size] = "g";
  level.colorList[level.colorList.size] = "p";
  level.colorList[level.colorList.size] = "o";
  level.colorCheckList["red"] = "r";
  level.colorCheckList["r"] = "r";
  level.colorCheckList["blue"] = "b";
  level.colorCheckList["b"] = "b";
  level.colorCheckList["yellow"] = "y";
  level.colorCheckList["y"] = "y";
  level.colorCheckList["cyan"] = "c";
  level.colorCheckList["c"] = "c";
  level.colorCheckList["green"] = "g";
  level.colorCheckList["g"] = "g";
  level.colorCheckList["purple"] = "p";
  level.colorCheckList["p"] = "p";
  level.colorCheckList["orange"] = "o";
  level.colorCheckList["o"] = "o";
  level.currentColorForced = [];
  level.currentColorForced["allies"] = [];
  level.currentColorForced["axis"] = [];
  level.lastColorForced = [];
  level.lastColorForced["allies"] = [];
  level.lastColorForced["axis"] = [];
  for (i = 0; i < level.colorList.size; i++) {
    level.arrays_of_colorForced_ai["allies"][level.colorList[i]] = [];
    level.arrays_of_colorForced_ai["axis"][level.colorList[i]] = [];
    level.currentColorForced["allies"][level.colorList[i]] = undefined;
    level.currentColorForced["axis"][level.colorList[i]] = undefined;
  }
}

player_init_color_grouping() {
  thread player_color_node();
}

convert_color_to_short_string() {
  self.script_forceColor = level.colorCheckList[self.script_forceColor];
}

ai_picks_destination(currentColorCode) {
  if(isDefined(self.script_forcecolor)) {
    convert_color_to_short_string();
    self.currentColorCode = currentColorCode;
    color = self.script_forcecolor;
    assert(colorIsLegit(color), "AI at origin " + self.origin + " has non-legit forced color " + color + ". Legit colors are red blue yellow cyan green purple and orange.");
    level.arrays_of_colorForced_ai[self.team][color] = array_add(level.arrays_of_colorForced_ai[self.team][color], self);
    thread goto_current_ColorIndex();
    return;
  }
}

goto_current_ColorIndex() {
  if(!isDefined(self.currentColorCode)) {
    return;
  }
  nodes = level.arrays_of_colorCoded_nodes[self.team][self.currentColorCode];
  self left_color_node();
  if(!isalive(self)) {
    return;
  }
  if(!has_color()) {
    return;
  }
  for (i = 0; i < nodes.size; i++) {
    node = nodes[i];
    if(isalive(node.color_user) && !IsPlayer(node.color_user)) {
      continue;
    }
    self thread ai_sets_goal_with_delay(node);
    thread decrementColorUsers(node);
    return;
  }
  no_node_to_go_to();
}

no_node_to_go_to() {
  println("AI with export " + self.export+" was told to go to color node but had no node to go to.");
}

get_color_list() {
  colorList = [];
  colorList[colorList.size] = "r";
  colorList[colorList.size] = "b";
  colorList[colorList.size] = "y";
  colorList[colorList.size] = "c";
  colorList[colorList.size] = "g";
  colorList[colorList.size] = "p";
  colorList[colorList.size] = "o";
  return colorList;
}

get_colorcodes_from_trigger(color_team, team) {
  colorCodes = strtok(color_team, " ");
  colors = [];
  colorCodesByColorIndex = [];
  usable_colorCodes = [];
  colorList = get_color_list();
  for (i = 0; i < colorCodes.size; i++) {
    color = undefined;
    for (p = 0; p < colorList.size; p++) {
      if(issubstr(colorCodes[i], colorList[p])) {
        color = colorList[p];
        break;
      }
    }
    if(!isDefined(level.arrays_of_colorCoded_nodes[team][colorCodes[i]])) {
      continue;
    }
    assertEx(isDefined(color), "Trigger at origin " + self getorigin() + " had strange color index " + colorCodes[i]);
    colorCodesByColorIndex[color] = colorCodes[i];
    colors[colors.size] = color;
    usable_colorCodes[usable_colorCodes.size] = colorCodes[i];
  }
  colorCodes = usable_colorCodes;
  array = [];
  array["colorCodes"] = colorCodes;
  array["colorCodesByColorIndex"] = colorCodesByColorIndex;
  array["colors"] = colors;
  return array;
}

trigger_issues_orders(color_team, team) {
  self endon("death");
  array = get_colorcodes_from_trigger(color_team, team);
  colorCodes = array["colorCodes"];
  colorCodesByColorIndex = array["colorCodesByColorIndex"];
  colors = array["colors"];
  for (;;) {
    self waittill("trigger");
    if(isDefined(self.activated_color_trigger)) {
      self.activated_color_trigger = undefined;
      continue;
    }
    if(!isDefined(self.color_enabled) || (isDefined(self.color_enabled) && self.color_enabled)) {
      activate_color_trigger_internal(colorCodes, colors, team, colorCodesByColorIndex);
    }
    trigger_auto_disable();
  }
}

trigger_auto_disable() {
  if(!isDefined(self.script_color_auto_disable)) {
    self.script_color_auto_disable = true;
  }
  if(!isDefined(self.color_enabled)) {
    if(self.script_color_auto_disable) {
      self.color_enabled = false;
    } else {
      self.color_enabled = true;
    }
  }
}

activate_color_trigger(team) {
  if(team == "allies")
    self thread get_colorcodes_and_activate_trigger(self.script_color_allies, team);
  else
    self thread get_colorcodes_and_activate_trigger(self.script_color_axis, team);
}

get_colorcodes_and_activate_trigger(color_team, team) {
  array = get_colorcodes_from_trigger(color_team, team);
  colorCodes = array["colorCodes"];
  colorCodesByColorIndex = array["colorCodesByColorIndex"];
  colors = array["colors"];
  activate_color_trigger_internal(colorCodes, colors, team, colorCodesByColorIndex);
}

activate_color_trigger_internal(colorCodes, colors, team, colorCodesByColorIndex) {
  for (i = 0; i < colorCodes.size; i++) {
    if(!isDefined(level.arrays_of_colorCoded_spawners[team][colorCodes[i]])) {
      continue;
    }
    level.arrays_of_colorCoded_spawners[team][colorCodes[i]] = array_removeUndefined(level.arrays_of_colorCoded_spawners[team][colorCodes[i]]);
    for (p = 0; p < level.arrays_of_colorCoded_spawners[team][colorCodes[i]].size; p++)
      level.arrays_of_colorCoded_spawners[team][colorCodes[i]][p].currentColorCode = colorCodes[i];
  }
  for (i = 0; i < colors.size; i++) {
    level.arrays_of_colorForced_ai[team][colors[i]] = array_removeDead(level.arrays_of_colorForced_ai[team][colors[i]]);
    level.lastColorForced[team][colors[i]] = level.currentColorForced[team][colors[i]];
    level.currentColorForced[team][colors[i]] = colorCodesByColorIndex[colors[i]];
    assertEx(isDefined(level.arrays_of_colorCoded_nodes[team][level.currentColorForced[team][colors[i]]]),
      "Trigger tried to set colorCode " + colors[i] + " but there are no nodes for " + team + " that use that color combo.");
  }
  ai_array = [];
  for (i = 0; i < colorCodes.size; i++) {
    if(same_color_code_as_last_time(team, colors[i])) {
      continue;
    }
    colorCode = colorCodes[i];
    if(!isDefined(level.arrays_of_colorCoded_ai[team][colorCode])) {
      continue;
    }
    ai_array[colorCode] = issue_leave_node_order_to_ai_and_get_ai(colorCode, colors[i], team);
  }
  for (i = 0; i < colorCodes.size; i++) {
    colorCode = colorCodes[i];
    if(!isDefined(ai_array[colorCode])) {
      continue;
    }
    if(same_color_code_as_last_time(team, colors[i])) {
      continue;
    }
    if(!isDefined(level.arrays_of_colorCoded_ai[team][colorCode])) {
      continue;
    }
    issue_color_order_to_ai(colorCode, colors[i], team, ai_array[colorCode]);
  }
}

same_color_code_as_last_time(team, color) {
  if(!isDefined(level.lastColorForced[team][color]))
    return false;
  return level.lastColorForced[team][color] == level.currentColorForced[team][color];
}

process_cover_node_with_last_in_mind_allies(node, lastColor) {
  if(issubstr(node.script_color_allies, lastColor))
    self.cover_nodes_last[self.cover_nodes_last.size] = node;
  else
    self.cover_nodes_first[self.cover_nodes_first.size] = node;
}

process_cover_node_with_last_in_mind_axis(node, lastColor) {
  if(issubstr(node.script_color_axis, lastColor))
    self.cover_nodes_last[self.cover_nodes_last.size] = node;
  else
    self.cover_nodes_first[self.cover_nodes_first.size] = node;
}

process_cover_node(node, null) {
  self.cover_nodes_first[self.cover_nodes_first.size] = node;
}

process_path_node(node, null) {
  self.path_nodes[self.path_nodes.size] = node;
}

prioritize_colorCoded_nodes(team, colorCode, color) {
  nodes = level.arrays_of_colorCoded_nodes[team][colorCode];
  ent = spawnstruct();
  ent.path_nodes = [];
  ent.cover_nodes_first = [];
  ent.cover_nodes_last = [];
  lastColorForced_exists = isDefined(level.lastColorForced[team][color]);
  for (i = 0; i < nodes.size; i++) {
    node = nodes[i];
    ent[[level.color_node_type_function[node.type][lastColorForced_exists][team]]](node, level.lastColorForced[team][color]);
  }
  ent.cover_nodes_first = array_randomize(ent.cover_nodes_first);
  nodes = ent.cover_nodes_first;
  for (i = 0; i < ent.cover_nodes_last.size; i++) {
    nodes[nodes.size] = ent.cover_nodes_last[i];
  }
  for (i = 0; i < ent.path_nodes.size; i++) {
    nodes[nodes.size] = ent.path_nodes[i];
  }
  level.arrays_of_colorCoded_nodes[team][colorCode] = nodes;
}

get_prioritized_colorCoded_nodes(team, colorCode, color) {
  return level.arrays_of_colorCoded_nodes[team][colorCode];
}

issue_leave_node_order_to_ai_and_get_ai(colorCode, color, team) {
  level.arrays_of_colorCoded_ai[team][colorCode] = array_removeDead(level.arrays_of_colorCoded_ai[team][colorCode]);
  ai = level.arrays_of_colorCoded_ai[team][colorCode];
  ai = array_combine(ai, level.arrays_of_colorForced_ai[team][color]);
  newArray = [];
  for (i = 0; i < ai.size; i++) {
    if(isDefined(ai[i].currentColorCode) && ai[i].currentColorCode == colorCode)
      continue;
    newArray[newArray.size] = ai[i];
  }
  ai = newArray;
  if(!ai.size) {
    return;
  }
  for (i = 0; i < ai.size; i++)
    ai[i] left_color_node();
  return ai;
}

issue_color_order_to_ai(colorCode, color, team, ai) {
  original_ai_array = ai;
  prioritize_colorCoded_nodes(team, colorCode, color);
  nodes = get_prioritized_colorCoded_nodes(team, colorCode, color);
  level.colorNodes_debug_array[team][colorCode] = nodes;
  if(nodes.size < ai.size)
    println("^3Warning, ColorNumber system tried to make " + ai.size + " AI go to " + nodes.size + " nodes.");
  counter = 0;
  ai_count = ai.size;
  for (i = 0; i < nodes.size; i++) {
    node = nodes[i];
    if(isalive(node.color_user)) {
      continue;
    }
    closestAI = getclosest(node.origin, ai);
    assert(isalive(closestAI));
    ai = array_remove(ai, closestAI);
    closestAI take_color_node(node, colorCode, self, counter);
    counter++;
    if(!ai.size)
      return;
  }
}

take_color_node(node, colorCode, trigger, counter) {
  self notify("stop_color_move");
  self.currentColorCode = colorCode;
  self thread process_color_order_to_ai(node, trigger, counter);
}

player_color_node() {
  for (;;) {
    playerNode = undefined;
    if(!isDefined(self.node)) {
      wait(0.05);
      continue;
    }
    olduser = self.node.color_user;
    playerNode = self.node;
    playerNode.color_user = self;
    for (;;) {
      if(!isDefined(self.node)) {
        break;
      }
      if(self.node != playerNode) {
        break;
      }
      wait(0.05);
    }
    playerNode.color_user = undefined;
    playerNode color_node_finds_a_user();
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

color_node_finds_user_from_colorcodes(colorCodeString, team) {
  if(isDefined(self.color_user)) {
    return;
  }
  colorCodes = strtok(colorCodeString, " ");
  array_levelthread(colorCodes, ::color_node_finds_user_for_colorCode, team);
}

color_node_finds_user_for_colorCode(colorCode, team) {
  color = colorCode[0];
  assertex(colorIsLegit(color), "Color " + color + " is not legit");
  if(!isDefined(level.currentColorForced[team][color])) {
    return;
  }
  if(level.currentColorForced[team][color] != colorCode) {
    return;
  }
  ai = get_force_color_guys(team, color);
  if(!ai.size) {
    return;
  }
  for (i = 0; i < ai.size; i++) {
    guy = ai[i];
    if(guy occupies_colorCode(colorCode)) {
      continue;
    }
    guy take_color_node(self, colorCode);
    return;
  }
}

occupies_colorCode(colorCode) {
  if(!isDefined(self.currentColorCode)) {
    return false;
  }
  return self.currentColorCode == colorCode;
}

ai_sets_goal_with_delay(node) {
  self endon("death");
  delay = my_current_node_delays();
  if(delay) {
    wait(delay);
  }
  ai_sets_goal(node);
}

ai_sets_goal(node) {
  self notify("stop_going_to_node");
  set_goal_and_volume(node);
  volume = level.colorCoded_volumes[self.team][self.currentColorCode];
  if(isDefined(self.script_careful)) {
    thread careful_logic(node, volume);
  }
}

set_goal_and_volume(node) {
  if(isDefined(self._colors_go_line)) {
    self thread maps\_anim::anim_single_queue(self, self._colors_go_line);
    self._colors_go_line = undefined;
  }
  self setgoalnode(node);
  if(!self.fixedNode) {
    assertex(isDefined(node.radius), "Node at origin " + node.origin + " has no .radius.");
    self.goalradius = node.radius;
  } else {
    if(isDefined(node.radius))
      self.goalradius = node.radius;
  }
  volume = level.colorCoded_volumes[self.team][self.currentColorCode];
  if(isDefined(volume)) {
    self setFixedNodeSafeVolume(volume);
  } else {
    self clearFixedNodeSafeVolume();
  }
  if(isDefined(node.fixedNodeSafeRadius)) {
    self.fixedNodeSafeRadius = node.fixedNodeSafeRadius;
  } else {
    self.fixedNodeSafeRadius = 64;
  }
}

careful_logic(node, volume) {
  self endon("death");
  self endon("stop_being_careful");
  self endon("stop_going_to_node");
  thread recover_from_careful_disable(node);
  for (;;) {
    wait_until_an_enemy_is_in_safe_area(node, volume);
    use_big_goal_until_goal_is_safe(node, volume);
    self.fixednode = true;
    set_goal_and_volume(node);
  }
}

recover_from_careful_disable(node) {
  self endon("death");
  self endon("stop_going_to_node");
  self waittill("stop_being_careful");
  self.fixednode = true;
  set_goal_and_volume(node);
}

use_big_goal_until_goal_is_safe(node, volume) {
  self setgoalpos(self.origin);
  self.goalradius = 1024;
  self.fixednode = false;
  if(isDefined(volume)) {
    for (;;) {
      wait(1);
      if(self isKnownEnemyInRadius(node.origin, self.fixedNodeSafeRadius))
        continue;
      if(self isKnownEnemyInVolume(volume))
        continue;
      return;
    }
  } else {
    for (;;) {
      if(!(self isKnownEnemyInRadius_tmp(node.origin, self.fixedNodeSafeRadius)))
        return;
      wait(1);
    }
  }
}

isKnownEnemyInRadius_tmp(node_origin, safe_radius) {
  ai = getaiarray("axis");
  for (i = 0; i < ai.size; i++) {
    if(distance2d(ai[i].origin, node_origin) < safe_radius)
      return true;
  }
  return false;
}

wait_until_an_enemy_is_in_safe_area(node, volume) {
  if(isDefined(volume)) {
    for (;;) {
      if(self isKnownEnemyInRadius(node.origin, self.fixedNodeSafeRadius))
        return;
      if(self isKnownEnemyInVolume(volume))
        return;
      wait(1);
    }
  } else {
    for (;;) {
      if(self isKnownEnemyInRadius_tmp(node.origin, self.fixedNodeSafeRadius))
        return;
      wait(1);
    }
  }
}

my_current_node_delays() {
  if(!isDefined(self.node))
    return false;
  return self.node script_delay();
}

process_color_order_to_ai(node, trigger, counter) {
  thread decrementColorUsers(node);
  self endon("stop_color_move");
  self endon("death");
  if(isDefined(trigger)) {
    trigger script_delay();
  }
  if(!my_current_node_delays()) {
    if(isDefined(counter)) {
      wait(counter * randomfloatrange(0.2, 0.35));
    }
  }
  self ai_sets_goal(node);
  self.color_ordered_node_assignment = node;
  for (;;) {
    self waittill("node_taken", taker);
    if(taker == self) {
      wait(0.05);
    }
    node = get_best_available_new_colored_node();
    if(isDefined(node)) {
      assertEx(!isalive(node.color_user), "Node already had color user!");
      if(isalive(self.color_node.color_user) && self.color_node.color_user == self)
        self.color_node.color_user = undefined;
      self.color_node = node;
      node.color_user = self;
      self ai_sets_goal(node);
    }
  }
}

get_best_available_colored_node() {
  assertEx(self.team != "neutral");
  assertEx(isDefined(self.script_forceColor), "AI with export " + self.export+" lost his script_forcecolor.. somehow.");
  colorCode = level.currentColorForced[self.team][self.script_forceColor];
  nodes = get_prioritized_colorCoded_nodes(self.team, colorCode, self.script_forcecolor);
  assertEx(nodes.size > 0, "Tried to make guy with export " + self.export+" go to forcecolor " + self.script_forceColor + " but there are no nodes of that color enabled");
  for (i = 0; i < nodes.size; i++) {
    if(!isalive(nodes[i].color_user))
      return nodes[i];
  }
}

get_best_available_new_colored_node() {
  assertEx(self.team != "neutral");
  assertEx(isDefined(self.script_forceColor), "AI with export " + self.export+" lost his script_forcecolor.. somehow.");
  colorCode = level.currentColorForced[self.team][self.script_forceColor];
  nodes = get_prioritized_colorCoded_nodes(self.team, colorCode, self.script_forcecolor);
  assertEx(nodes.size > 0, "Tried to make guy with export " + self.export+" go to forcecolor " + self.script_forceColor + " but there are no nodes of that color enabled");
  for (i = 0; i < nodes.size; i++) {
    if(nodes[i] == self.color_node)
      continue;
    if(!isalive(nodes[i].color_user))
      return nodes[i];
  }
}

process_stop_short_of_node(node) {
  self endon("stopScript");
  self endon("death");
  if(isDefined(self.node)) {
    return;
  }
  if(distance(node.origin, self.origin) < 32) {
    reached_node_but_could_not_claim_it(node);
    return;
  }
  currentTime = gettime();
  wait_for_killanimscript_or_time(1);
  newTime = gettime();
  if(newTime - currentTime >= 1000)
    reached_node_but_could_not_claim_it(node);
}

wait_for_killanimscript_or_time(timer) {
  self endon("killanimscript");
  wait(timer);
}

reached_node_but_could_not_claim_it(node) {
  ai = getaiarray();
  guy = undefined;
  for (i = 0; i < ai.size; i++) {
    if(!isDefined(ai[i].node))
      continue;
    if(ai[i].node != node) {
      continue;
    }
    ai[i] notify("eject_from_my_node");
    wait(1);
    self notify("eject_from_my_node");
    return true;
  }
  return false;
}

decrementColorUsers(node) {
  node.color_user = self;
  assertEx(!isDefined(self.color_node), "Decrement had color_node");
  self.color_node = node;
  assertEx(!isDefined(self.color_node_debug_val), "Guy had double color_node_debug_val");
  self.color_node_debug_val = true;
  self endon("stop_color_move");
  self waittill("death");
  self.color_node.color_user = undefined;
}

colorIsLegit(color) {
  for (i = 0; i < level.colorList.size; i++) {
    if(color == level.colorList[i])
      return true;
  }
  return false;
}

add_volume_to_global_arrays(colorCode, team) {
  colors = strtok(colorCode, " ");
  for (p = 0; p < colors.size; p++) {
    assert(!isDefined(level.colorCoded_volumes[team][colors[p]]), "Multiple info_volumes exist with color code " + colors[p]);
    level.colorCoded_volumes[team][colors[p]] = self;
  }
}

add_node_to_global_arrays(colorCode, team) {
  self.color_user = undefined;
  colors = strtok(colorCode, " ");
  for (p = 0; p < colors.size; p++) {
    if(isDefined(level.arrays_of_colorCoded_nodes[team]) && isDefined(level.arrays_of_colorCoded_nodes[team][colors[p]])) {
      level.arrays_of_colorCoded_nodes[team][colors[p]] = array_add(level.arrays_of_colorCoded_nodes[team][colors[p]], self);
      continue;
    }
    level.arrays_of_colorCoded_nodes[team][colors[p]][0] = self;
    level.arrays_of_colorCoded_ai[team][colors[p]] = [];
    level.arrays_of_colorCoded_spawners[team][colors[p]] = [];
  }
}

left_color_node() {
  self.color_node_debug_val = undefined;
  if(!isDefined(self.color_node)) {
    return;
  }
  if(isDefined(self.color_node.color_user) && self.color_node.color_user == self)
    self.color_node.color_user = undefined;
  self.color_node = undefined;
  self notify("stop_color_move");
}

GetColorNumberArray() {
  array = [];
  if(issubstr(self.classname, "axis") || issubstr(self.classname, "enemy")) {
    array["team"] = "axis";
    array["colorTeam"] = self.script_color_axis;
  }
  if((issubstr(self.classname, "ally")) || (issubstr(self.classname, "civilian"))) {
    array["team"] = "allies";
    array["colorTeam"] = self.script_color_allies;
  }
  if(!isDefined(array["colorTeam"]))
    array = undefined;
  return array;
}

removeSpawnerFromColorNumberArray() {
  colorNumberArray = GetColorNumberArray();
  if(!isDefined(colorNumberArray)) {
    return;
  }
  team = colorNumberArray["team"];
  colorTeam = colorNumberArray["colorTeam"];
  colors = strtok(colorTeam, " ");
  for (i = 0; i < colors.size; i++)
    level.arrays_of_colorCoded_spawners[team][colors[i]] = array_remove(level.arrays_of_colorCoded_spawners[team][colors[i]], self);
}

add_cover_node(type) {
  level.color_node_type_function[type][true]["allies"] = ::process_cover_node_with_last_in_mind_allies;
  level.color_node_type_function[type][true]["axis"] = ::process_cover_node_with_last_in_mind_axis;
  level.color_node_type_function[type][false]["allies"] = ::process_cover_node;
  level.color_node_type_function[type][false]["axis"] = ::process_cover_node;
}

add_path_node(type) {
  level.color_node_type_function[type][true]["allies"] = ::process_path_node;
  level.color_node_type_function[type][false]["allies"] = ::process_path_node;
  level.color_node_type_function[type][true]["axis"] = ::process_path_node;
  level.color_node_type_function[type][false]["axis"] = ::process_path_node;
}

colorNode_spawn_reinforcement(classname, fromColor) {
  level endon("kill_color_replacements");
  reinforcement = spawn_hidden_reinforcement(classname, fromColor);
  if(isDefined(level.friendly_startup_thread))
    reinforcement thread[[level.friendly_startup_thread]]();
  reinforcement thread colorNode_replace_on_death();
}

colorNode_replace_on_death() {
  level endon("kill_color_replacements");
  assertex(isalive(self), "Tried to do replace on death on something that was not alive");
  self endon("_disable_reinforcement");
  if(self.team == "axis") {
    return;
  }
  if(isDefined(self.replace_on_death)) {
    return;
  }
  self.replace_on_death = true;
  assertEx(!isDefined(self.respawn_on_death), "Guy with export " + self.export+" tried to run respawn on death twice.");
  classname = self.classname;
  color = self.script_forceColor;
  waittillframeend;
  if(isalive(self)) {
    self waittill("death");
  }
  color_order = level.current_color_order;
  if(!isDefined(self.script_forceColor)) {
    return;
  }
  thread colorNode_spawn_reinforcement(classname, self.script_forceColor);
  if(isDefined(self) && isDefined(self.script_forceColor))
    color = self.script_forceColor;
  if(isDefined(self) && isDefined(self.origin))
    origin = self.origin;
  for (;;) {
    if(get_color_from_order(color, color_order) == "none") {
      return;
    }
    correct_colored_friendlies = get_force_color_guys("allies", color_order[color]);
    correct_colored_friendlies = remove_heroes_from_array(correct_colored_friendlies);
    correct_colored_friendlies = remove_without_classname(correct_colored_friendlies, classname);
    if(!correct_colored_friendlies.size) {
      wait(2);
      continue;
    }
    players = get_players();
    correct_colored_guy = getclosest(players[0].origin, correct_colored_friendlies);
    assertEx(correct_colored_guy.script_forceColor != color, "Tried to replace a " + color + " guy with a guy of the same color!");
    waittillframeend;
    if(!isalive(correct_colored_guy)) {
      continue;
    }
    correct_colored_guy set_force_color(color);
    if(isDefined(level.friendly_promotion_thread)) {
      correct_colored_guy[[level.friendly_promotion_thread]](color);
    }
    color = color_order[color];
  }
}

get_color_from_order(color, color_order) {
  if(!isDefined(color))
    return "none";
  if(!isDefined(color_order))
    return "none";
  if(!isDefined(color_order[color]))
    return "none";
  return color_order[color];
}

friendly_spawner_vision_checker() {
  level.friendly_respawn_vision_checker_thread = true;
  successes = 0;
  for (;;) {
    flag_waitopen("respawn_friendlies");
    wait(1);
    if(!isDefined(level.respawn_spawner)) {
      continue;
    }
    spawner = level.respawn_spawner;
    players = get_players();
    player_sees_spawner = false;
    for (q = 0; q < players.size; q++) {
      difference_vec = players[q].origin - spawner.origin;
      if(length(difference_vec) < 200) {
        player_sees_spawner();
        player_sees_spawner = true;
        break;
      }
      forward = anglesToForward((0, players[q] getplayerangles()[1], 0));
      difference = vectornormalize(difference_vec);
      dot = vectordot(forward, difference);
      if(dot < 0.2) {
        player_sees_spawner();
        player_sees_spawner = true;
        break;
      }
      successes++;
      if(successes < 3)
        continue;
    }
    if(player_sees_spawner) {
      continue;
    }
    flag_set("player_looks_away_from_spawner");
  }
}

get_color_spawner(classname, fromColor) {
  specificFromColor = false;
  if(isDefined(level.respawn_spawners_specific) && isDefined(level.respawn_spawners_specific[fromColor])) {
    specificFromColor = true;
  }
  if(!isDefined(level.respawn_spawner)) {
    if(!isDefined(fromColor) || !specificFromColor) {
      ASSERTMSG("Tried to spawn a guy but neither level.respawn_spawner or level.respawn_spawners_specific is defined.Either set it to a spawner or use targetname trigger_friendly_respawn triggers.HINT: has the player hit a friendly_respawn_trigger for ALL allied color groups in the map by the time the player has reached this point?");
    }
  }
  if(!isDefined(classname)) {
    if(isDefined(fromColor) && specificFromColor) {
      return level.respawn_spawners_specific[fromColor];
    } else {
      return level.respawn_spawner;
    }
  }
  spawners = getentarray("color_spawner", "targetname");
  class_spawners = [];
  for (i = 0; i < spawners.size; i++)
    class_spawners[spawners[i].classname] = spawners[i];
  spawner = undefined;
  keys = getarraykeys(class_spawners);
  for (i = 0; i < keys.size; i++) {
    if(!issubstr(class_spawners[keys[i]].classname, classname))
      continue;
    spawner = class_spawners[keys[i]];
    break;
  }
  if(!isDefined(spawner)) {
    if(isDefined(fromColor) && specificFromColor) {
      return level.respawn_spawners_specific[fromColor];
    } else {
      return level.respawn_spawner;
    }
  }
  if(isDefined(fromColor) && specificFromColor) {
    spawner.origin = level.respawn_spawners_specific[fromColor].origin;
  } else {
    spawner.origin = level.respawn_spawner.origin;
  }
  return spawner;
}

spawn_hidden_reinforcement(classname, fromColor) {
  level endon("kill_color_replacements");
  spawn = undefined;
  for (;;) {
    if(!flag("respawn_friendlies")) {
      if(!isDefined(level.friendly_respawn_vision_checker_thread))
        thread friendly_spawner_vision_checker();
      for (;;) {
        flag_wait_either("player_looks_away_from_spawner", "respawn_friendlies");
        flag_waitopen("friendly_spawner_locked");
        if(flag("player_looks_away_from_spawner") || flag("respawn_friendlies")) {
          break;
        }
      }
      flag_set("friendly_spawner_locked");
    }
    spawner = get_color_spawner(classname, fromColor);
    spawner.count = 1;
    while (!level ok_to_trigger_spawn(true)) {
      wait_network_frame();
    }
    if(isDefined(spawner.script_forcespawn) && spawner.script_forcespawn) {
      spawn = spawner StalingradSpawn();
    } else {
      spawn = spawner Dospawn();
    }
    if(spawn_failed(spawn)) {
      thread lock_spawner_for_awhile();
      wait(1);
      continue;
    }
    level._numTriggerSpawned++;
    level notify("reinforcement_spawned", spawn);
    break;
  }
  for (;;) {
    if(!isDefined(fromColor)) {
      break;
    }
    if(get_color_from_order(fromColor, level.current_color_order) == "none") {
      break;
    }
    fromColor = level.current_color_order[fromColor];
  }
  if(isDefined(fromColor))
    spawn set_force_color(fromColor);
  thread lock_spawner_for_awhile();
  return spawn;
}

lock_spawner_for_awhile() {
  flag_set("friendly_spawner_locked");
  wait(2);
  flag_clear("friendly_spawner_locked");
}

player_sees_spawner() {
  successes = 0;
  flag_clear("player_looks_away_from_spawner");
}

kill_color_replacements() {
  flag_clear("friendly_spawner_locked");
  level notify("kill_color_replacements");
  ai = getaiarray();
  array_thread(ai, ::remove_replace_on_death);
}

remove_replace_on_death() {
  self.replace_on_death = undefined;
}