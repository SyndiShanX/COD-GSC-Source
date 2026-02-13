/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2500.gsc
*************************************************/

_id_4056(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.streakname = var_0;
  var_2.owner = var_1;
  var_2._id_7C8C = _id_6E22(var_1);
  var_2._id_936C = _id_69A7();
  var_2._id_038F = 0;
  var_2._id_DA63 = 0;
  var_2._id_79B5 = 0;
  var_2.damage = 0;
  var_2._id_0267 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "createCustomStreakData")) {
    var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "createCustomStreakData")]](var_2, var_0);
  }

  return var_2;
}

_id_6E22(var_0) {
  if(!isDefined(var_0.pers["nextKillstreakID"])) {
    var_0.pers["nextKillstreakID"] = 0;
  }

  var_1 = var_0.pers["nextKillstreakID"];
  var_0.pers["nextKillstreakID"]++;
  return var_1;
}

_id_69A7() {
  if(!isDefined(self.pers["deaths"])) {
    return 0;
  }

  return self.pers["deaths"];
}

_id_6AE6(var_0) {
  var_1 = undefined;

  for(var_2 = 1; var_2 <= 3; var_2++) {
    var_3 = self._id_E9FF._id_EA14[var_2];

    if(isDefined(var_3) && var_3.streakname == var_0) {
      var_1 = var_3;
      break;
    }
  }

  if(isDefined(var_1)) {
    return var_1._id_936C;
  }

  return undefined;
}

_id_C2C8(var_0, var_1, var_2) {
  if(!isDefined(level._id_8DC4)) {
    level._id_8DC4 = [];
  }

  if(isDefined(level._id_8DC4[var_0]) && isDefined(level._id_8DC4[var_0][var_1])) {
    return;
  }
  var_3 = 0;

  foreach(var_5 in level._id_8DC4) {
    foreach(var_7 in var_5) {
      if(var_2 == var_7) {
        var_3 = 1;
        break;
      }
    }

    if(istrue(var_3)) {
      return;
    }
  }

  level._id_8DC4[var_0][var_1] = var_2;
}

_id_0CF8(var_0, var_1) {
  var_2 = undefined;

  if(var_1 == "off") {
    var_2 = 0;
  } else {
    var_2 = level._id_8DC4[var_0][var_1];
  }

  self setclientomnvar("ui_killstreak_controls", var_2);
}

_id_8DC7(var_0) {
  switch (var_0) {
    case "dronedrop":
    case "pac_sentry":
    case "weapondrop":
    case "radar_drone_overwatch":
    case "scrambler_drone_guard":
    case "directional_uav":
    case "uav":
    case "counter_uav":
      return 1;
    default:
      return 0;
  }
}

_id_8A08(var_0) {
  switch (var_0) {
    case "pac_sentry":
    case "cruise_predator":
    case "ball_turret_gunner":
    case "radar_drone_recon":
    case "chopper_gunner":
      return 1;
    default:
      return 0;
  }
}

_id_891E(var_0) {
  switch (var_0) {
    case "multi_airstrike":
    case "scrambler_drone_guard":
    case "nuke":
    case "white_phosphorus":
      return 1;
    default:
      return 0;
  }
}

_id_89FA(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "ks_remote_device_mp":
    case "ks_remote_gunship_mp":
      var_1 = 1;
      break;
  }

  return var_1;
}

_id_E72A(var_0, var_1) {
  var_2 = int(_func_0222("mp/killstreakTable.csv", 1, var_0, 0));
  self setclientomnvar("ui_remote_control_sequence", var_2);
  thread _id_EC84(var_1);
}

_id_E941(var_0, var_1) {
  self setclientomnvar("ui_remote_control_sequence", -1);
  thread _id_EC84(var_0, 1, var_1);
}

_id_EC84(var_0, var_1, var_2) {
  self endon("disconnect");
  self notify("dof_set_tablet");
  self endon("dof_set_tablet");

  if(istrue(var_1) && !istrue(var_2)) {
    self _meth_865D();
    self _meth_8660(1.8, 15, 20, 20);
    self _meth_8662(30, 5);
  }

  if(isDefined(var_0) && var_0 > 0) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  }

  if(istrue(var_1)) {
    self _meth_865E();
  } else {
    self _meth_865D();
    self _meth_8660(1.8, 15, 20, 20);
    self _meth_8662(30, 5);
  }
}

