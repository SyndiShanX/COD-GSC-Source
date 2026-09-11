/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\colors.gsc
***********************************************/

function init_colors() {
  if(!scripts\engine\utility::add_init_script("colors", &init_colors)) {
    return;
  }

  scripts\engine\utility::flag_init("respawn_friendlies");
  thread init_color_grouping();
}

function init_color_grouping() {
  var0 = getallnodes();
  scripts\engine\utility::flag_init("player_looks_away_from_spawner");
  scripts\engine\utility::flag_init("friendly_spawner_locked");
  level.arrays_of_colorcoded_nodes = [];
  level.arrays_of_colorcoded_nodes["axis"] = [];
  level.arrays_of_colorcoded_nodes["allies"] = [];
  level.arrays_of_colorcoded_volumes = [];
  level.arrays_of_colorcoded_volumes["axis"] = [];
  level.arrays_of_colorcoded_volumes["allies"] = [];
  var1 = [];
  var1 = scripts\engine\utility::array_combine(var1, getEntArray("trigger_multiple", "code_classname"));
  var1 = scripts\engine\utility::array_combine(var1, getEntArray("trigger_radius", "code_classname"));
  var1 = scripts\engine\utility::array_combine(var1, getEntArray("trigger_once", "code_classname"));
  level.color_teams = [];
  level.color_teams["allies"] = "allies";
  level.color_teams["axis"] = "axis";
  level.color_teams["team3"] = "axis";
  level.color_teams["neutral"] = "neutral";
  var2 = getEntArray("info_volume", "code_classname");

  foreach(var4 in var0) {
    if(isDefined(var4.script_color_allies)) {
      add_node_to_global_arrays(var4, var4.script_color_allies, "allies");
    }

    if(isDefined(var4.script_color_axis)) {
      add_node_to_global_arrays(var4, var4.script_color_axis, "axis");
    }
  }

  foreach(var7 in var2) {
    if(isDefined(var7.script_color_allies)) {
      add_volume_to_global_arrays(var7, var7.script_color_allies, "allies");
    }

    if(isDefined(var7.script_color_axis)) {
      add_volume_to_global_arrays(var7, var7.script_color_axis, "axis");
    }
  }

  foreach(var10 in var1) {
    if(isDefined(var10.script_color_allies)) {
      thread trigger_issues_orders(var10, var10.script_color_allies);
    }

    if(isDefined(var10.script_color_axis)) {
      thread trigger_issues_orders(var10, var10.script_color_axis);
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

  foreach(var13 in level.colorlist) {
    level.arrays_of_colorforced_ai["allies"][var13] = [];
    level.arrays_of_colorforced_ai["axis"][var13] = [];
    level.currentcolorforced["allies"][var13] = undefined;
    level.currentcolorforced["axis"][var13] = undefined;
  }

  thread player_color_node();
  var15 = getspawnerteamarray("allies");
  level._color_friendly_spawners = [];

  foreach(var17 in var15) {
    level._color_friendly_spawners[var17.classname] = var17;
    LOC_0000059f:
  }
}

function convert_color_to_short_string() {
  self.script_forcecolor = level.colorchecklist[self.script_forcecolor];
}

function ai_picks_destination(var0) {
  if(isDefined(self.script_forcecolor)) {
    convert_color_to_short_string();
    self.currentcolorcode = var0;
    var1 = self.script_forcecolor;
    level.arrays_of_colorforced_ai[get_team()][var1] = scripts\engine\utility::array_add(level.arrays_of_colorforced_ai[get_team()][var1], self);
    thread goto_current_colorindex();
    return;
  }
}

function goto_current_colorindex() {
  if(!isDefined(self.currentcolorcode)) {
    return;
  }

  var0 = level.arrays_of_colorcoded_nodes[get_team()][self.currentcolorcode];
  left_color_node();

  if(!isalive(self)) {
    return;
  }

  if(!scripts\engine\sp\utility::has_color()) {
    return;
  }

  if(!isDefined(var0)) {
    var1 = level.arrays_of_colorcoded_volumes[get_team()][self.currentcolorcode];
    send_ai_to_colorvolume(var1, self.currentcolorcode);
    return;
  }

  for(var2 = 0; var2 < var1.size; var2++) {
    var3 = var1[var2];

    if(isalive(var3.color_user) && !isPlayer(var3.color_user)) {
      continue;
    }

    thread ai_sets_goal_with_delay(var3);
    thread decrementcolorusers(var3);
    return;
  }

  no_node_to_go_to();
}

function no_node_to_go_to() {
  var0 = "AI with export " + self.export+" was told to go to color node but had no node to go to.";

  if(getdvarint("debug_colornodes") || getdvarint("debug_colorfriendlies")) {
    iprintln(var0);
    return;
  }
}

function get_color_list() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "r");
}

