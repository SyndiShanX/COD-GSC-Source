/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1570.gsc
**************************************/

main() {
  if(isDefined(level._id_3E86)) {
    level._effect["air_support_marker"] = loadfx("smoke/signal_smoke_air_support_paris_ac130");
  } else {
    level._effect["air_support_marker"] = loadfx("smoke/signal_smoke_air_support");

  }
  level._effect["air_support_trail"] = loadfx("smoke/smoke_geotrail_air_support");

  if(isDefined(level._id_3E87)) {
    level._effect["air_support_sticky_marker"] = level._id_3E87;

  }
  if(isDefined(level._id_3E88)) {
    level._effect["air_support_marker_enemy"] = level._id_3E88;

  }
  if(isDefined(level._id_3E89)) {
    level._effect["air_support_trail_enemy"] = level._id_3E89;

  }
  level._id_3E8A = "ac130_40mm_air_support_strobe";
  precacheitem(level._id_3E8A);
  precacheitem("air_support_strobe");
  precacherumble("ac130_artillery_rumble");
  common_scripts\utility::flag_init("flag_strobes_in_use");
  level._id_3E8B = [];
  level._id_03B8 = 0;
  thread _id_3E91();

  foreach(var_1 in level.players) {
    var_1 maps\_utility::_id_1402("flag_strobe_ready");
    var_1 thread _id_3EB9();
  }

  maps\_utility::_id_25F1("autosave_check_air_support_strobe_not_in_use", ::_id_03B9, "Can't save because an air support strobe is in use");
}

_id_03B9() {
  return level._id_03B8 == 0;
}

_id_3E8C(var_0) {
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = var_0;
  thread _id_3E95(var_1);
  _id_3E9E(var_1);
}

_id_3E8D() {
  self notify("stop_strobe_tracking");
  self endon("stop_strobe_tracking");
  self giveweapon("air_support_strobe");
  self setweaponammoclip("air_support_strobe", 99);
  self setactionslot(4, "weapon", "air_support_strobe");
  maps\_utility::_id_13DC("flag_strobe_ready");
  var_0 = 18;

  if(isDefined(level._id_3E8E)) {
    var_0 = level._id_3E8E;

  }
  var_1 = weaponfiretime("air_support_strobe") - 0.05;

  for(;;) {
    self waittill("grenade_fire", var_2, var_3);
    var_2.owner = self;

    if(var_3 == "air_support_strobe") {
      var_2 thread _id_3E98();
      wait(var_1);
      maps\_utility::_id_13DE("flag_strobe_ready");
      self takeweapon("air_support_strobe");
      _id_3EBA();
      wait(var_0 - var_1);
      self giveweapon("air_support_strobe");
      self setweaponammoclip("air_support_strobe", 99);
      self setactionslot(4, "weapon", "air_support_strobe");
      refreshhudammocounter();
      maps\_utility::_id_13DC("flag_strobe_ready");
      level notify("air_support_strobe_ready");
    }
  }
}

_id_3E8F() {
  self takeweapon("air_support_strobe");
  _id_3EBA();
  self notify("stop_strobe_tracking");
  maps\_utility::_id_13DE("flag_strobe_ready");
}

_id_3E90() {
  thread _id_3E8D();
}

_id_3E91() {
  var_0 = 2.5;

  if(isDefined(level._id_3E92)) {
    var_0 = level._id_3E92;

  }
  for(;;) {
    var_1 = _id_3E9F();

    if(var_1 _id_3EA7() || isDefined(level._id_3E93) && level._id_3E93) {
      level notify("air_suport_strobe_fired_upon", var_1);
      thread _id_3EB3(8);

      if(!isDefined(level._id_3E94) || !level._id_3E94) {
        var_1 thread _id_3E96();

      }
      wait(var_0);
      var_1 _id_3EA8();
      continue;
    }

    level notify("air_support_strobe_no_targets");
    wait 1;
  }
}

