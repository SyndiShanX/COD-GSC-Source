/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\stealth\utility.gsc
***********************************************/

#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\stealth\callbacks;
#using scripts\stealth\debug;
#using scripts\stealth\enemy;
#using scripts\stealth\friendly;
#using scripts\stealth\init;
#using scripts\stealth\manager;
#using scripts\stealth\neutral;
#using scripts\stealth\threat_sight;
#namespace utility;

function get_group(name) {
  if(!isDefined(level.stealth.groupdata.groups[name])) {
    return undefined;
  }

  return level.stealth.groupdata.groups[name].members;
}

function group_flag_clear(f, group) {
  name = get_group_flagname(f, group);
  flag_clear(name);
  array = level.stealth.group.flags[f];
  clear = 1;

  foreach(value in array) {
    if(!issubstr(value, "allies") && flag(value)) {
      return;
    }
  }

  if(flag(name) && self != level) {
    self notify(f);
  }

  flag_clear(f);
}

function group_flag_set(f) {
  assertex(issentient(self), "an AI must call this function");
  name = get_group_flagname(f);

  if(!flag(name) && self != level) {
    self notify(f);
  }

  flag_set(name);
  flag_set(f);
}

function group_flag(f) {
  assertex(issentient(self), "an AI must call this function");
  name = get_group_flagname(f);
  return flag(name);
}

function get_group_flagname(f, group) {
  if(!isDefined(group)) {
    assertex(issentient(self), "an AI must call this function");
    group = self.script_stealthgroup;
  }

  name = f + "-Group:" + group;
  return name;
}

function group_flag_wait(f) {
  name = get_group_flagname(f);
  flag_wait(name);
}

function group_flag_waitopen(f) {
  name = get_group_flagname(f);
  flag_waitopen(name);
}

function group_flag_wait_or_timeout(f, timer) {
  name = get_group_flagname(f);
  flag_wait_or_timeout(name, timer);
}

function group_flag_waitopen_or_timeout(f, timer) {
  name = get_group_flagname(f);
  flag_waitopen_or_timeout(name, timer);
}

function group_flag_init(f) {
  assertex(issentient(self), "an AI must call this function");

  if(isDefined(self.script_stealthgroup)) {
    self.script_stealthgroup = string(self.script_stealthgroup);
  } else {
    self.script_stealthgroup = "default";
  }

  if(!ismp() && self.team == "allies") {
    self.script_stealthgroup += "allies";
  }

  if(!flag_exist(f)) {
    flag_init(f);
  }

  name = get_group_flagname(f);

  if(!flag_exist(name)) {
    flag_init(name);

    if(!isDefined(level.stealth.group.flags[f])) {
      level.stealth.group.flags[f] = [];
    }

    level.stealth.group.flags[f][level.stealth.group.flags[f].size] = name;
  }
}

function group_setcombatgoalRadius(group, goalradius) {
  assert(isDefined(level.stealth));

  if(!isDefined(level.stealth.combat_goalradius)) {
    level.stealth.combat_goalradius = [];
  }

  level.stealth.combat_goalradius[group] = goalradius;
}

function group_add() {
  assertex(issentient(self), "an AI must call this function");

  if(!isDefined(level.stealth.group.groups[self.script_stealthgroup])) {
    level.stealth.group.groups[self.script_stealthgroup] = [];
    level.stealth.group notify(self.script_stealthgroup);
  }

  level.stealth.group.groups[self.script_stealthgroup][level.stealth.group.groups[self.script_stealthgroup].size] = self;
}

function group_spotted_flag() {
  if(!ismp()) {
    assert(self.team != "axis", "group flag no longer supported on enemy teams.");
  }

  name = get_group_flagname("stealth_spotted");
  return flag(name);
}

function any_groups_in_combat() {
  if(!flag("stealth_enabled")) {
    return 0;
  }

  return function_1bb1470f934a81eb();
}

function check_stealth() {
  assertex(isDefined(self.stealth), "stealth is not enabled on this AI at location: " + self.origin);
}

