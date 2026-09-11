/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\utility.gsc
***********************************************/

function get_group(var_0) {
  if(!isDefined(level.stealth.groupdata.groups[var_0])) {
    return undefined;
  }

  return level.stealth.groupdata.groups[var_0].members;
}

function group_flag_clear(var_0, var_1) {
  var_2 = get_group_flagname(var_0, var_1);
  scripts\engine\utility::flag_clear(var_2);
  var_3 = level.stealth.group.flags[var_0];
  var_4 = 1;

  foreach(var_6 in var_3) {
    if(!issubstr(var_6, "allies") && scripts\engine\utility::flag(var_6)) {
      return;
    }
  }

  if(scripts\engine\utility::flag(var_2) && self != level) {
    self notify(var_0);
  }

  scripts\engine\utility::flag_clear(var_0);
}

function group_flag_set(var_0) {
  var_1 = get_group_flagname(var_0);

  if(!scripts\engine\utility::flag(var_1) && self != level) {
    self notify(var_0);
  }

  scripts\engine\utility::flag_set(var_1);
  scripts\engine\utility::flag_set(var_0);
}

function group_flag(var_0) {
  var_1 = get_group_flagname(var_0);
  return scripts\engine\utility::flag(var_1);
}

function get_group_flagname(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = self.script_stealthgroup;
  }

  var_2 = var_0 + "-Group:" + var_1;
  return var_2;
}

function group_flag_wait(var_0) {
  var_1 = get_group_flagname(var_0);
  scripts\engine\utility::flag_wait(var_1);
}

function group_flag_waitopen(var_0) {
  var_1 = get_group_flagname(var_0);
  scripts\engine\utility::flag_waitopen(var_1);
}

function group_flag_wait_or_timeout(var_0, var_1) {
  var_2 = get_group_flagname(var_0);
  scripts\engine\utility::flag_wait_or_timeout(var_2, var_1);
}

function group_flag_waitopen_or_timeout(var_0, var_1) {
  var_2 = get_group_flagname(var_0);
  scripts\engine\utility::flag_waitopen_or_timeout(var_2, var_1);
}

function group_flag_init(var_0) {
  if(isDefined(self.script_stealthgroup)) {
    self.script_stealthgroup = scripts\engine\utility::string(self.script_stealthgroup);
  } else {
    self.script_stealthgroup = "default";
  }

  if(self.team == "allies") {
    self.script_stealthgroup += "allies";
  }

  if(!scripts\engine\utility::flag_exist(var_0)) {
    scripts\engine\utility::flag_init(var_0);
  }

  var_1 = get_group_flagname(var_0);

  if(!scripts\engine\utility::flag_exist(var_1)) {
    scripts\engine\utility::flag_init(var_1);

    if(!isDefined(level.stealth.group.flags[var_0])) {
      level.stealth.group.flags[var_0] = [];
    }

    level.stealth.group.flags[var_0][level.stealth.group.flags[var_0].size] = var_1;
    return;
  }
}

function group_setcombatgoalRadius(var_0, var_1) {
  if(!isDefined(level.stealth.combat_goalradius)) {
    level.stealth.combat_goalradius = [];
  }

  level.stealth.combat_goalradius[var_0] = var_1;
}

function group_add() {
  if(!isDefined(level.stealth.group.groups[self.script_stealthgroup])) {
    level.stealth.group.groups[self.script_stealthgroup] = [];
    level.stealth.group notify(self.script_stealthgroup);
  }

  level.stealth.group.groups[self.script_stealthgroup][level.stealth.group.groups[self.script_stealthgroup].size] = self;
}

function group_spotted_flag() {
  var_0 = get_group_flagname("stealth_spotted");
  return scripts\engine\utility::flag(var_0);
}

