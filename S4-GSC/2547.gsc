/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2547.gsc
*************************************************/

init() {}

_id_A8F2() {
  _id_44EE("Use Objective: Setup");
  level._effect["vfx/iw8/level/highway/vfx_suicidetruck_explosion.vfx"] = loadfx("vfx/iw8/level/highway/vfx/iw8/level/highway/vfx_suicidetruck_explosion.vfx");
  _id_8241();
}

_id_44EE(var_0) {
  if(1) {
    return;
  }
}

_id_8241() {
  var_0 = scripts\engine\utility::getStructArray("computer_location", "targetname");
  var_1 = var_0[randomint(var_0.size)];
  level._id_A890 = var_1 _id_406C(var_1.origin, var_1.angles, "intel_laptop", &"MP_ESCAPE_MODE/PULL_WMD_DATA_CORE", "objectUsed");
  level._id_A890._id_4140 = level._id_A890.origin;
  level._id_A890._id_A97E = (0, 0, 30);

  if(!isDefined(level._id_A890._id_A908) || level._id_A890._id_A908 < 0) {
    level._id_A890 _id_07D6::_id_C579(1, 1);
    _id_D89A(level._id_A890, "MP_ESCAPE_MODE/WMD");
  }
}

_id_D89A(var_0, var_1) {
  var_2 = var_0._id_A908;
  _func_016B(var_2, "invisible");
  _func_0167(var_2, var_1);
  _func_0161(var_2, 30);
  _func_015D(var_2, "icon_waypoint_marker");
  _func_0172(var_2, 0);
  _func_0174(var_2, 1);
  _func_018C(var_2);
  _func_017A(var_2, 1);
  _func_0163(var_2, var_0.origin + (0, 0, 50));
  _func_016B(var_2, "current");
}

_id_10BB3(var_0) {
  level endon("game_ended");
  var_0 endon("death_or_disconnect");

  for(;;) {
    var_0 waittill("objectUsed", var_1);
    _id_A746(var_0, var_1);
  }
}

_id_DCCE(var_0) {
  if(!isDefined(level._id_A890)) {
    return;
  }
  thread scripts\mp\gametypes\arm::_id_B8A4(var_0);

  foreach(var_2 in scripts\mp\utility\player::_id_6DC4(var_0.team)) {
    _func_0185(level._id_A890._id_A908, var_2);
  }

  if(!istrue(level._id_A744)) {
    level._id_A743 = 1;

    foreach(var_5 in level.players) {
      if(var_5.team != var_0.team) {
        continue;
      }
    }
  }
}

_id_790A() {
  foreach(var_1 in level.players) {
    _func_0189(level._id_A890._id_A908, var_1);
  }
}

_id_790B(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(level._id_A890)) {
    return;
  }
  _func_0189(level._id_A890._id_A908, var_0);
  thread _id_10BB3(var_0);
}

_id_A746(var_0, var_1) {
  setgameendtime(0);
  level._id_CC0B = 1;
  wait 3;
  var_2 = 10 - level.players.size;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = vectornormalize(var_0 getEye() - var_1.origin);
    var_5 = var_1.origin + (randomfloat(1024), randomfloat(1024), 0);
    playFX(level._effect["vfx/iw8/level/highway/vfx_suicidetruck_explosion.vfx"], var_5, var_4);
    earthquake(0.245, 2.2, var_5, 50000);
    playrumbleonposition("damage_heavy", var_5);
    wait(0.5 + randomfloat(0.5));
  }

  foreach(var_7 in level.players) {
    if(var_7.team == var_0.team) {
      continue;
    }
    var_4 = vectornormalize(var_7 getEye() - var_0.origin);
    playFX(level._effect["vfx/iw8/level/highway/vfx_suicidetruck_explosion.vfx"], var_7.origin, var_4);
    earthquake(0.245, 2.2, var_7.origin, 50000);
    playrumbleonposition("damage_heavy", var_7.origin);
    wait(0.5 + randomfloat(0.5));
    var_7 _meth_81FA();
  }

  thread _id_B8A5(var_0);
  wait 5;
  level._id_5AA3 = var_0.team;
  thread scripts\mp\gamelogic::_id_52F7(var_0.team, game["end_reason"]["target_destroyed"], undefined, 1, 0);
}

