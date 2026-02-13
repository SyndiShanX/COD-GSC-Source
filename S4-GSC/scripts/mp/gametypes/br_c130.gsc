/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_c130.gsc
*************************************************/

_id_E271(var_0, var_1) {
  var_2 = _id_99FD(var_0, var_1);
  var_3 = _id_99FE(var_2);
  return var_3;
}

_id_99FD(var_0, var_1) {
  var_2 = 160;
  var_3 = 200;

  if(isDefined(var_0)) {
    var_4 = var_0;
  } else {
    var_4 = (0, 0, 0);
  }

  if(level.mapname == "mp_torez") {
    var_2 = 165;
    var_3 = 195;
    var_4 = (3000, -2000, 0);
  }

  var_5 = 6.28318;
  var_6 = randomfloatrange(0, 360);
  var_7 = randomfloatrange(var_2, var_3);

  if(isDefined(var_1)) {
    var_8 = var_1;
  } else {
    var_8 = level._id_2A73._id_2A25[0];
  }

  var_9 = spawnStruct();
  var_9._id_BEFE = var_8;
  var_9._id_BFF4 = var_6;
  var_9._id_52DE = var_7;
  var_9._id_3392 = var_4;
  return var_9;
}

_id_99FE(var_0) {
  var_1 = var_0._id_BEFE;
  var_2 = var_0._id_BFF4;
  var_3 = var_0._id_52DE;
  var_4 = var_0._id_3392;
  var_5 = (var_2 + var_3) % 360;
  var_6 = (var_1 * cos(var_2), var_1 * sin(var_2), _id_0797::_id_693D()) + var_4;
  var_7 = (var_1 * cos(var_5), var_1 * sin(var_5), _id_0797::_id_693D()) + var_4;
  var_8 = vectornormalize(var_7 - var_6);
  var_7 = var_7 + var_8 * var_1;
  var_6 = var_6 - var_8 * var_1 * 2;
  var_9 = spawnStruct();
  var_9._id_E715 = var_6;
  var_9._id_5340 = var_7;
  var_9._id_1784 = vectortoangles(var_8);
  return var_9;
}

_id_DEAE(var_0) {
  var_1 = level._id_2A73._id_2A78;

  if(var_0[0] < var_1[1][0]) {
    var_0 = (var_1[1][0], var_0[1], var_0[2]);
  } else if(var_0[0] > var_1[0][0]) {
    var_0 = (var_1[0][0], var_0[1], var_0[2]);
  }

  if(var_0[1] < var_1[1][1]) {
    var_0 = (var_0[0], var_1[1][1], var_0[2]);
  } else if(var_0[1] > var_1[0][1]) {
    var_0 = (var_0[0], var_1[0][1], var_0[2]);
  }

  return var_0;
}

_id_89BD(var_0, var_1, var_2) {
  var_3 = (var_0[0], var_0[1], 0);
  var_4 = (var_1[0], var_1[1], 0);
  var_5 = (var_2[0], var_2[1], 0);
  var_6 = vectornormalize(var_3 - var_4);
  var_7 = vectornormalize(var_5 - var_4);
  var_8 = vectordot(var_6, var_7);
  return var_8 > 0;
}

_id_94E3(var_0, var_1, var_2, var_3) {
  var_4 = var_0[0] - var_2[0];
  var_5 = var_0[1] - var_2[1];
  var_6 = var_1[0] - var_2[0];
  var_7 = var_1[1] - var_2[1];
  var_8 = float(var_3);
  var_9 = var_6 - var_4;
  var_10 = var_7 - var_5;
  var_11 = var_9 * var_9 + var_10 * var_10;
  var_12 = var_4 * var_7 - var_6 * var_5;
  var_13 = var_8 * var_8 * var_11 - var_12 * var_12;

  if(var_13 < 0) {
    return;
  } else if(var_13 == 0) {
    var_14 = var_12 * var_10 / var_11 + var_2[0];
    var_15 = -1 * var_12 * var_9 / var_11 + var_2[1];
    return (var_14, var_15, 0);
  } else {
    var_16 = _func_0218(var_13);
    var_17 = var_12 * var_10;
    var_18 = scripts\engine\utility::_id_DD3F(var_10) * var_9 * var_16;
    var_19 = (var_17 + var_18) / var_11 + var_2[0];
    var_20 = (var_17 - var_18) / var_11 + var_2[0];
    var_21 = -1 * var_12 * var_9;
    var_22 = abs(var_10) * var_16;
    var_23 = (var_21 + var_22) / var_11 + var_2[1];
    var_24 = (var_21 - var_22) / var_11 + var_2[1];
    return [(var_19, var_23, 0), (var_20, var_24, 0)];
  }
}

