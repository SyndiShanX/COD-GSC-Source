/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\colors.gsc
***********************************************/

#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\utility;
#namespace colors;

function init_colors() {
  if(!add_init_script("colors", &init_colors)) {
    return;
  }

  flag_init("respawn_friendlies");
  registersharedfunc("colors", "set_force_color", &set_force_color);
  thread init_color_grouping();
}

function init_color_grouping() {
  nodes = getallnodes();
  flag_init("player_looks_away_from_spawner");
  flag_init("friendly_spawner_locked");
  level.arrays_of_colorcoded_nodes = [];
  level.arrays_of_colorcoded_nodes["axis"] = [];
  level.arrays_of_colorcoded_nodes["allies"] = [];
  level.arrays_of_colorcoded_volumes = [];
  level.arrays_of_colorcoded_volumes["axis"] = [];
  level.arrays_of_colorcoded_volumes["allies"] = [];
  triggers = [];
  triggers = array_combine(triggers, getEntArray("trigger_multiple", "code_classname"));
  triggers = array_combine(triggers, getEntArray("trigger_radius", "code_classname"));
  triggers = array_combine(triggers, getEntArray("trigger_once", "code_classname"));
  level.color_teams = [];
  level.color_teams["allies"] = "allies";
  level.color_teams["axis"] = "axis";
  level.color_teams["team3"] = "axis";
  level.color_teams["neutral"] = "neutral";
  volumes = getEntArray("info_volume", "code_classname");

  foreach(node in nodes) {
    if(isDefined(node.script_color_allies)) {
      node add_node_to_global_arrays(node.script_color_allies, "allies");
    }

    if(isDefined(node.script_color_axis)) {
      node add_node_to_global_arrays(node.script_color_axis, "axis");
    }
  }

  foreach(volume in volumes) {
    if(isDefined(volume.script_color_allies)) {
      volume add_volume_to_global_arrays(volume.script_color_allies, "allies");
    }

    if(isDefined(volume.script_color_axis)) {
      volume add_volume_to_global_arrays(volume.script_color_axis, "axis");
    }
  }

  foreach(trigger in triggers) {
    if(isDefined(trigger.script_color_allies)) {
      trigger thread trigger_issues_orders(trigger.script_color_allies, "allies");
    }

    if(isDefined(trigger.script_color_axis)) {
      trigger thread trigger_issues_orders(trigger.script_color_axis, "axis");
    }
  }

  level.colornodes_debug_array = [];
  level.colornodes_debug_array["<dev string:x1c>"] = [];
  level.colornodes_debug_array["<dev string:x23>"] = [];
  level.colorvolumes_debug_array["<dev string:x1c>"] = [];
  level.colorvolumes_debug_array["<dev string:x23>"] = [];

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
  add_path_node("Ambush");
  add_path_node("Guard");
  add_path_node("Path");
  add_path_node("Path 3D");
  add_path_node("Exposed");
  add_path_node("Exposed 3D");
  add_path_node("Cover 3D");
  add_path_node("Cover Stand 3D");
  add_cover_node("Begin 3D");
  add_cover_node("End 3D");
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

  foreach(color in level.colorlist) {
    level.arrays_of_colorforced_ai["allies"][color] = [];
    level.arrays_of_colorforced_ai["axis"][color] = [];
    level.currentcolorforced["allies"][color] = undefined;
    level.currentcolorforced["axis"][color] = undefined;
  }

  thread player_color_node();
  spawners = getspawnerteamarray("allies");
  level._color_friendly_spawners = [];

  foreach(spawner in spawners) {
    if(!isDefined(spawner.script_forcecolor)) {
      continue;
    }

    level._color_friendly_spawners[spawner.classname] = spawner;
  }
}

function convert_color_to_short_string() {
  self.script_forcecolor = level.colorchecklist[self.script_forcecolor];
}

function ai_picks_destination(currentcolorcode) {
  if(isDefined(self.script_forcecolor)) {
    convert_color_to_short_string();
    self.currentcolorcode = currentcolorcode;
    color = self.script_forcecolor;
    assert(colorislegit(color), "AI at origin " + self.origin + " has non - legit forced color " + color + ". Legit colors are red blue yellow cyan green purple and orange.");
    level.arrays_of_colorforced_ai[get_team()][color] = array_add(level.arrays_of_colorforced_ai[get_team()][color], self);
    thread goto_current_colorindex();
    return;
  }
}