function array_remove_dupes(var0) {
  var1 = [];

  foreach(var3 in var0) {
    var1 = 1;
  }

  var5 = [];

  foreach(var7 in var1) {
    var5 = var8;
  }

  return var5;
}

function get_colorcodes_from_trigger(var0, var1) {
  return get_colorcodes(var0, var1);
}

function get_colorcodes(var0, var1) {
  var2 = strtok(var0, " ");
  var2 = array_remove_dupes(var2);
  var3 = [];
  var4 = [];
  var5 = [];
  var6 = get_color_list();

  foreach(var8 in var2) {
    var9 = undefined;

    foreach(var9 in var6) {
      if(issubstr(var8, var9)) {
        break;
      }
    }

    if(!colorcode_is_used_in_map(var1, var8)) {
      continue;
    }

    var4 = var8;
    var3 = var9;
    var5 = var8;
  }

  var2 = var5;
  var13 = [];
  GscBinSkip0(0x2e, "colorCodes", var2);
}

function colorcode_is_used_in_map(var0, var1) {
  if(isDefined(level.arrays_of_colorcoded_nodes[var0][var1])) {
    return true;
  }

  return isDefined(level.arrays_of_colorcoded_volumes[var0][var1]);
}

function trigger_issues_orders(var0, var1) {
  self endon("death");

  for(;;) {
    self waittill("trigger");

    if(isDefined(self.activated_color_trigger)) {
      self.activated_color_trigger = undefined;
      continue;
    }

    get_colorcodes_and_activate_trigger(var0, var1);

    if(isDefined(self.script_oneway) && self.script_oneway) {
      thread trigger_delete_target_chain();
    }
  }
}

function trigger_delete_target_chain() {
  var0 = [];
  GscBinSkip1(0x45, 0, self);
}

function activate_color_trigger(var0) {
  if(var0 == "allies") {
    thread get_colorcodes_and_activate_trigger(self.script_color_allies, var0);
    return;
  }

  thread get_colorcodes_and_activate_trigger(self.script_color_axis, var0);
}

function get_colorcodes_and_activate_trigger(var0, var1) {
  var2 = get_colorcodes_from_trigger(var0, var1);
  var3 = var2["colorCodes"];
  var4 = var2["colorCodesByColorIndex"];
  var5 = var2["colors"];
  activate_color_code_internal(var3, var5, var1, var4);
}

function activate_color_code_internal(var0, var1, var2, var3) {
  for(var4 = 0; var4 < var0.size; var4++) {
    if(!isDefined(level.arrays_of_colorcoded_spawners[var2][var0[var4]])) {
      continue;
    }

    level.arrays_of_colorcoded_spawners[var2][var0[var4]] = scripts\engine\utility::array_removeundefined(level.arrays_of_colorcoded_spawners[var2][var0[var4]]);

    for(var5 = 0; var5 < level.arrays_of_colorcoded_spawners[var2][var0[var4]].size; var5++) {
      level.arrays_of_colorcoded_spawners[var2][var0[var4]][var5].currentcolorcode = var0[var4];
    }
  }

  foreach(var7 in var1) {
    level.arrays_of_colorforced_ai[var2][var7] = scripts\engine\utility::array_removedead(level.arrays_of_colorforced_ai[var2][var7]);
    level.lastcolorforced[var2][var7] = level.currentcolorforced[var2][var7];
    level.currentcolorforced[var2][var7] = var3[var7];
  }

  var11 = [];
  var12 = 0;

  for(var4 = 0; var4 < var0.size; var4++) {
    if(same_color_code_as_last_time(var2, var1[var4])) {
      continue;
    }

    var13 = var0[var4];

    if(!isDefined(level.arrays_of_colorcoded_ai[var2][var13])) {
      continue;
    }

    var11 = issue_leave_node_order_to_ai_and_get_ai(var13, var1[var4], var2);
  }

  for(var4 = 0; var4 < var0.size; var4++) {
    var13 = var0[var4];

    if(!isDefined(var11[var13])) {
      continue;
    }

    if(same_color_code_as_last_time(var2, var1[var4])) {
      continue;
    }

    if(!isDefined(level.arrays_of_colorcoded_ai[var2][var13])) {
      continue;
    }

    var12 = 1;
    issue_color_order_to_ai(var13, var1[var4], var2, var11[var13]);
  }

  if(var12) {
    level notify("new_color_trigger", self);
    return;
  }
}