_id_690D(var_0, var_1, var_2) {
  var_3 = _id_94E3(var_0, var_1, var_2.origin, var_2._id_0359);

  if(!isDefined(var_3)) {
    return;
  } else if(!_func_0107(var_3)) {
    if(_id_89BD(var_3, var_0, var_1)) {
      return var_3;
    }
  } else {
    var_4 = _id_89BD(var_3[0], var_0, var_1);
    var_5 = _id_89BD(var_3[1], var_0, var_1);

    if(!var_4 && !var_5) {
      return;
    } else if(var_4 && !var_5) {
      return var_3[0];
    } else if(var_5 && !var_4) {
      return var_3[1];
    } else {
      var_6 = distance2dsquared(var_0, var_3[0]);
      var_7 = distance2dsquared(var_0, var_3[1]);

      if(var_6 < var_7) {
        return var_3[0];
      } else {
        return var_3[1];
      }
    }
  }
}

_id_C056(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = _id_690D(var_0, var_1, var_5);
    var_3[var_3.size] = var_6;
  }

  var_8 = undefined;
  var_9 = 0;

  foreach(var_6 in var_3) {
    var_11 = distance2dsquared(var_0, var_6);

    if(!isDefined(var_8) || var_11 < var_9) {
      var_8 = var_6;
      var_9 = var_11;
    }
  }

  return var_8;
}

_id_DEAF(var_0, var_1) {
  if(!isDefined(level._id_AD0F) || level._id_AD0F.size == 0) {
    return _id_DEAE(var_1);
  }

  if(!isDefined(level._id_AD10)) {
    level._id_AD10 = level._id_AD0F;
  }

  var_2 = physics_createcontents(["physicscontents_playertrigger"]);
  var_3 = scripts\engine\trace::_id_C053(var_0, var_1, level._id_AD10, var_2);

  if(var_3["fraction"] < 1.0) {
    var_1 = var_3["position"];
  }

  if(isDefined(level._id_AD11) && level._id_AD11.size > 0 && getdvarint("#x34e1f150c1982a923", 0) == 0) {
    var_4 = _id_C056(var_0, var_1, level._id_AD11);

    if(isDefined(var_4)) {
      var_5 = distance2dsquared(var_0, var_1);
      var_6 = distance2dsquared(var_0, var_4);

      if(var_6 < var_5) {
        var_1 = (var_4[0], var_4[1], var_1[2]);
      }
    }
  }

  return var_1;
}

_id_6C3B() {
  var_0 = getdvarfloat("#x3b7dfc268cda9db53", 0.7);
  var_1 = (level._id_2A73._id_2A7B[0] / 2 + level._id_2A73._id_2A7B[1] / 2) / 2;
  var_2 = var_0 * var_1;
  return var_2;
}

_id_8B1A(var_0) {
  var_1 = level._id_2A73._id_2A7A;
  var_2 = _id_6C3B();
  var_3 = distance2d(var_1, var_0);
  return var_3 < var_2;
}

