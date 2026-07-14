/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\stealth\utility.gsc
***************************************/

#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\stealth\enemy;
#using scripts\stealth\friendly;
#using scripts\stealth\init;
#using scripts\stealth\manager;
#using scripts\stealth\neutral;
#namespace utility;

function get_group(name) {
  if(!isDefined(level.stealth.groupdata.groups[name])) {
    return undefined;
  }

  return level.stealth.groupdata.groups[name].members;
}

function get_group_flagname(f, group) {
  if(!isDefined(group)) {
    assert(issentient(self), "<dev string:x24>");
    group = self.script_stealthgroup;
  }

  name = f + "\x94\xf7\xba\x05_E\xe1" + group;
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

function group_flag_init(f) {
  assert(issentient(self), "<dev string:x24>");

  if(isDefined(self.script_stealthgroup)) {
    self.script_stealthgroup = string(self.script_stealthgroup);
  } else {
    self.script_stealthgroup = "\x91\xca\xcc\v\xab\xd8:";
  }

  if(!ismp() && self.team == "O\x15\x1b\xad\x9ff") {
    self.script_stealthgroup += "O\x15\x1b\xad\x9ff";
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
  assert(issentient(self), "<dev string:x24>");

  if(!isDefined(level.stealth.group.groups[self.script_stealthgroup])) {
    level.stealth.group.groups[self.script_stealthgroup] = [];
    level.stealth.group notify(self.script_stealthgroup);
  }

  level.stealth.group.groups[self.script_stealthgroup][level.stealth.group.groups[self.script_stealthgroup].size] = self;
}

function group_spotted_flag() {
  if(!ismp()) {
    assert(self.team != "<dev string:x45>", "<dev string:x4d>");
  }

  name = get_group_flagname("7tV\x16\xb1th_\x9b\x83\xbd\xa3\xd1ed");
  return flag(name);
}

function any_groups_in_combat() {
  if(!flag("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3")) {
    return 0;
  }

  return function_f83a77097be9668e();
}

function check_stealth() {
  assert(isDefined(self.stealth), "<dev string:x7f>" + self.origin);
}

function set_detect_ranges(hidden, spotted) {
  if(!isDefined(hidden) && !isDefined(spotted)) {
    assertmsg("<dev string:xb2>");
  }

  stealth_manager::set_detect_ranges_internal(hidden, spotted);
}

function set_min_detect_range_darkness(hidden, spotted) {
  if(!isDefined(hidden) && !isDefined(spotted)) {
    assertmsg("<dev string:xd7>");
  }

  if(isDefined(hidden)) {
    function_c63094004125dfc1("\xf8VZW\xd3\xad", "GX\xa9]\x82", hidden["GX\xa9]\x82"]);
    function_c63094004125dfc1("\xf8VZW\xd3\xad", "1x\xc5\xb4\xabx", hidden["1x\xc5\xb4\xabx"]);
    function_c63094004125dfc1("\xf8VZW\xd3\xad", "\x8b\x90\xb5\xc4W", hidden["\x8b\x90\xb5\xc4W"]);
  }

  if(isDefined(spotted)) {
    function_c63094004125dfc1("\x1f\x93?pK+\x9c", "GX\xa9]\x82", spotted["GX\xa9]\x82"]);
    function_c63094004125dfc1("\x1f\x93?pK+\x9c", "1x\xc5\xb4\xabx", spotted["1x\xc5\xb4\xabx"]);
    function_c63094004125dfc1("\x1f\x93?pK+\x9c", "\x8b\x90\xb5\xc4W", spotted["\x8b\x90\xb5\xc4W"]);
  }
}

function function_45380219f0ec11c0(hidden, spotted) {
  if(!isDefined(hidden) && !isDefined(spotted)) {
    assertmsg("<dev string:xd7>");
  }

  if(isDefined(hidden)) {
    function_969c9c5a1df7bfae("\xf8VZW\xd3\xad", "GX\xa9]\x82", hidden["GX\xa9]\x82"]);
    function_969c9c5a1df7bfae("\xf8VZW\xd3\xad", "1x\xc5\xb4\xabx", hidden["1x\xc5\xb4\xabx"]);
    function_969c9c5a1df7bfae("\xf8VZW\xd3\xad", "\x8b\x90\xb5\xc4W", hidden["\x8b\x90\xb5\xc4W"]);
  }

  if(isDefined(spotted)) {
    function_969c9c5a1df7bfae("\x1f\x93?pK+\x9c", "GX\xa9]\x82", spotted["GX\xa9]\x82"]);
    function_969c9c5a1df7bfae("\x1f\x93?pK+\x9c", "1x\xc5\xb4\xabx", spotted["1x\xc5\xb4\xabx"]);
    function_969c9c5a1df7bfae("\x1f\x93?pK+\x9c", "\x8b\x90\xb5\xc4W", spotted["\x8b\x90\xb5\xc4W"]);
  }
}

function do_stealth() {
  if(!isDefined(level.player.stealth)) {
    init::set_stealth_mode(1);
  }

  switch (self.team) {
    case #"hash_24b14065e10b1f8d":
    case #"hash_7c2d091e6337bf54":
      thread enemy::main();
      break;
    case #"hash_5f54b9bf7583687f":
      thread friendly::main();
      break;
    case #"hash_a571cacc018623b8":
      thread neutral::main();
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
    self.stealth.var_22b9dcd69fd4208e = self.patharraystartnode;
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
  assertmsg("<dev string:xfc>");
}

function set_patrol_style(style, allowreact, reactposition, magnitude) {
  switch (style) {
    case #"hash_186d745a92c317d9":
      self.var_1d6eabfad177376d = 1;
      break;
  }

  self setpatrolstyle(style, allowreact, reactposition, magnitude);
}

function get_patrol_style() {
  assert(isDefined(self.stealth));
  return asm::asm_getdemeanor();
}

function set_patrol_react(position, magnitude) {
  self setpatrolreact(position, magnitude);
}

function function_21a129be478aa01() {
  if(isDefined(self.fnstealthgotonode) && isDefined(self.stealth.last_goal)) {
    if(isDefined(self.saved_script_forcegoal)) {
      self.script_forcegoal = self.saved_script_forcegoal;
    }

    self thread[[self.fnstealthgotonode]](self.stealth.last_goal, undefined, undefined, self.stealth.var_22b9dcd69fd4208e);
    self.saved_script_forcegoal = undefined;
    self.stealth.last_goal = undefined;
    self.stealth.var_22b9dcd69fd4208e = undefined;
    return true;
  }

  return false;
}

function is_visible(other) {
  if(isPlayer(self)) {
    if(within_fov(self.origin, self.angles, other.origin, 0.766)) {
      if(isDefined(other.tagging_visible) || tagging_shield()) {
        return 1;
      }

      if(utility_common::player_can_see_ai(self, other, 250)) {
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

function animgenericcustomanimmode(guy, custom_animmode, anime, tag, thread_func, var_83264c7dd9405255) {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnanimgenericcustomanimmode)) {
    return [[level.stealth.fnanimgenericcustomanimmode]](guy, custom_animmode, anime, tag, thread_func, var_83264c7dd9405255);
  }
}

function stealth_music(musichidden, musicspotted) {
  self notify("2k\xb3@\xa0\xd3\x12ZhV\xd2\xf7P");
  self endon("2k\xb3@\xa0\xd3\x12ZhV\xd2\xf7P");
  thread stealth_music_pause_monitor();

  while(true) {
    flag_wait("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");
    flag_waitopen("7tV\x16\xb1th_\x9b\x83\xbd\xa3\xd1ed");
    flag_waitopen("G\x15[4\x90\xf0\x0f@Y\xf5\x11\xb0$\x1c\x01NF\x1bk");
    function_2351a4478cf96f2b();

    foreach(player in level.players) {
      player thread stealth_music_transition(musichidden);
    }

    flag_wait("7tV\x16\xb1th_\x9b\x83\xbd\xa3\xd1ed");
    flag_waitopen("G\x15[4\x90\xf0\x0f@Y\xf5\x11\xb0$\x1c\x01NF\x1bk");
    function_ef804525c827ddb2();

    foreach(player in level.players) {
      player thread stealth_music_transition(musicspotted);
    }
  }
}

function function_ef804525c827ddb2() {
  if(isDefined(level.var_e5cf637e5534040b)) {
    wait level.var_e5cf637e5534040b;
  }

  if(getdvarint(@ "hash_5cf56ca298c06c21", 0) != 0) {
    wait getdvarint(@ "hash_5cf56ca298c06c21", 0);
  }
}

function function_2351a4478cf96f2b() {
  if(isDefined(level.var_6e18683c40b9f3d2)) {
    wait level.var_6e18683c40b9f3d2;
  }

  if(getdvarint(@ "hash_9a92f5b582657d72", 0) != 0) {
    wait getdvarint(@ "hash_9a92f5b582657d72", 0);
  }
}

function stealth_music_stop() {
  self notify("2k\xb3@\xa0\xd3\x12ZhV\xd2\xf7P");
  self notify("\xe2\x8c\x8a\xa3L\x8ep\xcd\x8b\rmx\xa3s\xdc\xae9\xd1Y_*\xdb\xba\x05\xe4\xf6\x11");

  foreach(player in level.players) {
    player thread stealth_music_transition(undefined);
  }
}

function stealth_music_pause_monitor(musichidden, musicspotted) {
  self notify("\xe2\x8c\x8a\xa3L\x8ep\xcd\x8b\rmx\xa3s\xdc\xae9\xd1Y_*\xdb\xba\x05\xe4\xf6\x11");
  self endon("\xe2\x8c\x8a\xa3L\x8ep\xcd\x8b\rmx\xa3s\xdc\xae9\xd1Y_*\xdb\xba\x05\xe4\xf6\x11");

  while(true) {
    flag_wait("G\x15[4\x90\xf0\x0f@Y\xf5\x11\xb0$\x1c\x01NF\x1bk");

    foreach(player in level.players) {
      player thread stealth_music_transition(undefined);
    }

    flag_waitopen("G\x15[4\x90\xf0\x0f@Y\xf5\x11\xb0$\x1c\x01NF\x1bk");

    if(flag("7tV\x16\xb1th_\x9b\x83\xbd\xa3\xd1ed")) {
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

    if(ent_flag_exist("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3") && ent_flag("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3") && self.team == "?\xb1\xc0\x9a") {
      dummyevent = spawnStruct();
      dummyevent.origin = level.player.origin;
      dummyevent.investigate_point = level.player.origin;
      dummyevent.investigate_pos = level.player.origin;
      dummyevent.type = "\xe3\xd0\xc3e\x85h";
      dummyevent.typeorig = "\x11\xf9\x9b\x01\xb2\xf4";
      self.dontevershoot = 0;
      self.dontattackme = 0;
      enemy::bt_event_combat(dummyevent);
    }
  }

  if(ent_flag_exist("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3")) {
    if(enabled) {
      ent_flag_set("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");
      return;
    }

    ent_flag_clear("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");
  }
}

function custom_state_functions(array) {
  assert(!isDefined(self.stealth), "<dev string:x121>");

  if(isDefined(array["\x1f\x93?pK+\x9c"])) {
    self.stealth_state_func["\x1f\x93?pK+\x9c"] = array["\x1f\x93?pK+\x9c"];
  }

  if(isDefined(array["\xf8VZW\xd3\xad"])) {
    self.stealth_state_func["\xf8VZW\xd3\xad"] = array["\xf8VZW\xd3\xad"];
  }
}

function set_stealth_func(type, func) {
  self.stealth.funcs[type] = func;

  if(isai(self)) {
    self function_a92ce75a37eeb7f7(type, func);
  }
}

function set_event_override(eventtype, funcoverride) {
  if(isDefined(self.stealth) && isDefined(eventtype) && isDefined(self.stealth.funcs)) {
    self.stealth.funcs["\xfd\x1b\xb8\x95\xff\x1b" + eventtype] = funcoverride;
  }
}

function bcisincombat() {
  self endon("\x1e\xfd\xd1\xa2\a");

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

function is_investigating() {
  if(!isDefined(self.stealth)) {
    return 0;
  }

  return self[[self.fnisinstealthinvestigate]]();
}

function is_hunting() {
  if(!isDefined(self.stealth)) {
    return 0;
  }

  return self[[self.fnisinstealthhunt]]();
}

function function_4c52c2d0a7b596cf() {
  if(!isDefined(self.stealth)) {
    return 1;
  }

  return self[[self.fnisinstealthcombat]]();
}

function function_bd30b9ad0ff2b50e(state, event) {
  if(!isDefined(self.stealth)) {
    return;
  }

  self[[self.fnsetstealthstate]](state, event);
}

function function_786a2b833a3fbe86(filter_func, severity) {
  all_states = 0;

  if(!isDefined(severity)) {
    severity = ["\xc0\xc6J"];
    all_states = 1;
  }

  if(!isarray(severity)) {
    severity = [severity];
  }

  if(!all_states) {
    all_states = arraycontains(severity, "\xc0\xc6J");
  }

  if(all_states || arraycontains(severity, "\xc2\x99.K\xdd\x9fBw>]\x8e")) {
    set_stealth_func("\xdf4\x9c\x03\xca\xf9x^l\xf4\xdf\xc7;\x150a\xef", filter_func);
  }

  if(all_states || arraycontains(severity, "\x8e\x86U\b\xe9s\xa7\xb1\x87\x99\xb9")) {
    set_stealth_func("\x04;\xcet\xe5\xcc\xb5\xd7\xc79L\x0fz+M=\x8c", filter_func);
  }

  if(all_states || arraycontains(severity, "\xe3\xd0\xc3e\x85h")) {
    set_stealth_func("\x18u!\x91\xd4<\xb3xn\xe4\x864", filter_func);
  }

  if(all_states || arraycontains(severity, "9\xa6H\n\b\xcd$")) {
    set_stealth_func("\xccj\xf9\xc93\xc7C\xd0\xd0Q04\v", filter_func);
  }
}

function function_8627d9834438b4be() {
  range = level.stealth.damage_auto_range;

  if(isDefined(self.stealth.override_damage_auto_range)) {
    range = self.stealth.override_damage_auto_range;
  } else if(isDefined(level.stealth.override_damage_auto_range)) {
    range = level.stealth.override_damage_auto_range;
  }

  if(!isDefined(range)) {
    range = 240;
  }

  return range;
}

function function_d8481da8b3907ef4() {
  range = level.stealth.damage_sight_range;

  if(isDefined(self.stealth.override_damage_sight_range)) {
    range = self.stealth.override_damage_sight_range;
  } else if(isDefined(level.stealth.override_damage_sight_range)) {
    range = level.stealth.override_damage_sight_range;
  }

  if(!isDefined(range)) {
    range = 750;
  }

  return range;
}

function function_f8501b6198f503f5() {
  range = level.stealth.var_602277e5a2e2d5fa;

  if(isDefined(self.stealth.var_ca183bf0a7c4b5cf)) {
    range = self.stealth.var_ca183bf0a7c4b5cf;
  } else if(isDefined(level.stealth.var_ca183bf0a7c4b5cf)) {
    range = level.stealth.var_ca183bf0a7c4b5cf;
  }

  if(!isDefined(range)) {
    range = 1200;
  }

  return range;
}

function function_dad7b074713963f6(eventtype, other, type, isperipheral) {
  if(!(isDefined(self) && isDefined(self.stealth))) {
    return;
  }

  rangeauto = function_8627d9834438b4be();
  rangesight = function_d8481da8b3907ef4();

  if(istrue(isperipheral)) {
    rangesight = function_f8501b6198f503f5();
  }

  stealtheventbroadcast(eventtype, self, other, rangeauto, rangesight, type);
}