/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\colors_shared.gsc
***********************************************/

#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\util_shared;

#namespace colors;

autoexec __init__system__() {
  system::register(#"colors", &__init__, &__main__, undefined);
}

__init__() {
  nodes = getallnodes();
  level flag::init("player_looks_away_from_spawner");
  level flag::init("friendly_spawner_locked");
  level flag::init("respawn_friendlies");
  level.arrays_of_colorcoded_nodes = [];
  level.arrays_of_colorcoded_nodes[#"axis"] = [];
  level.arrays_of_colorcoded_nodes[#"allies"] = [];
  level.arrays_of_colorcoded_nodes[#"team3"] = [];
  level.colorcoded_volumes = [];
  level.colorcoded_volumes[#"axis"] = [];
  level.colorcoded_volumes[#"allies"] = [];
  level.colorcoded_volumes[#"team3"] = [];
  volumes = getEntArray("info_volume", "classname");

  for(i = 0; i < nodes.size; i++) {
    if(isDefined(nodes[i].script_color_allies)) {
      nodes[i] add_node_to_global_arrays(nodes[i].script_color_allies, #"allies");
    }

    if(isDefined(nodes[i].script_color_axis)) {
      nodes[i] add_node_to_global_arrays(nodes[i].script_color_axis, #"axis");
    }

    if(isDefined(nodes[i].script_color_team3)) {
      nodes[i] add_node_to_global_arrays(nodes[i].script_color_team3, #"team3");
    }
  }

  for(i = 0; i < volumes.size; i++) {
    if(isDefined(volumes[i].script_color_allies)) {
      volumes[i] add_volume_to_global_arrays(volumes[i].script_color_allies, #"allies");
    }

    if(isDefined(volumes[i].script_color_axis)) {
      volumes[i] add_volume_to_global_arrays(volumes[i].script_color_axis, #"axis");
    }

    if(isDefined(volumes[i].script_color_team3)) {
      volumes[i] add_volume_to_global_arrays(volumes[i].script_color_team3, #"team3");
    }
  }

  level.colornodes_debug_array = [];
  level.colornodes_debug_array[#"allies"] = [];
  level.colornodes_debug_array[#"axis"] = [];
  level.colornodes_debug_array[#"team3"] = [];

  level.color_node_type_function = [];
  add_cover_node(#"bad node");
  add_cover_node(#"cover stand");
  add_cover_node(#"cover crouch");
  add_cover_node(#"cover prone");
  add_cover_node(#"cover crouch window");
  add_cover_node(#"cover right");
  add_cover_node(#"cover left");
  add_cover_node(#"cover wide left");
  add_cover_node(#"cover wide right");
  add_cover_node(#"cover pillar");
  add_cover_node(#"conceal stand");
  add_cover_node(#"conceal crouch");
  add_cover_node(#"conceal prone");
  add_cover_node(#"reacquire");
  add_cover_node(#"balcony");
  add_cover_node(#"scripted");
  add_cover_node(#"begin");
  add_cover_node(#"end");
  add_cover_node(#"turret");
  add_path_node(#"guard");
  add_path_node(#"exposed");
  add_path_node(#"path");
  level.colorlist = [];
  level.colorlist[level.colorlist.size] = "r";
  level.colorlist[level.colorlist.size] = "b";
  level.colorlist[level.colorlist.size] = "y";
  level.colorlist[level.colorlist.size] = "c";
  level.colorlist[level.colorlist.size] = "g";
  level.colorlist[level.colorlist.size] = "p";
  level.colorlist[level.colorlist.size] = "o";
  level.colorchecklist[#"red"] = "r";
  level.colorchecklist[#"r"] = "r";
  level.colorchecklist[#"blue"] = "b";
  level.colorchecklist[#"b"] = "b";
  level.colorchecklist[#"yellow"] = "y";
  level.colorchecklist[#"y"] = "y";
  level.colorchecklist[#"cyan"] = "c";
  level.colorchecklist[#"c"] = "c";
  level.colorchecklist[#"green"] = "g";
  level.colorchecklist[#"g"] = "g";
  level.colorchecklist[#"purple"] = "p";
  level.colorchecklist[#"p"] = "p";
  level.colorchecklist[#"orange"] = "o";
  level.colorchecklist[#"o"] = "o";
  level.currentcolorforced = [];
  level.currentcolorforced[#"allies"] = [];
  level.currentcolorforced[#"axis"] = [];
  level.currentcolorforced[#"team3"] = [];
  level.lastcolorforced = [];
  level.lastcolorforced[#"allies"] = [];
  level.lastcolorforced[#"axis"] = [];
  level.lastcolorforced[#"team3"] = [];

  for(i = 0; i < level.colorlist.size; i++) {
    level.arrays_of_colorforced_ai[#"allies"][level.colorlist[i]] = [];
    level.arrays_of_colorforced_ai[#"axis"][level.colorlist[i]] = [];
    level.arrays_of_colorforced_ai[#"team3"][level.colorlist[i]] = [];
    level.currentcolorforced[#"allies"][level.colorlist[i]] = undefined;
    level.currentcolorforced[#"axis"][level.colorlist[i]] = undefined;
    level.currentcolorforced[#"team3"][level.colorlist[i]] = undefined;
  }

  thread debugdvars();
  thread debugcolorfriendlies();
}

__main__() {
  foreach(trig in trigger::get_all()) {
    if(isDefined(trig.script_color_allies)) {
      trig thread trigger_issues_orders(trig.script_color_allies, #"allies");
    }

    if(isDefined(trig.script_color_axis)) {
      trig thread trigger_issues_orders(trig.script_color_axis, #"axis");
    }

    if(isDefined(trig.script_color_team3)) {
      trig thread trigger_issues_orders(trig.script_color_team3, #"team3");
    }
  }
}

debugdvars() {
  while(true) {
    if(getdvar(#"debug_colornodes", 0) > 0) {
      thread debug_colornodes();
    }

    waitframe(1);
  }
}

get_team_substr() {
  if(self.team == #"allies") {
    if(!isDefined(self.node.script_color_allies_old)) {
      return;
    }

    return self.node.script_color_allies_old;
  }

  if(self.team == #"axis") {
    if(!isDefined(self.node.script_color_axis_old)) {
      return;
    }

    return self.node.script_color_axis_old;
  }
}

try_to_draw_line_to_node() {
  if(!isDefined(self.node)) {
    return;
  }

  if(!isDefined(self.script_forcecolor)) {
    return;
  }

  substr = get_team_substr();

  if(!isDefined(substr)) {
    return;
  }

  if(!issubstr(substr, self.script_forcecolor)) {
    return;
  }

  recordline(self.origin + (0, 0, 25), self.node.origin, _get_debug_color(self.script_forcecolor), "<dev string:x38>", self);
  line(self.origin + (0, 0, 25), self.node.origin, _get_debug_color(self.script_forcecolor));
}

_get_debug_color(str_color) {
  switch (str_color) {
    case #"red":
    case #"r":
      return (1, 0, 0);
    case #"green":
    case #"g":
      return (0, 1, 0);
    case #"b":
    case #"blue":
      return (0, 0, 1);
    case #"yellow":
    case #"y":
      return (1, 1, 0);
    case #"orange":
    case #"o":
      return (1, 0.5, 0);
    case #"c":
    case #"cyan":
      return (0, 1, 1);
    case #"purple":
    case #"p":
      return (1, 0, 1);
    default:
      println("<dev string:x41>" + str_color + "<dev string:x50>");
      return (0, 0, 0);
  }
}

debug_colornodes() {
  array = [];
  array[#"axis"] = [];
  array[#"allies"] = [];
  array[#"team3"] = [];
  aiarray = arraycombine(getplayers(), getaiarray(), 0, 0);

  foreach(ai in aiarray) {
    if(!isDefined(ai.currentcolorcode) || !isai(ai) && !isbot(ai) || !isDefined(array[ai.team])) {
      continue;
    }

    array[ai.team][ai.currentcolorcode] = 1;
    color = (1, 1, 1);

    if(isDefined(ai.script_forcecolor)) {
      color = _get_debug_color(ai.script_forcecolor);
    }

    recordenttext(ai.currentcolorcode, ai, color, "<dev string:x38>");
    print3d(ai.origin + (0, 0, 25), ai.currentcolorcode, color, 1, 0.7);
    ai try_to_draw_line_to_node();
  }

  draw_colornodes(array, #"allies");
  draw_colornodes(array, #"axis");
  draw_colornodes(array, #"team3");
}

draw_colornodes(array, team) {
  foreach(k, v in array[team]) {
    color = _get_debug_color(function_9e72a96(k)[0]);

    if(isDefined(level.colornodes_debug_array[team][k])) {
      a_team_nodes = level.colornodes_debug_array[team][k];

      for(p = 0; p < a_team_nodes.size; p++) {
        print3d(a_team_nodes[p].origin, "<dev string:x90>" + function_9e72a96(k), color, 1, 0.7);

        if(getdvar(#"debug_colornodes", 0) == 2 && isDefined(a_team_nodes[p].script_color_allies_old)) {
          if(isDefined(a_team_nodes[p].color_user) && isalive(a_team_nodes[p].color_user) && isDefined(a_team_nodes[p].color_user.script_forcecolor)) {
            print3d(a_team_nodes[p].origin + (0, 0, -5), "<dev string:x90>" + a_team_nodes[p].script_color_allies_old, _get_debug_color(a_team_nodes[p].color_user.script_forcecolor), 0.5, 0.4);
            continue;
          }

          print3d(a_team_nodes[p].origin + (0, 0, -5), "<dev string:x90>" + a_team_nodes[p].script_color_allies_old, color, 0.5, 0.4);
        }
      }
    }
  }
}

debugcolorfriendlies() {
  level.debug_color_friendlies = [];
  level.debug_color_huds = [];
  level thread debugcolorfriendliestogglewatch();

  for(;;) {
    level waittill(#"updated_color_friendlies");
    draw_color_friendlies();
  }
}

debugcolorfriendliestogglewatch() {
  just_turned_on = 0;
  just_turned_off = 0;

  while(true) {
    if(getdvar(#"debug_colornodes", 0) == 1 && !just_turned_on) {
      just_turned_on = 1;
      just_turned_off = 0;
      draw_color_friendlies();
    }

    if(getdvar(#"debug_colornodes", 0) != 1 && !just_turned_off) {
      just_turned_off = 1;
      just_turned_on = 0;
      draw_color_friendlies();
    }

    wait 0.25;
  }
}

get_script_palette() {
  rgb = [];
  rgb[#"r"] = (1, 0, 0);
  rgb[#"o"] = (1, 0.5, 0);
  rgb[#"y"] = (1, 1, 0);
  rgb[#"g"] = (0, 1, 0);
  rgb[#"c"] = (0, 1, 1);
  rgb[#"b"] = (0, 0, 1);
  rgb[#"p"] = (1, 0, 1);
  return rgb;
}

draw_color_friendlies() {
  level endon(#"updated_color_friendlies");
  colored_friendlies = [];
  colors = [];
  colors[colors.size] = "<dev string:x95>";
  colors[colors.size] = "<dev string:x99>";
  colors[colors.size] = "<dev string:x9d>";
  colors[colors.size] = "<dev string:xa1>";
  colors[colors.size] = "<dev string:xa5>";
  colors[colors.size] = "<dev string:xa9>";
  colors[colors.size] = "<dev string:xad>";
  rgb = get_script_palette();

  for(i = 0; i < colors.size; i++) {
    colored_friendlies[colors[i]] = 0;
  }

  foreach(color in level.debug_color_friendlies) {
    colored_friendlies[color]++;
  }

  for(i = 0; i < level.debug_color_huds.size; i++) {
    level.debug_color_huds[i] destroy();
  }

  level.debug_color_huds = [];

  if(getdvar(#"debug_colornodes", 0) != 1) {
    return;
  }

  y = 365;

  for(i = 0; i < colors.size; i++) {
    if(colored_friendlies[colors[i]] <= 0) {
      continue;
    }

    for(p = 0; p < colored_friendlies[colors[i]]; p++) {
      overlay = newdebughudelem();
      overlay.x = 15 + 25 * p;
      overlay.y = y;
      overlay setshader(#"white", 16, 16);
      overlay.alignx = "<dev string:xb1>";
      overlay.aligny = "<dev string:xb8>";
      overlay.alpha = 1;
      overlay.color = rgb[colors[i]];
      level.debug_color_huds[level.debug_color_huds.size] = overlay;
    }

    y += 25;
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

  if(!isDefined(nodes)) {
    nodes = [];
  } else if(!isarray(nodes)) {
    nodes = array(nodes);
  }

  nodes[nodes.size] = level.colorcoded_volumes[self.team][self.currentcolorcode];
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

  if(isbot(self)) {
    println("<dev string:xc1>" + self.name + "<dev string:xd2>");
    return;
  }

  println("<dev string:x10c>" + self.export+"<dev string:xd2>");
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

    if(!isDefined(level.arrays_of_colorcoded_nodes[team][colorcodes[i]]) && !isDefined(level.colorcoded_volumes[team][colorcodes[i]])) {
      continue;
    }

    assert(isDefined(color), "<dev string:x11e>" + self getorigin() + "<dev string:x133>" + colorcodes[i]);
    colorcodesbycolorindex[color] = colorcodes[i];
    colors[colors.size] = color;
    usable_colorcodes[usable_colorcodes.size] = colorcodes[i];
  }

  colorcodes = usable_colorcodes;
  array = [];
  array[#"colorcodes"] = colorcodes;
  array[#"colorcodesbycolorindex"] = colorcodesbycolorindex;
  array[#"colors"] = colors;
  return array;
}

trigger_issues_orders(color_team, team) {
  self endon(#"death");
  array = get_colorcodes_from_trigger(color_team, team);
  colorcodes = array[#"colorcodes"];
  colorcodesbycolorindex = array[#"colorcodesbycolorindex"];
  colors = array[#"colors"];

  for(;;) {
    self waittill(#"trigger");

    if(isDefined(self.activated_color_trigger)) {
      self.activated_color_trigger = undefined;
      continue;
    }

    if(!isDefined(self.color_enabled) || isDefined(self.color_enabled) && self.color_enabled) {
      activate_color_trigger_internal(colorcodes, colors, team, colorcodesbycolorindex);
    }

    trigger_auto_disable();
  }
}

trigger_auto_disable() {
  if(!isDefined(self.script_color_stay_on)) {
    self.script_color_stay_on = 0;
  }

  if(!isDefined(self.color_enabled)) {
    if(isDefined(self.script_color_stay_on) && self.script_color_stay_on) {
      self.color_enabled = 1;
      return;
    }

    self.color_enabled = 0;
  }
}

activate_color_trigger(var_cc966c56) {
  switch (var_cc966c56) {
    case #"allies":
      str_color = self.script_color_allies;
      break;
    case #"axis":
      str_color = self.script_color_axis;
      break;
    case #"team3":
      str_color = self.script_color_team3;
      break;
    default:
      return;
  }

  self thread get_colorcodes_and_activate_trigger(str_color, var_cc966c56);
}

get_colorcodes_and_activate_trigger(color_team, team) {
  array = get_colorcodes_from_trigger(color_team, team);
  colorcodes = array[#"colorcodes"];
  colorcodesbycolorindex = array[#"colorcodesbycolorindex"];
  colors = array[#"colors"];
  activate_color_trigger_internal(colorcodes, colors, team, colorcodesbycolorindex);
}

activate_color_trigger_internal(colorcodes, colors, team, colorcodesbycolorindex) {
  for(i = 0; i < colorcodes.size; i++) {
    if(!isDefined(level.arrays_of_colorcoded_spawners[team][colorcodes[i]])) {
      continue;
    }

    arrayremovevalue(level.arrays_of_colorcoded_spawners[team][colorcodes[i]], undefined);

    for(p = 0; p < level.arrays_of_colorcoded_spawners[team][colorcodes[i]].size; p++) {
      level.arrays_of_colorcoded_spawners[team][colorcodes[i]][p].currentcolorcode = colorcodes[i];
    }
  }

  for(i = 0; i < colors.size; i++) {
    level.arrays_of_colorforced_ai[team][colors[i]] = array::remove_dead(level.arrays_of_colorforced_ai[team][colors[i]]);
    level.lastcolorforced[team][colors[i]] = level.currentcolorforced[team][colors[i]];
    level.currentcolorforced[team][colors[i]] = colorcodesbycolorindex[colors[i]];
    assert(isDefined(level.arrays_of_colorcoded_nodes[team][level.currentcolorforced[team][colors[i]]]) || isDefined(level.colorcoded_volumes[team][level.currentcolorforced[team][colors[i]]]), "<dev string:x14f>" + colors[i] + "<dev string:x171>" + team + "<dev string:x190>");
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
  if(!isDefined(level.lastcolorforced[team][color])) {
    return false;
  }

  return level.lastcolorforced[team][color] == level.currentcolorforced[team][color];
}

function_f06ea88(node, var_f9350db6, var_cc966c56) {
  switch (var_cc966c56) {
    case #"allies":
      str_color = node.script_color_allies;
      break;
    case #"axis":
      str_color = node.script_color_axis;
      break;
    case #"team3":
      str_color = node.script_color_team3;
      break;
    default:
      return;
  }

  if(issubstr(str_color, var_f9350db6)) {
    self.cover_nodes_last[self.cover_nodes_last.size] = node;
    return;
  }

  self.cover_nodes_first[self.cover_nodes_first.size] = node;
}

process_cover_node(node, var_f9350db6, var_cc966c56) {
  self.cover_nodes_first[self.cover_nodes_first.size] = node;
}

process_path_node(node, var_f9350db6, var_cc966c56) {
  self.path_nodes[self.path_nodes.size] = node;
}

prioritize_colorcoded_nodes(team, colorcode, color) {
  nodes = level.arrays_of_colorcoded_nodes[team][colorcode];
  ent = spawnStruct();
  ent.path_nodes = [];
  ent.cover_nodes_first = [];
  ent.cover_nodes_last = [];
  lastcolorforced_exists = isDefined(level.lastcolorforced[team][color]);

  for(i = 0; i < nodes.size; i++) {
    node = nodes[i];
    ent[[level.color_node_type_function[node.type][lastcolorforced_exists]]](node, level.lastcolorforced[team][color], team);
  }

  ent.cover_nodes_first = array::randomize(ent.cover_nodes_first);
  nodes = ent.cover_nodes_first;

  for(i = 0; i < ent.cover_nodes_last.size; i++) {
    nodes[nodes.size] = ent.cover_nodes_last[i];
  }

  for(i = 0; i < ent.path_nodes.size; i++) {
    nodes[nodes.size] = ent.path_nodes[i];
  }

  level.arrays_of_colorcoded_nodes[team][colorcode] = nodes;
}

get_prioritized_colorcoded_nodes(team, colorcode, color) {
  if(isDefined(level.arrays_of_colorcoded_nodes[team][colorcode])) {
    return level.arrays_of_colorcoded_nodes[team][colorcode];
  }

  if(isDefined(level.colorcoded_volumes[team][colorcode])) {
    return level.colorcoded_volumes[team][colorcode];
  }
}

issue_leave_node_order_to_ai_and_get_ai(colorcode, color, team) {
  level.arrays_of_colorcoded_ai[team][colorcode] = array::remove_dead(level.arrays_of_colorcoded_ai[team][colorcode]);
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

  for(i = 0; i < ai.size; i++) {
    ai[i] left_color_node();
  }

  return ai;
}

issue_color_order_to_ai(colorcode, color, team, ai) {
  original_ai_array = ai;
  prioritize_colorcoded_nodes(team, colorcode, color);
  nodes = get_prioritized_colorcoded_nodes(team, colorcode, color);

  level.colornodes_debug_array[team][colorcode] = nodes;

  if(nodes.size < ai.size) {
    println("<dev string:x1ae>" + ai.size + "<dev string:x1dd>" + nodes.size + "<dev string:x1ea>");
  }

  counter = 0;
  ai_count = ai.size;

  for(i = 0; i < nodes.size; i++) {
    node = nodes[i];

    if(isalive(node.color_user)) {
      continue;
    }

    closestai = arraysort(ai, node.origin, 1, 1)[0];
    assert(isalive(closestai));
    arrayremovevalue(ai, closestai);
    closestai take_color_node(node, colorcode, self, counter);
    counter++;

    if(!ai.size) {
      return;
    }
  }
}

take_color_node(node, colorcode, trigger, counter) {
  self notify(#"stop_color_move");
  self.currentcolorcode = colorcode;
  self thread process_color_order_to_ai(node, trigger, counter);
}

player_color_node() {
  for(;;) {
    playernode = undefined;

    if(!isDefined(self.node)) {
      waitframe(1);
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

      waitframe(1);
    }

    playernode.color_user = undefined;
    playernode color_node_finds_a_user();
  }
}

color_node_finds_a_user() {
  if(isDefined(self.script_color_allies)) {
    color_node_finds_user_from_colorcodes(self.script_color_allies, #"allies");
  }

  if(isDefined(self.script_color_axis)) {
    color_node_finds_user_from_colorcodes(self.script_color_axis, #"axis");
  }

  if(isDefined(self.script_color_team3)) {
    color_node_finds_user_from_colorcodes(self.script_color_team3, #"team3");
  }
}

color_node_finds_user_from_colorcodes(colorcodestring, team) {
  if(isDefined(self.color_user)) {
    return;
  }

  colorcodes = strtok(colorcodestring, " ");
  array::thread_all_ents(colorcodes, &color_node_finds_user_for_colorcode, team);
}

color_node_finds_user_for_colorcode(colorcode, team) {
  color = colorcode[0];
  assert(colorislegit(color), "<dev string:x1f4>" + color + "<dev string:x1fd>");

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
  if(!isDefined(self.currentcolorcode)) {
    return false;
  }

  return self.currentcolorcode == colorcode;
}

ai_sets_goal_with_delay(node) {
  self endon(#"death");
  delay = my_current_node_delays();

  if(delay) {
    wait delay;
  }

  ai_sets_goal(node);
}

ai_sets_goal(node) {
  self notify(#"stop_going_to_node");
  set_goal_and_volume(node);
}

set_goal_and_volume(node) {
  if(isDefined(self._colors_go_line)) {
    self notify(#"colors_go_line_done");
    self._colors_go_line = undefined;
  }

  if(isDefined(node.radius) && node.radius) {
    self.goalradius = node.radius;
  }

  if(isDefined(node.script_forcegoal) && node.script_forcegoal) {
    self thread color_force_goal(node);
  } else {
    self setgoal(node);
  }

  volume = level.colorcoded_volumes[self.team][self.currentcolorcode];

  if(isDefined(volume)) {
    self setgoal(volume);
  }
}

color_force_goal(node) {
  self endon(#"death");
  self thread ai::force_goal(node, 1, "stop_color_forcegoal", 1);
  self waittill(#"goal", #"stop_color_move");
  self notify(#"stop_color_forcegoal");
}

my_current_node_delays() {
  if(!isDefined(self.node)) {
    return 0;
  }

  return self.node util::script_delay();
}

process_color_order_to_ai(node, trigger, counter) {
  thread decrementcolorusers(node);
  self endon(#"stop_color_move", #"death");

  if(isDefined(trigger)) {
    trigger util::script_delay();
  }

  if(isDefined(trigger)) {
    if(isDefined(trigger.script_flag_wait)) {
      level flag::wait_till(trigger.script_flag_wait);
    }
  }

  if(!my_current_node_delays()) {
    if(isDefined(counter)) {
      wait counter * randomfloatrange(0.2, 0.35);
    }
  }

  self ai_sets_goal(node);
  self.color_ordered_node_assignment = node;

  for(;;) {
    waitresult = self waittill(#"node_taken");

    if(waitresult.taker == self) {
      waitframe(1);
    }

    node = get_best_available_new_colored_node();

    if(isDefined(node)) {
      assert(!isalive(node.color_user), "<dev string:x20d>");

      if(isalive(self.color_node.color_user) && self.color_node.color_user == self) {
        self.color_node.color_user = undefined;
      }

      self.color_node = node;
      node.color_user = self;
      self ai_sets_goal(node);
    }
  }
}

get_best_available_colored_node() {
  assert(self.team != #"neutral");
  assert(isDefined(self.script_forcecolor), "<dev string:x10c>" + self.export+"<dev string:x22c>");
  colorcode = level.currentcolorforced[self.team][self.script_forcecolor];
  nodes = get_prioritized_colorcoded_nodes(self.team, colorcode, self.script_forcecolor);
  assert(nodes.size > 0, "<dev string:x255>" + self.export+"<dev string:x276>" + self.script_forcecolor + "<dev string:x28b>");

  for(i = 0; i < nodes.size; i++) {
    if(!isalive(nodes[i].color_user)) {
      return nodes[i];
    }
  }
}

get_best_available_new_colored_node() {
  assert(self.team != #"neutral");
  assert(isDefined(self.script_forcecolor), "<dev string:x10c>" + self.export+"<dev string:x22c>");
  colorcode = level.currentcolorforced[self.team][self.script_forcecolor];
  nodes = get_prioritized_colorcoded_nodes(self.team, colorcode, self.script_forcecolor);
  assert(nodes.size > 0, "<dev string:x255>" + self.export+"<dev string:x276>" + self.script_forcecolor + "<dev string:x28b>");
  nodes = arraysort(nodes, self.origin);

  for(i = 0; i < nodes.size; i++) {
    if(!isalive(nodes[i].color_user)) {
      return nodes[i];
    }
  }
}

process_stop_short_of_node(node) {
  self endon(#"stopscript", #"death");

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

  if(newtime - currenttime >= 1000) {
    reached_node_but_could_not_claim_it(node);
  }
}

wait_for_killanimscript_or_time(timer) {
  self endon(#"killanimscript");
  wait timer;
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

    ai[i] notify(#"eject_from_my_node");
    wait 1;
    self notify(#"eject_from_my_node");
    return true;
  }

  return false;
}

decrementcolorusers(node) {
  node.color_user = self;
  self.color_node = node;

  self.color_node_debug_val = 1;

  self endon(#"stop_color_move");
  self waittill(#"death");
  self.color_node.color_user = undefined;
}

colorislegit(color) {
  for(i = 0; i < level.colorlist.size; i++) {
    if(color == level.colorlist[i]) {
      return true;
    }
  }

  return false;
}

add_volume_to_global_arrays(colorcode, team) {
  colors = strtok(colorcode, " ");

  for(p = 0; p < colors.size; p++) {
    assert(!isDefined(level.colorcoded_volumes[team][colors[p]]), "<dev string:x2bb>" + colors[p]);
    level.colorcoded_volumes[team][colors[p]] = self;
  }
}

add_node_to_global_arrays(colorcode, team) {
  self.color_user = undefined;
  colors = strtok(colorcode, " ");

  for(p = 0; p < colors.size; p++) {
    if(isDefined(level.arrays_of_colorcoded_nodes[team]) && isDefined(level.arrays_of_colorcoded_nodes[team][colors[p]])) {
      if(!isDefined(level.arrays_of_colorcoded_nodes[team][colors[p]])) {
        level.arrays_of_colorcoded_nodes[team][colors[p]] = [];
      } else if(!isarray(level.arrays_of_colorcoded_nodes[team][colors[p]])) {
        level.arrays_of_colorcoded_nodes[team][colors[p]] = array(level.arrays_of_colorcoded_nodes[team][colors[p]]);
      }

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

  if(isDefined(self.color_node.color_user) && self.color_node.color_user == self) {
    self.color_node.color_user = undefined;
  }

  self.color_node = undefined;
  self notify(#"stop_color_move");
}

removespawnerfromcolornumberarray() {
  switch (self.team) {
    case #"allies":
      str_color = self.script_color_allies;
      break;
    case #"axis":
      str_color = self.script_color_axis;
      break;
    case #"team3":
      str_color = self.script_color_team3;
      break;
    default:
      return;
  }

  if(!isDefined(str_color)) {
    return;
  }

  a_str_colors = strtok(str_color, " ");

  for(i = 0; i < a_str_colors.size; i++) {
    arrayremovevalue(level.arrays_of_colorcoded_spawners[self.team][a_str_colors[i]], self);
  }
}

add_cover_node(type) {
  level.color_node_type_function[type][1] = &function_f06ea88;
  level.color_node_type_function[type][0] = &process_cover_node;
}

add_path_node(type) {
  level.color_node_type_function[type][1] = &process_path_node;
  level.color_node_type_function[type][0] = &process_path_node;
}

colornode_spawn_reinforcement(classname, fromcolor) {
  level endon(#"kill_color_replacements");
  friendly_spawners_type = getclasscolorhash(classname, fromcolor);

  while(level.friendly_spawners_types[friendly_spawners_type] > 0) {
    spawn = undefined;

    for(;;) {
      if(!level flag::get("respawn_friendlies")) {
        if(!isDefined(level.friendly_respawn_vision_checker_thread)) {
          thread friendly_spawner_vision_checker();
        }

        for(;;) {
          level flag::wait_till_any(array("player_looks_away_from_spawner", "respawn_friendlies"));
          level flag::wait_till_clear("friendly_spawner_locked");

          if(level flag::get("player_looks_away_from_spawner") || level flag::get("respawn_friendlies")) {
            break;
          }
        }

        level flag::set("friendly_spawner_locked");
      }

      spawner = get_color_spawner(classname, fromcolor);
      spawner.count = 1;
      level.friendly_spawners_types[friendly_spawners_type] -= 1;
      spawner util::script_wait();
      spawn = spawner spawner::spawn();

      if(spawner::spawn_failed(spawn)) {
        thread lock_spawner_for_awhile();
        wait 1;
        continue;
      }

      level notify(#"reinforcement_spawned", {
        #entity: spawn
      });
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

    if(isDefined(fromcolor)) {
      spawn set_force_color(fromcolor);
    }

    thread lock_spawner_for_awhile();

    if(isDefined(level.friendly_startup_thread)) {
      spawn thread[[level.friendly_startup_thread]]();
    }

    spawn thread colornode_replace_on_death();
  }
}

colornode_replace_on_death() {
  level endon(#"kill_color_replacements");
  assert(isalive(self), "<dev string:x2ea>");
  self endon(#"_disable_reinforcement");

  if(self.team == #"axis") {
    return;
  }

  if(isDefined(self.replace_on_death)) {
    return;
  }

  self.replace_on_death = 1;
  assert(!isDefined(self.respawn_on_death), "<dev string:x329>" + self.export+"<dev string:x33c>");
  classname = self.classname;
  color = self.script_forcecolor;
  waittillframeend();

  if(isalive(self)) {
    self waittill(#"death");
  }

  color_order = level.current_color_order;

  if(!isDefined(self.script_forcecolor)) {
    return;
  }

  friendly_spawners_type = getclasscolorhash(classname, self.script_forcecolor);

  if(!isDefined(level.friendly_spawners_types) || !isDefined(level.friendly_spawners_types[friendly_spawners_type]) || level.friendly_spawners_types[friendly_spawners_type] <= 0) {
    level.friendly_spawners_types[friendly_spawners_type] = 1;
    thread colornode_spawn_reinforcement(classname, self.script_forcecolor);
  } else {
    level.friendly_spawners_types[friendly_spawners_type] += 1;
  }

  if(isDefined(self) && isDefined(self.script_forcecolor)) {
    color = self.script_forcecolor;
  }

  if(isDefined(self) && isDefined(self.origin)) {
    origin = self.origin;
  }

  for(;;) {
    if(get_color_from_order(color, color_order) == "none") {
      return;
    }

    correct_colored_friendlies = get_force_color_guys(#"allies", color_order[color]);
    correct_colored_friendlies = array::filter_classname(correct_colored_friendlies, 1, classname);

    if(!correct_colored_friendlies.size) {
      wait 2;
      continue;
    }

    players = getplayers();
    correct_colored_guy = arraysort(correct_colored_friendlies, players[0].origin, 1)[0];
    assert(correct_colored_guy.script_forcecolor != color, "<dev string:x364>" + color + "<dev string:x37a>");
    waittillframeend();

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
  if(!isDefined(color)) {
    return "none";
  }

  if(!isDefined(color_order)) {
    return "none";
  }

  if(!isDefined(color_order[color])) {
    return "none";
  }

  return color_order[color];
}

friendly_spawner_vision_checker() {
  level.friendly_respawn_vision_checker_thread = 1;
  successes = 0;

  for(;;) {
    level flag::wait_till_clear("respawn_friendlies");
    wait 1;

    if(!isDefined(level.respawn_spawner)) {
      continue;
    }

    spawner = level.respawn_spawner;
    players = getplayers();
    player_sees_spawner = 0;

    for(q = 0; q < players.size; q++) {
      difference_vec = players[q].origin - spawner.origin;

      if(length(difference_vec) < 200) {
        player_sees_spawner();
        player_sees_spawner = 1;
        break;
      }

      forward = anglesToForward((0, players[q] getplayerangles()[1], 0));
      difference = vectornormalize(difference_vec);
      dot = vectordot(forward, difference);

      if(dot < 0.2) {
        player_sees_spawner();
        player_sees_spawner = 1;
        break;
      }

      successes++;

      if(successes < 3) {}
    }

    if(player_sees_spawner) {
      continue;
    }

    level flag::set("player_looks_away_from_spawner");
  }
}

get_color_spawner(classname, fromcolor) {
  specificfromcolor = 0;

  if(isDefined(level.respawn_spawners_specific) && isDefined(level.respawn_spawners_specific[fromcolor])) {
    specificfromcolor = 1;
  }

  if(!isDefined(level.respawn_spawner)) {
    if(!isDefined(fromcolor) || !specificfromcolor) {
      assertmsg("<dev string:x39f>");
    }
  }

  if(!isDefined(classname)) {
    if(isDefined(fromcolor) && specificfromcolor) {
      return level.respawn_spawners_specific[fromcolor];
    } else {
      return level.respawn_spawner;
    }
  }

  spawners = getEntArray("color_spawner", "targetname");
  class_spawners = [];

  for(i = 0; i < spawners.size; i++) {
    class_spawners[spawners[i].classname] = spawners[i];
  }

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
    if(isDefined(fromcolor) && specificfromcolor) {
      return level.respawn_spawners_specific[fromcolor];
    } else {
      return level.respawn_spawner;
    }
  }

  if(isDefined(fromcolor) && specificfromcolor) {
    spawner.origin = level.respawn_spawners_specific[fromcolor].origin;
  } else {
    spawner.origin = level.respawn_spawner.origin;
  }

  return spawner;
}

getclasscolorhash(classname, fromcolor) {
  classcolorhash = classname;

  if(isDefined(fromcolor)) {
    classcolorhash += "##" + fromcolor;
  }

  return classcolorhash;
}

lock_spawner_for_awhile() {
  level flag::set("friendly_spawner_locked");
  wait 2;
  level flag::clear("friendly_spawner_locked");
}

player_sees_spawner() {
  level flag::clear("player_looks_away_from_spawner");
}

kill_color_replacements() {
  level flag::clear("friendly_spawner_locked");
  level notify(#"kill_color_replacements");
  level.friendly_spawners_types = undefined;
  ai = getaiarray();
  array::thread_all(ai, &remove_replace_on_death);
}

remove_replace_on_death() {
  self.replace_on_death = undefined;
}

set_force_color(_color) {
  color = shortencolor(_color);
  assert(colorislegit(color), "<dev string:x4e1>" + color);

  if(!isactor(self) && !isbot(self)) {
    set_force_color_spawner(color);
    return;
  }

  assert(isalive(self), "<dev string:x514>");
  self.script_color_axis = undefined;
  self.script_color_allies = undefined;
  self.old_forcecolor = undefined;

  if(isDefined(self.script_forcecolor)) {
    arrayremovevalue(level.arrays_of_colorforced_ai[self.team][self.script_forcecolor], self);
  }

  self.script_forcecolor = color;

  if(!isDefined(level.arrays_of_colorforced_ai[self.team][self.script_forcecolor])) {
    level.arrays_of_colorforced_ai[self.team][self.script_forcecolor] = [];
  } else if(!isarray(level.arrays_of_colorforced_ai[self.team][self.script_forcecolor])) {
    level.arrays_of_colorforced_ai[self.team][self.script_forcecolor] = array(level.arrays_of_colorforced_ai[self.team][self.script_forcecolor]);
  }

  level.arrays_of_colorforced_ai[self.team][self.script_forcecolor][level.arrays_of_colorforced_ai[self.team][self.script_forcecolor].size] = self;
  level thread remove_colorforced_ai_when_dead(self);
  self thread new_color_being_set(color);
}

remove_colorforced_ai_when_dead(ai) {
  script_forcecolor = ai.script_forcecolor;
  team = ai.team;
  ai waittill(#"death");
  level.arrays_of_colorforced_ai[team][script_forcecolor] = array::remove_undefined(level.arrays_of_colorforced_ai[team][script_forcecolor]);
}

shortencolor(color) {
  assert(isDefined(level.colorchecklist[tolower(color)]), "<dev string:x4e1>" + color);
  return level.colorchecklist[tolower(color)];
}

set_force_color_spawner(color) {
  self.script_forcecolor = color;
  self.old_forcecolor = undefined;
}

new_color_being_set(color) {
  self notify(#"new_color_being_set");
  self.new_force_color_being_set = 1;
  left_color_node();
  self endon(#"new_color_being_set", #"death");
  waittillframeend();
  waittillframeend();

  if(isDefined(self.script_forcecolor)) {
    self.currentcolorcode = level.currentcolorforced[self.team][self.script_forcecolor];
    self thread goto_current_colorindex();
  }

  self.new_force_color_being_set = undefined;
  self notify(#"done_setting_new_color");

  update_debug_friendlycolor();
}

update_debug_friendlycolor_on_death() {
  self notify(#"debug_color_update");
  self endon(#"debug_color_update");
  self waittill(#"death");

  foreach(n_key, v in level.debug_color_friendlies) {
    ai = getentbynum(n_key);

    if(!isalive(ai)) {
      arrayremoveindex(level.debug_color_friendlies, n_key, 1);
    }
  }

  level notify(#"updated_color_friendlies");
}

update_debug_friendlycolor() {
  self thread update_debug_friendlycolor_on_death();

  if(isDefined(self.script_forcecolor)) {
    level.debug_color_friendlies[self getentitynumber()] = self.script_forcecolor;
  } else {
    level.debug_color_friendlies[self getentitynumber()] = undefined;
  }

  level notify(#"updated_color_friendlies");
}

has_color() {
  if(self.team == #"allies") {
    return (isDefined(self.script_color_allies) || isDefined(self.script_forcecolor));
  } else if(self.team == #"axis") {
    return (isDefined(self.script_color_axis) || isDefined(self.script_forcecolor));
  } else if(self.team == #"team3") {
    return (isDefined(self.script_color_team3) || isDefined(self.script_forcecolor));
  }

  return false;
}

get_force_color() {
  color = self.script_forcecolor;
  return color;
}

get_force_color_guys(team, color) {
  ai = getaiteamarray(team);
  guys = [];

  for(i = 0; i < ai.size; i++) {
    guy = ai[i];

    if(!isDefined(guy.script_forcecolor)) {
      continue;
    }

    if(guy.script_forcecolor != color) {
      continue;
    }

    guys[guys.size] = guy;
  }

  return guys;
}

get_all_force_color_friendlies() {
  ai = getaiteamarray(#"allies");
  guys = [];

  for(i = 0; i < ai.size; i++) {
    guy = ai[i];

    if(!isDefined(guy.script_forcecolor)) {
      continue;
    }

    guys[guys.size] = guy;
  }

  return guys;
}

disable() {
  if(isDefined(self.new_force_color_being_set)) {
    self endon(#"death");
    self waittill(#"done_setting_new_color");
  }

  if(!isDefined(self.script_forcecolor)) {
    return;
  }

  assert(!isDefined(self.old_forcecolor), "<dev string:x54d>");
  self.old_forcecolor = self.script_forcecolor;
  arrayremovevalue(level.arrays_of_colorforced_ai[self.team][self.script_forcecolor], self);
  left_color_node();
  self.script_forcecolor = undefined;
  self.currentcolorcode = undefined;

  update_debug_friendlycolor();
}

enable() {
  if(isDefined(self.script_forcecolor)) {
    return;
  }

  if(!isDefined(self.old_forcecolor)) {
    return;
  }

  set_force_color(self.old_forcecolor);
  self.old_forcecolor = undefined;
}

is_color_ai() {
  return isDefined(self.script_forcecolor) || isDefined(self.old_forcecolor);
}

insure_player_does_not_set_forcecolor_twice_in_one_frame() {
  assert(!isDefined(self.setforcecolor), "<dev string:x5ae>");
  self.setforcecolor = 1;
  waittillframeend();

  if(!isalive(self)) {
    return;
  }

  self.setforcecolor = undefined;
}

