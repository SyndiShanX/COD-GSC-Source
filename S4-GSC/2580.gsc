/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2580.gsc
*************************************************/

_id_DEBE(var_0, var_1) {
  var_0 thread scripts\mp\utility\script::_id_A695("death", "end_explode");
  var_0 endon("end_explode");

  if(var_1) {
    var_0 waittill("missile_stuck", var_6, var_2, var_3, var_4, var_5);
  } else {
    var_0 setotherent(self);
    var_0 thread _id_07C3::_id_A0FF(19, "hitequip", ::_id_DEBC, ::_id_DEBB);
    _id_078D::_id_0FD1(var_0);
    var_0 _id_078D::_id_D15E(::_id_DEBA);
    var_0 thread _id_DEBF();
    var_0 waittill("explode", var_6);
  }

  thread _id_DEC4(var_6);
}

_id_DEB0(var_0, var_1, var_2) {
  var_1 = (0, 0, 1);
  var_3 = var_0 + var_1;
  var_4 = var_3 + var_1 * 137;
  var_5 = physics_createcontents(["physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle", "physicscontents_missileclip"]);
  var_6 = _func_02C1(var_3, var_4, var_5, var_2, 0, "physicsquery_closest", 1);

  if(isDefined(var_6) && var_6.size > 0) {
    var_4 = var_6[0]["position"];

    if(1) {
      var_7 = vectordot(var_4 - var_3, var_1);

      if(var_7 > 0) {
        if(var_7 >= 50) {
          var_7 = min(var_7 - 25, 112);
        } else {
          var_7 = var_7 / 2;
        }

        var_4 = var_3 + var_1 * var_7;
      }
    }
  } else
    var_4 = var_3 + var_1 * 112;

  return var_4;
}

