/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1370.gsc
**************************************/

_id_41CB(var_0, var_1) {
  self endon("death");
  var_1 = var_1 + "spotted";
  self notify(var_1);
  self endon(var_1);

  switch (self.team) {
    case "allies":
      for(;;) {
        maps\_utility::_id_1654("_stealth_enabled");
        common_scripts\utility::flag_wait("_stealth_spotted");

        if(!maps\_utility::_id_1008("_stealth_enabled")) {
          continue;
        }
        self thread[[var_0]]();
        common_scripts\utility::flag_waitopen("_stealth_spotted");
      }

      break;
    case "team3":
    case "axis":
      for(;;) {
        maps\_utility::_id_1654("_stealth_enabled");
        maps\_stealth_utility::_id_41CC();

        if(!maps\_utility::_id_1008("_stealth_enabled")) {
          continue;
        }
        self thread[[var_0]]();
        maps\_stealth_utility::_id_41CD();
      }

      break;
  }
}

_id_41CE(var_0, var_1) {
  self endon("death");
  var_1 = var_1 + "hidden";
  self notify(var_1);
  self endon(var_1);

  switch (self.team) {
    case "allies":
      for(;;) {
        maps\_utility::_id_1654("_stealth_enabled");
        common_scripts\utility::flag_waitopen("_stealth_spotted");

        if(!maps\_utility::_id_1008("_stealth_enabled")) {
          continue;
        }
        self thread[[var_0]]();
        common_scripts\utility::flag_wait("_stealth_spotted");
      }

      break;
    case "team3":
    case "axis":
      for(;;) {
        maps\_utility::_id_1654("_stealth_enabled");
        maps\_stealth_utility::_id_41CD();

        if(!maps\_utility::_id_1008("_stealth_enabled")) {
          continue;
        }
        self thread[[var_0]]();
        maps\_stealth_utility::_id_41CC();
      }

      break;
  }
}

_id_41CF(var_0, var_1, var_2) {
  self._id_0B6E._id_41D0._id_41D1[var_0][var_1] = var_2;
}

_id_41D2(var_0, var_1) {
  return self._id_0B6E._id_41D0._id_41D1[var_0][var_1];
}

_id_41D3(var_0) {
  self._id_0B6E._id_41D0._id_41D4 = var_0;
}

_id_41D5(var_0) {
  if(var_0 == "heard_scream" || var_0 == "doFlashBanged" || var_0 == "explode") {
    return 1;
  }
  return 0;
}

_id_41D6(var_0) {}

_id_41D7(var_0) {
  setdvarifuninitialized("stealth_debug_prints", "0");

  if(!isDefined(getDvar("stealth_debug_prints"))) {
    setDvar("stealth_debug_prints", "0");
  }
  if(getdvarint("stealth_debug_prints") != 1) {
    return;
  }
}

_id_41D8(var_0) {}

_id_41D9(var_0) {
  if(isDefined(self._id_204F)) {
    self._id_204F = maps\_utility::string(self._id_204F);
  } else {
    self._id_204F = "default";
  }
  var_1 = _id_41DB(var_0);

  if(!common_scripts\utility::flag_exist(var_1)) {
    common_scripts\utility::flag_init(var_1);

    if(!isDefined(level._id_0B6E._id_1124.flags[var_0])) {
      level._id_0B6E._id_1124.flags[var_0] = [];
    }
    var_2 = level._id_0B6E._id_1124.flags[var_0].size;
    level._id_0B6E._id_1124.flags[var_0][var_2] = var_1;
  }
}

_id_41DA() {
  if(!isDefined(level._id_0B6E._id_1124.groups[self._id_204F])) {
    level._id_0B6E._id_1124.groups[self._id_204F] = [];
    level._id_0B6E._id_1124 notify(self._id_204F);
  }

  var_0 = level._id_0B6E._id_1124.groups[self._id_204F].size;
  level._id_0B6E._id_1124.groups[self._id_204F][var_0] = self;
}

_id_41DB(var_0) {
  return _id_41DC(var_0, self._id_204F);
}

