/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2651.gsc
*************************************************/

init() {
  level._id_9F7D = 14000;
  level._id_9F7B = 7000;
  level._id_9F7C = 1500;
  level._id_C8B8 = [];
  level._id_C340["explode"] = loadfx("vfx/core/expl/aerial_explosion");
}

_id_F797(var_0, var_1) {
  scripts\mp\utility\player::_id_D8D4("remotemissile");
  var_2 = scripts\mp\killstreaks\killstreaks::_id_827A();

  if(var_2 != "success") {
    if(var_2 != "disconnect") {
      scripts\mp\utility\player::_id_3990();
    }

    return 0;
  }

  self setclientomnvar("ui_predator_missile", 1);
  level thread _id_0BE6(var_0, self);
  return 1;
}

_id_6919(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_3._id_FF63 = [];
    var_3._id_E367 = 0;
  }

  foreach(var_6 in level.players) {
    if(!scripts\mp\utility\player::isreallyalive(var_6)) {
      continue;
    }
    if(var_6.team == self.team) {
      continue;
    }
    if(var_6.team == "spectator") {
      continue;
    }
    var_7 = 999999999;
    var_8 = undefined;

    foreach(var_3 in var_0) {
      var_3._id_FF63[var_3._id_FF63.size] = var_6;
      var_10 = distance2d(var_3._id_EEA2.origin, var_6.origin);

      if(var_10 <= var_7) {
        var_7 = var_10;
        var_8 = var_3;
      }
    }

    var_8._id_E367 = var_8._id_E367 + 2;
  }

  var_13 = var_0[0];

  foreach(var_3 in var_0) {
    foreach(var_6 in var_3._id_FF63) {
      var_3._id_E367 = var_3._id_E367 + 1;

      if(scripts\engine\trace::_bullet_trace_passed(var_6.origin + (0, 0, 32), var_3.origin, 0, var_6)) {
        var_3._id_E367 = var_3._id_E367 + 3;
      }

      if(var_3._id_E367 > var_13._id_E367) {
        var_13 = var_3;
        continue;
      }

      if(var_3._id_E367 == var_13._id_E367) {
        if(scripts\engine\utility::cointoss()) {
          var_13 = var_3;
        }
      }
    }
  }

  return var_13;
}

_id_0BE6(var_0, var_1) {
  var_2 = getEntArray("remoteMissileSpawn", "targetname");

  foreach(var_4 in var_2) {
    if(isDefined(var_4.target)) {
      var_4._id_EEA2 = getent(var_4.target, "targetname");
    }
  }

  if(var_2.size > 0) {
    var_6 = var_1 _id_6919(var_2);
  } else {
    var_6 = undefined;
  }

  if(isDefined(var_6)) {
    var_7 = var_6.origin;
    var_8 = var_6._id_EEA2.origin;
    var_9 = vectornormalize(var_7 - var_8);
    var_7 = var_9 * 14000 + var_8;
    var_10 = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("remotemissile_projectile_mp"), var_7, var_8, var_1);
  } else {
    var_11 = (0, 0, level._id_9F7D);
    var_12 = level._id_9F7B;
    var_13 = level._id_9F7C;
    var_14 = anglesToForward(var_1.angles);
    var_7 = var_1.origin + var_11 + var_14 * var_12 * -1;
    var_8 = var_1.origin + var_14 * var_13;
    var_10 = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("remotemissile_projectile_mp"), var_7, var_8, var_1);
  }

  if(!isDefined(var_10)) {
    var_1 scripts\mp\utility\player::_id_3990();
    return;
  }

  var_10.team = var_1.team;
  var_10 thread _id_742F();
  var_10._id_936C = var_0;
  var_10.type = "remote";
  level._id_C341 = 1;
  _id_9F6D(var_1, var_10);
}

_id_742F() {
  self endon("death");
  self endon("deleted");
  self setCanDamage(1);

  for(;;) {
    self waittill("damage");
  }
}

_id_9F6D(var_0, var_1) {
  var_0 endon("joined_team");
  var_0 endon("joined_spectators");
  var_1 thread _id_C8A7();
  var_0 thread _id_B3ED(var_1);
  var_0 thread _id_B3EE(var_1);
  var_0 visionsetmissilecamforplayer("black_bw", 0);
  var_0 endon("disconnect");

  if(isDefined(var_1)) {
    var_0 visionsetmissilecamforplayer(game["thermal_vision"], 1.0);
    var_0 _meth_840B();
    var_0 thread _id_46BE();
    var_0 cameralinkto(var_1, "tag_origin");
    var_0 _meth_8094(var_1);

    if(getdvarint("#x36c8f5946a1247e70")) {
      var_0 scripts\mp\utility\player::setthirdpersondof(0);
    }

    var_1 waittill("death");
    var_0 _meth_840A();

    if(isDefined(var_1)) {
      var_0 scripts\common\utility::_id_F73A(level._id_9BB4, "predator_missile", var_1.origin);
    }

    var_0 _meth_8095();
    var_0 scripts\mp\utility\player::_freezecontrols(1);

    if(!level.gameended) {
      var_0 setclientomnvar("ui_predator_missile", 2);
    }

    wait 0.5;
    var_0 _meth_8060();

    if(getdvarint("#x36c8f5946a1247e70")) {
      var_0 scripts\mp\utility\player::setthirdpersondof(1);
    }
  }

  var_0 setclientomnvar("ui_predator_missile", 0);
  var_0 scripts\mp\utility\player::_id_3990();
}

_id_46BE() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait 0.15;
}

_id_B3EE(var_0) {
  var_0 endon("death");
  self endon("disconnect");
  scripts\engine\utility::waittill_any_2("joined_team", "joined_spectators");

  if(self.team != "spectator") {
    self _meth_8095();
    self _meth_8060();

    if(getdvarint("#x36c8f5946a1247e70")) {
      scripts\mp\utility\player::setthirdpersondof(1);
    }
  }

  scripts\mp\utility\player::_id_3990();
  level._id_C341 = undefined;
}

_id_C8A7() {
  var_0 = self getentitynumber();
  level._id_C8B8[var_0] = self;
  self waittill("death");
  level._id_C8B8[var_0] = undefined;
  level._id_C341 = undefined;
}

_id_B3ED(var_0) {
  var_0 endon("death");
  self endon("death");
  level waittill("game_ended");
  self _meth_8095();
  self _meth_8060();

  if(getdvarint("#x36c8f5946a1247e70")) {
    scripts\mp\utility\player::setthirdpersondof(1);
  }
}