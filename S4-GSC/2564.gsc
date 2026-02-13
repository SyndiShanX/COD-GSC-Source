/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2564.gsc
*************************************************/

_id_2E60(var_0, var_1) {
  thread _id_2E66();
}

_id_2E64(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  scripts\mp\utility\print::_id_BD15("c4 spawn", var_0.owner);
  var_0._id_F1D3 = gettime();
  var_0 _id_078E::_id_C2B5(1, ::_id_EC12);
  _id_2E42(var_0.owner, var_0);
  thread _id_2E67();
  thread _id_2E66();

  if(scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp")) {
    var_0._id_75A8 = 1;
  }

  var_0 thread scripts\mp\weapons::_id_9ED2();
  var_0 thread _id_2E55();
  var_0 thread _id_2E4E();
  thread scripts\mp\weapons::_id_A106(self, var_0);
  var_0 waittill("missile_stuck");
  var_0 setotherent(self);
  var_0 setnodeploy(1);
  scripts\mp\weapons::_id_AACF(var_0, "equip_c4", ::_id_2E4A);
  thread scripts\mp\weapons::_id_A105(self, var_0);
  var_0 thread scripts\mp\weapons::_id_99EF("tag_use", 1);
  var_0 _id_0812::_id_C2B2("Lethal_Static", var_0.owner, 1);
  var_0 _id_078D::_id_D15E(::_id_2E52);
  var_0 thread _id_0A69::_id_CA34();
  thread scripts\mp\weapons::_id_ACD8(var_0);
  var_0 _meth_85B9();
  var_0 _meth_85BA();
  var_0._id_75F3 = var_0 _id_078F::_id_D594(0, 0, undefined, undefined, undefined, 0.1, 1);
  var_0 _id_2E62();
}

_id_2E62() {
  if(istrue(level._id_434D)) {
    return;
  }
  if(isDefined(self._id_4346)) {
    _id_0817::_id_C51F(self._id_4346);
  }

  var_0 = (self.origin[0], self.origin[1], self.origin[2] - 50.0);
  self._id_4346 = _id_0817::_id_1135(var_0, _id_0817::_id_69D4(), 100, self.owner.team, undefined, self.owner, 0, self, 1);
}

_id_2E4F(var_0) {
  self endon("death");
  self.owner endon("disconnect");

  if(isDefined(var_0)) {
    var_0 endon("disconnect");
  } else {
    var_0 = self.owner;
  }

  wait 0.1;
  thread _id_2E54(var_0);
}

_id_2E54(var_0) {
  scripts\mp\utility\print::_id_BD15("c4 triggered", self.owner);
  level notify("explosion_extinguish", self.origin, 256, self.owner, self);
  var_1 = undefined;
  var_2 = undefined;
  var_3 = self.origin;
  var_4 = scripts\engine\trace::_id_3EE5(0, 1, 1, 0, 1, 1, 0, 0, 0);
  var_5 = vectordot((0, 0, 1), anglestoup(self.angles));

  if(abs(var_5) <= 0.81915) {
    var_6 = var_3 - anglestoup(self.angles) * 5;
    var_7 = _func_02C1(var_3, var_6, var_4, self, 0, "physicsquery_closest", 1);

    if(isDefined(var_7) && var_7.size > 0) {
      var_1 = 5;
      var_2 = "explodeWall";
    }
  } else if(var_5 <= -0.96592) {
    var_6 = var_3 - anglestoup(self.angles) * 5;
    var_7 = _func_02C1(var_3, var_6, var_4, self, 0, "physicsquery_closest", 1);

    if(isDefined(var_7) && var_7.size > 0) {
      var_1 = 5;
      var_2 = "explodeWall";
    }
  }

  if(!isDefined(var_1)) {
    var_6 = var_3 - (0, 0, 20);
    var_7 = _func_02C1(var_3, var_6, var_4, self, 0, "physicsquery_closest", 1);

    if(!isDefined(var_7) || var_7.size <= 0) {
      var_1 = 5;
      var_2 = "explodeAir";
    }
  }

  if(!isDefined(var_1)) {
    var_1 = 5;
    var_2 = "explode";
  }

  thread _id_2E4A(var_1);
  self setentityowner(var_0);
  self _meth_85AE();
  self setscriptablepartstate("effects", var_2, 0);
}

_id_EC12() {
  thread _id_2E4A();
}

_id_2E4C(var_0) {
  thread _id_2E4A(5);
  self setscriptablepartstate("effects", "destroy", 0);
}

