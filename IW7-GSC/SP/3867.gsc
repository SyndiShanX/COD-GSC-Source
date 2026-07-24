/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3867.gsc
**************************************/

main() {
  _id_9732();
  scripts\sp\utility::_id_65E0("stealth_enabled");
  scripts\sp\utility::_id_65E1("stealth_enabled");
  scripts\sp\utility::_id_65E0("stealth_override_goal");
  scripts\sp\utility::_id_65E0("stealth_hold_position");
  scripts\sp\utility::_id_65E0("stealth_attack");
  scripts\sp\utility::_id_65E0("stealth_cover_blown");
  _id_0F27::_id_868B("stealth_spotted");
  _id_0F27::_id_868B("stealth_cover_blown");
  _id_0F27::_id_8682();
  self._id_10E6D.beginusegas = "patrol";
  self._id_527B = "patrol";
  scripts\asm\asm_bb::_id_2980("patrol", "unaware");
  _id_0F27::_id_F557(::_id_D7DD);
  _id_0F1C::_id_6854();
  thread _id_B960(128, 600);
  thread _id_10A9E();
  thread _id_4DFE();
  thread _id_3D64();
  thread _id_7346();

  if(isDefined(self.target)) {
    self.goalradius = 32;
    thread _id_0B77::_id_8409(undefined, undefined, undefined, undefined, undefined);
  }

  _id_F299("reset");
  self._id_10E6D._id_13529 = scripts\engine\utility::array_randomize(["sf1", "sf2", "sf3", "sf4"])[0];
}

_id_9732() {
  self._id_10E6D = spawnStruct();
  self._id_10E6D._id_74D5 = [];
  self._id_10E6D._id_B470 = 2;
  self.combatmemorytimerand = self.combatmode;
  self._id_10E6D._id_DD1D = 0;
  scripts\sp\utility::_id_F292("setdef");
  self.newenemyreactiondistsq = squared(level._id_10E6D._id_0021["ai_eventDistFootstepSprint"]["hidden"]);
  _id_0F19::_id_4682();
}

_id_10A9E() {
  self endon("death");

  for(;;) {
    scripts\sp\utility::_id_65E3("stealth_enabled");

    if(_id_0F27::_id_8689("stealth_spotted"))
      thread _id_10E20();

    _id_0F27::_id_868E("stealth_spotted");
    scripts\sp\utility::_id_65E3("stealth_enabled");
    thread _id_10E1B();
    scripts\sp\utility::_id_65E3("stealth_enabled");
    _id_0F27::_id_868D("stealth_spotted");
  }
}

_id_3D64() {
  self endon("death");

  while(!isDefined(self._id_10E6D._id_C9A8))
    wait 0.05;

  if(_id_0F27::_id_8689("stealth_cover_blown"))
    thread _id_1272D();
}

_id_4DFE() {
  self waittill("death");

  if(isDefined(self)) {
    _id_0F26::_id_117D4("death");

    if(isDefined(self.stealth_vo_ent)) {
      self.stealth_vo_ent stopsounds();
      scripts\engine\utility::waitframe();
      self.stealth_vo_ent delete();
      self.stealth_vo_ent = undefined;
    }
  }
}

_id_1645() {
  self notify("active_sense_thread");
  self endon("active_sense_thread");
  self endon("death");
  self endon("pain_death");

  for(;;) {
    scripts\sp\utility::_id_65E3("stealth_enabled");

    if(!_id_0F27::_id_869D()) {
      if(!scripts\sp\utility::_id_65DB("stealth_attack")) {
        _id_0F19::_id_468A();
        _id_DAB0();
      }
    }

    wait 0.1;
  }
}