function same_color_code_as_last_time(var0, var1) {
  if(!isDefined(level.lastcolorforced[var0][var1])) {
    return false;
  }

  return level.lastcolorforced[var0][var1] == level.currentcolorforced[var0][var1];
}

function process_cover_node_with_last_in_mind_allies(var0, var1) {
  if(issubstr(var0.script_color_allies, var1)) {
    self.cover_nodes_last[self.cover_nodes_last.size] = var0;
    return;
  }

  self.cover_nodes_first[self.cover_nodes_first.size] = var0;
}

function process_cover_node_with_last_in_mind_axis(var0, var1) {
  if(issubstr(var0.script_color_axis, var1)) {
    self.cover_nodes_last[self.cover_nodes_last.size] = var0;
    return;
  }

  self.cover_nodes_first[self.cover_nodes_first.size] = var0;
}

function process_cover_node(var0, var1) {
  self.cover_nodes_first[self.cover_nodes_first.size] = var0;
}

function process_path_node(var0, var1) {
  self.path_nodes[self.path_nodes.size] = var0;
}

function prioritize_colorcoded_nodes(var0, var1, var2) {
  var3 = level.arrays_of_colorcoded_nodes[var0][var1];
  var4 = spawnStruct();
  var4.path_nodes = [];
  var4.cover_nodes_first = [];
  var4.cover_nodes_last = [];
  var5 = isDefined(level.lastcolorforced[var0][var2]);

  foreach(var7 in var3) {
    var4[[level.color_node_type_function[var7.type][var5][var0]]](var7, level.lastcolorforced[var0][var2]);
  }

  var4.cover_nodes_first = scripts\engine\utility::array_randomize(var4.cover_nodes_first);
  var9 = [];
  var3 = [];

  foreach(var7 in var4.cover_nodes_first) {
    if(isDefined(var7.script_colorlast)) {
      var9 = var7;
      var3[var11] = undefined;
      continue;
    }

    var3 = var7;
  }

  for(var12 = 0; var12 < var4.cover_nodes_last.size; var12++) {
    var3 = var4.cover_nodes_last[var12];
  }

  for(var12 = 0; var12 < var4.path_nodes.size; var12++) {
    var3 = var4.path_nodes[var12];
  }

  foreach(var7 in var9) {
    var3 = var7;
  }

  level.arrays_of_colorcoded_nodes[var0][var1] = var3;
}

function get_prioritized_colorcoded_nodes(var0, var1, var2) {
  return level.arrays_of_colorcoded_nodes[var0][var1];
}

function get_colorcoded_volume(var0, var1) {
  return level.arrays_of_colorcoded_volumes[var0][var1];
}

function issue_leave_node_order_to_ai_and_get_ai(var0, var1, var2) {
  level.arrays_of_colorcoded_ai[var2][var0] = scripts\engine\utility::array_removedead(level.arrays_of_colorcoded_ai[var2][var0]);
  var3 = level.arrays_of_colorcoded_ai[var2][var0];
  var3 = scripts\engine\utility::array_combine(var3, level.arrays_of_colorforced_ai[var2][var1]);
  var4 = [];

  foreach(var6 in var3) {
    if(isDefined(var6.currentcolorcode) && var6.currentcolorcode == var0) {
      continue;
    }

    var4 = var6;
  }

  var3 = var4;

  if(!var3.size) {
    return;
  }

  scripts\engine\utility::array_thread(var3, &left_color_node);
  return var3;
}

function send_ai_to_colorvolume(var0, var1) {
  self notify("stop_color_move");
  self.currentcolorcode = var1;

  if(isDefined(var0.target)) {
    var2 = getnode(var0.target, "targetname");

    if(isDefined(var2)) {
      self setgoalnode(var2);
    }
  }

  if(!isDefined(self.og_color_fixednode)) {
    self.og_color_fixednode = self.fixednode;
  }

  self.fixednode = 0;
  self setgoalvolumeauto(var0, var0 scripts\engine\sp\utility::get_cover_volume_forward());
}