function set_detect_ranges(hidden, spotted, var_8f3f480583606401) {
  if(!isDefined(hidden) && !isDefined(spotted)) {
    assertmsg("Please define at least one array!");
  }

  scripts\stealth\manager::set_detect_ranges_internal(hidden, spotted, var_8f3f480583606401);
}

function set_min_detect_range_darkness(hidden, spotted) {
  if(!isDefined(hidden) && !isDefined(spotted)) {
    assertmsg("Please define at least one value!");
  }

  if(isDefined(hidden)) {
    function_f53f47c5e7e21548("hidden", "prone", hidden["prone"]);
    function_f53f47c5e7e21548("hidden", "crouch", hidden["crouch"]);
    function_f53f47c5e7e21548("hidden", "stand", hidden["stand"]);
  }

  if(isDefined(spotted)) {
    function_f53f47c5e7e21548("spotted", "prone", spotted["prone"]);
    function_f53f47c5e7e21548("spotted", "crouch", spotted["crouch"]);
    function_f53f47c5e7e21548("spotted", "stand", spotted["stand"]);
  }
}

function function_f3883fe06a11269(hidden, spotted) {
  if(!isDefined(hidden) && !isDefined(spotted)) {
    assertmsg("Please define at least one value!");
  }

  if(isDefined(hidden)) {
    function_9c8f4ad66661c757("hidden", "prone", hidden["prone"]);
    function_9c8f4ad66661c757("hidden", "crouch", hidden["crouch"]);
    function_9c8f4ad66661c757("hidden", "stand", hidden["stand"]);
  }

  if(isDefined(spotted)) {
    function_9c8f4ad66661c757("spotted", "prone", spotted["prone"]);
    function_9c8f4ad66661c757("spotted", "crouch", spotted["crouch"]);
    function_9c8f4ad66661c757("spotted", "stand", spotted["stand"]);
  }
}

function do_stealth() {
  if(!isDefined(level.player.stealth)) {
    scripts\stealth\init::set_stealth_mode(1);
  }

  switch (self.team) {
    case #"hash_24b14065e10b1f8d":
    case #"hash_7c2d091e6337bf54":
      thread scripts\stealth\enemy::main();
      break;
    case #"hash_5f54b9bf7583687f":
      thread scripts\stealth\friendly::main();
      break;
    case #"hash_a571cacc018623b8":
      thread scripts\stealth\neutral::main();
      break;
  }
}

function save_last_goal() {
  if(isDefined(self.stealth.last_goal)) {
    return;
  }

  self.saved_script_forcegoal = self.script_forcegoal;

  if(isDefined(self.patharray)) {
    if(self.patharrayindex == self.patharray.size - 1) {
      index = self.patharrayindex;
    } else {
      index = self.patharrayindex + 1;
    }

    self.stealth.last_goal = self.patharray[index];
    self.stealth.var_7fc1729e33311de3 = self.var_a2bac30a03260051;
    return;
  }

  if(isDefined(self.last_set_goalnode)) {
    self.stealth.last_goal = self.last_set_goalnode;
    return;
  }

  if(isDefined(self.last_set_goalent)) {
    self.stealth.last_goal = self.last_set_goalent;
  }
}

function set_patrol_move_loop_anim(animoverride) {
  assertmsg("really?not currently supported.");
}

function set_patrol_style(style, allowreact, reactposition, magnitude) {
  switch (style) {
    case #"hash_186d745a92c317d9":
      self.var_e31ee88092e41cc8 = 1;
      break;
  }

  self setpatrolstyle(style, allowreact, reactposition, magnitude);
}

function get_patrol_style() {
  assert(isDefined(self.stealth));
  return asm_getdemeanor();
}

function set_patrol_react(position, magnitude) {
  self function_68f50ada6e19d8f4(position, magnitude);
}

function function_783cf2a7aaab23c() {
  if(isDefined(self.fnstealthgotonode) && isDefined(self.stealth.last_goal)) {
    if(isDefined(self.saved_script_forcegoal)) {
      self.script_forcegoal = self.saved_script_forcegoal;
    }

    self thread[[self.fnstealthgotonode]](self.stealth.last_goal, undefined, undefined, self.stealth.var_7fc1729e33311de3);
    self.saved_script_forcegoal = undefined;
    self.stealth.last_goal = undefined;
    self.stealth.var_7fc1729e33311de3 = undefined;
    return true;
  }

  return false;
}

