/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\yard\yard_util.gsc
**********************************************/

_id_10626(var_0, var_1) {
  var_2 = [];

  if(isDefined(var_1))
    var_2 = _id_229A(getnodearray(var_1, "script_noteworthy"));

  var_3 = 1;
  var_0 = _id_2289(var_0);
  var_4 = [];

  foreach(var_6 in var_0) {
    var_7 = var_6;

    if(isai(var_6) || isspawner(var_6))
      var_7 = var_6.name;

    var_8 = undefined;

    if(isDefined(var_7) && isDefined(var_2[var_7]))
      var_8 = var_2[var_7];
    else if(isDefined(var_2["NONAME" + var_3])) {
      var_8 = var_2["NONAME" + var_3];
      var_3++;
    }

    if(isstring(var_6)) {
      switch (var_7) {
        case "salter":
          var_4 = scripts\engine\utility::array_add(var_4, _id_107BE(var_8));
          break;
        case "ethan":
          var_4 = scripts\engine\utility::array_add(var_4, _id_106D9(var_8));
          break;
        case "brooks":
          var_4 = scripts\engine\utility::array_add(var_4, _id_1065E(var_8));
          break;
        case "kloos":
          var_4 = scripts\engine\utility::array_add(var_4, _id_10750(var_8));
          break;
        default:
      }

      continue;
    }

    if(isspawner(var_6)) {
      var_9 = 1;

      if(isDefined(var_6._id_ECE7) && var_6.count == 0)
        var_9 = 0;

      var_6.count = 1;
      var_10 = var_6 scripts\sp\utility::_id_10619(1);

      if(!var_9)
        var_10 thread _id_0B77::_id_1A14(level._id_1162[var_6._id_ECE7]);

      var_4 = scripts\engine\utility::array_add(var_4, var_10);

      if(isDefined(var_8))
        var_10 _id_B399(var_8);

      continue;
    }

    if(isai(var_6)) {
      var_4 = scripts\engine\utility::array_add(var_4, var_6);

      if(isDefined(var_8))
        var_6 _id_B399(var_8);

      continue;
    }
  }

  scripts\engine\utility::waitframe();
  return var_4;
}

_id_107BE(var_0) {
  if(!isDefined(level._id_EA2C))
    level._id_EA2C = _id_107D5("salter", "Salter", "iw7_m4");

  if(isDefined(var_0))
    level._id_EA2C _id_B399(var_0);

  return level._id_EA2C;
}

_id_106D9(var_0) {
  if(!isDefined(level._id_6754))
    level._id_6754 = _id_107D5("ethan", "Ethan", "iw7_sdfar");

  if(isDefined(var_0))
    level._id_6754 _id_B399(var_0);

  return level._id_6754;
}

_id_10766(var_0) {
  if(!isDefined(level._id_B4F1))
    level._id_B4F1 = _id_107D5("mccallum", "McCallum", "iw7_m4");

  if(isDefined(var_0))
    level._id_B4F1 _id_B399(var_0);

  return level._id_B4F1;
}

_id_1065E(var_0) {
  if(!isDefined(level._id_30F6))
    level._id_30F6 = _id_107D5("brooks", "Brooks", "iw7_erad");

  if(isDefined(var_0))
    level._id_30F6 _id_B399(var_0);

  return level._id_30F6;
}

_id_10750(var_0) {
  if(!isDefined(level._id_A6F4))
    level._id_A6F4 = _id_107D5("kloos", "Kloos", "iw7_erad");

  if(isDefined(var_0))
    level._id_A6F4 _id_B399(var_0);

  return level._id_A6F4;
}