_id_DEC4(var_0) {
  var_1 = scripts\mp\utility\weapon::_id_0C48("snapshot_grenade_mp", var_0, (0, 0, 0), 100, 1);
  var_1 _id_078E::_id_C2B5(3, ::_id_DEB7);
  var_1 setotherent(self);
  var_1 setscriptablepartstate("beacon", "active", 0);
  var_1 setscriptablepartstate("anims", "deploy", 0);
  var_1 _meth_8647();
  var_1.owner = self;
  var_1 thread _id_07C3::_id_A0FF(19, "hitequip", ::_id_DEBC, ::_id_DEBB);
  _id_078D::_id_0FD1(var_1);
  var_1 _id_078D::_id_D15E(::_id_DEBA);
  var_1 thread _id_DEBF();
  var_1 endon("death");
  var_2 = scripts\mp\utility\weapon::_id_0C48("snapshot_grenade_danger_mp", var_1.origin, (0, 0, 0), 100, 1);
  var_2.weapon_name = "snapshot_grenade_danger_mp";
  var_2 linkto(var_1);
  var_2 hidefromplayer(self);
  var_1 thread _id_DEB2(var_2);
  var_3 = spawn("script_model", var_1.origin);
  var_3.angles = var_1.angles;
  var_3 setModel("tag_origin");
  var_1 linkto(var_3, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_1 thread _id_DEB3(var_3);
  var_4 = (0, 0, 1);
  var_5 = _id_DEB0(var_0, var_4, [var_1, var_2]);
  var_6 = vectordot(var_5 - var_0, var_4);
  var_7 = (0, 0, 0);

  if(var_6 > 0) {
    var_8 = var_6 / 112;
    var_9 = 0.65 * var_8;
    var_10 = var_9 * 0.19;
    var_11 = var_9 * 0.6;
    var_12 = 0.3 * var_8;
    var_13 = var_9 * 0;
    var_14 = var_9 * 0.35;
    var_3 rotateto(var_7, var_12, var_13, var_14);
    wait 0.3;
    var_1 setscriptablepartstate("dust", "active", 0);
    var_1 setscriptablepartstate("anims", "idle", 0);
    var_3 moveto(var_5, var_9, var_10, var_11);
    wait(var_9);
  } else {
    var_3.angles = var_7;
    wait 0.3;
  }

  var_15 = 0.0;
  wait(var_15);
  var_1 setscriptablepartstate("detect", "active", 0);
  var_1 setscriptablepartstate("anims", "idle", 0);
  var_1 setscriptablepartstate("beacon", "neutral", 0);
  wait 0.5;
  var_1 _id_DEB9();
  var_1 thread _id_DEB8();
}

_id_DEB9() {
  var_0 = self.owner;
  var_1 = self.origin;
  var_2 = self.angles;
  var_3 = _id_DEB6(var_0, var_1);
  var_4 = physics_createcontents(["physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle"]);
  var_5 = scripts\common\utility::_id_B7BF(var_1, 540);

  foreach(var_7 in var_5) {
    if(!scripts\mp\utility\player::isreallyalive(var_7)) {
      continue;
    }
    if(!scripts\cp_mp\utility\player_utility::_id_B78C(var_0, var_7)) {
      continue;
    }
    if(0) {
      var_8 = var_1;
      var_9 = var_7 getEye();
      var_10 = _func_02C1(var_8, var_9, var_4, undefined, 0, "physicsquery_closest", 1);

      if(isDefined(var_10) && var_10.size > 0) {
        continue;
      }
    }

    _id_DEB1(var_7, var_0, var_3);
  }

  if(1) {
    _func_0251(var_1, var_0, 540, 500, "specialty_snapshot_immunity");
  }
}

_id_DEB6(var_0, var_1) {
  var_2 = undefined;

  if(1) {
    var_2 = spawnStruct();
    var_2.owner = var_0;
    var_2._id_033E = var_1;
    var_2._id_8747 = 1;
    var_2._id_EEF7 = [];
    var_2._id_534F = [];
    var_2._id_ACE9 = [];
  }

  return var_2;
}

_id_DEB1(var_0, var_1, var_2) {
  if(var_0 scripts\mp\utility\perk::_hasperk("specialty_snapshot_immunity")) {
    var_1 _id_07C4::_id_FC47("hittacresist");
    return;
  }

  var_1 _id_07C4::_id_FC47("");

  if(1) {
    var_3 = var_0 getentitynumber();
    var_2._id_EEF7[var_3] = var_0;
    var_2._id_534F[var_3] = gettime() + 1250;
    var_2._id_ACE9[var_3] = ::scripts\mp\utility\outline::outlineenableforplayer(var_0, var_1, "snapshotgrenade", "equipment");
    var_0 scripts\mp\utility\outline::_id_0C2E("snapshotgrenade", 0);
    var_0 _id_09B5::_id_9B40();
    var_2 thread _id_DEBD();
  }

  if(0) {
    var_1 thread _id_DEB5(var_0 gettagorigin("j_spineupper"), var_0.angles, var_0);
  }

  var_0._id_9049 = gettime();
  var_1 _id_07C3::_id_3AC3("equip_snapshot_grenade");
  var_1 scripts\mp\utility\stats::_id_7DAE("snapshotHits", 1);
}

_id_DEB8() {
  self setscriptablepartstate("destroy", "active", 0);
  self setscriptablepartstate("beacon", "neutral", 0);
  self setscriptablepartstate("dust", "neutral", 0);
  self setscriptablepartstate("detect", "neutral", 0);
  self setscriptablepartstate("anims", "neutral", 0);
  self _meth_8647();
  thread _id_DEB7(0.35);
}

_id_DEB7(var_0) {
  self notify("death");
  _id_078E::_id_4807();
  self endon("death");
  self._id_57CE = 1;
  self setCanDamage(0);

  if(isDefined(var_0)) {
    wait(var_0);
  }

  self delete();
}

_id_DEBB(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = var_0._id_7C97;

  if(scripts\engine\utility::_id_8794(var_3)) {
    if(isDefined(var_2)) {
      var_6 = 1;

      if(var_4 >= scripts\mp\weapons::_id_9EDF()) {
        var_6 = var_6 + 1;
      }

      if(_id_0A8B::_id_8866(var_2, var_3)) {
        var_6 = var_6 * 2;
      }

      var_4 = var_6 * 19;
    }
  }

  scripts\mp\weapons::_id_555D(self.owner, var_1, var_2, var_3);
  return var_4;
}

_id_DEBC(var_0) {
  var_1 = var_0.attacker;

  if(isDefined(var_1) && scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_1)) {
    var_1 notify("destroyed_equipment");
    var_1 scripts\mp\killstreaks\killstreaks::_id_6FEA(self, var_0.objweapon);
  }

  thread _id_DEB8();
}