function goto_current_colorindex() {
  if(!isDefined(self.currentcolorcode)) {
    return;
  }

  nodes = level.arrays_of_colorcoded_nodes[get_team()][self.currentcolorcode];
  left_color_node();

  if(!isalive(self)) {
    return;
  }

  if(!has_color()) {
    return;
  }

  if(!isDefined(nodes)) {
    volume = level.arrays_of_colorcoded_volumes[get_team()][self.currentcolorcode];
    assertex(isDefined(volume), "No nodes or volumes for guy at colorcode " + self.currentcolorcode);
    send_ai_to_colorvolume(volume, self.currentcolorcode);
    return;
  }

  for(i = 0; i < nodes.size; i++) {
    node = nodes[i];

    if(isalive(node.color_user) && !isPlayer(node.color_user)) {
      continue;
    }

    thread ai_sets_goal_with_delay(node);
    thread decrementcolorusers(node);
    return;
  }

  no_node_to_go_to();
}

function no_node_to_go_to() {
  msg = "AI with export " + self.export+" was told to go to color node but had no node to go to.";

  if(getdvarint(@ "debug_colornodes") || getdvarint(@ "hash_10b43cfca1168946")) {
    iprintln(msg);
    return;
  }

  println(msg);
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

function array_remove_dupes(array) {
  var_f2bfbf2b4a95d948 = [];

  foreach(val in array) {
    var_f2bfbf2b4a95d948[val] = 1;
  }

  new_array = [];

  foreach(_ in var_f2bfbf2b4a95d948) {
    new_array[new_array.size] = index;
  }

  return new_array;
}

function get_colorcodes_from_trigger(color_team, team) {
  return get_colorcodes(color_team, team);
}

function get_colorcodes(color_team, team) {
  colorcodes = strtok(color_team, " ");
  colorcodes = array_remove_dupes(colorcodes);
  colors = [];
  colorcodesbycolorindex = [];
  usable_colorcodes = [];
  colorlist = get_color_list();

  foreach(colorcode in colorcodes) {
    color = undefined;

    foreach(color in colorlist) {
      if(issubstr(colorcode, color)) {
        break;
      }
    }

    assertex(isDefined(color), "Trigger at origin " + self getorigin() + " had strange color index " + colorcode);

    if(!colorcode_is_used_in_map(team, colorcode)) {
      continue;
    }

    colorcodesbycolorindex[color] = colorcode;
    colors[colors.size] = color;
    usable_colorcodes[usable_colorcodes.size] = colorcode;
  }

  colorcodes = usable_colorcodes;
  array = [];
  array["colorCodes"] = colorcodes;
  array["colorCodesByColorIndex"] = colorcodesbycolorindex;
  array["colors"] = colors;
  return array;
}

function colorcode_is_used_in_map(team, colorcode) {
  if(isDefined(level.arrays_of_colorcoded_nodes[team][colorcode])) {
    return true;
  }

  return isDefined(level.arrays_of_colorcoded_volumes[team][colorcode]);
}

function trigger_issues_orders(color_team, team) {
  self endon("death");

  for(;;) {
    self waittill("trigger");

    if(isDefined(self.activated_color_trigger)) {
      self.activated_color_trigger = undefined;
      continue;
    }

    get_colorcodes_and_activate_trigger(color_team, team);

    if(isDefined(self.script_oneway) && self.script_oneway) {
      thread trigger_delete_target_chain();
      assertmsg("why am I here?");
    }
  }
}

function trigger_delete_target_chain() {
  array = [];
  current_array[0] = self;

  while(current_array.size) {
    targeting = [];

    foreach(current in current_array) {
      array[array.size] = current;

      if(!isDefined(current.targetname)) {
        continue;
      }

      temp_array = getEntArray(current.targetname, "target");

      foreach(temp in temp_array) {
        targeting[targeting.size] = temp;
      }

      temp_array = undefined;
    }

    current_array = [];

    foreach(target in targeting) {
      if(!isDefined(target.script_color_allies) && !isDefined(target.script_color_axis)) {
        continue;
      }

      current_array[current_array.size] = target;
    }
  }

  array_delete(array);
}

function activate_color_trigger(team) {
  if(team == "allies") {
    thread get_colorcodes_and_activate_trigger(self.script_color_allies, team);
    return;
  }

  thread get_colorcodes_and_activate_trigger(self.script_color_axis, team);
}

function get_colorcodes_and_activate_trigger(color_team, team) {
  array = get_colorcodes_from_trigger(color_team, team);
  colorcodes = array["colorCodes"];
  colorcodesbycolorindex = array["colorCodesByColorIndex"];
  colors = array["colors"];
  activate_color_code_internal(colorcodes, colors, team, colorcodesbycolorindex);
}

function activate_color_code_internal(colorcodes, colors, team, colorcodesbycolorindex) {
  for(i = 0; i < colorcodes.size; i++) {
    if(!isDefined(level.arrays_of_colorcoded_spawners[team][colorcodes[i]])) {
      continue;
    }

    level.arrays_of_colorcoded_spawners[team][colorcodes[i]] = array_removeundefined(level.arrays_of_colorcoded_spawners[team][colorcodes[i]]);

    for(p = 0; p < level.arrays_of_colorcoded_spawners[team][colorcodes[i]].size; p++) {
      level.arrays_of_colorcoded_spawners[team][colorcodes[i]][p].currentcolorcode = colorcodes[i];
    }
  }

  foreach(color in colors) {
    level.arrays_of_colorforced_ai[team][color] = array_removedead(level.arrays_of_colorforced_ai[team][color]);
    level.lastcolorforced[team][color] = level.currentcolorforced[team][color];
    level.currentcolorforced[team][color] = colorcodesbycolorindex[color];

    color_forced = level.currentcolorforced[team][color];
    color_defined = isDefined(level.arrays_of_colorcoded_nodes[team][color_forced]) || isDefined(level.arrays_of_colorcoded_volumes[team][color_forced]);
    assertex(color_defined, "<dev string:x28>" + color + "<dev string:x48>" + team + "<dev string:x65>");
  }

  ai_array = [];
  actually_triggered = 0;

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

    actually_triggered = 1;
    issue_color_order_to_ai(colorcode, colors[i], team, ai_array[colorcode]);
  }

  if(actually_triggered) {
    level notify("new_color_trigger", self);
  }
}

