/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\stealth\utility.gsc
***********************************************/

#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\flashlight;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\debug;
#using scripts\core_common\stealth\enemy;
#using scripts\core_common\stealth\friendly;
#using scripts\core_common\stealth\group;
#using scripts\core_common\stealth\manager;
#using scripts\core_common\stealth\neutral;
#using scripts\core_common\stealth\threat_sight;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\util;
#namespace utility;

function scalevolume(ent, vol) {}

#namespace namespace_979752dc;

function get_group(name) {
  if(!isDefined(level.stealth.groupdata.groups[name])) {
    return undefined;
  }

  return level.stealth.groupdata.groups[name].members;
}

function group_flag_clear(f, group) {
  name = get_group_flagname(f, group);
  level flag::clear(name);
  array = level.stealth.group.flags[f];
  clear = 1;

  foreach(value in array) {
    if(!issubstr(value, "allies") && level flag::get(value)) {
      return;
    }
  }

  if(level flag::get(name) && self != level) {
    self notify(f);
  }

  level flag::clear(f);
}

function group_flag_set(f) {
  assert(issentient(self), "<dev string:x38>");
  name = self get_group_flagname(f);

  if(!level flag::get(name) && self != level) {
    self notify(f);
  }

  level flag::set(name);
  level flag::set(f);
}

function group_flag(f) {
  assert(issentient(self), "<dev string:x38>");
  name = self get_group_flagname(f);
  return level flag::get(name);
}

function get_group_flagname(f, group) {
  if(!isDefined(group)) {
    assert(issentient(self), "<dev string:x38>");
    group = self.script_stealthgroup;
  }

  name = f + "-Group:" + group;
  return name;
}

function group_flag_wait(f) {
  name = get_group_flagname(f);
  level flag::wait_till(name);
}

function group_flag_waitopen(f) {
  name = get_group_flagname(f);
  level flag::wait_till_clear(name);
}

function function_9b4d5512(f, timer) {
  name = get_group_flagname(f);
  level flag::wait_till_timeout(timer, name);
}

function group_flag_waitopen_or_timeout(f, timer) {
  name = get_group_flagname(f);
  level flag::wait_till_clear_timeout(timer, name);
}

function group_flag_init(f) {
  assert(issentient(self), "<dev string:x38>");

  if(isDefined(self.script_stealthgroup)) {
    self.script_stealthgroup = string(self.script_stealthgroup);
  } else {
    self.script_stealthgroup = "default";
  }

  if(self.team == "allies") {
    self.script_stealthgroup += "allies";
  }

  if(!level flag::exists(f)) {
    level flag::init(f);
  }

  name = self get_group_flagname(f);

  if(!level flag::exists(name)) {
    level flag::init(name);

    if(!isDefined(level.stealth.group.flags[f])) {
      level.stealth.group.flags[f] = [];
    }

    level.stealth.group.flags[f][level.stealth.group.flags[f].size] = name;
  }

  return name;
}

function function_740dbf99() {
  level flag::clear("stealth_spotted");
  level flag::clear("stealth_meter_combat_alerted");
}

function group_setcombatgoalradius(group, goalradius) {
  assert(isDefined(level.stealth));

  if(!isDefined(level.stealth.combat_goalradius)) {
    level.stealth.combat_goalradius = [];
  }

  level.stealth.combat_goalradius[group] = goalradius;
}

function group_add() {
  assert(issentient(self), "<dev string:x38>");

  if(!isDefined(level.stealth.group.groups[self.script_stealthgroup])) {
    level.stealth.group.groups[self.script_stealthgroup] = [];
    level.stealth.group notify(self.script_stealthgroup);
  }

  level.stealth.group.groups[self.script_stealthgroup][level.stealth.group.groups[self.script_stealthgroup].size] = self;
}

function group_spotted_flag() {
  assert(self.team != "<dev string:x59>", "<dev string:x61>");
  assert(isDefined(self.stealth.var_103386e8));
  return level flag::get(self.stealth.var_103386e8);
}