function set_path_dist(ent) {
  ent.distsqrd = get_path_dist_sq(self.origin, ent.origin, self);
}

function get_path_dist_sq(from, to, var_320b468dc1d97042) {
  path = self findpath(from, to);

  if(isDefined(var_320b468dc1d97042)) {
    var_320b468dc1d97042.path = path;
  }

  distsq = 0;

  for(i = 1; i < path.size; i++) {
    distsq += distancesquared(path[i - 1], path[i]);
  }

  return distsq;
}

function remove_path_dist() {
  self.path = undefined;
  self.distsqrd = undefined;
}

function is_visible(other) {
  if(isPlayer(self)) {
    if(within_fov(self.origin, self.angles, other.origin, 0.766)) {
      if(isDefined(other.tagging_visible) || tagging_shield()) {
        return 1;
      }

      if(scripts\anim\utility_common::player_can_see_ai(self, other, 250)) {
        return 1;
      }
    }
  } else if(isDefined(other.team) && self.team == other.team) {
    return self cansee(other, 300);
  } else {
    return self cansee(other);
  }

  return 0;
}

function tagging_shield() {
  return isDefined(self.offhandshield) && isDefined(self.offhandshield.active) && self.offhandshield.active;
}

function setbattlechatter(state) {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnsetbattlechatter)) {
    return [[level.stealth.fnsetbattlechatter]](state);
  }
}

function addeventplaybcs(eventaction, eventtype, modifier, delay, eventstruct, force) {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnaddeventplaybcs)) {
    return [[level.stealth.fnaddeventplaybcs]](eventaction, eventtype, modifier, delay, eventstruct, force);
  }
}

function animgenericcustomanimmode(guy, custom_animmode, anime, tag, thread_func, var_212b748f7df888b0) {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnanimgenericcustomanimmode)) {
    return [[level.stealth.fnanimgenericcustomanimmode]](guy, custom_animmode, anime, tag, thread_func, var_212b748f7df888b0);
  }
}

function stealth_music(musichidden, musicspotted) {
  self notify("stealth_music");
  self endon("stealth_music");
  thread stealth_music_pause_monitor();

  while(true) {
    flag_wait("stealth_enabled");
    flag_waitopen("stealth_spotted");
    flag_waitopen("stealth_music_pause");
    function_f81d9864f1fc95a6();

    foreach(player in level.players) {
      player thread stealth_music_transition(musichidden);
    }

    flag_wait("stealth_spotted");
    flag_waitopen("stealth_music_pause");
    function_4efc63abff5f42d3();

    foreach(player in level.players) {
      player thread stealth_music_transition(musicspotted);
    }
  }
}

function function_4efc63abff5f42d3() {
  if(isDefined(level.var_667495cce3974c46)) {
    wait level.var_667495cce3974c46;
  }

  if(getdvarint(@ "hash_5cf56ca298c06c21", 0) != 0) {
    wait getdvarint(@ "hash_5cf56ca298c06c21", 0);
  }
}

function function_f81d9864f1fc95a6() {
  if(isDefined(level.var_e588ee33138024c3)) {
    wait level.var_e588ee33138024c3;
  }

  if(getdvarint(@ "hash_9a92f5b582657d72", 0) != 0) {
    wait getdvarint(@ "hash_9a92f5b582657d72", 0);
  }
}

function stealth_music_stop() {
  self notify("stealth_music");
  self notify("stealth_music_pause_monitor");

  foreach(player in level.players) {
    player thread stealth_music_transition(undefined);
  }
}

function stealth_music_pause_monitor(musichidden, musicspotted) {
  self notify("stealth_music_pause_monitor");
  self endon("stealth_music_pause_monitor");

  while(true) {
    flag_wait("stealth_music_pause");

    foreach(player in level.players) {
      player thread stealth_music_transition(undefined);
    }

    flag_waitopen("stealth_music_pause");

    if(flag("stealth_spotted")) {
      foreach(player in level.players) {
        player thread stealth_music_transition(musicspotted);
      }

      continue;
    }

    foreach(player in level.players) {
      player thread stealth_music_transition(musichidden);
    }
  }
}