function any_groups_in_combat(var_0) {
  if(!scripts\engine\utility::flag("stealth_enabled")) {
    return false;
  }

  foreach(var_2 in level.stealth.groupdata.groups) {
    if(isDefined(var_0) && !scripts\engine\utility::array_contains(var_0, var_2.name)) {
      continue;
    }

    if(scripts\stealth\group::group_anyoneincombat(var_2.name)) {
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

function set_stealth_state(var_0) {
  switch (var_0) {
    case "attack":
      var_1 = 3;
      break;
    case "warning2":
      var_1 = 2;
      break;
    case "warning1":
      var_1 = 1;
      break;
    default:
      var_1 = 0;
      break;
  }

  self.stealth.state = var_1;
}

function check_stealth() {}

function alertlevel_init_map() {
  level.stealth.alert_levels_exe = [];
  level.stealth.alert_levels_exe["normal"] = "noncombat";
  level.stealth.alert_levels_exe["reset"] = "noncombat";
  level.stealth.alert_levels_exe["warning1"] = "alert";
  level.stealth.alert_levels_exe["warning2"] = "alert";
  level.stealth.alert_levels_exe["combat_hunt"] = "alert";
  level.stealth.alert_levels_exe["attack"] = "combat";
  level.stealth.alert_levels_int = [];
  level.stealth.alert_levels_int["normal"] = 0;
  level.stealth.alert_levels_int["reset"] = 0;
  level.stealth.alert_levels_int["warning1"] = 1;
  level.stealth.alert_levels_int["warning2"] = 2;
  level.stealth.alert_levels_int["combat_hunt"] = 2;
  level.stealth.alert_levels_int["attack"] = 3;
  level.stealth.alert_levels_exe["combat"] = 3;
}

function alertlevel_script_to_exe(var_0) {
  if(isDefined(level.stealth.alert_levels_exe[var_0])) {
    return level.stealth.alert_levels_exe[var_0];
  }

  return var_0;
}

function set_detect_ranges(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {}

  scripts\stealth\manager::set_detect_ranges_internal(var_0, var_1);
}

function set_min_detect_range_darkness(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {}

  if(isDefined(var_0)) {
    level.stealth.detect.minrangedarkness["hidden"]["prone"] = var_0["prone"];
    level.stealth.detect.minrangedarkness["hidden"]["crouch"] = var_0["crouch"];
    level.stealth.detect.minrangedarkness["hidden"]["stand"] = var_0["stand"];
  }

  if(isDefined(var_1)) {
    level.stealth.detect.minrangedarkness["spotted"]["prone"] = var_1["prone"];
    level.stealth.detect.minrangedarkness["spotted"]["crouch"] = var_1["crouch"];
    level.stealth.detect.minrangedarkness["spotted"]["stand"] = var_1["stand"];
    return;
  }
}

function do_stealth() {
  if(!isDefined(level.player.stealth)) {
    scripts\stealth\init::set_stealth_mode(1);
  }

  switch (self.team) {
    case "team3":
    case "axis":
      thread scripts\stealth\enemy::main();
      break;
    case "allies":
      thread scripts\stealth\friendly::main();
      break;
    case "neutral":
      thread scripts\stealth\neutral::main();
      break;
  }
}

function save_last_goal() {
  if(isDefined(self.stealth.last_goal)) {
    return;
  }

  self.saved_script_forcegoal = self.script_forcegoal;

  if(isDefined(self.last_set_goalnode)) {
    self.stealth.last_goal = self.last_set_goalnode;
    return;
  }

  if(isDefined(self.last_set_goalent)) {
    self.stealth.last_goal = self.last_set_goalent.origin;
    return;
  }

  if(isDefined(self.last_set_goalpos)) {
    self.stealth.last_goal = self.last_set_goalpos;
    return;
  }

  self.stealth.last_goal = self.origin;
}

function set_patrol_move_loop_anim(var_0) {}

function set_default_patrol_style(var_0) {
  self.stealth.default_patrol_style = var_0;

  if(isDefined(self.stealth.default_patrol_style)) {
    set_patrol_style(self.stealth.default_patrol_style);
    return;
  }
}

function get_patrol_react_magnitude_int(var_0) {
  switch (var_0) {
    case "small":
      return 0;
    case "smed":
      return 1;
    case "med":
      return 2;
    case "large":
      return 3;
  }
}

function set_patrol_style(var_0, var_1, var_2, var_3) {
  if(var_0 == "unaware") {
    var_0 = "patrol";
  }

  scripts\common\utility::demeanor_override(var_0);

  if(var_0 == "cqb") {
    var_4 = 60;

    if(isDefined(self.stealth.hunt_speed)) {
      var_4 = self.stealth.hunt_speed;
    }

    scripts\engine\utility::set_movement_speed(var_4);
  }

  if(istrue(var_1)) {
    set_patrol_react(var_2, var_3);
    return;
  }
}

function get_patrol_style() {
  return scripts\asm\asm::asm_getdemeanor();
}

function get_patrol_style_default() {
  var_0 = self.stealth.default_patrol_style;

  if(!isDefined(var_0)) {
    var_0 = level.stealth.default_patrol_style;
  }

  return var_0;
}

function set_patrol_react(var_0, var_1) {
  if(isDefined(self.stealth.breacting)) {
    if(get_patrol_react_magnitude_int(self.stealth.breacting) >= get_patrol_react_magnitude_int(var_1)) {
      return;
    }
  }

  self.stealth.patrol_react_magnitude = var_1;
  self.stealth.patrol_react_pos = var_0;
  self.stealth.patrol_react_time = gettime();
}

function goto_last_goal() {
  self notify("going_back");
  self endon("death");

  if(isDefined(self.stealth.goback_func)) {
    self[[self.stealth.goback_func]]();
  }

  var_0 = self.stealth.last_goal;

  if(isDefined(self.saved_script_forcegoal)) {
    self.script_forcegoal = self.saved_script_forcegoal;
    self.saved_script_forcegoal = undefined;
  }

  if(isnode(var_0)) {
    self.stealth.last_goal = undefined;
    stealth_override_goal(0);
    return;
  }

  if(isDefined(var_0)) {
    self setgoalpos(var_0);
    self.goalradius = 40;
  }

  if(isDefined(var_0)) {
    thread goto_last_goal_and_clear(var_0);
  }

  wait 0.05;
  stealth_override_goal(0);
}

function goto_last_goal_and_clear(var_0) {
  self endon("death");
  waittill_true_goal(var_0);
  self.stealth.last_spot = undefined;
}

function alert_delay_distance_time(var_0) {
  var_1 = 2;

  if(isDefined(self.stealth.maxalertdelay)) {
    var_1 = self.stealth.maxalertdelay;
  }

  if(self[[self.fnisinstealthinvestigate]]()) {
    var_1 = min(1.5, var_1);
  } else if(self[[self.fnisinstealthhunt]]()) {
    var_1 = min(1, var_1);
  }

  var_2 = 0.1;
  var_3 = 0.4;
  var_4 = 64;
  var_5 = 1024;
  var_6 = distance2d(self.origin, var_0.origin);

  if(var_6 < var_4) {
    var_7 = scripts\engine\math::normalize_value(0, var_4, var_6);
    var_8 = scripts\engine\math::factor_value(var_2, var_3, var_7);
  } else {
    var_7 = scripts\engine\math::normalize_value(var_6, var_7, var_8);
    var_8 = scripts\engine\math::factor_value(var_5, var_3, var_7);
  }

  return var_8;
}

function set_path_dist(var_0) {
  var_0.distsqrd = get_path_dist_sq(self.origin, var_0.origin, self);
}

function get_path_dist_sq(var_0, var_1, var_2) {
  var_3 = self findpath(var_0, var_1);

  if(isDefined(var_2)) {
    var_2.path = var_3;
  }

  var_4 = 0;

  for(var_5 = 1; var_5 < var_3.size; var_5++) {
    var_4 += distancesquared(var_3[var_5 - 1], var_3[var_5]);
  }

  return var_4;
}

function remove_path_dist() {
  self.path = undefined;
  self.distsqrd = undefined;
}

function is_visible(var_0) {
  if(isPlayer(self)) {
    if(scripts\engine\utility::within_fov(self.origin, self.angles, var_0.origin, 0.766)) {
      if(isDefined(var_0.tagging_visible) || tagging_shield()) {
        return 1;
      }

      if(scripts\anim\utility_common::player_can_see_ai(self, var_0, 250)) {
        return 1;
      }
    }
  } else {
    return self cansee(var_0);
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

function setbattlechatter(var_0) {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnsetbattlechatter)) {
    return [[level.stealth.fnsetbattlechatter]](var_0);
  }
}

function addeventplaybcs(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnaddeventplaybcs)) {
    return [[level.stealth.fnaddeventplaybcs]](var_0, var_1, var_2, var_3, var_4, var_5);
  }
}

function animgenericcustomanimmode(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnanimgenericcustomanimmode)) {
    return [[level.stealth.fnanimgenericcustomanimmode]](var_0, var_1, var_2, var_3, var_4, var_5);
  }
}

