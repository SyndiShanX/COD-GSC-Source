/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_colors.gsc
**************************************/

#include maps\_utility;
#include maps\_spawner;
#include common_scripts\utility;
#include maps\_anim;

init_color_grouping(nodes) {
  flag_init("player_looks_away_from_spawner");
  flag_init("friendly_spawner_locked");
  level.arrays_of_colorcoded_nodes = [];
  level.arrays_of_colorcoded_nodes["axis"] = [];
  level.arrays_of_colorcoded_nodes["allies"] = [];
  level.colorcoded_volumes = [];
  level.colorcoded_volumes["axis"] = [];
  level.colorcoded_volumes["allies"] = [];
  triggers = get_triggers("trigger_once", "trigger_multiple", "trigger_radius", "trigger_box");
  volumes = getentarray("info_volume", "classname");

  for(i = 0; i < nodes.size; i++) {
    if(isDefined(nodes[i].script_color_allies))
      nodes[i] add_node_to_global_arrays(nodes[i].script_color_allies, "allies");

    if(isDefined(nodes[i].script_color_axis))
      nodes[i] add_node_to_global_arrays(nodes[i].script_color_axis, "axis");
  }

  for(i = 0; i < triggers.size; i++) {
    if(isDefined(triggers[i].script_color_allies))
      triggers[i] thread trigger_issues_orders(triggers[i].script_color_allies, "allies");

    if(isDefined(triggers[i].script_color_axis))
      triggers[i] thread trigger_issues_orders(triggers[i].script_color_axis, "axis");
  }

  for(i = 0; i < volumes.size; i++) {
    if(isDefined(volumes[i].script_color_allies))
      volumes[i] add_volume_to_global_arrays(volumes[i].script_color_allies, "allies");

    if(isDefined(volumes[i].script_color_axis))
      volumes[i] add_volume_to_global_arrays(volumes[i].script_color_allies, "axis");
  }

  level.colornodes_debug_array = [];
  level.colornodes_debug_array["allies"] = [];
  level.colornodes_debug_array["axis"] = [];

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
  add_cover_node("Cover Pillar");
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
  add_path_node("Exposed");
  add_path_node("Path");
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

  for(i = 0; i < level.colorlist.size; i++) {
    level.arrays_of_colorforced_ai["allies"][level.colorlist[i]] = [];
    level.arrays_of_colorforced_ai["axis"][level.colorlist[i]] = [];
    level.currentcolorforced["allies"][level.colorlist[i]] = undefined;
    level.currentcolorforced["axis"][level.colorlist[i]] = undefined;
  }
}

player_init_color_grouping() {
  thread player_color_node();
}

convert_color_to_short_string() {
  self.script_forcecolor = level.colorchecklist[self.script_forcecolor];
}

goto_current_colorindex() {
  if(!isDefined(self.currentcolorcode)) {
    return;
  }
  nodes = level.arrays_of_colorcoded_nodes[self.team][self.currentcolorcode];
  self left_color_node();

  if(!isalive(self)) {
    return;
  }
  if(!has_color()) {
    return;
  }
  for(i = 0; i < nodes.size; i++) {
    node = nodes[i];

    if(isalive(node.color_user) && !isplayer(node.color_user)) {
      continue;
    }
    self thread ai_sets_goal_with_delay(node);
    thread decrementcolorusers(node);
    return;
  }

  println("AI with export " + self.export+" was told to go to color node but had no node to go to.");
}

get_color_list() {
  colorlist = [];
  colorlist[colorlist.size] = "r";
  colorlist[colorlist.size] = "b";
  colorlist[colorlist.size] = "y";
  colorlist[colorlist.size] = "c";
  colorlist[colorlist.size] = "g";
  colorlist[colorlist.size] = "p";
  colorlist[colorlist.size] = "o";
  return colorlist;
}

get_colorcodes_from_trigger(color_team, team) {
  colorcodes = strtok(color_team, " ");
  colors = [];
  colorcodesbycolorindex = [];
  usable_colorcodes = [];
  colorlist = get_color_list();

  for(i = 0; i < colorcodes.size; i++) {
    color = undefined;

    for(p = 0; p < colorlist.size; p++) {
      if(issubstr(colorcodes[i], colorlist[p])) {
        color = colorlist[p];
        break;
      }
    }

    if(!isDefined(level.arrays_of_colorcoded_nodes[team][colorcodes[i]])) {
      continue;
    }
    assert(isDefined(color), "Trigger at origin " + self getorigin() + " had strange color index " + colorcodes[i]);
    colorcodesbycolorindex[color] = colorcodes[i];
    colors[colors.size] = color;
    usable_colorcodes[usable_colorcodes.size] = colorcodes[i];
  }

  colorcodes = usable_colorcodes;
  array = [];
  array["colorCodes"] = colorcodes;
  array["colorCodesByColorIndex"] = colorcodesbycolorindex;
  array["colors"] = colors;
  return array;
}

