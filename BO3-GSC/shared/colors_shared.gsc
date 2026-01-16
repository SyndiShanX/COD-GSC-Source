/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\colors_shared.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#namespace colors;

function autoexec __init__sytem__() {
  system::register("colors", & __init__, & __main__, undefined);
}

function __init__() {
  nodes = getallnodes();
  level flag::init("player_looks_away_from_spawner");
  level flag::init("friendly_spawner_locked");
  level flag::init("respawn_friendlies");
  level.arrays_of_colorcoded_nodes = [];
  level.arrays_of_colorcoded_nodes["axis"] = [];
  level.arrays_of_colorcoded_nodes["allies"] = [];
  level.colorcoded_volumes = [];
  level.colorcoded_volumes["axis"] = [];
  level.colorcoded_volumes["allies"] = [];
  volumes = getentarray("info_volume", "classname");
  for (i = 0; i < nodes.size; i++) {
    if(isdefined(nodes[i].script_color_allies)) {
      nodes[i] add_node_to_global_arrays(nodes[i].script_color_allies, "allies");
    }
    if(isdefined(nodes[i].script_color_axis)) {
      nodes[i] add_node_to_global_arrays(nodes[i].script_color_axis, "axis");
    }
  }
  for (i = 0; i < volumes.size; i++) {
    if(isdefined(volumes[i].script_color_allies)) {
      volumes[i] add_volume_to_global_arrays(volumes[i].script_color_allies, "allies");
    }
    if(isdefined(volumes[i].script_color_axis)) {
      volumes[i] add_volume_to_global_arrays(volumes[i].script_color_axis, "axis");
    }
  }
  level.colornodes_debug_array = [];
  level.colornodes_debug_array[""] = [];
  level.colornodes_debug_array[""] = [];
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
  for (i = 0; i < level.colorlist.size; i++) {
    level.arrays_of_colorforced_ai["allies"][level.colorlist[i]] = [];
    level.arrays_of_colorforced_ai["axis"][level.colorlist[i]] = [];
    level.currentcolorforced["allies"][level.colorlist[i]] = undefined;
    level.currentcolorforced["axis"][level.colorlist[i]] = undefined;
  }
  thread debugdvars();
  thread debugcolorfriendlies();
}

function __main__() {
  foreach(trig in trigger::get_all()) {
    if(isdefined(trig.script_color_allies)) {
      trig thread trigger_issues_orders(trig.script_color_allies, "allies");
    }
    if(isdefined(trig.script_color_axis)) {
      trig thread trigger_issues_orders(trig.script_color_axis, "axis");
    }
  }
}

function debugdvars() {
  if(getdvarstring("") == "") {
    setdvar("", "");
  }
  while (true) {
    if(getdvarint("") > 0) {
      thread debug_colornodes();
    }
    wait(0.05);
  }
}

function get_team_substr() {
  if(self.team == "") {
    if(!isdefined(self.node.script_color_allies_old)) {
      return;
    }
    return self.node.script_color_allies_old;
  }
  if(self.team == "") {
    if(!isdefined(self.node.script_color_axis_old)) {
      return;
    }
    return self.node.script_color_axis_old;
  }
}

function try_to_draw_line_to_node() {
  if(!isdefined(self.node)) {
    return;
  }
  if(!isdefined(self.script_forcecolor)) {
    return;
  }
  substr = get_team_substr();
  if(!isdefined(substr)) {
    return;
  }
  if(!issubstr(substr, self.script_forcecolor)) {
    return;
  }
  recordline(self.origin + vectorscale((0, 0, 1), 25), self.node.origin, _get_debug_color(self.script_forcecolor), "", self);
  line(self.origin + vectorscale((0, 0, 1), 25), self.node.origin, _get_debug_color(self.script_forcecolor));
}

function _get_debug_color(str_color) {
  switch (str_color) {
    case "":
    case "": {
      return (1, 0, 0);
      break;
    }
    case "":
    case "": {
      return (0, 1, 0);
      break;
    }
    case "":
    case "": {
      return (0, 0, 1);
      break;
    }
    case "":
    case "": {
      return (1, 1, 0);
      break;
    }
    case "":
    case "": {
      return (1, 0.5, 0);
      break;
    }
    case "":
    case "": {
      return (0, 1, 1);
      break;
    }
    case "":
    case "": {
      return (1, 0, 1);
      break;
    }
    default: {
      println(("" + str_color) + "");
      return (0, 0, 0);
      break;
    }
  }
}

function debug_colornodes() {
  array = [];
  array[""] = [];
  array[""] = [];
  array[""] = [];
  foreach(ai in getaiarray()) {
    if(!isdefined(ai.currentcolorcode)) {
      continue;
    }
    array[ai.team][ai.currentcolorcode] = 1;
    color = (1, 1, 1);
    if(isdefined(ai.script_forcecolor)) {
      color = _get_debug_color(ai.script_forcecolor);
    }
    recordenttext(ai.currentcolorcode, ai, color, "");
    print3d(ai.origin + vectorscale((0, 0, 1), 25), ai.currentcolorcode, color, 1, 0.7);
    if(ai.team == "") {
      continue;
    }
    ai try_to_draw_line_to_node();
  }
  draw_colornodes(array, "");
  draw_colornodes(array, "");
}