function issue_color_order_to_ai(var0, var1, var2, var3) {
  var4 = var3;
  var5 = isDefined(self.script_stack);
  var6 = [];
  var7 = undefined;

  if(isDefined(level.arrays_of_colorcoded_nodes[var2][var0])) {
    if(!var5) {
      prioritize_colorcoded_nodes(var2, var0, var1);
    }

    var6 = get_prioritized_colorcoded_nodes(var2, var0, var1);

    if(var5) {
      var9 = scripts\engine\utility::getStruct(self.target, "targetname");
      var6 = sortbydistance(var6, var9.origin);
    }

    var10 = 0;
    var11 = var3.size;

    for(var12 = 0; var12 < var6.size; var12++) {
      var13 = var6[var12];

      if(isalive(var13.color_user)) {
        continue;
      }

      var14 = scripts\engine\utility::getclosest(var13.origin, var3);
      var3 = scripts\engine\utility::array_remove(var3, var14);
      take_color_node(var14, var13, var0, self, var10);
      var10++;

      if(!var3.size) {
        return;
      }
    }

    return;
  }

  var7 = get_colorcoded_volume(var2, var0);
  scripts\engine\utility::array_thread(var3, &send_ai_to_colorvolume, var7, var0);
}

function take_color_node(var0, var1, var2, var3) {
  self notify("stop_color_move");
  self.currentcolorcode = var1;
  thread process_color_order_to_ai(var0, var2, var3);
}

function player_color_node() {
  for(;;) {
    var0 = undefined;

    if(!isDefined(level.player.node)) {
      wait 0.05;
      continue;
    }

    var1 = level.player.node.color_user;
    var0 = level.player.node;
    var0.color_user = level.player;

    for(;;) {
      if(!isDefined(level.player.node)) {
        break;
      }

      if(level.player.node != var0) {
        break;
      }

      wait 0.05;
    }

    var0.color_user = undefined;
    color_node_finds_a_user(var0);
  }
}

function color_node_finds_a_user() {
  if(isDefined(self.script_color_allies)) {
    color_node_finds_user_from_colorcodes(self.script_color_allies, "allies");
  }

  if(isDefined(self.script_color_axis)) {
    color_node_finds_user_from_colorcodes(self.script_color_axis, "axis");
    return;
  }
}

function color_node_finds_user_from_colorcodes(var0, var1) {
  if(isDefined(self.color_user)) {
    return;
  }

  var2 = strtok(var0, " ");
  var2 = array_remove_dupes(var2);
  scripts\engine\utility::array_levelthread(var2, &color_node_finds_user_for_colorcode, var1);
}

function color_node_finds_user_for_colorcode(var0, var1) {
  var2 = var0[0];

  if(!isDefined(level.currentcolorforced[var1][var2])) {
    return;
  }

  if(level.currentcolorforced[var1][var2] != var0) {
    return;
  }

  var3 = scripts\engine\sp\utility::get_force_color_guys(var1, var2);

  for(var4 = 0; var4 < var3.size; var4++) {
    var5 = var3[var4];

    if(occupies_colorcode(var5, var0)) {
      continue;
    }

    take_color_node(var5, self, var0);
    return;
  }
}

function occupies_colorcode(var0) {
  if(!isDefined(self.currentcolorcode)) {
    return false;
  }

  return self.currentcolorcode == var0;
}

function ai_sets_goal_with_delay(var0) {
  self endon("death");
  self endon("stop_color_move");
  my_current_node_delays();
  thread ai_sets_goal(var0);
}

function ai_sets_goal(var0) {
  self notify("stop_going_to_node");
  set_goal_and_volume(var0);
  var1 = level.arrays_of_colorcoded_volumes[get_team()][self.currentcolorcode];

  if(isDefined(self.script_careful)) {
    thread careful_logic(var0, var1);
    return;
  }
}