_id_406C(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  var_5 = spawn("script_model", var_0);
  var_5 setnodeploy(1);
  var_5._id_0481 = "useableObject";
  var_5 setModel(var_2);
  var_5.angles = var_1;
  var_5._id_FE90 = _id_07D6::_id_3FF0(var_5.origin + anglestoup(var_5.angles) * 7, "HINT_BUTTON", undefined, var_3, -300, undefined, "show", 250, 160, 200, 160);
  var_5._id_FE90 linkto(var_5);
  var_5._id_FE90._id_10851 = var_4;

  foreach(var_7 in level.players) {
    var_5._id_FE90 disableplayeruse(var_7);
  }

  var_5 thread _id_FEE6();
  return var_5;
}

_id_FEE6() {
  self endon("restarting_physics");
  var_0 = self._id_FE90;
  var_1 = undefined;

  if(istrue(level.gameended) && !isDefined(var_0)) {
    return;
  }
  while(isDefined(self)) {
    var_0 waittill("trigger", var_2);
    var_2._id_8ACB = 1;
    var_1 = _id_406D();
    var_1._id_7C8C = "use";
    var_3 = var_1 _id_FE7D(var_2, 15);

    if(!isDefined(var_2)) {
      return;
    }
    if(!var_3) {
      var_2._id_8ACB = 0;
      continue;
    }

    var_2._id_8ACB = 0;
    var_2 notify(var_0._id_10851, self);
  }
}

_id_FE7D(var_0, var_1) {
  scripts\mp\movers::_id_CDD8(var_0);
  var_0 scripts\common\utility::_id_158D(0);
  self._id_4143 = 0;
  self._id_84EF = 1;
  self._id_FEB1 = 0;
  self._id_FEE7 = var_1;
  var_2 = _id_FE7F(var_0);

  if(isalive(var_0)) {
    var_0 scripts\common\utility::_id_158D(1);
  }

  if(isDefined(var_0)) {
    scripts\mp\movers::_id_CDE7(var_0);
  }

  if(!isDefined(self)) {
    return 0;
  }

  self._id_84EF = 0;
  self._id_4143 = 0;
  return var_2;
}

_id_FE7F(var_0) {
  while(var_0 _id_89A3(self)) {
    if(!var_0 scripts\mp\movers::_id_CDE8(self)) {
      var_0 _id_07D6::_id_FD75(self, 0);
      return 0;
    }

    self._id_4143 = self._id_4143 + level._id_5F3A * self._id_FEB1;

    if(isDefined(self._id_A8EC)) {
      self._id_FEB1 = 1 * self._id_A8EC;
    } else {
      self._id_FEB1 = 1;
    }

    var_0 _id_07D6::_id_FD75(self, 1);

    if(self._id_4143 >= self._id_FEE7) {
      var_0 _id_07D6::_id_FD75(self, 0);
      return scripts\mp\utility\player::isreallyalive(var_0);
    }

    waitframe();
  }

  if(isDefined(self)) {
    var_0 _id_07D6::_id_FD75(self, 0);
  }

  return 0;
}

_id_406D() {
  var_0 = spawn("script_origin", self.origin);
  var_0._id_4143 = 0;
  var_0._id_FEE7 = 0;
  var_0._id_FEB1 = 3000;
  var_0._id_84EF = 0;
  var_0._id_7C8C = self._id_7C8C;
  var_0 linkto(self);
  var_0 thread _id_479C(self);
  return var_0;
}

_id_479C(var_0) {
  self endon("death");
  var_0 waittill("death");

  if(isDefined(self._id_FE45)) {
    foreach(var_2 in self._id_FE45) {
      var_2 setclientomnvar("ui_securing", 0);
      var_2._id_F913 = undefined;
    }
  }

  self delete();
}

_id_89A3(var_0) {
  return !level.gameended && isDefined(var_0) && scripts\mp\utility\player::isreallyalive(self) && self useButtonPressed() && !self isonladder() && !self meleeButtonPressed() && var_0._id_4143 < var_0._id_FEE7 && (!isDefined(self._id_F03B) || !self._id_F03B);
}

_id_B8A5(var_0) {
  scripts\mp\gametypes\arm::_id_B8BB(var_0, "extract_littlebird_start_a_friendly", 10);
  scripts\mp\gametypes\arm::_id_B35D(var_0, "extract_littlebird_start_a_friendly", 20);
}