_id_DAB0() {
  if(self.ignoreall) {
    return;
  }
  if(!isDefined(level._id_10E6D)) {
    return;
  }
  var_0 = self.origin;
  var_1 = (0, 0, 0);

  if(scripts\sp\utility::hastag(self.model, "j_spine4")) {
    var_0 = self gettagorigin("j_spine4");
    var_1 = (0, 0, 35);
  }

  foreach(var_3 in level.players) {
    var_4 = 0;

    if(!isalive(var_3)) {
      continue;
    }
    if(issentient(var_3) && (var_3.ignoreme || var_3.notarget)) {
      continue;
    }
    var_5 = distancesquared(var_0, var_3.origin + var_1);

    if(isDefined(level._id_10E6D._id_DAB2) && level._id_10E6D._id_DAB2 > 0) {
      var_6 = squared(level._id_10E6D._id_DAB2);

      if(var_5 < var_6)
        var_4 = 1;
    }

    if(!var_4 && isDefined(level._id_10E6D._id_DAB3) && level._id_10E6D._id_DAB3 > 0) {
      var_7 = squared(level._id_10E6D._id_DAB3);

      if(var_5 < var_7 && self cansee(var_3, 0))
        var_4 = 1;
    }

    if(var_4) {
      self _meth_84F7("proximity", var_3, var_3.origin);
      return;
    }
  }
}

_id_F2E0(var_0) {
  if(!isDefined(self._id_10E6D)) {
    return;
  }
  if(var_0 && self.alertlevelint <= 2) {
    self._id_10E6D._id_2B96 = 1;
    _id_F59D("blind");
  } else {
    self._id_10E6D._id_2B96 = undefined;

    if(self.alertlevelint > 2)
      _id_F59D("spotted");
    else
      _id_F59D("hidden");
  }
}

_id_F59D(var_0) {
  switch (var_0) {
    case "blind":
      _id_0F26::_id_117D4("hidden");
      self.fovcosine = 1.0;
      self.fovcosinebusy = 1.0;
      self.fovcosinez = 0;
      self.fovground = 0;
      break;
    case "hidden":
      if(_id_0F22::_id_9B2C())
        _id_0F26::_id_117D4("investigate");
      else
        _id_0F26::_id_117D4("hidden");

      self.fovcosine = 0.7;
      self.fovcosinebusy = 0.86;
      self.fovcosinez = 0.97;
      self.fovground = 1;
      break;
    case "spotted":
      _id_0F26::_id_117D4("spotted");
      self.fovcosine = 0.01;
      self.fovcosinez = 0;
      self.fovground = 0;
      break;
  }
}

_id_10E1B() {
  if(scripts\engine\utility::is_true(self._id_10E6D._id_2B96))
    _id_F59D("blind");
  else
    _id_F59D("hidden");

  self.favoriteenemy = undefined;
  self._id_5951 = 1;
  self.dontevershoot = 1;
  thread scripts\sp\utility::_id_F2DA(0);
  self._id_FED1 = undefined;
  self.combatmode = self.combatmemorytimerand;
  self._id_10E6D._id_DD1D = 0;
  thread _id_0F19::_id_467C();
  _id_0F27::_id_F4C9();

  if(!isDefined(self._id_10E6D._id_C3B5)) {
    self._id_10E6D._id_C3B5 = self.combatmode;
    self.combatmode = "no_cover";
  }

  foreach(var_1 in level.players) {
    if(!isDefined(var_1._id_10E6D)) {
      continue;
    }
    if(!isDefined(var_1._id_10E6D._id_10A9D)) {
      continue;
    }
    var_1._id_10E6D._id_10A9D[self.unique_id] = undefined;
  }

  _id_0F22::_id_9B25();
  thread _id_1645();
  self._id_10E6D.beginusegas = "patrol";
  self.diequietly = 1;
  self clearenemy();
  _id_F299("reset");
  _id_0F1C::_id_6839();
}

_id_10E20() {
  _id_F59D("spotted");
  self._id_5951 = undefined;
  self.dontevershoot = undefined;
  self.combatmode = self.combatmemorytimerand;
  self.diequietly = 0;
  thread scripts\sp\utility::_id_F2DA(1);
  _id_0F22::_id_9B25();

  if(isDefined(self._id_10E6D._id_C3B5)) {
    self.combatmode = self._id_10E6D._id_C3B5;
    self._id_10E6D._id_C3B5 = undefined;
  }

  self notify("active_sense_thread");
  var_0 = undefined;
  var_1 = self.origin;

  if(isDefined(level._id_10E6D.group._id_10A9B))
    var_0 = level._id_10E6D.group._id_10A9B[self._id_EED1];

  if(isDefined(var_0)) {
    var_1 = var_0.origin;
    self getenemyinfo(var_0);
  } else
    var_0 = undefined;

  self _meth_84F7("combat", var_0, var_1);
}

