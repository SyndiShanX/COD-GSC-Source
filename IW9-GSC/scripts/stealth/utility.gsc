/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\utility.gsc
***********************************************/

get_group(name) {
  if(!isDefined(level.stealth.groupdata.groups[name]))
    return undefined;

  return level.stealth.groupdata.groups[name].members;
}

group_flag_clear(f, group) {
  name = get_group_flagname(f, group);
  scripts\engine\utility::flag_clear(name);
  array = level.stealth.group.flags[f];
  _id_75EDE4D5E4FB6BA6 = 1;

  foreach(key, value in array) {
    if(!issubstr(value, "allies") && scripts\engine\utility::flag(value))
      return;
  }

  if(scripts\engine\utility::flag(name) && self != level)
    self notify(f);

  scripts\engine\utility::flag_clear(f);
}

group_flag_set(f) {
  name = get_group_flagname(f);

  if(!scripts\engine\utility::flag(name) && self != level)
    self notify(f);

  scripts\engine\utility::flag_set(name);
  scripts\engine\utility::flag_set(f);
}

group_flag(f) {
  name = get_group_flagname(f);
  return scripts\engine\utility::flag(name);
}

get_group_flagname(f, group) {
  if(!isDefined(group))
    group = self.script_stealthgroup;

  name = f + "-Group:" + group;
  return name;
}

group_flag_wait(f) {
  name = get_group_flagname(f);
  scripts\engine\utility::flag_wait(name);
}

group_flag_waitopen(f) {
  name = get_group_flagname(f);
  scripts\engine\utility::flag_waitopen(name);
}

group_flag_wait_or_timeout(f, timer) {
  name = get_group_flagname(f);
  scripts\engine\utility::flag_wait_or_timeout(name, timer);
}

group_flag_waitopen_or_timeout(f, timer) {
  name = get_group_flagname(f);
  scripts\engine\utility::flag_waitopen_or_timeout(name, timer);
}

group_flag_init(f) {
  if(isDefined(self.script_stealthgroup))
    self.script_stealthgroup = scripts\engine\utility::string(self.script_stealthgroup);
  else
    self.script_stealthgroup = "default";

  if(!scripts\common\utility::ismp() && self.team == "allies")
    self.script_stealthgroup = self.script_stealthgroup + "allies";

  if(!scripts\engine\utility::flag_exist(f))
    scripts\engine\utility::flag_init(f);

  name = get_group_flagname(f);

  if(!scripts\engine\utility::flag_exist(name)) {
    scripts\engine\utility::flag_init(name);

    if(!isDefined(level.stealth.group.flags[f]))
      level.stealth.group.flags[f] = [];

    level.stealth.group.flags[f][level.stealth.group.flags[f].size] = name;
  }
}

group_setcombatgoalRadius(group, goalradius) {
  if(!isDefined(level.stealth.combat_goalradius))
    level.stealth.combat_goalradius = [];

  level.stealth.combat_goalradius[group] = goalradius;
}

group_add() {
  if(!isDefined(level.stealth.group.groups[self.script_stealthgroup])) {
    level.stealth.group.groups[self.script_stealthgroup] = [];
    level.stealth.group notify(self.script_stealthgroup);
  }

  level.stealth.group.groups[self.script_stealthgroup][level.stealth.group.groups[self.script_stealthgroup].size] = self;
}

group_spotted_flag() {
  if(!scripts\common\utility::ismp()) {}

  name = get_group_flagname("stealth_spotted");
  return scripts\engine\utility::flag(name);
}

any_groups_in_combat() {
  if(!scripts\engine\utility::flag("stealth_enabled"))
    return 0;

  return _func_1BB1470F934A81EB();
}

check_stealth() {}

set_detect_ranges(hidden, spotted, _id_8F3F480583606401) {
  if(!isDefined(hidden) && !isDefined(spotted)) {}

  scripts\stealth\manager::set_detect_ranges_internal(hidden, spotted, _id_8F3F480583606401);
}

set_min_detect_range_darkness(hidden, spotted) {
  if(!isDefined(hidden) && !isDefined(spotted)) {}

  if(isDefined(hidden)) {
    _func_F53F47C5E7E21548("hidden", "prone", hidden["prone"]);
    _func_F53F47C5E7E21548("hidden", "crouch", hidden["crouch"]);
    _func_F53F47C5E7E21548("hidden", "stand", hidden["stand"]);
  }

  if(isDefined(spotted)) {
    _func_F53F47C5E7E21548("spotted", "prone", spotted["prone"]);
    _func_F53F47C5E7E21548("spotted", "crouch", spotted["crouch"]);
    _func_F53F47C5E7E21548("spotted", "stand", spotted["stand"]);
  }
}

