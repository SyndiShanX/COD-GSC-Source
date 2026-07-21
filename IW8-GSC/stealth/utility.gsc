/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: stealth\utility.gsc
***********************************************/

get_group(var_0) {
  if(!isDefined(level.stealth.groupdata.groups[var_0]))
    return undefined;

  return level.stealth.groupdata.groups[var_0].members;
}

group_flag_clear(var_0, var_1) {
  var_2 = get_group_flagname(var_0, var_1);
  scripts\engine\utility::flag_clear(var_2);
  var_3 = level.stealth.group.flags[var_0];
  var_4 = 1;

  foreach(var_7, var_6 in var_3) {
    if(!issubstr(var_6, "_encstr_9A8507BA4040188D08") && scripts\engine\utility::flag(var_6))
      return;
  }

  if(scripts\engine\utility::flag(var_2) && self != level)
    self notify(var_0);

  scripts\engine\utility::flag_clear(var_0);
}

group_flag_set(var_0) {
  var_1 = get_group_flagname(var_0);

  if(!scripts\engine\utility::flag(var_1) && self != level)
    self notify(var_0);

  scripts\engine\utility::flag_set(var_1);
  scripts\engine\utility::flag_set(var_0);
}

group_flag(var_0) {
  var_1 = get_group_flagname(var_0);
  return scripts\engine\utility::flag(var_1);
}

get_group_flagname(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = self.script_stealthgroup;

  var_2 = var_0 + "_encstr_A25B085A40AAE7938372" + var_1;
  return var_2;
}

group_flag_wait(var_0) {
  var_1 = get_group_flagname(var_0);
  scripts\engine\utility::flag_wait(var_1);
}

group_flag_waitopen(var_0) {
  var_1 = get_group_flagname(var_0);
  scripts\engine\utility::flag_waitopen(var_1);
}

group_flag_wait_or_timeout(var_0, var_1) {
  var_2 = get_group_flagname(var_0);
  scripts\engine\utility::flag_wait_or_timeout(var_2, var_1);
}

group_flag_waitopen_or_timeout(var_0, var_1) {
  var_2 = get_group_flagname(var_0);
  scripts\engine\utility::flag_waitopen_or_timeout(var_2, var_1);
}

group_flag_init(var_0) {
  if(isDefined(self.script_stealthgroup))
    self.script_stealthgroup = scripts\engine\utility::string(self.script_stealthgroup);
  else
    self.script_stealthgroup = "_encstr_8B1608EC43B8D647A113";

  if(self.team == "_encstr_9A8507BA4040188D08")
    self.script_stealthgroup = self.script_stealthgroup + "_encstr_9A8507BA4040188D08";

  if(!scripts\engine\utility::flag_exist(var_0))
    scripts\engine\utility::flag_init(var_0);

  var_1 = get_group_flagname(var_0);

  if(!scripts\engine\utility::flag_exist(var_1)) {
    scripts\engine\utility::flag_init(var_1);

    if(!isDefined(level.stealth.group.flags[var_0]))
      level.stealth.group.flags[var_0] = [];

    level.stealth.group.flags[var_0][level.stealth.group.flags[var_0].size] = var_1;
  }
}

group_setcombatgoalRadius(var_0, var_1) {
  if(!isDefined(level.stealth.combat_goalradius))
    level.stealth.combat_goalradius = [];

  level.stealth.combat_goalradius[var_0] = var_1;
}

group_add() {
  if(!isDefined(level.stealth.group.groups[self.script_stealthgroup])) {
    level.stealth.group.groups[self.script_stealthgroup] = [];
    level.stealth.group notify(self.script_stealthgroup);
  }

  level.stealth.group.groups[self.script_stealthgroup][level.stealth.group.groups[self.script_stealthgroup].size] = self;
}

group_spotted_flag() {
  var_0 = get_group_flagname("_encstr_AA14106E4795B063A31AFADC38F6A31D95C8");
  return scripts\engine\utility::flag(var_0);
}

