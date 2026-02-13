/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2672.gsc
*************************************************/

init() {
  level._effect["vfx_spawn_beacon_smoke"] = loadfx("vfx/iw8_mp/_requests/vfx_spawn_beacon_smoke.vfx");
}

_id_24B8() {
  self _meth_852A("tac_ops_spawn_grenade_mp");
  return 1;
}

_id_F1CB(var_0) {
  if(!isDefined(level._id_ED1D)) {
    level._id_ED1D = [];
  }

  var_1 = level._id_ED1D[var_0.owner.team];

  if(isDefined(level._id_ED1D[var_0.owner.team])) {
    var_1 thread _id_4EA7();
    level._id_ED1D[var_0.owner.team] = undefined;
  }

  level._id_ED1D[var_0.owner.team] = var_0;
  var_0.team = var_0.owner.team;
  var_0._id_F17A = (var_0.angles[0], var_0.angles[1], 0);
  var_0 waittill("missile_stuck");
  playFXOnTag(scripts\engine\utility::getfx("vfx_spawn_beacon_smoke"), var_0, "tag_origin");
  var_0 thread _id_078F::_id_D594(0, 20, undefined, undefined, undefined, 0.1);
  var_0 _id_1175();
  var_0 thread _id_ADA9();
  var_0 thread _id_4310();
  var_0 thread _id_43F4();
}

_id_4310() {
  self endon("death");
  var_0 = undefined;
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  self._id_7164 = 60;

  for(;;) {
    self waittill("damage", var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    var_9 = scripts\mp\utility\weapon::_id_9ACB(var_9, var_13);

    if(!isPlayer(var_0) && !isagent(var_0)) {
      continue;
    }
    if(!scripts\mp\weapons::_id_5FB2(self.owner, var_0)) {
      continue;
    }
    if(_id_0A8B::_id_A5A7(var_0, var_9, var_13, var_4)) {
      continue;
    }
    self._id_7164 = self._id_7164 - var_1;

    if(self._id_7164 <= 0) {
      break;
    } else
      var_0 _id_07C4::_id_FC47("");
  }

  _id_4EA7();
}

_id_4EA7() {
  playFX(scripts\engine\utility::getfx("equipment_sparks"), self.origin);
  self notify("death");
}

_id_43F4() {
  self waittill("death");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_spawn_beacon_smoke"), self, "tag_origin");
  _id_C4BB();
  self delete();
}

_id_ADA9() {
  level endon("game_ended");
  self endon("death");
  self.owner scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators", "disconnect");
  _id_4EA7();
}

_id_1175() {
  self._id_6D48 = ::_id_6D47;
  _id_081C::_id_10B4("spawn_beacon", self.team, self, "spawn_beacon");
}

_id_C4BB() {
  _id_081C::_id_C4C9("spawn_beacon", self.team);
}

_id_6D47(var_0, var_1) {
  var_2 = [];
  var_2["origin"] = _id_48AE(var_0, var_1);
  var_2["angles"] = _id_48AD(var_2["origin"], var_0, var_1);
  return var_2;
}

_id_48AE(var_0, var_1) {
  var_2 = _func_00B5(var_0.origin, 512, 0, 64, "path", 1);

  if(!isDefined(var_2) || var_2.size <= 0) {
    return var_0.origin;
  }

  return var_2[0].origin;
}

_id_48AD(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;

  foreach(var_6 in level.players) {
    if(var_6.team != var_1.team && scripts\mp\utility\player::isreallyalive(var_6) && var_6 != var_2) {
      var_7 = distance2dsquared(var_6.origin, var_0);

      if(!isDefined(var_4) || var_7 < var_4) {
        var_3 = var_6;
        var_4 = var_7;
      }
    }
  }

  if(!isDefined(var_3)) {
    return var_1._id_F17A;
  }

  var_9 = var_2 _meth_847B(var_0, var_3.origin, 1, 1);
  var_10 = undefined;

  if(var_9.size <= 1) {
    return var_1._id_F17A;
  } else {
    var_10 = var_9[1];
  }

  var_11 = var_10 - var_0;
  var_11 = (var_11[0], var_11[1], 0);
  var_12 = vectortoangles(var_11);
  return var_12;
}