_id_E272() {
  var_0 = level._id_2A73._id_2A7A;
  var_1 = _id_6C3B();
  var_2 = randomfloat(360);

  if(scripts\mp\gametypes\br_public::_id_878D()) {
    if(isDefined(level._id_7E73)) {
      var_2 = level._id_7E73;
    } else {
      var_2 = 75;
    }
  }

  var_3 = anglesToForward((0, var_2, 0));
  var_3 = var_3 * (var_1 * randomfloatrange(-1, 1));
  var_3 = var_3 + (0, 0, _id_693E());
  var_0 = var_0 + var_3;

  if(!scripts\mp\gametypes\br_public::_id_878D() && !scripts\mp\gametypes\br_public::_id_8804()) {
    var_0 = _func_0093("#x3d6ed0739b8dffc9f", var_0);
  }

  var_4 = (0, randomfloatrange(0, 360), 0);

  if(scripts\mp\gametypes\br_public::_id_878D()) {
    var_4 = (0, 75, 0);
  } else {
    var_4 = (0, getdvarfloat("#x3e770b133de0e42e9", var_4[1]), 0);
  }

  var_5 = level._id_2A73._id_2A25[0] * 2;
  var_6 = _id_E273(var_0, var_4, var_5);
  var_7 = _id_0797::_id_693D();
  var_6._id_E715 = (var_6._id_E715[0], var_6._id_E715[1], var_7);
  var_6._id_5340 = (var_6._id_5340[0], var_6._id_5340[1], var_7);
  return var_6;
}

_id_E273(var_0, var_1, var_2) {
  var_3 = anglesToForward(var_1);
  var_2 = level._id_2A73._id_2A25[0] * 2;

  if(scripts\mp\gametypes\br_public::_id_878D()) {
    var_2 = level._id_2A73._id_2A25[2] * 2;
  }

  var_4 = var_0 - var_3 * var_2;
  var_5 = var_0 + var_3 * var_2;
  var_4 = _id_DEAF(var_0, var_4);
  var_5 = _id_DEAF(var_0, var_5);
  var_6 = var_4;
  var_7 = var_5;
  var_3 = vectornormalize(var_5 - var_4);
  var_4 = var_4 - var_3 * _id_6940() * 10;
  var_5 = var_5 + var_3 * 100000;

  if(scripts\mp\gametypes\br_public::_id_878D()) {
    var_4 = var_4 - var_3 * _id_6940() * 20;
  }

  var_8 = spawnStruct();
  var_8._id_E715 = var_4;
  var_8._id_5340 = var_5;
  var_8._id_E716 = var_6;
  var_8._id_5341 = var_7;
  var_8._id_1784 = var_1;
  var_8._id_AED8 = var_3;
  var_8._id_3392 = var_0;
  return var_8;
}

_id_6940() {
  if(isDefined(level._id_2A73) && isDefined(level._id_2A73._id_2E1E)) {
    return level._id_2A73._id_2E1E;
  }

  return 3044;
}

_id_693E() {
  return 8000;
}

_id_D4AE(var_0, var_1) {
  if(isDefined(var_0)) {
    level._id_2A73._id_2E15 = var_0;
  }

  if(isDefined(var_1)) {
    level._id_2A73._id_2E1B = var_1;
  }

  setomnvar("ui_br_altimeter_c130_height", _id_0797::_id_693D());
  setomnvar("ui_br_altimeter_sea_height", _id_0797::_id_693F());
}

_id_FC20(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0._id_E715) || !isDefined(var_0._id_5340) || !isDefined(var_0._id_1784)) {
    return;
  }
  setomnvar("ui_br_c130_path_start_x", int(var_0._id_E716[0]));
  setomnvar("ui_br_c130_path_start_y", int(var_0._id_E716[1]));
  setomnvar("ui_br_c130_path_end_x", int(var_0._id_5341[0]));
  setomnvar("ui_br_c130_path_end_y", int(var_0._id_5341[1]));
}

_id_4061() {
  self notify("debug130Line");

  if(isDefined(level._id_2A73._id_2A7A) && isDefined(level._id_2A73._id_2A7B)) {
    var_0 = _id_E272();
    level thread scripts\mp\gametypes\br_analytics::_id_2B00(var_0._id_3392, var_0._id_1784[1], var_0._id_E716, var_0._id_5341);
  } else
    var_0 = _id_E271();

  _id_FC20(var_0);
  return var_0;
}