_id_0F3883FE06A11269(hidden, spotted) {
  if(!isDefined(hidden) && !isDefined(spotted)) {}

  if(isDefined(hidden)) {
    _func_9C8F4AD66661C757("hidden", "prone", hidden["prone"]);
    _func_9C8F4AD66661C757("hidden", "crouch", hidden["crouch"]);
    _func_9C8F4AD66661C757("hidden", "stand", hidden["stand"]);
  }

  if(isDefined(spotted)) {
    _func_9C8F4AD66661C757("spotted", "prone", spotted["prone"]);
    _func_9C8F4AD66661C757("spotted", "crouch", spotted["crouch"]);
    _func_9C8F4AD66661C757("spotted", "stand", spotted["stand"]);
  }
}

do_stealth() {
  if(!isDefined(level.player.stealth))
    scripts\stealth\init::set_stealth_mode(1);

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

save_last_goal() {
  if(isDefined(self.stealth.last_goal)) {
    return;
  }
  self.saved_script_forcegoal = self.script_forcegoal;

  if(isDefined(self.last_set_goalnode))
    self.stealth.last_goal = self.last_set_goalnode;
  else if(isDefined(self.last_set_goalent))
    self.stealth.last_goal = self.last_set_goalent.origin;
  else if(isDefined(self.last_set_goalpos))
    self.stealth.last_goal = self.last_set_goalpos;
  else
    self.stealth.last_goal = self.origin;
}

set_patrol_move_loop_anim(_id_8D24396A7E16B0D4) {}

set_patrol_style(style, _id_31D3553FDE54BA29, _id_CD4CA207CEC1B1D3, _id_6BD296FF8DB5AB91) {
  switch (style) {
    case "alert":
      self._id_E31EE88092E41CC8 = 1;
      break;
  }

  self _meth_D00232775A05290E(style, _id_31D3553FDE54BA29, _id_CD4CA207CEC1B1D3, _id_6BD296FF8DB5AB91);
}

get_patrol_style() {
  return scripts\asm\asm::asm_getdemeanor();
}

set_patrol_react(position, _id_6BD296FF8DB5AB91) {
  self _meth_68F50ADA6E19D8F4(position, _id_6BD296FF8DB5AB91);
}

goto_last_goal() {
  self notify("going_back");
  self endon("death");

  if(isDefined(self.stealth.goback_func))
    self[[self.stealth.goback_func]]();

  goal = self.stealth.last_goal;

  if(isDefined(self.saved_script_forcegoal)) {
    self.script_forcegoal = self.saved_script_forcegoal;
    self.saved_script_forcegoal = undefined;
  }

  if(isnode(goal)) {
    self.stealth.last_goal = undefined;
    return;
  }

  if(isDefined(goal)) {
    self setgoalpos(goal);
    self.goalradius = 40;
  }

  if(isDefined(goal))
    thread goto_last_goal_and_clear(goal);

  wait 0.05;
}

goto_last_goal_and_clear(origin) {
  self endon("death");
  waittill_true_goal(origin);
  self.stealth.last_spot = undefined;
}

set_path_dist(ent) {
  ent.distsqrd = get_path_dist_sq(self.origin, ent.origin, self);
}

get_path_dist_sq(from, to, _id_320B468DC1D97042) {
  path = self findpath(from, to);

  if(isDefined(_id_320B468DC1D97042))
    _id_320B468DC1D97042.path = path;

  distsq = 0;

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < path.size; _id_AC0E594AC96AA3A8++)
    distsq = distsq + distancesquared(path[_id_AC0E594AC96AA3A8 - 1], path[_id_AC0E594AC96AA3A8]);

  return distsq;
}

remove_path_dist() {
  self.path = undefined;
  self.distsqrd = undefined;
}

is_visible(other) {
  if(isPlayer(self)) {
    if(scripts\engine\utility::within_fov(self.origin, self.angles, other.origin, 0.766)) {
      if(isDefined(other.tagging_visible) || tagging_shield())
        return 1;

      if(_id_2B79931B08683E0A::player_can_see_ai(self, other, 250))
        return 1;
    }
  } else if(isDefined(other.team) && self.team == other.team)
    return self cansee(other, 300);
  else
    return self cansee(other);

  return 0;
}

tagging_shield() {
  return isDefined(self.offhandshield) && isDefined(self.offhandshield.active) && self.offhandshield.active;
}

setbattlechatter(state) {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnsetbattlechatter))
    return [[level.stealth.fnsetbattlechatter]](state);
}