_id_107D5(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::get_target_ent(var_0);
  var_3.count = 1;
  var_4 = var_3 scripts\sp\utility::_id_10619(1);
  var_4._id_1FBB = var_0;
  var_4 scripts\sp\utility::_id_F3B5("r");
  var_4 scripts\sp\utility::_id_F2DA(0);
  var_4 _meth_839E();
  var_4 scripts\sp\utility::_id_72EC(var_2, "primary");
  var_4._id_72C7 = 1;
  var_4.goalradius = 16;
  var_4._id_C065 = 1;
  var_4 thread scripts\sp\utility::_id_5131();

  if(!isDefined(level._id_1684))
    level._id_1684 = [];

  level._id_1684[var_0] = var_4;
  return var_4;
}

_id_4046(var_0, var_1) {
  if(isDefined(self.name))
    level._id_1684 = scripts\sp\utility::_id_22B2(level._id_1684, self.name);

  if(isDefined(self._id_B14F))
    scripts\sp\utility::_id_1101B();

  if(isDefined(self._id_5D6C) && isDefined(self._id_5D6C._id_4D94) && isDefined(self._id_5D6C._id_4D94.allies))
    self._id_5D6C._id_4D94.allies = scripts\engine\utility::array_remove(self._id_5D6C._id_4D94.allies, self);

  if(isDefined(var_0) && var_0) {
    if(isDefined(var_1))
      self _meth_81D0(var_1);
    else
      self _meth_81D0();
  } else
    self delete();
}

_id_D2E0() {
  level.player thread _id_0F24::main();
  level thread _id_0F21::_id_F5B6(1);
  scripts\engine\utility::delaythread(0.5, _id_0F26::_id_117D3, 0);
}

_id_D2DF() {
  level thread _id_0F21::_id_F5B6(0);
}

_id_13E3B() {
  level._id_13E40 = [];
  level._id_13E40["prone"] = 300;
  level._id_13E40["crouch"] = 600;
  level._id_13E40["stand"] = 1125;
  level._id_13E47 = [];
  level._id_13E47["prone"] = 600;
  level._id_13E47["crouch"] = 1125;
  level._id_13E47["stand"] = 2250;
  _id_0F27::_id_F353(level._id_13E40, level._id_13E47);
  var_0 = [];
  var_0["sight_dist"] = 600;
  var_0["detect_dist"] = 300;
  var_0["found_dist"] = 100;
  _id_0F19::_id_F30E(var_0);
  var_1["ai_eventDistDeath"]["spotted"] = 384;
  var_1["ai_eventDistDeath"]["hidden"] = 384;
  var_1["ai_eventDistPain"]["spotted"] = 192;
  var_1["ai_eventDistPain"]["hidden"] = 192;
  var_1["ai_eventDistExplosion"]["spotted"] = 1536;
  var_1["ai_eventDistExplosion"]["hidden"] = 1536;
  var_1["ai_eventDistBullet"]["spotted"] = 48;
  var_1["ai_eventDistBullet"]["hidden"] = 48;
  var_1["ai_eventDistFootstep"]["spotted"] = 150;
  var_1["ai_eventDistFootstep"]["hidden"] = 75;
  var_1["ai_eventDistFootstepWalk"]["spotted"] = 75;
  var_1["ai_eventDistFootstepWalk"]["hidden"] = 38;
  var_1["ai_eventDistFootstepSprint"]["spotted"] = 300;
  var_1["ai_eventDistFootstepSprint"]["hidden"] = 200;
  var_1["ai_eventDistGunShot"]["spotted"] = 1536;
  var_1["ai_eventDistGunShot"]["hidden"] = 1536;
  var_1["ai_eventDistSilencedShot"]["spotted"] = 96;
  var_1["ai_eventDistSilencedShot"]["hidden"] = 96;
  var_1["ai_eventDistGunShotTeam"]["spotted"] = 535;
  var_1["ai_eventDistGunShotTeam"]["hidden"] = 535;
  var_1["ai_eventDistNewEnemy"]["spotted"] = 96;
  var_1["ai_eventDistNewEnemy"]["hidden"] = 96;
  _id_0F23::_id_F395(var_1);
  _id_0F23::_id_6806("hidden");
}

