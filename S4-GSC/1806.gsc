/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1806.gsc
*************************************************/

_id_2E64(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  var_0 thread _id_2E4B(self);
  var_0._id_F1D3 = gettime();
  var_0._id_476E = ::_id_2E4A;
  _id_2E42(var_0);
  thread _id_2E67();
  thread _id_2E66();
  var_0 thread scripts\cp\cp_weapon::_id_9ED2();
  var_0 thread _id_2E55();
  var_0 thread c4_destroyonnotify();
  var_0 waittill("missile_stuck");
  thread scripts\cp\cp_weapon::_id_A105(self, var_0);
  var_0 thread _id_0728::_id_99EF("tag_use", 1);
  scripts\cp\cp_weapon::_id_AB22(var_0, undefined, 1);
  var_0 setscriptablepartstate("effects", "plant", 0);
}

_id_2E4F() {
  self endon("death");
  self.owner endon("disconnect");
  wait 0.1;
  thread _id_2E54(self.owner);
}

_id_2E54(var_0) {
  thread _id_2E4A(5);
  level notify("grenade_exploded_during_stealth", self, "c4_mp_p", var_0.name);
  self setentityowner(var_0);
  self setscriptablepartstate("effects", "explode", 0);
}

_id_2E4C(var_0) {
  thread _id_2E4A(2);
  self setscriptablepartstate("effects", "destroy", 0);
}

_id_2E4A(var_0) {
  level endon("game_ended");
  self notify("death");
  level._id_9EE2[self getentitynumber()] = undefined;
  _id_078F::_id_D593(self._id_75F3);
  self._id_75F3 = undefined;
  self._id_57CE = 1;
  var_1 = self.owner;

  if(isDefined(self.owner)) {
    var_1._id_B1CE = scripts\engine\utility::array_remove(var_1._id_B1CE, self);
    var_1 notify("c4_update", 0);
  }

  self makeunusable();

  if(isDefined(var_0)) {
    wait(var_0);
  }

  if(isDefined(self)) {
    self delete();
  }
}

_id_2E55() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  var_0 = self.owner;
  self waittill("detonateExplosive", var_1);

  if(isDefined(var_1)) {
    thread _id_2E54(var_1);
  } else {
    thread _id_2E54(var_0);
  }
}

c4_destroyonnotify() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  var_0 = self.owner;
  self waittill("destroyExplosive");
  thread _id_2E4C(var_0);
}

_id_2E4D() {
  self endon("death");
  self.owner endon("disconnect");
  self waittill("emp_damage", var_0, var_1);

  if(isDefined(self.owner) && var_0 != self.owner) {
    var_0 notify("destroyed_equipment");
  }

  thread _id_2E4C();
}

_id_2E65() {
  if(!isalive(self)) {
    return 0;
  }

  if(scripts\cp\utility::_id_8ACE()) {
    return 0;
  }

  if(!isDefined(self._id_2E72) || self._id_2E72.size <= 0) {
    return 0;
  }

  return 1;
}

_id_2E48(var_0) {
  return (gettime() - self._id_F1D3) / 1000 > 0.3 && !isDefined(self._id_48D1);
}

_id_2E67() {
  self endon("death");
  self endon("disconnect");
  self endon("c4_unset");
  level endon("game_ended");
  self notify("watchForDetonation");
  self endon("watchForDetonation");
  var_0 = makeweapon("s4_c4_zm");

  for(;;) {
    self waittillmatch("detonate", var_0);
    thread _id_2E50();
  }
}

_id_2E66() {
  self endon("death");
  self endon("disconnect");
  self endon("c4_unset");
  level endon("game_ended");
  self notify("watchForAltDetonation");
  self endon("watchForAltDetonation");

  while(self useButtonPressed()) {
    waitframe();
  }

  var_0 = 0;
  var_1 = level._id_5F3A;

  for(;;) {
    if(self useButtonPressed()) {
      var_0 = 0;

      while(self useButtonPressed()) {
        var_0 = var_0 + var_1;
        wait(var_1);
      }

      if(var_0 >= 0.5) {
        continue;
      }
      var_0 = 0;

      while(!self useButtonPressed() && var_0 < 0.25) {
        var_0 = var_0 + var_1;
        wait(var_1);
      }

      if(var_0 >= 0.25) {
        continue;
      }
      if(_id_2E65()) {
        thread _id_2E43();
        wait 1.26;
        thread _id_2E50();
      }
    }

    waitframe();
  }
}

_id_2E43() {
  var_0 = makeweapon("s4_eq_gesture_detonate_mp");
  self _meth_852A(var_0);
  thread _id_2E44();
}

_id_2E44() {
  self endon("death_or_disconnect");
  self notify("c4_animDetonateCleanup()");
  self endon("c4_animDetonateCleanup()");
  var_0 = makeweapon("s4_eq_gesture_detonate_mp");
  wait 1;

  if(self hasweapon(var_0)) {
    self takeweapon(var_0);
  }
}

_id_2E50() {
  if(isDefined(self._id_2E72)) {
    foreach(var_1 in self._id_2E72) {
      if(var_1 _id_2E48()) {
        var_1 thread _id_2E4F();
      }
    }
  }

  var_3 = _id_0728::_id_69A4("primary");
  var_4 = _id_0728::_id_6A15("primary");

  if(isDefined(var_3) && var_3 == "equip_c4" && isDefined(var_4) && var_4 == 0) {
    _id_0728::_id_EDBD("primary");
  }
}

_id_2E42(var_0) {
  if(!isDefined(self._id_2E72)) {
    self._id_2E72 = [];
  }

  self._id_2E72[var_0 getentitynumber()] = var_0;
  self _meth_883C(1);
  thread _id_2E5D(var_0);
}

_id_2E5C(var_0) {
  if(!isDefined(self._id_2E72)) {
    return;
  }
  self._id_2E72[var_0] = undefined;

  foreach(var_2 in self._id_2E72) {
    if(isDefined(var_2)) {
      return;
    }
  }

  self _meth_883C(0);
}

_id_2E5D(var_0) {
  self endon("disconnect");
  var_1 = var_0 getentitynumber();
  var_0 waittill("death");
  _id_2E5C(var_1);
}

_id_2E4B(var_0) {
  self endon("death");
  self endon("missile_stuck");
  var_0 waittill("disconnect");
  self delete();
}