_id_41DC(var_0, var_1) {
  var_2 = var_0 + "-Group:" + var_1;
  return var_2;
}

_id_41DD(var_0) {
  var_1 = _id_41DB(var_0);
  common_scripts\utility::flag_set(var_1);
  common_scripts\utility::flag_set(var_0);
}

_id_41DE(var_0) {
  var_1 = [];
  var_2 = level._id_0B6E._id_1124.groups;

  foreach(var_6, var_4 in var_2) {
    var_5 = _id_41DC(var_0, var_6);

    if(common_scripts\utility::flag(var_5)) {
      var_1[var_1.size] = var_6;
    }
  }

  return var_1;
}

_id_41DF(var_0) {
  var_1 = [];
  var_2 = level._id_0B6E._id_1124.groups;

  foreach(var_7, var_4 in var_2) {
    var_5 = _id_41DC(var_0, var_7);

    if(common_scripts\utility::flag(var_5)) {
      var_6 = _id_41E1(var_7);
      var_1 = maps\_utility::_id_1843(var_1, var_6);
    }
  }

  return var_1;
}

_id_41E0(var_0, var_1) {
  var_2 = _id_41DC(var_0, var_1);
  common_scripts\utility::flag_clear(var_2);
  var_3 = level._id_0B6E._id_1124.flags[var_0];
  var_4 = 1;

  foreach(var_7, var_6 in var_3) {
    if(common_scripts\utility::flag(var_6)) {
      return;
    }
  }

  common_scripts\utility::flag_clear(var_0);
}

_id_41E1(var_0) {
  level._id_0B6E._id_1124.groups[var_0] = maps\_utility::_id_1361(level._id_0B6E._id_1124.groups[var_0]);
  return level._id_0B6E._id_1124.groups[var_0];
}

_id_41E2(var_0) {
  if(!isDefined(level._id_0B6E._id_1124.groups[var_0])) {
    level._id_0B6E._id_1124 waittill(var_0);
  }
}

_id_41E3() {
  self endon("death");
  self endon("pain_death");

  for(;;) {
    maps\_utility::_id_13DB("_stealth_enabled");
    var_0 = self._id_0B6E._id_41D0._id_41D1["state"]["spotted"];

    switch (self.team) {
      case "allies":
        self[[var_0]]();
        break;
      case "team3":
      case "axis":
        self[[var_0]](1);
        break;
    }

    maps\_utility::_id_1654("_stealth_enabled");
    var_1 = self._id_0B6E._id_41D0._id_41D1["state"]["hidden"];
    self[[var_1]]();
  }
}

_id_41E4() {
  self notify("going_back");
  self endon("death");
  self notify("stop_loop");

  if(isDefined(self._id_0B6E._id_41D0._id_41D4)) {
    self[[self._id_0B6E._id_41D0._id_41D4]]();
  }
  var_0 = self._id_0B6E._id_41D0._id_41E5;

  if(isDefined(var_0) && self.type != "dog" && !isDefined(self._id_11A0)) {
    self._id_11A0 = maps\_patrol::_id_2066;
  }
  if(isDefined(self._id_11A0) && isDefined(self.pathgoalpos)) {
    self setgoalpos(self.origin);
    wait 0.05;
  }

  if(isDefined(self._id_2050)) {
    if(isDefined(self._id_2056)) {
      self.target = self._id_2056.targetname;
    }
    if(isDefined(self._id_41E6)) {
      self.target = self._id_41E6.targetname;
      self._id_41E6 = undefined;
    }

    thread maps\_patrol::_id_204E();
  } else if(isalive(self._id_206C)) {
    thread maps\_patrol::_id_2076();
    maps\_utility::_id_2080();
    self._id_23DB = undefined;
  } else if(isDefined(var_0)) {
    if(self.type != "dog") {
      maps\_utility::_id_140B("_stealth_patrol_cqb", 1);
    } else {
      maps\_utility::_id_2080();
      self._id_23DB = undefined;
    }

    self._id_117F = 1;
    self._id_1199 = 1;
    self setgoalpos(var_0);
    self.goalradius = 40;
  }

  waittillframeend;
  maps\_utility::_id_13DE("_stealth_override_goalpos");

  if(isDefined(var_0)) {
    thread _id_41E7(var_0);
  }
}