function set_goal_and_volume(var0) {
  if(isDefined(self.colornode_func)) {
    self thread[[self.colornode_func]](var0);
  }

  if(isDefined(self._colors_go_line)) {
    thread scripts\sp\anim::anim_single_queue(self, self._colors_go_line);
    self._colors_go_line = undefined;
  }

  if(isDefined(self.colornode_setgoal_func)) {
    self thread[[self.colornode_setgoal_func]](var0);
  } else {
    self setgoalnode(var0);
  }

  if(is_using_forcegoal_radius(var0)) {
    thread forcegoal_radius(var0);
  } else if(isDefined(var0.radius) && var0.radius > 0) {
    self.goalradius = var0.radius;
  }

  if(isDefined(self.og_color_fixednode)) {
    self.fixednode = self.og_color_fixednode;
    self.og_color_fixednode = undefined;
  }

  var1 = level.arrays_of_colorcoded_volumes[get_team()][self.currentcolorcode];

  if(isDefined(var1)) {
    self setfixednodesafevolume(var1);
  } else {
    self clearfixednodesafevolume();
  }

  if(isDefined(var0.fixednodesaferadius)) {
    self.fixednodesaferadius = var0.fixednodesaferadius;
    return;
  }

  if(isDefined(level.fixednodesaferadius_default)) {
    self.fixednodesaferadius = level.fixednodesaferadius_default;
    return;
  }

  self.fixednodesaferadius = 64;
}

function is_using_forcegoal_radius(var0) {
  if(!isDefined(self.script_forcegoal)) {
    return 0;
  }

  if(!self.script_forcegoal) {
    return 0;
  }

  if(!isDefined(var0.fixednodesaferadius)) {
    return 0;
  }

  if(self.fixednode) {
    return 0;
  }

  return 1;
}

function forcegoal_radius(var0) {
  self endon("death");
  self endon("stop_going_to_node");
  self.goalradius = var0.fixednodesaferadius;
  scripts\engine\utility::waittill_either("goal", "damage");

  if(isDefined(var0.radius) && var0.radius > 0) {
    self.goalradius = var0.radius;
    return;
  }
}

function careful_logic(var0, var1) {
  self endon("death");
  self endon("stop_being_careful");
  self endon("stop_going_to_node");
  thread recover_from_careful_disable(var0);

  for(;;) {
    wait_until_an_enemy_is_in_safe_area(var0, var1);
    use_big_goal_until_goal_is_safe(var0, var1);
    self.fixednode = 1;
    set_goal_and_volume(var0);
  }
}

function recover_from_careful_disable(var0) {
  self endon("death");
  self endon("stop_going_to_node");
  self waittill("stop_being_careful");
  self.fixednode = 1;
  set_goal_and_volume(var0);
}

function use_big_goal_until_goal_is_safe(var0, var1) {
  self setgoalpos(self.origin);
  self.goalradius = 1024;
  self.fixednode = 0;

  if(isDefined(var1)) {
    for(;;) {
      wait 1;

      if(self isknownenemyinradius(var0.origin, self.fixednodesaferadius)) {
        continue;
      }

      if(self isknownenemyinvolume(var1)) {
        continue;
      }

      return;
    }

    return;
  }

  for(;;) {
    if(!isknownenemyinradius_tmp(var0.origin, self.fixednodesaferadius)) {
      return;
    }

    wait 1;
  }
}

function isknownenemyinradius_tmp(var0, var1) {
  var2 = getaiarray("axis");

  for(var3 = 0; var3 < var2.size; var3++) {
    if(distance2d(var2[var3].origin, var0) < var1) {
      return true;
    }
  }

  return false;
}

function wait_until_an_enemy_is_in_safe_area(var0, var1) {
  if(isDefined(var1)) {
    for(;;) {
      if(self isknownenemyinradius(var0.origin, self.fixednodesaferadius)) {
        return;
      }

      if(self isknownenemyinvolume(var1)) {
        return;
      }

      wait 1;
    }

    return;
  }

  for(;;) {
    if(isknownenemyinradius_tmp(var0.origin, self.fixednodesaferadius)) {
      return;
    }

    wait 1;
  }
}

function my_current_node_delays() {
  if(!isDefined(self.node)) {
    return 0;
  }

  var0 = self.node;
  var1 = 0;

  if(isDefined(var0.script_flag_wait)) {
    scripts\engine\utility::flag_wait(var0.script_flag_wait);
    var1 = 1;
  }

  if(isDefined(self.script_color_delay_override)) {
    wait self.script_color_delay_override;
    var1 = 1;
  } else {
    var1 = var0 scripts\engine\utility::script_delay() || var1;
  }

  return var1;
}

