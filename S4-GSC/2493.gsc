/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2493.gsc
*************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("uav", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("uav", "init")]]();
  }

  var_0 = getEntArray("minimap_corner", "targetname");

  if(var_0.size) {
    var_1 = var_0[0].origin;
    var_2 = var_0[1].origin;
    var_3 = (0, 0, 0);
    var_3 = var_2 - var_1;
    var_3 = (var_3[0] / 2, var_3[1] / 2, var_3[2] / 2) + var_1;
    level._id_F901 = var_3;
  } else
    level._id_F901 = (0, 0, 0);

  level._id_F8FF = spawn("script_model", level._id_F901);
  level._id_F8FF setModel("tag_origin");
  level._id_F8FF.angles = (0, 115, 0);
  level._id_F8FF hide();
  level._id_F8FF._id_0481 = "uavrig_script_model";
  level._id_F8FF thread _id_C929(60);
  level._id_F900 = spawn("script_model", level._id_F901);
  level._id_F900 setModel("tag_origin");
  level._id_F900.angles = (0, 115, 0);
  level._id_F900 hide();
  level._id_F900._id_0481 = "uavrig_script_model";
  level._id_F900 thread _id_C929(90);
  level._id_3DA7 = spawn("script_model", level._id_F901);
  level._id_3DA7 setModel("tag_origin");
  level._id_3DA7.angles = (0, 115, 0);
  level._id_3DA7 hide();
  level._id_3DA7._id_0481 = "counteruavrig_script_model";
  level._id_3DA7 thread _id_C929(60);
  level._id_11D9 = spawn("script_model", level._id_F901);
  level._id_11D9 setModel("tag_origin");
  level._id_11D9.angles = (0, 115, 0);
  level._id_11D9 hide();
  level._id_11D9._id_0481 = "advanceduavrig_script_model";
  level._id_11D9 thread _id_C929(200);
  level._id_F905 = _func_00E4();
  level._id_F8F2 = _func_00E3();
  level._id_F8F4 = _func_00E1();
  level._id_F8F9 = _func_00E0();
  level._id_F8F5 = _func_00E2();
  level._id_0BCE["plane_propellor"] = loadfx("vfx/s4/vehicle/vfx_propeller_01.vfx");
  _id_0847::_id_DEEC();

  if(level.teambased) {
    for(var_4 = 0; var_4 < level._id_EF89.size; var_4++) {
      level.radarmode[level._id_EF89[var_4]] = "normal_radar";
      level._id_0F66[level._id_EF89[var_4]] = 0;
      level._id_0F3D[level._id_EF89[var_4]] = 0;
      level._id_0F37[level._id_EF89[var_4]] = 0;
      level._id_F8F8[level._id_EF89[var_4]] = [];
    }
  } else {
    level.radarmode = [];
    level._id_0F66 = [];
    level._id_0F3D = [];
    level._id_0F37 = [];
    level._id_F8F8 = [];
  }

  level._id_F36F = 0;
  level._id_F36E = 0;
  level._id_0F36 = 0;
  level thread onplayerconnect();
  level thread onloadoutchange();
  level thread _id_F903();
  game["dialog"]["uav_destroyed"] = "uav_destroyed";
  game["dialog"]["esp_destroyed"] = "mp_glob_kill_bchr_sped";
}

onloadoutchange() {
  for(;;) {
    level waittill("player_class_change", var_0);
    level notify("uav_update");
  }
}

onplayerconnect() {
  var_0 = _func_00E0();

  for(;;) {
    level waittill("connected", var_1);
    scripts\cp_mp\utility\killstreak_utility::_id_FD71();
    level._id_0F66[var_1.guid] = 0;
    level._id_0F66[var_1.guid + "_radarStrength"] = var_0;
    level._id_0F3D[var_1.guid] = 0;
    level.radarmode[var_1.guid] = "normal_radar";
    var_1._id_0358 = var_0;
  }
}

onplayerspawned() {
  level notify("uav_update");
}

_id_C929(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    self endon(var_2);
  }

  if(!isDefined(var_0)) {
    var_0 = 60;
  }

  if(!isDefined(var_1)) {
    var_1 = -360;
  }

  self._id_C925 = var_0;
  self._id_C922 = var_1;

  for(;;) {
    self rotateyaw(var_1, var_0);
    wait(var_0);
  }
}

_id_F7A4(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::_id_4056(var_0, self);
  return _id_F7A6(var_1);
}

_id_F7A6(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_1 = var_0.streakname;
  var_2 = self.pers["team"];
  var_3 = self.guid;
  var_4 = var_3;

  if(level.teambased) {
    var_4 = var_2;
  }

  var_5 = undefined;

  switch (var_1) {
    case "uav":
      if(getdvarint("#x35ff4106e4998209e", 1) == 0) {
        var_5 = "KILLSTREAKS/UNAVAILABLE";
      } else if(isDefined(level._id_0F66[var_4]) && level._id_0F66[var_4] > 2) {
        var_5 = "KILLSTREAKS/SPY_PLANE_CANNOT_BE_USED";
      }

      break;
    case "directional_uav":
      if(getdvarint("#x377f6e388981433d2", 1) == 0) {
        var_5 = "KILLSTREAKS/UNAVAILABLE";
      } else if(isDefined(level._id_0F37[var_4]) && level._id_0F37[var_4] > 0) {
        var_5 = "KILLSTREAKS/LOCAL_INFORMANTS_CANNOT_BE_USED";
      }

      break;
    case "counter_spy_plane":
      if(getdvarint("#x3bdb9ac688c17ee5a", 1) == 0) {
        var_5 = "KILLSTREAKS/UNAVAILABLE";
      } else if(isDefined(level._id_0F3D[var_4]) && level._id_0F3D[var_4] > 0) {
        var_5 = "KILLSTREAKS/COUNTER_SPY_PLANE_CANNOT_BE_USED";
      }

      break;
  }

  if(isDefined(var_5)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](var_5);
    }

    return 0;
  }

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      return 0;
    }
  }

  var_6 = _id_09B9::_id_EA01(var_0, makeweapon("s4_ks_gesture_generic_mp"));

  if(!istrue(var_6)) {
    return 0;
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      return 0;
    }
  }

  var_7 = _id_FEEE(var_0.streakname, var_0);
  return istrue(var_7);
}