_id_E270(var_0) {
  var_1 = distance(var_0._id_E715, var_0._id_5340);
  var_2 = var_1 / _id_6940();
  level._id_29F4 = _id_72F7(var_0._id_E715, var_0._id_5340, var_2);
  level._id_29F4._id_AEE7 = var_0;
  return var_2;
}

_id_E33E() {
  if(isDefined(level._id_7E5E) && level._id_7E5E == "script_model") {
    self unlink();
  }

  scripts\mp\gametypes\br_infils::_id_533F();
  thread _id_B75F(level._id_29F4);
  thread _id_9A20();
  self._id_2BF2 = 1;

  if(istrue(self._id_8793) && getDvar("#x3f59526763711edc4", "") != "dmz") {
    level scripts\mp\gametypes\br_public::_id_2BDD("deploy_squad_leader", self, 1, 0);
  }
}

_id_B75F(var_0) {
  self.angles = var_0.angles;
  self allowcrouch(0);
  self allowprone(0);
  thread _id_954F(var_0, 0);
  thread _id_9550(var_0, 0);
  self._id_2A5E = "c130";
  thread _id_AC5E(var_0);
  self setclientomnvar("ui_hide_nameplate_strings", 1);
}

_id_9A20() {
  self endon("disconnect");
  self setclientomnvar("ui_br_show_jumpmaster_info", 1);
  scripts\engine\utility::waittill_any_2("death", "freefall_complete");
  self setclientomnvar("ui_br_show_jumpmaster_info", 0);
}

_id_AC5E(var_0) {
  self endon("death");

  if(isDefined(level._id_7E5E) && level._id_7E5E == "script_model") {
    self.angles = var_0.angles;
    self playerlinkto(var_0, "");
    self playerhide();
  }

  scripts\mp\utility\player::_id_0DC2("", 0);
  self setplayerangles(var_0.angles);
  var_1 = 1;

  if(isDefined(self._id_7E64)) {
    var_1 = self._id_7E64;
  }

  var_2 = "cam_orbit_br_ac130_player" + var_1;
  self _meth_8697(var_2);
}

_id_72F7(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  var_5 = spawn("script_model", var_0);
  var_5 setModel("veh8_mil_air_acharlie130_magma_animated");
  var_5 setCanDamage(0);
  var_5.maxhealth = 100000;
  var_5.health = var_5.maxhealth;
  var_5._id_3841 = 1;
  var_5._id_E715 = var_0;
  var_5._id_49C1 = vectornormalize(var_1 - var_0);
  var_5.angles = vectortoangles(var_5._id_49C1);
  var_5._id_82CD = spawn("script_model", var_0);
  var_5._id_82CD setModel("veh8_mil_air_acharlie130_magma_rigid");
  var_5._id_82CD._id_3841 = 1;
  var_5._id_82CD linkto(var_5, "", (0, 0, 0), (0, 0, 0));
  var_5._id_B72B = [(32, 30, -500), (-32, 30, -500), (0, 30, -500), (16, 30, -500), (-16, 30, -500)];
  var_5._id_41E2 = 0;

  if(var_3) {
    var_5 thread _id_8CEC("c130");
  }

  if(isDefined(var_4)) {
    var_5 thread[[var_4]](var_1, var_2);
  } else {
    var_5 thread _id_72DE(var_1, var_2);
  }

  return var_5;
}

_id_72DE(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self hide();
  self._id_82CD hide();
  self waittill("start_moving");
  self show();
  self._id_82CD show();
  self moveto(var_0, var_1);
  thread _id_8D5D(var_1, "c130");
  thread _id_72F8();
  self playLoopSound("br_ac130_lp");
}

