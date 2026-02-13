/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_convoy.gsc
*************************************************/

_id_F94D(var_0) {
  level thread _id_E392(var_0);
}

_id_F94C(var_0) {
  level thread _id_E37F(var_0);
}

_id_E392(var_0) {
  level._id_2A2D = [];
  var_1 = _func_00E6("br_convoy", "targetname");
  var_2 = [];

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_2[var_3] = var_1[var_3];
  }

  var_4 = (level._id_2A73._id_2A78[0] + level._id_2A73._id_2A78[1]) * 0.5;
  var_5 = var_0._id_E715 - var_4;
  var_6 = vectortoangles(var_5)[1];
  var_7 = [];

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_8 = var_2[var_3].origin - var_4;
    var_7[var_3] = vectortoangles(var_8)[1];
  }

  var_9 = -1;
  var_10 = -1;

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(var_6 < var_7[var_3]) {
      var_10 = var_3;
      continue;
    }

    if(var_10 != -1) {
      break;
    }
  }

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(var_6 > var_7[var_3]) {
      var_9 = var_3;
      continue;
    }

    if(var_9 != -1) {
      break;
    }
  }

  if(var_9 == -1) {
    var_9 = var_1.size - 1;
  }

  if(var_10 == -1) {
    var_10 = 0;
  }

  for(var_3 = 0; var_3 < var_7.size; var_3++) {}

  var_11 = 1;
  var_12 = [var_9, var_10];

  for(var_3 = 0; var_3 < var_11; var_3++) {
    if(var_9 - 1 - var_3 <= 0) {
      var_12[var_12.size] = var_1.size - 1 - var_3;
    } else {
      var_12[var_12.size] = var_9 - 1 - var_3;
    }

    if(var_10 + 1 + var_3 >= var_1.size) {
      var_12[var_12.size] = 0;
      continue;
    }

    var_12[var_12.size] = var_10 + 1 + var_3;
  }

  for(var_3 = 0; var_3 < var_12.size; var_3++) {}

  for(var_3 = 0; var_3 < var_12.size; var_3++) {
    thread _id_E28B(var_1[var_12[var_3]]);
  }
}

_id_E37F(var_0) {
  level._id_2A2D = [];
  var_1 = _func_00E6("br_convoy", "targetname");
  var_2 = [];

  foreach(var_4 in var_1) {
    if(distancesquared(var_4.origin, (19328, 2944, 512)) < 40000) {
      var_2[var_2.size] = var_4;
    }
  }

  var_1 = scripts\engine\utility::_id_1BBF(var_1, var_2);
  var_6 = [];

  for(var_7 = 0; var_7 < var_1.size; var_7++) {
    var_6[var_7] = var_1[var_7];
  }

  var_8 = (level._id_2A73._id_2A78[0] + level._id_2A73._id_2A78[1]) * 0.5;
  var_9 = var_0._id_E715 - var_8;
  var_10 = vectortoangles(var_9)[1];
  var_11 = [];

  for(var_7 = 0; var_7 < var_1.size; var_7++) {
    var_12 = var_6[var_7].origin - var_8;
    var_11[var_7] = vectortoangles(var_12)[1];
  }

  var_13 = -1;
  var_14 = -1;

  for(var_7 = 0; var_7 < var_1.size; var_7++) {
    if(var_10 < var_11[var_7]) {
      var_14 = var_7;
      continue;
    }

    if(var_14 != -1) {
      break;
    }
  }

  for(var_7 = 0; var_7 < var_1.size; var_7++) {
    if(var_10 > var_11[var_7]) {
      var_13 = var_7;
      continue;
    }

    if(var_13 != -1) {
      break;
    }
  }

  if(var_13 == -1) {
    var_13 = var_1.size - 1;
  }

  if(var_14 == -1) {
    var_14 = 0;
  }

  for(var_7 = 0; var_7 < var_11.size; var_7++) {}

  var_15 = 4;
  var_16 = [var_13, var_14];

  for(var_7 = 0; var_7 < var_15; var_7++) {
    if(var_13 - 1 - var_7 <= 0) {
      var_16[var_16.size] = var_1.size - 1 - var_7;
    } else {
      var_16[var_16.size] = var_13 - 1 - var_7;
    }

    if(var_14 + 1 + var_7 >= var_1.size) {
      var_16[var_16.size] = 0;
      continue;
    }

    var_16[var_16.size] = var_14 + 1 + var_7;
  }

  for(var_7 = 0; var_7 < var_16.size; var_7++) {}

  for(var_7 = 0; var_7 < var_16.size; var_7++) {
    thread _id_E2F7(var_1[var_16[var_7]]);
  }
}