_id_8DBE() {
  if(!isDefined(self.pers["useNVG"])) {
    return;
  }
  if(self _meth_8632()) {
    self.pers["useNVG"] = 1;
    self.pers["killstreak_forcedNVGOff"] = 1;
    self _meth_8246(1);
  } else {
    self.pers["useNVG"] = 0;
    self.pers["killstreak_forcedNVGOff"] = 0;
  }
}

_id_8DBA() {
  if(!isDefined(self.pers["useNVG"])) {
    return;
  }
  if(istrue(self.pers["useNVG"])) {
    self _meth_8249(1);
    self.pers["killstreak_forcedNVGOff"] = 0;
  }
}

_id_B86F(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isPlayer(self)) {
    var_3 = self;
  } else if(isDefined(self.owner)) {
    var_3 = self.owner;
  }

  if(isDefined(var_2) && var_2 > 0) {
    var_3 endon("disconnect");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  }

  if(isDefined(var_3)) {
    if(!isDefined(var_3._id_41CC) || istrue(var_1)) {
      var_3 _id_09C1::_id_AC3E(var_0);
      var_3._id_41CC = var_0;
      var_3 thread _id_3986(5);
    }
  }
}

_id_3986(var_0) {
  self endon("disconnect");
  self notify("clear_stored_dialog");
  self endon("clear_stored_dialog");
  wait(var_0);

  if(isDefined(self._id_41CC)) {
    self._id_41CC = undefined;
  }
}

_id_8DAE(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "lpcFeatureGated") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "lpcFeatureGated")]]()) {
    return;
  }
  _id_8DB2();
  var_6 = undefined;

  if(isDefined(var_4) && isDefined(var_5)) {
    var_6 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var_0, var_1, var_2, var_5, var_3, var_4, 1);
  } else if(isDefined(var_5)) {
    var_6 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var_0, var_1, var_2, var_5, var_3, undefined, 1);
  } else {
    var_6 = _id_8DC2(var_0, var_1, var_2, var_3);
  }

  self._id_4349 = var_6;
  return var_6;
}

_id_8DC2(var_0, var_1, var_2, var_3) {
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    return;
  }
  var_4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var_0, var_1, var_2, undefined, var_3, level.players[randomint(level.players.size)], 1);
  self._id_4349 = var_4;
  return var_4;
}

_id_8DB2(var_0) {
  if(!isDefined(var_0) && !isDefined(self._id_4349)) {
    return;
  }
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "isSpawnDangerZoneAlive") || !scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "removeSpawnDangerZone")) {
    return;
  }
  if(!isDefined(var_0)) {
    var_0 = self._id_4349;
  }

  if(isDefined(var_0) && [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "isSpawnDangerZoneAlive")]](var_0)) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "removeSpawnDangerZone")]](var_0);
  }

  self._id_4349 = undefined;
}

_id_E9FD(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = scripts\engine\trace::_id_3EE5(0, 1, 0, 1, 1, 0);

  if(scripts\engine\trace::ray_trace_passed(var_0, var_1, var_2, var_4)) {
    var_3 = 1;
  }

  return var_3;
}

_id_EF77(var_0) {
  foreach(var_2 in level._id_EF89) {
    if(var_2 == var_0) {
      continue;
    }
    if(isDefined(level._id_F8F8) && isDefined(level._id_F8F8[var_2]) && level._id_F8F8[var_2].size > 0) {
      foreach(var_4 in level._id_F8F8[var_2]) {
        if(!isDefined(var_4)) {
          continue;
        }
        if(var_4._id_F904 == "counter_uav") {
          return 0;
        }
      }
    }
  }

  if(isDefined(level._id_F8F8) && isDefined(level._id_F8F8[var_0]) && level._id_F8F8[var_0].size > 0) {
    foreach(var_4 in level._id_F8F8[var_0]) {
      if(!isDefined(var_4)) {
        continue;
      }
      if(var_4._id_F904 == "uav" || var_4._id_F904 == "directional_uav") {
        return 1;
      }
    }
  }

  return 0;
}

