/***************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_helicopters.gsc
***************************************************/

_id_D87B(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 notify("cancel_heli");
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 setModel("tag_origin");
  self._id_B70E = var_1;
  self._id_B7E0 = var_0.origin;

  if(istrue(var_0._id_8783)) {
    level._id_2637 = self._id_B7E0;
  }

  var_1 playLoopSound("veh_apache_killstreak_amb_lr");
  var_1 linkto(self, "tag_origin", self._id_B72B[self._id_B7C6.size], (0, 90, 0));
  var_0 setstance("stand");
  var_0 setCanDamage(0);
  var_0 _meth_8063();
  var_0 playerlinktodelta(var_1, "tag_player", 1.0, 40, 40, -5, 70, 0);
  _id_07D1::_id_60C2("prematch_done");
  var_0 notifyonplayercommand("halo_jump_c130", "+gostand");
  var_0 thread scripts\mp\gametypes\br_c130::_id_954F(self, 1);
  var_0 thread scripts\mp\gametypes\br_c130::_id_9550(self, 1);
}

_id_E340(var_0) {
  var_0.angles = self.angles;
  var_0 thread scripts\mp\gametypes\br_c130::_id_954F(self, 1);
  var_0 thread scripts\mp\gametypes\br_c130::_id_9550(self, 1);
  var_0._id_2A5E = "heli";
  var_0 thread _id_AC5E(self);
}

_id_AC5E(var_0) {
  var_1 = 450;
  var_2 = (-5, 0, 0);
  var_3 = anglesToForward(var_2) * var_1 * -1;
  var_0._id_2ACC = var_3 + (150, 150, 0);
  self.angles = var_0.angles;
  self playerlinkto(var_0, "tag_origin");
  self playerhide();
  scripts\mp\utility\player::_id_0DC2("", 0);

  if(isDefined(self._id_2A82)) {
    self._id_2A82 delete();
  }

  var_4 = spawn("script_model", var_0.origin);
  var_4 setModel("tag_player");
  var_4 linkto(var_0, "tag_origin", (0, 0, 50), (0, 0, 0));
  self._id_2A82 = var_4;
  self _meth_8697("camera_custom_orbit_2");
}

_id_5E9D() {
  foreach(var_1 in level.players) {
    var_1 notify("halo_jump");
    var_1 notify("halo_kick_c130");
  }
}

_id_8CA2(var_0, var_1) {
  level endon("game_ended");
  self endon("br_jump");
  scripts\common\utility::_id_1554(0);
  scripts\mp\utility\player::_id_5265(0);
  scripts\common\utility::_id_1562(0);
  scripts\common\utility::_id_158A(0);
  self notifyonplayercommand("halo_jump", "+gostand");
  self waittill("halo_jump");
  var_2 = self getplayerangles();
  var_3 = var_0 _id_6A3D();
  var_4 = anglestoleft(var_0.angles);
  var_5 = var_3.origin + var_4 * 200;
  var_6 = physics_createcontents(["physicscontents_glass", "physicscontents_water", "physicscontents_playerclip", "physicscontents_vehicleclip"]);
  var_7 = (0, 0, 0);
  var_8 = _func_02C1(var_5, var_5 + (0, 0, -20000), var_6, undefined, 0, "physicsquery_closest", 1);

  if(isDefined(var_8) && var_8.size > 0) {
    var_9 = var_8[0]["position"];
    var_7 = _func_02AB(var_9);
  } else
    iprintln("ERROR NOTHING BELOW TO CAST ON");

  self unlink();
  var_10 = spawn("script_model", self.origin);
  var_10.angles = self.angles;
  var_10 setModel("tag_origin");
  self playerlinkto(var_10);
  var_10 moveto(var_7 + (0, 0, 24), var_1, 0, 1.0);
  self playerlinkto(var_10);
  var_11 = spawn("script_model", self.origin + (0, 0, 300));
  var_11 setModel("ctl_parachute_player");
  var_11 notsolid();
  childthread _id_AE3C(var_11);
  wait(var_1 - 0.333);
  self unlink();
  var_0._id_B7C6 = scripts\engine\utility::array_remove(var_0._id_B7C6, self);
  self setCanDamage(1);
  scripts\common\utility::_id_158A(1);
  scripts\common\utility::_id_1562(1);
  scripts\mp\utility\player::_id_5265(1);
  scripts\common\utility::_id_1554(1);

  if(isDefined(var_0)) {
    var_0 _id_8C9C();
  }
}

_id_AE3C(var_0) {
  for(;;) {
    if(self isonground() || !isalive(self)) {
      self._id_2A44 = (0, 0, 0);
      var_0 delete();
      break;
    } else {
      var_0.angles = self.angles;
      var_0.origin = self.origin + (0, 0, 360);
    }

    waitframe();
  }
}

