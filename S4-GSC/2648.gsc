/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2648.gsc
*************************************************/

init() {
  if(!isDefined(level._id_B157)) {
    level._id_B157 = [];
  }
}

_id_6FC7(var_0, var_1) {
  var_2 = _id_402E(var_0);
  _id_C4FE();
  self._id_32CD = var_2;
  var_3 = _id_AA77(var_0, var_2, 1, var_1);
  self._id_32CD = undefined;
  _id_C70E();
  return isDefined(var_2);
}

_id_402E(var_0) {
  if(isDefined(self._id_87A7) && self._id_87A7) {
    return;
  }
  var_1 = level._id_B157[var_0];
  var_2 = spawn("script_model", self.origin);
  var_2 setModel(var_1.modelbase);
  var_2.angles = self.angles;
  var_2.owner = self;
  var_2.team = self.team;
  var_2._id_3B73 = var_1;
  var_2._id_5BDA = 1;

  if(isDefined(var_1._id_AA99)) {
    var_2[[var_1._id_AA99]](var_0);
  }

  var_2 _id_436E(var_0);
  var_2 thread _id_F224(var_0);
  var_2 thread _id_74A8(var_0);
  var_2 thread _id_AB15(var_0);
  var_2 thread _id_AAF6(var_0);
  return var_2;
}

_id_74A8(var_0) {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_1);

    if(!scripts\mp\utility\player::isreallyalive(var_1)) {
      continue;
    }
    if(isDefined(self _meth_8151())) {
      self unlink();
    }

    var_1 _id_AA77(var_0, self, 0);
  }
}

_id_AA77(var_0, var_1, var_2, var_3) {
  self endon("death_or_disconnect");
  var_1 thread _id_AA82(var_0, self);
  scripts\common\utility::_id_158D(0);

  if(!isai(self)) {
    self notifyonplayercommand("placePlaceable", "+attack");
    self notifyonplayercommand("placePlaceable", "+attack_akimbo_accessible");
    self notifyonplayercommand("cancelPlaceable", "+actionslot 4");

    if(!self _meth_8684()) {
      self notifyonplayercommand("cancelPlaceable", "+actionslot 5");
      self notifyonplayercommand("cancelPlaceable", "+actionslot 6");
      self notifyonplayercommand("cancelPlaceable", "+actionslot 7");
    }
  }

  for(;;) {
    if(isDefined(var_3) && var_3 == 1 && !self isonladder() && self isonground() && !self _meth_81CE()) {
      var_4 = "placePlaceable";
    } else {
      var_4 = scripts\engine\utility::_id_10898("placePlaceable", "cancelPlaceable", "force_cancel_placement");
    }

    if(!isDefined(var_1)) {
      scripts\common\utility::_id_158D(1);
      return 1;
    } else if(var_4 == "cancelPlaceable" && var_2 || var_4 == "force_cancel_placement") {
      var_1 _id_AA7E(var_0, var_4 == "force_cancel_placement" && !isDefined(var_1._id_5BDA));
      return 0;
    } else if(var_1._id_314C) {
      var_1 thread _id_AB55(var_0);
      scripts\common\utility::_id_158D(1);
      return 1;
    } else
      waitframe();
  }
}

_id_AA7E(var_0, var_1) {
  if(isDefined(self._id_32CA)) {
    var_2 = self._id_32CA;
    var_2 _meth_80FC();
    var_2._id_87A7 = undefined;
    var_2._id_32CD = undefined;
    var_2 scripts\common\utility::_id_158D(1);
  }

  if(isDefined(self._id_267F)) {
    self._id_267F delete();
  }

  if(isDefined(self._id_32CF)) {
    self._id_32CF delete();
  }

  var_3 = level._id_B157[var_0];

  if(isDefined(var_3._id_AA7F)) {
    self[[var_3._id_AA7F]](var_0);
  }

  if(isDefined(var_1) && var_1) {
    scripts\mp\weapons::_id_555A();
  }

  self delete();
}