_id_FEEE(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var_0, self.origin);
  }

  var_2 = self.pers["team"];
  var_3 = level._id_F902[var_0]._id_F224;
  var_4 = 0;
  level thread _id_9103(self, var_0, var_1, var_4);

  switch (var_0) {
    case "counter_spy_plane":
      self notify("used_counter_uav");
      break;
    case "directional_uav":
      self.radarshowenemydirection = 1;

      if(level.teambased) {
        foreach(var_6 in level.players) {
          if(var_6.pers["team"] == var_2) {
            var_6.radarshowenemydirection = 1;
          }
        }
      }

      self notify("used_directional_uav");
      break;
    default:
      self notify("used_uav");

      if(level.teambased) {
        var_8 = _id_0C08(var_2);
      }

      break;
  }

  return 1;
}

counterspyplane_watchkills(var_0) {
  self endon("death");
  var_0 endon("uav_finished");

  for(;;) {
    level waittill("player_killed", var_1, var_2);

    if(var_2.team == var_0.team) {
      var_0 thread scripts\mp\killstreaks\killstreaks::givescoreforalliedkillsduringcounterspyplane();
    }

    waitframe();
  }
}

_id_5D45(var_0, var_1, var_2) {
  self endon("death");
  var_3 = 1800;

  switch (self._id_F904) {
    case "counter_spy_plane":
      var_3 = 1500;
      break;
  }

  var_4 = 20000 / var_3;
  var_5 = (0, var_1 - 90, 0);
  var_6 = var_0 gettagorigin("tag_origin") + var_2;
  var_7 = var_6 - anglesToForward(var_5) * 20000;
  self.origin = var_7;
  self.angles = var_5;
  self moveto(var_6, var_4, 0, 1);
  wait(var_4 - 3);
  self rotateroll(45, 3);
  wait 3;
  self linkto(var_0, "tag_origin");
}