_id_7346() {
  self endon("death");

  for(;;) {
    self.fovforward = 0;
    scripts\sp\utility::_id_65E3("stealth_enabled");

    if(self.alertlevelint <= 2 && scripts\asm\asm::asm_isinstate("patrol_move"))
      self.fovforward = 1;

    wait 0.05;
  }
}

_id_1B3D(var_0) {
  thread _id_0F27::_id_1284A("hmph");
  _id_F299("reset");
  thread _id_10E1B();
  _id_0F27::_id_8468();
}

_id_F5C9() {
  self endon("death");
  self endon("pain_death");
  self.dontevershoot = undefined;
  self[[self._id_10E6D._id_D7DE]]();

  if(self.ignoreme) {
    return;
  }
  _id_0F22::_id_9B25();
  var_0 = self.enemy;

  if(isDefined(var_0)) {
    level._id_10E6D.group._id_10A9B[self._id_EED1] = var_0;

    if(isDefined(var_0._id_10E6D))
      var_0 _id_0F27::_id_868C("stealth_spotted");
  }

  _id_0F27::_id_868C("stealth_spotted");
}

_id_D7DD() {
  wait 2;
}

_id_F299(var_0) {
  if(!scripts\sp\utility::_id_65DB("stealth_enabled")) {
    return;
  }
  if(isDefined(self._id_1B44) && self._id_1B44 == var_0) {
    return;
  }
  self notify("set_alert_level");
  self endon("set_alert_level");
  self endon("death");

  if(var_0 == "attack" || var_0 == "combat")
    thread _id_F5C9();

  self._id_1B44 = var_0;

  while(isDefined(self.syncedmeleetarget))
    wait 0.05;

  _id_0F27::_id_F5B7(var_0);
  self notify("stealth_alertlevel_change", var_0);
  self.alertlevel = _id_0F27::_id_1B40(var_0);
  var_1 = self.alertlevelint > 2;
  _id_0F1C::_id_6837(!var_1);
  self.ignoreexplosionevents = !var_1;
}

_id_F345() {
  level _id_0F27::_id_F5B4("go_to_node_wait", ::_id_8415);
  level _id_0F27::_id_F5B4("go_to_node_arrive", ::_id_840C);
  level _id_0F27::_id_F5B4("reset", ::_id_1B3D);
  level _id_0F27::_id_F5B4("set_patrol_style", _id_0F27::_id_F4C8);
  level _id_0F27::_id_F5B4("trigger_cover_blown", ::_id_1272D);
  level _id_0F27::_id_F5B4("set_blind", ::_id_F2E0);
  level _id_0F27::_id_F5B4("investigate", ::_id_6847);
  level _id_0F27::_id_F5B4("cover_blown", ::_id_6847);
  level _id_0F27::_id_F5B4("combat", ::_id_6847);
}

_id_B960(var_0, var_1) {
  var_2 = undefined;
  var_3 = self.team;

  for(;;) {
    if(!isalive(self)) {
      return;
    }
    self waittill("damage", var_4, var_5, var_6, var_7);
    _id_3DAF(var_4, var_5, var_7);
    var_8 = self.origin;

    if(isalive(self) && !scripts\sp\utility::_id_65DB("stealth_enabled")) {
      continue;
    }
    if(isalive(var_5))
      var_2 = var_5;

    if(!isDefined(var_2)) {
      continue;
    }
    if(isPlayer(var_2) || isDefined(var_2.team) && var_2.team != var_3) {
      break;
    }

    if(isDefined(var_2.classname) && var_2.classname == "script_model") {
      if(var_2._id_9D62) {
        break;
      }
    }
  }

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_2) && var_2 == level.player && _id_0E29::_id_87A7() == "controllingrobot")
    var_2 setthreatbiasgroup();

  if(isDefined(self._id_10E6D._id_C813))
    var_0 = self._id_10E6D._id_C813;
  else if(isDefined(level._id_10E6D._id_C813))
    var_0 = level._id_10E6D._id_C813;

  if(isDefined(self._id_10E6D._id_C814))
    var_1 = self._id_10E6D._id_C814;
  else if(isDefined(level._id_10E6D._id_C814))
    var_1 = level._id_10E6D._id_C814;

  _id_0F1C::_id_67FF("attack", var_2, var_0, var_1);
}