_id_72F8() {
  level endon("game_ended");

  if(scripts\mp\utility\game::getgametype() == "br") {
    wait 0.1;
    self setscriptablepartstate("br_fx", "clouds");
  } else {
    var_0 = level._effect["vfx_snatch_ac130_clouds"];

    if(!isDefined(var_0)) {
      return;
    }
    wait 0.1;
    playFXOnTag(var_0, self, "tag_body");
  }
}

_id_82C9(var_0) {
  var_1 = level._id_2A73._id_2A78;

  if(isDefined(level._id_2A73._id_2A79)) {
    var_1 = level._id_2A73._id_2A79;
  }

  if((scripts\mp\gametypes\br_public::_id_8804() || scripts\mp\gametypes\br_public::_id_878D()) && isDefined(level._id_29F4)) {
    var_2 = var_0[0] < var_1[1][0] && var_0[0] > var_1[0][0] && var_0[1] < var_1[1][1] && var_0[1] > var_1[0][1];
  } else {
    var_2 = var_0[0] < var_1[0][0] && var_0[0] > var_1[1][0] && var_0[1] < var_1[0][1] && var_0[1] > var_1[1][1];
  }

  return var_2;
}

_id_89B2(var_0, var_1) {
  var_2 = _id_82C9(var_0);

  if((scripts\mp\gametypes\br_public::_id_878D() || scripts\mp\gametypes\br_public::_id_8804()) && isDefined(level._id_29F4)) {
    return var_2;
  }

  if(!var_2) {
    return 0;
  }

  if(_id_8B1A(var_0)) {
    return 1;
  }

  var_3 = scripts\mp\outofbounds::_id_89B8(var_0);

  if(var_3) {
    return 0;
  }

  if(istrue(var_1)) {
    var_4 = 16;
    var_5 = physics_createcontents(["physicscontents_playertrigger"]);
    var_6 = _func_02C2(var_0, var_0, var_4, var_5, undefined, "physicsquery_all");

    foreach(var_8 in var_6) {
      var_9 = var_8["entity"];

      if(isDefined(var_9) && isDefined(var_9._id_0481) && var_9._id_0481 == "OutOfBounds") {
        return 0;
      }
    }
  }

  return 1;
}

_id_B197() {
  var_0 = anglesToForward(self.angles);

  for(;;) {
    var_1 = vectornormalize(self._id_AEE7._id_E716 - self.origin);
    var_2 = vectordot(var_0, var_1) < 0;

    if(var_2) {
      break;
    }

    waitframe();
  }
}

_id_8CEC(var_0) {
  level endon("game_ended");
  self endon("death");
  _func_01EA("ui_hide_minimap", 1);
  waitframe();
  _id_B197();
  var_1 = _id_693E();

  while(!_id_89B2((self.origin[0], self.origin[1], var_1))) {
    waitframe();
  }

  _func_01EA("ui_hide_minimap", 0);
  level._id_2E36 = 1;

  for(;;) {
    var_2 = anglesToForward(self.angles);
    var_3 = vectornormalize(self._id_AEE7._id_3392 - self.origin);
    var_4 = vectordot(var_2, var_3) < 0;

    if(var_4) {
      break;
    }

    waitframe();
  }

  var_5 = getdvarint("#x343b33e9d1ef8aff6", 3500);

  for(;;) {
    var_2 = anglesToForward(self.angles);
    var_6 = self.origin + var_2 * var_5;
    var_6 = (var_6[0], var_6[1], var_1);

    if(!_id_89B2(var_6)) {
      foreach(var_8 in level.players) {
        if(isDefined(var_8) && isDefined(var_8._id_2A5E) && var_8._id_2A5E == var_0 && !isDefined(var_8._id_8CA7)) {
          var_8._id_8CA7 = "outOfBounds";
          var_8 notify("halo_kick_c130");
        }
      }

      break;
    }

    waitframe();
  }

  level._id_2E36 = undefined;
}

