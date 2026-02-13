/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2397.gsc
*************************************************/

_id_6D7F() {
  if(self getstance() == "crouch") {
    var_0 = self.origin + (0, 0, 24);
  } else if(self getstance() == "prone") {
    var_0 = self.origin + (0, 0, 10);
  } else {
    var_0 = self.origin + (0, 0, 32);
  }

  return var_0;
}

isreallyalive(var_0) {
  return isalive(var_0) && !isDefined(var_0._id_59E0) && !istrue(self._id_46C3);
}

_id_875B(var_0) {
  return isDefined(self._id_965F) && var_0 == self._id_965F;
}

_id_8989() {
  return self playerads() > 0.5;
}

setthirdpersondof(var_0) {
  if(var_0) {
    _id_D52C();
  } else {
    _id_D51E();
  }
}

_id_FD26(var_0, var_1) {
  switch (var_0) {
    case "playing":
    case "intermission":
      var_1 = "";
      break;
    case "dead":
    case "spectator":
      if(istrue(level._id_4CFA)) {
        var_1 = "";
      } else if(istrue(level._id_A790)) {
        if(istrue(self._id_ED4A)) {
          var_1 = "hud_status_dogtag";
        } else if(istrue(self._id_C7EE)) {
          if(isDefined(self._id_0407) && self._id_0407 == "hud_status_revive_or") {
            var_1 = "hud_status_revive_or";
          } else {
            var_1 = "hud_status_revive_wh";
          }
        } else
          var_1 = "hud_status_dead";
      } else
        var_1 = "hud_status_dead";

      break;
  }

  if(!isDefined(var_1)) {
    var_1 = "";
  }

  self.sessionstate = var_0;
  self._id_0407 = var_1;
  self setclientomnvar("ui_session_state", var_0);
}

_id_6DC4(var_0, var_1) {
  var_2 = [];

  if(!isDefined(var_1) || var_1) {
    foreach(var_4 in level.characters) {
      if(isDefined(var_4.team) && var_4.team == var_0) {
        var_2[var_2.size] = var_4;
      }
    }
  } else {
    foreach(var_4 in level.players) {
      if(isDefined(var_4.team) && var_4.team == var_0) {
        var_2[var_2.size] = var_4;
      }
    }
  }

  return var_2;
}

_id_66AA(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = self getentitynumber();
  var_3 = [];

  foreach(var_5 in level.players) {
    if(var_5 == self) {
      continue;
    }
    var_6 = 0;

    if(!var_1) {
      if(isDefined(var_5.team) && (var_5.team == "spectator" || var_5.sessionstate == "spectator")) {
        var_7 = var_5 getspectatingplayer();

        if(isDefined(var_7) && var_7 == self) {
          var_6 = 1;
        }
      }

      if(var_5._id_01D2 == var_2) {
        var_6 = 1;
      }
    }

    if(!var_0) {
      if(var_5.killcamentity == var_2) {
        var_6 = 1;
      }
    }

    if(var_6) {
      var_3[var_3.size] = var_5;
    }
  }

  return var_3;
}

_id_D433(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_66AA(var_4, var_5);

  foreach(var_8 in var_6) {
    var_8 notify("changing_watching_visionset");

    if(isDefined(var_3) && var_3) {
      var_8 visionsetmissilecamforplayer(var_0, var_1);
    } else {
      var_8 visionsetnakedforplayer(var_0, var_1);
    }

    if(var_0 != "" && isDefined(var_2)) {
      var_8 thread _id_C5FD(self, var_1 + var_2);
      var_8 thread _id_C5FB(self);

      if(var_8 _id_88C7()) {
        var_8 thread _id_C5FC();
      }
    }
  }
}

_id_C5FC() {
  self endon("disconnect");
  self waittill("spawned");
  self visionsetnakedforplayer("", 0.0);
}

_id_C5FD(var_0, var_1) {
  self endon("changing_watching_visionset");
  var_2 = gettime();
  var_3 = self.team;

  while(gettime() - var_2 < var_1 * 1000) {
    if(self.team != var_3 || !scripts\engine\utility::array_contains(var_0 _id_66AA(), self)) {
      self visionsetnakedforplayer("", 0.0);
      self notify("changing_visionset");
      break;
    }

    waitframe();
  }
}

