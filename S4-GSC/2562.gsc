/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2562.gsc
*************************************************/

_id_1D41() {
  var_0 = _id_09E2::_id_10143("equip_at_mine_stun", 1);
  var_0._id_0359 = 100;
  var_0._id_F612 = ::_id_1D4A;
}

_id_1D49(var_0) {
  self endon("disconnect");
  var_0 endon("death");

  if(scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp")) {
    var_0._id_75A8 = 1;
  }

  var_0 _id_078E::_id_C2B5(2, ::_id_4774);
  thread scripts\mp\weapons::_id_A106(self, var_0);
  var_0 thread _id_1D50();
  var_1 = spawnStruct();
  var_1._id_F1D0 = 100;
  var_1._id_F1D1 = -50;
  var_1._id_330E = 3;
  var_1._id_3314 = 0.5;
  var_1._id_330C = 1;
  var_1._id_B1D3 = 0.5;
  var_1._id_B1D2 = 15;
  var_1._id_B1D4 = 12;
  var_1._id_B1D1 = 20;
  var_1._id_B1D5 = 45;
  var_1._id_B1D6 = 0.342;
  var_0 setscriptablepartstate("visibility", "show", 0);
  var_0 waittill("missile_stuck", var_2);

  if(isDefined(var_2)) {
    var_0 linkto(var_2);
  }

  thread _id_1D44(var_0);
}

_id_1D48() {
  if(istrue(level._id_434D)) {
    return;
  }
  if(isDefined(self._id_4346)) {
    _id_0817::_id_C51F(self._id_4346);
  }

  self._id_4346 = _id_0817::_id_1135(self.origin, _id_0817::_id_69D4(), 72, self.owner.team, undefined, self.owner, 0, self, 1);
}

_id_1D44(var_0) {
  var_0 endon("mine_destroyed");
  var_0 endon("death");
  var_0 setotherent(self);
  var_0 setentityowner(self);
  var_0 _meth_85B9();
  var_0 _meth_85BA();
  var_0 setnodeploy(1);
  var_0 setscriptablepartstate("plant", "active", 0);
  self setscriptablepartstate("equipATMineFXView", "plant", 0);
  scripts\mp\weapons::_id_AACF(var_0, "equip_at_mine_stun", ::_id_1D3A);
  thread scripts\mp\weapons::_id_A105(self, var_0);
  var_0 _id_0812::_id_C2B2("Lethal_Static", var_0.owner, 1);
  var_0 thread scripts\mp\weapons::_id_9ED2();
  var_0 thread _id_1D4B();
  var_0 _id_078D::_id_D15E(::_id_1D3C);
  var_0 _id_1D48();
  wait 1.5;
  var_0 thread _id_07CD::_id_C33E(::_id_1D3E, 1, 1);
  var_0 setscriptablepartstate("arm", "active", 0);
  var_0 thread _id_1D52();
  var_0 thread scripts\mp\weapons::_id_99EF("tag_use", 1);
  thread scripts\mp\weapons::_id_ACD8(var_0);
  var_0._id_75F3 = var_0 _id_078F::_id_D594(0, 0, undefined, undefined, undefined, 0.1, 1);
}

_id_1D3E(var_0) {
  thread _id_1D3A(5);

  if(!isDefined(var_0)) {
    var_0 = self.owner;
  }

  self setentityowner(var_0);
  self _meth_85AE();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "neutral", 0);
  self setscriptablepartstate("explode", "fromPlayer", 0);
  self setscriptablepartstate("hacked", "neutral", 0);
}

_id_1D3F(var_0) {
  var_0 dodamage(200, self.origin, self.owner, self, "MOD_EXPLOSIVE", makeweapon("s4_mine_ger_s44_mp"));
  var_1 = var_0 _id_0A8B::_id_A5A1(self.owner, makeweapon("s4_mine_ger_s44_mp"), self, "MOD_EXPLOSIVE");
  thread _id_1D40();
  waitframe();

  if(isDefined(var_0)) {
    var_0 _id_0A8B::_id_A5A6(var_1);
  }
}

_id_1D40() {
  thread _id_1D3A(5);
  self setentityowner(self.owner);
  self _meth_85AE();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);
  self setscriptablepartstate("explode", "fromVehicle", 0);
}

_id_1D3D(var_0) {
  thread _id_1D3A(5);
  self setentityowner(var_0);
  self _meth_85AE();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);
  self setscriptablepartstate("explode", "fromDamage", 0);
}