_id_2E4A(var_0) {
  self notify("death");
  level._id_9EE2[self getentitynumber()] = undefined;
  self setCanDamage(0);
  scripts\mp\weapons::_id_99EC();
  _id_078E::_id_4807();
  _id_078F::_id_D593(self._id_75F3);
  self._id_75F3 = undefined;
  self._id_57CE = 1;

  if(isDefined(self._id_4346)) {
    _id_0817::_id_C51F(self._id_4346);
    self._id_4346 = undefined;
  }

  var_1 = self.owner;

  if(isDefined(var_1)) {
    _id_2E5C(var_1, self, self getentitynumber());
    var_1 scripts\mp\weapons::_id_C498(self);
    var_1 notify("c4_update", 0);
  }

  thread _id_2E5F();

  if(isDefined(var_0)) {
    wait(var_0);
  }

  self delete();
}

_id_2E5F() {
  self endon("death");
  wait 0.5;
  var_0 = self _meth_8151();

  if(isDefined(var_0)) {
    var_0 waittill("death");
    self setscriptablepartstate("effects", "neutral", 0);
  }
}

_id_2E55() {
  self endon("death");
  level endon("game_ended");
  var_0 = self.owner;
  self waittill("detonateExplosive", var_1);

  if(isDefined(var_1)) {
    thread _id_2E54(var_1);
  } else {
    thread _id_2E54(var_0);
  }
}

_id_2E52(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;

  if(istrue(scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_1))) {
    var_1 notify("destroyed_equipment");
    var_1 scripts\mp\killstreaks\killstreaks::_id_6FEA(self);
  }

  var_3 = "";

  if(istrue(self._id_75A8)) {
    var_3 = "hitequip";
  }

  if(isPlayer(var_1)) {
    var_1 _id_07C4::_id_FC47(var_3);
  }

  thread _id_2E4C();
}

_id_2E4E() {
  self endon("death");
  level scripts\engine\utility::waittill_any_2("game_ended", "bro_shot_start");
  thread _id_2E4C();
}

_id_2E65() {
  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return 0;
  }

  if(scripts\mp\utility\player::_id_8ACE()) {
    return 0;
  }

  if(!isDefined(self._id_2E72) || self._id_2E72.size <= 0) {
    return 0;
  }

  return 1;
}

_id_2E48() {
  return (gettime() - self._id_F1D3) / 1000 > 0.3;
}

_id_2E67() {
  self endon("death_or_disconnect");
  self endon("c4_unset");
  level endon("game_ended");
  self notify("watchForDetonation");
  self endon("watchForDetonation");

  for(;;) {
    self waittill("detonate");

    if(self getheldoffhand().basename == "s4_c4_mp" || self getheldoffhand().basename == "s4_eq_gesture_detonate_mp") {
      thread _id_2E50();
    }
  }
}

_id_2E66() {
  self endon("death_or_disconnect");
  self endon("c4_unset");
  level endon("game_ended");
  self notify("watchForAltDetonation");
  self endon("watchForAltDetonation");

  while(self usebuttonpressed()) {
    waitframe();
  }

  var_0 = 0;
  var_1 = level._id_5F3A;

  for(;;) {
    if(self usebuttonpressed()) {
      var_0 = 0;

      while(self usebuttonpressed()) {
        var_0 = var_0 + var_1;
        wait(var_1);
      }

      if(var_0 >= 0.5) {
        continue;
      }
      var_0 = 0;

      while(!self usebuttonpressed() && var_0 < 0.25) {
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
}

_id_2E59(var_0) {
  if(istrue(self._id_57CE)) {
    return;
  }
  _id_2E5C(var_0, self, self getentitynumber());
  thread _id_2E4C();
}

_id_2E5E() {
  if(scripts\mp\equipment::_id_755B("equip_c4")) {
    thread _id_2E66();
  }
}

_id_2E42(var_0, var_1) {
  if(!isDefined(var_0._id_2E72)) {
    var_0._id_2E72 = [];
  }

  var_2 = var_1 getentitynumber();
  var_0._id_2E72[var_2] = var_1;
  var_0 _meth_883C(1);
  thread _id_2E5D(var_0, var_1, var_2);
}

_id_2E5C(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    var_1 notify("c4_removeFromArray");
  }

  if(isDefined(var_0) && isDefined(var_0._id_2E72)) {
    var_0._id_2E72[var_2] = undefined;

    foreach(var_4 in var_0._id_2E72) {
      if(isDefined(var_4)) {
        return;
      }
    }

    var_0 _meth_883C(0);
  }
}

_id_2E5D(var_0, var_1, var_2) {
  var_1 endon("c4_removeFromArray");
  var_0 endon("disconnect");
  var_1 waittill("death");
  thread _id_2E5C(var_0, var_1, var_2);
}