_id_9103(var_0, var_1, var_2, var_3) {
  var_4 = var_0.team;
  var_5 = _id_6E1D(var_1);

  if(scripts\cp_mp\utility\game_utility::_id_88FE()) {
    if(level.gametype == "arm") {
      if(isDefined(level._id_7B20)) {
        var_5.origin = level._id_7B20;
      }
    } else
      var_5.origin = var_0.origin;
  }

  var_6 = undefined;

  if(istrue(var_3)) {
    var_6 = spawnStruct();
    var_6._id_014E = 0;
  } else {
    var_6 = spawn("script_model", var_5 gettagorigin("tag_origin") + (0, 0, 10000));
    var_6._id_DEC8 = spawn("script_model", var_6.origin);
    var_6._id_DEC8 setModel("tag_origin");
    thread _id_084C::_id_F8EB(var_6._id_DEC8, var_1);
  }

  var_7 = level._id_F902[var_1].modelbase;

  if(scripts\cp_mp\utility\player_utility::_id_6C67(var_0) && isDefined(level._id_F902[var_1]._id_9FD1)) {
    var_7 = level._id_F902[var_1]._id_9FD1;
  }

  var_8 = level._id_F902[var_1]._id_F224;

  if(var_0 scripts\cp_mp\utility\killstreak_utility::_id_0C44("specialty_reaper") && var_0 scripts\cp_mp\utility\killstreak_utility::_id_C0B7(var_1)) {
    var_8 = var_8 * 1.5;

    foreach(var_11, var_10 in var_0._id_E9FF._id_EA14) {
      if(var_10.streakname == var_1 && istrue(var_0._id_E9FF._id_EA14[var_11]._id_C0B4)) {
        var_0._id_E9FF._id_EA14[var_11]._id_C0B4 = undefined;
      }
    }
  }

  var_13 = level._id_F902[var_1].maxhealth;
  var_14 = level._id_F902[var_1]._id_EFAC;
  var_15 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](var_0, var_2.streakname);
    var_15 = 2.0;
  }

  if(level.gametype == "br") {
    var_0 _id_F8EA(var_4, 15000, var_1);
  }

  var_0 thread scripts\cp_mp\utility\killstreak_utility::_id_B86F("use_" + var_2.streakname, 1, var_15);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]](var_14, var_0);
  }

  if(isent(var_6)) {
    var_6 setModel(var_7);
  }

  var_6.team = var_4;
  var_6.owner = var_0;
  var_6._id_F27E = 0;
  var_6._id_F904 = var_1;
  var_6.health = level._id_F902[var_1].health;
  var_6.maxhealth = var_13;
  var_6.streakinfo = var_2;
  var_6._id_41BE = 0;
  var_16 = undefined;

  switch (var_1) {
    case "uav":
      var_16 = "v_ui_icon_hud_minimap_killstreak04";
      break;
    case "counter_spy_plane":
      var_16 = "v_ui_icon_hud_minimap_killstreak02";
      break;
  }

  if(isDefined(var_16) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
    var_6._id_9F26 = var_6[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]](var_16, var_6.team, undefined, 1, 1);
  }

  if(var_1 == "counter_spy_plane") {
    var_17 = spawn("script_model", var_6 gettagorigin("tag_turbine_l_fx"));
    var_17 setModel("tag_origin");
    var_17 linkto(var_6, "tag_turbine_l_fx");
    var_6.propellorfx[0] = var_17;
    playFXOnTag(level._id_0BCE["plane_propellor"], var_6.propellorfx[0], "tag_origin");
    var_18 = spawn("script_model", var_6 gettagorigin("tag_turbine_r_fx"));
    var_18 setModel("tag_origin");
    var_18 linkto(var_6, "tag_turbine_r_fx");
    var_6.propellorfx[1] = var_18;
    playFXOnTag(level._id_0BCE["plane_propellor"], var_6.propellorfx[1], "tag_origin");
  } else if(var_1 == "uav") {
    var_17 = spawn("script_model", var_6 gettagorigin("tag_prop_00"));
    var_17 setModel("tag_origin");
    var_17 linkto(var_6, "tag_prop_00");
    var_6.propellorfx[0] = var_17;
    playFXOnTag(level._id_0BCE["plane_propellor"], var_6.propellorfx[0], "tag_origin");
  }

  foreach(var_20 in level.players) {
    if(uav_isfriendlyteam(var_20, var_6)) {
      var_6 hidefromplayer(var_20);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "Objective_PlayerMask_HideFrom") && isDefined(var_6._id_9F26)) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "Objective_PlayerMask_HideFrom")]](var_6._id_9F26, var_20);
      }

      if(isDefined(var_6.propellorfx)) {
        foreach(var_22 in var_6.propellorfx) {
          var_22 hidefromplayer(var_20);
        }
      }
    }
  }

  var_6 thread _id_A12D();
  var_6 thread _id_C712();
  var_6 thread _id_10B64();

  if(isent(var_6)) {
    var_6 setotherent(var_0);
    var_6 _meth_856D();
    var_6 _meth_85AF();
    var_6 _meth_8851(3, var_0.team);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
      var_6[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_1, "Killstreak_Air", var_0);
    }

    var_6 thread _id_4331();
    var_6 thread _id_0A2D::_id_745A();
    var_6 thread _id_AFCB();
    var_6 thread _id_F43C();
    var_25 = 6500;

    if(var_6._id_F904 == "counter_spy_plane") {
      var_25 = 6500;
    }

    if(isDefined(level._id_E34D)) {
      var_26 = level._id_E34D;
    } else {
      var_26 = level._id_E726;
    }

    if(!isDefined(var_26)) {
      var_27 = spawnStruct();
      var_27.origin = (var_0.origin[0], var_0.origin[1], 6969);
      var_26 = [var_27];
    }

    var_28 = var_26[0];

    foreach(var_27 in var_26) {
      if(var_27.origin[2] < var_28.origin[2]) {
        var_28 = var_27;
      }
    }

    var_31 = var_28.origin[2];
    var_32 = var_5.origin[2];

    if(var_31 < 0) {
      var_32 = var_32 + var_31 * -1;
      var_31 = 0;
    }

    var_33 = randomint(360);
    var_34 = randomint(1000);

    if(var_6._id_F904 == "directional_uav") {
      var_34 = randomintrange(20000, 22000);
    }

    var_35 = var_34 + 4000;
    var_36 = cos(var_33) * var_35;
    var_37 = sin(var_33) * var_35;
    var_38 = vectornormalize((var_36, var_37, var_25));
    var_38 = var_38 * var_25;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
      var_39 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();

      if(var_39 == "br") {
        var_38 = var_38 + (0, 0, 2000);
      }
    }

    var_6 thread _id_5D45(var_5, var_33, var_38);
  }

  var_6[[level._id_F902[var_1]._id_10AF]]();

  if(var_1 == "uav" || var_1 == "directional_uav") {
    var_6 _id_C7B1(1);
    var_6 thread _id_19DC();
  } else if(var_1 == "counter_spy_plane")
    var_6 thread counterspyplane_watchkills(var_0);

  if(isDefined(level._id_0F66[var_4]) && level._id_0F66[var_4] > 0) {
    if(isent(var_6)) {
      foreach(var_41 in level._id_F8F8[var_4]) {
        if(var_41 == var_6) {
          continue;
        }
        if(isDefined(var_41._id_F27E)) {
          var_41._id_F27E = var_41._id_F27E + 5;
        }
      }
    } else
      var_6._id_F27E = 5 * (level._id_0F66[var_4] - 1);
  }

  level notify("uav_update");
  var_6 scripts\cp_mp\hostmigration::_id_7AA7("death", var_8);

  if(isDefined(var_6._id_9F26)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](var_6._id_9F26);
    }
  }

  if(isDefined(var_6.propellorfx)) {
    foreach(var_17 in var_6.propellorfx) {
      stopFXOnTag(level._id_0BCE["plane_propellor"], var_17, "tag_origin");
    }
  }

  if(var_6._id_014E < var_6.maxhealth) {
    if(isent(var_6)) {
      var_6 unlink();
      var_6 rotateroll(-44, 3);
      var_6._id_482B = var_6.origin + anglesToForward(var_6.angles) * 20000;
      var_45 = 1800;

      switch (var_6._id_F904) {
        case "counter_spy_plane":
          var_45 = 1500;
          break;
      }

      var_46 = 20000 / var_45;
      var_6 moveto(var_6._id_482B, var_46, 1);

      if(isDefined(level._id_F902[var_1]._id_6091) && isDefined(level._id_F902[var_1]._id_606B)) {
        playFXOnTag(level._id_F902[var_1]._id_6091, var_6, level._id_F902[var_1]._id_606B);
      }
    }

    if(isDefined(var_0) && !istrue(level.gameended)) {
      if(getdvarint("#x3356440afeaa4319", 0)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDialogOnPlayer")) {
          var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDialogOnPlayer")]](level._id_F902[var_6._id_F904]._id_106B4, undefined, undefined, var_0.origin);
        }
      } else
        var_0 scripts\cp_mp\utility\killstreak_utility::_id_B86F(level._id_F902[var_6._id_F904]._id_106B4, 1);
    }

    var_6 scripts\cp_mp\hostmigration::_id_7AA7("death", 3);

    if(var_6._id_014E < var_6.maxhealth) {
      var_6 notify("leaving");
      var_6._id_DEC8 notify("leaving");
      thread _id_084C::_id_F8EC(var_6._id_DEC8, var_1);
      var_6._id_8908 = 1;

      if(isent(var_6)) {
        var_6 moveto(var_6._id_482B, 15);
      }
    }

    var_6 scripts\cp_mp\hostmigration::_id_7AA7("death", 15);

    if(var_6._id_014E < var_6.maxhealth) {
      var_6._id_919D = 1;
    }
  }

  var_6.owner notify("uav_finished");

  if(var_1 == "uav" || var_1 == "directional_uav") {
    var_6 _id_C7B1(level._id_9F28);
  }

  var_6[[level._id_F902[var_1]._id_C4C5]]();

  if(isDefined(level._id_8DD3)) {
    level thread[[level._id_8DD3]](var_2);
  }

  if(isDefined(var_6._id_5423)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](var_6._id_5423);
    }

    var_6 notify("uav_deleteObjective");
  }

  var_6.streakinfo._id_57A7 = !istrue(var_6._id_919D);

  if(!istrue(self._id_C143)) {
    var_6.owner scripts\cp_mp\utility\killstreak_utility::_id_C14A(var_6.streakinfo);
  }

  if(isDefined(var_6)) {
    if(isent(var_6)) {
      var_6 delete();
    } else {
      var_6 notify("death");
    }
  }

  if(var_1 == "directional_uav") {
    var_0.radarshowenemydirection = 0;

    if(level.teambased) {
      foreach(var_20 in level.players) {
        if(isDefined(var_20) && var_20.pers["team"] == var_4) {
          var_20.radarshowenemydirection = 0;
        }
      }
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - " + var_1, var_0);
  }

  level notify("uav_update");
}

