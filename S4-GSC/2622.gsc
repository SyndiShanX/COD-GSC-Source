/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2622.gsc
*************************************************/

_id_7EBF() {
  thread _id_0A46::init();
  thread _id_0A34::init();
  level._id_11ED["actor_s4_mp_guard_dog"]["setup_model_func"] = ::_id_D7C0;
  level._id_11ED["actor_s4_mp_attack_dog"]["setup_model_func"] = ::_id_D75D;
  level._id_11ED["actor_s4_mp_guard_dog_codmas"]["setup_model_func"] = ::_id_D7C0;
  level._id_11ED["actor_s4_mp_attack_dog_codmas"]["setup_model_func"] = ::_id_D75D;
}

_id_AA44(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self.isactive = 0;
  self._id_7552 = 0;
  var_1._id_8FFB = gettime();

  if(isPlayer(var_1) && isDefined(self.owner) && var_1 != self.owner) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "onKillstreakKilled")) {
      var_9 = self._id_4CEE;

      if(self._id_4CEE == "attack_dog") {
        var_9 = "attack_dogs";
      }

      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "onKillstreakKilled")]](self._id_4CEE, var_1, var_4, var_3, var_2, "destroyed_" + var_9);
    }
  }

  if(self._id_4CEE == "guard_dog") {
    level thread scripts\mp\battlechatter_mp::_id_F759(self.owner, "gdog_kia");
    level thread scripts\mp\battlechatter_mp::_id_F759(var_1, "gdog_ekia");
  } else if(!isDefined(self.retreat) || !self.retreat) {
    level thread scripts\mp\battlechatter_mp::_id_F759(self.owner, "adog_kia");
    level thread scripts\mp\battlechatter_mp::_id_F759(var_1, "adog_ekia");
  }

  if(isDefined(self._id_FE90)) {
    if(isDefined(self.owner)) {
      self._id_FE90 disableplayeruse(self.owner);
    }

    self._id_FE90 delete();
  }

  if(isDefined(self.spawndangerzone)) {
    _id_0817::_id_C51F(self.spawndangerzone);
    self.spawndangerzone = undefined;
  }

  _id_07F7::_id_AA46(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 0);
  _id_09EF::_id_4386();
  self notify("killanimscript");
}

_id_AA50(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(self._id_B859)) {}

  if(self._id_4CEE == "guard_dog" && isDefined(var_1) && isPlayer(var_1)) {
    if(var_1 == self.owner) {
      level thread scripts\mp\battlechatter_mp::_id_F759(self.owner, "gdog_selfdamage");
    } else if(var_1.team != self.owner.team) {
      level thread scripts\mp\battlechatter_mp::_id_F759(self.owner, "gdog_enmydamage");
    } else if(var_1.team == self.owner.team) {
      level thread scripts\mp\battlechatter_mp::_id_F759(self.owner, "gdog_allydamage");
    }
  }

  var_12 = var_2;

  if(isDefined(var_8) && var_8 == "head") {
    var_13 = 1.1;

    if(weaponclass(var_5) == "sniper") {
      var_13 = 1.7;
    }

    var_12 = int(var_12 * var_13);

    if(var_2 > 0 && var_12 <= 0) {
      var_12 = 1;
    }
  }

  if(weaponclass(var_5) == "rocketlauncher") {
    var_12 = int(var_12 * 1.5);
  }

  if(self.health - var_12 > 0) {
    _id_0B00::_id_AA9A(var_0, var_1, var_12, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }

  if(isPlayer(var_1)) {
    if(isDefined(self._id_1DFA) && self._id_1DFA != "attacking") {
      if(distancesquared(self.origin, var_1.origin) <= self._id_4CC7) {
        _id_0B00::_id_D55D(var_1);
      }
    }
  }

  _id_07F7::_id_457A(var_0, var_1, var_12, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11);
}

_id_B29C(var_0) {
  self endon("death");
  self _meth_827E("kstreak_dog_pain");
  self._id_B859 = 1;
  wait(var_0);
  self._id_B859 = 0;
}

_id_B3D7() {
  return !(scripts\cp_mp\utility\player_utility::isinvehicle(1) || self _meth_86B7() || self _meth_86B8() || self _meth_87AF());
}

_id_B5F9(var_0) {
  self endon("death_or_disconnect");

  if(_id_B3D7()) {
    thread _id_084C::dog_whistle(self);
    var_1 = _id_09B9::_id_EA01(var_0, makeweapon("s4_ks_gesture_dog_whistle_mp"));
    return var_1;
  }
}

_id_E119(var_0, var_1, var_2, var_3) {
  if(!(isDefined(var_0) && isDefined(var_1))) {
    var_4 = self[[level._id_6D4A]]();
    var_0 = var_4.origin;
    var_1 = var_4.angles;
  }

  self._id_E3D8 = "dog";
  var_5 = _id_07F7::_id_E32A(var_3, var_0, var_1);

  if(isDefined(var_2)) {
    _id_09EF::_id_D136(var_2.team, var_2);
    self _meth_8851(3, var_2.team);
  }

  var_5 _meth_86FE("killstreak");
  level notify("spawned_agent", self);
  _id_0B00::init();
  thread _id_0B00::main();
  self _meth_8390("Dogs");
  self takeallweapons();
  wait 0.1;
}

_id_D7C0(var_0) {
  self._id_189C = "dog";
  self._id_10691 = "unitednations";

  if(scripts\mp\utility\game::isholidayenabled(2)) {
    self setModel("c_s4_doberman_04");
    self _meth_8352("c_s4_ger_shepherd_04");
  } else {
    self setModel("c_s4_doberman_03");
    self _meth_8352("c_s4_ger_shepherd_03");
  }
}

_id_D75D(var_0) {
  self._id_189C = "dog";
  self._id_10691 = "unitednations";

  if(scripts\mp\utility\game::isholidayenabled(2)) {
    self setModel("c_s4_doberman_05");
    self _meth_8352("c_s4_ger_shepherd_05");
  } else {
    self setModel("c_s4_doberman_01");
    self _meth_8352("c_s4_ger_shepherd_01");
  }
}

_id_B3D5(var_0, var_1) {
  if(getdvarint("#x3c4e971a832d9c06f", 1) == 0 && var_0 == "guard_dog") {
    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/UNAVAILABLE");
    return 0;
  }

  if(getdvarint("#x3edef8e16b143e351", 1) == 0 && var_0 == "attack_dog") {
    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/UNAVAILABLE");
    return 0;
  }

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_1)) {
      return 0;
    }
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_1)) {
      return 0;
    }
  }

  if(_id_652D(var_0)) {
    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/ALREADY_HAVE_DOGS");
    return 0;
  }

  if(_id_09EF::_id_6BAB(var_0) >= 3) {
    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/TOO_MANY_DOGS");
    return 0;
  }

  if(_id_09EF::_id_6BB4(self) >= 4) {
    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/AGENT_MAX");
    return 0;
  }

  var_2 = _func_00AE();

  if(_id_09EF::_id_6BAB() >= var_2) {
    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/UNAVAILABLE");
    return 0;
  }

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return 0;
  }

  return 1;
}

_id_D1E1(var_0, var_1) {
  if(!isDefined(self._id_4CDD)) {
    self._id_4CDD = [];
  }

  self._id_4CDD[var_0] = var_1;
}

_id_652D(var_0) {
  if(!isDefined(self._id_4CDD)) {
    return 0;
  }

  if(!isDefined(self._id_4CDD[var_0])) {
    return 0;
  }

  return self._id_4CDD[var_0];
}