addeventplaybcs(eventaction, eventtype, modifier, delay, _id_5125C340EACE0872, _id_F8048727716242B0) {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnaddeventplaybcs))
    return [[level.stealth.fnaddeventplaybcs]](eventaction, eventtype, modifier, delay, _id_5125C340EACE0872, _id_F8048727716242B0);
}

animgenericcustomanimmode(guy, _id_9481A070A25EB0BD, anime, tag, _id_49500266747F0F18, _id_212B748F7DF888B0) {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnanimgenericcustomanimmode))
    return [[level.stealth.fnanimgenericcustomanimmode]](guy, _id_9481A070A25EB0BD, anime, tag, _id_49500266747F0F18, _id_212B748F7DF888B0);
}

stealth_music(_id_BD2621A5F467FE6C, _id_A1F4D479A8C138CD) {
  self notify("stealth_music");
  self endon("stealth_music");
  thread stealth_music_pause_monitor();

  for(;;) {
    scripts\engine\utility::flag_wait("stealth_enabled");
    scripts\engine\utility::flag_waitopen("stealth_spotted");
    scripts\engine\utility::flag_waitopen("stealth_music_pause");
    _id_F81D9864F1FC95A6();

    foreach(player in level.players)
    player thread stealth_music_transition(_id_BD2621A5F467FE6C);

    scripts\engine\utility::flag_wait("stealth_spotted");
    scripts\engine\utility::flag_waitopen("stealth_music_pause");
    _id_4EFC63ABFF5F42D3();

    foreach(player in level.players)
    player thread stealth_music_transition(_id_A1F4D479A8C138CD);
  }
}

_id_4EFC63ABFF5F42D3() {
  if(isDefined(level._id_667495CCE3974C46))
    wait(level._id_667495CCE3974C46);

  if(getdvarint("dvar_5CF56CA298C06C21", 0) != 0)
    wait(getdvarint("dvar_5CF56CA298C06C21", 0));
}

_id_F81D9864F1FC95A6() {
  if(isDefined(level._id_E588EE33138024C3))
    wait(level._id_E588EE33138024C3);

  if(getdvarint("dvar_9A92F5B582657D72", 0) != 0)
    wait(getdvarint("dvar_9A92F5B582657D72", 0));
}

stealth_music_stop() {
  self notify("stealth_music");
  self notify("stealth_music_pause_monitor");

  foreach(player in level.players)
  player thread stealth_music_transition(undefined);
}

stealth_music_pause_monitor(_id_BD2621A5F467FE6C, _id_A1F4D479A8C138CD) {
  self notify("stealth_music_pause_monitor");
  self endon("stealth_music_pause_monitor");

  for(;;) {
    scripts\engine\utility::flag_wait("stealth_music_pause");

    foreach(player in level.players)
    player thread stealth_music_transition(undefined);

    scripts\engine\utility::flag_waitopen("stealth_music_pause");

    if(scripts\engine\utility::flag("stealth_spotted")) {
      foreach(player in level.players)
      player thread stealth_music_transition(_id_A1F4D479A8C138CD);

      continue;
    }

    foreach(player in level.players)
    player thread stealth_music_transition(_id_BD2621A5F467FE6C);
  }
}

stealth_music_transition(_id_A675F64A80383D1E) {
  if(isDefined(self.fnstealthmusictransition))
    return [[self.fnstealthmusictransition]](_id_A675F64A80383D1E);
}

update_light_meter() {
  if(isDefined(self.fnupdatelightmeter))
    return [[self.fnupdatelightmeter]]();
}

disable_stealth_system() {
  scripts\engine\utility::flag_clear("stealth_enabled");
  _id_8BAB3203A26744B8 = getaiunittypearray("all", "all");

  foreach(ai in _id_8BAB3203A26744B8)
  ai enable_stealth_for_ai(0);

  foreach(player in level.players) {
    player.maxvisibledist = 8192;

    if(player scripts\engine\utility::ent_flag_exist("stealth_enabled"))
      player scripts\stealth\player::_id_03718FC282393305("stealth_enabled");
  }

  scripts\stealth\manager::event_change("spotted");
}

enable_stealth_system() {
  scripts\engine\utility::flag_set("stealth_enabled");
  _id_8BAB3203A26744B8 = getaiunittypearray("all", "all");

  foreach(ai in _id_8BAB3203A26744B8)
  ai enable_stealth_for_ai(1);

  foreach(player in level.players) {
    if(player scripts\engine\utility::ent_flag_exist("stealth_enabled"))
      player scripts\stealth\player::_id_E403865F115834A8("stealth_enabled");
  }
}