trigger_issues_orders(color_team, team) {
  self endon("death");
  array = get_colorcodes_from_trigger(color_team, team);
  colorcodes = array["colorCodes"];
  colorcodesbycolorindex = array["colorCodesByColorIndex"];
  colors = array["colors"];

  for(;;) {
    self waittill("trigger");

    if(isDefined(self.activated_color_trigger)) {
      self.activated_color_trigger = undefined;
      continue;
    }

    if(!isDefined(self.color_enabled) || isDefined(self.color_enabled) && self.color_enabled)
      activate_color_trigger_internal(colorcodes, colors, team, colorcodesbycolorindex);

    trigger_auto_disable();
  }
}

trigger_auto_disable() {
  if(!isDefined(self.script_color_stay_on))
    self.script_color_stay_on = 0;

  if(!isDefined(self.color_enabled)) {
    if(is_true(self.script_color_stay_on))
      self.color_enabled = 1;
    else
      self.color_enabled = 0;
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
  colorcodes = array["colorCodes"];
  colorcodesbycolorindex = array["colorCodesByColorIndex"];
  colors = array["colors"];
  activate_color_trigger_internal(colorcodes, colors, team, colorcodesbycolorindex);
}

activate_color_trigger_internal(colorcodes, colors, team, colorcodesbycolorindex) {
  for(i = 0; i < colorcodes.size; i++) {
    if(!isDefined(level.arrays_of_colorcoded_spawners[team][colorcodes[i]])) {
      continue;
    }
    arrayremovevalue(level.arrays_of_colorcoded_spawners[team][colorcodes[i]], undefined);

    for(p = 0; p < level.arrays_of_colorcoded_spawners[team][colorcodes[i]].size; p++)
      level.arrays_of_colorcoded_spawners[team][colorcodes[i]][p].currentcolorcode = colorcodes[i];
  }

  for(i = 0; i < colors.size; i++) {
    level.arrays_of_colorforced_ai[team][colors[i]] = array_removedead(level.arrays_of_colorforced_ai[team][colors[i]]);
    level.lastcolorforced[team][colors[i]] = level.currentcolorforced[team][colors[i]];
    level.currentcolorforced[team][colors[i]] = colorcodesbycolorindex[colors[i]];
    assert(isDefined(level.arrays_of_colorcoded_nodes[team][level.currentcolorforced[team][colors[i]]]), "Trigger tried to set colorCode " + colors[i] + " but there are no nodes for " + team + " that use that color combo.");
  }

  ai_array = [];

  for(i = 0; i < colorcodes.size; i++) {
    if(same_color_code_as_last_time(team, colors[i])) {
      continue;
    }
    colorcode = colorcodes[i];

    if(!isDefined(level.arrays_of_colorcoded_ai[team][colorcode])) {
      continue;
    }
    ai_array[colorcode] = issue_leave_node_order_to_ai_and_get_ai(colorcode, colors[i], team);
  }

  for(i = 0; i < colorcodes.size; i++) {
    colorcode = colorcodes[i];

    if(!isDefined(ai_array[colorcode])) {
      continue;
    }
    if(same_color_code_as_last_time(team, colors[i])) {
      continue;
    }
    if(!isDefined(level.arrays_of_colorcoded_ai[team][colorcode])) {
      continue;
    }
    issue_color_order_to_ai(colorcode, colors[i], team, ai_array[colorcode]);
  }
}

same_color_code_as_last_time(team, color) {
  if(!isDefined(level.lastcolorforced[team][color]))
    return false;

  return level.lastcolorforced[team][color] == level.currentcolorforced[team][color];
}

process_cover_node_with_last_in_mind_allies(node, lastcolor) {
  if(issubstr(node.script_color_allies, lastcolor))
    self.cover_nodes_last[self.cover_nodes_last.size] = node;
  else
    self.cover_nodes_first[self.cover_nodes_first.size] = node;
}

process_cover_node_with_last_in_mind_axis(node, lastcolor) {
  if(issubstr(node.script_color_axis, lastcolor))
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

prioritize_colorcoded_nodes(team, colorcode, color) {
  nodes = level.arrays_of_colorcoded_nodes[team][colorcode];
  ent = spawnstruct();
  ent.path_nodes = [];
  ent.cover_nodes_first = [];
  ent.cover_nodes_last = [];
  lastcolorforced_exists = isDefined(level.lastcolorforced[team][color]);

  for(i = 0; i < nodes.size; i++) {
    node = nodes[i];
    ent[[level.color_node_type_function[node.type][lastcolorforced_exists][team]]](node, level.lastcolorforced[team][color]);
  }

  ent.cover_nodes_first = array_randomize(ent.cover_nodes_first);
  nodes = ent.cover_nodes_first;

  for(i = 0; i < ent.cover_nodes_last.size; i++)
    nodes[nodes.size] = ent.cover_nodes_last[i];

  for(i = 0; i < ent.path_nodes.size; i++)
    nodes[nodes.size] = ent.path_nodes[i];

  level.arrays_of_colorcoded_nodes[team][colorcode] = nodes;
}

get_prioritized_colorcoded_nodes(team, colorcode, color) {
  return level.arrays_of_colorcoded_nodes[team][colorcode];
}

issue_leave_node_order_to_ai_and_get_ai(colorcode, color, team) {
  level.arrays_of_colorcoded_ai[team][colorcode] = array_removedead(level.arrays_of_colorcoded_ai[team][colorcode]);
  ai = level.arrays_of_colorcoded_ai[team][colorcode];
  ai = arraycombine(ai, level.arrays_of_colorforced_ai[team][color], 1, 0);
  newarray = [];

  for(i = 0; i < ai.size; i++) {
    if(isDefined(ai[i].currentcolorcode) && ai[i].currentcolorcode == colorcode) {
      continue;
    }
    newarray[newarray.size] = ai[i];
  }

  ai = newarray;

  if(!ai.size) {
    return;
  }
  for(i = 0; i < ai.size; i++)
    ai[i] left_color_node();

  return ai;
}

issue_color_order_to_ai(colorcode, color, team, ai) {
  original_ai_array = ai;
  prioritize_colorcoded_nodes(team, colorcode, color);
  nodes = get_prioritized_colorcoded_nodes(team, colorcode, color);

  level.colornodes_debug_array[team][colorcode] = nodes;

  if(nodes.size < ai.size)
    println("^3Warning, ColorNumber system tried to make " + ai.size + " AI go to " + nodes.size + " nodes.");

  counter = 0;
  ai_count = ai.size;

  for(i = 0; i < nodes.size; i++) {
    node = nodes[i];

    if(isalive(node.color_user)) {
      continue;
    }
    closestai = getclosest(node.origin, ai);
    assert(isalive(closestai));
    arrayremovevalue(ai, closestai);
    closestai take_color_node(node, colorcode, self, counter);
    counter++;

    if(!ai.size)
      return;
  }
}

take_color_node(node, colorcode, trigger, counter) {
  self notify("stop_color_move");
  self.currentcolorcode = colorcode;
  self thread process_color_order_to_ai(node, trigger, counter);
}

player_color_node() {
  for(;;) {
    playernode = undefined;

    if(!isDefined(self.node)) {
      wait 0.05;
      continue;
    }

    olduser = self.node.color_user;
    playernode = self.node;
    playernode.color_user = self;

    for(;;) {
      if(!isDefined(self.node)) {
        break;
      }

      if(self.node != playernode) {
        break;
      }

      wait 0.05;
    }

    playernode.color_user = undefined;
    playernode color_node_finds_a_user();
  }
}

color_node_finds_a_user() {
  if(isDefined(self.script_color_allies))
    color_node_finds_user_from_colorcodes(self.script_color_allies, "allies");

  if(isDefined(self.script_color_axis))
    color_node_finds_user_from_colorcodes(self.script_color_axis, "axis");
}

color_node_finds_user_from_colorcodes(colorcodestring, team) {
  if(isDefined(self.color_user)) {
    return;
  }
  colorcodes = strtok(colorcodestring, " ");
  array_ent_thread(colorcodes, ::color_node_finds_user_for_colorcode, team);
}

color_node_finds_user_for_colorcode(colorcode, team) {
  color = colorcode[0];
  assert(colorislegit(color), "Color " + color + " is not legit");

  if(!isDefined(level.currentcolorforced[team][color])) {
    return;
  }
  if(level.currentcolorforced[team][color] != colorcode) {
    return;
  }
  ai = get_force_color_guys(team, color);

  if(!ai.size) {
    return;
  }
  for(i = 0; i < ai.size; i++) {
    guy = ai[i];

    if(guy occupies_colorcode(colorcode)) {
      continue;
    }
    guy take_color_node(self, colorcode);
    return;
  }
}

occupies_colorcode(colorcode) {
  if(!isDefined(self.currentcolorcode))
    return false;

  return self.currentcolorcode == colorcode;
}

ai_sets_goal_with_delay(node) {
  self endon("death");
  delay = my_current_node_delays();

  if(delay)
    wait(delay);

  ai_sets_goal(node);
}

ai_sets_goal(node) {
  self notify("stop_going_to_node");
  set_goal_and_volume(node);
  volume = level.colorcoded_volumes[self.team][self.currentcolorcode];

  if(isDefined(self.script_careful) && self.script_careful)
    thread careful_logic(node, volume);
}

set_goal_and_volume(node) {
  if(isDefined(self._colors_go_line)) {
    self thread maps\_anim::anim_single_queue(self, self._colors_go_line);
    self notify("colors_go_line_done");
    self._colors_go_line = undefined;
  }

  if(isDefined(node.script_sprint) && node.script_sprint)
    self thread color_sprint_to_goal(node);

  if(isDefined(node.script_forcegoal) && node.script_forcegoal)
    self thread color_force_goal(node);
  else
    self set_goal_node(node);

  if(!self.fixednode) {
    assert(isDefined(node.radius), "Node at origin " + node.origin + " has no .radius.");
    self.goalradius = node.radius;
  } else if(isDefined(node.radius))
    self.goalradius = node.radius;

  volume = level.colorcoded_volumes[self.team][self.currentcolorcode];

  if(isDefined(volume))
    self setfixednodesafevolume(volume);
  else
    self clearfixednodesafevolume();

  if(isDefined(node.fixednodesaferadius))
    self.fixednodesaferadius = node.fixednodesaferadius;
  else
    self.fixednodesaferadius = 64;
}

color_force_goal(node) {
  self endon("death");
  self thread force_goal(node, undefined, 1, "stop_color_forcegoal", 1);
  self waittill_either("goal", "stop_color_move");
  self notify("stop_color_forcegoal");
}

color_sprint_to_goal(node) {
  self endon("death");
  self change_movemode("sprint");
  self waittill_either("goal", "stop_color_move");
  self reset_movemode();
}

careful_logic(node, volume) {
  self endon("death");
  self endon("stop_being_careful");
  self endon("stop_going_to_node");
  thread recover_from_careful_disable(node);

  for(;;) {
    wait_until_an_enemy_is_in_safe_area(node, volume);
    use_big_goal_until_goal_is_safe(node, volume);
    self.fixednode = 1;
    set_goal_and_volume(node);
  }
}

recover_from_careful_disable(node) {
  self endon("death");
  self endon("stop_going_to_node");
  self waittill("stop_being_careful");
  self.fixednode = 1;
  set_goal_and_volume(node);
}

use_big_goal_until_goal_is_safe(node, volume) {
  self setgoalpos(self.origin);
  self.goalradius = 1024;
  self.fixednode = 0;

  if(isDefined(volume)) {
    for(;;) {
      wait 1;

      if(self isknownenemyinradius(node.origin, self.fixednodesaferadius)) {
        continue;
      }
      if(self isknownenemyinvolume(volume)) {
        continue;
      }
      return;
    }
  } else {
    for(;;) {
      if(!self isknownenemyinradius_tmp(node.origin, self.fixednodesaferadius)) {
        return;
      }
      wait 1;
    }
  }
}

isknownenemyinradius_tmp(node_origin, safe_radius) {
  ai = getaiarray("axis");

  for(i = 0; i < ai.size; i++) {
    if(distance2d(ai[i].origin, node_origin) < safe_radius)
      return true;
  }

  return false;
}

wait_until_an_enemy_is_in_safe_area(node, volume) {
  if(isDefined(volume)) {
    for(;;) {
      if(self isknownenemyinradius(node.origin, self.fixednodesaferadius)) {
        return;
      }
      if(self isknownenemyinvolume(volume)) {
        return;
      }
      wait 1;
    }
  } else {
    for(;;) {
      if(self isknownenemyinradius_tmp(node.origin, self.fixednodesaferadius)) {
        return;
      }
      wait 1;
    }
  }
}

my_current_node_delays() {
  if(!isDefined(self.node))
    return 0;

  return self.node script_delay();
}

process_color_order_to_ai(node, trigger, counter) {
  thread decrementcolorusers(node);
  self endon("stop_color_move");
  self endon("death");

  if(isDefined(trigger))
    trigger script_delay();

  if(isDefined(trigger)) {
    if(isDefined(trigger.script_flag_wait))
      flag_wait(trigger.script_flag_wait);
  }

  if(!my_current_node_delays()) {
    if(isDefined(counter))
      wait(counter * randomfloatrange(0.2, 0.35));
  }

  self ai_sets_goal(node);
  self.color_ordered_node_assignment = node;

  for(;;) {
    self waittill("node_taken", taker);

    if(taker == self)
      wait 0.05;

    node = get_best_available_new_colored_node();

    if(isDefined(node)) {
      assert(!isalive(node.color_user), "Node already had color user!");

      if(isalive(self.color_node.color_user) && self.color_node.color_user == self)
        self.color_node.color_user = undefined;

      self.color_node = node;
      node.color_user = self;
      self ai_sets_goal(node);
    }
  }
}

get_best_available_colored_node() {
  assert(self.team != "neutral");
  assert(isDefined(self.script_forcecolor), "AI with export " + self.export+" lost his script_forcecolor.. somehow.");
  colorcode = level.currentcolorforced[self.team][self.script_forcecolor];
  nodes = get_prioritized_colorcoded_nodes(self.team, colorcode, self.script_forcecolor);
  assert(nodes.size > 0, "Tried to make guy with export " + self.export+" go to forcecolor " + self.script_forcecolor + " but there are no nodes of that color enabled");

  for(i = 0; i < nodes.size; i++) {
    if(!isalive(nodes[i].color_user))
      return nodes[i];
  }
}

get_best_available_new_colored_node() {
  assert(self.team != "neutral");
  assert(isDefined(self.script_forcecolor), "AI with export " + self.export+" lost his script_forcecolor.. somehow.");
  colorcode = level.currentcolorforced[self.team][self.script_forcecolor];
  nodes = get_prioritized_colorcoded_nodes(self.team, colorcode, self.script_forcecolor);
  assert(nodes.size > 0, "Tried to make guy with export " + self.export+" go to forcecolor " + self.script_forcecolor + " but there are no nodes of that color enabled");
  nodes = get_array_of_closest(self.origin, nodes);

  for(i = 0; i < nodes.size; i++) {
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
  if(distancesquared(node.origin, self.origin) < 1024) {
    reached_node_but_could_not_claim_it(node);
    return;
  }

  currenttime = gettime();
  wait_for_killanimscript_or_time(1);
  newtime = gettime();

  if(newtime - currenttime >= 1000)
    reached_node_but_could_not_claim_it(node);
}

wait_for_killanimscript_or_time(timer) {
  self endon("killanimscript");
  wait(timer);
}

reached_node_but_could_not_claim_it(node) {
  ai = getaiarray();

  for(i = 0; i < ai.size; i++) {
    if(!isDefined(ai[i].node)) {
      continue;
    }
    if(ai[i].node != node) {
      continue;
    }
    ai[i] notify("eject_from_my_node");
    wait 1;
    self notify("eject_from_my_node");
    return true;
  }

  return false;
}

decrementcolorusers(node) {
  node.color_user = self;
  self.color_node = node;

  self.color_node_debug_val = 1;

  self endon("stop_color_move");
  self waittill("death");
  self.color_node.color_user = undefined;
}

colorislegit(color) {
  for(i = 0; i < level.colorlist.size; i++) {
    if(color == level.colorlist[i])
      return true;
  }

  return false;
}

add_volume_to_global_arrays(colorcode, team) {
  colors = strtok(colorcode, " ");

  for(p = 0; p < colors.size; p++) {
    assert(!isDefined(level.colorcoded_volumes[team][colors[p]]), "Multiple info_volumes exist with color code " + colors[p]);
    level.colorcoded_volumes[team][colors[p]] = self;
  }
}

add_node_to_global_arrays(colorcode, team) {
  self.color_user = undefined;
  colors = strtok(colorcode, " ");

  for(p = 0; p < colors.size; p++) {
    if(isDefined(level.arrays_of_colorcoded_nodes[team]) && isDefined(level.arrays_of_colorcoded_nodes[team][colors[p]])) {
      level.arrays_of_colorcoded_nodes[team][colors[p]][level.arrays_of_colorcoded_nodes[team][colors[p]].size] = self;
      continue;
    }

    level.arrays_of_colorcoded_nodes[team][colors[p]][0] = self;
    level.arrays_of_colorcoded_ai[team][colors[p]] = [];
    level.arrays_of_colorcoded_spawners[team][colors[p]] = [];
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

getcolornumberarray() {
  array = [];

  if(issubstr(self.classname, "axis") || issubstr(self.classname, "enemy")) {
    array["team"] = "axis";
    array["colorTeam"] = self.script_color_axis;
  }

  if(issubstr(self.classname, "ally") || issubstr(self.classname, "civilian")) {
    array["team"] = "allies";
    array["colorTeam"] = self.script_color_allies;
  }

  if(!isDefined(array["colorTeam"]))
    array = undefined;

  return array;
}

removespawnerfromcolornumberarray() {
  colornumberarray = getcolornumberarray();

  if(!isDefined(colornumberarray)) {
    return;
  }
  team = colornumberarray["team"];
  colorteam = colornumberarray["colorTeam"];
  colors = strtok(colorteam, " ");

  for(i = 0; i < colors.size; i++)
    arrayremovevalue(level.arrays_of_colorcoded_spawners[team][colors[i]], self);
}

add_cover_node(type) {
  level.color_node_type_function[type][1]["allies"] = ::process_cover_node_with_last_in_mind_allies;
  level.color_node_type_function[type][1]["axis"] = ::process_cover_node_with_last_in_mind_axis;
  level.color_node_type_function[type][0]["allies"] = ::process_cover_node;
  level.color_node_type_function[type][0]["axis"] = ::process_cover_node;
}

add_path_node(type) {
  level.color_node_type_function[type][1]["allies"] = ::process_path_node;
  level.color_node_type_function[type][0]["allies"] = ::process_path_node;
  level.color_node_type_function[type][1]["axis"] = ::process_path_node;
  level.color_node_type_function[type][0]["axis"] = ::process_path_node;
}

colornode_spawn_reinforcement(classname, fromcolor) {
  level endon("kill_color_replacements");
  reinforcement = spawn_hidden_reinforcement(classname, fromcolor);

  if(isDefined(level.friendly_startup_thread))
    reinforcement thread[[level.friendly_startup_thread]]();

  reinforcement thread colornode_replace_on_death();
}

colornode_replace_on_death() {
  level endon("kill_color_replacements");
  assert(isalive(self), "Tried to do replace on death on something that was not alive");
  self endon("_disable_reinforcement");

  if(self.team == "axis") {
    return;
  }
  if(isDefined(self.replace_on_death)) {
    return;
  }
  self.replace_on_death = 1;
  assert(!isDefined(self.respawn_on_death), "Guy with export " + self.export+" tried to run respawn on death twice.");
  classname = self.classname;
  color = self.script_forcecolor;
  waittillframeend;

  if(isalive(self))
    self waittill("death");

  color_order = level.current_color_order;

  if(!isDefined(self.script_forcecolor)) {
    return;
  }
  thread colornode_spawn_reinforcement(classname, self.script_forcecolor);

  if(isDefined(self) && isDefined(self.script_forcecolor))
    color = self.script_forcecolor;

  if(isDefined(self) && isDefined(self.origin))
    origin = self.origin;

  for(;;) {
    if(get_color_from_order(color, color_order) == "none") {
      return;
    }
    correct_colored_friendlies = get_force_color_guys("allies", color_order[color]);
    correct_colored_friendlies = remove_heroes_from_array(correct_colored_friendlies);
    correct_colored_friendlies = remove_without_classname(correct_colored_friendlies, classname);

    if(!correct_colored_friendlies.size) {
      wait 2;
      continue;
    }

    players = get_players();
    correct_colored_guy = getclosest(players[0].origin, correct_colored_friendlies);
    assert(correct_colored_guy.script_forcecolor != color, "Tried to replace a " + color + " guy with a guy of the same color!");
    waittillframeend;

    if(!isalive(correct_colored_guy)) {
      continue;
    }
    correct_colored_guy set_force_color(color);

    if(isDefined(level.friendly_promotion_thread))
      correct_colored_guy[[level.friendly_promotion_thread]](color);

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
  level.friendly_respawn_vision_checker_thread = 1;
  successes = 0;

  for(;;) {
    flag_waitopen("respawn_friendlies");
    wait 1;

    if(!isDefined(level.respawn_spawner)) {
      continue;
    }
    spawner = level.respawn_spawner;
    players = get_players();
    player_sees_spawner = 0;

    for(q = 0; q < players.size; q++) {
      difference_vec = players[q].origin - spawner.origin;

      if(length(difference_vec) < 200) {
        player_sees_spawner();
        player_sees_spawner = 1;
        break;
      }

      forward = anglestoforward((0, players[q] getplayerangles()[1], 0));
      difference = vectornormalize(difference_vec);
      dot = vectordot(forward, difference);

      if(dot < 0.2) {
        player_sees_spawner();
        player_sees_spawner = 1;
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

get_color_spawner(classname, fromcolor) {
  specificfromcolor = 0;

  if(isDefined(level.respawn_spawners_specific) && isDefined(level.respawn_spawners_specific[fromcolor]))
    specificfromcolor = 1;

  if(!isDefined(level.respawn_spawner)) {
    if(!isDefined(fromcolor) || !specificfromcolor) {
      assertmsg("Tried to spawn a guy but neither level.respawn_spawner or level.respawn_spawners_specific is defined.Either set it to a spawner or use targetname trigger_friendly_respawn triggers.HINT: has the player hit a friendly_respawn_trigger for ALL allied color groups in the map by the time the player has reached this point?");

    }
  }

  if(!isDefined(classname)) {
    if(isDefined(fromcolor) && specificfromcolor)
      return level.respawn_spawners_specific[fromcolor];
    else
      return level.respawn_spawner;
  }

  spawners = getentarray("color_spawner", "targetname");
  class_spawners = [];

  for(i = 0; i < spawners.size; i++)
    class_spawners[spawners[i].classname] = spawners[i];

  spawner = undefined;
  keys = getarraykeys(class_spawners);

  for(i = 0; i < keys.size; i++) {
    if(!issubstr(class_spawners[keys[i]].classname, classname)) {
      continue;
    }
    spawner = class_spawners[keys[i]];
    break;
  }

  if(!isDefined(spawner)) {
    if(isDefined(fromcolor) && specificfromcolor)
      return level.respawn_spawners_specific[fromcolor];
    else
      return level.respawn_spawner;
  }

  if(isDefined(fromcolor) && specificfromcolor)
    spawner.origin = level.respawn_spawners_specific[fromcolor].origin;
  else
    spawner.origin = level.respawn_spawner.origin;

  return spawner;
}

spawn_hidden_reinforcement(classname, fromcolor) {
  level endon("kill_color_replacements");
  spawn = undefined;

  for(;;) {
    if(!flag("respawn_friendlies")) {
      if(!isDefined(level.friendly_respawn_vision_checker_thread))
        thread friendly_spawner_vision_checker();

      for(;;) {
        flag_wait_either("player_looks_away_from_spawner", "respawn_friendlies");
        flag_waitopen("friendly_spawner_locked");

        if(flag("player_looks_away_from_spawner") || flag("respawn_friendlies")) {
          break;
        }
      }

      flag_set("friendly_spawner_locked");
    }

    spawner = get_color_spawner(classname, fromcolor);
    spawner.count = 1;

    while(!level ok_to_trigger_spawn(1))
      wait_network_frame();

    spawner script_wait();
    spawn = spawner spawn_ai();

    if(spawn_failed(spawn)) {
      thread lock_spawner_for_awhile();
      wait 1;
      continue;
    }

    level._numtriggerspawned++;
    level notify("reinforcement_spawned", spawn);
    break;
  }

  for(;;) {
    if(!isDefined(fromcolor)) {
      break;
    }

    if(get_color_from_order(fromcolor, level.current_color_order) == "none") {
      break;
    }

    fromcolor = level.current_color_order[fromcolor];
  }

  if(isDefined(fromcolor))
    spawn set_force_color(fromcolor);

  thread lock_spawner_for_awhile();
  return spawn;
}

lock_spawner_for_awhile() {
  flag_set("friendly_spawner_locked");
  wait 2;
  flag_clear("friendly_spawner_locked");
}

player_sees_spawner() {
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