function same_color_code_as_last_time(team, color) {
  if(!isDefined(level.lastcolorforced[team][color])) {
    return false;
  }

  return level.lastcolorforced[team][color] == level.currentcolorforced[team][color];
}

function process_cover_node_with_last_in_mind_allies(node, var_3ca71f162ca5c520) {
  if(issubstr(node.script_color_allies, var_3ca71f162ca5c520)) {
    self.cover_nodes_last[self.cover_nodes_last.size] = node;
    return;
  }

  self.cover_nodes_first[self.cover_nodes_first.size] = node;
}

function process_cover_node_with_last_in_mind_axis(node, var_3ca71f162ca5c520) {
  if(issubstr(node.script_color_axis, var_3ca71f162ca5c520)) {
    self.cover_nodes_last[self.cover_nodes_last.size] = node;
    return;
  }

  self.cover_nodes_first[self.cover_nodes_first.size] = node;
}

function process_cover_node(node, null) {
  self.cover_nodes_first[self.cover_nodes_first.size] = node;
}

function process_path_node(node, null) {
  self.path_nodes[self.path_nodes.size] = node;
}

function prioritize_colorcoded_nodes(team, colorcode, color) {
  nodes = level.arrays_of_colorcoded_nodes[team][colorcode];
  ent = spawnStruct();
  ent.path_nodes = [];
  ent.cover_nodes_first = [];
  ent.cover_nodes_last = [];
  lastcolorforced_exists = isDefined(level.lastcolorforced[team][color]);

  foreach(node in nodes) {
    ent[[level.color_node_type_function[node.type][lastcolorforced_exists][team]]](node, level.lastcolorforced[team][color]);
  }

  ent.cover_nodes_first = array_randomize(ent.cover_nodes_first);
  lastnodes = [];
  nodes = [];

  foreach(node in ent.cover_nodes_first) {
    if(isDefined(node.script_colorlast)) {
      lastnodes[lastnodes.size] = node;
      nodes[index] = undefined;
      continue;
    }

    nodes[nodes.size] = node;
  }

  for(i = 0; i < ent.cover_nodes_last.size; i++) {
    nodes[nodes.size] = ent.cover_nodes_last[i];
  }

  for(i = 0; i < ent.path_nodes.size; i++) {
    nodes[nodes.size] = ent.path_nodes[i];
  }

  foreach(node in lastnodes) {
    nodes[nodes.size] = node;
  }

  level.arrays_of_colorcoded_nodes[team][colorcode] = nodes;
}

function get_prioritized_colorcoded_nodes(team, colorcode, color) {
  return level.arrays_of_colorcoded_nodes[team][colorcode];
}

function get_colorcoded_volume(team, colorcode) {
  return level.arrays_of_colorcoded_volumes[team][colorcode];
}