enable_stealth_for_ai(enabled) {
  if(!enabled) {
    self.maxvisibledist = 8192;

    if(scripts\engine\utility::ent_flag_exist("stealth_enabled") && scripts\engine\utility::ent_flag("stealth_enabled") && self.team == "axis") {
      _id_5EF1B5D63A8D28BD = spawnStruct();
      _id_5EF1B5D63A8D28BD.origin = level.player.origin;
      _id_5EF1B5D63A8D28BD.investigate_point = level.player.origin;
      _id_5EF1B5D63A8D28BD.investigate_pos = level.player.origin;
      _id_5EF1B5D63A8D28BD.type = "combat";
      _id_5EF1B5D63A8D28BD.typeorig = "attack";
      self.dontevershoot = 0;
      self.dontattackme = 0;
      scripts\stealth\enemy::bt_event_combat(_id_5EF1B5D63A8D28BD);
    }
  }

  if(scripts\engine\utility::ent_flag_exist("stealth_enabled")) {
    if(enabled)
      scripts\engine\utility::ent_flag_set("stealth_enabled");
    else
      scripts\engine\utility::ent_flag_clear("stealth_enabled");
  }
}

custom_state_functions(array) {
  if(isDefined(array["spotted"]))
    self.stealth_state_func["spotted"] = array["spotted"];

  if(isDefined(array["hidden"]))
    self.stealth_state_func["hidden"] = array["hidden"];
}

set_stealth_func(type, func) {
  self.stealth.funcs[type] = func;

  if(isai(self))
    self _meth_A29879BF1276A08A(type, func);
}

set_event_override(eventtype, _id_483F43F9665EF7B3) {
  if(isDefined(eventtype) && isDefined(self.stealth) && isDefined(self.stealth.funcs))
    self.stealth.funcs["event_" + eventtype] = _id_483F43F9665EF7B3;
}

bcisincombat() {
  self endon("death");

  if(isDefined(self.fnisinstealthcombat) && self[[self.fnisinstealthcombat]]())
    return 1;

  if(!isDefined(self.stealth))
    return 1;

  return 0;
}

_autosave_stealthcheck() {
  return 1;
}

waittill_true_goal(origin, radius) {
  self endon("death");

  if(!isDefined(radius))
    radius = self.goalradius;

  for(;;) {
    self waittill("goal");

    if(distance(self.origin, origin) < radius + 10) {
      break;
    }
  }
}

get_player_drone() {
  if(isDefined(level.stealth.fngetplayerdrone))
    return [[level.stealth.fngetplayerdrone]](self);
}

_id_3EE5D99169F2293F() {
  if(!isDefined(self.stealth))
    return 0;

  return self[[self.fnisinstealthidle]]();
}

_id_C9F8C83EB3DE1B32() {
  if(!isDefined(self.stealth))
    return 0;

  return self[[self.fnisinstealthinvestigate]]();
}

_id_0CDCA96A984FDB85() {
  if(!isDefined(self.stealth))
    return 0;

  return self[[self.fnisinstealthhunt]]();
}

_id_6A86DD83C01F8FAA() {
  if(!isDefined(self.stealth))
    return 1;

  return self[[self.fnisinstealthcombat]]();
}

_id_C14048638B343B7F(state, event) {
  if(!isDefined(self.stealth)) {
    return;
  }
  self[[self.fnsetstealthstate]](state, event);
}

_id_6516755416A6584B(_id_8E88D47EC56EEA22, _id_F945CC6444AD364E) {
  _id_A1D4CA153FFBB0CF = 0;

  if(!isDefined(_id_F945CC6444AD364E)) {
    _id_F945CC6444AD364E = ["all"];
    _id_A1D4CA153FFBB0CF = 1;
  }

  if(!isarray(_id_F945CC6444AD364E))
    _id_F945CC6444AD364E = [_id_F945CC6444AD364E];

  if(!_id_A1D4CA153FFBB0CF)
    _id_A1D4CA153FFBB0CF = scripts\engine\utility::array_contains(_id_F945CC6444AD364E, "all");

  if(_id_A1D4CA153FFBB0CF || scripts\engine\utility::array_contains(_id_F945CC6444AD364E, "investigate"))
    set_stealth_func("event_investigate", _id_8E88D47EC56EEA22);

  if(_id_A1D4CA153FFBB0CF || scripts\engine\utility::array_contains(_id_F945CC6444AD364E, "cover_blown"))
    set_stealth_func("event_cover_blown", _id_8E88D47EC56EEA22);

  if(_id_A1D4CA153FFBB0CF || scripts\engine\utility::array_contains(_id_F945CC6444AD364E, "combat"))
    set_stealth_func("event_combat", _id_8E88D47EC56EEA22);
}