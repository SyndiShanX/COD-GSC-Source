/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1758.gsc
*************************************************/

init() {
  setdvarifuninitialized("#x3bf80a041ac321793", 0);
  level scripts\engine\utility::delaythread(0.05, ::_id_C8A0);
}

_id_C8A0() {
  level._id_C8A4 = spawnStruct();
  level._id_C8A4._id_32F8 = getscriptablearray("scriptable", "code_classname");

  if(!isDefined(level._id_C8A4._id_32F8) || level._id_C8A4._id_32F8.size <= 0) {
    return;
  }
  var_0 = 0;

  foreach(var_2 in level._id_C8A4._id_32F8) {
    if(var_0 > 19) {
      var_0 = 0;
      waitframe();
    }

    var_0 = var_0 + 1;

    if(scripts\common\utility::issp()) {
      if(!isDefined(var_2.model) || !var_2 _id_FF33()) {
        level._id_C8A4._id_32F8 = scripts\engine\utility::array_remove(level._id_C8A4._id_32F8, var_2);
        continue;
      }
    }

    if(!isDefined(var_2 _meth_8575("Anim_Explosion", 1)) && !isDefined(var_2 _meth_8575("Anim_PlayerStandRock", 1))) {
      level._id_C8A4._id_32F8 = scripts\engine\utility::array_remove(level._id_C8A4._id_32F8, var_2);
      continue;
    }

    var_2._id_01D7 = anglesToForward(var_2.angles);
    var_2._id_0376 = anglestoright(var_2.angles);

    if(!scripts\common\utility::issp()) {
      var_2._id_04BD = anglestoup(var_2.angles);
      var_2._id_5FE3 = var_2 _meth_8174(1, 0, 0);
      var_2._id_20AB = var_2 _meth_8174(-1, 0, 0);
      var_2._id_919E = var_2 _meth_8174(0, 1, 0);
      var_2._id_C865 = var_2 _meth_8174(0, -1, 0);
      var_2._id_F349 = var_2 _meth_8174(0, 0, 0.25);
      var_2._id_73BA = vectordot(var_2._id_01D7, var_2._id_5FE3 - var_2._id_20AB) / 2;
      var_2._id_73BE = vectordot(var_2._id_0376, var_2._id_C865 - var_2._id_919E) / 2;
      var_2.players = [];
      var_2._id_F397 = [];
      var_2._id_C8BF = [];
      var_2._id_C8BE = [];
    }

    var_2 thread _id_C89A();
    var_2 thread _id_C89D();
    var_2 thread _id_C89F();
  }

  level thread _id_1411();
}

_id_FF33() {
  if(isDefined(self._id_039B) && self._id_039B == "not_rockable") {
    return 0;
  }

  if(issubstr(self.model, "veh8_")) {
    return 1;
  } else {
    return 0;
  }
}

_id_C89D() {
  self endon("death");
  self endon("rocked");
  self setCanDamage(1);
  self._id_C8A3 = 0;
  self._id_C8A2 = "";

  for(;;) {
    self.health = 99999;
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    self._id_C8A3 = var_3;
    self._id_C8A2 = var_4;
    _id_BCE8(self.origin + (0, 0, 0), "Damage by: " + var_4 + " " + var_0, (1, 1, 1), 1, 0.25, 100);
  }
}

_id_C89F() {
  self endon("death");
  self waittillmatch("scriptableNotification", "anim_explosion");
  self notify("rocked");

  if(_func_010F(self._id_C8A2)) {
    var_0 = self._id_C8A3 - self.origin;
    var_1 = scripts\engine\utility::ter_op(vectordot(self._id_01D7, var_0) > 0, "front", "back");
    var_2 = scripts\engine\utility::ter_op(vectordot(self._id_0376, var_0) > 0, "right", "left");
    self setscriptablepartstate("Anim_Explosion", var_1 + "_" + var_2, 0);
    _id_BCE8(self.origin + (0, 0, -5), "Death by: " + self._id_C8A2, (1, 0, 0), 1, 0.25, 1000);
    _id_BCE8(self.origin + (0, 0, 12), "Animation: " + var_1 + "_" + var_2, (1, 1, 1), 1, 0.25, 1000);
  } else {
    var_3 = ["front_left", "front_right", "back_left", "back_right"];
    var_4 = var_3[randomint(var_3.size - 1)];
    self setscriptablepartstate("Anim_Explosion", var_4, 0);
    _id_BCE8(self.origin + (0, 0, -5), "Death by: " + self._id_C8A2, (1, 0, 0), 1, 0.25, 1000);
    _id_BCE8(self.origin + (0, 0, 5), "scripted explosion", (1, 0, 0), 1, 0.5, 500);
    _id_BCE8(self.origin + (0, 0, 10), "Animation: " + var_4, (1, 1, 1), 1, 0.25, 1000);
  }

  self waittillmatch("scriptableNotification", "anim_explosion_complete");
  thread _id_C89E();
}

_id_C89E() {
  self endon("death");

  for(;;) {
    self.health = 99999;
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(_func_010F(var_4) && var_0 > 10) {
      self setscriptablepartstate("Anim_Explosion", "rock", 1);
    }

    _id_BCE8(self.origin + (0, 0, 7), "Death animation: rock", (1, 1, 1), 1, 0.25, 1000);
    _id_BCE8(self.origin + (0, 0, 0), "Death damage by: " + var_4 + " " + var_0, (1, 1, 1), 1, 0.25, 150);
  }
}

_id_C89A() {
  self endon("death");

  if(getdvarint("#x3bf80a041ac321793")) {
    for(;;) {
      _id_BCE8(self.origin + (0, 0, 60), "rockable", (1, 1, 1), 1, 0.5, 2);
      waitframe();
      waitframe();
    }
  }
}

_id_1411() {
  level._id_141A = spawnStruct();
  level._id_141A._id_32F8 = level._id_C8A4._id_32F8;
  var_0 = 0;

  foreach(var_2 in level._id_141A._id_32F8) {
    if(var_0 > 19) {
      var_0 = 0;
      waitframe();
    }

    var_0 = var_0 + 1;

    if(!isDefined(var_2._id_039B) || var_2._id_039B != "car_alarm" || !isDefined(var_2 _meth_8679("Car_Alarm"))) {
      level._id_141A._id_32F8 = scripts\engine\utility::array_remove(level._id_141A._id_32F8, var_2);
      continue;
    }

    var_2 thread _id_1410();
  }
}

_id_1410() {
  self endon("death");
  self endon("rocked");
  self endon("stop_alarm");
  self setCanDamage(1);
  self._id_141B = 0;
  thread _id_140F();

  for(;;) {
    self.health = 99999;
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    _id_BCE8(self.origin + (0, 0, -7), "Alarm damage by: " + var_4 + " " + var_0, (1, 1, 1), 1, 0.25, 150);
    self._id_141B = self._id_141B + var_0;
    waitframe();

    if(self._id_141B > 200) {
      self setscriptablepartstate("Car_Alarm", "on", 0);
      level notify("car_alarm", self);
      break;
    }
  }
}

_id_140F() {
  self endon("death");

  if(getdvarint("#x3bf80a041ac321793")) {
    for(;;) {
      _id_BCE8(self.origin + (0, 0, 70), "alarm.dmg: " + self._id_141B, (1, 1, 1), 1, 0.5, 2);
      waitframe();
      waitframe();
    }
  }
}

_id_BCE8(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(getdvarint("#x3bf80a041ac321793")) {
    return;
  }
}