_id_13E2E() {
  level._id_13E40 = [];
  level._id_13E40["prone"] = 100;
  level._id_13E40["crouch"] = 200;
  level._id_13E40["stand"] = 275;
  level._id_13E47 = [];
  level._id_13E47["prone"] = 800;
  level._id_13E47["crouch"] = 1500;
  level._id_13E47["stand"] = 3000;
  _id_0F27::_id_F353(level._id_13E40, level._id_13E47);
  var_0 = [];
  var_0["sight_dist"] = 600;
  var_0["detect_dist"] = 300;
  var_0["found_dist"] = 100;
  _id_0F19::_id_F30E(var_0);
  var_1["ai_eventDistDeath"]["spotted"] = 384;
  var_1["ai_eventDistDeath"]["hidden"] = 384;
  var_1["ai_eventDistPain"]["spotted"] = 192;
  var_1["ai_eventDistPain"]["hidden"] = 192;
  var_1["ai_eventDistExplosion"]["spotted"] = 1536;
  var_1["ai_eventDistExplosion"]["hidden"] = 1536;
  var_1["ai_eventDistBullet"]["spotted"] = 48;
  var_1["ai_eventDistBullet"]["hidden"] = 48;
  var_1["ai_eventDistFootstep"]["spotted"] = 150;
  var_1["ai_eventDistFootstep"]["hidden"] = 75;
  var_1["ai_eventDistFootstepWalk"]["spotted"] = 75;
  var_1["ai_eventDistFootstepWalk"]["hidden"] = 38;
  var_1["ai_eventDistFootstepSprint"]["spotted"] = 300;
  var_1["ai_eventDistFootstepSprint"]["hidden"] = 200;
  var_1["ai_eventDistGunShot"]["spotted"] = 1536;
  var_1["ai_eventDistGunShot"]["hidden"] = 1536;
  var_1["ai_eventDistSilencedShot"]["spotted"] = 96;
  var_1["ai_eventDistSilencedShot"]["hidden"] = 96;
  var_1["ai_eventDistGunShotTeam"]["spotted"] = 535;
  var_1["ai_eventDistGunShotTeam"]["hidden"] = 535;
  var_1["ai_eventDistNewEnemy"]["spotted"] = 96;
  var_1["ai_eventDistNewEnemy"]["hidden"] = 96;
  _id_0F23::_id_F395(var_1);
  _id_0F23::_id_6806("hidden");
}

_id_8E36() {
  _id_0F27::_id_57C7();
  _id_8E38();

  if(!scripts\engine\utility::flag("stealth_spotted"))
    _id_0F18::_id_10E8B("hidden");
}

_id_8E38() {
  _id_0F27::_id_F5B4("hidden", ::_id_8E35);
  _id_0F27::_id_F5B4("spotted", ::_id_8E37);
}

_id_8E35() {
  var_0 = "stealth_spotted";
  level endon(var_0);
  self endon("stop_friendly_follow_stealth_logic");
  self._id_73F4 = 1;
  self.grenadeammo = 0;
  self.ignoreme = 1;
  self.ignoreall = 0;
  self._id_10E6D._id_931F = 1;
  self.maxvisibledist = 130;
  self.maxsightdistsqrd = squared(230);
  self.pathenemyfightdist = 200;
  self.dontevershoot = 1;
  var_1 = 1.5;
  scripts\sp\utility::_id_28D7("allies");

  for(;;) {
    if(!isDefined(self.enemy)) {
      wait 0.05;
      continue;
    }

    var_2 = self.enemy;

    if(_id_73E4(var_2)) {
      if(!scripts\engine\utility::flag(var_0))
        wait(var_1);

      _id_73DE(var_2);
    }

    wait 0.05;
  }
}