_id_1D3B(var_0) {
  thread _id_1D3A(5);
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);
  self setscriptablepartstate("destroy", "active", 0);
}

_id_1D3A(var_0) {
  self notify("death");
  level._id_9EE2[self getentitynumber()] = undefined;
  self setscriptablepartstate("hack_usable", "off");
  self setCanDamage(0);
  scripts\mp\weapons::_id_99EC();
  _id_078F::_id_D593(self._id_75F3);
  self._id_75F3 = undefined;
  self._id_57CE = 1;

  if(isDefined(self._id_4346)) {
    _id_0817::_id_C51F(self._id_4346);
    self._id_4346 = undefined;
  }

  if(isDefined(self.owner)) {
    self.owner scripts\mp\weapons::_id_C498(self);
  }

  if(isDefined(self._id_4341)) {
    self._id_4341 delete();
  }

  var_1 = self _meth_8150();

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(isDefined(var_3) && isDefined(var_3._id_5562) && var_3._id_5562 == "equip_claymore" && !istrue(var_3._id_57CE)) {
        var_3 thread _id_0A05::_id_3813();
      }
    }
  }

  if(isDefined(var_0)) {
    wait(var_0);
  }

  _id_078E::_id_4807();
  self delete();
}

_id_1D46() {}

_id_1D52() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");

  for(;;) {
    self waittill("trigger_grenade", var_0);

    foreach(var_2 in var_0) {
      if(var_2.classname == "script_vehicle") {
        if(var_2 _id_09E2::_id_10148(self)) {
          continue;
        }
        if(!_id_09E2::_id_1014C(var_2, self)) {
          continue;
        }
        _id_09E2::_id_10149(var_2, self);
        break;
      }

      if(var_2.classname == "agent" || var_2.classname == "player") {
        if(!isPlayer(var_2) && !isagent(var_2)) {
          continue;
        }
        if(isDefined(var_2.vehicle)) {
          continue;
        }
        if(!scripts\mp\utility\player::isreallyalive(var_2)) {
          continue;
        }
        thread _id_1D45(var_2);
        break;
      }
    }
  }
}

_id_1D45(var_0) {
  self endon("mine_destroyed");
  self endon("death");
  self notify("mine_triggered");
  self._id_F618 = 1;
  scripts\mp\weapons::_id_99EC();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);
  var_1 = scripts\mp\utility\weapon::_id_0C48("s4_mine_ger_s44_mp", self.origin, (0, 0, 0), 100, 1);
  var_1 linkto(self);
  thread _id_1D36(var_1);
  var_1._id_10D0C = makeweapon("s4_mine_ger_s44_mp");
  self._id_4341 = var_1;
  scripts\mp\weapons::_id_57EC(var_0, 0.05);
  thread _id_1D4D();
}

_id_1D4A(var_0, var_1) {
  var_1 endon("mine_destroyed");
  var_1 endon("death");
  var_1.owner endon("disconnect");
  var_1 notify("mine_triggered");
  var_1 scripts\mp\weapons::_id_99EC();
  var_1 setscriptablepartstate("arm", "neutral", 0);
  var_1 setscriptablepartstate("trigger", "active", 0);
  wait 0.2;
  var_1 thread _id_1D3F(var_0);
}

_id_1D4F(var_0) {
  self endon("death");
  self._id_0203 scripts\engine\utility::_id_108A8(var_0, "death", "mine_destroyed");

  if(isDefined(self._id_0203)) {
    self moveto(self.origin, 0.05, 0, 0);
  }

  while(isDefined(self._id_0203)) {
    waitframe();
  }

  self delete();
}

_id_4774() {
  _id_1D3A(0);
}