function issue_leave_node_order_to_ai_and_get_ai(colorcode, color, team) {
  level.arrays_of_colorcoded_ai[team][colorcode] = array_removedead(level.arrays_of_colorcoded_ai[team][colorcode]);
  ai = level.arrays_of_colorcoded_ai[team][colorcode];
  ai = array_combine(ai, level.arrays_of_colorforced_ai[team][color]);
  newarray = [];

  foreach(guy in ai) {
    if(isDefined(guy.currentcolorcode) && guy.currentcolorcode == colorcode) {
      continue;
    }

    newarray[newarray.size] = guy;
  }

  ai = newarray;

  if(!ai.size) {
    return;
  }

  array_thread(ai, &left_color_node);
  return ai;
}

function send_ai_to_colorvolume(volume, colorcode) {
  self notify("stop_color_move");
  self.currentcolorcode = colorcode;

  if(!my_current_node_delays()) {
    wait randomfloatrange(0.1, 0.25);
  }

  if(isDefined(volume.target)) {
    node = getnode(volume.target, "targetname");

    if(isDefined(node)) {
      self setgoalnode(node);
    }
  }

  if(!isDefined(self.og_color_fixednode)) {
    self.og_color_fixednode = self.fixednode;
  }

  self.fixednode = 0;
  self setgoalvolumeauto(volume, volume get_cover_volume_forward());
}

function issue_color_order_to_ai(colorcode, color, team, ai) {
  original_ai_array = ai;

  level.colornodes_debug_array[team][colorcode] = undefined;

  level.colorvolumes_debug_array[team][colorcode] = undefined;

  stack = isDefined(self.script_stack);
  nodes = [];
  volume = undefined;

  if(isDefined(level.arrays_of_colorcoded_nodes[team][colorcode])) {
    if(!stack) {
      prioritize_colorcoded_nodes(team, colorcode, color);
    }

    nodes = get_prioritized_colorcoded_nodes(team, colorcode, color);

    level.colornodes_debug_array[team][colorcode] = nodes;

    if(nodes.size < ai.size) {
      msg = "<dev string:x81>" + ai.size + "<dev string:xae>" + nodes.size + "<dev string:xb9>";

      if(getdvarint(@ "debug_colornodes") || getdvarint(@ "hash_10b43cfca1168946")) {
        iprintln(msg);
      } else {
        println(msg);
      }
    }

    if(stack) {
      stackstruct = getStruct(self.target, "targetname");
      nodes = sortbydistance(nodes, stackstruct.origin);
    }

    counter = 0;
    ai_count = ai.size;

    for(i = 0; i < nodes.size; i++) {
      node = nodes[i];

      if(isalive(node.color_user)) {
        continue;
      }

      closestai = getclosest(node.origin, ai);
      assert(isalive(closestai));
      ai = array_remove(ai, closestai);
      closestai take_color_node(node, colorcode, self, counter);
      counter++;

      if(!ai.size) {
        return;
      }
    }

    return;
  }

  volume = get_colorcoded_volume(team, colorcode);

  if(!isDefined(volume)) {
    assertex(isDefined(volume), "<dev string:xc1>" + colorcode + "<dev string:xe1>");
  } else {
    assertex(volume.size == 1, "<dev string:x10b>" + colorcode + "<dev string:xe1>");
  }

  level.colorvolumes_debug_array[team][colorcode] = volume;

  array_thread(ai, &send_ai_to_colorvolume, volume, colorcode);
}

function take_color_node(node, colorcode, trigger, counter) {
  self notify("stop_color_move");
  self.currentcolorcode = colorcode;
  thread process_color_order_to_ai(node, trigger, counter);
}

function player_color_node() {
  for(;;) {
    playernode = undefined;

    if(!isDefined(level.player.node)) {
      wait 0.05;
      continue;
    }

    olduser = level.player.node.color_user;
    playernode = level.player.node;
    playernode.color_user = level.player;

    for(;;) {
      if(!isDefined(level.player.node)) {
        break;
      }

      if(level.player.node != playernode) {
        break;
      }

      wait 0.05;
    }

    playernode.color_user = undefined;
    playernode color_node_finds_a_user();
  }
}

function color_node_finds_a_user() {
  if(isDefined(self.script_color_allies)) {
    color_node_finds_user_from_colorcodes(self.script_color_allies, "allies");
  }

  if(isDefined(self.script_color_axis)) {
    color_node_finds_user_from_colorcodes(self.script_color_axis, "axis");
  }
}

function color_node_finds_user_from_colorcodes(colorcodestring, team) {
  if(isDefined(self.color_user)) {
    return;
  }

  colorcodes = strtok(colorcodestring, " ");
  colorcodes = array_remove_dupes(colorcodes);
  array_levelthread(colorcodes, &color_node_finds_user_for_colorcode, team);
}