_id_8E37() {
  var_0 = undefined;

  if(isDefined(self._id_A906))
    var_0 = self._id_A906;
  else if(isDefined(self._id_A905))
    var_0 = self._id_A905;

  if(!isDefined(var_0))
    self._id_E45C = var_0;

  self notify("stop_going_to_node");
  _id_10FD9();
  self.dontevershoot = undefined;
  self.ignoreme = 0;
  self.ignoreall = 0;
  self._id_2894 = 0.75;
}

_id_73E4(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(!isalive(var_0))
    return 0;

  if(isDefined(var_0.ignoreme) && var_0.ignoreme == 1)
    return 0;

  var_1 = 200;
  var_2 = 850;
  var_3 = distance(self.origin, var_0.origin);
  var_3 = int(var_3);

  if(_id_9BCE(var_0) && var_3 <= var_2)
    return 1;

  if(isDefined(var_0._id_10E6D) && var_0._id_10E6D.state > 0)
    return 1;

  if(var_3 > var_1)
    return 0;

  if(isDefined(var_0._id_10E6D) && var_0._id_10E6D.state == 0 && !isDefined(var_0._id_6592))
    return 0;

  if(_id_10A5C(var_0.origin))
    return 0;

  var_4 = undefined;

  if(!isDefined(var_4))
    return 1;

  if(isDefined(var_4) && _id_D283(var_4))
    return 1;
  else
    return 0;
}

_id_9BCE(var_0) {
  if(var_0 scripts\sp\utility::_id_65DF("stealth_attack") && var_0 scripts\sp\utility::_id_65DB("stealth_attack"))
    return 1;
  else
    return 0;
}

_id_10A5C(var_0, var_1) {
  self endon("death");

  if(!isDefined(var_1))
    var_1 = 70;

  var_2 = abs(self.origin[2] - var_0[2]);

  if(var_2 > var_1)
    return 1;

  return 0;
}

_id_D283(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(!scripts\sp\utility::_id_CFAC(var_2))
      return 0;
  }

  return 1;
}

_id_73DE(var_0) {
  var_1 = "stealth_spotted";

  if(isDefined(self._id_11707)) {
    return;
  }
  if(!isalive(var_0)) {
    return;
  }
  self._id_11707 = 1;
  var_2 = self._id_2894;
  self._id_CA15 = 1;
  self._id_2894 = self._id_2894 * 10;
  self.dontevershoot = undefined;

  if(isalive(var_0))
    _id_73CF(var_0);

  self._id_2894 = var_2;
  self._id_CA15 = 0;
  self.dontevershoot = 1;
  self._id_11707 = undefined;
  thread _id_8406();
}

_id_8406() {
  if(isDefined(self.node)) {
    self _meth_82EE(self.node);
    return;
  } else if(isDefined(self._id_73B5)) {
    self setgoalpos(self._id_73B5);
    return;
  }

  var_0 = undefined;

  if(isDefined(self._id_A906))
    var_0 = self._id_A906;
  else if(isDefined(self._id_A905))
    var_0 = self._id_A905;

  if(!isDefined(var_0)) {
    return;
  }
  self _meth_82EE(var_0);
}

_id_73CF(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0._id_5951 = undefined;
  thread _id_73F9(var_0);
  var_0 thread _id_992C(self);
  var_0 scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "death");
  scripts\sp\utility::_id_178D(scripts\sp\utility::timeout, 5);
  scripts\sp\utility::_id_57D6();

  if(!isalive(var_0)) {
    return;
  }
  self notify("stop_chasing_enemy");
  return;
}

_id_73F9(var_0) {
  var_0 endon("death");
  self endon("stop_chasing_enemy");
  var_1 = 800;

  while(isalive(var_0)) {
    if(!self cansee(var_0)) {
      var_2 = distance(self.origin, var_0.origin);

      if(var_2 <= var_1)
        self setgoalpos(var_0.origin);
    } else
      self setgoalpos(self.origin);

    wait 0.25;
  }
}