_id_41E7(var_0) {
  self endon("death");
  self endon("_stealth_enemy_alert_level_change");
  maps\_utility::_id_2796(var_0);
  self._id_0B6E._id_41D0._id_41E5 = undefined;
}

_id_41E8(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }
  if(isDefined(level._id_0B6E._id_41E9._id_41EA) && distancesquared(var_0, level._id_0B6E._id_41E9.origin) < 4096 && var_1 == level._id_0B6E._id_41E9.radius && var_2 == level._id_0B6E._id_41E9._id_14BE) {
    return level._id_0B6E._id_41E9._id_41EA;
  }
  level._id_0B6E._id_41E9.origin = var_0;
  level._id_0B6E._id_41E9.radius = var_1;
  level._id_0B6E._id_41E9._id_14BE = var_2;
  level._id_0B6E._id_41E9._id_41EA = getnodesinradius(var_0, var_1, var_2, 512, "Path");
  return level._id_0B6E._id_41E9._id_41EA;
}

_id_41EB() {
  self.fovcosine = 0.01;
  self.ignoreall = 0;
  self.diequietly = 0;
  maps\_utility::_id_140C();
  self.fixednode = 0;
}

_id_41EC(var_0, var_1) {
  self endon("death");
  var_0 endon("death");

  if(!isDefined(var_1)) {
    var_1 = 60;
  }
  wait(var_1);

  if(isDefined(var_0._id_0B6E._id_41ED._id_41EE[self.unique_id]) && var_0._id_0B6E._id_41ED._id_41EE[self.unique_id] > 0) {
    var_0._id_0B6E._id_41ED._id_41EE[self.unique_id]--;
  }
}

_id_41EF() {
  if(!maps\_utility::_id_1008("_stealth_behavior_reaction_anim")) {
    maps\_utility::_id_1414();
    self notify("stop_animmode");
    self notify("stop_loop");
  }

  if(isDefined(self._id_2050)) {
    if(isDefined(self._id_2056)) {
      self._id_2056._id_2055 = undefined;
    }
    self notify("release_node");
    self notify("end_patrol");
  }

  self notify("stop_first_frame");
  maps\_utility::_id_140C();
  maps\_utility::_id_26FC();
}

_id_41F0() {
  if(isDefined(self._id_0B6E._id_41D0._id_41E5)) {
    return;
  }
  if(isDefined(self._id_1407)) {
    self._id_0B6E._id_41D0._id_41E5 = self._id_1407.origin;
  } else if(isDefined(self._id_1405)) {
    self._id_0B6E._id_41D0._id_41E5 = self._id_1405.origin;
  } else if(isDefined(self._id_2725)) {
    self._id_0B6E._id_41D0._id_41E5 = self._id_2725;
  } else {
    self._id_0B6E._id_41D0._id_41E5 = self.origin;
  }
}

_id_41F1(var_0) {
  self._id_0B6E._id_41D0._id_41E5 = var_0;
}

_id_41F2(var_0, var_1) {
  self notify("enemy_runto_and_lookaround");
  self endon("enemy_runto_and_lookaround");
  self endon("death");
  self endon("_stealth_enemy_alert_level_change");

  if(self.type != "dog") {
    self endon("_stealth_saw_corpse");
  }
  var_2 = _id_41DB("_stealth_spotted");
  level endon(var_2);
  self notify("stop_loop");
  maps\_utility::_id_13DC("_stealth_override_goalpos");

  if(isDefined(var_0)) {
    self setgoalnode(var_0);
  } else {
    self setgoalpos(var_1);
  }
  self.goalradius = 64;
  self waittill("goal");

  if(self.type != "dog") {
    maps\_utility::_id_26FA("_stealth_look_around");
  }
}