function stealth_music_transition(aliasto) {
  if(isDefined(self.fnstealthmusictransition)) {
    return [[self.fnstealthmusictransition]](aliasto);
  }
}

function update_light_meter() {
  if(isDefined(self.fnupdatelightmeter)) {
    return [[self.fnupdatelightmeter]]();
  }
}

function enable_stealth_for_ai(enabled) {
  if(!enabled) {
    self.maxvisibledist = 8192;

    if(ent_flag_exist("stealth_enabled") && ent_flag("stealth_enabled") && self.team == "axis") {
      dummyevent = spawnStruct();
      dummyevent.origin = level.player.origin;
      dummyevent.investigate_point = level.player.origin;
      dummyevent.investigate_pos = level.player.origin;
      dummyevent.type = "combat";
      dummyevent.typeorig = "attack";
      self.dontevershoot = 0;
      self.dontattackme = 0;
      scripts\stealth\enemy::bt_event_combat(dummyevent);
    }
  }

  if(ent_flag_exist("stealth_enabled")) {
    if(enabled) {
      ent_flag_set("stealth_enabled");
      return;
    }

    ent_flag_clear("stealth_enabled");
  }
}

function custom_state_functions(array) {
  assertex(!isDefined(self.stealth), "Stealth system is already active, your custom stealth state functions are not going to be called.");

  if(isDefined(array["spotted"])) {
    self.stealth_state_func["spotted"] = array["spotted"];
  }

  if(isDefined(array["hidden"])) {
    self.stealth_state_func["hidden"] = array["hidden"];
  }
}

function set_stealth_func(type, func) {
  self.stealth.funcs[type] = func;

  if(isai(self)) {
    self function_a29879bf1276a08a(type, func);
  }
}

function set_event_override(eventtype, funcoverride) {
  if(isDefined(eventtype) && isDefined(self.stealth) && isDefined(self.stealth.funcs)) {
    self.stealth.funcs["event_" + eventtype] = funcoverride;
  }
}

function bcisincombat() {
  self endon("death");

  if(isDefined(self.fnisinstealthcombat) && self[[self.fnisinstealthcombat]]()) {
    return true;
  }

  if(!isDefined(self.stealth)) {
    return true;
  }

  return false;
}

function _autosave_stealthcheck() {
  return true;
}

function get_player_drone() {
  if(isDefined(level.stealth.fngetplayerdrone)) {
    return [[level.stealth.fngetplayerdrone]](self);
  }
}

function is_idling() {
  if(!isDefined(self.stealth)) {
    return 0;
  }

  return self[[self.fnisinstealthidle]]();
}

function function_c9f8c83eb3de1b32() {
  if(!isDefined(self.stealth)) {
    return 0;
  }

  return self[[self.fnisinstealthinvestigate]]();
}

function function_cdca96a984fdb85() {
  if(!isDefined(self.stealth)) {
    return 0;
  }

  return self[[self.fnisinstealthhunt]]();
}

function function_6a86dd83c01f8faa() {
  if(!isDefined(self.stealth)) {
    return 1;
  }

  return self[[self.fnisinstealthcombat]]();
}

function function_c14048638b343b7f(state, event) {
  if(!isDefined(self.stealth)) {
    return;
  }

  self[[self.fnsetstealthstate]](state, event);
}

function function_6516755416a6584b(filter_func, severity) {
  all_states = 0;

  if(!isDefined(severity)) {
    severity = ["all"];
    all_states = 1;
  }

  if(!isarray(severity)) {
    severity = [severity];
  }

  if(!all_states) {
    all_states = array_contains(severity, "all");
  }

  if(all_states || array_contains(severity, "investigate")) {
    set_stealth_func("event_investigate", filter_func);
  }

  if(all_states || array_contains(severity, "cover_blown")) {
    set_stealth_func("event_cover_blown", filter_func);
  }

  if(all_states || array_contains(severity, "combat")) {
    set_stealth_func("event_combat", filter_func);
  }
}