_id_C5FB(var_0) {
  self endon("changing_watching_visionset");
  var_0 waittill("disconnect");
  self visionsetnakedforplayer("", 0.0);
}

_id_C708(var_0) {
  if(istrue(level._id_10FA1)) {
    return;
  }
  self visionsetnakedforplayer("", var_0);
}

_id_8108() {
  if(isDefined(level._id_A7C1) && _func_0121(level._id_A7C1)) {
    visionsetnight(level._id_A7C1);
  } else {
    visionsetnight("nvg_base_mp");
  }
}

_id_AD68(var_0) {
  visionsetnight(var_0);
  level._id_A7C1 = var_0;
}

_id_C653() {
  level._id_A7C1 = undefined;
  visionsetnight("nvg_base_mp");
}

isenemy(var_0) {
  if(level.teambased) {
    return var_0.team != self.team;
  } else if(isDefined(var_0.owner)) {
    return var_0.owner != self;
  } else {
    return var_0 != self;
  }
}

getuniqueid() {
  if(!isDefined(self.pers)) {
    self.pers = [];
  }

  if(isDefined(self.pers["guid"])) {
    return self.pers["guid"];
  }

  var_0 = self getguid();

  if(var_0 == "0000000000000000") {
    if(isDefined(level.guidgen)) {
      level.guidgen++;
    } else {
      level.guidgen = 1;
    }

    var_0 = "script" + level.guidgen;
  }

  self.pers["guid"] = var_0;
  return self.pers["guid"];
}

_id_6C5F(var_0, var_1, var_2, var_3) {
  var_4 = ["physicscontents_characterproxy"];
  return scripts\mp\utility\entity::getentitiesinradius(var_0, var_1, var_2, var_3, physics_createcontents(var_4));
}

_id_6C60(var_0, var_1, var_2, var_3) {
  var_4 = ["physicscontents_characterproxy"];
  var_5 = [];
  var_6 = scripts\mp\utility\entity::getentitiesinradius(var_0, var_1, var_2, var_3, physics_createcontents(var_4));

  foreach(var_8 in var_6) {
    var_9 = undefined;
    var_10 = [var_8 gettagorigin("j_head"), var_8 gettagorigin("j_mainroot"), var_8 gettagorigin("tag_origin")];

    for(var_11 = 0; var_11 < var_10.size; var_11++) {
      if(!scripts\engine\trace::ray_trace_passed(var_0, var_10[var_11], level.characters, scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 1, 1))) {
        continue;
      }
      if(!isDefined(var_9)) {
        var_5[var_5.size] = spawnStruct();
        var_5[var_5.size - 1].player = var_8;
        var_5[var_5.size - 1]._id_10419 = [];
        var_9 = 1;
      }

      var_5[var_5.size - 1]._id_10419[var_5[var_5.size - 1]._id_10419.size] = var_10[var_11];
    }
  }

  return var_5;
}

_id_886C(var_0, var_1) {
  if(!level.teambased) {
    return 0;
  }

  if(!isPlayer(var_1) && !isDefined(var_1.team)) {
    return 0;
  }

  if(var_0 != var_1.team) {
    return 0;
  }

  return 1;
}

_id_0BD6(var_0) {
  if(!isDefined(self.enabledcollisionnotifies)) {
    self.enabledcollisionnotifies = 0;
  }

  if(var_0) {
    if(self.enabledcollisionnotifies == 0) {
      self enablecollisionnotifies(1);
    }

    self.enabledcollisionnotifies++;
  } else {
    if(self.enabledcollisionnotifies == 1) {
      self enablecollisionnotifies(0);
    }

    self.enabledcollisionnotifies--;
  }
}

_id_1533(var_0) {
  if(self._id_965F != "archetype_scout") {
    return;
  }
  if(var_0) {
    if(!isDefined(self._id_4A94)) {
      self._id_4A94 = 0;
    }

    self._id_4A94--;

    if(!self._id_4A94) {
      self allowdodge(1);
    }
  } else {
    if(!isDefined(self._id_4A94)) {
      self._id_4A94 = 0;
    }

    self._id_4A94++;
    self allowdodge(0);
  }
}