_id_3E95(var_0) {
  level notify("air_support_strobe_thrown", var_0);
  level endon("air_support_strobe_thrown");
  common_scripts\utility::flag_set("flag_strobes_in_use");
  wait 5;

  for(;;) {
    while(!_id_3EA0()) {
      wait 1;

    }
    wait 10;

    if(_id_3EA0()) {
      break;
    }
  }

  common_scripts\utility::flag_clear("flag_strobes_in_use");
}

_id_3E96() {
  self endon("death");
  var_0 = 5.8;

  if(isDefined(level._id_3E97)) {
    var_0 = 3;

  }
  wait(var_0);
  var_1 = 512;
  var_2 = 400;
  var_3 = 11 - var_0;
  badplace_cylinder("", var_3, self.origin - (0, 0, var_1 / 2), var_2, var_1, "axis");
  level._id_3E97 = 1;
}

_id_3E98(var_0) {
  self endon("death");
  thread _id_03BA();
  thread _id_3E95(self);
  self._id_3E99 = common_scripts\utility::spawn_tag_origin();
  self._id_3E99 linkto(self);
  wait 0.1;

  if(isDefined(var_0) && var_0) {
    playFXOnTag(common_scripts\utility::getfx("air_support_trail_enemy"), self._id_3E99, "tag_origin");
    self._id_3E9A = 1;
  } else {
    playFXOnTag(common_scripts\utility::getfx("air_support_trail"), self._id_3E99, "tag_origin");

  }
  wait 2.35;
  var_1 = 0.5;
  var_2 = gettime() + var_1 * 1000;
  var_3 = self.origin;

  while(gettime() < var_2) {
    common_scripts\utility::waitframe();
    var_4 = (self.origin - var_3) * 20;
    var_3 = self.origin;

    if(var_4[2] >= 0) {
      break;
    }
  }

  var_5 = bulletTrace(self.origin, self.origin + (0, 0, -1024), 1, undefined, 1);

  if(isDefined(var_5["position"])) {
    self.origin = var_5["position"];

  }
  if(isDefined(self._id_3E9B) && self._id_3E9B) {
    thread _id_3E9C();
  } else if(isDefined(var_0) && var_0) {
    playFX(common_scripts\utility::getfx("air_support_marker_enemy"), self.origin);
  } else {
    playFX(common_scripts\utility::getfx("air_support_marker"), self.origin);

  }
  _id_3E9E(self);
  var_6 = 512;
  var_7 = 650;
  badplace_cylinder("", 9.5, self.origin - (0, 0, var_6 / 2), var_7, var_6, "allies");
  wait 15;

  if(isDefined(self._id_3E99)) {
    if(isDefined(var_0) && var_0) {
      stopFXOnTag(common_scripts\utility::getfx("air_support_marker_enemy"), self._id_3E99, "tag_origin");
    } else {
      stopFXOnTag(common_scripts\utility::getfx("air_support_marker"), self._id_3E99, "tag_origin");

    }
    self._id_3E99 delete();
  }

  self delete();
}

_id_03BA() {
  if(!isDefined(self)) {
    return;
  }
  level._id_03B8++;
  self waittill("death");
  wait 4;
  level._id_03B8--;
}

_id_3E9C() {
  self endon("death");
  var_0 = 5;
  var_1 = 0.3;

  for(var_2 = 0; var_2 <= var_0 / var_1; var_2++) {
    if(isDefined(self._id_3E99)) {
      playFXOnTag(common_scripts\utility::getfx("air_support_sticky_marker"), self._id_3E99, "tag_origin");
      wait(var_1);
      continue;
    }

    break;
  }

  wait 1;
  stopFXOnTag(common_scripts\utility::getfx("air_support_sticky_marker"), self._id_3E99, "tag_origin");
}

_id_3E9D(var_0) {
  self endon("death");
  self unlink();
  self rotateto((0, 0, 90), 0.05);

  while(isDefined(var_0) && isDefined(var_0.origin)) {
    self moveto(var_0.origin, 0.05);
    common_scripts\utility::waitframe();
  }
}