function draw_colornodes(array, team) {
  keys = getarraykeys(array[team]);
  for (i = 0; i < keys.size; i++) {
    color = _get_debug_color(getsubstr(keys[i], 0, 1));
    if(isdefined(level.colornodes_debug_array[team][keys[i]])) {
      a_team_nodes = level.colornodes_debug_array[team][keys[i]];
      for (p = 0; p < a_team_nodes.size; p++) {
        print3d(a_team_nodes[p].origin, "" + keys[i], color, 1, 0.7);
        if(getdvarstring("") == "" && isdefined(a_team_nodes[p].script_color_allies_old)) {
          if(isdefined(a_team_nodes[p].color_user) && isalive(a_team_nodes[p].color_user) && isdefined(a_team_nodes[p].color_user.script_forcecolor)) {
            print3d(a_team_nodes[p].origin + (vectorscale((0, 0, -1), 5)), "" + a_team_nodes[p].script_color_allies_old, _get_debug_color(a_team_nodes[p].color_user.script_forcecolor), 0.5, 0.4);
            continue;
          }
          print3d(a_team_nodes[p].origin + (vectorscale((0, 0, -1), 5)), "" + a_team_nodes[p].script_color_allies_old, color, 0.5, 0.4);
        }
      }
    }
  }
}

function debugcolorfriendlies() {
  level.debug_color_friendlies = [];
  level.debug_color_huds = [];
  level thread debugcolorfriendliestogglewatch();
  for (;;) {
    level waittill("updated_color_friendlies");
    draw_color_friendlies();
  }
}

function debugcolorfriendliestogglewatch() {
  just_turned_on = 0;
  just_turned_off = 0;
  while (true) {
    if(getdvarstring("") == "" && !just_turned_on) {
      just_turned_on = 1;
      just_turned_off = 0;
      draw_color_friendlies();
    }
    if(getdvarstring("") != "" && !just_turned_off) {
      just_turned_off = 1;
      just_turned_on = 0;
      draw_color_friendlies();
    }
    wait(0.25);
  }
}

function get_script_palette() {
  rgb = [];
  rgb[""] = (1, 0, 0);
  rgb[""] = (1, 0.5, 0);
  rgb[""] = (1, 1, 0);
  rgb[""] = (0, 1, 0);
  rgb[""] = (0, 1, 1);
  rgb[""] = (0, 0, 1);
  rgb[""] = (1, 0, 1);
  return rgb;
}

function draw_color_friendlies() {
  level endon("updated_color_friendlies");
  keys = getarraykeys(level.debug_color_friendlies);
  colored_friendlies = [];
  colors = [];
  colors[colors.size] = "";
  colors[colors.size] = "";
  colors[colors.size] = "";
  colors[colors.size] = "";
  colors[colors.size] = "";
  colors[colors.size] = "";
  colors[colors.size] = "";
  rgb = get_script_palette();
  for (i = 0; i < colors.size; i++) {
    colored_friendlies[colors[i]] = 0;
  }
  for (i = 0; i < keys.size; i++) {
    color = level.debug_color_friendlies[keys[i]];
    colored_friendlies[color]++;
  }
  for (i = 0; i < level.debug_color_huds.size; i++) {
    level.debug_color_huds[i] destroy();
  }
  level.debug_color_huds = [];
  if(getdvarstring("") != "") {
    return;
  }
  y = 365;
  for (i = 0; i < colors.size; i++) {
    if(colored_friendlies[colors[i]] <= 0) {
      continue;
    }
    for (p = 0; p < colored_friendlies[colors[i]]; p++) {
      overlay = newhudelem();
      overlay.x = 15 + (25 * p);
      overlay.y = y;
      overlay setshader("", 16, 16);
      overlay.alignx = "";
      overlay.aligny = "";
      overlay.alpha = 1;
      overlay.color = rgb[colors[i]];
      level.debug_color_huds[level.debug_color_huds.size] = overlay;
    }
    y = y + 25;
  }
}

function player_init_color_grouping() {
  thread player_color_node();
}

function convert_color_to_short_string() {
  self.script_forcecolor = level.colorchecklist[self.script_forcecolor];
}

