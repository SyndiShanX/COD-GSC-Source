/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_76b7d1126b57b69c.gsc
***********************************************/

_id_9E3F4898DB5D314E(callback) {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("enemy_on_compass");
  self[[callback]]();
}

_id_E23DCF42AAE58DAD(_id_3777ECE6A73EADA5, callback, _id_16C5559B456AC301) {
  level endon("game_ended");
  self endon("disconnect");

  foreach(enemy in level.players) {
    if(isDefined(_id_16C5559B456AC301) && _id_16C5559B456AC301) {
      if(!isbot(enemy))
        continue;
    }

    _id_3482E3D6BB34C1BF(enemy, _id_3777ECE6A73EADA5, callback);
  }
}

_id_3482E3D6BB34C1BF(enemy, _id_3777ECE6A73EADA5, callback) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("ftue_enemy_loot_viewed");
  self._id_EE280D08E9B9729D = callback;

  if(!isalliedsentient(self, enemy)) {
    foreach(item in enemy._id_D2DBB2FA012E6D9C) {
      if(!isDefined(item)) {
        continue;
      }
      childthread _id_67E2C9BD89ED9289::_id_683C095E6767C4C8(item.origin, _id_3777ECE6A73EADA5, ::_id_D138A208396BB595);
    }
  }
}

_id_EC7F69BBA0F79EE7(callback, _id_16C5559B456AC301) {
  level endon("game_ended");
  self endon("disconnect");

  foreach(enemy in level.players) {
    if(isDefined(_id_16C5559B456AC301) && _id_16C5559B456AC301) {
      if(!isbot(enemy))
        continue;
    }

    _id_8441DAA65AC853D9(enemy, callback);
  }
}

_id_8441DAA65AC853D9(enemy, callback) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isalliedsentient(self, enemy)) {
    foreach(item in enemy._id_D2DBB2FA012E6D9C) {
      if(!isDefined(item)) {
        continue;
      }
      thread _id_54532A3F6BFC04E8(item, callback);
    }
  }
}

_id_D138A208396BB595() {
  level endon("game_ended");
  self endon("disconnect");
  self[[self._id_EE280D08E9B9729D]]();
  self notify("ftue_enemy_loot_viewed");
}

_id_54532A3F6BFC04E8(item, callback) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("ftue_enemy_loot_picked");
  _id_06A1457B04B003EC = item.origin;
  level waittill("pickedupweapon_kill_callout_" + item.type + item.origin);
  _id_78B3A92FCADD7914 = distance2d(_id_06A1457B04B003EC, self.origin) / 2;

  if(_id_78B3A92FCADD7914 < 100) {
    self[[callback]]();
    self notify("ftue_enemy_loot_picked");
  }
}