_id_3E9E(var_0) {
  level._id_3E8B[level._id_3E8B.size] = var_0;
  level notify("air_support_strobe_popped", var_0);
}

_id_3E9F() {
  for(level._id_3E8B = common_scripts\utility::array_removeundefined(level._id_3E8B); level._id_3E8B.size == 0; level._id_3E8B = common_scripts\utility::array_removeundefined(level._id_3E8B)) {
    level waittill("air_support_strobe_popped", var_0);

  }
  return level._id_3E8B[0];
}

_id_3EA0() {
  return level._id_3E8B.size == 0;
}

_id_3EA1(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    level._id_3EA2 = var_1;

  }
  if(isDefined(var_2)) {
    level._id_3EA3 = var_2;

  }
  level._id_3EA4 = var_0;
}

_id_3EA5() {
  if(isDefined(level._id_3EA4) && isalive(level._id_3EA4)) {
    var_0 = level._id_3EA4.origin;

    if(isDefined(level._id_3EA3)) {
      var_0 = level._id_3EA4 gettagorigin(level._id_3EA3);

    }
    if(isDefined(level._id_3EA2)) {
      var_1 = level.player getEye();

      if(var_0[2] > level._id_3EA2 && var_1[2] < level._id_3EA2) {
        var_2 = (level._id_3EA2 - var_1[2]) / (var_0[2] - var_1[2]);
        var_0 = maps\_utility::_id_281D(var_2, level.player.origin, var_0);
      }
    }

    return var_0;
  } else {
    return self.origin + (30, 15, 12000);
  }
}

_id_3EA6() {
  return _id_3EA5();
}

_id_3EA7() {
  var_0 = _id_3EAD(self.origin, _id_3EA5());
  var_0 = _id_3EB0(var_0, _id_3EA6());
  return var_0.size > 0;
}

_id_3EA8() {
  self endon("death");

  if(!isDefined(self)) {
    return;
  }
  var_0 = 10;
  var_1 = 200;
  var_2 = 60 / var_1;
  maps\_audio::aud_send_msg("ac130_prepare_inc");

  for(var_3 = 0; var_3 < var_0; var_3++) {
    var_4 = _id_3EA5();
    var_5 = _id_3EA6();
    var_6 = _id_3EAD(self.origin, var_4);
    var_6 = _id_3EB0(var_6, var_5);
    var_7 = _id_3EAF(var_6, var_3, var_0);

    if(!isDefined(var_7)) {
      var_7 = self.origin + _id_3EB1(32);

    }
    if(isDefined(self._id_3E9A)) {
      var_8 = magicbullet(level._id_3E8A, var_4, var_7);
    } else {
      var_8 = magicbullet(level._id_3E8A, var_4, var_7, self.owner);

    }
    var_8 thread _id_3EAC(0.3, 0.5, 1200);
    var_9 = spawnStruct();
    var_9._id_3EA9 = var_7;
    var_9._id_3EAA = var_2;
    var_9._id_3EAB = var_8;
    maps\_audio::aud_send_msg("aud_ac130_bullet", var_9);
    wait(var_2);
  }

  if(isDefined(self._id_3E99)) {
    stopFXOnTag(common_scripts\utility::getfx("air_support_marker"), self._id_3E99, "tag_origin");
    self._id_3E99 delete();
  }

  self delete();
}

_id_3EAC(var_0, var_1, var_2) {
  var_3 = self.origin;

  while(isDefined(self)) {
    var_3 = self.origin;
    wait 0.1;
  }

  earthquake(var_0, var_1, var_3, var_2);
  playrumbleonposition("ac130_artillery_rumble", var_3);
}

