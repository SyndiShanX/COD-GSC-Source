/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2560.gsc
*************************************************/

_id_1B61() {
  var_0 = scripts\mp\equipment::_id_6A15("health");

  if(var_0 <= 0) {
    return;
  }
  if(self _meth_86B8()) {
    self notify("try_armor_repair_cancel");
    return;
  }

  if(isDefined(self._id_1B63)) {
    self._id_1B63--;
  }

  var_1 = self._id_2A0E + 5;
  var_2 = clamp(var_1, 0, self._id_2A7D);
  var_3 = max(1, getdvarint("#x38bc48083f7fa1f21", 50));
  var_2 = int(var_2 / var_3) * var_3 + var_3;
  self._id_2A0E = clamp(var_2, 0, self._id_2A7D);
  var_4 = self._id_2A0E / self._id_2A7D;
  var_5 = int(var_4 * 100);
  scripts\mp\gametypes\br_public::_id_FC1A("armorHealthRatio", int(self._id_2A0E));
  scripts\mp\equipment::_id_4559("health", 1);
  _id_07BC::_id_ABD1("armor_plate");
  self notify("armor_plate_inserted");
}

_id_1B5E() {
  var_0 = self._id_2A0E + 5;
  var_1 = clamp(var_0, 0, self._id_2A7D);
  var_2 = max(1, getdvarint("#x38bc48083f7fa1f21", 50));
  var_1 = int(var_1 / var_2) * var_2;
  var_3 = clamp(var_1, 0, self._id_2A7D);

  if(var_3 >= self._id_2A0E) {
    return;
  } else {
    self._id_2A0E = var_3;
  }

  var_4 = self._id_2A0E / self._id_2A7D;
  var_5 = int(var_4 * 100);
  scripts\mp\gametypes\br_public::_id_FC1A("armorHealthRatio", int(self._id_2A0E));
}

_id_FE25(var_0, var_1) {
  self endon("death_or_disconnect");

  if(var_1 == 0) {
    return;
  } else if(istrue(self._id_82E8)) {
    return 0;
  }

  if(!_id_874A()) {
    return;
  }
  if(self _meth_84B7()) {
    if(self _meth_84B7("iw8_ges_pickup_br")) {
      self _meth_8494("iw8_ges_pickup_br", 0, 1);
      wait 0.05;
    } else
      return;
  }

  var_2 = makeweapon("armor_plate_deploy_mp");
  var_3 = scripts\cp_mp\utility\killstreak_utility::_id_4056("", self);
  var_3._id_1B74 = var_2;
  thread _id_10AC3();
  _id_F2DB(1);
  var_4 = _id_09B9::_id_EC37(var_2, var_3, ::_id_82E6, undefined, ::_id_AA6F, undefined, undefined, self._id_7548);
}

_id_10AC3() {
  self endon("armor_plate_done");
  self endon("armor_repair_end");
  self endon("disconnect");
  scripts\engine\utility::_id_108C5("death", "last_stand_start");
  _id_F2DB(0);
}

_id_F2DB(var_0) {
  scripts\common\utility::_id_1587(!var_0);
  self allowmelee(!var_0);
  scripts\common\utility::_id_154F(!var_0);
  self._id_82E8 = var_0;
}

_id_AA6F(var_0, var_1) {
  if(!istrue(var_1)) {
    _id_F2DB(0);
    return;
  }
}

_id_AA70(var_0) {
  _id_F2DB(0);
}