_id_A12D() {
  self endon("death");
  self.owner scripts\engine\utility::waittill_any_2("disconnect", "joined_team");

  if(isent(self)) {
    self hide();
    var_0 = anglestoright(self.angles) * 200;
    playFX(level._id_F902[self._id_F904]._id_6090, self.origin, var_0);
    playsoundatpos(self.origin, level._id_F902[self._id_F904]._id_E053);
    self._id_014E = self.maxhealth;
  }

  self notify("death");
}

_id_C712() {
  self endon("death");

  for(;;) {
    level waittill("host_migration_end");

    if(level.teambased) {
      foreach(var_1 in level._id_EF89) {
        var_2 = _id_0C08(var_1);
        _id_0CF1(var_1, var_2);
      }
    }
  }
}

_id_FD70() {
  self endon("death");

  for(;;) {
    level scripts\engine\utility::_id_108C5("joined_team", "uav_update");
    self hide();

    foreach(var_1 in level.players) {
      if(level.teambased) {
        if(var_1.team != self.team) {
          self showtoplayer(var_1);
        }

        continue;
      }

      if(isDefined(self.owner) && var_1 == self.owner) {
        continue;
      }
      self showtoplayer(var_1);
    }
  }
}

_id_4331() {
  level endon("game_ended");
  self setCanDamage(1);
  self._id_014E = 0;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "mapWeapon")) {
      var_9 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "mapWeapon")]](var_9, var_13);
    }

    if(!isPlayer(var_1)) {
      if(!isDefined(self)) {
        return;
      }
    } else {
      if(self._id_F904 == "directional_uav" && (var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_PISTOL_BULLET" || var_4 == "MOD_EXPLOSIVE_BULLET")) {
        continue;
      }
      if(uav_isfriendlyteam(var_1, self) && getdvarint("#x3e0ef8627be45090a", 0) == 0) {
        continue;
      }
      if(isDefined(var_8) && var_8 &level._id_7CA1) {
        self._id_10A0F = 1;
      }

      if(isDefined(var_8) && var_8 &level._id_7CA3) {
        self._id_10A10 = 1;
      }

      self._id_10A0C = 1;
      var_14 = var_0;

      if(isPlayer(var_1)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback")) {
          var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("hitequip");
        }

        if(var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_PISTOL_BULLET") {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
            if(var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_armorpiercing")) {
              var_14 = var_14 + var_0 * level._id_1B5C;
            }
          }
        }
      }

      var_15 = 1;
      var_16 = 1;
      var_17 = 1;

      if(self._id_F904 == "directional_uav") {
        var_15 = 5;
        var_16 = 6;
        var_17 = 7;
      }

      if(isDefined(var_9)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage")) {
          var_14 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](var_1, var_9, var_4, var_14, self.maxhealth, var_15, var_16, var_17);
        }

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakHit")) {
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakHit")]](var_1, var_9, self, var_4, var_14);
        }

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "logAttackerKillstreak")) {
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "logAttackerKillstreak")]](self, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, getcompleteweaponname(var_9));
        }
      }

      self._id_014E = self._id_014E + var_14;

      if(isDefined(level._id_F902[self._id_F904].fxid_damaged) && self._id_014E > self.maxhealth / 2.0 && self._id_41BE == 0) {
        self._id_41BE = 1;
        var_18 = self gettagorigin("tag_body");
        self.damagedfxent = spawn("script_model", var_18);
        self.damagedfxent setModel("tag_origin");
        self.damagedfxent.angles = self.angles;
        self.damagedfxent linkto(self, "tag_body", (0, 0, 0), (0, 0, 0));
        playFXOnTag(level._id_F902[self._id_F904].fxid_damaged, self.damagedfxent, "tag_origin");

        foreach(var_20 in level.players) {
          if(uav_isfriendlyteam(var_20, self)) {
            self.damagedfxent hidefromplayer(var_20);
            self hidefromplayer(var_20);
          }
        }
      }

      if(self._id_014E >= self.maxhealth) {
        if(isPlayer(var_1) && (!isDefined(self.owner) || var_1 != self.owner)) {
          var_22 = level._id_F902[self._id_F904]._id_2F7B;
          var_23 = "destroyed_" + self._id_F904;

          if(self._id_F904 == "uav") {
            var_23 = undefined;
            self.owner scripts\cp_mp\utility\killstreak_utility::_id_B86F("uav_destroyed", 1);
            thread _id_0A8D::_id_9136("esp_destroyed", var_1.team);
          }

          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "onKillstreakKilled")) {
            self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "onKillstreakKilled")]](self._id_F904, var_1, var_9, var_4, var_0, "destroyed_" + self._id_F904, var_23, var_22);
          }

          if(isDefined(self._id_F8FE) && self._id_F8FE != var_1) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("uav", "remoteUAV_processTaggedAssist")) {
              self._id_F8FE thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("uav", "remoteUAV_processTaggedAssist")]]();
            }
          }
        }

        self hide();
        var_24 = anglestoright(self.angles) * 200;
        var_25 = spawnfx(level._id_F902[self._id_F904]._id_6090, self.origin, var_24);
        triggerfx(var_25);
        var_25 thread scripts\mp\utility\script::_id_46C7(5);

        foreach(var_20 in level.players) {
          if(uav_isfriendlyteam(var_20, self)) {
            var_25 hidefromplayer(var_20);
          }
        }

        stopFXOnTag(level._id_F902[self._id_F904].fxid_damaged, self.damagedfxent, "tag_origin");
        playsoundatpos(self.origin, level._id_F902[self._id_F904]._id_E053);
        self notify("death");
        return;
      }
    }
  }
}