_id_8D5D(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  wait(var_0);

  if(isDefined(self.players)) {
    foreach(var_3 in self.players) {
      if(isDefined(var_3) && isDefined(var_3._id_2A5E) && var_3._id_2A5E == var_1 && !isDefined(var_3._id_8CA7)) {
        var_3._id_8CA7 = "outOfBounds";
        var_3 notify("halo_kick_c130");
      }
    }
  } else {
    foreach(var_3 in level.players) {
      if(isDefined(var_3) && isDefined(var_3._id_2A5E) && var_3._id_2A5E == var_1 && !isDefined(var_3._id_8CA7)) {
        var_3._id_8CA7 = "outOfBounds";
        var_3 notify("halo_kick_c130");
      }
    }
  }

  self stoploopsound();
  var_7 = level._effect["vfx_br_ac130_clouds"];
  var_8 = level._effect["vfx_br_ac130_oneshot"];

  if(scripts\mp\utility\game::getgametype() != "br") {
    var_7 = level._effect["vfx_snatch_ac130_clouds"];
  }

  if(isDefined(var_7)) {
    stopFXOnTag(var_7, self, "tag_body");
  }

  if(isDefined(var_8)) {
    stopFXOnTag(var_8, self, "tag_body");
  }

  wait 0.1;

  if(isDefined(self._id_18E7)) {
    var_9 = 1;

    while(var_9) {
      var_9 = 0;

      foreach(var_3 in level.players) {
        if(isDefined(var_3._id_2A5E)) {
          var_9 = 1;
          break;
        }
      }

      if(var_9) {
        wait 0.5;
      }
    }

    scripts\mp\gametypes\br_public::_id_383E(self._id_18E7);
  } else {
    if(isDefined(self._id_82CD)) {
      self._id_82CD delete();
    }

    self delete();
  }
}

_id_2EC6() {
  var_0 = self.origin - anglesToForward(self.angles) * 150;
  return var_0;
}

_id_9550(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("cancel_c130");
  self endon("br_jump");
  self waittill("halo_kick_c130", var_2);

  if(!isDefined(var_2)) {
    var_2 = (0, var_0.angles[1] + 180, 0);
  }

  self._id_2BD6 = 1;
  thread _id_9168(var_0, var_1, var_2, 0);
}

_id_954F(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("cancel_c130");
  self endon("br_jump");
  var_2 = undefined;
  self._id_C16B = 0;
  var_3 = getdvarint("#x3df37778aa2425d1c", 0);
  var_0 _id_B197();

  for(;;) {
    var_4 = scripts\engine\utility::_id_108C5("halo_jump_c130", "halo_jump_solo_c130");

    if(!isDefined(var_4)) {
      var_4 = "halo_jump_c130";
    }

    var_5 = scripts\mp\utility\teams::_id_6DCA(self.team, "players");

    if(!var_3) {
      var_2 = var_0 _id_2EC6();

      if(_id_89B2(var_2)) {
        self._id_8CA7 = "solo";
        self notify("halo_kick_c130");
        scripts\engine\utility::_id_F125("infil_jump_done", scripts\mp\gametypes\br_public::_id_FC1A, "jumpMasterState", 0);
        break;
      } else
        self iprintlnbold(&"MP_BR_INGAME/NOT_PLAYABLE");

      continue;
    }

    var_6 = scripts\mp\gametypes\br_public::_id_898B() || isDefined(self._id_E4A0) && self._id_E4A0 == 0;

    if(!var_6 && var_5.size > 1) {
      if(var_4 == "halo_jump_solo_c130") {
        var_2 = var_0 _id_2EC6();

        if(_id_89B2(var_2)) {
          self._id_8CA7 = "solo";
          self notify("halo_kick_c130");
          scripts\engine\utility::_id_F125("infil_jump_done", scripts\mp\gametypes\br_public::_id_FC1A, "jumpMasterState", 0);
          break;
        } else
          self iprintlnbold(&"MP_BR_INGAME/NOT_PLAYABLE");
      }

      continue;
    }

    var_2 = var_0 _id_2EC6();

    if(_id_89B2(var_2)) {
      if(var_6) {
        self._id_8CA7 = "leader";
        var_7 = isDefined(level._id_E48E);

        if(var_7) {
          var_8 = level._id_E48E[self.team][self._id_E496];
          var_5 = var_8.players;
        }

        foreach(var_10 in var_5) {
          if(var_10 != self && isDefined(var_10._id_2A5E) && !isDefined(var_10._id_8CA7)) {
            var_10._id_8CA7 = "follower";
            var_10 notify("halo_kick_c130", self getplayerangles());
          }

          var_10 playlocalsound("tmp_br_infil_ac130_jumpmaster_go");
        }

        if(var_4 != "halo_jump_solo_c130" && getdvarint("#x350a227b60610018d", 0)) {
          thread _id_79D3(var_5);
        } else {
          foreach(var_10 in var_5) {
            if(isDefined(var_10._id_2A5E)) {
              _id_D715(var_10, var_5, 0);
            }
          }
        }
      }

      break;
    } else
      self iprintlnbold(&"MP_BR_INGAME/NOT_PLAYABLE");

    var_2 = var_0 _id_2EC6();
    waitframe();
  }

  thread _id_9168(var_0, var_1, self getplayerangles(), 0);
}