function color_node_finds_user_for_colorcode(colorcode, team) {
  color = colorcode[0];
  assertex(colorislegit(color), "Color " + color + " is not legit");

  if(!isDefined(level.currentcolorforced[team][color])) {
    return;
  }

  if(level.currentcolorforced[team][color] != colorcode) {
    return;
  }

  ai = get_force_color_guys(team, color);

  for(i = 0; i < ai.size; i++) {
    guy = ai[i];

    if(guy occupies_colorcode(colorcode)) {
      continue;
    }

    guy take_color_node(self, colorcode);
    return;
  }
}

function occupies_colorcode(colorcode) {
  if(!isDefined(self.currentcolorcode)) {
    return false;
  }

  return self.currentcolorcode == colorcode;
}

function ai_sets_goal_with_delay(node) {
  self endon("death");
  self endon("stop_color_move");
  my_current_node_delays();
  thread ai_sets_goal(node);
}

function ai_sets_goal(node) {
  self notify("stop_going_to_node");
  set_goal_and_volume(node);
  volume = level.arrays_of_colorcoded_volumes[get_team()][self.currentcolorcode];

  if(isDefined(self.script_careful)) {
    thread careful_logic(node, volume);
  }
}

function set_goal_and_volume(node) {
  if(isDefined(self.colornode_func)) {
    self thread[[self.colornode_func]](node);
  }

  if(isDefined(self._colors_go_line)) {
    thread scripts\sp\anim::anim_single_queue(self, self._colors_go_line);
    self._colors_go_line = undefined;
  }

  if(isDefined(self.colornode_setgoal_func)) {
    self thread[[self.colornode_setgoal_func]](node);
  } else {
    self setgoalnode(node);
  }

  if(is_using_forcegoal_radius(node)) {
    thread forcegoal_radius(node);
  } else if(isDefined(node.radius) && node.radius > 0) {
    self.goalradius = node.radius;
  }

  if(isDefined(self.og_color_fixednode)) {
    self.fixednode = self.og_color_fixednode;
    self.og_color_fixednode = undefined;
  }

  volume = level.arrays_of_colorcoded_volumes[get_team()][self.currentcolorcode];

  if(isDefined(volume)) {
    self setfixednodesafevolume(volume);
  } else {
    self clearfixednodesafevolume();
  }

  if(isDefined(node.fixednodesaferadius)) {
    self.fixednodesaferadius = node.fixednodesaferadius;
    return;
  }

  if(isDefined(level.fixednodesaferadius_default)) {
    self.fixednodesaferadius = level.fixednodesaferadius_default;
    return;
  }

  self.fixednodesaferadius = 64;
}

function is_using_forcegoal_radius(node) {
  if(!isDefined(self.script_forcegoal)) {
    return 0;
  }

  if(!self.script_forcegoal) {
    return 0;
  }

  if(!isDefined(node.fixednodesaferadius)) {
    return 0;
  }

  if(self.fixednode) {
    return 0;
  }

  return 1;
}

function forcegoal_radius(node) {
  self endon("death");
  self endon("stop_going_to_node");
  self.goalradius = node.fixednodesaferadius;
  waittill_either("goal", "damage");

  if(isDefined(node.radius) && node.radius > 0) {
    self.goalradius = node.radius;
  }
}

function careful_logic(node, volume) {
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

function recover_from_careful_disable(node) {
  self endon("death");
  self endon("stop_going_to_node");
  self waittill("stop_being_careful");
  self.fixednode = 1;
  set_goal_and_volume(node);
}

function use_big_goal_until_goal_is_safe(node, volume) {
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

    return;
  }

  for(;;) {
    if(!isknownenemyinradius_tmp(node.origin, self.fixednodesaferadius)) {
      return;
    }

    wait 1;
  }
}

function isknownenemyinradius_tmp(node_origin, safe_radius) {
  ai = getaiarray("axis");

  for(i = 0; i < ai.size; i++) {
    if(distance2d(ai[i].origin, node_origin) < safe_radius) {
      return true;
    }
  }

  return false;
}

function wait_until_an_enemy_is_in_safe_area(node, volume) {
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

    return;
  }

  for(;;) {
    if(isknownenemyinradius_tmp(node.origin, self.fixednodesaferadius)) {
      return;
    }

    wait 1;
  }
}