_id_F903() {
  level endon("game_ended");

  for(;;) {
    level waittill("uav_update");

    if(level.teambased) {
      foreach(var_1 in level._id_EF89) {
        _id_FD5F(var_1);
      }

      continue;
    }

    _id_FD05();
  }
}

_id_74B6() {
  foreach(var_1 in level.players) {
    if(isDefined(self.streakname) && (self.streakname == "directional_uav" || self.streakname == "counter_spy_plane")) {
      return;
    }
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
      if(!var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_expanded_minimap")) {
        continue;
      }
    }

    if(var_1.team == self.team) {
      continue;
    }
    thread _id_56F0(var_1);
  }
}

_id_56F0(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  _func_0253(var_0);
  self waittill("death");
  _func_0253(var_0);
}

_id_0C08(var_0) {
  var_1 = level._id_0F66[var_0];
  var_2 = level._id_0F37[var_0];
  var_3 = level._id_F36E - level._id_0F3D[var_0];
  var_4 = _func_00E4();
  var_5 = _func_00E3();

  if(var_2) {
    var_1 = var_5 - _func_00E0();
  }

  if(var_3 > 0) {
    var_6 = var_4;
  } else if(var_2 > 0) {
    var_6 = var_5;
  } else if(level.gametype == "br") {
    var_6 = int(clamp(var_1 + _func_00E0(), _func_00E0(), _func_00E1()));
  } else {
    var_6 = int(clamp(var_1 + _func_00E0(), _func_00E0(), var_5));
  }

  var_6 = int(clamp(var_6, var_4, var_5));
  return var_6;
}

_id_0CF1(var_0, var_1) {
  _id_FD5F(var_0, var_1);
}