_id_992C(var_0) {
  for(;;) {
    self waittill("damage", var_1, var_2);

    if(var_2 == var_0)
      scripts\sp\utility::_id_54C6();
  }
}

_id_10180() {
  foreach(var_1 in getaiarray("allies")) {
    if(isDefined(var_1._id_73F4))
      var_1 _id_10FD9();
  }
}

_id_10FD9() {
  self notify("stop_friendly_follow_stealth_logic");
  self._id_73F4 = undefined;
  self.maxsightdistsqrd = 67108864;
  self.maxsightdistsqrd = squared(8192);
  scripts\sp\utility::_id_F340();
}

_id_D5FC(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = getEntArray(var_0, "targetname");

  foreach(var_9 in var_7) {
    if(isDefined(var_9) && isDefined(var_9.script_noteworthy)) {
      var_10 = var_9.script_noteworthy;

      switch (var_10) {
        case "door_open_right":
          var_5 = var_9;
          break;
        case "door_open_left":
          var_4 = var_9;
          break;
        case "door_closed":
          var_6 = var_9;
          break;
      }
    }
  }

  if(var_1 == "open") {
    scripts\engine\utility::array_thread(var_7, ::_id_F595);

    if(var_2 == "unlock")
      wait 1;
  }

  if(var_1 == "open") {
    foreach(var_9 in var_7) {
      if(isDefined(var_9.script_noteworthy) && var_9.script_noteworthy == "left") {
        var_13 = var_9 scripts\sp\utility::_id_7A8E();
        var_13 linkTo(var_9);
        var_9 moveTo(var_4.origin, 1, 0);
        var_13 connectpaths();
        continue;
      }

      if(isDefined(var_9.script_noteworthy) && var_9.script_noteworthy == "right") {
        var_13 = var_9 scripts\sp\utility::_id_7A8E();
        var_13 linkTo(var_9);
        var_9 moveTo(var_5.origin, 1, 0);
        var_13 connectpaths();
      }
    }

    if(isDefined(var_3)) {
      var_7[0] thread scripts\sp\utility::play_sound_on_entity(var_3);
      return;
    }
  } else if(var_1 == "close") {
    foreach(var_9 in var_7) {
      if(isDefined(var_9.script_noteworthy) && var_9.script_noteworthy == "left") {
        var_13 = var_9 scripts\sp\utility::_id_7A8E();
        var_13 linkTo(var_9);
        var_9 moveTo(var_6.origin, 1, 0);
        var_13 scripts\engine\utility::delaycall(1, ::disconnectpaths);
        continue;
      }

      if(isDefined(var_9.script_noteworthy) && var_9.script_noteworthy == "right") {
        var_13 = var_9 scripts\sp\utility::_id_7A8E();
        var_13 linkTo(var_9);
        var_9 moveTo(var_6.origin, 1, 0);
        var_13 scripts\engine\utility::delaycall(1, ::disconnectpaths);
      }
    }

    if(isDefined(var_3))
      var_7[0] thread scripts\sp\utility::play_sound_on_entity(var_3);

    if(var_2 == "locked") {
      wait 2;
      scripts\engine\utility::array_thread(var_7, ::_id_F594);
    }
  }
}

_id_F595() {
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "right" || self.model == "sdf_door_airlock_01") {
    if(scripts\sp\utility::hastag(self.model, "tag_screen_locked"))
      self hidepart("tag_screen_locked", self.model);

    if(scripts\sp\utility::hastag(self.model, "tag_screen_restricted"))
      self hidepart("tag_screen_restricted", self.model);

    if(scripts\sp\utility::hastag(self.model, "tag_screen_open"))
      self showpart("tag_screen_open", self.model);
  }
}

