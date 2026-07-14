/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\colors.gsc
**************************************/

#using scripts\common\ai;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\anim;
#namespace colors;

function init_colors() {
  if(!utility::add_init_script("\x16\xbe\xac\xb6Z\x11", &init_colors)) {
    return;
  }

  utility::flag_init("res\a\x85\xee7\xbe\xcc\xc9\xb4\xacn\x19\xb1-e\xb9");
  utility::registersharedfunc(#"colors", #"set_force_color", &utility_sp::set_force_color);
  thread init_color_grouping();
}

function init_color_grouping() {
  nodes = getallnodes();
  utility::flag_init("\xf9\x05\x88\xd2H>DY\xe2l|\x05s\xfdt\xee7\xf3\xb1\xe6\xef\x95\x8c\xb2\x8e,\xfc\xdf[\xbc");
  utility::flag_init("f\x9c\x96V\xcd\x8c\x8d\x97\xd7\x9b\xe0\xb0w\xdc\xcaN\xfa\x1b\xbdl\xb5\xac\xc8");
  level.arrays_of_colorcoded_nodes = [];
  level.arrays_of_colorcoded_nodes["?\xb1\xc0\x9a"] = [];
  level.arrays_of_colorcoded_nodes["O\x15\x1b\xad\x9ff"] = [];
  level.arrays_of_colorcoded_volumes = [];
  level.arrays_of_colorcoded_volumes["?\xb1\xc0\x9a"] = [];
  level.arrays_of_colorcoded_volumes["O\x15\x1b\xad\x9ff"] = [];
  triggers = utility::array_combine(getEntArray("E\x03\xae\xad\x7f\xcc\xa9\x17\xda\xb0K\xa4s\xeb\xfb\xf7", #code_classname), getEntArray("\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I", #code_classname), getEntArray("\xcd\xf8\x02\xf9\x1c\xbe\xd6F\xab\v=\x9a", #code_classname));
  level.color_teams = [];
  level.color_teams["O\x15\x1b\xad\x9ff"] = "O\x15\x1b\xad\x9ff";
  level.color_teams["?\xb1\xc0\x9a"] = "?\xb1\xc0\x9a";
  level.color_teams["\x8c\x1b\xab)\xd1"] = "?\xb1\xc0\x9a";
  level.color_teams["\xba\xa5\x1f\xc9m\x80i"] = "\xba\xa5\x1f\xc9m\x80i";
  volumes = getEntArray("\xfd-\xfa\xf5\xa30}W{}\xe8", #code_classname);

  foreach(node in nodes) {
    if(isDefined(node.script_color_allies)) {
      node add_node_to_global_arrays(node.script_color_allies, "O\x15\x1b\xad\x9ff");
    }

    if(isDefined(node.script_color_axis)) {
      node add_node_to_global_arrays(node.script_color_axis, "?\xb1\xc0\x9a");
    }
  }

  foreach(volume in volumes) {
    if(isDefined(volume.script_color_allies)) {
      volume add_volume_to_global_arrays(volume.script_color_allies, "O\x15\x1b\xad\x9ff");
    }

    if(isDefined(volume.script_color_axis)) {
      volume add_volume_to_global_arrays(volume.script_color_axis, "?\xb1\xc0\x9a");
    }
  }

  foreach(trigger in triggers) {
    if(isDefined(trigger.script_color_allies)) {
      trigger thread trigger_issues_orders(trigger.script_color_allies, "O\x15\x1b\xad\x9ff");
    }

    if(isDefined(trigger.script_color_axis)) {
      trigger thread trigger_issues_orders(trigger.script_color_axis, "?\xb1\xc0\x9a");
    }
  }

  level.colornodes_debug_array = [];
  level.colornodes_debug_array["<dev string:x24>"] = [];
  level.colornodes_debug_array["<dev string:x2e>"] = [];
  level.colorvolumes_debug_array["<dev string:x24>"] = [];
  level.colorvolumes_debug_array["<dev string:x2e>"] = [];

  level.color_node_type_function = [];
  add_cover_node("4X\xc1\x1f\xf5\xc4\x8dO");
  add_cover_node("\xcalv\xe9\xf1\xb1\x89\x96\x9d^#");
  add_cover_node("\xd2\xc8\xaf/\xf5\x1c\xdfs\xfes\x06\xce");
  add_cover_node("!\xech\xe9\x0e\xf2P\x83\xc4^\xa4");
  add_cover_node("C\xed;\xcar\b\xa1r\xdb\xael\x1a\x04Wi\xcd2\xedw");
  add_cover_node("c\xb0\x14\xd5\xd9\xe4\xaf\x8d\x91}\xc2");
  add_cover_node("g\x1fWv\xec\xec@P(o");
  add_cover_node("\xe0;\x11\xd0\\\xcd\x16\xb4t\xf5\xcb\x98\xa5\x7f\xde");
  add_cover_node("\xed\x17\xe1\xdf\x166\xa7\xa0\xbd\x14\xec\xcef\xa5\x15a");
  add_cover_node("\xff\x17\xedh\xdd\xef\xa2Y?\v\xc77\b");
  add_cover_node("}\xdf+\xcd\xe0@_-\xa3q\xcfpq\xa2");
  add_cover_node("\x8e\xb0(;\x02\xff\x91\xc2{\xd5\x90\xfau");
  add_cover_node("\xa9co\x86\xa7%\xabZ\xda");
  add_cover_node("J\xe3b\xbc\x0et\xac");
  add_cover_node("86gH\x1e;\xcfE");
  add_cover_node("\x90\xcav-7");
  add_cover_node("9\xdb\x90");
  add_cover_node("v0\x8c@\x88d");
  add_path_node(",|\xd8\x8dF\x85");
  add_path_node("4\x1eJ<l");
  add_path_node("L\xc7\xb3\x91");
  add_path_node("dZ\xedX\xb0\xd1i");
  add_path_node("\xf7\xd5d'hTb");
  add_path_node(")I\xd3\xe0C}s\xe6B\x1f");
  add_path_node("\x16\xbfH\x15t\x18\xea^");
  add_path_node("\xc6\xbeqP\x9b\x14\x96\xfa\xfel\xf1\x98\xac\xfc");
  add_cover_node("!\x86e%'\xfc\xe4\xd4");
  add_cover_node("oV\xb6\xf3\xb5\x16");
  level.colorlist = [];
  level.colorlist[level.colorlist.size] = "4";
  level.colorlist[level.colorlist.size] = "\xde";
  level.colorlist[level.colorlist.size] = "m";
  level.colorlist[level.colorlist.size] = "\xcc";
  level.colorlist[level.colorlist.size] = "\x97";
  level.colorlist[level.colorlist.size] = "N";
  level.colorlist[level.colorlist.size] = "W";
  level.colorchecklist["\x9b\x9b\v"] = "4";
  level.colorchecklist["4"] = "4";
  level.colorchecklist["\xfb\xa0M\xd7"] = "\xde";
  level.colorchecklist["\xde"] = "\xde";
  level.colorchecklist["^\xca\x8d6\xbdw"] = "m";
  level.colorchecklist["m"] = "m";
  level.colorchecklist["\xc6\xf5\x92\xc6"] = "\xcc";
  level.colorchecklist["\xcc"] = "\xcc";
  level.colorchecklist["n*f\x1dw"] = "\x97";
  level.colorchecklist["\x97"] = "\x97";
  level.colorchecklist["\x14\xb5W(\xa6\xc9"] = "N";
  level.colorchecklist["N"] = "N";
  level.colorchecklist["\xb7\xc9\v\xdc\xceV"] = "W";
  level.colorchecklist["W"] = "W";
  level.currentcolorforced = [];
  level.currentcolorforced["O\x15\x1b\xad\x9ff"] = [];
  level.currentcolorforced["?\xb1\xc0\x9a"] = [];
  level.lastcolorforced = [];
  level.lastcolorforced["O\x15\x1b\xad\x9ff"] = [];
  level.lastcolorforced["?\xb1\xc0\x9a"] = [];

  foreach(color in level.colorlist) {
    level.arrays_of_colorforced_ai["O\x15\x1b\xad\x9ff"][color] = [];
    level.arrays_of_colorforced_ai["?\xb1\xc0\x9a"][color] = [];
    level.currentcolorforced["O\x15\x1b\xad\x9ff"][color] = undefined;
    level.currentcolorforced["?\xb1\xc0\x9a"][color] = undefined;
  }

  thread player_color_node();
  spawners = getspawnerteamarray("O\x15\x1b\xad\x9ff");
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
    assert(colorislegit(color), "<dev string:x36>" + self.origin + "<dev string:x47>" + color + "<dev string:x69>");
    level.arrays_of_colorforced_ai[get_team()][color] = utility::array_add(level.arrays_of_colorforced_ai[get_team()][color], self);
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

  if(!utility_sp::has_color()) {
    return;
  }

  if(!isDefined(nodes)) {
    volume = level.arrays_of_colorcoded_volumes[get_team()][self.currentcolorcode];
    assert(isDefined(volume), "<dev string:xad>" + self.currentcolorcode);
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
  msg = "\x8f\x04@\x15\xbb\x1d_P\xd5>\xfb\xb4=\xf5\xb8" + self.export+"\x1e{(\xa0\xc5u \xb2:\x81[\x93\xd5\">\x0f\xa4\xbc\bg\xcbB\xc5-\xd0\x05o\r\xed\x82\xbd\xe9\xe0\x93:\x96\xb18<\x94\xe8\xf0\x86\x9b\xbd\xc4\xbc\xeb\xa1\xdf\nG\xb6\xc2\xc1";

  if(getdvarint(@ "debug_colornodes") || getdvarint(@ "hash_10b43cfca1168946")) {
    iprintln(msg);
    return;
  }

  println(msg);
}

function get_color_list() {
  colorlist = [];
  colorlist[colorlist.size] = "4";
  colorlist[colorlist.size] = "\xde";
  colorlist[colorlist.size] = "m";
  colorlist[colorlist.size] = "\xcc";
  colorlist[colorlist.size] = "\x97";
  colorlist[colorlist.size] = "N";
  colorlist[colorlist.size] = "W";
  return colorlist;
}

function array_remove_dupes(array) {
  var_a65213f4dcce2839 = [];

  foreach(val in array) {
    var_a65213f4dcce2839[val] = 1;
  }

  new_array = [];

  foreach(_ in var_a65213f4dcce2839) {
    new_array[new_array.size] = index;
  }

  return new_array;
}

function get_colorcodes_from_trigger(color_team, team) {
  return get_colorcodes(color_team, team);
}

function get_colorcodes(color_team, team) {
  colorcodes = strtok(color_team, "\xda");
  colorcodes = array_remove_dupes(colorcodes);
  colors = [];
  colorcodesbycolorindex = [];
  usable_colorcodes = [];
  colorlist = get_color_list();

  foreach(colorcode in colorcodes) {
    color = undefined;

    foreach(colorlistentry in colorlist) {
      if(issubstr(colorcode, colorlistentry)) {
        if(isDefined(color)) {
          assertmsg("<dev string:xda>" + self getorigin() + "<dev string:xf0>" + colorcode + "<dev string:x110>" + color + "<dev string:x120>" + colorlistentry + "<dev string:x12b>");
        }

        color = colorlistentry;
        var_bbed9b9d73614527 = 0;

        var_bbed9b9d73614527 = 1;

        if(!var_bbed9b9d73614527) {
          break;
        }
      }
    }

    if(!isDefined(color)) {
      assertmsg("<dev string:xda>" + self getorigin() + "<dev string:x130>" + colorcode);
      continue;
    }

    if(!colorcode_is_used_in_map(team, colorcode)) {
      continue;
    }

    colorcodesbycolorindex[color] = colorcode;
    colors[colors.size] = color;
    usable_colorcodes[usable_colorcodes.size] = colorcode;
  }

  colorcodes = usable_colorcodes;
  array = [];
  array["\xe6=\xc8 4hw\x03\x9b\v"] = colorcodes;
  array["\xe7\xfe\xb4Q\xa8\xcd\x16\xe9\xba\xaf\xd2^\x99\xea\x05P_8\xf6\b\xfa\xa1"] = colorcodesbycolorindex;
  array["\x16\xbe\xac\xb6Z\x11"] = colors;
  return array;
}

function colorcode_is_used_in_map(team, colorcode) {
  if(isDefined(level.arrays_of_colorcoded_nodes[team][colorcode])) {
    return true;
  }

  return isDefined(level.arrays_of_colorcoded_volumes[team][colorcode]);
}

function trigger_issues_orders(color_team, team) {
  self endon("\x1e\xfd\xd1\xa2\a");

  for(;;) {
    self waittill("\x91`\xb1\xe7T\x97>");

    if(isDefined(self.activated_color_trigger)) {
      self.activated_color_trigger = undefined;
      continue;
    }

    get_colorcodes_and_activate_trigger(color_team, team);

    if(isDefined(self.script_oneway) && self.script_oneway) {
      thread trigger_delete_target_chain();
      assertmsg("<dev string:x14d>");
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

      temp_array = getEntArray(current.targetname, #target);

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

  utility::array_delete(array);
}

function activate_color_trigger(team) {
  if(team == "O\x15\x1b\xad\x9ff") {
    thread get_colorcodes_and_activate_trigger(self.script_color_allies, team);
    return;
  }

  thread get_colorcodes_and_activate_trigger(self.script_color_axis, team);
}

function get_colorcodes_and_activate_trigger(color_team, team) {
  array = get_colorcodes_from_trigger(color_team, team);
  colorcodes = array["\xe6=\xc8 4hw\x03\x9b\v"];
  colorcodesbycolorindex = array["\xe7\xfe\xb4Q\xa8\xcd\x16\xe9\xba\xaf\xd2^\x99\xea\x05P_8\xf6\b\xfa\xa1"];
  colors = array["\x16\xbe\xac\xb6Z\x11"];
  activate_color_code_internal(colorcodes, colors, team, colorcodesbycolorindex);
}

function activate_color_code_internal(colorcodes, colors, team, colorcodesbycolorindex) {
  for(i = 0; i < colorcodes.size; i++) {
    if(!isDefined(level.arrays_of_colorcoded_spawners[team][colorcodes[i]])) {
      continue;
    }

    level.arrays_of_colorcoded_spawners[team][colorcodes[i]] = utility::array_removeundefined(level.arrays_of_colorcoded_spawners[team][colorcodes[i]]);

    for(p = 0; p < level.arrays_of_colorcoded_spawners[team][colorcodes[i]].size; p++) {
      level.arrays_of_colorcoded_spawners[team][colorcodes[i]][p].currentcolorcode = colorcodes[i];
    }
  }

  foreach(color in colors) {
    level.arrays_of_colorforced_ai[team][color] = utility::array_removedead(level.arrays_of_colorforced_ai[team][color]);
    level.lastcolorforced[team][color] = level.currentcolorforced[team][color];
    level.currentcolorforced[team][color] = colorcodesbycolorindex[color];

    color_forced = level.currentcolorforced[team][color];
    color_defined = isDefined(level.arrays_of_colorcoded_nodes[team][color_forced]) || isDefined(level.arrays_of_colorcoded_volumes[team][color_forced]);
    assert(color_defined, "<dev string:x15f>" + color + "<dev string:x182>" + team + "<dev string:x1a2>");
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
    level notify("\xe0\xae\xf6\xde\xb4\xde\xa5D\xc3\xe7Y\a\x89\xb0\xf7)}", self);
  }
}

function same_color_code_as_last_time(team, color) {
  if(!isDefined(level.lastcolorforced[team][color])) {
    return false;
  }

  return level.lastcolorforced[team][color] == level.currentcolorforced[team][color];
}

function process_cover_node_with_last_in_mind_allies(node, var_5d3c7382451aceb9) {
  if(issubstr(node.script_color_allies, var_5d3c7382451aceb9)) {
    self.cover_nodes_last[self.cover_nodes_last.size] = node;
    return;
  }

  self.cover_nodes_first[self.cover_nodes_first.size] = node;
}

function process_cover_node_with_last_in_mind_axis(node, var_5d3c7382451aceb9) {
  if(issubstr(node.script_color_axis, var_5d3c7382451aceb9)) {
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

  ent.cover_nodes_first = utility::array_randomize(ent.cover_nodes_first);
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
  level.arrays_of_colorcoded_ai[team][colorcode] = utility::array_removedead(level.arrays_of_colorcoded_ai[team][colorcode]);
  ai = level.arrays_of_colorcoded_ai[team][colorcode];
  ai = utility::array_combine(ai, level.arrays_of_colorforced_ai[team][color]);
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

  utility::array_thread(ai, &left_color_node);
  return ai;
}

function send_ai_to_colorvolume(volume, colorcode) {
  self notify("b\x9ea\xed\xaf)C'\x9df9\x19\x0e\xed$");
  self.currentcolorcode = colorcode;

  if(!my_current_node_delays()) {
    wait randomfloatrange(0.1, 0.25);
  }

  if(isDefined(volume.target)) {
    node = getnode(volume.target, #targetname);

    if(isDefined(node)) {
      self setgoalnode(node);
    }
  }

  if(!isDefined(self.og_color_fixednode)) {
    self.og_color_fixednode = self.fixednode;
  }

  self.fixednode = 0;
  self setgoalvolumeauto(volume, volume ai::get_cover_volume_forward());
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
      msg = "<dev string:x1c1>" + ai.size + "<dev string:x1f1>" + nodes.size + "<dev string:x1ff>";

      if(getdvarint(@ "debug_colornodes") || getdvarint(@ "hash_10b43cfca1168946")) {
        iprintln(msg);
      } else {
        println(msg);
      }
    }

    if(stack) {
      stackstruct = utility::getStruct(self.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
      nodes = sortbydistance(nodes, stackstruct.origin);
    }

    counter = 0;
    ai_count = ai.size;

    for(i = 0; i < nodes.size; i++) {
      node = nodes[i];

      if(isalive(node.color_user)) {
        continue;
      }

      if(node nodeisdisconnected()) {
        continue;
      }

      closestai = utility::getclosest(node.origin, ai);
      assert(isalive(closestai));
      ai = arrayremove(ai, closestai);
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
    assert(isDefined(volume), "<dev string:x20a>" + colorcode + "<dev string:x22d>");
  } else {
    assert(volume.size == 1, "<dev string:x25a>" + colorcode + "<dev string:x22d>");
  }

  level.colorvolumes_debug_array[team][colorcode] = volume;

  utility::array_thread(ai, &send_ai_to_colorvolume, volume, colorcode);
}

function take_color_node(node, colorcode, trigger, counter) {
  self notify("b\x9ea\xed\xaf)C'\x9df9\x19\x0e\xed$");
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

      waitframe();
    }

    playernode.color_user = undefined;
    playernode color_node_finds_a_user();
  }
}

function color_node_finds_a_user() {
  if(isDefined(self.script_color_allies)) {
    color_node_finds_user_from_colorcodes(self.script_color_allies, "O\x15\x1b\xad\x9ff");
  }

  if(isDefined(self.script_color_axis)) {
    color_node_finds_user_from_colorcodes(self.script_color_axis, "?\xb1\xc0\x9a");
  }
}

function color_node_finds_user_from_colorcodes(colorcodestring, team) {
  if(isDefined(self.color_user)) {
    return;
  }

  colorcodes = strtok(colorcodestring, "\xda");
  colorcodes = array_remove_dupes(colorcodes);
  utility::array_levelthread(colorcodes, &color_node_finds_user_for_colorcode, team);
}

function color_node_finds_user_for_colorcode(colorcode, team) {
  color = colorcode[0];
  assert(colorislegit(color), "<dev string:x2af>" + color + "<dev string:x2b9>");

  if(!isDefined(level.currentcolorforced[team][color])) {
    return;
  }

  if(level.currentcolorforced[team][color] != colorcode) {
    return;
  }

  ai = utility_sp::get_force_color_guys(team, color);

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
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("b\x9ea\xed\xaf)C'\x9df9\x19\x0e\xed$");
  my_current_node_delays();
  thread ai_sets_goal(node);
}

function ai_sets_goal(node) {
  self notify("\x83\xcb\xd4\xd6XoZ\xca)\xadaz\x95\x9e\xcf\xa6\xe2\xf1");
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
    thread anim_sp::anim_single_queue(self, self._colors_go_line);
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
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x83\xcb\xd4\xd6XoZ\xca)\xadaz\x95\x9e\xcf\xa6\xe2\xf1");
  self.goalradius = node.fixednodesaferadius;
  utility::waittill_any("\x83\xd6\xaf\x11", "\fU`\xc0y\x95");

  if(isDefined(node.radius) && node.radius > 0) {
    self.goalradius = node.radius;
  }
}

function careful_logic(node, volume) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xe6UP\xe4\xccE\x81 \xe0\xfb|h\xde\xea7\xdaXi");
  self endon("\x83\xcb\xd4\xd6XoZ\xca)\xadaz\x95\x9e\xcf\xa6\xe2\xf1");
  thread recover_from_careful_disable(node);

  for(;;) {
    wait_until_an_enemy_is_in_safe_area(node, volume);
    use_big_goal_until_goal_is_safe(node, volume);
    self.fixednode = 1;
    set_goal_and_volume(node);
  }
}

function recover_from_careful_disable(node) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x83\xcb\xd4\xd6XoZ\xca)\xadaz\x95\x9e\xcf\xa6\xe2\xf1");
  self waittill("\xe6UP\xe4\xccE\x81 \xe0\xfb|h\xde\xea7\xdaXi");
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
  ai = getaiarray("?\xb1\xc0\x9a");

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
    utility::flag_wait(node.script_flag_wait);
    hasdelay = 1;
  }

  if(isDefined(node.script_flag_waitopen)) {
    utility::flag_waitopen(node.script_flag_waitopen);
    hasdelay = 1;
  }

  if(isDefined(self.script_color_delay_override)) {
    wait self.script_color_delay_override;
    hasdelay = 1;
  } else {
    hasdelay = node utility::script_delay() || hasdelay;
  }

  return hasdelay;
}

function process_color_order_to_ai(node, trigger, counter) {
  thread decrementcolorusers(node);
  self endon("b\x9ea\xed\xaf)C'\x9df9\x19\x0e\xed$");
  self endon("\x1e\xfd\xd1\xa2\a");

  if(isDefined(trigger)) {
    trigger utility::script_delay();
  }

  if(!my_current_node_delays()) {
    if(isDefined(counter)) {
      wait counter * randomfloatrange(0.1, 0.25);
    }
  }

  ai_sets_goal(node);
  self.color_ordered_node_assignment = node;

  for(;;) {
    self waittill("\ro\xd32\x8c\x9b\t\xd7", reason, taker, duration);

    if(reason != "\x84\x1e\xd4w\xf6" && reason != "\x83\xa2\x0f\x16\b%>\xb0" && reason != "@\xf6\xa8\x91\xe3dc-" && reason != "\xc8\x884\x8b\xdb\x91\xb4\xba\xbc7\x12F" && reason != "\xd5\xb9s,\xcc\xb2") {
      continue;
    }

    if(reason == "\xc8\x884\x8b\xdb\x91\xb4\xba\xbc7\x12F" && isDefined(duration) && duration < 2000) {
      continue;
    }

    node = get_best_available_new_colored_node();

    if(isDefined(node)) {
      assert(!isalive(node.color_user), "<dev string:x2ca>");

      if(isalive(self.color_node.color_user) && self.color_node.color_user == self) {
        self.color_node.color_user = undefined;
      }

      self.color_node = node;
      node.color_user = self;
      ai_sets_goal(node);
    }
  }
}

function get_best_available_new_colored_node() {
  assert(get_team() != "<dev string:x2ea>");
  assert(isDefined(self.script_forcecolor), "<dev string:x2f5>" + self.export+"<dev string:x308>");
  colorcode = level.currentcolorforced[get_team()][self.script_forcecolor];
  nodes = get_prioritized_colorcoded_nodes(get_team(), colorcode, self.script_forcecolor);
  assert(nodes.size > 0, "<dev string:x332>" + self.export+"<dev string:x354>" + self.script_forcecolor + "<dev string:x36a>");

  foreach(node in nodes) {
    if(!function_18b260d3b0f401af(node)) {
      continue;
    }

    if(!isalive(node.color_user)) {
      return node;
    }
  }
}

function function_18b260d3b0f401af(node) {
  if(self isnodeinbadplace(node)) {
    return false;
  }

  if(node nodeisdisconnected()) {
    return false;
  }

  if(node == self.color_node) {
    return false;
  }

  return true;
}

function process_stop_short_of_node(node) {
  self endon("\xd9j'\xfd\x11\x9fA\x16u;");
  self endon("\x1e\xfd\xd1\xa2\a");

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
  self endon("\xbb\x91a^\xe9\x1dr\x1e\x1cks\xf5y@");
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

    ai[i] notify("/b\xed`\xbc\x88\xcdE\xe4{\xe7\xd0\xd1\xbdi\x82\x1d\x9b");
    wait 1;
    self notify("/b\xed`\xbc\x88\xcdE\xe4{\xe7\xd0\xd1\xbdi\x82\x1d\x9b");
    return true;
  }

  return false;
}

function decrementcolorusers(node) {
  node.color_user = self;
  self.color_node = node;
  self endon("b\x9ea\xed\xaf)C'\x9df9\x19\x0e\xed$");
  self waittill("\x1e\xfd\xd1\xa2\a");
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
  colorcodes = strtok(colorcode_string, "\xda");
  colorcodes = array_remove_dupes(colorcodes);

  foreach(colorcode in colorcodes) {
    assert(!isDefined(level.arrays_of_colorcoded_volumes[team][colorcode]), "<dev string:x39b>" + colorcode);
    level.arrays_of_colorcoded_volumes[team][colorcode] = self;
    level.arrays_of_colorcoded_ai[team][colorcode] = [];
    level.arrays_of_colorcoded_spawners[team][colorcode] = [];
  }
}

function add_node_to_global_arrays(colorcode_string, team) {
  self.color_user = undefined;
  colorcodes = strtok(colorcode_string, "\xda");
  colorcodes = array_remove_dupes(colorcodes);

  foreach(colorcode in colorcodes) {
    if(isDefined(level.arrays_of_colorcoded_nodes[team]) && isDefined(level.arrays_of_colorcoded_nodes[team][colorcode])) {
      level.arrays_of_colorcoded_nodes[team][colorcode] = utility::array_add(level.arrays_of_colorcoded_nodes[team][colorcode], self);
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
  self notify("b\x9ea\xed\xaf)C'\x9df9\x19\x0e\xed$");
}

function getcolornumberarray() {
  array = [];

  if(issubstr(self.classname, "?\xb1\xc0\x9a") || issubstr(self.classname, "\xba8C\xef\xc2") || issubstr(self.classname, "\x8c\x1b\xab)\xd1")) {
    array["\x03\x94=b"] = "?\xb1\xc0\x9a";
    array["\xdd\x96^\x96(\xac\xf5\xea\xa6"] = self.script_color_axis;
  }

  if(issubstr(self.classname, ")\xfe\xe9\n") || self.type == "75\xffQ\x95\xfe`\x9a") {
    array["\x03\x94=b"] = "O\x15\x1b\xad\x9ff";
    array["\xdd\x96^\x96(\xac\xf5\xea\xa6"] = self.script_color_allies;
  }

  if(!isDefined(array["\xdd\x96^\x96(\xac\xf5\xea\xa6"])) {
    array = undefined;
  }

  return array;
}

function removespawnerfromcolornumberarray() {
  colornumberarray = getcolornumberarray();

  if(!isDefined(colornumberarray)) {
    return;
  }

  team = colornumberarray["\x03\x94=b"];
  colorteam = colornumberarray["\xdd\x96^\x96(\xac\xf5\xea\xa6"];
  colors = strtok(colorteam, "\xda");
  colors = array_remove_dupes(colors);

  for(i = 0; i < colors.size; i++) {
    level.arrays_of_colorcoded_spawners[team][colors[i]] = arrayremove(level.arrays_of_colorcoded_spawners[team][colors[i]], self);
  }
}

function add_cover_node(type) {
  level.color_node_type_function[type][1]["O\x15\x1b\xad\x9ff"] = &process_cover_node_with_last_in_mind_allies;
  level.color_node_type_function[type][1]["?\xb1\xc0\x9a"] = &process_cover_node_with_last_in_mind_axis;
  level.color_node_type_function[type][0]["O\x15\x1b\xad\x9ff"] = &process_cover_node;
  level.color_node_type_function[type][0]["?\xb1\xc0\x9a"] = &process_cover_node;
}

function add_path_node(type) {
  level.color_node_type_function[type][1]["O\x15\x1b\xad\x9ff"] = &process_path_node;
  level.color_node_type_function[type][0]["O\x15\x1b\xad\x9ff"] = &process_path_node;
  level.color_node_type_function[type][1]["?\xb1\xc0\x9a"] = &process_path_node;
  level.color_node_type_function[type][0]["?\xb1\xc0\x9a"] = &process_path_node;
}

function colornode_spawn_reinforcement(classname, fromcolor) {
  level endon("\xc0>xC,\t\xd8B\xd8h\xdfu^\x86{B\xf2\x95\x1b\xad\xef\v\xf3");
  level endon("CX\xe5\xc8X\v\xfb]\x9e{\x12\xf8\xce\x8f \xfd\xc9CKD\xc5\x93|\x98\xd6\xe4\x90gJh\b\xf9M");
  reinforcement = spawn_hidden_reinforcement(classname, fromcolor);

  if(isDefined(level.friendly_startup_thread)) {
    reinforcement thread[[level.friendly_startup_thread]]();
  }

  reinforcement thread colornode_replace_on_death();
}

function colornode_replace_on_death() {
  level endon("\xc0>xC,\t\xd8B\xd8h\xdfu^\x86{B\xf2\x95\x1b\xad\xef\v\xf3");
  assert(isalive(self), "<dev string:x3cb>");
  self endon("\xe7\x9c\x11z\xf9\xad{G\xe0\r\xe9ql\xba\x11ud9He6\xaf");

  if(isDefined(self.replace_on_death)) {
    return;
  }

  self.replace_on_death = 1;
  assert(!isDefined(self.respawn_on_death), "<dev string:x40b>" + self.export+"<dev string:x41f>");
  classname = self.classname;
  color = self.script_forcecolor;
  waittillframeend();

  if(isalive(self)) {
    self waittill("\x1e\xfd\xd1\xa2\a");
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
    if(get_color_from_order(color, color_order) == "\r+x5") {
      return;
    }

    correct_colored_friendlies = utility_sp::get_force_color_guys("O\x15\x1b\xad\x9ff", color_order[color]);

    if(!isDefined(level.color_doesnt_care_about_classname)) {
      correct_colored_friendlies = utility_sp::remove_without_classname(correct_colored_friendlies, classname);
    }

    if(!correct_colored_friendlies.size) {
      wait 2;
      continue;
    }

    correct_colored_guy = utility::getclosest(level.player.origin, correct_colored_friendlies);
    assert(correct_colored_guy.script_forcecolor != color, "<dev string:x448>" + color + "<dev string:x45f>");
    waittillframeend();

    if(!isalive(correct_colored_guy)) {
      continue;
    }

    correct_colored_guy utility_sp::set_force_color(color);

    if(isDefined(level.friendly_promotion_thread)) {
      correct_colored_guy[[level.friendly_promotion_thread]](color);
    }

    color = color_order[color];
  }
}

function get_color_from_order(color, color_order) {
  if(!isDefined(color)) {
    return "\r+x5";
  }

  if(!isDefined(color_order)) {
    return "\r+x5";
  }

  if(!isDefined(color_order[color])) {
    return "\r+x5";
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

    utility::flag_set("\xf9\x05\x88\xd2H>DY\xe2l|\x05s\xfdt\xee7\xf3\xb1\xe6\xef\x95\x8c\xb2\x8e,\xfc\xdf[\xbc");
  }
}

function get_color_spawner(classname, fromcolor) {
  if(isDefined(self.color_respawn_spawner)) {
    return self.color_respawn_spawner;
  }

  if(isDefined(classname)) {
    if(!isDefined(level._color_friendly_spawners[classname])) {
      spawners = getspawnerteamarray("O\x15\x1b\xad\x9ff");

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

    spawner = utility::random(spawners);

    if(!isDefined(spawner)) {
      spawners = [];

      foreach(spawner in level._color_friendly_spawners) {
        if(isDefined(spawner)) {
          spawners[index] = spawner;
        }
      }

      level._color_friendly_spawners = spawners;
      return utility::random(level._color_friendly_spawners);
    }

    return spawner;
  }

  assert(isDefined(level._color_friendly_spawners[classname]), "<dev string:x485>" + classname + "<dev string:x4b7>");
  return level._color_friendly_spawners[classname];
}

function respawn_friendlies_without_vision_check() {
  if(isDefined(level.respawn_friendlies_force_vision_check)) {
    return false;
  }

  return utility::flag("res\a\x85\xee7\xbe\xcc\xc9\xb4\xacn\x19\xb1-e\xb9");
}

function wait_until_vision_check_satisfied_or_disabled() {
  if(utility::flag("\xf9\x05\x88\xd2H>DY\xe2l|\x05s\xfdt\xee7\xf3\xb1\xe6\xef\x95\x8c\xb2\x8e,\xfc\xdf[\xbc")) {
    return;
  }

  level endon("\xf9\x05\x88\xd2H>DY\xe2l|\x05s\xfdt\xee7\xf3\xb1\xe6\xef\x95\x8c\xb2\x8e,\xfc\xdf[\xbc");

  for(;;) {
    if(respawn_friendlies_without_vision_check()) {
      return;
    }

    wait 0.05;
  }
}

function spawn_hidden_reinforcement(classname, fromcolor) {
  level endon("\xc0>xC,\t\xd8B\xd8h\xdfu^\x86{B\xf2\x95\x1b\xad\xef\v\xf3");
  level endon("CX\xe5\xc8X\v\xfb]\x9e{\x12\xf8\xce\x8f \xfd\xc9CKD\xc5\x93|\x98\xd6\xe4\x90gJh\b\xf9M");
  spawn = undefined;

  for(;;) {
    if(!respawn_friendlies_without_vision_check()) {
      if(!isDefined(level.friendly_respawn_vision_checker_thread)) {
        thread friendly_spawner_vision_checker();
      }

      for(;;) {
        wait_until_vision_check_satisfied_or_disabled();
        utility::flag_waitopen("f\x9c\x96V\xcd\x8c\x8d\x97\xd7\x9b\xe0\xb0w\xdc\xcaN\xfa\x1b\xbdl\xb5\xac\xc8");

        if(utility::flag("\xf9\x05\x88\xd2H>DY\xe2l|\x05s\xfdt\xee7\xf3\xb1\xe6\xef\x95\x8c\xb2\x8e,\xfc\xdf[\xbc") || respawn_friendlies_without_vision_check()) {
          break;
        }
      }

      utility::flag_set("f\x9c\x96V\xcd\x8c\x8d\x97\xd7\x9b\xe0\xb0w\xdc\xcaN\xfa\x1b\xbdl\xb5\xac\xc8");
    }

    spawner = get_color_spawner(classname, fromcolor);
    spawner.count = 1;
    oldorg = spawner.origin;
    spawner.origin = level.respawn_spawner_org;
    utility::script_delay();
    spawn = spawner stalingradspawn();
    spawner.origin = oldorg;

    if(ai::spawn_failed(spawn)) {
      thread lock_spawner_for_awhile();
      wait 1;
      continue;
    }

    level notify("\x17jE\xf8\xaf\xcb\x8a@x\x95o,ffs\x1d]y\xf4\"\xae", spawn);
    break;
  }

  for(;;) {
    if(!isDefined(fromcolor)) {
      break;
    }

    if(get_color_from_order(fromcolor, level.current_color_order) == "\r+x5") {
      break;
    }

    fromcolor = level.current_color_order[fromcolor];
  }

  if(isDefined(fromcolor)) {
    spawn utility_sp::set_force_color(fromcolor);
  }

  thread lock_spawner_for_awhile();
  return spawn;
}

function lock_spawner_for_awhile() {
  utility::flag_set("f\x9c\x96V\xcd\x8c\x8d\x97\xd7\x9b\xe0\xb0w\xdc\xcaN\xfa\x1b\xbdl\xb5\xac\xc8");

  if(isDefined(level.friendly_respawn_lock_func)) {
    [[level.friendly_respawn_lock_func]]();
  } else {
    wait 2;
  }

  utility::flag_clear("f\x9c\x96V\xcd\x8c\x8d\x97\xd7\x9b\xe0\xb0w\xdc\xcaN\xfa\x1b\xbdl\xb5\xac\xc8");
}

function player_sees_spawner() {
  successes = 0;
  utility::flag_clear("\xf9\x05\x88\xd2H>DY\xe2l|\x05s\xfdt\xee7\xf3\xb1\xe6\xef\x95\x8c\xb2\x8e,\xfc\xdf[\xbc");
}

function kill_color_replacements() {
  utility::flag_clear("f\x9c\x96V\xcd\x8c\x8d\x97\xd7\x9b\xe0\xb0w\xdc\xcaN\xfa\x1b\xbdl\xb5\xac\xc8");
  level notify("\xc0>xC,\t\xd8B\xd8h\xdfu^\x86{B\xf2\x95\x1b\xad\xef\v\xf3");
  ai = getaiarray();
  utility::array_thread(ai, &remove_replace_on_death);
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