any_groups_in_combat(var_0) {
  if(!scripts\engine\utility::flag("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46"))
    return 0;

  foreach(var_2 in level.stealth.groupdata.groups) {
    if(isDefined(var_0) && !scripts\engine\utility::array_contains(var_0, var_2.name)) {
      continue;
    }
    if(scripts\stealth\group::group_anyoneincombat(var_2.name))
      return 1;
  }

  return 0;
}

get_stealth_state() {
  switch (self.stealth.state) {
    case 0:
      return "_encstr_820E07FAE8780B3A4C";
    case 1:
      return "_encstr_990A08985BAA40FB15E4";
    case 2:
      return "_encstr_990A08985BAA40FB15E4";
    case 3:
      return "_encstr_999A07C61338F9A23A";
  }
}

set_stealth_state(var_0) {
  switch (var_0) {
    case "_encstr_999A07C61338F9A23A":
      var_1 = 3;
      break;
    case "_encstr_927D09879B6EB23938A9B2":
      var_1 = 2;
      break;
    case "_encstr_BE7D09F301B846B228D7D6":
      var_1 = 1;
      break;
    default:
      var_1 = 0;
      break;
  }

  self.stealth.state = var_1;
}

check_stealth() {}

alertlevel_init_map() {
  level.stealth.alert_levels_exe = [];
  level.stealth.alert_levels_exe["_encstr_820E07FAE8780B3A4C"] = "_encstr_AB410AEE5FF05E3739D98AE3";
  level.stealth.alert_levels_exe["_encstr_88F20627959BCAE8"] = "_encstr_AB410AEE5FF05E3739D98AE3";
  level.stealth.alert_levels_exe["_encstr_BE7D09F301B846B228D7D6"] = "_encstr_85BB067A08A3FAB3";
  level.stealth.alert_levels_exe["_encstr_927D09879B6EB23938A9B2"] = "_encstr_85BB067A08A3FAB3";
  level.stealth.alert_levels_exe["_encstr_8B9A0CD8F65B98581DBE86AE738E"] = "_encstr_85BB067A08A3FAB3";
  level.stealth.alert_levels_exe["_encstr_999A07C61338F9A23A"] = "_encstr_AA7C07466F9DA30713";
  level.stealth.alert_levels_int = [];
  level.stealth.alert_levels_int["_encstr_820E07FAE8780B3A4C"] = 0;
  level.stealth.alert_levels_int["_encstr_88F20627959BCAE8"] = 0;
  level.stealth.alert_levels_int["_encstr_BE7D09F301B846B228D7D6"] = 1;
  level.stealth.alert_levels_int["_encstr_927D09879B6EB23938A9B2"] = 2;
  level.stealth.alert_levels_int["_encstr_8B9A0CD8F65B98581DBE86AE738E"] = 2;
  level.stealth.alert_levels_int["_encstr_999A07C61338F9A23A"] = 3;
  level.stealth.alert_levels_exe["_encstr_AA7C07466F9DA30713"] = 3;
}

alertlevel_script_to_exe(var_0) {
  if(isDefined(level.stealth.alert_levels_exe[var_0]))
    return level.stealth.alert_levels_exe[var_0];

  return var_0;
}

set_detect_ranges(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {}

  scripts\stealth\manager::set_detect_ranges_internal(var_0, var_1);
}

set_min_detect_range_darkness(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {}

  if(isDefined(var_0)) {
    level.stealth.detect.minrangedarkness["_encstr_95DF070DD22319CA9B"]["_encstr_922406F1A6FD5E05"] = var_0["_encstr_922406F1A6FD5E05"];
    level.stealth.detect.minrangedarkness["_encstr_95DF070DD22319CA9B"]["_encstr_B13D076BED70539F23"] = var_0["_encstr_B13D076BED70539F23"];
    level.stealth.detect.minrangedarkness["_encstr_95DF070DD22319CA9B"]["_encstr_A5AD069B231F0BAF"] = var_0["_encstr_A5AD069B231F0BAF"];
  }

  if(isDefined(var_1)) {
    level.stealth.detect.minrangedarkness["_encstr_8ADA089BC1B78EE8B246"]["_encstr_922406F1A6FD5E05"] = var_1["_encstr_922406F1A6FD5E05"];
    level.stealth.detect.minrangedarkness["_encstr_8ADA089BC1B78EE8B246"]["_encstr_B13D076BED70539F23"] = var_1["_encstr_B13D076BED70539F23"];
    level.stealth.detect.minrangedarkness["_encstr_8ADA089BC1B78EE8B246"]["_encstr_A5AD069B231F0BAF"] = var_1["_encstr_A5AD069B231F0BAF"];
  }
}