_id_EF78(var_0) {
  if(isDefined(level._id_F8F8) && isDefined(level._id_F8F8[var_0]) && level._id_F8F8[var_0].size > 0) {
    foreach(var_2 in level._id_F8F8[var_0]) {
      if(!isDefined(var_2)) {
        continue;
      }
      if(var_2._id_F904 == "uav" || var_2._id_F904 == "directional_uav") {
        return 1;
      }
    }
  }

  return 0;
}

_id_5413(var_0) {
  if(isDefined(level._id_EB9A) && level._id_EB9A.size > 0) {
    foreach(var_2 in level._id_EB9A) {
      if(level.teambased && var_2.team == var_0) {
        continue;
      }
      if(var_2._id_786F == "scrambler_drone_guard") {
        return 1;
      }
    }
  }

  return 0;
}

_id_FD71() {
  var_0 = [];

  foreach(var_2 in level._id_EF89) {
    var_0[var_2] = _id_EF77(var_2);
  }

  foreach(var_5 in level.players) {
    if(!isDefined(var_5.team) || var_5.team == "spectator" || var_5.team == "follower" || var_5.team == "free") {
      var_5 setclientomnvar("ui_show_hardcore_minimap", 0);
      continue;
    }

    var_5 setclientomnvar("ui_show_hardcore_minimap", var_0[var_5.team]);
  }
}

_id_8ABC(var_0) {
  if(!isDefined(level._id_F8F8)) {
    return 0;
  }

  if(!isDefined(level._id_F8F8[var_0])) {
    return 0;
  }

  return level._id_F8F8[var_0].size > 0;
}

_id_6ADF(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "airdrop_multiple":
    case "airdrop":
      var_1 = "s4_deploy_airdrop_mp";
      break;
    case "juggernaut":
      var_1 = "s4_ks_deploy_flamenaut_mp";
      break;
    case "bradley":
    case "radar_drone_overwatch":
    case "ball_turret_gunner":
    case "directional_uav":
    case "white_phosphorus":
    case "uav":
    case "chopper_support":
      var_1 = "s4_ks_gesture_generic_mp";
      break;
    case "toma_strike":
      var_1 = "s4_ks_targeting_radio_mp";
      break;
    case "precision_airstrike":
      var_1 = "s4_binoculars_mp";
      break;
    case "cruise_predator":
    case "chopper_gunner":
      var_1 = "ks_remote_device_mp";
      break;
    case "pac_sentry":
      var_1 = "s4_ks_remote_goliath_mp";
      break;
    case "hover_jet":
    case "scrambler_drone_guard":
      var_1 = "ks_remote_map_mp";
      break;
    case "manual_turret":
      var_1 = "deploy_manual_turret_mp";
      break;
    case "sentry_gun":
      var_1 = "deploy_sentry_mp";
      break;
    case "nuke":
      var_1 = "ks_remote_nuke_mp";
      break;
  }

  return var_1;
}

_id_6AE2(var_0) {
  var_1 = [];

  switch (var_0) {
    case "juggernaut":
      var_1 = ["s4_gw_flima35_mp"];
      break;
    case "manual_turret":
      var_1 = ["manual_turret_mp"];
      break;
    case "sentry_gun":
      var_1 = ["sentry_turret_mp"];
      break;
  }

  return var_1;
}

_id_6BAC(var_0, var_1) {
  var_2 = 0;

  foreach(var_4 in var_1) {
    if(var_4.team == var_0) {
      var_2++;
    }
  }

  return var_2;
}

_id_6ADB() {
  if(isDefined(scripts\cp_mp\utility\game_utility::_id_6B18())) {
    return scripts\cp_mp\utility\game_utility::_id_6B17("airstrikeheight");
  }

  var_0 = getEntArray("airstrikeheight", "targetname");

  if(var_0.size > 1) {}

  return var_0[0];
}