_id_E2FA(var_0, var_1) {
  var_2 = "jackal";
  var_3 = _id_5954();
  var_4 = "veh_blima_gunner_proto_mp";
  var_5 = "veh8_mil_air_blima_gunner_streak_proto";
  var_6 = 1500;
  var_7 = _func_0216(var_5, "br_spawn_heli_" + var_0, var_4, var_1, (0, -90, 0));
  var_7.streakinfo = var_3;
  var_7 vehicle_setspeed(30, 15, 5);
  var_7 notsolid(0);
  var_7 setCanDamage(0);
  var_7 setscriptablepartstate("engine", "on");
  var_7 playLoopSound("lbravo_engine_high");
  var_7.health = var_6;
  var_7._id_EEF5 = level._id_9AAC;
  var_7._id_EEA2 = undefined;
  var_7.team = "allies";
  var_7._id_50A0 = 0;
  var_7._id_916C = 0;
  var_7._id_BEDA = 0;
  var_7._id_B7C6 = [];
  var_7._id_B72B = [(32, 30, -135), (-32, 30, -135), (0, 30, -135), (16, 30, -135), (-16, 30, -135)];
  var_7._id_8CA4 = [];

  for(var_8 = 0; var_8 < 10; var_8++) {
    var_7._id_8CA4[var_8] = 0;
  }

  return var_7;
}

_id_6A3D() {
  if(!isDefined(self._id_8CA4)) {
    return self._id_F448[0];
  }

  for(var_0 = 0; var_0 < 10; var_0++) {
    if(self._id_8CA4[var_0] == 0) {
      self._id_8CA4[var_0] = 1;
      return self._id_F448[var_0];
    }
  }

  return self._id_F448[9];
}

_id_2EC6() {
  var_0 = self.origin - anglesToForward(self.angles) * 150;
  return var_0;
}

_id_77C5() {
  self endon("death");
  self endon("leaving");
  self._id_F448 = [];

  for(var_0 = 0; var_0 < 10; var_0++) {
    var_1 = spawnStruct();
    var_1.origin = self.origin;
    var_1.angles = self.angles;
    self._id_F448[var_0] = var_1;
  }

  for(;;) {
    for(var_0 = 9; var_0 > 0; var_0--) {
      self._id_F448[var_0].origin = self._id_F448[var_0 - 1].origin;
      self._id_F448[var_0].angles = self._id_F448[var_0 - 1].angles;
      self._id_8CA4[var_0] = self._id_8CA4[var_0 - 1];
    }

    self._id_F448[0].origin = self.origin;
    self._id_F448[0].angles = self.angles;
    self._id_8CA4[0] = 0;
    wait 1.0;
  }
}

_id_5954() {
  var_0 = spawnStruct();
  var_0._id_1F84 = 1;
  var_0._id_5B70 = "offhand_fired";
  var_0._id_887C = 1;
  var_0._id_8CED = 5;
  var_0._id_936C = 0;
  var_0._id_9925 = gettime();
  var_0._id_CF97 = "gesture_script_weapon";
  var_0.streakname = "jackal";
  var_0._id_EA15 = undefined;
  var_0._id_04CC = -1;
  var_0._id_04FE = "ks_gesture_generic_mp";
  var_0.objweapon = makeweapon(var_0._id_04FE);
  var_0._id_79B5 = 0;
  return var_0;
}

_id_8898(var_0) {
  return var_0._id_B7C6.size == 10;
}

_id_E031(var_0, var_1) {
  return var_0._id_B7C6.size < var_1._id_B7C6.size;
}

_id_6B80(var_0) {
  if(level.teambased) {
    foreach(var_2 in level._id_2A58) {
      if(isDefined(var_2._id_E391) && var_2._id_E391 == var_0 && !_id_8898(var_2)) {
        return var_2;
      }
    }

    foreach(var_2 in level._id_2A58) {
      if(!isDefined(var_2._id_E391)) {
        var_2._id_E391 = var_0;
        return var_2;
      }
    }
  } else {
    var_6 = scripts\engine\utility::_id_1BD6(level._id_2A58, ::_id_E031);

    foreach(var_8 in var_6) {
      if(!_id_8898(var_8)) {
        return var_8;
      }
    }
  }

  return undefined;
}

_id_8CE1() {
  foreach(var_1 in self._id_B7C6) {
    if(isDefined(var_1) && isDefined(var_1._id_2A5E) && var_1._id_2A5E == "heli") {
      var_1 cameradefault();
      var_1 notify("halo_kick_c130");
    }
  }
}

_id_5772() {
  self endon("death");
  level notify("infil_locked");
  _id_8CE1();
  self notify("begin_exit");
  self._id_916C = 1;
  var_0 = getent("airstrikeheight", "targetname");
  var_1 = var_0.origin[2];
  var_2 = (level._id_2A73._id_2A78[0] + level._id_2A73._id_2A78[1]) * 0.5;
  var_3 = self.origin - var_2;
  var_3 = (var_3[0], var_3[1], 0);
  var_4 = vectornormalize(var_3);
  var_5 = self.origin + var_4 * 10000 + (0, 0, 1) * var_1;
  var_6 = 150;
  var_7 = 50;
  var_8 = 350;
  self vehicle_setspeed(var_6, var_7, var_7);
  self setvehgoalpos(var_5, 0);
  self setneargoalnotifydist(var_8);
  self waittill("near_goal");
  self delete();
}

_id_8C9C() {
  foreach(var_1 in level._id_2A58) {
    if(isDefined(var_1) && var_1._id_B7C6.size == 0) {
      var_1 thread _id_5772();
    }
  }
}