function process_color_order_to_ai(var0, var1, var2) {
  thread decrementcolorusers(var0);
  self endon("stop_color_move");
  self endon("death");

  if(isDefined(var1)) {
    var1 scripts\engine\utility::script_delay();
  }

  if(!my_current_node_delays()) {
    if(isDefined(var2)) {
      wait var2 * randomfloatrange(0.2, 0.35);
    }
  }

  ai_sets_goal(var0);
  self.color_ordered_node_assignment = var0;

  for(;;) {
    self waittill("node_bad", var3, var4, var5);

    if(var3 != "taken" && var3 != "unusable" && var3 != "badplace" && var3 != "path_blocked" && var3 != "unsafe") {
      continue;
    }

    if(var3 == "path_blocked" && isDefined(var5) && var5 < 2000) {
      continue;
    }

    var0 = get_best_available_new_colored_node();

    if(isDefined(var0)) {
      if(isalive(self.color_node.color_user) && self.color_node.color_user == self) {
        self.color_node.color_user = undefined;
      }

      self.color_node = var0;
      var0.color_user = self;
      ai_sets_goal(var0);
    }
  }
}

function get_best_available_colored_node() {
  var0 = level.currentcolorforced[get_team()][self.script_forcecolor];
  var1 = get_prioritized_colorcoded_nodes(get_team(), var0, self.script_forcecolor);

  foreach(var3 in var1) {
    if(self isnodeinbadplace(var3)) {
      continue;
    }

    if(!isalive(var3.color_user)) {
      return var3;
    }
  }
}

function get_best_available_new_colored_node() {
  var0 = level.currentcolorforced[get_team()][self.script_forcecolor];
  var1 = get_prioritized_colorcoded_nodes(get_team(), var0, self.script_forcecolor);

  foreach(var3 in var1) {
    if(self isnodeinbadplace(var3)) {
      continue;
    }

    if(var3 == self.color_node) {
      continue;
    }

    if(!isalive(var3.color_user)) {
      return var3;
    }
  }
}

function process_stop_short_of_node(var0) {
  self endon("stopScript");
  self endon("death");

  if(isDefined(self.node)) {
    return;
  }

  if(distance(var0.origin, self.origin) < 32) {
    reached_node_but_could_not_claim_it(var0);
    return;
  }

  var1 = gettime();
  wait_for_killanimscript_or_time(1);
  var2 = gettime();

  if(var2 - var1 >= 1000) {
    reached_node_but_could_not_claim_it(var0);
    return;
  }
}

function wait_for_killanimscript_or_time(var0) {
  self endon("killanimscript");
  wait var0;
}

function reached_node_but_could_not_claim_it(var0) {
  var1 = getaiarray();
  var2 = undefined;

  for(var3 = 0; var3 < var1.size; var3++) {
    if(!isDefined(var1[var3].node)) {
      continue;
    }

    if(var1[var3].node != var0) {
      continue;
    }

    var1[var3] notify("eject_from_my_node");
    wait 1;
    self notify("eject_from_my_node");
    return true;
  }

  return false;
}

function decrementcolorusers(var0) {
  var0.color_user = self;
  self.color_node = var0;
  self endon("stop_color_move");
  self waittill("death");
  self.color_node.color_user = undefined;
}

function colorislegit(var0) {
  for(var1 = 0; var1 < level.colorlist.size; var1++) {
    if(var0 == level.colorlist[var1]) {
      return true;
    }
  }

  return false;
}

function add_volume_to_global_arrays(var0, var1) {
  var2 = strtok(var0, " ");
  var2 = array_remove_dupes(var2);

  foreach(var4 in var2) {
    level.arrays_of_colorcoded_volumes[var1][var4] = self;
    level.arrays_of_colorcoded_ai[var1][var4] = [];
    level.arrays_of_colorcoded_spawners[var1][var4] = [];
  }
}

function add_node_to_global_arrays(var0, var1) {
  self.color_user = undefined;
  var2 = strtok(var0, " ");
  var2 = array_remove_dupes(var2);

  foreach(var4 in var2) {
    if(isDefined(level.arrays_of_colorcoded_nodes[var1]) && isDefined(level.arrays_of_colorcoded_nodes[var1][var4])) {
      level.arrays_of_colorcoded_nodes[var1][var4] = scripts\engine\utility::array_add(level.arrays_of_colorcoded_nodes[var1][var4], self);
      continue;
    }

    level.arrays_of_colorcoded_nodes[var1][var4][0] = self;
    level.arrays_of_colorcoded_ai[var1][var4] = [];
    level.arrays_of_colorcoded_spawners[var1][var4] = [];
  }
}