_id_F594() {
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "right" || self.model == "sdf_door_airlock_01") {
    if(scripts\sp\utility::hastag(self.model, "tag_screen_locked"))
      self showpart("tag_screen_locked", self.model);

    if(scripts\sp\utility::hastag(self.model, "tag_screen_open"))
      self hidepart("tag_screen_open", self.model);

    if(scripts\sp\utility::hastag(self.model, "tag_screen_restricted"))
      self hidepart("tag_screen_restricted", self.model);
  }
}

_id_D08D(var_0, var_1, var_2) {
  self endon("stop_trying_gesture");
  thread scripts\sp\utility::_id_C12D("stop_trying_gesture", var_0);

  for(;;) {
    var_3 = scripts\sp\utility::_id_D08C(var_1, var_2);

    if(var_3)
      return 1;
    else
      wait 0.15;
  }
}

_id_B399(var_0) {
  if(isnode(var_0)) {
    scripts\sp\utility::_id_1160F(var_0);
    return;
  } else if(isent(var_0)) {
    scripts\sp\utility::_id_11624(var_0);
    self setgoalpos(self.origin);
    return;
  } else if(isstruct(var_0)) {
    scripts\sp\utility::_id_11624(var_0);
    self setgoalpos(self.origin);
    return;
  }

  var_1 = undefined;
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");

  if(isDefined(var_1)) {
    self _meth_80F1(var_1.origin, var_1.angles);
    self setgoalpos(self.origin);
    return;
  }

  var_1 = getnode(var_0, "targetname");

  if(isDefined(var_1)) {
    scripts\sp\utility::_id_1160F(var_1);
    self setgoalpos(self.origin);
    return;
  }

  var_1 = getEnt(var_0, "targetname");

  if(isDefined(var_1)) {
    scripts\sp\utility::_id_11624(var_1);
    self setgoalpos(self.origin);
  }
}

_id_6E55(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  scripts\engine\utility::flag_wait(var_0);

  if(isDefined(var_9))
    self[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  else {
    if(isDefined(var_8)) {
      self[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);
      return;
    }

    if(isDefined(var_7)) {
      self[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7);
      return;
    }

    if(isDefined(var_6)) {
      self[[var_1]](var_2, var_3, var_4, var_5, var_6);
      return;
    }

    if(isDefined(var_5)) {
      self[[var_1]](var_2, var_3, var_4, var_5);
      return;
    }

    if(isDefined(var_4)) {
      self[[var_1]](var_2, var_3, var_4);
      return;
    }

    if(isDefined(var_3)) {
      self[[var_1]](var_2, var_3);
      return;
    }

    if(isDefined(var_2)) {
      self[[var_1]](var_2);
      return;
      return;
    }

    self[[var_1]]();
  }
}

_id_127B4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  scripts\sp\utility::_id_127B3(var_0);

  if(isDefined(var_9))
    self[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  else {
    if(isDefined(var_8)) {
      self[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);
      return;
    }

    if(isDefined(var_7)) {
      self[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7);
      return;
    }

    if(isDefined(var_6)) {
      self[[var_1]](var_2, var_3, var_4, var_5, var_6);
      return;
    }

    if(isDefined(var_5)) {
      self[[var_1]](var_2, var_3, var_4, var_5);
      return;
    }

    if(isDefined(var_4)) {
      self[[var_1]](var_2, var_3, var_4);
      return;
    }

    if(isDefined(var_3)) {
      self[[var_1]](var_2, var_3);
      return;
    }

    if(isDefined(var_2)) {
      self[[var_1]](var_2);
      return;
      return;
    }

    self[[var_1]]();
  }
}

_id_C152(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_6)) {
    foreach(var_8 in var_6)
    self endon(var_8);
  }

  self waittill(var_0);

  if(isDefined(var_5))
    self[[var_1]](var_2, var_3, var_4, var_5);
  else {
    if(isDefined(var_4)) {
      self[[var_1]](var_2, var_3, var_4);
      return;
    }

    if(isDefined(var_3)) {
      self[[var_1]](var_2, var_3);
      return;
    }

    if(isDefined(var_2)) {
      self[[var_1]](var_2);
      return;
      return;
    }

    self[[var_1]]();
  }
}