_id_E2F7(var_0) {
  level endon("game_ended");
  var_1 = 0;

  if(isDefined(var_0._id_039B)) {
    if(var_0._id_039B == "left") {
      var_1 = 1;
    }
  }

  var_2 = [];

  for(var_3 = 0; var_3 < 2; var_3++) {
    var_4 = _id_E39C(var_0, var_0.angles, var_1);
    var_2[var_2.size] = var_4;
    wait 1.333;
  }

  if(level.mapname == "mp_torez") {
    var_5 = 3;
    var_6 = 17;
  } else {
    var_5 = 15;
    var_6 = 25;
  }

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_2[var_3] _meth_8438(var_5, 30, 30);
  }

  wait 10;

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_2[var_3] _meth_8438(var_5 * 2, 30, 30);
  }

  wait 4;

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_2[var_3] _meth_8438(var_6, 30, 30);
  }
}

_id_E28B(var_0) {
  level endon("game_ended");
  var_1 = 0;

  if(isDefined(var_0._id_039B)) {
    if(var_0._id_039B == "left") {
      var_1 = 1;
    }
  }

  var_2 = [];

  for(var_3 = 0; var_3 < 4; var_3++) {
    var_2[var_2.size] = _id_E39C(var_0, var_0.angles, var_1);
    wait 1.333;
  }

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_2[var_3] _meth_8438(15, 30, 30);
  }

  wait 12;

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_2[var_3] _meth_8438(25, 30, 30);
  }
}

_id_E39C(var_0, var_1, var_2) {
  var_3 = _func_0216("veh8_mil_lnd_umike", "umike", "umike", var_0.origin, var_1);
  var_3._id_18AF = "umikeVeh";
  var_3 _meth_8438(25, 30, 30);
  var_3 thread _id_10302(var_0);
  var_3 setscriptablepartstate("dustFX", "normal");
  var_3 setscriptablepartstate("exhaustFX", "active");
  level._id_2A2D[level._id_2A2D.size] = var_3;
  var_3._id_B7C6 = [];
  var_3._id_2A71 = var_2;
  return var_3;
}

_id_10302(var_0) {
  self endon("death");
  self endon("stop_follow_path");
  self _meth_83DC(var_0);
  self playLoopSound("iw8_mp_snatch_convoy_lp");

  for(var_1 = _func_00E5(var_0.target, "targetname"); isDefined(var_1); var_1 = _func_00E5(var_1.target, "targetname")) {
    var_1 waittill("trigger");

    if(!isDefined(var_1.target)) {
      break;
    }
  }

  self vehicle_setspeed(0, 30, 30);

  for(var_2 = self _meth_842E(); var_2 > 1; var_2 = self _meth_842E()) {
    wait 0.1;
  }

  self stoploopsound("iw8_mp_snatch_convoy_lp");
  self stoploopsound("veh_technical_temp_surface");
  level notify("infil_locked");
  thread _id_8CE1();
  wait 3;
  var_3 = spawn("script_model", self.origin);
  var_3 setModel("veh8_mil_lnd_umike_static_allied");
  var_3.angles = self.angles;
  _id_07F9::_id_C799(self._id_A906);
  self delete();
}

_id_E33F() {
  if(isalive(self)) {
    if(!isDefined(self._id_4974)) {
      if(!scripts\mp\gametypes\br_public::_id_898B()) {
        return;
      }
    }

    if(level.teambased) {
      var_0 = scripts\mp\utility\teams::_id_6DCA(self.team, "players");
    } else {
      var_0 = [self];
    }

    foreach(var_2 in var_0) {
      var_2 notify("cancel_c130");
      var_2 notify("cancel_heli");
      var_2 unlink();

      if(!isDefined(var_2._id_2AC5)) {
        var_2._id_2AC5 = _id_6B92(var_2.team);
        var_2._id_2AC5._id_B7C6[var_2._id_2AC5._id_B7C6.size] = var_2;
      }

      var_3 = var_2._id_2AC5;
      var_2.angles = var_3.angles;

      if(!isDefined(var_3._id_DCD2)) {
        var_3 _id_DCB5();
        var_3._id_DCD2 = 1;
      }

      var_2 thread _id_8CA2(var_3);
    }
  }
}

_id_8CA2(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("cancel_convoy");
  self endon("br_jump");
  self._id_2A5E = "convoy";
  thread _id_AC5E(var_0);
  thread _id_954F(var_0);
  thread _id_9550(var_0);
}

_id_8CE1() {
  foreach(var_1 in self._id_B7C6) {
    if(isDefined(var_1) && isDefined(var_1._id_2A5E) && var_1._id_2A5E == "convoy") {
      var_1 cameradefault();
      var_1 unlink();
      var_1 thread _id_8CA3(self);
      var_1 notify("br_jump");
    }
  }
}

_id_9550(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("cancel_c130");
  self endon("cancel_heli");
  self endon("br_jump");
  self waittill("halo_kick_c130");
  var_0 thread _id_8CE1();
}