_id_AB55(var_0) {
  var_1 = level._id_B157[var_0];
  self.origin = self._id_B174;
  self.angles = self._id_32CF.angles;
  self playSound(var_1._id_B162);
  _id_DCD4(var_0);

  if(isDefined(var_1._id_AB56)) {
    self[[var_1._id_AB56]](var_0);
  }

  self setcursorhint("HINT_NOICON");
  self sethintstring(var_1._id_0224);
  var_2 = self.owner;
  var_2 _meth_80FC();
  var_2._id_87A7 = undefined;
  self._id_32CA = undefined;
  self._id_8983 = 1;
  self._id_5BDA = undefined;

  if(isDefined(var_1._id_75F2)) {
    self._id_75F3 = thread _id_078F::_id_D594(0, var_1._id_75F2, 0, undefined, undefined, undefined, 1);
  }

  thread _id_742F(var_0);
  thread _id_7431(var_0);
  self makeuseable();
  _id_0812::_id_C2B2("Killstreak_Ground", self.owner);

  foreach(var_4 in level.players) {
    if(var_4 == var_2) {
      self _meth_80E0(var_4);
      continue;
    }

    self disableplayeruse(var_4);
  }

  if(isDefined(self._id_DBE2)) {
    level thread scripts\mp\hud_util::_id_EF8D(var_1._id_E419, var_2);
    self._id_DBE2 = 0;
  }

  var_6 = spawnStruct();
  var_6._id_950E = self._id_A283;
  var_6._id_B385 = 1;
  var_6._id_5338 = "carried";

  if(isDefined(var_1._id_AB3B)) {
    var_6._id_43F7 = var_1._id_AB3B;
  }

  thread scripts\mp\movers::_id_7403(var_6);
  thread _id_10BD5();
  self notify("placed");
  self._id_32CF delete();
  self._id_32CF = undefined;
}

_id_AA82(var_0, var_1) {
  var_2 = level._id_B157[var_0];
  self._id_32CF = var_1 _id_3FA7(var_0);
  self._id_8983 = undefined;
  self._id_32CA = var_1;
  var_1._id_87A7 = 1;
  _id_436E(var_0);
  _id_790F(var_0);

  if(isDefined(var_2._id_AA83)) {
    self[[var_2._id_AA83]](var_0);
  }

  thread _id_FCF2(var_0, var_1);
  thread _id_AA84(var_0, var_1);
  self notify("carried");
}

_id_FCF2(var_0, var_1) {
  var_1 endon("death_or_disconnect");
  level endon("game_ended");
  self endon("placed");
  self endon("death");
  self._id_314C = 1;
  var_2 = -1;
  var_3 = level._id_B157[var_0];
  var_4 = (0, 0, 0);

  if(isDefined(var_3._id_B173)) {
    var_4 = (0, 0, var_3._id_B173);
  }

  var_5 = self._id_32CF;

  for(;;) {
    var_6 = var_1 _meth_8065(1, var_3._id_B175);
    self._id_B174 = var_6["origin"];
    var_5.origin = self._id_B174 + var_4;
    var_5.angles = var_6["angles"];
    self._id_314C = var_1 isonground() && var_6["result"] && abs(self._id_B174[2] - var_1.origin[2]) < var_3._id_B16E;

    if(isDefined(var_6["entity"])) {
      self._id_A283 = var_6["entity"];
    } else {
      self._id_A283 = undefined;
    }

    if(self._id_314C != var_2) {
      if(self._id_314C) {
        var_5 setModel(var_3._id_9FDD);
        var_1 _meth_80FD(var_3._id_B17C);
      } else {
        var_5 setModel(var_3._id_9FDE);
        var_1 _meth_80FD(var_3._id_31A4);
      }
    }

    var_2 = self._id_314C;
    waitframe();
  }
}

_id_436E(var_0) {
  self makeunusable();
  _id_78FE();
  var_1 = level._id_B157[var_0];

  if(isDefined(var_1._id_AAA2)) {
    self[[var_1._id_AAA2]](var_0);
  }
}

_id_78FE() {
  _id_078F::_id_D593(self._id_75F3);
}

_id_742F(var_0) {
  self endon("carried");
  var_1 = level._id_B157[var_0];
  _id_07C3::_id_A0FF(var_1.maxhealth, var_1._id_42FD, ::_id_7433, ::_id_A007, 1);
}

_id_A007(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = var_0._id_7C97;
  var_6 = var_4;
  var_7 = self._id_3B73;

  if(isDefined(var_7._id_15C1) && var_7._id_15C1) {
    var_6 = _id_07C3::_id_7468(var_2, var_3, var_6);
  }

  if(isDefined(var_7._id_15B4) && var_7._id_15B4) {
    var_6 = _id_07C3::_id_743D(var_2, var_3, var_6);
  }

  var_6 = _id_07C3::_id_746C(var_2, var_3, var_6);
  var_6 = _id_07C3::_id_7453(var_2, var_3, var_6);
  var_6 = _id_07C3::_id_741D(var_2, var_3, var_6);

  if(isDefined(var_7._id_A007)) {
    var_6 = self[[var_7._id_A007]](var_2, var_3, var_6);
  }

  return var_6;
}