function stealth_music(var_0, var_1) {
  self notify("stealth_music");
  self endon("stealth_music");
  thread stealth_music_pause_monitor();

  for(;;) {
    scripts\engine\utility::flag_wait("stealth_enabled");
    scripts\engine\utility::flag_waitopen("stealth_spotted");
    scripts\engine\utility::flag_waitopen("stealth_music_pause");

    foreach(var_3 in level.players) {
      thread stealth_music_transition(var_3);
    }

    scripts\engine\utility::flag_wait("stealth_spotted");
    scripts\engine\utility::flag_waitopen("stealth_music_pause");

    foreach(var_3 in level.players) {
      thread stealth_music_transition(var_3);
    }
  }
}

function stealth_music_stop() {
  self notify("stealth_music");
  self notify("stealth_music_pause_monitor");

  foreach(var_1 in level.players) {
    thread stealth_music_transition(var_1);
  }
}

function stealth_music_pause_monitor(var_0, var_1) {
  self notify("stealth_music_pause_monitor");
  self endon("stealth_music_pause_monitor");

  for(;;) {
    scripts\engine\utility::flag_wait("stealth_music_pause");

    foreach(var_3 in level.players) {
      thread stealth_music_transition(var_3);
    }

    scripts\engine\utility::flag_waitopen("stealth_music_pause");

    if(scripts\engine\utility::flag("stealth_spotted")) {
      foreach(var_3 in level.players) {
        thread stealth_music_transition(var_3);
      }

      continue;
    }

    foreach(var_3 in level.players) {
      thread stealth_music_transition(var_3);
    }
  }
}