_id_41F3(var_0, var_1, var_2) {
  var_3 = _id_41E8(var_0, var_1, var_2);

  if(!isDefined(var_3) || var_3.size == 0) {
    return;
  }
  var_4 = var_3[randomint(var_3.size)];

  for(var_3 = common_scripts\utility::array_remove(var_3, var_4); isDefined(var_4.owner); var_3 = common_scripts\utility::array_remove(var_3, var_4)) {
    if(var_3.size == 0) {
      return;
    }
    var_4 = var_3[randomint(var_3.size)];
  }

  level._id_0B6E._id_41E9._id_41EA = var_3;
  return var_4;
}

_id_41F4() {
  if(self.type == "dog") {
    return;
  }
  if(!_id_41FD("wtf")) {
    return;
  }
  var_0 = "stealth_" + self._id_0AB6 + "_anexplosion";
  self playSound(var_0);
}

_id_41F5() {
  if(self.type == "dog") {
    return;
  }
  if(!_id_41FD("huh")) {
    return;
  }
  var_0 = "stealth_" + self._id_0AB6 + "_huh";
  self playSound(var_0);
}

_id_41F6() {
  if(self.type == "dog") {
    return;
  }
  if(!_id_41FD("hmph")) {
    return;
  }
  var_0 = "stealth_" + self._id_0AB6 + "_hmph";
  self playSound(var_0);
}

_id_41F7() {
  self endon("death");
  self endon("pain_death");

  if(self.type == "dog") {
    return;
  }
  if(!_id_41FD("spotted")) {
    return;
  }
  self playSound("RU_" + self._id_0AB6 + "_stealth_alert");
}

_id_41F8(var_0) {
  self endon("death");
  self endon("pain_death");
  maps\_stealth_utility::_id_41CC();

  if(self.type == "dog") {
    return;
  }
  if(_id_41FD("spotted")) {
    thread _id_41FA(var_0);
    var_1 = "RU_" + self._id_0AB6 + "_stealth_alert";
    self playSound(var_1);
  }

  if(_id_41FD("acknowledge")) {
    thread _id_41F9(self.origin);
  }
}

_id_41F9(var_0) {
  wait 1.5;

  if(isDefined(self._id_0AB6)) {
    var_1 = self._id_0AB6;
  } else {
    var_1 = randomint(3);
  }
  var_2 = "RU_" + var_1 + "_stealth_alert_r";
  common_scripts\utility::play_sound_in_space(var_2, var_0);
}

_id_41FA(var_0) {
  var_1 = _id_41E1(self._id_204F);

  foreach(var_4, var_3 in var_1) {
    if(var_3 == self) {
      continue;
    }
    if(isDefined(var_3.enemy) || isDefined(var_3.favoriteenemy)) {
      continue;
    }
    var_3 notify("heard_scream", var_0);
  }
}

_id_41FB() {
  self endon("death");

  if(isDefined(self._id_41FC)) {
    wait(self._id_41FC);
  }
  if(!_id_41FD("corpse")) {
    return;
  }
  if(self.type == "dog") {
    maps\_utility::_id_13DB("_stealth_behavior_reaction_anim_in_progress");
    self notify("event_awareness", "howl");
    return;
  }

  var_0 = "stealth_" + self._id_0AB6 + "_deadbody";
  self playSound(var_0);
}

_id_41FD(var_0) {
  if(var_0 == "spotted") {
    if(level._id_0B6E._id_41D0.sound[var_0][self._id_204F]) {
      return 0;
    }
    level._id_0B6E._id_41D0.sound[var_0][self._id_204F] = 1;
  } else {
    if(level._id_0B6E._id_41D0.sound[var_0]) {
      return 0;
    }
    level._id_0B6E._id_41D0.sound[var_0] = 1;
    thread _id_41FE(var_0);
  }

  return 1;
}

_id_41FE(var_0) {
  wait(level._id_0B6E._id_41D0._id_41FF);
  level._id_0B6E._id_41D0.sound[var_0] = 0;
}