_id_1543(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("gesture", var_0, var_1);

  if(!isDefined(var_2)) {
    return;
  }
  if(var_0) {
    if(scripts\engine\utility::is_player_gamepad_enabled()) {
      self setactionslot(1, "taunt");
    } else {
      self setactionslot(7, "taunt");
    }
  } else if(scripts\engine\utility::is_player_gamepad_enabled())
    self setactionslot(1, "");
  else {
    self setactionslot(7, "");
  }
}

_id_899C(var_0, var_1) {
  var_2 = 0;

  if(isagent(var_0) && isDefined(var_0._id_1210) && var_0._id_1210 == "playerProxy") {
    if(var_0.owner == var_1) {
      var_2 = 1;
    }
  }

  return var_2;
}

_id_5268(var_0, var_1) {
  if(var_0) {
    _func_030F(var_1);
    level._id_BF55 = 1;
  } else {
    _func_030F(1.0);
    level._id_BF55 = undefined;
  }
}

_id_89D5() {
  return istrue(level._id_BF55);
}

_id_0DC2(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(isai(var_3)) {
      continue;
    }
    var_3 visionsetnakedforplayer(var_0, var_1);
  }

  return;
}

_id_7903() {
  if(!isDefined(self._id_F910)) {
    self._id_7904 = 0;
  }

  if(self._id_7904 == 0) {
    self setclientomnvar("ui_hide_hud", 1);
  }

  self._id_7904++;
}

_id_7901() {
  if(self._id_7904 == 1) {
    self setclientomnvar("ui_hide_hud", 0);
  }

  self._id_7904--;
}

_id_7908(var_0) {
  if(_id_165C() && !istrue(var_0)) {
    return;
  }
  if(!isDefined(self._id_9F2B)) {
    self._id_9F2B = 0;
  }

  var_1 = self._id_9F2B;
  self._id_9F2B--;

  if(self._id_9F2B < 0) {
    self._id_9F2B = 0;
  }

  if(istrue(var_0) || self._id_9F2B == 0 && var_1 > self._id_9F2B) {
    self setclientomnvar("ui_hide_minimap", 1);

    if(istrue(var_0)) {
      self._id_9F2B = 0;
    }
  }
}

_id_DCC4() {
  if(scripts\cp\utility::_id_8633()) {
    return;
  }
  if(!isDefined(self._id_9F2B)) {
    self._id_9F2B = 0;
  }

  var_0 = self._id_9F2B;
  self._id_9F2B++;

  if(self._id_9F2B == 1 && var_0 < self._id_9F2B) {
    self setclientomnvar("ui_hide_minimap", 0);
  }
}

_id_165C() {
  return istrue(level._id_9F28) || level.gametype == "br" || level.gametype == "brm";
}

_id_8855() {
  return isDefined(self._id_AC3D) && isDefined(self._id_AC3D._id_6285) && self._id_AC3D._id_6285 == "female";
}

_id_6B29(var_0, var_1) {
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(var_4.team != "spectator" && (!var_1 || var_4 scripts\cp_mp\utility\player_utility::_isalive())) {
      if(!isDefined(var_2) || var_4 getentitynumber() < var_2) {
        var_2 = var_4 getentitynumber();
      }
    }
  }

  return var_2;
}

_id_D8D4(var_0) {
  if(isDefined(self._id_32E7)) {
    self._id_32E7.alpha = 0;
  }

  self._id_FF18 = var_0;
  scripts\common\utility::_id_158B(0);
  scripts\common\utility::_id_152F(0);
  scripts\common\utility::_id_1562(0);
  scripts\common\utility::_id_151F(0);
  self setclientomnvar("ui_using_killstreak_remote", 1);
  self notify("using_remote");
}

_id_6CEC() {
  return self._id_FF18;
}