_id_82E6(var_0) {
  self endon("death_or_disconnect");
  self endon("armor_repair_end");
  thread _id_10A8F();

  if(!_id_874A()) {
    self notify("try_armor_repair_cancel");
    return;
  }

  var_1 = gettime();

  if(self._id_7548) {
    var_2 = var_1 + 2800.0;
    var_3 = 3000.0;
    var_4 = 2800.0;
    var_5 = var_1 + 1125.0;
  } else {
    var_2 = var_1 + 1860.0;
    var_3 = 2000.0;
    var_4 = 1860.0;
    var_5 = 0;
  }

  while(var_1 < var_2) {
    if(self._id_7548 && var_1 > var_5) {
      self._id_7548 = 0;
      _id_1B5E();
    }

    if(!isDefined(var_0._id_1B74) || var_0._id_1B74 != self getcurrentweapon()) {
      return;
    }
    waitframe();
    var_1 = gettime();
  }

  _id_1B61();
  var_6 = (var_3 - var_4) / 1000;
  wait(var_6);

  while(_id_DB15()) {
    var_7 = self.equipment["health"];
    var_8 = scripts\mp\equipment::_id_6A15("health");

    if(isDefined(var_7) && isDefined(var_8) && var_8 > 0 && self._id_2A0E < self._id_2A7D) {
      var_9 = gettime() + 1250.0;

      while(gettime() < var_9) {
        if(!isDefined(var_0._id_1B74) || var_0._id_1B74 != self getcurrentweapon()) {
          return;
        }
        waitframe();
      }

      _id_1B61();
      var_10 = 0.25;
      wait(var_10);
      continue;
    }

    break;
  }

  self notify("armor_plate_done");
}

_id_874A() {
  if(isDefined(self.vehicle)) {
    var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A6(self.vehicle, self);

    if(var_0 == "driver") {
      return 0;
    }
  }

  if(self _meth_86B8()) {
    return 0;
  }

  if(self._id_2A0E == self._id_2A7D) {
    scripts\mp\hud_message::_id_DCA2(level._id_2A95._id_2A8E);
    return 0;
  }

  return 1;
}

_id_DB15() {
  var_0 = scripts\engine\utility::is_player_gamepad_enabled() && self _meth_876F();
  var_1 = isDefined(self._id_1B63) && self._id_1B63 > 0;
  return var_0 || var_1;
}

_id_10A8F() {
  self endon("armor_repair_end");
  self endon("death_or_disconnect");
  childthread _id_1B68();
}

_id_1B68() {
  self endon("armor_repair_end");
  self endon("disconnect");
  self notifyonplayercommand("try_armor_repair_cancel", "+weapnext");
  self notifyonplayercommand("try_armor_repair_cancel", "+weapprev");
  self notifyonplayercommand("try_armor_repair_cancel", "+attack");
  self notifyonplayercommand("try_armor_repair_cancel", "+smoke");
  self notifyonplayercommand("try_armor_repair_cancel", "+frag");
  self notifyonplayercommand("try_armor_repair_cancel", "+melee_zoom");
  scripts\engine\utility::_id_10884("death", "mantle_start", "try_armor_repair_cancel", "last_stand_start", "special_weapon_fired", "armor_plate_done");
  thread _id_1B6A();
}

_id_1B69() {
  self endon("armor_repair_end");
  self endon("try_use_heal_slot");
  self waittill("try_armor_repair_weapnext");
  waitframe();

  while(self _meth_876F()) {
    waitframe();
  }

  self notify("try_armor_repair_cancel");
}

_id_1B67() {
  self endon("armor_repair_end");
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    thread _id_1B6A();
  }
}

_id_1B6A() {
  self endon("disconnect");
  self _meth_824C("try_armor_repair_cancel", "+weapnext");
  self _meth_824C("try_armor_repair_cancel", "+attack");
  self _meth_824C("try_armor_repair_cancel", "+smoke");
  self _meth_824C("try_armor_repair_cancel", "+frag");
  self _meth_824C("try_armor_repair_cancel", "+melee_zoom");
  self notify("armor_repair_end");

  while(self._id_0133.basename == "armor_plate_deploy_mp") {
    waitframe();
  }

  waitframe();
  _id_F2DB(0);
}

_id_1B2F() {
  self endon("death_or_disconnect");

  while(self isswitchingweapon()) {
    waitframe();
  }

  if(self._id_0133.basename == "armor_plate_deploy_mp") {
    _id_09B9::_id_6CF6(self._id_0133);
  }

  thread _id_1B6A();
}