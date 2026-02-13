/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1831.gsc
*************************************************/

_id_D7AD(var_0, var_1) {
  var_2 = "sentry_turret";
  var_3 = level._id_D0FA[var_2];
  var_4 = spawnturret("misc_turret", var_0.origin, level._id_D0FA[var_2].weaponinfo);
  var_4.team = "axis";

  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_4.angles = var_0.angles;
  var_4.health = var_3.maxhealth;
  var_4.maxhealth = var_3.maxhealth;
  var_4._id_D11F = var_2;
  var_4._id_A0B2 = 0;
  var_4._id_7659 = 0;
  var_4._id_AD20 = 0;
  var_4._id_3D10 = 2;
  var_4._id_F89C = "sentry_turret";

  if(!isDefined(var_1)) {
    var_1 = "weapon_wm_mg_sentry_turret";
  }

  var_4 setModel(var_1);
  var_4 _meth_83A0("axis");
  var_4 makeunusable();
  var_4 setnodeploy(1);
  var_4 setdefaultdroppitch(0);
  var_4 _meth_82ED(0.2);
  var_4 _meth_8224();
  var_4 _meth_8331(80);
  var_4 _meth_8372(80);
  var_4 _meth_82F0(50);
  var_4 _meth_8395(60);
  var_4 _meth_8302(0.6, "pitch");
  var_4 _meth_8302(0.6, "yaw");
  var_4 _meth_8301(0.65);
  var_4 setdefaultdroppitch(-89.0);
  var_4 _meth_839D(1);
  var_4 solid();
  var_4 _id_078D::_id_D3BA(::_id_D108);
  var_4 _id_078D::_id_D189(::_id_D107);
  var_4 _id_078D::_id_1538(0);
  var_0._id_F81F = var_4;
  wait 1;
  var_4 setmode("auto_nonai");
  var_4 _id_078D::_id_1538(1);
  var_4 _id_D109();
  var_4 thread _id_42BF();
  var_4 thread _id_D0CE();
  var_4 thread _id_D0D9();
  var_4 thread _id_09BB::_id_D0CF();
  return var_4;
}

_id_D108(var_0) {
  _id_D109();
}

_id_D107(var_0) {
  if(var_0) {
    return;
  }
  _id_D109();
}

_id_D109() {
  if(_id_078D::_id_85B3()) {
    self _meth_8410();
    self setmode(level._id_D0FA[self._id_F89C]._id_D0F7);
    self _meth_8202();
  } else {
    self _meth_8411();
    self setmode("auto_nonai");
  }
}

_id_53D9() {
  self endon("death");
  self endon("kill_turret");
  level endon("game_ended");
  var_0 = self.origin;
  var_1 = 0.05;
  var_2 = int(var_1 * 20);

  for(;;) {
    wait(var_1);
  }
}

_id_42BF() {
  self endon("death");
  self endon("kill_turret");
  level endon("game_ended");
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);

    if(!isDefined(var_1) || !isPlayer(var_1) && (!isDefined(var_1.owner) || !isPlayer(var_1.owner))) {
      continue;
    }
    if(isDefined(var_9.basename)) {
      if(issubstr(var_9.basename, "emp_drone")) {}
    }

    var_15 = isDefined(var_1) && isPlayer(var_1);
    var_16 = isDefined(var_1.owner) && isPlayer(var_1.owner);
    var_17 = isDefined(var_1.classname) && var_1.classname == "script_vehicle" && isDefined(var_1.owner) && isPlayer(var_1.owner);
    var_18 = var_17 && var_4 == "MOD_CRUSH";

    if(var_15 || var_16 || var_18) {
      if(!scripts\cp\utility::_id_86C9()) {
        if(var_16) {
          var_1 = var_1.owner;
        }

        _id_06FC::_id_108F(self, var_1, var_13, var_9, var_0, var_3, var_2, undefined, undefined, var_4);
      }
    }

    _id_071B::_id_BD47(var_13, var_1, var_0, var_8, var_4, var_9, var_2, var_2, var_7, undefined, self);
  }
}

_id_D0CE() {
  self endon("death");
  level endon("game_ended");
  self._id_A0B2 = 0;
  self._id_7659 = 0;
  self._id_AD20 = 0;
  thread _id_D0DD();

  for(;;) {
    scripts\engine\utility::_id_108C5("turretstatechange", "cooled");

    if(self _meth_81C1()) {
      self _meth_8203();
      thread _id_D0D0();
      continue;
    }

    self _meth_8202();
    _id_D0F0();
    thread _id_D0D1();
  }
}

