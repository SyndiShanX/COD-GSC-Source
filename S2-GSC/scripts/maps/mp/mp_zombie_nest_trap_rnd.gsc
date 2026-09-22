/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_trap_rnd.gsc
*******************************************************/

_id_9CC0(var_0) {
  var_1 = getEntArray(var_0.target, "targetname");
  level._id_9CC0 = var_1[0];
  level._id_9CC0._id_9C92 = var_0;
  level._id_9CC0._id_9CBB = var_0._id_0165;
  thread _id_0378::_id_8D74("aud_trap_elec_start");

  foreach(var_3 in var_1) {
    if(!isDefined(var_3._id_0165)) {
      continue;
    }
    if(var_3._id_0165 == "damage_over_time") {
      var_0 thread _id_9CC2(var_3);
      var_0 thread _id_9CC3(var_3);
      waitframe();
    }
  }

  thread _id_9CC1(var_0);
}

_id_9CC2(var_0) {
  self endon("cooldown");
  self endon("no_power");
  self endon("deactivate");
  self endon("ready");
  var_1 = 0;
  var_2 = 0.25;

  if(isDefined(self._id_817A)) {
    var_3 = self._id_817A;
  } else {
    var_3 = 20;
  }

  while(var_1 < var_3) {
    wait(var_2);
    var_1 = var_1 + var_2;

    foreach(var_5 in level.players) {
      if(!var_5 istouching(var_0)) {
        continue;
      }
      var_5 thread _id_35B1();
    }
  }
}

_id_9CC3(var_0) {
  self endon("cooldown");
  self endon("no_power");
  self endon("deactivate");
  self endon("ready");
  var_1 = 0;
  var_2 = 0.15;

  if(isDefined(self._id_817A)) {
    var_3 = self._id_817A;
  } else {
    var_3 = 20;
  }

  while(var_1 < var_3) {
    wait(var_2);
    var_1 = var_1 + var_2;
    var_4 = _id_0547::_id_408F();

    foreach(var_6 in var_4) {
      if(!isDefined(var_6) || !isalive(var_6)) {
        continue;
      }
      if(isPlayer(var_6)) {
        continue;
      }
      if(!var_6 istouching(var_0)) {
        continue;
      }
      maps\mp\mp_zombie_nest_ee_hc_raven_weapon_upgrades::_id_6FEE(var_6);
      var_6 _id_054D::_id_099B("electroBuff", var_6 _id_44B0(self._id_0117));
    }
  }
}

_id_9CC1(var_0) {
  for(;;) {
    var_0 waittill("trap_state_change", var_1);

    if(var_1 == "cooldown" || var_1 == "no_power" || var_1 == "deactivate") {}
  }
}

_id_44B0(var_0) {
  var_1 = _id_054D::_id_443F("electroBuff");

  if(!isDefined(var_1)) {
    var_1 = _id_9048();
  }

  if(isDefined(self._id_0A4B) && self._id_0A4B == "zombie_heavy") {
    var_1._id_29D5 = 600 * _id_054D::_id_4441();
  }

  var_1._id_5CC8 = 0.2;
  var_1.player = var_0;
  return var_1;
}

_id_9048() {
  var_0 = spawnStruct();
  var_0._id_1CF2 = ::_id_A10B;
  var_0._id_1CF0 = ::_id_7CD9;
  var_0._id_5CC8 = 0.2;
  var_0._id_29D5 = 60 * _id_054D::_id_4441();
  var_0._id_90F0 = 0.6;
  self notify("speed_debuffs_changed");
  return var_0;
}

_id_A10B(var_0) {
  if(_id_0547::_id_580A()) {
    self dodamage(var_0._id_29D5 * 0.25, self.origin, level._id_9CC0, level._id_9CC0, "MOD_ENERGY", "trap_zm_mp");
  } else {
    self dodamage(var_0._id_29D5, self.origin, level._id_9CC0, level._id_9CC0, "MOD_ENERGY", "trap_zm_mp");

    if(!isDefined(self.hitbytrap)) {
      foreach(var_2 in level.players) {
        var_2 maps\mp\gametypes\zombies::_id_47C7("kill_trap");
        self.hitbytrap = 1;
      }
    }
  }
}

_id_7CD9(var_0) {
  self notify("speed_debuffs_changed");
}

_id_35B1() {}