_id_9168(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("cancel_c130");
  setdvarifuninitialized("#x36972bbe376d734b0", 1);
  self notify("br_jump");
  self allowcrouch(1);
  self allowprone(1);
  self._id_B928 = undefined;
  self._id_2E0E = undefined;
  scripts\mp\gametypes\br_public::_id_FC1A("isInInfilPlane", 0);

  if(isDefined(level._id_7E79) && isDefined(level._id_7E79._id_B7B5)) {
    level._id_7E79._id_B7B5--;
  }

  self _meth_824C("halo_jump_c130", "+gostand");
  self _meth_824C("halo_jump_solo_c130", "+gostand");
  self _meth_824C("abandon_fireteam_leader", "+frag");
  self _meth_824C("br_pass_squad_leader", "+usereload");
  self _meth_824C("br_pass_squad_leader", "+activate");
  self waittill("infil_jump_done");
  self cameradefault();
  self._id_2A5E = undefined;
  thread _id_AE18(var_0, var_1, var_2, var_3);
}

_id_79D3(var_0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  thread _id_10B4C(var_0);
  var_1 = self;
  wait 0.2;
  var_2 = [(-250, 0, 0), (-150, -150, 0), (-150, 150, 0)];
  var_3 = 0;

  foreach(var_5 in var_0) {
    if(!isDefined(var_5) || !isalive(var_5)) {
      continue;
    }
    if(var_5 != var_1) {
      if(isDefined(var_5._id_8CA7) && var_5._id_8CA7 != "solo") {
        var_5 thread _id_BE5A(var_1, var_2[var_3]);
        var_3++;
        continue;
      }

      _id_D715(var_5, var_0, 0);
    }
  }

  var_7 = 2700;
  var_8 = 999999999;

  while(!self usebuttonpressed() && var_8 > var_7) {
    var_9 = scripts\common\utility::groundpos(var_1.origin);
    var_8 = var_1.origin[2] - var_9[2];

    if(var_1 _meth_86B8()) {
      break;
    }

    waitframe();
  }

  foreach(var_11 in var_0) {
    if(!isDefined(var_11) || !isalive(var_11)) {
      continue;
    }
    if(var_11 != self && istrue(var_11._id_24C5)) {
      var_11 notify("stop_push");
      var_11._id_24C5 = undefined;
    }

    _id_D715(var_11, var_0, 0);
  }

  self notify("hold_teammates_complete");
}

_id_10B4C(var_0) {
  level endon("game_ended");
  self endon("hold_teammates_complete");
  scripts\engine\utility::waittill_any_2("death", "disconnect");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(var_2 != self && istrue(var_2._id_24C5)) {
      var_2 notify("stop_push");
      var_2._id_24C5 = undefined;
    }

    _id_D715(var_2, var_0, 0);
  }
}