_id_137BA(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3) && !scripts\engine\utility::flag_exist(var_3))
    scripts\engine\utility::flag_init(var_3);

  if(!isDefined(var_2))
    var_2 = 0;

  var_4 = getnotetracktimes(var_0, var_1)[0];
  var_5 = var_4 * getanimlength(var_0) + var_2;
  wait(var_5);

  if(isDefined(var_3))
    scripts\engine\utility::flag_set(var_3);
}

_id_22B4(var_0, var_1, var_2) {
  var_3 = [];
  var_0 = _id_2289(var_0);
  var_4 = _id_2289(var_1);

  if(var_4.size == 0)
    return var_0;

  foreach(var_11, var_6 in var_0) {
    var_7 = 0;

    foreach(var_9 in var_4) {
      if(var_9 == var_11) {
        var_7 = 1;
        break;
      }
    }

    if(var_7) {
      continue;
    }
    var_3[var_11] = var_6;
  }

  return var_3;
}

_id_2289(var_0) {
  return scripts\engine\utility::ter_op(isarray(var_0), var_0, [var_0]);
}

_id_229A(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = 1;

  foreach(var_5 in var_0) {
    if(isDefined(var_5._id_EE52)) {
      var_1[var_5._id_EE52] = var_5;
      continue;
    }

    var_1["NONAME" + scripts\sp\utility::string(var_3)] = var_5;
    var_3++;
  }

  return var_1;
}

_id_2281(var_0) {
  var_1 = undefined;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_2 == 0) {
      var_1 = var_0[0];
      continue;
    }

    var_1 = scripts\engine\utility::array_combine(var_1, var_0[var_2]);
  }

  return var_1;
}

_id_10641(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "targetname");
  var_2 = getEntArray("hero_spawners", "targetname");

  foreach(var_4 in var_1) {
    if(var_4.script_noteworthy == "player") {
      scripts\sp\utility::_id_11633(var_4);
      continue;
    }

    foreach(var_6 in var_2) {
      if(var_6.script_noteworthy == var_4.script_noteworthy) {
        var_7 = var_6 _id_10731();
        var_7 _meth_80F1(var_4.origin, var_4.angles);
        var_7 setgoalpos(var_7.origin);
      }
    }
  }
}

_id_10731() {
  if(!isDefined(level.allies))
    level.allies = [];

  var_0 = self.script_noteworthy;
  var_1 = scripts\sp\utility::_id_10619(1, 1);
  var_1._id_1FBB = var_0;
  var_1.name = var_0;
  level.allies[var_0] = var_1;
  return var_1;
}

_id_59B0(var_0, var_1, var_2, var_3, var_4) {
  setdvarifuninitialized("test_prefix", 0);
  var_5 = undefined;
  var_6 = getEntArray(var_0, "targetname");

  if(!var_6.size) {
    var_7 = scripts\engine\utility::getStruct(var_0, "targetname");

    if(getdvarint("test_prefix")) {
      var_6 = getEntArray(var_7.target, "targetname");
      var_5 = getEntArray("top", "script_noteworthy");
    } else
      var_6 = var_7 scripts\sp\utility::_id_7A8F();
  }

  if(isDefined(var_3))
    var_6[0] thread scripts\sp\utility::play_sound_on_entity(var_3);

  var_8 = 1;
  var_9 = 0.5;

  if(isDefined(var_4)) {
    var_8 = var_4;
    var_9 = 0;
  }

  var_1 = tolower(var_1);

  foreach(var_11 in var_6) {
    var_12 = var_2;

    if(isDefined(var_11.script_noteworthy)) {
      if(var_11.script_noteworthy == "left" || var_11.script_noteworthy == "bottom")
        var_12 = var_2 * -1;
    }

    switch (var_1) {
      case "x":
        var_11 movex(var_12, var_8, 0, var_9);
        break;
      case "y":
        var_11 movey(var_12, var_8, 0, var_9);
        break;
      case "z":
        var_11 movez(var_12, var_8, 0, var_9);
        break;
    }
  }

  var_6[0] waittill("movedone");
  scripts\engine\utility::array_thread(var_6, ::_id_59B1);
}