_id_C70C(var_0) {
  var_0 endon("death_or_disconnect");
  level endon("game_ended");

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  var_1 = 0.5;

  if(!isDefined(var_0._id_C707)) {
    return;
  }
  while(var_1 > 0) {
    var_0 setplayerangles((var_0._id_C707[0], var_0._id_C707[1], 0));
    var_1 = var_1 - 0.05;
    wait 0.05;
  }

  var_0._id_C707 = undefined;
}

_id_C14A(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onKillStreakEnd")) {
    var_1 = var_0._id_A2B6;

    if(isDefined(var_1)) {
      var_2 = var_1.streakname;
      var_3 = gettime();
      var_4 = var_3 - var_1._id_0EF1;
      var_5 = var_0._id_0267;
      var_6 = 0;
      var_7 = 0;
      var_8 = 0;
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onKillStreakEnd")]](var_2, var_4, var_3, var_5, var_6, var_7, var_8);
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("dlog", "killStreakExpired")) {
    var_1 = var_0._id_A2B6;

    if(isDefined(var_1)) {
      var_9 = var_1._id_EA10;
      var_10 = var_1.streakname;
      var_11 = var_1._id_887C;
      var_3 = gettime();
      var_12 = self.origin;
      var_13 = istrue(var_0._id_57A7);
      var_14 = var_0._id_DA63;
      var_15 = var_0._id_79B5;
      var_16 = var_0._id_0267;
      var_17 = var_0._id_038F;
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("dlog", "killStreakExpired")]](self, var_9, var_10, var_11, var_3, var_12, var_13, var_14, var_15, var_16, var_17);
    }
  }
}

_id_B702() {
  var_0 = undefined;

  if(isDefined(self.vehicle)) {
    var_0 = [self.vehicle];
  } else {
    var_1 = self _meth_84A5();

    if(isDefined(var_1) && isDefined(var_1.classname) && var_1.classname == "script_vehicle") {
      var_0 = [var_1];
    }
  }

  return var_0;
}

_id_0C44(var_0) {
  return isDefined(self.perks) && isDefined(self.perks[var_0]);
}

_id_C0B7(var_0) {
  if(isDefined(var_0)) {
    foreach(var_3, var_2 in self._id_E9FF._id_EA14) {
      if(var_2.streakname == var_0 && istrue(self._id_E9FF._id_EA14[var_3]._id_C0B4)) {
        return 1;
      }
    }
  }

  return 0;
}

_id_C0BE() {
  if(!isDefined(level._id_3E85._id_8E4F)) {
    level._id_3E85._id_8E4F = level._id_3E85._id_8E54;
  }

  scripts\cp_mp\killstreaks\airdrop::_id_AD54("radar_drone_overwatch", 100);
  scripts\cp_mp\killstreaks\airdrop::_id_AD54("scrambler_drone_guard", 100);
  scripts\cp_mp\killstreaks\airdrop::_id_AD54("uav", 100);
  scripts\cp_mp\killstreaks\airdrop::_id_AD54("body_armor", 100);
  scripts\cp_mp\killstreaks\airdrop::_id_AD54("precision_airstrike", 100);
  scripts\cp_mp\killstreaks\airdrop::_id_AD54("cruise_predator", 100);
  scripts\cp_mp\killstreaks\airdrop::_id_AD54("pac_sentry", 65);
  scripts\cp_mp\killstreaks\airdrop::_id_AD54("white_phosphorus", 65);
  scripts\cp_mp\killstreaks\airdrop::_id_AD54("multi_airstrike", 65);
  scripts\cp_mp\killstreaks\airdrop::_id_AD54("chopper_gunner", 35);
  scripts\cp_mp\killstreaks\airdrop::_id_AD54("directional_uav", 35);
}

_id_C0BD() {
  if(isDefined(level._id_3E85._id_8E4F)) {
    level._id_3E85._id_8E54 = level._id_3E85._id_8E4F;
  }
}

shoulddisablekillstreakweaponswitch() {
  if(scripts\engine\utility::is_equal(level.gametype, "arena_evo")) {
    return 1;
  }

  return 0;
}

donttakekillstreakonladderuse(var_0) {
  if(!scripts\engine\utility::is_equal(var_0, "non_temp_weapon_switch")) {
    return 0;
  }

  if(!self isonladder()) {
    return 0;
  }

  return 1;
}