do_stealth() {
  if(!isDefined(level.player.stealth))
    scripts\stealth\init::set_stealth_mode(1);

  switch (self.team) {
    case "_encstr_B848067B63177293":
    case "_encstr_8E8405EA382B2A":
      thread scripts\stealth\enemy::main();
      break;
    case "_encstr_9A8507BA4040188D08":
      thread scripts\stealth\friendly::main();
      break;
    case "_encstr_A7A408B9CA5D1D4E2C63":
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

set_patrol_move_loop_anim(var_0) {}

set_default_patrol_style(var_0) {
  self.stealth.default_patrol_style = var_0;

  if(isDefined(self.stealth.default_patrol_style))
    set_patrol_style(self.stealth.default_patrol_style);
}

get_patrol_react_magnitude_int(var_0) {
  switch (var_0) {
    case "_encstr_A972062F7FDAF9B0":
      return 0;
    case "_encstr_82180596757AE1":
      return 1;
    case "_encstr_8C190457C869":
      return 2;
    case "_encstr_8DEC06B1E943615B":
      return 3;
  }
}

set_patrol_style(var_0, var_1, var_2, var_3) {
  if(var_0 == "_encstr_97C8081B2DD9BB0FE35F")
    var_0 = "_encstr_96080730D8534E0A28";

  scripts\common\utility::demeanor_override(var_0);

  if(var_0 == "_encstr_931904C66102") {
    var_4 = 60;

    if(isDefined(self.stealth.hunt_speed))
      var_4 = self.stealth.hunt_speed;

    scripts\engine\utility::set_movement_speed(var_4);
  }

  if(istrue(var_1))
    set_patrol_react(var_2, var_3);
}

get_patrol_style() {
  return scripts\asm\asm::asm_getdemeanor();
}

get_patrol_style_default() {
  var_0 = self.stealth.default_patrol_style;

  if(!isDefined(var_0))
    var_0 = level.stealth.default_patrol_style;

  return var_0;
}

set_patrol_react(var_0, var_1) {
  if(isDefined(self.stealth.breacting)) {
    if(get_patrol_react_magnitude_int(self.stealth.breacting) >= get_patrol_react_magnitude_int(var_1))
      return;
  }

  self.stealth.patrol_react_magnitude = var_1;
  self.stealth.patrol_react_pos = var_0;
  self.stealth.patrol_react_time = gettime();
}

goto_last_goal() {
  self notify("_encstr_9BC70BCF07D028B0E9F980CEC2");
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(self.stealth.goback_func))
    self[[self.stealth.goback_func]]();

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

  if(isDefined(var_0))
    thread goto_last_goal_and_clear(var_0);

  wait 0.05;
  stealth_override_goal(0);
}

goto_last_goal_and_clear(var_0) {
  self endon("_encstr_AD75063D571AE108");
  waittill_true_goal(var_0);
  self.stealth.last_spot = undefined;
}

alert_delay_distance_time(var_0) {
  var_1 = 2;

  if(isDefined(self.stealth.maxalertdelay))
    var_1 = self.stealth.maxalertdelay;

  if(self[[self.fnisinstealthinvestigate]]())
    var_1 = min(1.5, var_1);
  else if(self[[self.fnisinstealthhunt]]())
    var_1 = min(1.0, var_1);

  var_2 = 0.1;
  var_3 = 0.4;
  var_4 = 64;
  var_5 = 1024;
  var_6 = distance2d(self.origin, var_0.origin);

  if(var_6 < var_4) {
    var_7 = scripts\engine\math::normalize_value(0, var_4, var_6);
    var_8 = scripts\engine\math::factor_value(var_2, var_3, var_7);
  } else {
    var_7 = scripts\engine\math::normalize_value(var_4, var_5, var_6);
    var_8 = scripts\engine\math::factor_value(var_3, var_1, var_7);
  }

  return var_8;
}

set_path_dist(var_0) {
  var_0.distsqrd = get_path_dist_sq(self.origin, var_0.origin, self);
}

get_path_dist_sq(var_0, var_1, var_2) {
  var_3 = self findpath(var_0, var_1);

  if(isDefined(var_2))
    var_2.path = var_3;

  var_4 = 0;

  for(var_5 = 1; var_5 < var_3.size; var_5++)
    var_4 = var_4 + distancesquared(var_3[var_5 - 1], var_3[var_5]);

  return var_4;
}

remove_path_dist() {
  self.path = undefined;
  self.distsqrd = undefined;
}

is_visible(var_0) {
  if(isPlayer(self)) {
    if(scripts\engine\utility::within_fov(self.origin, self.angles, var_0.origin, 0.766)) {
      if(isDefined(var_0.tagging_visible) || tagging_shield())
        return 1;

      if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::player_can_see_ai(self, var_0, 250))
        return 1;
    }
  } else
    return self cansee(var_0);

  return 0;
}