function left_color_node() {
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
  var0 = [];

  if(issubstr(self.classname, "axis") || issubstr(self.classname, "enemy") || issubstr(self.classname, "team3")) {
    GscBinSkip0(0x2e, "team", "axis");
  }

  if(issubstr(self.classname, "ally") || self.type == "civilian") {
    GscBinSkip0(0x2e, "team", "allies");
  }

  if(!isDefined(var0["colorTeam"])) {
    var0 = undefined;
  }

  return var0;
}

function removespawnerfromcolornumberarray() {
  var0 = getcolornumberarray();

  if(!isDefined(var0)) {
    return;
  }

  var1 = var0["team"];
  var2 = var0["colorTeam"];
  var3 = strtok(var2, " ");
  var3 = array_remove_dupes(var3);

  for(var4 = 0; var4 < var3.size; var4++) {
    level.arrays_of_colorcoded_spawners[var1][var3[var4]] = scripts\engine\utility::array_remove(level.arrays_of_colorcoded_spawners[var1][var3[var4]], self);
  }
}

function add_cover_node(var0) {
  level.color_node_type_function[var0][1]["allies"] = &process_cover_node_with_last_in_mind_allies;
  level.color_node_type_function[var0][1]["axis"] = &process_cover_node_with_last_in_mind_axis;
  level.color_node_type_function[var0][0]["allies"] = &process_cover_node;
  level.color_node_type_function[var0][0]["axis"] = &process_cover_node;
}

function add_path_node(var0) {
  level.color_node_type_function[var0][1]["allies"] = &process_path_node;
  level.color_node_type_function[var0][0]["allies"] = &process_path_node;
  level.color_node_type_function[var0][1]["axis"] = &process_path_node;
  level.color_node_type_function[var0][0]["axis"] = &process_path_node;
}

function colornode_spawn_reinforcement(var0, var1) {
  level endon("kill_color_replacements");
  level endon("kill_hidden_reinforcement_waiting");
  var2 = spawn_hidden_reinforcement(var0, var1);

  if(isDefined(level.friendly_startup_thread)) {
    var2 thread[[level.friendly_startup_thread]]();
  }

  thread colornode_replace_on_death();
}

function colornode_replace_on_death() {
  level endon("kill_color_replacements");
  self endon("_disable_reinforcement");

  if(isDefined(self.replace_on_death)) {
    return;
  }

  self.replace_on_death = 1;
  var0 = self.classname;
  var1 = self.script_forcecolor;
  waittillframeend();

  if(isalive(self)) {
    self waittill("death");
  }

  var2 = level.current_color_order;

  if(!isDefined(self.script_forcecolor)) {
    return;
  }

  thread colornode_spawn_reinforcement(var0, self.script_forcecolor);

  if(isDefined(self) && isDefined(self.script_forcecolor)) {
    var1 = self.script_forcecolor;
  }

  jumpiffalse(isDefined(self) && isDefined(self.origin)) LOC_00000089;
  var3 = self.origin;

  for(;;) {
    if(get_color_from_order(var1, var2) == "none") {
      return;
    }

    var4 = scripts\engine\sp\utility::get_force_color_guys("allies", var2[var1]);

    if(!isDefined(level.color_doesnt_care_about_classname)) {
      var4 = scripts\engine\sp\utility::remove_without_classname(var4, var0);
    }

    if(!var4.size) {
      wait 2;
      continue;
    }

    var5 = scripts\engine\utility::getclosest(level.player.origin, var4);
    waittillframeend();

    if(!isalive(var5)) {
      continue;
    }

    var5 scripts\engine\sp\utility::set_force_color(var1);

    if(isDefined(level.friendly_promotion_thread)) {
      var5[[level.friendly_promotion_thread]](var1);
    }

    var1 = var2[var1];
  }
}

function get_color_from_order(var0, var1) {
  if(!isDefined(var0)) {
    return "none";
  }

  if(!isDefined(var1)) {
    return "none";
  }

  if(!isDefined(var1[var0])) {
    return "none";
  }

  return var1[var0];
}

function friendly_spawner_vision_checker() {
  level.friendly_respawn_vision_checker_thread = 1;
  var0 = 0;

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

    var1 = level.player.origin - level.respawn_spawner_org;

    if(length(var1) < 200) {
      player_sees_spawner();
      continue;
    }

    var2 = anglesToForward((0, level.player getplayerangles()[1], 0));
    var3 = vectorNormalize(var1);
    var4 = vectordot(var2, var3);

    if(var4 < 0.2) {
      player_sees_spawner();
      continue;
    }

    var0++;

    if(var0 < 3) {
      continue;
    }

    scripts\engine\utility::flag_set("player_looks_away_from_spawner");
  }
}