_id_3990(var_0) {
  scripts\common\utility::_id_158B(1);
  scripts\common\utility::_id_152F(1);
  scripts\common\utility::_id_151F(1);

  if(isDefined(self._id_32E7)) {
    self._id_32E7.alpha = 1;
  }

  self._id_FF18 = undefined;

  if(!isDefined(var_0)) {
    scripts\common\utility::_id_1562(1);
    _freezecontrols(0);
  }

  self setclientomnvar("ui_using_killstreak_remote", 0);
  self notify("stopped_using_remote");
}

_id_8ACE() {
  return isDefined(self._id_FF18);
}

_freezecontrols(var_0, var_1) {
  if(!isDefined(self.pers)) {
    return;
  }
  if(!isDefined(self.pers["controllerFreezeStack"])) {
    self.pers["controllerFreezeStack"] = 0;
  }

  if(var_0) {
    self.pers["controllerFreezeStack"]++;
  } else if(istrue(var_1)) {
    self.pers["controllerFreezeStack"] = 0;
  } else {
    self.pers["controllerFreezeStack"]--;
  }

  if(self.pers["controllerFreezeStack"] <= 0) {
    self.pers["controllerFreezeStack"] = 0;
    self freezecontrols(0);
    self._id_3C69 = 0;
  } else {
    self freezecontrols(1);
    self._id_3C69 = 1;
  }
}

_id_0BEE(var_0, var_1) {
  if(!isDefined(self.pers)) {
    return;
  }
  if(!isDefined(self.pers["controllerLookFreezeStack"])) {
    self.pers["controllerLookFreezeStack"] = 0;
  }

  if(var_0) {
    self.pers["controllerLookFreezeStack"]++;
  } else if(istrue(var_1)) {
    self.pers["controllerLookFreezeStack"] = 0;
  } else {
    self.pers["controllerLookFreezeStack"]--;
  }

  if(self.pers["controllerLookFreezeStack"] <= 0) {
    self.pers["controllerLookFreezeStack"] = 0;
    self freezelookcontrols(0);
    self._id_97F5 = 0;
  } else {
    self freezelookcontrols(1);
    self._id_97F5 = 1;
  }
}

_id_6C4D(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.guid == var_0) {
      return var_2;
    }
  }

  return undefined;
}

_id_D3E1(var_0, var_1, var_2, var_3) {
  var_4 = self _meth_8485(var_0);
  self._id_F07D = 1;
  self _meth_8486(var_0, var_1);

  if(!isDefined(var_3) || !var_3) {
    wait(var_2);
  } else {
    var_5 = self _meth_847F(var_0);

    for(;;) {
      if(self _meth_847D(var_0) >= var_5) {
        break;
      }

      waitframe();
    }
  }

  self _meth_8486(var_0, var_4);
  self._id_F07D = 0;
}

_id_D3E0(var_0, var_1, var_2, var_3) {
  var_4 = self _meth_8481(var_0);
  self._id_F07F = 1;
  self _meth_8482(var_0, var_1);

  if(!isDefined(var_3) || !var_3) {
    wait(var_2);
  } else {
    var_5 = self _meth_847F(var_0);

    for(;;) {
      if(self _meth_847D(var_0) >= var_5) {
        break;
      }

      waitframe();
    }
  }

  self _meth_8482(var_0, var_4);
  self._id_F07F = 0;
}

_id_0BD8() {
  if(!isDefined(self.enabledignoreme)) {
    self.enabledignoreme = 0;
  }

  if(self.enabledignoreme == 0) {
    self.ignoreme = 1;
  }

  self.enabledignoreme++;
}

_id_0BC2() {
  if(self.enabledignoreme == 1) {
    self.ignoreme = 0;
  }

  self.enabledignoreme--;
}

_id_0CBD() {
  self.enabledignoreme = undefined;
  self.ignoreme = 0;
}

_id_10AA3(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.buttonspressed)) {
    self.buttonspressed = [];
  }

  if(!isDefined(self.buttonspressed[var_0])) {
    var_4 = spawnStruct();
    var_4.player = self;
    var_4._id_8CCF = var_0;
    var_4._id_3AD6 = var_1;
    var_4._id_3AE1 = var_2;
    var_4._id_A69F = var_0 + "_buttonDown";
    var_4._id_A6B9 = var_0 + "_buttonUp";
    var_4.pressed = istrue(var_3);
    self.buttonspressed[var_0] = var_4;
    var_4 thread _id_10AA5();
  }
}

