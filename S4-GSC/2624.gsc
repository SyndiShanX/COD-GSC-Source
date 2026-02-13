/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2624.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::_id_C26A("emp", ::_id_F77D);
}

_id_F77C() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::_id_4056("emp", self);
  return _id_F77D(var_0);
}

_id_F77D(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      return 0;
    }
  }

  var_1 = _id_09B9::_id_EA01(var_0, makeweapon("s4_ks_gesture_generic_mp"));

  if(!istrue(var_1)) {
    return 0;
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      return 0;
    }
  }

  thread _id_E6A4();

  if(isDefined(level._id_8DD3)) {
    level thread[[level._id_8DD3]](self.streakinfo);
  }

  return 1;
}

_id_E6A4() {
  level endon("game_ended");
  var_0 = scripts\cp_mp\utility\killstreak_utility::_id_6ADB();
  var_1 = 3000;

  if(isDefined(var_0)) {
    var_1 = var_0.origin[2] + 500;
  }

  var_2 = level._id_9AAC * (1, 1, 0) + (0, 0, var_1);
  playFX(scripts\engine\utility::getfx("emp_shockwave"), var_2);
  self playSound("jammer_drone_shockwave");

  foreach(var_4 in level.players) {
    if(!scripts\mp\utility\player::isreallyalive(var_4)) {
      continue;
    }
    var_4 thread _id_19CF();
  }

  var_6 = scripts\mp\utility\teams::_id_6A01(self.owner.team);

  foreach(var_8 in var_6) {
    _id_483E(var_8, self);
  }
}

_id_19CF() {
  self setscriptablepartstate("emped", "active", 0);
  self playLoopSound("emp_nade_lp");
  thread _id_19D0();
  wait 0.5;
  self setscriptablepartstate("emped", "neutral", 0);
  self playSound("emp_nade_lp_end");
  self stoploopsound("emp_nade_lp");
}

_id_19D0() {
  visionsetnaked("coup_sunblind", 0.05);
  waitframe();
  visionsetnaked("coup_sunblind", 0);
  visionsetnaked("", 0.5);
}

_id_483E(var_0, var_1) {
  var_2 = "s4_v2_mp";
  var_3 = level._id_0F4C;
  var_4 = [[level._id_6885]]();
  var_5 = undefined;

  if(isDefined(var_3) && isDefined(var_4)) {
    var_5 = scripts\engine\utility::_id_1B9D(var_3, var_4);
  } else if(isDefined(var_3)) {
    var_5 = var_3;
  } else if(isDefined(var_4)) {
    var_5 = var_4;
  }

  if(isDefined(var_5)) {
    foreach(var_7 in var_5) {
      if(isDefined(var_7)) {
        var_7 scripts\mp\utility\killstreak::_id_4C56(10000, var_1, var_1, var_0, var_7.origin, "MOD_EXPLOSIVE", var_2);
      }
    }
  }
}