function stealth_music_transition(var_0) {
  if(isDefined(self.fnstealthmusictransition)) {
    return [[self.fnstealthmusictransition]](var_0);
  }
}

function update_light_meter() {
  if(isDefined(self.fnupdatelightmeter)) {
    return [[self.fnupdatelightmeter]]();
  }
}

function set_disguised(var_0) {
  if(isDefined(level.stealth.fnsetdisguised)) {
    self[[level.stealth.fnsetdisguised]](var_0);
    return;
  }
}

function set_disguised_default(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(var_0) {
    level.stealth.disguised = 1;
    level.stealth.threatsightratescale = 0.4;
    level.stealth.threatsightdistscale = 0.4;
    level.stealth.proximity_combat_radius_bump = 0;
    level.stealth.proximity_combat_radius_sight = 0;
    level.stealth.proximity_combat_radius_fake_sight = 0;
    setsaveddvar("LOTQPOLOOP", 0.25);
    setsaveddvar("NTMTQTQOLK", cos(90));
    setsaveddvar("RSKOMONOR", 0.025);
    setsaveddvar("NLLTMQRSKS", 0.25);
  } else {
    level.stealth.disguised = undefined;
    level.stealth.threatsightratescale = undefined;
    level.stealth.threatsightdistscale = undefined;
    level.stealth.proximity_combat_radius_bump = 100;
    level.stealth.proximity_combat_radius_sight = 150;
    level.stealth.proximity_combat_radius_fake_sight = 60;
    setsaveddvar("LOTQPOLOOP", 0.5);
    setsaveddvar("NTMTQTQOLK", cos(180));
    setsaveddvar("RSKOMONOR", 0.01);
    setsaveddvar("NLLTMQRSKS", 0.1);
  }

  var_1 = getaiarray();

  foreach(var_3 in var_1) {
    if(!isalive(var_3)) {
      continue;
    }

    if(isDefined(var_3.stealth) && isDefined(var_3.stealth.threat_sight_state)) {
      var_3 scripts\stealth\threat_sight::threat_sight_set_state_parameters();
    }
  }
}