_id_4200(var_0) {
  self endon("death");
  self endon("pain_death");

  if(_id_4207(var_0)) {
    return;
  }
  _id_4201(var_0);
  _id_420A(var_0);
}

_id_4201(var_0) {
  if(isDefined(self._id_0B6E._id_41D0._id_0EFE._id_4202)) {
    _id_4203(var_0);
    return;
  }

  var_1 = self._id_0B6E._id_41D0._id_41D1["animation"][var_0];
  self[[var_1]](var_0);
}

_id_4203(var_0) {
  var_1 = self._id_0B6E._id_41D0._id_0EFE._id_4202.node;
  var_2 = self._id_0B6E._id_41D0._id_0EFE._id_4202._id_11EB;
  var_3 = self._id_0B6E._id_41D0._id_0EFE._id_4202.tag;
  var_4 = self._id_0B6E._id_41D0._id_0EFE._id_4202._id_13F8;
  maps\_utility::_id_13DC("_stealth_behavior_reaction_anim");
  self.allowdeath = 1;
  var_1 notify(var_4);

  if(isDefined(self._id_4204)) {
    self._id_4205 = 1;
    var_1 thread maps\_anim::_id_11DD(self._id_4204, var_2);
  }

  if(var_0 != "doFlashBanged") {
    if(isDefined(var_3) || isDefined(self._id_4206)) {
      var_1 maps\_anim::_id_11C1(self, var_2, var_3);
    } else {
      var_1 maps\_anim::_id_11CC(self, "gravity", var_2);
    }
  }

  _id_420B();
}

_id_4207(var_0) {
  self notify("enemy_awareness_reaction", var_0);

  if(maps\_utility::_id_1008("_stealth_behavior_first_reaction") || maps\_utility::_id_1008("_stealth_behavior_reaction_anim_in_progress")) {
    return 1;
  }
  _id_41EF();

  if(issubstr(var_0, "warning")) {
    var_0 = "warning";
  }
  switch (var_0) {
    case "found_corpse":
    case "saw_corpse":
    case "heard_corpse":
    case "explode":
      maps\_utility::_id_13DC("_stealth_behavior_reaction_anim");
      break;
    case "reset":
    case "warning":
      break;
    default:
      if(!maps\_utility::_id_133C("_stealth_behavior_asleep") || !maps\_utility::_id_1008("_stealth_behavior_asleep") || maps\_stealth_utility::_id_4208()) {
        maps\_utility::_id_13DC("_stealth_behavior_first_reaction");
        thread _id_4209();
      }

      maps\_utility::_id_13DC("_stealth_behavior_reaction_anim");
      break;
  }

  maps\_utility::_id_13DC("_stealth_behavior_reaction_anim_in_progress");
  return 0;
}

_id_4209() {
  var_0 = _id_41DB("_stealth_spotted");
  self endon("death");
  common_scripts\utility::flag_wait_or_timeout(var_0, 3);

  if(common_scripts\utility::flag(var_0)) {
    maps\_utility::_id_13DC("_stealth_behavior_first_reaction");
  }
}

_id_420A(var_0) {
  switch (var_0) {
    default:
      maps\_utility::_id_13DE("_stealth_behavior_reaction_anim");
      break;
  }

  maps\_utility::_id_13DE("_stealth_behavior_reaction_anim_in_progress");
}

_id_420B() {
  self._id_0B6E._id_41D0._id_0EFE._id_4202 = undefined;
  self.newenemyreactiondistsq = squared(512);
}

_id_420C(var_0) {
  if(!isDefined(self._id_0B6E._id_41D0._id_0EFE._id_4202)) {
    return;
  }
  self._id_0B6E._id_41D0._id_0EFE._id_4202.node notify("stop_loop");

  if(!isDefined(var_0) || var_0 == 0) {
    self stopanimscripted();
  }
  _id_420B();
}