_id_D715(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::ter_op(var_0 scripts\mp\gametypes\br_public::_id_898B(), 2, var_2);
  var_0 scripts\mp\gametypes\br_public::_id_FC1A("jumpMasterState", var_3);
}

_id_B739() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("stop_push");
  self waittill("skydive_deployparachute");
  var_0 = scripts\mp\utility\teams::_id_6DCA(self.team, "players");
  _id_D715(self, var_0, 0);
}

_id_BE5A(var_0, var_1) {
  level endon("game_ended");
  self._id_24C5 = 1;
  var_2 = self;
  var_2 endon("death_or_disconnect");
  var_2 endon("stop_push");
  var_2 thread _id_B739();
  var_3 = length(var_1);

  while(!var_2 isonground() && !var_2 usebuttonpressed() && isDefined(var_0) && !var_2 _meth_86B8()) {
    var_4 = var_0 getplayerangles();
    var_5 = _func_01C6((0, 0, 1), var_1, var_4[1]);
    var_6 = var_0.origin + var_5 - var_2.origin;
    var_7 = length(var_6);

    if(var_7 > var_3) {
      var_8 = var_2 getvelocity();
      var_2 setvelocity(var_6 + var_8 * 0.9);
    }

    waitframe();
  }

  var_2 notify("stop_push");
  var_2._id_24C5 = undefined;
  var_9 = scripts\mp\utility\teams::_id_6DCA(var_2.team, "players");
  _id_D715(var_2, var_9, 0);
}

_id_AE18(var_0, var_1, var_2, var_3) {
  self setclientomnvar("ui_br_infiled", 1);
  self setclientomnvar("ui_hide_nameplate_strings", 0);
  self unlink();

  if(isDefined(self._id_2A82)) {
    self._id_2A82 delete();
  }

  thread _id_7E6B(var_0);
  waitframe();
  self playershow(1);

  if(isDefined(var_2)) {
    self setplayerangles(var_2);
  }

  if(scripts\mp\utility\game::getgametype() == "br") {
    self._id_2A64 = undefined;
    scripts\mp\gametypes\br_analytics::_id_2AE9(self);
  }

  var_4 = (0, 0, 0);

  if(var_3) {
    var_4 = anglesToForward(var_0.angles) * _id_6940();
  }

  self._id_7D26 = gettime() + 5000;
  self _meth_86B2(0);
  thread _id_0797::_id_E6AD(2.0, var_1, undefined, var_4);
}

_id_7E6B(var_0) {
  self endon("disconnect");
  var_1 = self;

  if(isDefined(var_0)) {
    var_0 playsoundtoplayer("br_ac130_flyby", var_1);
  }

  var_1 _meth_867F("mp_br_infil_music", 0.0);
  var_2 = game["music"]["br_plane_jump"].size - 1;
  var_3 = randomint(var_2);
  var_1 setplayermusicstate(game["music"]["br_plane_jump"][var_3]);
  var_1._id_8C94 = 1;
  wait 1.0;
  var_1 _meth_8078(3.0);
  wait 5.0;
  var_1 _meth_8680("mp_br_infil_music", 15.0);
}

_id_D67D(var_0) {
  if(isDefined(self._id_82E1) && self._id_82E1 == var_0) {
    return;
  }
  self._id_82E1 = var_0;
  level notify("update_circle_hide");
}

_id_10975() {
  level endon("game_ended");
  level._id_29F4 endon("death");
  level._id_29F4 _id_B197();

  for(;;) {
    var_0 = level._id_29F4 _id_2EC6();

    if(_id_89B2(var_0)) {
      foreach(var_2 in level.players) {
        if(isPlayer(var_2)) {
          var_2 playlocalsound("scr_br_infil_ac130_klaxon");
        }
      }

      wait 1.0;
      level notify("br_ready_to_jump");
      scripts\mp\gametypes\br_analytics::_id_2AE7();
      return;
    }

    waitframe();
  }
}