_id_FD5F(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = _id_0C08(var_0);
  }

  var_2 = int(max(min(var_2, level._id_F8F2), level._id_F905));
  var_3 = var_2 == level._id_F905;
  var_4 = !var_3;
  var_5 = var_2 >= level._id_F8F4;
  var_6 = !var_3;

  if(var_2 == level._id_F8F9) {
    var_7 = "normal_radar";
    var_4 = 0;
  } else if(var_2 == level._id_F8F2 || var_5)
    var_7 = "constant_radar";
  else if(var_2 == level._id_F8F5) {
    var_7 = "fast_radar";
  } else {
    var_7 = "normal_radar";
  }

  var_8 = level.players;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getTeamData")) {
    var_8 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getTeamData")]](var_0, "players");
  }

  foreach(var_10 in var_8) {
    if(!isDefined(var_10)) {
      continue;
    }
    var_10._id_0358 = scripts\engine\utility::ter_op(var_10 scripts\mp\utility\perk::_hasperk("specialty_engineer") && var_2 == 0, 3, var_2);
    var_10._id_024A = scripts\engine\utility::ter_op(var_10 scripts\mp\utility\perk::_hasperk("specialty_engineer"), 0, var_3);
    var_10.hasradar = var_4;
    var_10.radarshowenemydirection = var_5;

    if(var_10.radarshowenemydirection) {
      var_10.radarmode = "constant_radar";
    } else {
      var_10.radarmode = var_7;
    }

    var_10 setclientomnvar("ui_show_hardcore_minimap", scripts\engine\utility::ter_op(var_10 scripts\mp\utility\perk::_hasperk("specialty_engineer"), 1, var_6));
  }
}

_id_FD05() {
  foreach(var_1 in level.players) {
    var_2 = level._id_0F66[var_1.guid + "_radarStrength"];
    var_3 = level._id_F36E - level._id_0F3D[var_1.guid];

    if(var_3 > 0) {
      var_2 = level._id_F905;
    }

    var_2 = int(max(min(var_2, level._id_F8F2), level._id_F905));
    var_1._id_0358 = var_2;
    var_1._id_024A = var_2 == level._id_F905;
    var_4 = var_1.team == "spectator" || var_1.team == "follower" || var_1.team == "free";

    if(var_2 <= level._id_F8F9 || var_4) {
      var_1.hasradar = 0;
      var_1.radarshowenemydirection = 0;

      if(isDefined(var_1.radarmode) && var_1.radarmode == "constant_radar") {
        var_1.radarmode = "normal_radar";
      }

      var_1 setclientomnvar("ui_show_hardcore_minimap", 0);
      continue;
    }

    if(var_2 >= level._id_F8F5) {
      var_1.radarmode = "fast_radar";
    } else {
      var_1.radarmode = "normal_radar";
    }

    var_1.radarshowenemydirection = var_2 >= level._id_F8F4;

    if(istrue(var_1.radarshowenemydirection)) {
      var_1.radarmode = "constant_radar";
    }

    var_1.hasradar = 1;
    var_1 setclientomnvar("ui_show_hardcore_minimap", 1);
  }
}

_id_745C() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("stinger_fired", var_0, var_1, var_2);

    if(!isDefined(var_2) || var_2 != self) {
      continue;
    }
    var_1 thread _id_E85A(var_2, var_0);
  }
}

_id_F43C() {
  level endon("game_ended");
  self endon("death");
  self._id_04DF = (0, 0, 0);

  for(;;) {
    self._id_9023 = self.origin;
    wait 0.05;
    self._id_04DF = (self.origin - self._id_9023) / 0.05;
  }
}

_id_10B64() {
  self endon("death");
  self.owner endon("uav_finished");
  level waittill("game_ended");
  self._id_C143 = 1;
  self.owner scripts\cp_mp\utility\killstreak_utility::_id_C14A(self.streakinfo);
}

_id_E85A(var_0, var_1) {
  self endon("death");
  var_2 = distance(self.origin, var_0 _meth_8174(0, 0, 0));
  var_3 = var_0 _meth_8174(0, 0, 0);

  for(;;) {
    if(!isDefined(var_0)) {
      var_4 = var_3;
    } else {
      var_4 = var_0 _meth_8174(0, 0, 0);
    }

    var_3 = var_4;
    var_5 = distance(self.origin, var_4);

    if(var_5 < var_2) {
      var_2 = var_5;
    }

    if(var_5 > var_2) {
      if(var_5 > 1536) {
        return;
      }
      _func_01BA(self.origin, 1536, 600, 600, var_1, "MOD_EXPLOSIVE", "iw8_la_gromeo_mp");
      self hide();
      self notify("deleted");
      waitframe();
      self delete();
      var_1 notify("killstreak_destroyed");
    }

    waitframe();
  }
}

_id_1182() {
  if(level.teambased) {
    level._id_F8F8[self.team][level._id_F8F8[self.team].size] = self;
  } else {
    level._id_F8F8[self.owner.guid + "_" + gettime()] = self;
  }
}

_id_C539() {
  var_0 = [];

  if(level.teambased) {
    var_1 = self.team;

    foreach(var_3 in level._id_F8F8[var_1]) {
      if(!isDefined(var_3)) {
        continue;
      }
      var_0[var_0.size] = var_3;
    }

    level._id_F8F8[var_1] = var_0;
  } else {
    foreach(var_3 in level._id_F8F8) {
      if(!isDefined(var_3)) {
        continue;
      }
      var_0[var_0.size] = var_3;
    }

    level._id_F8F8 = var_0;
  }
}