tagging_shield() {
  return isDefined(self.offhandshield) && isDefined(self.offhandshield.active) && self.offhandshield.active;
}

getcorpseorigin() {
  if(isDefined(level.stealth)) {
    if(isDefined(level.stealth.additional_corpse) && isDefined(level.stealth.additional_corpse[self getentitynumber()]))
      return self.origin;

    if(isDefined(level.stealth.fngetcorpseorigin))
      return [[level.stealth.fngetcorpseorigin]]();
  }

  return self.origin;
}

setbattlechatter(var_0) {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnsetbattlechatter))
    return [[level.stealth.fnsetbattlechatter]](var_0);
}

addeventplaybcs(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnaddeventplaybcs))
    return [[level.stealth.fnaddeventplaybcs]](var_0, var_1, var_2, var_3, var_4, var_5);
}

animgenericcustomanimmode(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnanimgenericcustomanimmode))
    return [[level.stealth.fnanimgenericcustomanimmode]](var_0, var_1, var_2, var_3, var_4, var_5);
}

stealth_music(var_0, var_1) {
  self notify("_encstr_A9120ED7B8B141E2C11BE165FDB7CA0B");
  self endon("_encstr_A9120ED7B8B141E2C11BE165FDB7CA0B");
  thread stealth_music_pause_monitor();

  for(;;) {
    scripts\engine\utility::flag_wait("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");
    scripts\engine\utility::flag_waitopen("_encstr_AA14106E4795B063A31AFADC38F6A31D95C8");
    scripts\engine\utility::flag_waitopen("_encstr_9A8D14CDD1CA161B3A0D7D6BBAE6B4D8FAE016EA6E56");

    foreach(var_3 in level.players)
    var_3 thread stealth_music_transition(var_0);

    scripts\engine\utility::flag_wait("_encstr_AA14106E4795B063A31AFADC38F6A31D95C8");
    scripts\engine\utility::flag_waitopen("_encstr_9A8D14CDD1CA161B3A0D7D6BBAE6B4D8FAE016EA6E56");

    foreach(var_3 in level.players)
    var_3 thread stealth_music_transition(var_1);
  }
}

stealth_music_stop() {
  self notify("_encstr_A9120ED7B8B141E2C11BE165FDB7CA0B");
  self notify("_encstr_A9E41C23282D27FC39989F5577B758874F7B3B3D063F6178F8C57229E7A2");

  foreach(var_1 in level.players)
  var_1 thread stealth_music_transition(undefined);
}