function my_current_node_delays() {
  if(!isDefined(self.node)) {
    return 0;
  }

  node = self.node;
  hasdelay = 0;

  if(isDefined(node.script_flag_wait)) {
    flag_wait(node.script_flag_wait);
    hasdelay = 1;
  }

  if(isDefined(node.script_flag_waitopen)) {
    flag_waitopen(node.script_flag_waitopen);
    hasdelay = 1;
  }

  if(isDefined(self.script_color_delay_override)) {
    wait self.script_color_delay_override;
    hasdelay = 1;
  } else {
    hasdelay = node script_delay() || hasdelay;
  }

  return hasdelay;
}

function process_color_order_to_ai(node, trigger, counter) {
  thread decrementcolorusers(node);
  self endon("stop_color_move");
  self endon("death");

  if(isDefined(trigger)) {
    trigger script_delay();
  }

  if(!my_current_node_delays()) {
    if(isDefined(counter)) {
      wait counter * randomfloatrange(0.1, 0.25);
    }
  }

  ai_sets_goal(node);
  self.color_ordered_node_assignment = node;

  for(;;) {
    self waittill("node_bad", reason, taker, duration);

    if(reason != "taken" && reason != "unusable" && reason != "badplace" && reason != "path_blocked" && reason != "unsafe") {
      continue;
    }

    if(reason == "path_blocked" && isDefined(duration) && duration < 2000) {
      continue;
    }

    node = get_best_available_new_colored_node();

    if(isDefined(node)) {
      assertex(!isalive(node.color_user), "Node already had color user!");

      if(isalive(self.color_node.color_user) && self.color_node.color_user == self) {
        self.color_node.color_user = undefined;
      }

      self.color_node = node;
      node.color_user = self;
      ai_sets_goal(node);
    }
  }
}

function get_best_available_colored_node() {
  assertex(get_team() != "neutral");
  assertex(isDefined(self.script_forcecolor), "AI with export " + self.export+" lost his script_forcecolor.. somehow.");
  colorcode = level.currentcolorforced[get_team()][self.script_forcecolor];
  nodes = get_prioritized_colorcoded_nodes(get_team(), colorcode, self.script_forcecolor);
  assertex(nodes.size > 0, "Tried to make guy with export " + self.export+" go to forcecolor " + self.script_forcecolor + " but there are no nodes of that color enabled");

  foreach(node in nodes) {
    if(self isnodeinbadplace(node)) {
      continue;
    }

    if(!isalive(node.color_user)) {
      return node;
    }
  }
}

function get_best_available_new_colored_node() {
  assertex(get_team() != "neutral");
  assertex(isDefined(self.script_forcecolor), "AI with export " + self.export+" lost his script_forcecolor.. somehow.");
  colorcode = level.currentcolorforced[get_team()][self.script_forcecolor];
  nodes = get_prioritized_colorcoded_nodes(get_team(), colorcode, self.script_forcecolor);
  assertex(nodes.size > 0, "Tried to make guy with export " + self.export+" go to forcecolor " + self.script_forcecolor + " but there are no nodes of that color enabled");

  foreach(node in nodes) {
    if(self isnodeinbadplace(node)) {
      continue;
    }

    if(node == self.color_node) {
      continue;
    }

    if(!isalive(node.color_user)) {
      return node;
    }
  }
}