function get_color_spawner(var0, var1) {
  if(isDefined(self.color_respawn_spawner)) {
    return self.color_respawn_spawner;
  }

  if(isDefined(var0)) {
    if(!isDefined(level._color_friendly_spawners[var0])) {
      var2 = getspawnerteamarray("allies");

      foreach(var4 in var2) {
        if(var4.classname != var0) {
          continue;
        }

        if(!isDefined(var4.script_forcecolor)) {
          continue;
        }

        if(var4.script_forcecolor != var1) {
          continue;
        }

        level._color_friendly_spawners[var0] = var4;
        break;
      }
    }
  }

  if(!isDefined(var0)) {
    var2 = [];

    foreach(var4 in level._color_friendly_spawners) {
      if(var4.script_forcecolor != var1) {
        continue;
      }

      var2 = var4;
    }

    var4 = scripts\engine\utility::random(var2);

    if(!isDefined(var4)) {
      var2 = [];

      foreach(var4 in level._color_friendly_spawners) {
        if(isDefined(var4)) {
          var2 = var4;
        }
      }

      level._color_friendly_spawners = var2;
      return scripts\engine\utility::random(level._color_friendly_spawners);
    }

    return var8;
  }

  return level._color_friendly_spawners[var8];
}

function respawn_friendlies_without_vision_check() {
  if(isDefined(level.respawn_friendlies_force_vision_check)) {
    return 0;
  }

  return scripts\engine\utility::flag("respawn_friendlies");
}

function wait_until_vision_check_satisfied_or_disabled() {
  if(scripts\engine\utility::flag("player_looks_away_from_spawner")) {
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

function spawn_hidden_reinforcement(var0, var1) {
  level endon("kill_color_replacements");
  level endon("kill_hidden_reinforcement_waiting");
  var2 = undefined;

  for(;;) {
    if(!respawn_friendlies_without_vision_check()) {
      if(!isDefined(level.friendly_respawn_vision_checker_thread)) {
        thread friendly_spawner_vision_checker();
      }

      for(;;) {
        wait_until_vision_check_satisfied_or_disabled();
        scripts\engine\utility::flag_waitopen("friendly_spawner_locked");

        if(scripts\engine\utility::flag("player_looks_away_from_spawner") || respawn_friendlies_without_vision_check()) {
          break;
        }
      }

      scripts\engine\utility::flag_set("friendly_spawner_locked");
    }

    var3 = get_color_spawner(var0, var1);
    var3.count = 1;
    var4 = var3.origin;
    var3.origin = level.respawn_spawner_org;
    scripts\engine\utility::script_delay();
    var2 = var3 stalingradspawn();
    var3.origin = var4;

    if(scripts\common\ai::spawn_failed(var2)) {
      thread lock_spawner_for_awhile();
      wait 1;
      continue;
    }

    level notify("reinforcement_spawned", var2);
    break;
  }

  for(;;) {
    if(!isDefined(var1)) {
      break;
    }

    if(get_color_from_order(var1, level.current_color_order) == "none") {
      break;
    }

    var1 = level.current_color_order[var1];
  }

  if(isDefined(var1)) {
    var2 scripts\engine\sp\utility::set_force_color(var1);
  }

  thread lock_spawner_for_awhile();
  return var2;
}

function lock_spawner_for_awhile() {
  scripts\engine\utility::flag_set("friendly_spawner_locked");

  if(isDefined(level.friendly_respawn_lock_func)) {
    [[level.friendly_respawn_lock_func]]();
  } else {
    wait 2;
  }

  scripts\engine\utility::flag_clear("friendly_spawner_locked");
}

function player_sees_spawner() {
  var0 = 0;
  scripts\engine\utility::flag_clear("player_looks_away_from_spawner");
}

function kill_color_replacements() {
  scripts\engine\utility::flag_clear("friendly_spawner_locked");
  level notify("kill_color_replacements");
  var0 = getaiarray();
  scripts\engine\utility::array_thread(var0, &remove_replace_on_death);
}

function remove_replace_on_death() {
  self.replace_on_death = undefined;
}

function get_team(var0) {
  if(isDefined(self.team) && !isDefined(var0)) {
    var0 = self.team;
  }

  return level.color_teams[var0];
}