stealth_music_pause_monitor(var_0, var_1) {
  self notify("_encstr_A9E41C23282D27FC39989F5577B758874F7B3B3D063F6178F8C57229E7A2");
  self endon("_encstr_A9E41C23282D27FC39989F5577B758874F7B3B3D063F6178F8C57229E7A2");

  for(;;) {
    scripts\engine\utility::flag_wait("_encstr_9A8D14CDD1CA161B3A0D7D6BBAE6B4D8FAE016EA6E56");

    foreach(var_3 in level.players)
    var_3 thread stealth_music_transition(undefined);

    scripts\engine\utility::flag_waitopen("_encstr_9A8D14CDD1CA161B3A0D7D6BBAE6B4D8FAE016EA6E56");

    if(scripts\engine\utility::flag("_encstr_AA14106E4795B063A31AFADC38F6A31D95C8")) {
      foreach(var_3 in level.players)
      var_3 thread stealth_music_transition(var_1);

      continue;
    }

    foreach(var_3 in level.players)
    var_3 thread stealth_music_transition(var_0);
  }
}

stealth_music_transition(var_0) {
  if(isDefined(self.fnstealthmusictransition))
    return [[self.fnstealthmusictransition]](var_0);
}

update_light_meter() {
  if(isDefined(self.fnupdatelightmeter))
    return [[self.fnupdatelightmeter]]();
}

set_disguised(var_0) {
  if(isDefined(level.stealth.fnsetdisguised))
    self[[level.stealth.fnsetdisguised]](var_0);
}

set_disguised_default(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(var_0) {
    level.stealth.disguised = 1;
    level.stealth.threatsightratescale = 0.4;
    level.stealth.threatsightdistscale = 0.4;
    level.stealth.proximity_combat_radius_bump = 0;
    level.stealth.proximity_combat_radius_sight = 0;
    level.stealth.proximity_combat_radius_fake_sight = 0;
    setsaveddvar("_encstr_954C0BC4A78A5414D326D33DA0", 0.25);
    setsaveddvar("_encstr_85D60B867170254129796F7404", cos(90));
    setsaveddvar("_encstr_8BBC0A06631FDCA3EDA031C1", 0.025);
    setsaveddvar("_encstr_92F70B713C7893DD1FCE316076", 0.25);
  } else {
    level.stealth.disguised = undefined;
    level.stealth.threatsightratescale = undefined;
    level.stealth.threatsightdistscale = undefined;
    level.stealth.proximity_combat_radius_bump = 100;
    level.stealth.proximity_combat_radius_sight = 150;
    level.stealth.proximity_combat_radius_fake_sight = 60;
    setsaveddvar("_encstr_954C0BC4A78A5414D326D33DA0", 0.5);
    setsaveddvar("_encstr_85D60B867170254129796F7404", cos(180));
    setsaveddvar("_encstr_8BBC0A06631FDCA3EDA031C1", 0.01);
    setsaveddvar("_encstr_92F70B713C7893DD1FCE316076", 0.1);
  }

  var_1 = getaiarray();

  foreach(var_3 in var_1) {
    if(!isalive(var_3)) {
      continue;
    }
    if(isDefined(var_3.stealth) && isDefined(var_3.stealth.threat_sight_state))
      var_3 scripts\stealth\threat_sight::threat_sight_set_state_parameters();
  }
}

stealth_override_goal(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(var_0) {
    self.remove_from_animloop = 1;
    scripts\engine\utility::ent_flag_set("_encstr_860D1653EBD5EF75D0A9DFE77DB03A7B0B418A1911B8A72D");
    scripts\stealth\enemy::set_blind(0);
    self.last_set_goalent = undefined;
  } else
    scripts\engine\utility::ent_flag_clear("_encstr_860D1653EBD5EF75D0A9DFE77DB03A7B0B418A1911B8A72D");
}

stealth_behavior_active() {
  return scripts\engine\utility::ent_flag_exist("_encstr_860D1653EBD5EF75D0A9DFE77DB03A7B0B418A1911B8A72D") && scripts\engine\utility::ent_flag("_encstr_860D1653EBD5EF75D0A9DFE77DB03A7B0B418A1911B8A72D");
}