_id_3DAF(var_0, var_1, var_2) {
  if(var_0 > 0 && self.damagemod != "MOD_MELEE" && self._id_1B44 != "attack" && self._id_1B44 != "combat") {
    var_3 = self getEye();

    if(distancesquared(var_2, var_3) < squared(20))
      self dodamage(self.health, var_2, var_1, var_1, "MOD_HEAD_SHOT");
  }
}

_id_6847(var_0) {
  var_0._id_9B22 = var_0.origin;

  if(isDefined(self.enemy) && isDefined(var_0.entity) && var_0.entity == self.enemy)
    var_0._id_9B22 = self lastknownpos(self.enemy);
  else if(isDefined(var_0.entity) && var_0._id_12AE9 == "bulletwhizby")
    var_0._id_9B22 = var_0.entity.origin;

  _id_6849(var_0);

  if(_id_6848(var_0)) {
    return;
  }
  self._id_10E6D._id_A908 = gettime();

  if(!_id_DD2D(var_0))
    _id_DD2C(var_0);

  switch (var_0.type) {
    case "investigate":
      thread _id_6859(var_0);
      break;
    case "cover_blown":
      thread _id_6810(var_0);
      break;
    case "combat":
      thread _id_6808(var_0);
      break;
  }

  var_1 = _id_0F18::_id_10EBB(var_0._id_12AE9);

  if(isDefined(var_1) && var_1 != ::_id_6847)
    self thread[[var_1]](var_0);
}

_id_6848(var_0) {
  var_1 = self._id_10E6D._id_6896;

  if(!isDefined(var_1))
    var_1 = level._id_10E6D._id_6896;

  if(isDefined(var_1)) {
    var_2 = _id_0F1C::_id_6894(var_1, var_0.type);

    if(var_2 > 0)
      return 1;
  }

  if(scripts\engine\utility::is_true(level._id_10E6D._id_5659) && _id_6872(var_0))
    return 1;

  if(isDefined(var_0.entity) && var_0.entity == level.player && _id_0E29::_id_87A7() == "controllingrobot" && _id_6871(var_0)) {
    self._id_10E6D._id_683A[var_0._id_12AE9] = 0;
    self._id_10E6D._id_683A[var_0.type] = 0;
    return 1;
  }

  var_3 = _id_0F18::_id_10EBB("event_" + var_0.type);

  if(isDefined(var_3))
    return _id_0F18::_id_10E8A("event_" + var_0.type, var_0);

  return 0;
}

_id_6872(var_0) {
  if(issentient(var_0.entity)) {
    switch (var_0._id_12AE9) {
      case "proximity":
      case "footstep_walk":
      case "footstep_sprint":
      case "footstep":
        thread _id_0F26::_id_117C5(var_0.entity, 1.0);
        return 1;
    }
  }

  return 0;
}

_id_6871(var_0) {
  if(issentient(var_0.entity)) {
    switch (var_0._id_12AE9) {
      case "proximity":
        return 1;
      case "silenced_shot":
      case "projectile_impact":
      case "gunshot":
      case "bulletwhizby":
      case "grenade danger":
      case "explode":
        var_0.type = "combat";
        return 0;
    }
  }

  if(var_0.type != "combat")
    return 1;

  return 0;
}

_id_6849(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0._id_12AE9)) {
    return;
  }
  switch (var_0._id_12AE9) {
    case "sight":
      if(isDefined(self._id_10E6D._id_117CA) && self._id_10E6D._id_117CA == 0)
        var_0.type = "combat";

      break;
  }
}

_id_6859(var_0) {
  _id_F299("warning1");
  thread _id_0F22::_id_9B23(var_0);
}

_id_6810(var_0) {
  _id_F299("warning2");

  if(scripts\engine\utility::is_true(level._id_10E6D._id_5659)) {
    switch (var_0._id_12AE9) {
      case "silenced_shot":
      case "gunshot":
      case "explode":
        _id_0F27::_id_F357(0);
        level scripts\engine\utility::delaythread(20, _id_0F27::_id_F357, 1);
        break;
    }
  }

  thread _id_0F22::_id_9B23(var_0);

  if(!_id_0F27::_id_8693()) {
    var_1 = _id_0F27::_id_1284A("backup_call", 4.0);

    if(isDefined(var_1) && var_1)
      _id_0F27::_id_4F6C("seek_backup", var_0._id_9B22, randomintrange(1, 2), 800);
  }
}