function stealth_override_goal(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(var_0) {
    self.remove_from_animloop = 1;
    scripts\engine\utility::ent_flag_set("stealth_override_goal");
    scripts\stealth\enemy::set_blind(0);
    self.last_set_goalent = undefined;
    return;
  }

  scripts\engine\utility::ent_flag_clear("stealth_override_goal");
}

function stealth_behavior_active() {
  return scripts\engine\utility::ent_flag_exist("stealth_override_goal") && scripts\engine\utility::ent_flag("stealth_override_goal");
}

function stealth_behavior_wait() {
  if(stealth_behavior_active()) {
    scripts\engine\utility::ent_flag_waitopen("stealth_override_goal");
    return;
  }
}

function disable_stealth_system() {
  scripts\engine\utility::flag_clear("stealth_enabled");
  var_0 = getaiunittypearray("all", "all");

  foreach(var_2 in var_0) {
    enable_stealth_for_ai(var_2, 0);
  }

  foreach(var_5 in level.players) {
    var_5.maxvisibledist = 8192;

    if(var_5 scripts\engine\utility::ent_flag_exist("stealth_enabled")) {
      var_5 scripts\engine\utility::ent_flag_clear("stealth_enabled");
    }
  }

  scripts\stealth\manager::event_change("spotted");
}

function enable_stealth_system() {
  scripts\engine\utility::flag_set("stealth_enabled");
  var_0 = getaiunittypearray("all", "all");

  foreach(var_2 in var_0) {
    enable_stealth_for_ai(var_2, 1);
  }

  foreach(var_5 in level.players) {
    if(var_5 scripts\engine\utility::ent_flag_exist("stealth_enabled")) {
      var_5 scripts\engine\utility::ent_flag_set("stealth_enabled");
    }
  }
}

function enable_stealth_for_ai(var_0) {
  if(!var_0) {
    self.maxvisibledist = 8192;

    if(scripts\engine\utility::ent_flag_exist("stealth_enabled") && scripts\engine\utility::ent_flag("stealth_enabled") && self.team == "axis") {
      var_1 = spawnStruct();
      var_1.origin = level.player.origin;
      var_1.investigate_point = level.player.origin;
      var_1.investigate_pos = level.player.origin;
      var_1.type = "combat";
      var_1.typeorig = "attack";
      self.dontevershoot = 0;
      self.dontattackme = 0;
      scripts\stealth\enemy::bt_event_combat(var_1);
    }
  }

  if(scripts\engine\utility::ent_flag_exist("stealth_enabled")) {
    if(var_0) {
      scripts\engine\utility::ent_flag_set("stealth_enabled");
      return;
    }

    scripts\engine\utility::ent_flag_clear("stealth_enabled");
    return;
  }
}

function custom_state_functions(var_0) {
  if(isDefined(var_0["spotted"])) {
    self.stealth_state_func["spotted"] = var_0["spotted"];
  }

  if(isDefined(var_0["hidden"])) {
    self.stealth_state_func["hidden"] = var_0["hidden"];
    return;
  }
}

function set_stealth_func(var_0, var_1) {
  self.stealth.funcs[var_0] = var_1;
}

function set_event_override(var_0, var_1) {
  if(isDefined(var_0) && isDefined(self.stealth) && isDefined(self.stealth.funcs)) {
    self.stealth.funcs["event_" + var_0] = var_1;
    return;
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

function waittill_true_goal(var_0, var_1) {
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = self.goalradius;
  }

  for(;;) {
    self waittill("goal");

    if(distance(self.origin, var_0) < var_1 + 10) {
      break;
    }
  }
}

function quickdropnewitem() {
  if(isDefined(level.stealth.playerclearspectatekillchainsystem)) {
    return [[level.stealth.playerclearspectatekillchainsystem]](self);
  }
}