_id_693B(var_0) {
  if(!isDefined(self.buttonspressed)) {
    return 0;
  }

  if(!isDefined(self.buttonspressed[var_0])) {
    return 0;
  }

  return self.buttonspressed[var_0].pressed;
}

_id_10AA4(var_0) {
  if(!isDefined(self) || !isDefined(self.buttonspressed) || self.buttonspressed[var_0]) {
    return;
  }
  self.buttonspressed[var_0] notify("watchButtonPressedEnd");
  self.buttonspressed[var_0] = undefined;
}

_id_10AA5() {
  self.player endon("disconnect");
  self endon("watchButtonPressedEnd");

  for(;;) {
    self._id_0184 = 0;
    self._id_04BD = 0;
    childthread _id_10AA2();
    childthread _id_10AA7();
    self waittill("start_race");
    waittillframeend;
    self notify("end_race");

    if(self._id_0184 && self._id_04BD) {
      continue;
    }
    if(self._id_0184) {
      self.pressed = 1;
      continue;
    }

    self.pressed = 0;
  }
}

_id_10AA2() {
  self endon("end_race");
  self.player notifyonplayercommand(self._id_A69F, self._id_3AD6);
  self.player waittill(self._id_A69F);
  self._id_0184 = 1;
  self notify("start_race");
}

_id_10AA7() {
  self endon("end_race");
  self.player notifyonplayercommand(self._id_A6B9, self._id_3AE1);
  self.player waittill(self._id_A6B9);
  self._id_04BD = 1;
  self notify("start_race");
}

_id_10AA6() {
  self endon("watchButtonPressedEnd");
  self.player waittill("disconnect");
  self notify("watchButtonPressedEnd");
}

_id_0CE5(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(1) {
    return;
  }
  if(!isDefined(self)) {
    return;
  }
  var_0 = max(var_0, 0.0);
  var_1 = clamp(var_1, 1.0, 9994.0);
  var_2 = clamp(var_2, 2.0, 9998.0);
  var_3 = clamp(var_3, 3.0, 9999);

  if(var_2 > 9994.0) {
    var_5 = 0.0;
  }
}