function goto_current_colorindex() {
  if(!isdefined(self.currentcolorcode)) {
    return;
  }
  nodes = level.arrays_of_colorcoded_nodes[self.team][self.currentcolorcode];
  if(!isdefined(nodes)) {
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
  for (i = 0; i < nodes.size; i++) {
    node = nodes[i];
    if(isalive(node.color_user) && !isplayer(node.color_user)) {
      continue;
    }
    self thread ai_sets_goal_with_delay(node);
    thread decrementcolorusers(node);
    return;
  }
  println(("" + self.export) + "");
}

function get_color_list() {
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

function get_colorcodes_from_trigger(color_team, team) {
  colorcodes = strtok(color_team, " ");
  colors = [];
  colorcodesbycolorindex = [];
  usable_colorcodes = [];
  colorlist = get_color_list();
  for (i = 0; i < colorcodes.size; i++) {
    color = undefined;
    for (p = 0; p < colorlist.size; p++) {
      if(issubstr(colorcodes[i], colorlist[p])) {
        color = colorlist[p];
        break;
      }
    }
    if(!isdefined(level.arrays_of_colorcoded_nodes[team][colorcodes[i]]) && !isdefined(level.colorcoded_volumes[team][colorcodes[i]])) {
      continue;
    }
    assert(isdefined(color), (("" + self getorigin()) + "") + colorcodes[i]);
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

function trigger_issues_orders(color_team, team) {
  self endon("death");
  array = get_colorcodes_from_trigger(color_team, team);
  colorcodes = array["colorCodes"];
  colorcodesbycolorindex = array["colorCodesByColorIndex"];
  colors = array["colors"];
  if(isdefined(self.target)) {
    a_s_targets = struct::get_array(self.target, "targetname");
    foreach(s_target in a_s_targets) {
      if(s_target.script_string === "hero_catch_up") {
        if(!isdefined(self.a_s_hero_catch_up)) {
          self.a_s_hero_catch_up = [];
        }
        if(!isdefined(self.a_s_hero_catch_up)) {
          self.a_s_hero_catch_up = [];
        } else if(!isarray(self.a_s_hero_catch_up)) {
          self.a_s_hero_catch_up = array(self.a_s_hero_catch_up);
        }
        self.a_s_hero_catch_up[self.a_s_hero_catch_up.size] = s_target;
        if(isdefined(s_target.script_num)) {
          self.num_hero_catch_up_dist = s_target.script_num;
        }
      }
    }
  }
  for (;;) {
    self waittill("trigger");
    if(isdefined(self.activated_color_trigger)) {
      self.activated_color_trigger = undefined;
      continue;
    }
    if(!isdefined(self.color_enabled) || (isdefined(self.color_enabled) && self.color_enabled)) {
      activate_color_trigger_internal(colorcodes, colors, team, colorcodesbycolorindex);
    }
    trigger_auto_disable();
  }
}

function trigger_auto_disable() {
  if(!isdefined(self.script_color_stay_on)) {
    self.script_color_stay_on = 0;
  }
  if(!isdefined(self.color_enabled)) {
    if(isdefined(self.script_color_stay_on) && self.script_color_stay_on) {
      self.color_enabled = 1;
    } else {
      self.color_enabled = 0;
    }
  }
}

function function_b8457087(team) {
  if(team == "allies") {
    self thread get_colorcodes_and_activate_trigger(self.script_color_allies, team);
  } else {
    self thread get_colorcodes_and_activate_trigger(self.script_color_axis, team);
  }
}

function get_colorcodes_and_activate_trigger(color_team, team) {
  array = get_colorcodes_from_trigger(color_team, team);
  colorcodes = array["colorCodes"];
  colorcodesbycolorindex = array["colorCodesByColorIndex"];
  colors = array["colors"];
  activate_color_trigger_internal(colorcodes, colors, team, colorcodesbycolorindex);
}

function private is_target_visible(target) {
  n_player_fov = getdvarfloat("cg_fov");
  n_dot_check = cos(n_player_fov);
  v_pos = target;
  if(!isvec(target)) {
    v_pos = target.origin;
  }
  foreach(player in level.players) {
    v_eye = player geteye();
    v_facing = anglestoforward(player getplayerangles());
    v_to_ent = vectornormalize(v_pos - v_eye);
    n_dot = vectordot(v_facing, v_to_ent);
    if(n_dot > n_dot_check) {
      return true;
    }
    if(isvec(target)) {
      a_trace = bullettrace(v_eye, target, 0, player);
      if(a_trace["fraction"] == 1) {
        return true;
      }
      continue;
    }
    if(target sightconetrace(v_eye, player) != 0) {
      return true;
    }
  }
  return false;
}

function hero_catch_up_teleport(s_teleport, n_min_dist_from_player = 400, b_disable_colors = 0, func_callback) {
  self notify("_hero_catch_up_teleport_");
  self endon("_hero_catch_up_teleport_");
  self endon("stop_hero_catch_up_teleport");
  n_min_player_dist_sq = n_min_dist_from_player * n_min_dist_from_player;
  self endon("death");
  a_teleport = s_teleport;
  if(!isdefined(a_teleport)) {
    a_teleport = [];
  } else if(!isarray(a_teleport)) {
    a_teleport = array(a_teleport);
  }
  a_teleport = array::randomize(a_teleport);
  while (true) {
    b_player_nearby = 0;
    foreach(player in level.players) {
      if(distancesquared(player.origin, self.origin) < n_min_player_dist_sq) {
        b_player_nearby = 1;
        break;
      }
    }
    if(!b_player_nearby) {
      n_ai_dist = -1;
      if(isdefined(self.goal)) {
        n_ai_dist = self calcpathlength(self.node);
      }
      foreach(s in a_teleport) {
        if(positionwouldtelefrag(s.origin)) {
          continue;
        }
        if(isdefined(s.teleport_cooldown)) {
          if(gettime() < s.teleport_cooldown) {
            continue;
          }
        }
        if(self.team == "allies" && isdefined(level.heroes)) {
          hit_hero = arraygetclosest(s.origin, level.heroes, 16);
          if(isdefined(hit_hero)) {
            continue;
          }
        }
        if(isdefined(self.node) && n_ai_dist >= 0) {
          n_teleport_distance = pathdistance(s.origin, self.node.origin);
          if(n_teleport_distance > n_ai_dist) {
            return;
          }
        }
        if(is_target_visible(self)) {
          continue;
        }
        if(is_target_visible(s.origin)) {
          continue;
        }
        if(isdefined(self.script_forcecolor) || b_disable_colors) {
          if(self forceteleport(s.origin, s.angles, 1, 1)) {
            self pathmode("move allowed");
            s.teleport_cooldown = gettime() + 2000;
            self notify("hero_catch_up_teleport");
            if(b_disable_colors) {
              disable();
            } else {
              self set_force_color(self.script_forcecolor);
            }
            if(isdefined(func_callback)) {
              self[[func_callback]]();
            }
            return;
          }
        }
      }
    } else {
      return;
    }
    wait(0.5);
  }
}

function activate_color_trigger_internal(colorcodes, colors, team, colorcodesbycolorindex) {
  for (i = 0; i < colorcodes.size; i++) {
    if(!isdefined(level.arrays_of_colorcoded_spawners[team][colorcodes[i]])) {
      continue;
    }
    arrayremovevalue(level.arrays_of_colorcoded_spawners[team][colorcodes[i]], undefined);
    for (p = 0; p < level.arrays_of_colorcoded_spawners[team][colorcodes[i]].size; p++) {
      level.arrays_of_colorcoded_spawners[team][colorcodes[i]][p].currentcolorcode = colorcodes[i];
    }
  }
  for (i = 0; i < colors.size; i++) {
    level.arrays_of_colorforced_ai[team][colors[i]] = array::remove_dead(level.arrays_of_colorforced_ai[team][colors[i]]);
    level.lastcolorforced[team][colors[i]] = level.currentcolorforced[team][colors[i]];
    level.currentcolorforced[team][colors[i]] = colorcodesbycolorindex[colors[i]];
    /# /
    #
    assert(isdefined(level.arrays_of_colorcoded_nodes[team][level.currentcolorforced[team][colors[i]]]) || isdefined(level.colorcoded_volumes[team][level.currentcolorforced[team][colors[i]]]), ((("" + colors[i]) + "") + team) + "");
  }
  ai_array = [];
  for (i = 0; i < colorcodes.size; i++) {
    if(same_color_code_as_last_time(team, colors[i])) {
      continue;
    }
    colorcode = colorcodes[i];
    if(!isdefined(level.arrays_of_colorcoded_ai[team][colorcode])) {
      continue;
    }
    ai_array[colorcode] = issue_leave_node_order_to_ai_and_get_ai(colorcode, colors[i], team);
    if(isdefined(self.a_s_hero_catch_up) && ai_array.size > 0) {
      if(isdefined(ai_array[colorcode])) {
        for (j = 0; j < ai_array[colorcode].size; j++) {
          ai = ai_array[colorcode][j];
          if(isdefined(ai.is_hero) && ai.is_hero && isdefined(ai.script_forcecolor)) {
            ai thread hero_catch_up_teleport(self.a_s_hero_catch_up);
          }
        }
      }
    }
  }
  for (i = 0; i < colorcodes.size; i++) {
    colorcode = colorcodes[i];
    if(!isdefined(ai_array[colorcode])) {
      continue;
    }
    if(same_color_code_as_last_time(team, colors[i])) {
      continue;
    }
    if(!isdefined(level.arrays_of_colorcoded_ai[team][colorcode])) {
      continue;
    }
    issue_color_order_to_ai(colorcode, colors[i], team, ai_array[colorcode]);
  }
}

function same_color_code_as_last_time(team, color) {
  if(!isdefined(level.lastcolorforced[team][color])) {
    return 0;
  }
  return level.lastcolorforced[team][color] == level.currentcolorforced[team][color];
}

function process_cover_node_with_last_in_mind_allies(node, lastcolor) {
  if(issubstr(node.script_color_allies, lastcolor)) {
    self.cover_nodes_last[self.cover_nodes_last.size] = node;
  } else {
    self.cover_nodes_first[self.cover_nodes_first.size] = node;
  }
}

function process_cover_node_with_last_in_mind_axis(node, lastcolor) {
  if(issubstr(node.script_color_axis, lastcolor)) {
    self.cover_nodes_last[self.cover_nodes_last.size] = node;
  } else {
    self.cover_nodes_first[self.cover_nodes_first.size] = node;
  }
}

function process_cover_node(node, null) {
  self.cover_nodes_first[self.cover_nodes_first.size] = node;
}

function process_path_node(node, null) {
  self.path_nodes[self.path_nodes.size] = node;
}

function prioritize_colorcoded_nodes(team, colorcode, color) {
  nodes = level.arrays_of_colorcoded_nodes[team][colorcode];
  ent = spawnstruct();
  ent.path_nodes = [];
  ent.cover_nodes_first = [];
  ent.cover_nodes_last = [];
  lastcolorforced_exists = isdefined(level.lastcolorforced[team][color]);
  for (i = 0; i < nodes.size; i++) {
    node = nodes[i];
    ent[[level.color_node_type_function[node.type][lastcolorforced_exists][team]]](node, level.lastcolorforced[team][color]);
  }
  ent.cover_nodes_first = array::randomize(ent.cover_nodes_first);
  nodes = ent.cover_nodes_first;
  for (i = 0; i < ent.cover_nodes_last.size; i++) {
    nodes[nodes.size] = ent.cover_nodes_last[i];
  }
  for (i = 0; i < ent.path_nodes.size; i++) {
    nodes[nodes.size] = ent.path_nodes[i];
  }
  level.arrays_of_colorcoded_nodes[team][colorcode] = nodes;
}

function get_prioritized_colorcoded_nodes(team, colorcode, color) {
  if(isdefined(level.arrays_of_colorcoded_nodes[team][colorcode])) {
    return level.arrays_of_colorcoded_nodes[team][colorcode];
  }
  if(isdefined(level.colorcoded_volumes[team][colorcode])) {
    return level.colorcoded_volumes[team][colorcode];
  }
}

function issue_leave_node_order_to_ai_and_get_ai(colorcode, color, team) {
  level.arrays_of_colorcoded_ai[team][colorcode] = array::remove_dead(level.arrays_of_colorcoded_ai[team][colorcode]);
  ai = level.arrays_of_colorcoded_ai[team][colorcode];
  ai = arraycombine(ai, level.arrays_of_colorforced_ai[team][color], 1, 0);
  newarray = [];
  for (i = 0; i < ai.size; i++) {
    if(isdefined(ai[i].currentcolorcode) && ai[i].currentcolorcode == colorcode) {
      continue;
    }
    newarray[newarray.size] = ai[i];
  }
  ai = newarray;
  if(!ai.size) {
    return;
  }
  for (i = 0; i < ai.size; i++) {
    ai[i] left_color_node();
  }
  return ai;
}

function issue_color_order_to_ai(colorcode, color, team, ai) {
  original_ai_array = ai;
  prioritize_colorcoded_nodes(team, colorcode, color);
  nodes = get_prioritized_colorcoded_nodes(team, colorcode, color);
  level.colornodes_debug_array[team][colorcode] = nodes;
  if(nodes.size < ai.size) {
    println(((("" + ai.size) + "") + nodes.size) + "");
  }
  counter = 0;
  ai_count = ai.size;
  for (i = 0; i < nodes.size; i++) {
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

function take_color_node(node, colorcode, trigger, counter) {
  self notify("stop_color_move");
  self.script_careful = 1;
  self.currentcolorcode = colorcode;
  self thread process_color_order_to_ai(node, trigger, counter);
}

function player_color_node() {
  for (;;) {
    playernode = undefined;
    if(!isdefined(self.node)) {
      wait(0.05);
      continue;
    }
    olduser = self.node.color_user;
    playernode = self.node;
    playernode.color_user = self;
    for (;;) {
      if(!isdefined(self.node)) {
        break;
      }
      if(self.node != playernode) {
        break;
      }
      wait(0.05);
    }
    playernode.color_user = undefined;
    playernode color_node_finds_a_user();
  }
}

function color_node_finds_a_user() {
  if(isdefined(self.script_color_allies)) {
    color_node_finds_user_from_colorcodes(self.script_color_allies, "allies");
  }
  if(isdefined(self.script_color_axis)) {
    color_node_finds_user_from_colorcodes(self.script_color_axis, "axis");
  }
}

function color_node_finds_user_from_colorcodes(colorcodestring, team) {
  if(isdefined(self.color_user)) {
    return;
  }
  colorcodes = strtok(colorcodestring, " ");
  array::thread_all_ents(colorcodes, & color_node_finds_user_for_colorcode, team);
}

function color_node_finds_user_for_colorcode(colorcode, team) {
  color = colorcode[0];
  assert(colorislegit(color), ("" + color) + "");
  if(!isdefined(level.currentcolorforced[team][color])) {
    return;
  }
  if(level.currentcolorforced[team][color] != colorcode) {
    return;
  }
  ai = get_force_color_guys(team, color);
  if(!ai.size) {
    return;
  }
  for (i = 0; i < ai.size; i++) {
    guy = ai[i];
    if(guy occupies_colorcode(colorcode)) {
      continue;
    }
    guy take_color_node(self, colorcode);
    return;
  }
}

function occupies_colorcode(colorcode) {
  if(!isdefined(self.currentcolorcode)) {
    return 0;
  }
  return self.currentcolorcode == colorcode;
}

function ai_sets_goal_with_delay(node) {
  self endon("death");
  delay = my_current_node_delays();
  if(delay) {
    wait(delay);
  }
  ai_sets_goal(node);
}

function ai_sets_goal(node) {
  self notify("stop_going_to_node");
  set_goal_and_volume(node);
  volume = level.colorcoded_volumes[self.team][self.currentcolorcode];
}

function set_goal_and_volume(node) {
  if(isdefined(self._colors_go_line)) {
    self notify("colors_go_line_done");
    self._colors_go_line = undefined;
  }
  if(isdefined(node.radius) && node.radius) {
    self.goalradius = node.radius;
  }
  if(isdefined(node.script_forcegoal) && node.script_forcegoal) {
    self thread color_force_goal(node);
  } else {
    self setgoal(node);
  }
  volume = level.colorcoded_volumes[self.team][self.currentcolorcode];
  if(isdefined(volume)) {
    self setgoal(volume);
  } else {
    self clearfixednodesafevolume();
  }
  if(isdefined(node.fixednodesaferadius)) {
    self.fixednodesaferadius = node.fixednodesaferadius;
  } else {
    self.fixednodesaferadius = 64;
  }
}

function color_force_goal(node) {
  self endon("death");
  self thread ai::force_goal(node, undefined, 1, "stop_color_forcegoal", 1);
  self util::waittill_either("goal", "stop_color_move");
  self notify("stop_color_forcegoal");
}

function careful_logic(node, volume) {
  self endon("death");
  self endon("stop_being_careful");
  self endon("stop_going_to_node");
  thread recover_from_careful_disable(node);
  for (;;) {
    wait_until_an_enemy_is_in_safe_area(node, volume);
    use_big_goal_until_goal_is_safe(node, volume);
    set_goal_and_volume(node);
  }
}

function recover_from_careful_disable(node) {
  self endon("death");
  self endon("stop_going_to_node");
  self waittill("stop_being_careful");
  set_goal_and_volume(node);
}

function use_big_goal_until_goal_is_safe(node, volume) {
  self.goalradius = 1024;
  self setgoal(self.origin);
  if(isdefined(volume)) {
    for (;;) {
      wait(1);
      if(self isknownenemyinradius(node.origin, self.fixednodesaferadius)) {
        continue;
      }
      if(self isknownenemyinvolume(volume)) {
        continue;
      }
      return;
    }
  } else {
    for (;;) {
      if(!self isknownenemyinradius(node.origin, self.fixednodesaferadius)) {
        return;
      }
      wait(1);
    }
  }
}

function wait_until_an_enemy_is_in_safe_area(node, volume) {
  if(isdefined(volume)) {
    for (;;) {
      if(self isknownenemyinradius(node.origin, self.fixednodesaferadius)) {
        return;
      }
      if(self isknownenemyinvolume(volume)) {
        return;
      }
      wait(1);
    }
  } else {
    for (;;) {
      if(self isknownenemyinradius(node.origin, self.fixednodesaferadius)) {
        return;
      }
      wait(1);
    }
  }
}

function my_current_node_delays() {
  if(!isdefined(self.node)) {
    return 0;
  }
  return self.node util::script_delay();
}

function process_color_order_to_ai(node, trigger, counter) {
  thread decrementcolorusers(node);
  self endon("stop_color_move");
  self endon("death");
  if(isdefined(trigger)) {
    trigger util::script_delay();
  }
  if(isdefined(trigger)) {
    if(isdefined(trigger.script_flag_wait)) {
      level flag::wait_till(trigger.script_flag_wait);
    }
  }
  if(!my_current_node_delays()) {
    if(isdefined(counter)) {
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
    if(isdefined(node)) {
      assert(!isalive(node.color_user), "");
      if(isalive(self.color_node.color_user) && self.color_node.color_user == self) {
        self.color_node.color_user = undefined;
      }
      self.color_node = node;
      node.color_user = self;
      self ai_sets_goal(node);
    }
  }
}

function get_best_available_colored_node() {
  assert(self.team != "");
  assert(isdefined(self.script_forcecolor), ("" + self.export) + "");
  colorcode = level.currentcolorforced[self.team][self.script_forcecolor];
  nodes = get_prioritized_colorcoded_nodes(self.team, colorcode, self.script_forcecolor);
  assert(nodes.size > 0, ((("" + self.export) + "") + self.script_forcecolor) + "");
  for (i = 0; i < nodes.size; i++) {
    if(!isalive(nodes[i].color_user)) {
      return nodes[i];
    }
  }
}

function get_best_available_new_colored_node() {
  assert(self.team != "");
  assert(isdefined(self.script_forcecolor), ("" + self.export) + "");
  colorcode = level.currentcolorforced[self.team][self.script_forcecolor];
  nodes = get_prioritized_colorcoded_nodes(self.team, colorcode, self.script_forcecolor);
  assert(nodes.size > 0, ((("" + self.export) + "") + self.script_forcecolor) + "");
  nodes = arraysort(nodes, self.origin);
  for (i = 0; i < nodes.size; i++) {
    if(!isalive(nodes[i].color_user)) {
      return nodes[i];
    }
  }
}

function process_stop_short_of_node(node) {
  self endon("stopscript");
  self endon("death");
  if(isdefined(self.node)) {
    return;
  }
  if(distancesquared(node.origin, self.origin) < 1024) {
    reached_node_but_could_not_claim_it(node);
    return;
  }
  currenttime = gettime();
  wait_for_killanimscript_or_time(1);
  newtime = gettime();
  if((newtime - currenttime) >= 1000) {
    reached_node_but_could_not_claim_it(node);
  }
}

function wait_for_killanimscript_or_time(timer) {
  self endon("killanimscript");
  wait(timer);
}

function reached_node_but_could_not_claim_it(node) {
  ai = getaiarray();
  for (i = 0; i < ai.size; i++) {
    if(!isdefined(ai[i].node)) {
      continue;
    }
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

function decrementcolorusers(node) {
  node.color_user = self;
  self.color_node = node;
  self.color_node_debug_val = 1;
  self endon("stop_color_move");
  self waittill("death");
  self.color_node.color_user = undefined;
}

function colorislegit(color) {
  for (i = 0; i < level.colorlist.size; i++) {
    if(color == level.colorlist[i]) {
      return true;
    }
  }
  return false;
}

function add_volume_to_global_arrays(colorcode, team) {
  colors = strtok(colorcode, " ");
  for (p = 0; p < colors.size; p++) {
    assert(!isdefined(level.colorcoded_volumes[team][colors[p]]), "" + colors[p]);
    level.colorcoded_volumes[team][colors[p]] = self;
  }
}

function add_node_to_global_arrays(colorcode, team) {
  self.color_user = undefined;
  colors = strtok(colorcode, " ");
  for (p = 0; p < colors.size; p++) {
    if(isdefined(level.arrays_of_colorcoded_nodes[team]) && isdefined(level.arrays_of_colorcoded_nodes[team][colors[p]])) {
      if(!isdefined(level.arrays_of_colorcoded_nodes[team][colors[p]])) {
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

function left_color_node() {
  self.color_node_debug_val = undefined;
  if(!isdefined(self.color_node)) {
    return;
  }
  if(isdefined(self.color_node.color_user) && self.color_node.color_user == self) {
    self.color_node.color_user = undefined;
  }
  self.color_node = undefined;
  self notify("stop_color_move");
}

function getcolornumberarray() {
  array = [];
  if(issubstr(self.classname, "axis") || issubstr(self.classname, "enemy")) {
    array["team"] = "axis";
    array["colorTeam"] = self.script_color_axis;
  }
  if(issubstr(self.classname, "ally") || issubstr(self.classname, "civilian")) {
    array["team"] = "allies";
    array["colorTeam"] = self.script_color_allies;
  }
  if(!isdefined(array["colorTeam"])) {
    array = undefined;
  }
  return array;
}

function removespawnerfromcolornumberarray() {
  colornumberarray = getcolornumberarray();
  if(!isdefined(colornumberarray)) {
    return;
  }
  team = colornumberarray["team"];
  colorteam = colornumberarray["colorTeam"];
  colors = strtok(colorteam, " ");
  for (i = 0; i < colors.size; i++) {
    arrayremovevalue(level.arrays_of_colorcoded_spawners[team][colors[i]], self);
  }
}

function add_cover_node(type) {
  level.color_node_type_function[type][1]["allies"] = & process_cover_node_with_last_in_mind_allies;
  level.color_node_type_function[type][1]["axis"] = & process_cover_node_with_last_in_mind_axis;
  level.color_node_type_function[type][0]["allies"] = & process_cover_node;
  level.color_node_type_function[type][0]["axis"] = & process_cover_node;
}

function add_path_node(type) {
  level.color_node_type_function[type][1]["allies"] = & process_path_node;
  level.color_node_type_function[type][0]["allies"] = & process_path_node;
  level.color_node_type_function[type][1]["axis"] = & process_path_node;
  level.color_node_type_function[type][0]["axis"] = & process_path_node;
}

function colornode_spawn_reinforcement(classname, fromcolor) {
  level endon("kill_color_replacements");
  friendly_spawners_type = getclasscolorhash(classname, fromcolor);
  while (level.friendly_spawners_types[friendly_spawners_type] > 0) {
    spawn = undefined;
    for (;;) {
      if(!level flag::get("respawn_friendlies")) {
        if(!isdefined(level.friendly_respawn_vision_checker_thread)) {
          thread friendly_spawner_vision_checker();
        }
        for (;;) {
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
      level.friendly_spawners_types[friendly_spawners_type] = level.friendly_spawners_types[friendly_spawners_type] - 1;
      spawner util::script_wait();
      spawn = spawner spawner::spawn();
      if(spawner::spawn_failed(spawn)) {
        thread lock_spawner_for_awhile();
        wait(1);
        continue;
      }
      level notify("reinforcement_spawned", spawn);
      break;
    }
    for (;;) {
      if(!isdefined(fromcolor)) {
        break;
      }
      if(get_color_from_order(fromcolor, level.current_color_order) == "none") {
        break;
      }
      fromcolor = level.current_color_order[fromcolor];
    }
    if(isdefined(fromcolor)) {
      spawn set_force_color(fromcolor);
    }
    thread lock_spawner_for_awhile();
    if(isdefined(level.friendly_startup_thread)) {
      spawn thread[[level.friendly_startup_thread]]();
    }
    spawn thread colornode_replace_on_death();
  }
}

function colornode_replace_on_death() {
  level endon("kill_color_replacements");
  assert(isalive(self), "");
  self endon("_disable_reinforcement");
  if(self.team == "axis") {
    return;
  }
  if(isdefined(self.replace_on_death)) {
    return;
  }
  self.replace_on_death = 1;
  assert(!isdefined(self.respawn_on_death), ("" + self.export) + "");
  classname = self.classname;
  color = self.script_forcecolor;
  waittillframeend();
  if(isalive(self)) {
    self waittill("death");
  }
  color_order = level.current_color_order;
  if(!isdefined(self.script_forcecolor)) {
    return;
  }
  friendly_spawners_type = getclasscolorhash(classname, self.script_forcecolor);
  if(!isdefined(level.friendly_spawners_types) || !isdefined(level.friendly_spawners_types[friendly_spawners_type]) || level.friendly_spawners_types[friendly_spawners_type] <= 0) {
    level.friendly_spawners_types[friendly_spawners_type] = 1;
    thread colornode_spawn_reinforcement(classname, self.script_forcecolor);
  } else {
    level.friendly_spawners_types[friendly_spawners_type] = level.friendly_spawners_types[friendly_spawners_type] + 1;
  }
  if(isdefined(self) && isdefined(self.script_forcecolor)) {
    color = self.script_forcecolor;
  }
  if(isdefined(self) && isdefined(self.origin)) {
    origin = self.origin;
  }
  for (;;) {
    if(get_color_from_order(color, color_order) == "none") {
      return;
    }
    correct_colored_friendlies = get_force_color_guys("allies", color_order[color]);
    correct_colored_friendlies = array::filter_classname(correct_colored_friendlies, 1, classname);
    if(!correct_colored_friendlies.size) {
      wait(2);
      continue;
    }
    players = getplayers();
    correct_colored_guy = arraysort(correct_colored_friendlies, players[0].origin, 1)[0];
    assert(correct_colored_guy.script_forcecolor != color, ("" + color) + "");
    waittillframeend();
    if(!isalive(correct_colored_guy)) {
      continue;
    }
    correct_colored_guy set_force_color(color);
    if(isdefined(level.friendly_promotion_thread)) {
      correct_colored_guy[[level.friendly_promotion_thread]](color);
    }
    color = color_order[color];
  }
}

function get_color_from_order(color, color_order) {
  if(!isdefined(color)) {
    return "none";
  }
  if(!isdefined(color_order)) {
    return "none";
  }
  if(!isdefined(color_order[color])) {
    return "none";
  }
  return color_order[color];
}

function friendly_spawner_vision_checker() {
  level.friendly_respawn_vision_checker_thread = 1;
  successes = 0;
  for (;;) {
    level flag::wait_till_clear("respawn_friendlies");
    wait(1);
    if(!isdefined(level.respawn_spawner)) {
      continue;
    }
    spawner = level.respawn_spawner;
    players = getplayers();
    player_sees_spawner = 0;
    for (q = 0; q < players.size; q++) {
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
      if(successes < 3) {
        continue;
      }
    }
    if(player_sees_spawner) {
      continue;
    }
    level flag::set("player_looks_away_from_spawner");
  }
}

function get_color_spawner(classname, fromcolor) {
  specificfromcolor = 0;
  if(isdefined(level.respawn_spawners_specific) && isdefined(level.respawn_spawners_specific[fromcolor])) {
    specificfromcolor = 1;
  }
  if(!isdefined(level.respawn_spawner)) {
    if(!isdefined(fromcolor) || !specificfromcolor) {
      assertmsg("");
    }
  }
  if(!isdefined(classname)) {
    if(isdefined(fromcolor) && specificfromcolor) {
      return level.respawn_spawners_specific[fromcolor];
    }
    return level.respawn_spawner;
  }
  spawners = getentarray("color_spawner", "targetname");
  class_spawners = [];
  for (i = 0; i < spawners.size; i++) {
    class_spawners[spawners[i].classname] = spawners[i];
  }
  spawner = undefined;
  keys = getarraykeys(class_spawners);
  for (i = 0; i < keys.size; i++) {
    if(!issubstr(class_spawners[keys[i]].classname, classname)) {
      continue;
    }
    spawner = class_spawners[keys[i]];
    break;
  }
  if(!isdefined(spawner)) {
    if(isdefined(fromcolor) && specificfromcolor) {
      return level.respawn_spawners_specific[fromcolor];
    }
    return level.respawn_spawner;
  }
  if(isdefined(fromcolor) && specificfromcolor) {
    spawner.origin = level.respawn_spawners_specific[fromcolor].origin;
  } else {
    spawner.origin = level.respawn_spawner.origin;
  }
  return spawner;
}

function getclasscolorhash(classname, fromcolor) {
  classcolorhash = classname;
  if(isdefined(fromcolor)) {
    classcolorhash = classcolorhash + ("##" + fromcolor);
  }
  return classcolorhash;
}

function lock_spawner_for_awhile() {
  level flag::set("friendly_spawner_locked");
  wait(2);
  level flag::clear("friendly_spawner_locked");
}

function player_sees_spawner() {
  level flag::clear("player_looks_away_from_spawner");
}

function kill_color_replacements() {
  level flag::clear("friendly_spawner_locked");
  level notify("kill_color_replacements");
  level.friendly_spawners_types = undefined;
  ai = getaiarray();
  array::thread_all(ai, & remove_replace_on_death);
}

function remove_replace_on_death() {
  self.replace_on_death = undefined;
}

function set_force_color(_color) {
  color = shortencolor(_color);
  assert(colorislegit(color), "" + color);
  if(!isactor(self)) {
    set_force_color_spawner(color);
    return;
  }
  assert(isalive(self), "");
  self.fixednodesaferadius = 64;
  self.script_color_axis = undefined;
  self.script_color_allies = undefined;
  self.old_forcecolor = undefined;
  if(isdefined(self.script_forcecolor)) {
    arrayremovevalue(level.arrays_of_colorforced_ai[self.team][self.script_forcecolor], self);
  }
  self.script_forcecolor = color;
  if(!isdefined(level.arrays_of_colorforced_ai[self.team][self.script_forcecolor])) {
    level.arrays_of_colorforced_ai[self.team][self.script_forcecolor] = [];
  } else if(!isarray(level.arrays_of_colorforced_ai[self.team][self.script_forcecolor])) {
    level.arrays_of_colorforced_ai[self.team][self.script_forcecolor] = array(level.arrays_of_colorforced_ai[self.team][self.script_forcecolor]);
  }
  level.arrays_of_colorforced_ai[self.team][self.script_forcecolor][level.arrays_of_colorforced_ai[self.team][self.script_forcecolor].size] = self;
  level thread remove_colorforced_ai_when_dead(self);
  self thread new_color_being_set(color);
}

function remove_colorforced_ai_when_dead(ai) {
  script_forcecolor = ai.script_forcecolor;
  team = ai.team;
  ai waittill("death");
  level.arrays_of_colorforced_ai[team][script_forcecolor] = array::remove_undefined(level.arrays_of_colorforced_ai[team][script_forcecolor]);
}

function shortencolor(color) {
  assert(isdefined(level.colorchecklist[tolower(color)]), "" + color);
  return level.colorchecklist[tolower(color)];
}

function set_force_color_spawner(color) {
  self.script_forcecolor = color;
  self.old_forcecolor = undefined;
}

function new_color_being_set(color) {
  self notify("new_color_being_set");
  self.new_force_color_being_set = 1;
  left_color_node();
  self endon("new_color_being_set");
  self endon("death");
  waittillframeend();
  waittillframeend();
  if(isdefined(self.script_forcecolor)) {
    self.currentcolorcode = level.currentcolorforced[self.team][self.script_forcecolor];
    self thread goto_current_colorindex();
  }
  self.new_force_color_being_set = undefined;
  self notify("done_setting_new_color");
  update_debug_friendlycolor();
}

function update_debug_friendlycolor_on_death() {
  self notify("debug_color_update");
  self endon("debug_color_update");
  self waittill("death");
  a_keys = getarraykeys(level.debug_color_friendlies);
  foreach(n_key in a_keys) {
    ai = getentbynum(n_key);
    if(!isalive(ai)) {
      arrayremoveindex(level.debug_color_friendlies, n_key, 1);
    }
  }
  level notify("updated_color_friendlies");
}

function update_debug_friendlycolor() {
  self thread update_debug_friendlycolor_on_death();
  if(isdefined(self.script_forcecolor)) {
    level.debug_color_friendlies[self getentitynumber()] = self.script_forcecolor;
  } else {
    level.debug_color_friendlies[self getentitynumber()] = undefined;
  }
  level notify("updated_color_friendlies");
}

function has_color() {
  if(self.team == "axis") {
    return isdefined(self.script_color_axis) || isdefined(self.script_forcecolor);
  }
  return isdefined(self.script_color_allies) || isdefined(self.script_forcecolor);
}

function get_force_color() {
  color = self.script_forcecolor;
  return color;
}

function get_force_color_guys(team, color) {
  ai = getaiteamarray(team);
  guys = [];
  for (i = 0; i < ai.size; i++) {
    guy = ai[i];
    if(!isdefined(guy.script_forcecolor)) {
      continue;
    }
    if(guy.script_forcecolor != color) {
      continue;
    }
    guys[guys.size] = guy;
  }
  return guys;
}

function get_all_force_color_friendlies() {
  ai = getaiteamarray("allies");
  guys = [];
  for (i = 0; i < ai.size; i++) {
    guy = ai[i];
    if(!isdefined(guy.script_forcecolor)) {
      continue;
    }
    guys[guys.size] = guy;
  }
  return guys;
}

function disable(stop_being_careful) {
  if(isdefined(self.new_force_color_being_set)) {
    self endon("death");
    self waittill("done_setting_new_color");
  }
  if(isdefined(stop_being_careful) && stop_being_careful) {
    self notify("stop_going_to_node");
    self notify("stop_being_careful");
  }
  self clearfixednodesafevolume();
  if(!isdefined(self.script_forcecolor)) {
    return;
  }
  assert(!isdefined(self.old_forcecolor), "");
  self.old_forcecolor = self.script_forcecolor;
  arrayremovevalue(level.arrays_of_colorforced_ai[self.team][self.script_forcecolor], self);
  left_color_node();
  self.script_forcecolor = undefined;
  self.currentcolorcode = undefined;
  update_debug_friendlycolor();
}

function enable() {
  if(isdefined(self.script_forcecolor)) {
    return;
  }
  if(!isdefined(self.old_forcecolor)) {
    return;
  }
  set_force_color(self.old_forcecolor);
  self.old_forcecolor = undefined;
}

function is_color_ai() {
  return isdefined(self.script_forcecolor) || isdefined(self.old_forcecolor);
}

function insure_player_does_not_set_forcecolor_twice_in_one_frame() {
  /# /
  #
  assert(!isdefined(self.setforcecolor), "");
  self.setforcecolor = 1;
  waittillframeend();
  if(!isalive(self)) {
    return;
  }
  self.setforcecolor = undefined;
}