function process_stop_short_of_node(node) {
  self endon("stopScript");
  self endon("death");

  if(isDefined(self.node)) {
    return;
  }

  if(distance(node.origin, self.origin) < 32) {
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

function wait_for_killanimscript_or_time(timer) {
  self endon("killanimscript");
  wait timer;
}

function reached_node_but_could_not_claim_it(node) {
  ai = getaiarray();
  guy = undefined;

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

function decrementcolorusers(node) {
  node.color_user = self;
  self.color_node = node;
  self endon("stop_color_move");
  self waittill("death");
  self.color_node.color_user = undefined;
}

function colorislegit(color) {
  for(i = 0; i < level.colorlist.size; i++) {
    if(color == level.colorlist[i]) {
      return true;
    }
  }

  return false;
}

function add_volume_to_global_arrays(colorcode_string, team) {
  colorcodes = strtok(colorcode_string, " ");
  colorcodes = array_remove_dupes(colorcodes);

  foreach(colorcode in colorcodes) {
    assert(!isDefined(level.arrays_of_colorcoded_volumes[team][colorcode]), "Multiple info_volumes exist with color code " + colorcode);
    level.arrays_of_colorcoded_volumes[team][colorcode] = self;
    level.arrays_of_colorcoded_ai[team][colorcode] = [];
    level.arrays_of_colorcoded_spawners[team][colorcode] = [];
  }
}

function add_node_to_global_arrays(colorcode_string, team) {
  self.color_user = undefined;
  colorcodes = strtok(colorcode_string, " ");
  colorcodes = array_remove_dupes(colorcodes);

  foreach(colorcode in colorcodes) {
    if(isDefined(level.arrays_of_colorcoded_nodes[team]) && isDefined(level.arrays_of_colorcoded_nodes[team][colorcode])) {
      level.arrays_of_colorcoded_nodes[team][colorcode] = array_add(level.arrays_of_colorcoded_nodes[team][colorcode], self);
      continue;
    }

    level.arrays_of_colorcoded_nodes[team][colorcode][0] = self;
    level.arrays_of_colorcoded_ai[team][colorcode] = [];
    level.arrays_of_colorcoded_spawners[team][colorcode] = [];
  }
}

function left_color_node() {
  self.color_node_debug_val = undefined;

  if(!isDefined(self.color_node)) {
    return;
  }

  if(isDefined(self.color_node.color_user) && self.color_node.color_user == self) {
    self.color_node.color_user = undefined;
  }

  self.color_node = undefined;
  self notify("stop_color_move");
}

function getcolornumberarray() {
  array = [];

  if(issubstr(self.classname, "axis") || issubstr(self.classname, "enemy") || issubstr(self.classname, "team3")) {
    array["team"] = "axis";
    array["colorTeam"] = self.script_color_axis;
  }

  if(issubstr(self.classname, "ally") || self.type == "civilian") {
    array["team"] = "allies";
    array["colorTeam"] = self.script_color_allies;
  }

  if(!isDefined(array["colorTeam"])) {
    array = undefined;
  }

  return array;
}

function removespawnerfromcolornumberarray() {
  colornumberarray = getcolornumberarray();

  if(!isDefined(colornumberarray)) {
    return;
  }

  team = colornumberarray["team"];
  colorteam = colornumberarray["colorTeam"];
  colors = strtok(colorteam, " ");
  colors = array_remove_dupes(colors);

  for(i = 0; i < colors.size; i++) {
    level.arrays_of_colorcoded_spawners[team][colors[i]] = array_remove(level.arrays_of_colorcoded_spawners[team][colors[i]], self);
  }
}

function add_cover_node(type) {
  level.color_node_type_function[type][1]["allies"] = &process_cover_node_with_last_in_mind_allies;
  level.color_node_type_function[type][1]["axis"] = &process_cover_node_with_last_in_mind_axis;
  level.color_node_type_function[type][0]["allies"] = &process_cover_node;
  level.color_node_type_function[type][0]["axis"] = &process_cover_node;
}

function add_path_node(type) {
  level.color_node_type_function[type][1]["allies"] = &process_path_node;
  level.color_node_type_function[type][0]["allies"] = &process_path_node;
  level.color_node_type_function[type][1]["axis"] = &process_path_node;
  level.color_node_type_function[type][0]["axis"] = &process_path_node;
}

function colornode_spawn_reinforcement(classname, fromcolor) {
  level endon("kill_color_replacements");
  level endon("kill_hidden_reinforcement_waiting");
  reinforcement = spawn_hidden_reinforcement(classname, fromcolor);

  if(isDefined(level.friendly_startup_thread)) {
    reinforcement thread[[level.friendly_startup_thread]]();
  }

  reinforcement thread colornode_replace_on_death();
}

function colornode_replace_on_death() {
  level endon("kill_color_replacements");
  assertex(isalive(self), "Tried to do replace on death on something that was not alive");
  self endon("_disable_reinforcement");

  if(isDefined(self.replace_on_death)) {
    return;
  }

  self.replace_on_death = 1;
  assertex(!isDefined(self.respawn_on_death), "Guy with export " + self.export+" tried to run respawn on death twice.");
  classname = self.classname;
  color = self.script_forcecolor;
  waittillframeend();

  if(isalive(self)) {
    self waittill("death");
  }

  color_order = level.current_color_order;

  if(!isDefined(self.script_forcecolor)) {
    return;
  }

  thread colornode_spawn_reinforcement(classname, self.script_forcecolor);

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

    correct_colored_friendlies = get_force_color_guys("allies", color_order[color]);

    if(!isDefined(level.color_doesnt_care_about_classname)) {
      correct_colored_friendlies = remove_without_classname(correct_colored_friendlies, classname);
    }

    if(!correct_colored_friendlies.size) {
      wait 2;
      continue;
    }

    correct_colored_guy = getclosest(level.player.origin, correct_colored_friendlies);
    assertex(correct_colored_guy.script_forcecolor != color, "Tried to replace a " + color + " guy with a guy of the same color!");
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

function get_color_from_order(color, color_order) {
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

function friendly_spawner_vision_checker() {
  level.friendly_respawn_vision_checker_thread = 1;
  successes = 0;

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

    difference_vec = level.player.origin - level.respawn_spawner_org;

    if(length(difference_vec) < 200) {
      player_sees_spawner();
      continue;
    }

    forward = anglesToForward((0, level.player getplayerangles()[1], 0));
    difference = vectorNormalize(difference_vec);
    dot = vectordot(forward, difference);

    if(dot < 0.2) {
      player_sees_spawner();
      continue;
    }

    successes++;

    if(successes < 3) {
      continue;
    }

    flag_set("player_looks_away_from_spawner");
  }
}

function get_color_spawner(classname, fromcolor) {
  if(isDefined(self.color_respawn_spawner)) {
    return self.color_respawn_spawner;
  }

  if(isDefined(classname)) {
    if(!isDefined(level._color_friendly_spawners[classname])) {
      spawners = getspawnerteamarray("allies");

      foreach(spawner in spawners) {
        if(spawner.classname != classname) {
          continue;
        }

        if(!isDefined(spawner.script_forcecolor)) {
          continue;
        }

        if(spawner.script_forcecolor != fromcolor) {
          continue;
        }

        level._color_friendly_spawners[classname] = spawner;
        break;
      }
    }
  }

  if(!isDefined(classname)) {
    spawners = [];

    foreach(spawner in level._color_friendly_spawners) {
      if(spawner.script_forcecolor != fromcolor) {
        continue;
      }

      spawners[spawners.size] = spawner;
    }

    spawner = random(spawners);

    if(!isDefined(spawner)) {
      spawners = [];

      foreach(spawner in level._color_friendly_spawners) {
        if(isDefined(spawner)) {
          spawners[index] = spawner;
        }
      }

      level._color_friendly_spawners = spawners;
      return random(level._color_friendly_spawners);
    }

    return spawner;
  }

  assertex(isDefined(level._color_friendly_spawners[classname]), "No more reinforcement spawners with classname " + classname + " exist. They were likely deleted.");
  return level._color_friendly_spawners[classname];
}

function respawn_friendlies_without_vision_check() {
  if(isDefined(level.respawn_friendlies_force_vision_check)) {
    return 0;
  }

  return flag("respawn_friendlies");
}

function wait_until_vision_check_satisfied_or_disabled() {
  if(flag("player_looks_away_from_spawner")) {
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

function spawn_hidden_reinforcement(classname, fromcolor) {
  level endon("kill_color_replacements");
  level endon("kill_hidden_reinforcement_waiting");
  spawn = undefined;

  for(;;) {
    if(!respawn_friendlies_without_vision_check()) {
      if(!isDefined(level.friendly_respawn_vision_checker_thread)) {
        thread friendly_spawner_vision_checker();
      }

      for(;;) {
        wait_until_vision_check_satisfied_or_disabled();
        flag_waitopen("friendly_spawner_locked");

        if(flag("player_looks_away_from_spawner") || respawn_friendlies_without_vision_check()) {
          break;
        }
      }

      flag_set("friendly_spawner_locked");
    }

    spawner = get_color_spawner(classname, fromcolor);
    spawner.count = 1;
    oldorg = spawner.origin;
    spawner.origin = level.respawn_spawner_org;
    script_delay();
    spawn = spawner stalingradspawn();
    spawner.origin = oldorg;

    if(spawn_failed(spawn)) {
      thread lock_spawner_for_awhile();
      wait 1;
      continue;
    }

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

  if(isDefined(fromcolor)) {
    spawn set_force_color(fromcolor);
  }

  thread lock_spawner_for_awhile();
  return spawn;
}

function lock_spawner_for_awhile() {
  flag_set("friendly_spawner_locked");

  if(isDefined(level.friendly_respawn_lock_func)) {
    [[level.friendly_respawn_lock_func]]();
  } else {
    wait 2;
  }

  flag_clear("friendly_spawner_locked");
}

function player_sees_spawner() {
  successes = 0;
  flag_clear("player_looks_away_from_spawner");
}

function kill_color_replacements() {
  flag_clear("friendly_spawner_locked");
  level notify("kill_color_replacements");
  ai = getaiarray();
  array_thread(ai, &remove_replace_on_death);
}

function remove_replace_on_death() {
  self.replace_on_death = undefined;
}

function get_team(team) {
  if(isDefined(self.team) && !isDefined(team)) {
    team = self.team;
  }

  return level.color_teams[team];
}