_id_1088() {
  level._id_F36F++;

  if(level.teambased) {
    level._id_0F66[self.team]++;

    if(self._id_F904 == "directional_uav") {
      level._id_0F37[self.team]++;
      level._id_0F36++;
    }
  } else {
    level._id_0F66[self.owner.guid]++;
    level._id_0F66[self.owner.guid + "_radarStrength"]++;

    if(self._id_F904 == "directional_uav") {
      level._id_0F66[self.owner.guid + "_radarStrength"] = level._id_0F66[self.owner.guid + "_radarStrength"] + 2;

      if(!isDefined(level._id_0F37[self.owner.guid])) {
        level._id_0F37[self.owner.guid] = 0;
      }

      level._id_0F37[self.owner.guid]++;
      level._id_0F36++;
    }
  }
}

_id_1087() {
  if(level.teambased) {
    level._id_0F3D[self.team]++;
  } else {
    level._id_0F3D[self.owner.guid]++;
  }

  level._id_F36E++;
}

_id_C468() {
  if(level.teambased) {
    level._id_0F66[self.team]--;
    level._id_F36F--;

    if(self._id_F904 == "directional_uav") {
      level._id_0F37[self.team]--;
      level._id_0F36--;
    }
  } else if(isDefined(self.owner)) {
    level._id_0F66[self.owner.guid]--;
    level._id_F36F--;
    level._id_0F66[self.owner.guid + "_radarStrength"]--;

    if(self._id_F904 == "directional_uav") {
      level._id_0F66[self.owner.guid + "_radarStrength"] = level._id_0F66[self.owner.guid + "_radarStrength"] - 2;
      level._id_0F37[self.owner.guid]--;
      level._id_0F36--;
    }
  }
}

_id_C466() {
  if(level.teambased) {
    level._id_0F3D[self.team]--;
  } else if(isDefined(self.owner)) {
    level._id_0F3D[self.owner.guid]--;
  }

  level._id_F36E--;
}

_id_10B7E(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    var_3 endon("death");
  }

  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::_id_108AE(var_2, "leave");

  if(isDefined(var_1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](var_0, var_1);
    }
  }
}

_id_6E1D(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "uav":
      var_1 = level._id_F8FF;
      break;
    case "counter_spy_plane":
      var_1 = level._id_3DA7;
      break;
    case "directional_uav":
      var_1 = level._id_11D9;
      break;
    case "default":
      break;
  }

  return var_1;
}

_id_AFCB() {
  self.owner endon("disconnect");
  self endon("uav_deleteObjective");

  switch (self._id_F904) {
    case "uav":
      var_0 = "icon_minimap_uav";
      break;
    case "counter_spy_plane":
      var_0 = "icon_minimap_uav";
      break;
    case "directional_uav":
      var_0 = "icon_minimap_auav";
      break;
    default:
      var_0 = "icon_minimap_uav";
  }

  var_1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
    var_1 = scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjectiveEngineer");
  }

  if(isDefined(var_1)) {
    self._id_5423 = self[[var_1]](var_0, 1, 1);
  }

  var_2 = 0;

  for(;;) {
    var_3 = level.players.size;

    for(var_4 = 0; var_4 < 10; var_4++) {
      if(var_2 >= level.players.size) {
        var_2 = 0;
      }

      var_5 = level.players[var_2];
      var_2++;

      if(!isDefined(var_5)) {
        continue;
      }
      if(self._id_5423 != -1) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "objectivePlayerMaskAddShowPlayer") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "objectivePlayerMaskHideFrom")) {
          if(var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_engineer") && istrue(scripts\cp_mp\utility\player_utility::_id_B78C(var_5, self.owner))) {
            [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "objectivePlayerMaskAddShowPlayer")]](self._id_5423, var_5);
            continue;
          }

          [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "objectivePlayerMaskHideFrom")]](self._id_5423, var_5);
        }
      }
    }

    waitframe();
  }
}

_id_E729() {
  level endon("game_ended");

  foreach(var_1 in level.players) {
    if(!var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(level.teambased && var_1.team == self.owner.team) {
      continue;
    }
    if(!level.teambased && var_1 == self.owner) {
      continue;
    }
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
      if(!var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_empimmune")) {
        var_1 thread _id_DD0E(self);
      }
    }
  }

  thread _id_19E9();
}

_id_6F9B(var_0) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "givePerk")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "givePerk")]]("specialty_coldblooded");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "givePerk")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "givePerk")]]("specialty_tracker_jammer");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "givePerk")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "givePerk")]]("specialty_noscopeoutline");
  }

  var_0 waittill("death");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "removePerk")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "removePerk")]]("specialty_coldblooded");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "removePerk")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "removePerk")]]("specialty_tracker_jammer");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "removePerk")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "removePerk")]]("specialty_noscopeoutline");
  }
}

_id_DD0E(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self _meth_8619(1);
  var_0 waittill("death");
  self _meth_8619(0);
}

_id_19E9() {
  self endon("death");
  level endon("game_ended");
  var_0 = self.owner;
  var_1 = var_0.team;

  for(;;) {
    level waittill("player_spawned", var_2);

    if(var_2 == var_0) {
      continue;
    }
    if(level.teambased && var_2.team == var_1) {
      continue;
    }
    var_2 thread _id_DD0E(self);
  }
}