function any_groups_in_combat(stealthgroups) {
  if(!level flag::get("stealth_enabled")) {
    return false;
  }

  foreach(group in level.stealth.groupdata.groups) {
    if(isDefined(stealthgroups) && !array::contains(stealthgroups, group.name)) {
      continue;
    }

    if(stealth_group::group_anyoneincombat(group.name)) {
      return true;
    }
  }

  return false;
}

function get_stealth_state() {
  switch (self.stealth.state) {
    case 0:
      return "normal";
    case 1:
      return "warning";
    case 2:
      return "warning";
    case 3:
      return "attack";
  }
}

function set_stealth_state(msg) {
  switch (msg) {
    case # "attack":
      num = 3;
      break;
    case # "warning2":
      num = 2;
      break;
    case # "warning1":
      num = 1;
      break;
    default:
      num = 0;
      break;
  }

  self.stealth.state = num;
}

function check_stealth() {
  assert(isDefined(self.stealth), "<dev string:x93>" + self.origin);
}

function alertlevel_init_map() {
  level.stealth.alert_levels_exe = [];
  level.stealth.alert_levels_exe[#"normal"] = "noncombat";
  level.stealth.alert_levels_exe[#"reset"] = "noncombat";
  level.stealth.alert_levels_exe[#"warning1"] = "low_alert";
  level.stealth.alert_levels_exe[#"warning2"] = "high_alert";
  level.stealth.alert_levels_exe[#"combat_hunt"] = "high_alert";
  level.stealth.alert_levels_exe[#"attack"] = "combat";
  level.stealth.alert_levels_int = [];
  level.stealth.alert_levels_int[#"normal"] = 0;
  level.stealth.alert_levels_int[#"reset"] = 0;
  level.stealth.alert_levels_int[#"warning1"] = 2;
  level.stealth.alert_levels_int[#"warning2"] = 3;
  level.stealth.alert_levels_int[#"combat_hunt"] = 3;
  level.stealth.alert_levels_int[#"attack"] = 4;
  level.stealth.alert_levels_exe[#"combat"] = 4;
}

function alertlevel_script_to_exe(alertlevel) {
  if(isDefined(level.stealth.alert_levels_exe[alertlevel])) {
    return level.stealth.alert_levels_exe[alertlevel];
  }

  return alertlevel;
}

function function_7211414e(alertlevel) {
  if(isDefined(level.stealth.alert_levels_int[alertlevel])) {
    return level.stealth.alert_levels_int[alertlevel];
  }

  return -1;
}

function set_detect_ranges(hidden, spotted) {
  if(!isDefined(hidden) && !isDefined(spotted)) {
    assertmsg("<dev string:xc6>");
  }

  stealth_manager::set_detect_ranges_internal(hidden, spotted);
}

function set_min_detect_range_darkness(hidden, spotted) {
  if(!isDefined(hidden) && !isDefined(spotted)) {
    assertmsg("<dev string:xeb>");
  }

  if(isDefined(hidden)) {
    level.stealth.detect.minrangedarkness[#"hidden"][#"prone"] = hidden[#"prone"];
    level.stealth.detect.minrangedarkness[#"hidden"][#"crouch"] = hidden[#"crouch"];
    level.stealth.detect.minrangedarkness[#"hidden"][#"stand"] = hidden[#"stand"];
  }

  if(isDefined(spotted)) {
    level.stealth.detect.minrangedarkness[#"spotted"][#"prone"] = spotted[#"prone"];
    level.stealth.detect.minrangedarkness[#"spotted"][#"crouch"] = spotted[#"crouch"];
    level.stealth.detect.minrangedarkness[#"spotted"][#"stand"] = spotted[#"stand"];
  }
}

function do_stealth() {
  switch (self.team) {
    case # "axis":
    case # "team3":
      self thread stealth_enemy::main();
      break;
    case # "allies":
      self thread namespace_32a4062b::main();
      break;
    case # "neutral":
      self thread namespace_578db516::main();
      break;
  }
}

function save_last_goal() {
  if(isDefined(self.stealth.last_goal)) {
    return "exists";
  }

  result = "goal";
  self.saved_script_forcegoal = self.script_forcegoal;

  if(isDefined(self.last_set_goalnode)) {
    self.stealth.last_goal = self.last_set_goalnode;
  } else if(isDefined(self.last_set_goalent)) {
    self.stealth.last_goal = self.last_set_goalent.origin;
  } else if(isDefined(self.last_set_goalpos)) {
    self.stealth.last_goal = self.last_set_goalpos;
  } else if(isDefined(self.go_to_node)) {
    self.stealth.last_goal = self spawner::function_461ce3e9();
    result = "go_to_node";
  } else {
    self.stealth.last_goal = spawnStruct();
    self.stealth.last_goal.origin = self.origin;
    self.stealth.last_goal.angles = self.angles;
  }

  if(isDefined(self.stealth.last_goal)) {
    return result;
  }

  return undefined;
}

function set_patrol_move_loop_anim(animoverride) {
  assertmsg("<dev string:x110>");
}

function set_default_patrol_style(style) {
  self.stealth.default_patrol_style = style;

  if(isDefined(self.stealth.default_patrol_style)) {
    self set_patrol_style(self.stealth.default_patrol_style);
  }
}

function get_patrol_react_magnitude_int(style) {
  switch (style) {
    case # "small":
      return 0;
    case # "small_medium":
      return 1;
    case # "medium":
      return 2;
    case # "large":
      return 3;
  }

  assertmsg("<dev string:x135>");
}

function set_patrol_style(style, allowreact, reactposition, magnitude) {
  if(style == "unaware") {
    style = "patrol";
  }

  var_70fd8440 = -1;

  var_70fd8440 = getdvarint(#"hash_4aa9c88072661ef2", -1);

  if(var_70fd8440 < 0) {
    self ai::set_behavior_attribute("demeanor", style);
  }

  self.stealth.var_458bda8 = style;

  if(style == "cqb") {
    var_68c74e4f = 60;

    if(isDefined(self.stealth.hunt_speed)) {
      var_68c74e4f = self.stealth.hunt_speed;
    }

    self set_movement_speed(var_68c74e4f);
  }

  if(is_true(allowreact)) {
    self set_patrol_react(reactposition, magnitude, style);
  }
}

function get_patrol_style() {
  assert(isDefined(self.stealth));
  return self.stealth.var_458bda8;
}

function get_patrol_style_default() {
  default_patrol_style = self.stealth.default_patrol_style;

  if(!isDefined(default_patrol_style)) {
    default_patrol_style = level.stealth.default_patrol_style;
  }

  return default_patrol_style;
}

function function_2b21025e(position) {
  if(!isDefined(self.stealth.var_d54b515e)) {
    self.stealth.var_d54b515e = spawnStruct();
  }

  self.stealth.var_d54b515e.position = position;
  self.stealth.var_d54b515e.settime = gettime();
}

function function_b0c91323(var_affacce = 0) {
  if(!isDefined(self.stealth.var_d54b515e.position)) {
    return false;
  }

  currenttime = gettime();

  if(currenttime > self.stealth.var_d54b515e.settime + 100) {
    return false;
  }

  if(var_affacce) {
    if(isDefined(self.stealth.var_d54b515e.processtime) && currenttime == self.stealth.var_d54b515e.processtime) {
      return false;
    }
  }

  return true;
}

function function_ab75abf3() {
  self.stealth.var_d54b515e.processtime = gettime();
}

function set_patrol_react(position, magnitude, style) {
  if(!isDefined(style) || style != "combat") {
    if(isDefined(self.stealth.var_5cc4aa60) && self.stealth.var_5cc4aa60 > gettime()) {
      return;
    }
  }

  if(isDefined(self.stealth.breacting)) {
    if(get_patrol_react_magnitude_int(self.stealth.breacting) >= get_patrol_react_magnitude_int(magnitude)) {
      return;
    }
  }

  assert(magnitude == "<dev string:x15d>" || magnitude == "<dev string:x166>" || magnitude == "<dev string:x176>" || magnitude == "<dev string:x180>");

  if(self.alertlevel == "combat" && magnitude != "large") {
    magnitude = "large";
  }

  self.stealth.patrol_react_magnitude = magnitude;
  self.stealth.patrol_react_pos = position;
  self.stealth.patrol_react_time = gettime();
  self.stealth.var_527ef51c = self haspath();

  if(self isinscriptedstate() && is_true(self._scene_object._s.stealthreact) && !self flag::get("in_action")) {
    [[self._scene_object._o_scene]] - > stop();
  }

  self setblackboardattribute("_react_magnitude", self.stealth.patrol_react_magnitude);
}

function set_goal(goal, faceangles, goalradius = 16) {
  result = 1;

  if(self flag::get("stealth_goal_override")) {
    return;
  }

  self.keepclaimednode = 0;
  self.keepclaimednodeifvalid = 0;

  if(isDefined(faceangles)) {
    goalstruct = spawnStruct();

    if(isvec(goal)) {
      goalstruct.origin = goal;
    } else {
      goalstruct.origin = goal.origin;
    }

    goalstruct.angles = faceangles;
    goal = goalstruct;
  }

  self setgoal(goal);

  if(ispathnode(goal)) {
    result = self usecovernode(goal);
  } else {
    self usecovernode(undefined);
  }

  if(goalradius <= 0) {
    goalradius = undefined;
  }

  self set_goal_radius(goalradius);
  return result;
}

function set_goal_radius(newradius) {
  if(isDefined(newradius)) {
    self val::set(#"stealth", "goalradius", newradius);
    return;
  }

  self val::reset(#"stealth", "goalradius");
}

function alert_delay_distance_time(other) {
  maxwait = 2;

  if(isDefined(self.stealth.maxalertdelay)) {
    maxwait = self.stealth.maxalertdelay;
  }

  if(self[[self.fnisinstealthinvestigate]]()) {
    maxwait = min(1.5, maxwait);
  } else if(self[[self.fnisinstealthhunt]]()) {
    maxwait = min(1, maxwait);
  }

  var_fc45584 = 0.1;
  minwait = 0.4;
  mindist = 64;
  maxdist = 1024;
  dist2d = distance2d(self.origin, other.origin);

  if(dist2d < mindist) {
    timefactor = mapfloat(0, mindist, 0, mindist, dist2d);
    waittime = lerpfloat(var_fc45584, minwait, timefactor);
  } else {
    timefactor = mapfloat(mindist, maxdist, mindist, maxdist, dist2d);
    waittime = lerpfloat(minwait, maxwait, timefactor);
  }

  return waittime;
}

function set_path_dist(ent) {
  ent.distsqrd = get_path_dist_sq(self.origin, ent.origin, self);
}

function get_path_dist_sq(from, to, var_58924346) {
  path = self findpath(from, to);

  if(isDefined(var_58924346)) {
    var_58924346.path = path;
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
    if(util::within_fov(self.origin, self.angles, other.origin, 0.766)) {
      if(isDefined(other.tagging_visible) || self tagging_shield()) {
        return 1;
      }

      if(util::can_see_ai(self, other, 250)) {
        return 1;
      }
    }
  } else {
    return self cansee(other);
  }

  return 0;
}

function tagging_shield() {
  return isDefined(self.offhandshield) && isDefined(self.offhandshield.active) && self.offhandshield.active;
}

function getcorpseorigin() {
  if(isDefined(level.stealth)) {
    if(isDefined(level.stealth.additional_corpse) && isDefined(level.stealth.additional_corpse[self getentitynumber()])) {
      return self.origin;
    }

    if(isDefined(level.stealth.fngetcorpseorigin)) {
      return [[level.stealth.fngetcorpseorigin]]();
    }
  }

  return self.origin;
}

function setbattlechatter(state) {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnsetbattlechatter)) {
    return [[level.stealth.fnsetbattlechatter]](state);
  }
}

function function_f5f4416f(eventaction, eventtype, modifier, delay, eventstruct, force) {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnaddeventplaybcs)) {
    [[level.stealth.fnaddeventplaybcs]](eventaction, eventtype, modifier, delay, eventstruct, force, 1);
  }
}

function addeventplaybcs(eventaction, eventtype, modifier, delay, eventstruct, force) {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnaddeventplaybcs)) {
    [[level.stealth.fnaddeventplaybcs]](eventaction, eventtype, modifier, delay, eventstruct, force, 0);
  }
}

function stealth_music(musichidden, musicspotted) {
  self notify(#"stealth_music");
  self endon(#"stealth_music");
  self thread stealth_music_pause_monitor();

  while(true) {
    level flag::wait_till("stealth_enabled");
    level flag::wait_till_clear("stealth_spotted");
    level flag::wait_till_clear("stealth_music_pause");

    foreach(player in getplayers()) {
      player thread stealth_music_transition(musichidden);
    }

    level flag::wait_till("stealth_spotted");
    level flag::wait_till_clear("stealth_music_pause");

    foreach(player in getplayers()) {
      player thread stealth_music_transition(musicspotted);
    }
  }
}

function stealth_music_stop() {
  self notify(#"stealth_music");
  self notify(#"stealth_music_pause_monitor");

  foreach(player in getplayers()) {
    player thread stealth_music_transition(undefined);
  }
}

function stealth_music_pause_monitor(musichidden, musicspotted) {
  self notify(#"stealth_music_pause_monitor");
  self endon(#"stealth_music_pause_monitor");

  while(true) {
    level flag::wait_till("stealth_music_pause");

    foreach(player in getplayers()) {
      player thread stealth_music_transition(undefined);
    }

    level flag::wait_till_clear("stealth_music_pause");

    if(level flag::get("stealth_spotted")) {
      foreach(player in getplayers()) {
        player thread stealth_music_transition(musicspotted);
      }

      continue;
    }

    foreach(player in getplayers()) {
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

function set_disguised(disguised) {
  if(isDefined(level.stealth.fnsetdisguised)) {
    self[[level.stealth.fnsetdisguised]](disguised);
  }
}

function set_disguised_default(disguised = 0) {
  if(disguised) {
    level.stealth.disguised = 1;
    level.stealth.threatsightratescale = 0.5;
    level.stealth.threatsightdistscale = 0.5;
    level.stealth.proximity_combat_radius_bump = 0;
    level.stealth.proximity_combat_radius_sight = 0;
    level.stealth.proximity_combat_radius_fake_sight = 0;
    setsaveddvar(#"hash_12c53cd4a01caff3", 0.25);
    setsaveddvar(#"hash_5edb3c8437c5990e", cos(90));
    setsaveddvar(#"hash_30eedc859ec98ad", 0.025);
    setsaveddvar(#"hash_5aaea648688ff01e", 0.25);
  } else {
    level.stealth.disguised = undefined;
    level.stealth.threatsightratescale = undefined;
    level.stealth.threatsightdistscale = undefined;
    level.stealth.proximity_combat_radius_bump = 50;
    level.stealth.proximity_combat_radius_sight = 100;
    level.stealth.proximity_combat_radius_fake_sight = 60;
    setsaveddvar(#"hash_12c53cd4a01caff3", 0.5);
    setsaveddvar(#"hash_5edb3c8437c5990e", cos(180));
    setsaveddvar(#"hash_30eedc859ec98ad", 0.01);
    setsaveddvar(#"hash_5aaea648688ff01e", 0.1);
  }

  var_210a8489 = getactorarray();

  foreach(ai in var_210a8489) {
    if(!isalive(ai)) {
      continue;
    }

    if(isDefined(ai.stealth) && isDefined(ai.stealth.threat_sight_state)) {
      ai stealth_threat_sight::threat_sight_set_state_parameters();
    }
  }
}

function stealth_override_goal(override) {
  assert(isDefined(self.stealth));

  if(!isDefined(override)) {
    override = 0;
  }

  if(override) {
    self.remove_from_animloop = 1;
    self flag::set("stealth_override_goal");
    self stealth_enemy::set_blind(0);
    self.last_set_goalent = undefined;
  } else {
    self flag::clear("stealth_override_goal");
  }

  if(override) {
    var_29020f90 = self spawner::function_461ce3e9();

    if(!isDefined(self.stealth.var_29020f90)) {
      self.stealth.var_29020f90 = var_29020f90;
    }

    return;
  }

  if(isDefined(self.stealth.var_29020f90)) {
    self thread spawner::go_to_node(self.stealth.var_29020f90);
    self.stealth.var_29020f90 = undefined;
  }
}

function stealth_behavior_active() {
  return self flag::exists("stealth_override_goal") && self flag::get("stealth_override_goal");
}

function stealth_behavior_wait() {
  if(self stealth_behavior_active()) {
    self flag::wait_till_clear("stealth_override_goal");
  }
}

function disable_stealth_system() {
  level flag::clear("stealth_enabled");
  ais = getactorteamarray("axis", "allies", "team3", "neutral");

  foreach(ai in ais) {
    ai enable_stealth_for_ai(0);
  }

  foreach(player in getplayers()) {
    player.maxvisibledist = 8192;

    if(player flag::exists("stealth_enabled")) {
      player flag::clear("stealth_enabled");
    }

    if(isDefined(player.stealth)) {
      var_3d8a1086 = player get_group_flagname("stealth_spotted");
      level flag::clear(var_3d8a1086);
    }
  }

  stealth_manager::event_change("spotted");
  level thread function_740dbf99();
}

function enable_stealth_system() {
  level flag::set("stealth_enabled");
  ais = getaiarray();

  foreach(ai in ais) {
    ai enable_stealth_for_ai(1);
  }

  foreach(player in getplayers()) {
    if(player flag::exists("stealth_enabled")) {
      player flag::set("stealth_enabled");
    }
  }
}

function enable_stealth_for_ai(enabled, var_6f52290c = 0) {
  if(!enabled) {
    self.maxvisibledist = 8192;

    if(self flag::exists("stealth_enabled") && self flag::get("stealth_enabled") && self.team == "axis") {
      player = getplayers()[0];
      dummyevent = spawnStruct();
      dummyevent.origin = player.origin;
      dummyevent.investigate_point = player.origin;
      dummyevent.investigate_pos = player.origin;
      dummyevent.type = "combat";
      dummyevent.typeorig = "attack";

      if(var_6f52290c) {
        dummyevent.entity = player;
      }

      self.dontevershoot = 0;
      self.dontattackme = 0;
      self stealth_enemy::bt_event_combat(dummyevent);
      stealth_group::function_b6ebd4af(self);
      self stealth_threat_sight::function_60514e0b();
    }
  }

  if(self flag::exists("stealth_enabled")) {
    if(enabled) {
      self flag::set("stealth_enabled");
      return;
    }

    self flag::clear("stealth_enabled");
  }
}

function custom_state_functions(array) {
  assert(!isDefined(self.stealth), "<dev string:x189>");

  if(isDefined(array[#"spotted"])) {
    self.stealth_state_func[#"spotted"] = array[#"spotted"];
  }

  if(isDefined(array[#"hidden"])) {
    self.stealth_state_func[#"hidden"] = array[#"hidden"];
  }
}

function set_stealth_func(type, func) {
  self.stealth.funcs[type] = func;
}

function set_event_override(eventtype, funcoverride) {
  if(isDefined(eventtype) && isDefined(self.stealth) && isDefined(self.stealth.funcs)) {
    self.stealth.funcs["event_" + eventtype] = funcoverride;
  }
}

function function_bc54026c(eventtype) {
  if(isDefined(eventtype) && isDefined(self.stealth) && isDefined(self.stealth.funcs)) {
    self.stealth.funcs["event_" + eventtype] = undefined;
  }
}

function bcisincombat() {
  self endon(#"death");

  if(!isDefined(self.fnisinstealthcombat) || self[[self.fnisinstealthcombat]]()) {
    return true;
  }

  if(!isDefined(self.stealth)) {
    return true;
  }

  return false;
}

function function_2baa2568() {
  if(level flag::get("stealth_spotted")) {
    return false;
  }

  return true;
}

function waittill_true_goal(origin, radius) {
  self endon(#"death");

  if(!isDefined(radius)) {
    radius = self.goalradius;
  }

  while(true) {
    self waittill(#"goal");

    if(distance(self.origin, origin) < radius + 10) {
      break;
    }
  }
}

function function_133b86af() {
  result = getclosestpointonnavmesh(self.origin, 500, 16);

  if(!isDefined(result)) {
    result = self.origin;
  }

  return result;
}

function assign_unique_id() {
  if(!isDefined(level.ai_number)) {
    level.ai_number = 0;
  }

  self.unique_id = "ai" + level.ai_number;
  level.ai_number++;
  return self.unique_id;
}

function set_movement_speed(desiredspeed) {
  self setdesiredspeed(desiredspeed);
}

function clear_movement_speed() {
  self function_9ae1c50();
}

function ignore_corpse() {
  waitresult = self waittill(#"actor_corpse");

  if(isDefined(waitresult.corpse)) {
    waitresult.corpse.found = 1;
  }
}

function function_bf1fb16f() {
  self.fovcosinez = 0;
}

function function_569a126(enabled, distance = 2000) {
  assert(isDefined(level.stealth));

  if(enabled) {
    level.stealth.var_6fd6463b = distance * distance;
    return;
  }

  level.stealth.var_6fd6463b = undefined;
}

function function_2324f175(enabled) {
  self.var_6eed8aea = enabled;
  self.var_210e35f8 = enabled;
  self.var_dbc362ae = enabled;
}

function function_3249d5ff() {
  self.stealth.var_f4926fd9 = 1;
  self stealth_threat_sight::threat_sight_set_state_parameters("investigate_grace_period");
  self.awarenesslevelcurrent = "high_alert";

  if(self flashlight::function_47df32b8()) {
    self thread flashlight::function_8d59ee47(1);
  }
}

function function_64608a78() {
  self.stealth.var_f4926fd9 = 0;
  self.stealth.var_3bf603d9 = gettime();
  self stealth_threat_sight::threat_sight_set_state_parameters("investigate");
  self.awarenesslevelcurrent = "low_alert";

  if(self flashlight::function_3aec1b7()) {
    self thread flashlight::function_8d59ee47(0);
  }
}

function function_196ad164() {
  return is_true(self.stealth.var_f4926fd9);
}

function function_b60a878a() {
  return level.var_6eed8aea !== 0 && self.var_6eed8aea !== 0;
}

function function_d58e1c1c() {
  return level.var_210e35f8 !== 0 && self.var_210e35f8 !== 0;
}

function function_a54113fb() {
  return level.var_dbc362ae !== 0 && self.var_dbc362ae !== 0;
}

function function_57972217(var_45007919, var_ac53cd2c) {
  self.var_e6b70cdb = cos(var_45007919);
  self.fovcosineperiph = cos(var_ac53cd2c);
}

function function_6a3b08d0() {
  var_39dc2c21 = 1 / 999;
  self function_678d90a1(var_39dc2c21);
}