_id_954F(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("cancel_convoy");
  self endon("br_jump");

  for(;;) {
    self waittill("halo_jump_c130");

    if(!scripts\mp\gametypes\br_public::_id_898B()) {
      continue;
    }
    if(scripts\mp\gametypes\br_c130::_id_89B2(var_0.origin)) {
      if(scripts\mp\gametypes\br_public::_id_898B()) {
        var_1 = scripts\mp\utility\teams::_id_6DCA(self.team, "players");

        foreach(var_3 in var_1) {
          if(var_3 != self) {
            var_3 notify("halo_kick_c130");
          }
        }

        break;
      }
    } else
      self iprintlnbold(&"MP_BR_INGAME/NOT_PLAYABLE");

    waitframe();
  }

  self cameradefault();
  thread _id_8CA3(var_0);
  self notify("br_jump");
}

_id_8CA3(var_0) {
  self setclientomnvar("ui_br_infiled", 1);
  self._id_2A5E = undefined;
  var_1 = self getplayerangles();
  self unlink();

  if(istrue(var_0._id_2A71)) {
    var_2 = anglestoleft(var_0.angles) * 180;
  } else {
    var_2 = anglestoright(var_0.angles) * 180;
  }

  var_3 = anglesToForward(var_0.angles);

  if(!isDefined(var_0._id_A97C)) {
    var_0._id_A97C = 0;
  } else {
    var_0._id_A97C++;
  }

  if(var_0._id_A97C == 0) {
    var_2 = var_2 + var_3 * 36;
  } else if(var_0._id_A97C == 1) {
    var_2 = var_2 - var_3 * 36;
  } else if(var_0._id_A97C == 2) {
    var_2 = var_2 + var_3 * 72;
  } else {
    var_2 = var_2 - var_3 * 72;
  }

  var_4 = var_0.origin + var_2 + (0, 0, 18000);
  var_5 = physics_createcontents(["physicscontents_glass", "physicscontents_water", "physicscontents_playerclip", "physicscontents_vehicleclip"]);
  var_6 = _func_02C1(var_4, var_4 + (0, 0, -20000), var_5, undefined, 0, "physicsquery_closest", 1);

  if(isDefined(var_6) && var_6.size > 0) {
    var_7 = var_6[0]["position"];
    self setorigin(var_7, 1, 1);
  } else
    self setorigin(var_0.origin + var_2, 1, 1);

  waitframe();
  var_8 = game["music"]["snatch_spawn"].size;
  level._id_412F = randomint(var_8);
  self setplayermusicstate(game["music"]["snatch_spawn"][level._id_412F]);
  self playershow();
  self setplayerangles(var_1);
  self notify("fallDone");
  _id_0797::_id_AE2A();
}

_id_AC5E(var_0) {
  self.angles = var_0.angles;
  self playerlinkto(var_0, "tag_origin");
  self playerhide();
  scripts\mp\utility\player::_id_0DC2("", 0);
  self _meth_8697("camera_custom_orbit_1");
}

_id_1B0E() {
  foreach(var_1 in level._id_2A2D) {
    if(!isDefined(var_1) || !isDefined(var_1._id_B7C6)) {
      return 0;
    }
  }

  return 1;
}

_id_6B92(var_0) {
  if(level.teambased) {
    foreach(var_2 in level._id_2A2D) {
      if(isDefined(var_2._id_E391) && var_2._id_E391 == var_0 && !_id_8AB4(var_2)) {
        return var_2;
      }
    }

    foreach(var_2 in level._id_2A2D) {
      if(!isDefined(var_2._id_E391)) {
        var_2._id_E391 = var_0;
        return var_2;
      }
    }
  } else {
    var_6 = scripts\engine\utility::_id_1BD6(level._id_2A2D, ::_id_E03B);

    foreach(var_2 in var_6) {
      if(!_id_8AB4(var_2)) {
        return var_2;
      }
    }
  }

  return undefined;
}

_id_8AB4(var_0) {
  return var_0._id_B7C6.size == 8;
}

_id_E03B(var_0, var_1) {
  return var_0._id_B7C6.size < var_1._id_B7C6.size;
}

_id_DCB5() {
  var_0 = _id_07F9::_id_C57D(10);

  if(var_0 == -1) {
    return -1;
  }

  _id_07F9::_id_A867(var_0, "invisible", (0, 0, 0));
  _id_07F9::_id_FB94(var_0, self);
  _id_07F9::_id_FB9E(var_0, "active");
  var_1 = "icon_minimap_bradley";
  _id_07F9::_id_FB8F(var_0, var_1);
  _id_07F9::_id_FB98(var_0, 1);
  _id_07F9::_id_A8A2(var_0);
  self._id_A906 = var_0;
}