_id_59B1() {
  if(!isDefined(self.script_parameters))
    self connectpaths();
}

_id_11685(var_0, var_1, var_2) {
  if(getdvarint("loc_warnings", 0)) {
    return;
  }
  if(!isDefined(level._id_545A))
    level._id_545A = [];

  var_3 = 0;

  for(;;) {
    if(!isDefined(level._id_545A[var_3])) {
      break;
    }

    var_3++;
  }

  var_4 = "^3";

  if(!isDefined(var_2))
    var_2 = 1;

  var_2 = max(1, var_2);
  level._id_545A[var_3] = 1;
  var_5 = scripts\sp\hud_util::createfontstring("default", 1.5);
  var_5.location = 0;
  var_5.alignx = "left";
  var_5.aligny = "top";
  var_5.foreground = 1;
  var_5.sort = 20;
  var_5.alpha = 0;
  var_5 fadeovertime(0.5);
  var_5.alpha = 1;
  var_5.x = 40;
  var_5.y = 260 + var_3 * 18;
  var_5.label = " " + var_4 + "< " + var_0 + " > ^7" + var_1;
  var_5.color = (1, 1, 1);
  wait(var_2);
  var_6 = 10.0;
  var_5 fadeovertime(0.5);
  var_5.alpha = 0;

  for(var_7 = 0; var_7 < var_6; var_7++) {
    var_5.color = (1, 1, 0 / (var_6 - var_7));
    wait 0.05;
  }

  wait 0.25;
  var_5 destroy();
  level._id_545A[var_3] = undefined;
}

_id_40BB(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_2 = scripts\engine\utility::getStructArray("robot_security_station", "script_noteworthy");
  var_3 = undefined;

  foreach(var_5 in var_2) {
    if(ispointinvolume(var_5.origin, var_1))
      var_3 = var_5;
  }

  if(!isDefined(var_3)) {
    return;
  }
  var_7 = getEntArray(var_3.target, "targetname");
  scripts\sp\utility::_id_228A(var_7);
}

_id_1723(var_0, var_1, var_2, var_3) {
  if(!scripts\sp\utility::_id_C268(var_0))
    objective_add(scripts\sp\utility::_id_C264(var_0), var_1, var_2);
}

_id_13E43() {
  scripts\engine\utility::flag_wait("yard_start_objectives");
  _id_1723("obj_yard_main", "current", &"YARD_OBJ_TARGET");
  _id_1723("obj_stop_ambush", "current", &"YARD_OBJ_AMBUSH");
  scripts\engine\utility::flag_wait("yard_obj_ambush_done");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("obj_stop_ambush"));
  _id_1723("obj_locate_shipyard_command", "current", &"YARD_OBJ_LOCATE_COMMAND");
  scripts\engine\utility::flag_wait("yard_obj_locate_command_done");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("obj_locate_shipyard_command"));
  _id_1723("obj_activate_firing_controls", "current", &"YARD_OBJ_CONTROLS");
  scripts\engine\utility::flag_wait("yard_obj_activate_controls_done");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("obj_activate_firing_controls"));
  _id_1723("obj_hack_ethan", "current", &"YARD_OBJ_HACK");
  scripts\engine\utility::flag_wait("yard_obj_hack_ethan_done");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("obj_hack_ethan"));
  _id_1723("obj_destroy_power_core", "current", &"YARD_OBJ_POWER_CORE");
  scripts\engine\utility::flag_wait("yard_obj_destroy_core_done");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("obj_destroy_power_core"));
}