_id_7433(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = self._id_3B73;
  var_6 = _id_07C3::_id_AB18(self.streakname, var_1, var_2, var_3, var_4, var_5._id_CC16, var_5._id_484C);

  if(var_6 && isDefined(var_5._id_AAB3)) {
    self[[var_5._id_AAB3]](self.streakname, var_1, self.owner, var_3);
  }
}

_id_7431(var_0) {
  self endon("carried");
  self waittill("death");
  var_1 = level._id_B157[var_0];

  if(isDefined(self)) {
    _id_436E(var_0);

    if(isDefined(var_1._id_9FD5)) {
      self setModel(var_1._id_9FD5);
    }

    if(isDefined(var_1._id_AAA6)) {
      self[[var_1._id_AAA6]](var_0);
    }

    self delete();
  }
}

_id_AA84(var_0, var_1) {
  self endon("placed");
  self endon("death");
  var_1 endon("disconnect");
  var_1 waittill("death");

  if(self._id_314C) {
    thread _id_AB55(var_0);
  } else {
    _id_AA7E(var_0);
  }
}

_id_AB15(var_0) {
  self endon("death");
  level endon("game_ended");
  childthread _id_10BC5("disconnect", var_0);
  childthread _id_10BC5("joined_team", var_0);
  childthread _id_10BC5("joined_spectators", var_0);
}

_id_10BC5(var_0, var_1) {
  self.owner waittill(var_0);
  _id_3844(var_1);
}

_id_AAF6(var_0) {
  self endon("death");
  level waittill("game_ended");
  _id_3844(var_0);
}

_id_3844(var_0) {
  if(isDefined(self._id_8983)) {
    self notify("death");
  } else {
    _id_AA7E(var_0);
  }
}

_id_10BD5() {
  self endon("death");

  for(;;) {
    level waittill("connected", var_0);
    thread _id_AB5D(var_0);
  }
}

_id_AB5D(var_0) {
  self endon("death");
  var_0 endon("disconnect");
  var_0 waittill("spawned_player");
  self disableplayeruse(var_0);
}

_id_F224(var_0) {
  self endon("death");
  level endon("game_ended");
  var_1 = level._id_B157[var_0];
  var_2 = var_1._id_9371;

  while(var_2 > 0.0) {
    wait 1.0;
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(!isDefined(self._id_32CA)) {
      var_2 = var_2 - 1.0;
    }
  }

  if(isDefined(self.owner) && isDefined(var_1._id_70DB)) {
    self.owner thread _id_0A8D::_id_9137(var_1._id_70DB);
  }

  self notify("death");
}

_id_C541() {
  if(self hasweapon("iw6_riotshield_mp")) {
    self._id_C713 = "iw6_riotshield_mp";
    scripts\cp_mp\utility\inventory_utility::_takeweapon("iw6_riotshield_mp");
  }
}

_id_C4FE() {
  if(scripts\mp\utility\perk::_hasperk("specialty_explosivebullets")) {
    self._id_C70D = "specialty_explosivebullets";
    scripts\mp\utility\perk::removeperk("specialty_explosivebullets");
  }
}

_id_C715() {
  if(isDefined(self._id_C713)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(self._id_C713);
    self._id_C713 = undefined;
  }
}

_id_C70E() {
  if(isDefined(self._id_C70D)) {
    scripts\mp\utility\perk::_id_6FC2(self._id_C70D);
    self._id_C70D = undefined;
  }
}

_id_DCD4(var_0) {
  self show();

  if(isDefined(self._id_267F)) {
    self._id_267F show();
    level notify("update_bombsquad");
  }
}

_id_790F(var_0) {
  self hide();

  if(isDefined(self._id_267F)) {
    self._id_267F hide();
  }
}

_id_3FA7(var_0) {
  if(isDefined(self._id_87A7) && self._id_87A7) {
    return;
  }
  var_1 = spawnturret("misc_turret", self.origin + (0, 0, 25), "sentry_minigun_mp");
  var_1.angles = self.angles;
  var_1.owner = self;
  var_2 = level._id_B157[var_0];
  var_1 setModel(var_2.modelbase);
  var_1 _meth_8224();
  var_1 _meth_839D(1);
  var_1 setmode("sentry_offline");
  var_1 makeunusable();
  var_1 setsentryowner(self);
  var_1 _meth_8376(self);
  var_1 setCanDamage(0);
  var_1 notsolid();
  return var_1;
}