_id_DEBA(var_0) {
  if(!isDefined(self.owner)) {
    return;
  }
  var_1 = var_0.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_1))) {
    var_1 notify("destroyed_equipment");
    var_1 scripts\mp\killstreaks\killstreaks::_id_6FEA(self);
  }

  if(isPlayer(var_1)) {
    var_1 _id_07C4::_id_FC47("");
  }

  thread _id_DEB8();
}

_id_DEBF() {
  self endon("death");
  _id_DEC0();

  if(isDefined(self)) {
    thread _id_DEB8();
  }
}

_id_DEC0() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");

  for(;;) {
    waitframe();
  }
}

_id_DEB3(var_0) {
  var_0 endon("death");
  self waittill("death");
  wait 1;
  var_0 delete();
}

_id_DEB2(var_0) {
  var_0 endon("death");
  self waittill("death");
  var_0 delete();
}

_id_DEBD() {
  self endon("death");
  self.owner endon("death_or_disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");

  if(!istrue(self._id_8747)) {
    return;
  }
  self notify("update");
  self endon("update");
  thread _id_DEC1();

  while(self._id_EEF7.size > 0) {
    foreach(var_4, var_1 in self._id_EEF7) {
      var_1 = self._id_EEF7[var_4];
      var_2 = self._id_534F[var_4];
      var_3 = self._id_ACE9[var_4];

      if(!isDefined(var_1) || !scripts\mp\utility\player::isreallyalive(var_1) || gettime() >= var_2) {
        scripts\mp\utility\outline::outlinedisable(var_3, var_1);

        if(isDefined(var_1)) {
          var_1 scripts\mp\utility\outline::_id_0C2D();
        }

        self._id_EEF7[var_4] = undefined;
        self._id_534F[var_4] = undefined;
        self._id_ACE9[var_4] = undefined;
      }
    }

    waitframe();
  }

  thread _id_DEB4();
}

_id_DEC1() {
  self endon("death");
  self endon("update");
  _id_DEC2();
  thread _id_DEB4();
}

_id_DEC2() {
  self.owner endon("death_or_disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");

  for(;;) {
    waitframe();
  }
}

_id_DEB4() {
  self notify("death");
  self._id_8747 = 0;

  foreach(var_3, var_1 in self._id_EEF7) {
    var_1 = self._id_EEF7[var_3];
    var_2 = self._id_ACE9[var_3];
    scripts\mp\utility\outline::outlinedisable(var_2, var_1);

    if(isDefined(var_1)) {
      var_1 scripts\mp\utility\outline::_id_0C2D();
    }
  }
}

_id_DEB5(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0);
  var_3.angles = var_1;

  if(isDefined(var_2) && 1) {
    var_3 linkto(var_2);
  }

  var_3 setModel("equip_snapshot_marker_mp");
  var_3 setotherent(self);
  var_3 setscriptablepartstate("effects", "active", 0);
  var_3 _id_DEC5(self, 3000, var_2, 1250);

  if(isDefined(var_3)) {
    var_3 delete();
  }
}

_id_DEC5(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_0 endon("death_or_disconnect");
  level endon("game_ended");
  var_4 = gettime() + var_1;
  var_5 = scripts\engine\utility::ter_op(1, gettime() + 1250, undefined);

  while(var_4 > gettime()) {
    if(isDefined(var_5)) {
      if(var_5 < gettime()) {
        self unlink();
        var_5 = undefined;
      } else if(!isDefined(var_2)) {
        self unlink();
        var_5 = undefined;
      } else if(!scripts\mp\utility\player::isreallyalive(var_2)) {
        self unlink();
        var_5 = undefined;
      }
    }

    waitframe();
  }
}