_id_D0F2() {
  self endon("death");
  self playSound("sentry_gun_beep");
  wait 0.1;
  self playSound("sentry_gun_beep");
  wait 0.1;
  self playSound("sentry_gun_beep");
}

_id_D0F1() {
  thread _id_D0F2();

  while(self._id_A0B2 < level._id_D0FA[self._id_D11F]._id_E410) {
    self._id_A0B2 = self._id_A0B2 + 0.1;
    wait 0.1;
  }
}

_id_D0F0() {
  self._id_A0B2 = 0;
}

_id_D0D0() {
  self endon("death");
  self endon("stop_shooting");
  level endon("game_ended");
  _id_D0F1();
  var_0 = weaponfiretime(level._id_D0FA[self._id_D11F].weaponinfo);
  var_1 = level._id_D0FA[self._id_D11F]._id_2DB2;
  var_2 = level._id_D0FA[self._id_D11F]._id_2DB1;
  var_3 = level._id_D0FA[self._id_D11F]._id_AF6E;
  var_4 = level._id_D0FA[self._id_D11F]._id_AF6C;

  for(;;) {
    var_5 = randomintrange(var_1, var_2 + 1);

    for(var_6 = 0; var_6 < var_5 && !self._id_AD20; var_6++) {
      if(!_id_D0EF()) {
        break;
      }

      self _meth_83C1();
      self notify("bullet_fired");
      self._id_7659 = self._id_7659 + var_0;
      wait(var_0);
    }

    wait(randomfloatrange(var_3, var_4));
  }
}

_id_D0EF() {
  if(istrue(self._id_4D90)) {
    var_0 = self _meth_8184(0);

    if(isDefined(var_0) && isPlayer(var_0) && var_0 _meth_86B8()) {
      return 0;
    }
  }

  return 1;
}

_id_D0D1() {
  self notify("stop_shooting");
}

_id_D0DD() {
  if(istrue(self._id_DD98)) {
    return;
  }
  self endon("death");
  var_0 = weaponfiretime(level._id_D0FA[self._id_D11F].weaponinfo);
  var_1 = 0;
  var_2 = 0;
  var_3 = level._id_D0FA[self._id_D11F]._id_AD21;
  var_4 = level._id_D0FA[self._id_D11F]._id_3D0F;

  for(;;) {
    if(self._id_7659 != var_1) {
      wait(var_0);
    } else {
      self._id_7659 = max(0, self._id_7659 - 0.05);
    }

    if(self._id_7659 > var_3) {
      self._id_AD20 = 1;
      thread _id_B84E();

      while(self._id_7659) {
        self._id_7659 = max(0, self._id_7659 - var_4);
        wait 0.1;
      }

      self._id_AD20 = 0;
      self notify("not_overheated");
    }

    var_1 = self._id_7659;
    wait 0.05;
  }
}

_id_B84E() {
  self endon("death");
  self endon("not_overheated");
  level endon("game_ended");
  self notify("playing_heat_fx");
  self endon("playing_heat_fx");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("sentry_overheat_mp"), self, "tag_flash");
    wait(level._id_D0FA[self._id_D11F]._id_609D);
  }
}

_id_D0CF() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait 3.0;

    if(!isDefined(self._id_32CA)) {
      self playSound("sentry_gun_beep");
    }
  }
}

_id_D0D9() {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  self setmode("sentry_offline");
  self setscriptablepartstate("explode", "violent");

  if(isDefined(self._id_1DD4)) {
    foreach(var_1 in level.players) {
      var_2 = 0;

      if(isDefined(self._id_1DD4[var_1.guid]) && isDefined(self._id_1DD4[var_1.guid].damage)) {
        if(self._id_1DD4[var_1.guid].damage >= self.maxhealth * 0.1) {
          var_2 = 1;
        }

        if(self._id_1DD4[var_1.guid].damage >= self.maxhealth * 0.2) {
          var_2 = 2;
        }

        if(var_2 >= 1) {
          var_1 thread _id_0756::giverankxp("destroyed_sentry_gun", _id_0756::getscoreinfovalue("destroyed_sentry_gun"));
        }
      }
    }
  }

  if(isDefined(self)) {
    thread _id_D0D3();
  }
}

_id_D0D3() {
  self notify("sentry_delete_turret");
  self endon("sentry_delete_turret");
  wait 1.5;
  playFXOnTag(scripts\engine\utility::getfx("sentry_explode_mp"), self, "tag_aim");
  playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
  self playSound("sentry_explode_smoke");
  wait 0.1;
  self notify("deleting");

  if(isDefined(self)) {
    self delete();
  }
}