_id_D51F() {
  self endon("death_or_disconnect");
  _id_D51E();

  if(isai(self)) {
    return;
  }
  var_0 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip"];
  var_1 = physics_createcontents(var_0);
  var_2 = ["physicscontents_characterproxy"];
  var_3 = physics_createcontents(var_2);
  var_4 = 1;
  var_5 = 1;
  var_6 = cos(27);
  var_7 = 1;
  var_8 = 0;
  var_9 = [];
  var_9["geo"] = spawnStruct();
  var_9["geo"]._id_A400 = getdvarfloat("#x3f6ad6d89fc92e3f2", 0.01);
  var_9["geo"]._id_A3F7 = getdvarfloat("#x3bf828942a7c07f03", 0.95);
  var_9["geo"]._id_59B4 = getdvarfloat("#x3955bd346bbbc8837", 1.5);
  var_9["geo"]._id_59B0 = getdvarfloat("#x3183bdf3b3540e20e", 2.5);
  var_9["geo"]._id_A3EF = getdvarfloat("#x31441c94e36c2f377", 3.9);
  var_9["geo"]._id_59AF = getdvarfloat("#x368e32e14108584d0", 2.25);
  var_9["interest"] = spawnStruct();
  var_9["interest"]._id_A400 = getdvarfloat("#x33a65ce70502f61a8", 0.01);
  var_9["interest"]._id_A3F7 = getdvarfloat("#x3b0034cda50fa2339", 0.95);
  var_9["interest"]._id_59B4 = getdvarfloat("#x315f28cdb5f2667d", 1.5);
  var_9["interest"]._id_59B0 = getdvarfloat("#x3ecbfdb2fe8fd9fc4", 2.5);
  var_9["interest"]._id_A3EF = getdvarfloat("#x3e8e55795203d0dbd", 7.0);
  var_9["interest"]._id_59AF = getdvarfloat("#x362e944aaf94f2922", 3.5);

  for(;;) {
    waitframe();
    var_10 = "geo";

    if(istrue(self._id_FF0A)) {
      continue;
    }
    var_11 = self playerads() > 0.9;

    if(var_7 && !var_11) {
      if(var_8) {
        var_8 = 0;
        _id_0CE5(0, 0, 512, 512, 4, 0);
      }

      continue;
    }

    var_12 = self getEye();
    var_13 = self getplayerangles();
    var_14 = anglesToForward(var_13);
    var_15 = -1;
    var_16 = undefined;
    var_17 = undefined;
    var_18 = undefined;
    var_19 = undefined;

    if(var_4) {
      var_20 = 0;

      foreach(var_22 in level.players) {
        if(!scripts\cp_mp\utility\player_utility::_id_B78C(self, var_22)) {
          continue;
        }
        if(!var_22 scripts\cp_mp\utility\player_utility::_isalive()) {
          continue;
        }
        var_23 = var_22 getEye();
        var_24 = vectordot(var_14, vectornormalize(var_23 - var_12));

        if(var_24 < var_6) {
          continue;
        }
        var_25 = distance(var_12, var_23);

        if(!isDefined(var_16) || var_25 < var_16) {
          if(var_22 _meth_83CD(var_12, self) > 0) {
            var_16 = var_25;
          }
        }

        if(!isDefined(var_17) || var_25 > var_17) {
          if(var_22 _meth_83CD(var_12, self) > 0) {
            var_17 = var_25;
          }
        }
      }
    }

    var_27 = var_12 + var_14 * 10000;
    var_28 = scripts\engine\trace::_id_E409(var_12, var_27, 0.1, self, var_1, 0);
    var_19 = distance(var_12, var_28["position"]);
    var_29 = scripts\engine\trace::_id_E409(var_12, var_27, 20.0, self, var_3, 0);
    var_30 = var_29["entity"];
    var_31 = isDefined(var_30) && isPlayer(var_30) && scripts\cp_mp\utility\player_utility::_id_B78C(self, var_30);
    var_32 = var_31 && var_30 _meth_83CD(var_12, self) > 0;

    if(!isDefined(var_16) || var_19 < var_16) {
      var_16 = var_19;
    }

    if(!isDefined(var_17) || var_19 > var_17) {
      var_17 = var_19;
    }

    var_8 = 1;
    var_33 = max(abs(var_16 - var_17) * 0.5, 300.0);
    var_34 = 0.0;
    var_35 = max(var_16 - 50.0, 1.0);
    var_36 = var_17 + 50.0;
    var_37 = var_36 + var_33;
    var_38 = scripts\engine\utility::ter_op(var_32, 6.0, 4.0);
    var_39 = scripts\engine\utility::ter_op(var_32, 2.5, 1.25);
    _id_0CE5(var_34, var_35, var_36, var_37, var_38, var_39);
  }
}

_id_D523() {
  self endon("disconnect");
  self._id_FF0A = 1;
  _id_D524();
  _id_D51E();
}

_id_D524() {
  self endon("disconnect");
  self endon("death_delay_finished");
  var_0 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip"];
  var_1 = physics_createcontents(var_0);
  var_2 = vectornormalize(self.origin - self._id_8FFD.origin);
  var_3 = self.origin + (0, 0, 42);
  var_4 = var_3 + var_2 * 120.0;
  var_5 = scripts\engine\trace::_id_E409(var_3, var_4, 2.0, self, var_1, 0);
  var_6 = var_5["position"];

  while(istrue(self._id_FF0A)) {
    if(!isDefined(self._id_8FFD)) {
      break;
    }

    var_7 = distance(var_6, self._id_8FFD.origin);
    var_8 = 0.0;
    var_9 = max(var_7 - 12.0, 1.0);
    var_10 = var_7 + 12.0;
    var_11 = var_10 + 50.0;
    var_12 = 8.0;
    var_13 = 4.5;
    _id_0CE5(var_8, var_9, var_10, var_11, var_12, var_13);
    waitframe();
  }
}

_id_D51E() {
  self._id_FF0A = 0;
  _id_0CE5(0, 0, 512, 512, 4, 0);
}