_id_420D(var_0, var_1, var_2, var_3) {
  self._id_0B6E._id_41D0._id_0EFE._id_4202 = spawnStruct();
  self._id_0B6E._id_41D0._id_0EFE._id_4202.node = var_0;
  self._id_0B6E._id_41D0._id_0EFE._id_4202._id_11EB = var_1;
  self._id_0B6E._id_41D0._id_0EFE._id_4202.tag = var_2;
  self._id_0B6E._id_41D0._id_0EFE._id_4202._id_13F8 = var_3;
  thread _id_420E(var_0, var_1, var_2, var_3);
  self.newenemyreactiondistsq = 0;
}

_id_420E(var_0, var_1, var_2, var_3) {
  wait 0.1;

  if(!isDefined(self._id_4204)) {
    return;
  }
  var_4 = self._id_4204;
  self waittill("death");

  if(isDefined(self._id_4205)) {
    return;
  }
  var_0 thread maps\_anim::_id_11DD(var_4, var_1);
}

_id_420F(var_0, var_1) {
  level notify("event_awareness_handler");
  level endon("event_awareness_handler");
  level endon("default_event_awareness_enders");
  _id_4211(var_1);
  maps\_utility::_id_09C9(maps\_utility::_id_09CA, "event_awareness_handler");
  maps\_utility::_id_09C9(maps\_utility::_id_09CA, "default_event_awareness_enders");
  maps\_utility::_id_1DB1(common_scripts\utility::flag_clear, "_stealth_event");
  thread maps\_utility::_id_09CB();

  for(;;) {
    common_scripts\utility::flag_wait("_stealth_enabled");
    common_scripts\utility::flag_wait("_stealth_event");

    if(!common_scripts\utility::flag("_stealth_enabled")) {
      continue;
    }
    wait 2;
    _id_4210(var_0);
    common_scripts\utility::flag_waitopen("_stealth_event");
  }
}

_id_4210(var_0) {
  wait(randomfloatrange(0.5, 1));

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = common_scripts\utility::random(var_0);
  level thread maps\_utility::_id_1255(maps\_utility::_id_11F4, var_1);
}

_id_4211(var_0) {
  level endon("default_event_awareness_enders");
  level endon("event_awareness_handler");

  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
      if(common_scripts\utility::flag_exist(var_2) && common_scripts\utility::flag(var_2)) {
        level notify("default_event_awareness_enders");
      }
    }

    foreach(var_2 in var_0) {}
    maps\_utility::_id_09C9(maps\_utility::_id_09CA, var_2);
  }

  maps\_utility::_id_09C9(common_scripts\utility::flag_wait, "_stealth_spotted");
  maps\_utility::_id_09C9(maps\_utility::_id_09CA, "end_event_awareness_handler");
  maps\_utility::_id_09C9(maps\_utility::_id_09CA, "event_awareness_handler");
  maps\_utility::_id_1DB1(maps\_utility::_id_1DAA, "default_event_awareness_enders");
  thread maps\_utility::_id_09CB();
}

_id_4212() {
  if(!maps\_stealth_utility::_id_4213()) {
    return 0;
  }
  if(common_scripts\utility::flag("_stealth_player_nade")) {
    return 0;
  }
  if(common_scripts\utility::flag_exist("_radiation_poisoning")) {
    if(common_scripts\utility::flag("_radiation_poisoning")) {
      return 0;
    }
  }

  var_0 = getEntArray("destructible", "classname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.healthdrain)) {
      return 0;
    }
  }

  return 1;
}

_id_4214() {
  var_0 = maps\_stealth_utility::_id_4215();
  var_1 = maps\_stealth_utility::_id_4216();
  maps\_utility::_id_09C9(common_scripts\utility::flag_wait, var_0);
  maps\_utility::_id_09C9(common_scripts\utility::flag_wait, var_1);
  maps\_utility::_id_2757(maps\_utility::_id_09CA, "death");
  maps\_utility::_id_1DB1(maps\_utility::_id_1DAA, "end_patrol");
  thread maps\_utility::_id_09CB();
}

_id_4217() {
  thread maps\_stealth_utility::_id_4218();
}