_id_3EAD(var_0, var_1) {
  var_2 = 512;
  var_3 = 32;
  var_4 = 64;
  var_5 = 7500;
  var_6 = 1.1;
  var_7 = distance(var_0, var_1) / var_5 * var_6;
  var_8 = [];
  var_8[var_8.size] = var_0 + _id_3EB1(var_4);

  foreach(var_10 in vehicle_getarray()) {
    if(!isDefined(var_10._id_3EAE) && distance2d(var_10.origin, var_0) < var_2) {
      var_8[var_8.size] = var_10.origin + var_10 vehicle_getvelocity() * var_7 + _id_3EB1(var_3);
    }
  }

  foreach(var_13 in getaiarray("axis", "neutral")) {
    if(isalive(var_13) && !isDefined(var_13._id_3EAE) && distance(var_13.origin, var_0) < var_2) {
      var_8[var_8.size] = var_13.origin + _id_3EB1(var_3);
    }
  }

  return var_8;
}

_id_3EAF(var_0, var_1, var_2) {
  var_3 = 512;
  var_4 = self.origin + vectornormalize(self.origin - level.player.origin) * var_3;
  var_5 = self.origin + vectornormalize(level.player.origin - self.origin) * var_3;
  var_6 = vectorlerp(var_4, var_5, var_1 / var_2);
  var_7 = 9999999;
  var_8 = undefined;

  foreach(var_10 in var_0) {
    var_11 = distance2d(var_6, var_10);

    if(var_11 < var_7) {
      var_7 = var_11;
      var_8 = var_10;
    }
  }

  return var_8;
}

_id_3EB0(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(_id_3EB2(var_1, var_4)) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_3EB1(var_0) {
  return common_scripts\utility::randomvectorrange(0, var_0) * (1, 1, 0);
}

_id_3EB2(var_0, var_1) {
  return bullettracepassed(var_0, var_1 + (0, 0, 128), 0, undefined);
}

_id_3EB3(var_0) {
  level notify("air_support_strobe_stop_damage_watcher");
  level._id_3EB4 = 0;
  level._id_3EB5 = 0;

  foreach(var_2 in getaiarray("axis")) {}
  var_2 thread _id_3EB7();

  foreach(var_5 in vehicle_getarray()) {
    if(isDefined(var_5.script_team) && var_5.script_team == "axis") {
      var_5 thread _id_3EB7();
    }
  }

  wait(var_0);
  level notify("air_support_strobe_stop_damage_watcher");
  level notify("air_support_strobe_killed", level._id_3EB4);
}

_id_3EB6() {
  return level._id_3EB4;
}

_id_3EB7() {
  level endon("air_support_strobe_stop_damage_watcher");

  if(self.health <= 0) {
    return;
  }
  while(isDefined(self)) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    var_10 = 0;

    if(isDefined(self._id_163B)) {
      var_10 = self._id_163B;

    }
    if(isDefined(var_9) && var_9 == level._id_3E8A && (isDefined(self) && isDefined(self.health) && self.health <= var_10 && self.health + var_0 > var_10) && !maps\_vehicle::_id_1C06()) {
      level._id_3EB4++;

      if(isDefined(level._id_3EB8) && self == level._id_3EB8) {
        level._id_3EB5 = 1;

      }
      return;
    } else if(!isDefined(self) || !isDefined(self.health) || self.health <= var_10) {
      return;
    }
  }
}

_id_3EB9() {
  self endon("death");
  var_0 = self getcurrentweapon();
  self._id_3BF2 = var_0;

  for(;;) {
    var_0 = self getcurrentweapon();
    self waittill("weapon_change", var_1);
    self._id_3BF2 = var_0;
    var_0 = var_1;
  }
}

_id_3EBA() {
  if(self getcurrentweapon() == "none") {
    var_0 = 0;

    if(isDefined(self._id_3BF2) && self._id_3BF2 != "none" && self hasweapon(self._id_3BF2)) {
      var_0 = self switchtoweapon(self._id_3BF2);
    } else {
      var_1 = self getweaponslistprimaries();

      if(var_1.size > 0) {
        var_0 = self switchtoweapon(var_1[0]);
      }
    }
  }
}