_id_E6A5() {
  self endon("death");
  level endon("game_ended");
  wait 2;
  self playSound("jammer_drone_charge");
  playFXOnTag(scripts\engine\utility::getfx("jammer_drone_charge"), self, "tag_origin");
  wait 1.5;
  stopFXOnTag(scripts\engine\utility::getfx("jammer_drone_charge"), self, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("jammer_drone_shockwave"), self, "tag_origin");
  self playSound("jammer_drone_shockwave");

  foreach(var_1 in level.players) {
    if(!var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    var_1 thread _id_19F1();
  }

  var_3 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getEnemyTeams")) {
    var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getEnemyTeams")]](self.team);
  }

  foreach(var_5 in var_3) {
    _id_483E(var_5, self.owner);
  }
}

_id_19F1() {
  self playLoopSound("emp_nade_lp");
  thread _id_19F2();
  wait 0.5;
  self playSound("emp_nade_lp_end");
  self stoploopsound("emp_nade_lp");
}

_id_19F2() {
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
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "doDamageToKillstreak")) {
          var_7[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "doDamageToKillstreak")]](10000, var_1, var_1, var_0, var_7.origin, "MOD_EXPLOSIVE", var_2);
        }
      }
    }
  }
}

_id_C7B1(var_0) {
  var_1 = undefined;

  if(level.teambased) {
    var_1 = self.team;
  } else {
    var_1 = self.owner.guid;
  }

  foreach(var_3 in level.players) {
    if(isai(var_3)) {
      continue;
    }
    if(level.teambased && self.team != var_3.team) {
      continue;
    }
    if(!level.teambased && self.owner != var_3) {
      continue;
    }
    if(!var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(istrue(var_0)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "showMiniMap")) {
        var_3[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "showMiniMap")]]();
      }

      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "hideMiniMap")) {
      var_3[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "hideMiniMap")]]();
    }
  }
}

_id_19DC() {
  self.owner endon("disconnect");
  self endon("death");
  level endon("game_ended");
  var_0 = self.owner.guid;

  if(level.teambased) {
    var_0 = self.team;
  }

  level notify("uav_show_minimap_" + var_0);
  level endon("uav_show_minimap_" + var_0);

  if(istrue(level._id_8A88)) {
    return;
  }
  for(;;) {
    level waittill("player_spawned", var_1);

    if(isai(var_1)) {
      continue;
    }
    if(level.teambased && self.team != var_1.team) {
      continue;
    }
    if(!level.teambased && self.owner != var_1) {
      continue;
    }
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "showMiniMap")) {
      var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "showMiniMap")]]();
    }

    var_1._id_DCF8 = 1;
  }
}

_id_D56A(var_0, var_1) {
  if(isDefined(var_1)) {
    wait(var_1);
  }

  var_2 = getdvarint("#x3a93070affbb9fe0d");
  var_3 = "normal_radar";
  var_4 = 1;
  var_5 = 0;

  switch (var_2) {
    case 3:
      var_3 = "normal_radar";
      break;
    case 5:
      var_3 = "fast_radar";
      var_4 = 2;
      break;
    case 6:
      var_3 = "constant_radar";
      var_5 = 1;
      break;
    default:
      break;
  }

  if(level.teambased) {
    foreach(var_7 in level._id_EF89) {
      level.radarmode[var_7] = var_3;
      level._id_0F66[var_7] = var_4;
      level._id_0F37[var_7] = var_5;
      level._id_0F36 = level._id_EF89.size;
      _id_0CF1(var_7, var_2);
    }
  } else {
    var_4 = var_2;
    level.radarmode[var_0.guid] = var_3;
    var_0._id_0358 = var_4;
    level._id_0F66[var_0.guid + "_radarStrength"] = var_4;
    level._id_0F37[var_0.guid] = var_5;
    level._id_0F36 = level._id_EF89.size;
    _id_FD05();
  }
}

_id_F8EA(var_0, var_1, var_2) {
  if(!isDefined(var_2) || var_2 != "uav") {
    return;
  }
  var_3 = _id_F8ED(var_0, var_1);

  foreach(var_5 in var_3) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "dangerNotifyPlayer")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "dangerNotifyPlayer")]](var_5, var_2, 1);
    }
  }
}

_id_F8ED(var_0, var_1) {
  var_2 = [];
  var_3 = level._id_EF6A[var_0]["players"];

  foreach(var_5 in var_3) {
    if(!isDefined(var_5) || !var_5 scripts\cp_mp\utility\player_utility::_isalive() || var_5 scripts\cp_mp\utility\player_utility::_isalive() && istrue(var_5._id_7262)) {
      continue;
    }
    var_6 = scripts\common\utility::_id_B7B6(var_5.origin, var_1, var_3);

    foreach(var_8 in var_6) {
      if(var_2.size > 0) {
        var_9 = _id_F8EE(var_8, var_2);

        if(istrue(var_9)) {
          continue;
        }
      }

      var_2[var_2.size] = var_8;
    }
  }

  return var_2;
}

_id_F8EE(var_0, var_1) {
  var_2 = 0;

  foreach(var_4 in var_1) {
    if(isDefined(var_4) && var_0 == var_4) {
      var_2 = 1;
      break;
    }
  }

  return var_2;
}

uav_isfriendlyteam(var_0, var_1) {
  if(level.gametype == "dm") {
    return scripts\engine\utility::is_equal(var_0, var_1.owner);
  }

  return scripts\engine\utility::is_equal(var_0.team, var_1.team);
}