_id_D52A() {
  self._id_FF0A = 1;
  _id_0CE5(0, 0, 512, 512, 4, 0);
}

_id_D522() {
  self._id_FF0A = 1;
  _id_0CE5(0, 128, 512, 4000, 6, 1.8);
}

_id_D51B() {
  self._id_FF0A = 1;
  _id_0CE5(10, 80, 1000, 6500, 7, 3.5);
}

_id_D51D() {
  self._id_FF0A = 1;
  _id_0CE5(10, 80, 1000, 6500, 7, 3.5);
}

_id_D51C() {
  self._id_FF0A = 1;
  _id_0CE5(10, 80, 1000, 1000, 7, 0);
}

_id_D52B() {
  self._id_FF0A = 1;
  _id_0CE5(10, 120, 1000, 6500, 7, 3.5);
}

_id_D52C() {
  self._id_FF0A = 1;
  _id_0CE5(0, 110, 512, 4096, 6, 1.8);
}

_id_D520() {
  self._id_FF0A = 1;
  _id_0CE5(10, 80, 1000, 1000, 7, 0);
}

_id_D521() {
  self._id_FF0A = 1;
  _id_0CE5(10, 80, 1000, 6500, 10, 5);
}

_id_D525() {
  self._id_FF0A = 1;
  _id_0CE5(10, 80, 1000, 5000, 4, 3.5);
}

_id_D526() {
  self._id_FF0A = 1;
  _id_0CE5(10, 80, 800, 4000, 4.5, 3.5);
}

_id_D527() {
  self._id_FF0A = 1;
  _id_0CE5(10, 80, 600, 3000, 5, 3.5);
}

_id_D528() {
  self._id_FF0A = 1;
  _id_0CE5(10, 80, 500, 2000, 5.5, 3.5);
}

_id_D529() {
  self._id_FF0A = 1;
  _id_0CE5(10, 80, 400, 1000, 6, 3.5);
}

_id_5265(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("spawn_ignore", var_0, var_1);

  if(isDefined(var_2)) {
    self _meth_868E(!var_2);
  }
}

_id_898A() {
  return scripts\common\input_allow::_id_860C("spawn_ignore");
}

_id_394E() {
  self._id_01D2 = -1;
  self.killcamentity = -1;
  self._id_0060 = 0;
  self._id_0061 = 0;
  self._id_0354 = 0;
  self._id_03EB = 0;
}

_id_88C7() {
  if(isai(self)) {
    return 0;
  }

  if(self._id_03EB) {
    if(self._id_01D2 == -1 && self.killcamentity == -1) {
      return 0;
    }
  }

  return self._id_03EB;
}