_id_1D4D() {
  self endon("mine_destroyed");
  self endon("death");
  var_0 = 0.25;

  if(var_0 > 0) {
    var_1 = (0, 0, 1);
    var_2 = self.origin + var_1 * 64;
    var_3 = physics_createcontents(["physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle", "physicscontents_missileclip"]);
    var_4 = _id_0A91::_id_65A8();
    var_5 = self.origin;
    var_6 = var_2;
    var_7 = _func_02C1(var_5, var_6, var_3, var_4, 0, "physicsquery_closest", 1);

    if(isDefined(var_7) && var_7.size > 0) {
      var_8 = vectordot(var_7[0]["position"] - var_5, var_1);
      var_8 = max(0, var_8 - 1);
      var_0 = 0;
      var_2 = self.origin;

      if(var_8 > 0) {
        var_0 = var_8 / 64 * 0.25;
        var_2 = self.origin + var_1 * var_8;
      }
    }

    if(var_0 > 0) {
      var_9 = var_0;
      var_10 = var_9 * 0.81;
      var_9 = var_9 - var_10;
      var_11 = 0;

      if(var_9 > 0) {
        var_11 = var_9 * 0;
      }

      var_12 = spawn("script_model", self.origin);
      var_12.angles = vectortoangles(anglesToForward(self.angles) * (1, 1, 0));
      var_12 setModel("tag_origin");
      self._id_A24C = var_12;
      var_12._id_0203 = self;
      self linkto(var_12, "tag_origin", (0, 0, 0), (0, 0, 0));
      var_12 moveto(var_2, var_0, var_11, var_10);
      var_12 thread _id_1D4F(var_0);
      thread _id_1D4E(var_0);
      wait(var_0);
      thread _id_1D3E();
      return;
    }
  }
}

_id_1D4E(var_0) {
  self endon("mine_destroyed");
  self endon("death");
  self setscriptablepartstate("launch", "active", 0);
}

_id_1D3C(var_0) {
  var_1 = var_0.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_1))) {
    var_1 notify("destroyed_equipment");
    var_1 scripts\mp\killstreaks\killstreaks::_id_6FEA(self);

    if(isDefined(self.owner) && self.owner._id_B1D0.size > 1) {
      self.owner thread _id_0A8D::_id_9137("sm_destroyed_m");
    } else {
      self.owner thread _id_0A8D::_id_9137("sm_destroyed_s");
    }
  }

  if(isPlayer(var_1)) {
    var_1 _id_07C4::_id_FC47("");
  }

  thread _id_1D3B();
}

_id_1D4B() {
  self endon("death");
  self waittill("detonateExplosive", var_0);

  if(isDefined(var_0)) {
    thread _id_1D3D(var_0);
  } else if(isDefined(self.owner)) {
    thread _id_1D3D(self.owner);
  } else {
    thread _id_1D3B();
  }
}

_id_1D50() {
  self endon("mine_destroyed");
  self endon("death");
  level scripts\engine\utility::waittill_any_2("game_ended", "bro_shot_start");
  thread _id_1D3B();
}

_id_1D39(var_0) {
  var_0 dodamage(200, self.origin, self.owner, self, "MOD_EXPLOSIVE", makeweapon("s4_mine_ger_s44_mp"));
  var_1 = var_0 _id_0A8B::_id_A5A1(self.owner, makeweapon("s4_mine_ger_s44_mp"), self, "MOD_EXPLOSIVE");
  waitframe();

  if(isDefined(var_0)) {
    var_0 _id_0A8B::_id_A5A6(var_1);
  }
}

_id_1D42(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    return var_4;
  }

  if(var_3 != "MOD_EXPLOSIVE") {
    return var_4;
  }

  if(!isDefined(var_2)) {
    return var_4;
  }

  if(isnullweapon(var_2)) {
    return var_4;
  }

  if(var_2.basename != "s4_mine_ger_s44_mp" && var_2.basename != "at_mine_ap_mp") {
    return var_4;
  }

  var_5 = anglestoup(var_1.angles);
  var_6 = var_1.origin - self getEye();
  var_7 = vectordot(var_6, var_5);

  if(var_7 > 46) {
    return 0;
  }

  var_6 = self.origin - var_1.origin;
  var_8 = vectordot(var_6, var_5);

  if(var_8 > 46) {
    return 0;
  }

  if(var_2.basename == "at_mine_ap_mp" || istrue(var_1._id_F618)) {
    if(var_7 >= 0) {
      var_9 = var_0 getstance();

      if(var_9 == "prone") {
        var_4 = int(min(var_4, 35));
      } else if(var_9 == "crouch" || self issprintsliding()) {
        var_4 = int(min(var_4, 55));
      }
    }
  }

  return var_4;
}

_id_1D36(var_0) {
  var_0 endon("death");
  self waittill("death");
  var_0 delete();
}

_id_1D43(var_0) {
  self setscriptablepartstate("hacked", "active", 0);
  _id_1D48();
  thread scripts\mp\weapons::_id_A105(self.owner, self);
  thread scripts\mp\weapons::_id_ACD8(self);
}