_id_6808(var_0) {
  self notify("investigate_behavior");
  self notify("stop_going_to_node");
  self notify("investigate_forget");

  if(isDefined(self._id_10E6D._id_92CC) && isDefined(self._id_4E2A))
    self._id_4E2A = undefined;

  self._id_10E6D.beginusegas = "combat";
  _id_F299("attack");

  if(issentient(var_0.entity) && !isDefined(self.enemy)) {
    self getenemyinfo(var_0.entity);
    _id_0F26::_id_117D4("spotted");
  }

  scripts\sp\utility::_id_65E1("stealth_attack");
  _id_0F27::_id_10EE4(1);
  _id_0F27::_id_F4C8("combat", 1, var_0._id_9B22);
}

_id_1272D(var_0) {
  self endon("death");
  var_1 = undefined;

  if(isDefined(var_0))
    var_1 = var_0.origin;

  if(!isDefined(self._id_10E6D)) {
    return;
  }
  if(scripts\sp\utility::_id_65DB("stealth_cover_blown")) {
    return;
  }
  scripts\sp\utility::_id_65E1("stealth_cover_blown");
  _id_0F27::_id_868C("stealth_cover_blown");
  var_2 = _id_0F27::_id_7B72();

  if(!isDefined(var_2) || var_2 == "unaware") {
    if(!isDefined(self._id_10E6D._id_C9A8) || self._id_10E6D._id_C9A8 == "unaware")
      _id_0F27::_id_F4C8("alert", isDefined(self._id_10E6D.beginusegas) && self._id_10E6D.beginusegas != "investigate", var_1);

    self._id_10E6D._id_500C = "alert";
  }
}

_id_DD2C(var_0) {
  self endon("death");
  var_1 = 0.1;

  switch (var_0.type) {
    case "investigate":
      thread _id_0F27::_id_1284A("warning1", var_1);
      return 1;
    case "cover_blown":
      thread _id_0F27::_id_1284A("warning2", var_1);
      return 1;
    case "combat":
      thread _id_0F27::_id_1284A("spotted", var_1);
      return 1;
  }

  return 0;
}

_id_DD2D(var_0) {
  self endon("death");

  if(isDefined(var_0._id_12AE9)) {
    var_1 = randomfloatrange(0.5, 1.0);

    switch (var_0._id_12AE9) {
      case "explode":
        thread _id_0F27::_id_1284A("explosion", var_1);
        return 1;
      case "seek_backup":
        thread _id_0F27::_id_1284A("acknowledgement", var_1);
        return 1;
      case "found_corpse":
      case "saw_corpse":
        thread _id_0F27::_id_1284A(var_0._id_12AE9, var_1);
        thread _id_0F27::_id_1698(["saw_corpse", "found_corpse"], var_1 + 0.05);
        return 1;
    }
  }

  return 0;
}

_id_8417(var_0, var_1, var_2) {
  self endon("death");

  if(!isDefined(var_2))
    var_2 = 1;

  var_3 = !var_2;

  while(_id_0F27::_id_10E82() || !var_3) {
    _id_0F27::_id_10E87();
    self[[var_0]](var_1);
    var_3 = 1;
    self waittill("goal");
  }
}

_id_8415(var_0, var_1) {
  self endon("death");
  _id_8417(var_0, var_1);

  if(isDefined(self._id_10E6D._id_92CC)) {
    _id_0F27::_id_413E();

    if(isDefined(self._id_10E6D._id_4C4F))
      _id_0F27::_id_CCD4(var_1, "gravity");
  }
}

_id_840C(var_0, var_1) {
  _id_8417(var_0, var_1, 0);

  if(isDefined(var_1._id_EE2C))
    self.moveplaybackrate = var_1._id_EE2C;

  if(isDefined(var_1.script_animation)) {
    if(scripts\engine\utility::is_true(var_1._id_ED88) && isDefined(var_1.angles))
      self orientmode("face angle", var_1.angles[1]);

    var_2 = var_1.script_animation;
    scripts\sp\anim::_id_1EC8(self, "gravity", var_2);
  } else if(isDefined(var_1._id_EDDE))
    self[[level._id_92DE[var_1._id_EDDE]]](var_1);

  if(isDefined(var_1.script_animation_exit))
    scripts\sp\anim::_id_1EC8(self, "gravity", var_1.script_animation_exit);
}