_id_10968(var_0, var_1) {
  self endon("death_or_disconnect");
  var_2 = 0;

  if(!isDefined(var_1)) {
    var_1 = 0.05;
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  for(;;) {
    if(self.health != self.maxhealth) {
      var_2 = 0;
    } else {
      var_2 = var_2 + var_1;
    }

    wait(var_1);

    if(self.health == self.maxhealth && var_2 >= var_0) {
      break;
    }
  }

  return;
}

_id_1546(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("health_regen", var_0, var_1);
}

_id_85EC() {
  return scripts\common\input_allow::_id_860C("health_regen");
}

_id_1563(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("one_hit_melee_victim", var_0, var_1);
}

_id_8653() {
  return scripts\common\input_allow::_id_860C("one_hit_melee_victim");
}

_id_153F(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("flashed", var_0, var_1);
}

_id_8553() {
  return scripts\common\input_allow::_id_860C("flashed");
}

_id_1585(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("stunned", var_0, var_1);
}

_id_8554() {
  return scripts\common\input_allow::_id_860C("stunned");
}

_id_1584(var_0, var_1) {
  scripts\common\input_allow::allow_input_internal("stick_kill", var_0, var_1);
}

_id_86D5() {
  return scripts\common\input_allow::_id_860C("stick_kill");
}

_id_0CF0(var_0) {
  self _meth_84A4(var_0);
  self._id_EAF7 = var_0;
}

_id_D1C1() {
  if(isDefined(level._id_B5F8)) {
    _id_0CF0(level._id_B5F8);
  } else {
    _id_0CF0("zom_suit");
  }
}

_id_50EE(var_0, var_1) {
  if(!isDefined(self._id_5542)) {
    _id_7F68();
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = undefined;

  if(var_1) {
    var_2 = level._id_5543._id_AE82[var_0];
  } else {
    var_2 = level._id_5543._id_AE81[var_0];
  }

  var_3 = self._id_5542._id_421D[var_2];
  var_4 = "active" + var_3;
  self setscriptablepartstate(var_2, var_4, 0);
  var_3++;

  if(var_3 > 4) {
    var_3 = scripts\engine\utility::_id_9FC4(var_3, 4);
  }

  self._id_5542._id_421D[var_2] = var_3;
}

_id_38C9() {
  if(!isDefined(self._id_5542)) {
    return;
  }
  if(!isDefined(level._id_5543)) {
    _id_7F67();
  }

  foreach(var_1 in level._id_5543._id_AE81) {
    self setscriptablepartstate(var_1, "neutral", 0);
  }

  foreach(var_1 in level._id_5543._id_AE82) {
    self setscriptablepartstate(var_1, "neutral", 0);
  }

  self._id_5542 = undefined;
}

_id_C995(var_0, var_1) {
  if(!isDefined(self._id_C990)) {
    _id_8099();
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = undefined;

  if(var_1) {
    var_2 = level._id_C991._id_AE82[var_0];
  } else {
    var_2 = level._id_C991._id_AE81[var_0];
  }

  var_3 = self._id_C990._id_421D[var_2];
  var_4 = "active" + var_3;
  self setscriptablepartstate(var_2, var_4, 0);
  var_3++;

  if(var_3 > 4) {
    var_3 = scripts\engine\utility::_id_9FC4(var_3, 4);
  }

  self._id_C990._id_421D[var_2] = var_3;
}

_id_38FE() {
  if(!isDefined(self._id_C990)) {
    return;
  }
  foreach(var_1 in level._id_C991._id_AE81) {
    self setscriptablepartstate(var_1, "neutral", 0);
  }

  foreach(var_1 in level._id_C991._id_AE82) {
    self setscriptablepartstate(var_1, "neutral", 0);
  }

  self._id_C990 = undefined;
}

_id_7F67() {
  level._id_5543 = spawnStruct();
  var_0 = [];
  var_1 = "shakeeq";

  for(var_2 = 1; var_2 <= 4; var_2++) {
    var_0[var_2] = var_1 + var_2;
  }

  level._id_5543._id_AE81 = var_0;
  var_0 = [];
  var_1 = "shakeeqview";

  for(var_2 = 1; var_2 <= 4; var_2++) {
    var_0[var_2] = var_1 + var_2;
  }

  level._id_5543._id_AE82 = var_0;
}

_id_7F68() {
  if(!isDefined(level._id_5543)) {
    _id_7F67();
  }

  self._id_5542 = spawnStruct();
  var_0 = [];

  foreach(var_2 in level._id_5543._id_AE81) {
    var_0[var_2] = 1;
  }

  foreach(var_2 in level._id_5543._id_AE82) {
    var_0[var_2] = 1;
  }

  self._id_5542._id_421D = var_0;
}

_id_8098() {
  level._id_C991 = spawnStruct();
  var_0 = [];
  var_1 = "shakerumb";

  for(var_2 = 1; var_2 <= 4; var_2++) {
    var_0[var_2] = var_1 + var_2;
  }

  level._id_C991._id_AE81 = var_0;
  var_0 = [];
  var_1 = "shakerumbview";

  for(var_2 = 1; var_2 <= 4; var_2++) {
    var_0[var_2] = var_1 + var_2;
  }

  level._id_C991._id_AE82 = var_0;
}

_id_8099() {
  if(!isDefined(level._id_C991)) {
    _id_8098();
  }

  self._id_C990 = spawnStruct();
  var_0 = [];

  foreach(var_2 in level._id_C991._id_AE81) {
    var_0[var_2] = 1;
  }

  foreach(var_2 in level._id_C991._id_AE82) {
    var_0[var_2] = 1;
  }

  self._id_C990._id_421D = var_0;
}