stealth_behavior_wait() {
  if(stealth_behavior_active())
    scripts\engine\utility::ent_flag_waitopen("_encstr_860D1653EBD5EF75D0A9DFE77DB03A7B0B418A1911B8A72D");
}

disable_stealth_system() {
  scripts\engine\utility::flag_clear("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");
  var_0 = getaiunittypearray("_encstr_AF1904A7F929", "_encstr_AF1904A7F929");

  foreach(var_2 in var_0)
  var_2 enable_stealth_for_ai(0);

  foreach(var_5 in level.players) {
    var_5.maxvisibledist = 8192;

    if(var_5 scripts\engine\utility::ent_flag_exist("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46"))
      var_5 scripts\engine\utility::ent_flag_clear("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");
  }

  scripts\stealth\manager::event_change("_encstr_8ADA089BC1B78EE8B246");
}

enable_stealth_system() {
  scripts\engine\utility::flag_set("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");
  var_0 = getaiunittypearray("_encstr_AF1904A7F929", "_encstr_AF1904A7F929");

  foreach(var_2 in var_0)
  var_2 enable_stealth_for_ai(1);

  foreach(var_5 in level.players) {
    if(var_5 scripts\engine\utility::ent_flag_exist("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46"))
      var_5 scripts\engine\utility::ent_flag_set("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");
  }
}

enable_stealth_for_ai(var_0) {
  if(!var_0) {
    self.maxvisibledist = 8192;

    if(scripts\engine\utility::ent_flag_exist("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46") && scripts\engine\utility::ent_flag("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46") && self.team == "_encstr_8E8405EA382B2A") {
      var_1 = spawnStruct();
      var_1.origin = level.player.origin;
      var_1.investigate_point = level.player.origin;
      var_1.investigate_pos = level.player.origin;
      var_1.type = "_encstr_AA7C07466F9DA30713";
      var_1.typeorig = "_encstr_999A07C61338F9A23A";
      self.dontevershoot = 0;
      self.dontattackme = 0;
      scripts\stealth\enemy::bt_event_combat(var_1);
    }
  }

  if(scripts\engine\utility::ent_flag_exist("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46")) {
    if(var_0)
      scripts\engine\utility::ent_flag_set("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");
    else
      scripts\engine\utility::ent_flag_clear("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");
  }
}

custom_state_functions(var_0) {
  if(isDefined(var_0["_encstr_8ADA089BC1B78EE8B246"]))
    self.stealth_state_func["_encstr_8ADA089BC1B78EE8B246"] = var_0["_encstr_8ADA089BC1B78EE8B246"];

  if(isDefined(var_0["_encstr_95DF070DD22319CA9B"]))
    self.stealth_state_func["_encstr_95DF070DD22319CA9B"] = var_0["_encstr_95DF070DD22319CA9B"];
}

set_stealth_func(var_0, var_1) {
  self.stealth.funcs[var_0] = var_1;
}

set_event_override(var_0, var_1) {
  if(isDefined(var_0) && isDefined(self.stealth) && isDefined(self.stealth.funcs))
    self.stealth.funcs["_encstr_BACE07D36E4F603577" + var_0] = var_1;
}

bcisincombat() {
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(self.fnisinstealthcombat) && self[[self.fnisinstealthcombat]]())
    return 1;

  if(!isDefined(self.stealth))
    return 1;

  return 0;
}

_autosave_stealthcheck() {
  return 1;
}

waittill_true_goal(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_1))
    var_1 = self.goalradius;

  for(;;) {
    self waittill("_encstr_8B7205D9ED5958");

    if(distance(self.origin, var_0) < var_1 + 10) {
      break;
    }
  }
}

quickdropnewitem() {
  if(isDefined(level.stealth.playerclearspectatekillchainsystem))
    return [[level.stealth.playerclearspectatekillchainsystem]](self);
}