/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\179.gsc
**************************************/

_id_17E6() {
  wait 0.05;
  maps\_rank::_id_12CC();
}

_id_17E3(var_0, var_1) {
  var_2 = int(tablelookup("sp/specOpsTable.csv", 1, var_0, 5));
  var_3 = tablelookup("sp/specOpsTable.csv", 1, var_0, 6);
  var_4 = 1;
  _id_18B0(var_0, var_2, var_3, "", "", var_1, var_4);
}

_id_17E4() {
  _id_17E3("so_survival_2", "survival");
  _id_17E3("so_survival_3", "survival");
  _id_17E3("so_survival_4", "survival");
  _id_18AF(100, 120, "weaponupgrade");
  _id_18AF(0, 64, "weapon");
  _id_18AF(1000, 1020, "equipment");
  _id_18AF(10000, 10020, "airsupport");
}

_id_18AF(var_0, var_1, var_2) {
  for(var_3 = var_0; var_3 <= var_1; var_3++) {
    var_4 = tablelookup("sp/survival_armories.csv", 0, var_3, 1);

    if(!isDefined(var_4) || var_4 == "") {
      continue;
    }
    var_5 = var_3;
    var_6 = var_4;
    var_7 = var_2;
    var_8 = tablelookup("sp/survival_armories.csv", 1, var_4, 4);
    var_9 = tablelookup("sp/survival_armories.csv", 1, var_4, 5);
    var_10 = int(tablelookup("sp/survival_armories.csv", 1, var_4, 7));

    if(var_10 > 0) {
      var_11 = "weapon_missing_image";

      if(var_7 == "airsupport") {
        var_11 = "specops_ui_airsupport";
      }
      if(var_7 == "equipment") {
        var_11 = "specops_ui_equipmentstore";
      }
      if(var_7 == "weapon" || var_7 == "weaponupgrade") {
        var_11 = "specops_ui_weaponstore";
      }
      var_12 = 0;
      _id_18B0(var_6, var_10, var_8, var_9, var_11, "survival", var_12);
    }
  }
}

_id_18B0(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7._id_160B = var_0;
  var_7.name = var_2;
  var_7._id_189B = var_3;
  var_7.icon = var_4;
  var_7._id_18B1 = var_1;
  var_7.mode = var_5;
  var_7._id_01DD = var_6;

  if(!isDefined(level._id_1897)) {
    level._id_1897 = [];
  }
  if(!isDefined(level._id_1897[var_1])) {
    level._id_1897[var_1] = [];
  }
  level._id_1897[var_1][level._id_1897[var_1].size] = var_7;
}

_id_17E2(var_0) {
  if(isDefined(var_0) && var_0) {
    if(isDefined(level._id_18B2) && level._id_18B2) {
      return undefined;
    }
  }

  if(isDefined(level._id_0A35) && level._id_0A35) {
    return _id_18B5(var_0);
  }
  var_1 = getEntArray("info_player_start_so", "classname");

  if(var_1.size <= 0) {
    var_1 = getEntArray("info_player_start", "classname");
  }
  var_2 = common_scripts\utility::random(var_1);

  if(isDefined(var_0) && var_0) {
    return var_2.origin;
  }
  _id_18B7(level.player, var_2);

  if(maps\_utility::_id_12C1()) {
    var_3 = getEntArray("info_player_start_soPlayer2", "classname");

    if(var_3.size > 0) {
      var_4 = maps\_utility::_id_0AE9(var_2.origin, var_3);
      _id_18B7(level._id_1337, var_4);
    } else {
      _id_18B8();
    }
  }
}

_id_18B3() {
  return level._id_18B4 == "mode_defend";
}

_id_18B5(var_0) {
  if(_id_18B3()) {
    var_1 = getEntArray("info_player_start_pmcDefend", "classname");
  } else {
    var_1 = getEntArray("info_player_start_pmc", "classname");
  }
  var_2 = [];
  var_3 = undefined;

  foreach(var_5 in level.players) {
    if(!var_2.size) {
      var_3 = common_scripts\utility::random(var_1);
    } else {
      var_3 = maps\_utility::_id_18B6(var_3.origin, var_1, var_2);
    }
    if(isDefined(var_0) && var_0) {
      return var_3.origin;
    }
    var_5 setorigin(var_3.origin);
    var_5 setplayerangles(var_3.angles);
    var_2[var_2.size] = var_3;
  }
}

_id_18B7(var_0, var_1) {
  var_0 setorigin(var_1.origin);

  if(isDefined(var_1.angles)) {
    var_0 setplayerangles(var_1.angles);
  }
}

_id_18B8() {
  level._id_1337 setplayerangles(level.player.angles + (0, -25, 0));
  level._id_1337 setorigin(level.player.origin);
  var_0 = spawnStruct();
  var_0.entity = level._id_1337;
  var_0.right = -20.0;
  var_0.forward = -50.0;
  var_0 maps\_utility::_id_18B9();
  level._id_1337 setorigin(level._id_1337.origin);
}

_id_17EC(var_0) {
  if(_id_18BA(var_0)) {
    return 1;
  }
  if(_id_18BB(var_0)) {
    return 1;
  }
  return 0;
}

_id_18BA(var_0) {
  if(!isDefined(self._id_1693)) {
    return 0;
  }
  if(self._id_1693 == var_0) {
    return 0;
  }
  return 1;
}

_id_18BB(var_0) {
  if(!isDefined(self._id_18BC)) {
    return 0;
  }
  if(var_0 == 0) {
    return 1;
  }
  var_1 = strtok(self._id_18BC, ":;, ");
  var_2 = 1;

  foreach(var_4 in var_1) {
    if(var_4 == level.script) {
      var_2 = 0;
      break;
    }
  }

  return var_2;
}

_id_1845(var_0) {
  var_0.alpha = 0;

  while(!_id_1844()) {
    wait 0.5;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(_id_18BD(var_0)) {
    switch (self._id_1862) {
      case "on":
      case "none":
        var_0 maps\_hud_util::fade_over_time(1, 0.5);
        break;
      case "off":
        var_0 maps\_hud_util::fade_over_time(0, 0.5);
        break;
      default:
    }
  } else {
    var_0 maps\_hud_util::fade_over_time(1, 0.5);
  }
  if(!maps\_utility::_id_1008("so_hud_can_toggle")) {
    maps\_utility::_id_13DC("so_hud_can_toggle");
  }
}

_id_1844() {
  if(isDefined(level._id_1816) && level._id_1816) {
    return 0;
  }
  if(isDefined(level._id_1865) && level._id_1865) {
    return 1;
  }
  if(!isDefined(self._id_17D4)) {
    return 1;
  }
  return gettime() > self._id_17D4;
}

_id_18BD(var_0) {
  if(!isDefined(var_0._id_1867) || !var_0._id_1867) {
    return 0;
  }
  if(!isDefined(self._id_1862)) {
    return 0;
  }
  return 1;
}

_id_1807(var_0, var_1, var_2, var_3) {
  level endon("challenge_timer_expired");
  level endon("new_challenge_timer");
  level endon("special_op_terminated");
  var_4 = undefined;

  if(isDefined(var_3) && var_3) {
    var_4 = 1;
  }
  var_5 = maps\_specialops::_id_185B();
  self._id_18BE = maps\_specialops::_id_16B6(1, var_5, var_2, self, var_4);

  if(isDefined(level._id_16C3)) {
    self._id_186B = maps\_specialops::_id_16B6(1, var_5, undefined, self, var_4);
    self._id_186B settenthstimerstatic(level._id_16C3);
  } else {
    self._id_186B = maps\_specialops::_id_16B6(1, var_5, &"SPECIAL_OPS_TIME_NULL", self, var_4);
  }
  self._id_186B.alignx = "left";

  if(!isDefined(var_3) || var_3 == 0) {
    thread maps\_specialops::_id_1861();
    thread maps\_specialops::_id_1866(self._id_18BE);
    thread maps\_specialops::_id_1866(self._id_186B);
  } else {
    self._id_1862 = "none";
    self._id_18BE.alpha = 0;
    self._id_186B.alpha = 0;
  }

  _id_18C2(self._id_18BE, self._id_186B, var_0);

  if(isDefined(level._id_16C3)) {
    level._id_186A = level._id_16C3;
    thread _id_18C4(self._id_18BE, self._id_186B);
    thread _id_18C5(self._id_18BE, self._id_186B);
    thread _id_18CA(self._id_18BE, self._id_186B);
    thread _id_18CD(self._id_18BE, self._id_186B);
  }

  thread _id_18CC(self._id_18BE, self._id_186B, var_1);
}

_id_18BF() {
  if(!common_scripts\utility::flag_exist("so_challenge_is_3quarter")) {
    common_scripts\utility::flag_init("so_challenge_is_3quarter");
  }
  common_scripts\utility::flag_wait("so_challenge_is_3quarter");
  maps\_specialops::_id_187F(3, 4);
}

_id_18C0() {
  if(!common_scripts\utility::flag_exist("so_challenge_is_halfway")) {
    common_scripts\utility::flag_init("so_challenge_is_halfway");
  }
  common_scripts\utility::flag_wait("so_challenge_is_halfway");
  maps\_specialops::_id_187F(2, 4);
}

_id_18C1() {
  if(!common_scripts\utility::flag_exist("so_challenge_is_quarter")) {
    common_scripts\utility::flag_init("so_challenge_is_quarter");
  }
  common_scripts\utility::flag_wait("so_challenge_is_quarter");
  maps\_specialops::_id_187F(1, 4);
}

_id_18C2(var_0, var_1, var_2) {
  level endon("special_op_terminated");

  if(isDefined(var_2)) {
    common_scripts\utility::flag_wait(var_2);
  }
  foreach(var_4 in level.players) {
    if(!var_4 _id_1844()) {
      var_4._id_17D4 = gettime();
    }
  }

  if(!isDefined(level._id_16CF)) {
    if(_id_18C3()) {
      level.player playSound("arcademode_zerodeaths");
    }
    level._id_16CF = gettime();
  } else {
    level._id_01DE = gettime();
  }
  var_1.label = "";

  if(isDefined(level._id_16C3)) {
    var_1 settenthstimer(level._id_16C3);
  } else {
    var_1 settenthstimerup(0.0);
  }
}

_id_18C3() {
  if(isDefined(level._id_16C3)) {
    return 1;
  }
  foreach(var_1 in level.players) {
    if(var_1._id_1862 != "off") {
      return 1;
    }
  }

  return 0;
}

_id_18C4(var_0, var_1) {
  if(!_id_18CF(level._id_17D5)) {
    return;
  }
  level endon("challenge_timer_passed");
  level endon("new_challenge_timer");
  level endon("special_op_terminated");

  while(level._id_186A > level._id_17D5) {
    wait 0.1;
  }
  var_0 _id_192A();
  var_1 _id_192A();

  if(!_id_18C6()) {
    thread maps\_specialops::_id_187A();
  }
}

_id_18C5(var_0, var_1) {
  if(!_id_18CF(level._id_17D6)) {
    return;
  }
  level endon("challenge_timer_passed");
  level endon("new_challenge_timer");
  level endon("special_op_terminated");

  while(level._id_186A > level._id_17D6) {
    wait 0.1;
  }
  var_0 _id_192B();
  var_1 _id_192B();

  if(!_id_18C6()) {
    thread maps\_specialops::_id_187B();
  }
}

_id_18C6() {
  if(self != level.player) {
    return 1;
  }
  if(!isDefined(level._id_18C7)) {
    return 0;
  }
  return level._id_18C7;
}

_id_186C() {
  level endon("special_op_terminated");
  level notify("stop_challenge_timer_thread");
  level endon("stop_challenge_timer_thread");

  while(level._id_186A > 0) {
    wait 0.05;
    level._id_186A = level._id_186A - 0.05;
    thread _id_18C8();
  }

  level notify("challenge_timer_failed");
}

_id_18C8() {
  if(_id_18C9()) {
    foreach(var_1 in level.players) {
      var_1._id_18BE thread maps\_specialops::_id_1848();
      var_1._id_186B thread maps\_specialops::_id_1848();
    }

    if(level._id_1806 < 0) {
      level.player playSound("arcademode_kill_streak_lost");
    } else {
      level.player playSound("so_countdown_beep");
    }
  }
}

_id_18C9() {
  if(level._id_186A > level._id_1806) {
    return 0;
  }
  for(var_0 = 0; var_0 <= level._id_1805; var_0++) {
    if(level._id_186A > var_0) {
      if(level._id_1806 < var_0) {
        level._id_1806 = var_0 + 1;
      }
      continue;
    }

    level._id_1806 = var_0 - 1;
    return 1;
  }

  return 0;
}

_id_18CA(var_0, var_1) {
  if(!_id_18CF(level._id_16C3)) {
    return;
  }
  level endon("challenge_timer_passed");
  level endon("new_challenge_timer");
  level endon("special_op_terminated");
  thread _id_186C();
  level waittill("challenge_timer_failed");
  common_scripts\utility::flag_set("challenge_timer_expired");
  _id_18CE(var_0, var_1);

  if(self == level.player) {
    thread maps\_specialops::_id_1878();
  }
  var_2 = "@SPECIAL_OPS_FAILURE_HINT_TIME";

  if(isDefined(level._id_18CB)) {
    var_2 = level._id_18CB;
  }
  maps\_specialops::_id_183F(var_2, "ui_time_failure");

  if(self == level.player) {
    maps\_utility::_id_1826();
  }
}

_id_18CC(var_0, var_1, var_2) {
  level endon("challenge_timer_expired");
  level endon("new_challenge_timer");

  if(common_scripts\utility::flag_exist("individual_timers") && common_scripts\utility::flag("individual_timers")) {
    maps\_utility::_id_1654(var_2);
  } else {
    common_scripts\utility::flag_wait(var_2);
  }
  common_scripts\utility::flag_set("challenge_timer_passed");
  level._id_16CE = gettime();
  var_3 = common_scripts\utility::ter_op(isDefined(level._id_01DE), level._id_01DE, level._id_16CF);
  var_4 = maps\_utility::_id_17FC(level._id_16CE - var_3, 1, 0);
  var_5 = var_4 / 1000;

  if(isDefined(level._id_16C3)) {
    var_5 = level._id_16C3 - var_5;
  }
  if(var_5 <= 0) {
    var_5 = 0.1;
  }
  var_1 settenthstimerstatic(var_5);

  if(!common_scripts\utility::flag_exist("individual_timers")) {
    return;
  }
  if(common_scripts\utility::flag("individual_timers")) {
    return;
  }
  _id_18CE(var_0, var_1);
}

_id_18CD(var_0, var_1) {
  level waittill("new_challenge_timer");
  _id_18CE(var_0, var_1, 1);
}

_id_18CE(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    var_0 thread maps\_specialops::_id_185C(var_2);
  }
  if(isDefined(var_1)) {
    var_1 thread maps\_specialops::_id_185C(var_2);
  }
}

_id_18CF(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }
  if(var_0 <= 0) {
    return 0;
  }
  return 1;
}

_id_18D0() {
  if(getdvarint("so_nofail")) {
    return;
  }
  thread maps\_specialops::_id_1877();
  missionfailed();
  maps\_endmission::_id_17F8(0);
  _id_17F9(0);
  level notify("so_generate_deathquote");
  maps\_endmission::_id_17FA();
}

_id_17F9(var_0) {
  setDvar("ui_opensummary", 1);

  if(var_0) {
    setDvar("ui_mission_success", 1);
  } else {
    setDvar("ui_mission_success", 0);
  }
  if(common_scripts\utility::flag("special_op_terminated")) {}

  if(!isDefined(level._id_16CF)) {
    level._id_16CF = gettime();
  }
  if(!isDefined(level._id_16CE)) {
    level._id_16CE = gettime();
  }
  common_scripts\utility::flag_set("special_op_terminated");
  level notify("stop_music");
  thread maps\_utility_code::_id_1453(var_0);
  var_1 = undefined;

  if(isDefined(level._id_18D1) && level._id_18D1) {
    var_1 = _id_18B5(1);
  } else {
    var_1 = _id_17E2(1);
  }
  if(isDefined(var_1)) {
    foreach(var_3 in level.players) {}
    var_3 playersetstreamorigin(var_1);
  }

  ambientstop(2);
  maps\_utility::_id_1427(1);

  if(var_0) {
    thread _id_1903();
  } else {
    thread _id_1905();
  }
  foreach(var_3 in level.players) {
    var_3 allowjump(0);
    var_3 disableweapons();
    var_3 disableusability();
    var_3 enableinvulnerability();
    var_3.ignoreme = 1;
  }

  thread _id_18D5();

  if(var_0) {
    wait 0.5;

    foreach(var_3 in level.players) {}
    var_3 _id_18D2();

    wait 2.5;

    foreach(var_3 in level.players) {}
    var_3 uploadleaderboards();
  } else {
    wait 3;
  }
  thread _id_1900();

  if(!common_scripts\utility::flag("special_op_no_unlink")) {
    foreach(var_3 in level.players) {}
    var_3 unlink();
  }

  foreach(var_3 in level.players) {}
  var_3 freezecontrols(1);

  _id_190D(var_0);
}

_id_18D2() {
  if(maps\_utility::_id_12C1() && level.players.size == 2) {
    self setplayerdata("round", "xuidTeammate", maps\_utility::_id_133A(self) getxuid());
  }
  self setplayerdata("round", "timePlayed", self._id_16C6["time"]);
  self setplayerdata("round", "kills", self._id_16C6["kills"]);
  var_0 = 0;

  if(maps\_utility::_id_12DC()) {
    self setplayerdata("round", "score", self._id_16C6["score"]);
    self setplayerdata("round", "wave", self._id_16C6["wave"]);
    var_1 = 0;
    var_2 = 0;

    if(self.stats["weapon"].size > 0) {
      foreach(var_4 in self.stats["weapon"]) {
        var_1 = var_1 + var_4._id_0A40;
        var_2 = var_2 + var_4._id_0A3D;
      }
    }

    self setplayerdata("round", "bulletsFired", var_1);
    self setplayerdata("round", "bulletsHit", var_2);
    self setplayerdata("round", "headshots", self._id_18D3["headshot"]);
    self setplayerdata("round", "revives", self._id_18D3["revives"]);
    self setplayerdata("round", "credits", self._id_18D3["credits"]);
    self setplayerdata("round", "totalXp", self._id_18D3["credits"]);
  } else {
    var_6 = level._id_16D1;

    if(isDefined(self._id_1969)) {
      var_6 = self._id_1969;
    }
    self setplayerdata("round", "difficulty", var_6);
    self setplayerdata("round", "score", self._id_16C6["score"]);
  }
}

_id_18D5() {
  foreach(var_1 in level.players) {
    wait 0.1;
    var_1 setblurforplayer(6, 1);
  }
}

_id_1900() {
  wait 0.25;
  var_0 = getaiarray();
  var_0 = maps\_utility::_id_1843(var_0, getaispeciesarray("axis", "dog"));

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_1901) && var_2._id_1901 == 1) {
      continue;
    }
    if(isDefined(var_2._id_0D04)) {
      var_2 maps\_utility::_id_1902();
    }
    var_2 delete();
  }
}

_id_1903() {
  common_scripts\utility::flag_set("special_op_succeeded");

  foreach(var_1 in level.players) {
    var_2 = maps\_hud_util::_id_09A7("white", 0, var_1);
    var_2.color = (0.7, 0.7, 1);
    var_2 thread maps\_hud_util::fade_over_time(0.25, 2);
  }

  if(isDefined(level._id_1904)) {
    return;
  }
  var_4 = maps\_specialops::_id_16B6(3, 0, &"SPECIAL_OPS_CHALLENGE_SUCCESS");
  var_4.alignx = "center";
  var_4.horzalign = "center";
  var_4 _id_1928();
  var_4 setpulsefx(60, 2500, 500);
  wait 1.5;
  var_5 = level._id_1338;

  if(var_5 == "hijack" || var_5 == "fso") {
    var_5 = "delta";
  }
  maps\_utility::_id_1428("so_victory_" + var_5, undefined, 0, 1);
}

_id_1905() {
  common_scripts\utility::flag_set("special_op_failed");
  var_0 = maps\_specialops::_id_16B6(3, 0, &"SPECIAL_OPS_CHALLENGE_FAILURE");
  var_0.hidewhendead = 0;
  var_0.alignx = "center";
  var_0.horzalign = "center";
  var_0 _id_192B();
  var_0 setpulsefx(60, 2500, 500);

  foreach(var_2 in level.players) {
    var_3 = maps\_hud_util::_id_09A7("white", 0, var_2);
    var_3.color = (1, 0.4, 0.4);
    var_3 thread maps\_hud_util::fade_over_time(0.25, 2);
  }

  wait 1.5;
  var_5 = level._id_1338;

  if(var_5 == "hijack" || var_5 == "fso") {
    var_5 = "delta";
  }
  maps\_utility::_id_1428("so_defeat_" + var_5, undefined, 0, 1);
}

_id_1906() {
  var_0 = tablelookup("sp/specOpsTable.csv", 1, level.script, 13);
  var_1 = int(tablelookup("sp/specOpsTable.csv", 1, var_0, 5));
  var_2 = maps\_rank::getrank();
  return var_2 < var_1;
}

_id_1907() {
  return 1;
}

_id_1908() {
  return _id_1907() && !_id_1906();
}

_id_1909(var_0) {
  if(maps\_utility::_id_12DC()) {
    return;
  }
  return;
}

_id_190A(var_0, var_1, var_2) {
  var_3 = 0;

  for(var_4 = var_1; var_4 < var_2; var_4++) {
    var_3 = var_3 + int(max(0, int(var_0[var_4]) - 1));
  }
  return var_3;
}

_id_190B(var_0, var_1) {
  var_2 = var_0.size;

  if(var_2 > level._id_1889._id_190C.size) {
    var_2 = level._id_1889._id_190C.size;
  }
  var_3 = 0;

  for(var_4 = 0; var_4 < var_2; var_4++) {
    if(max(0, int(var_0[var_4]) - 1) >= var_1) {
      var_3++;
    }
  }

  return var_3;
}

_id_190D(var_0) {
  if(!isDefined(var_0) || !var_0) {
    return;
  }
  foreach(var_2 in level.players) {
    if(!var_2 _id_1908()) {
      var_2._id_190E = 1;
    }
  }

  if(issplitscreen() && level.ps3) {
    level._id_1337._id_190E = 0;
  }
  var_4 = tablelookup("sp/specOpsTable.csv", 1, level.script, 9);

  if(isDefined(var_4) && var_4 != "") {
    foreach(var_2 in level.players) {
      if(isDefined(var_2._id_190E) && var_2._id_190E) {
        continue;
      }
      var_6 = var_2 getlocalplayerprofiledata(var_4);

      if(!isDefined(var_6)) {
        continue;
      }
      var_7 = var_6 == 0;
      level._id_1910 = 0;

      if(var_7) {
        level._id_1910 = 1;
      }
      var_8 = var_2._id_16C6["score"];

      if(var_7 || var_8 > var_6) {
        var_2 setlocalplayerprofiledata(var_4, var_8);
      }
      if(!var_7 && var_8 > var_6) {
        var_2._id_1911 = 1;
        var_2._id_1912 = var_8;
      }
    }
  }

  var_10 = level._id_1889 maps\_endmission::_id_188A(level.script);

  if(!isDefined(var_10)) {
    missionsuccess(level.script);
    return;
  }

  level._id_1889 maps\_endmission::_id_1913(var_10);

  foreach(var_2 in level.players) {
    if(isDefined(var_2._id_190E) && var_2._id_190E) {
      continue;
    }
    var_12 = var_2 getlocalplayerprofiledata("missionSOHighestDifficulty");

    if(!isDefined(var_12)) {
      continue;
    }
    var_13 = int(tablelookup("sp/specopstable.csv", 0, "survival_count", 1));
    var_14 = int(tablelookup("sp/specopstable.csv", 0, "mission_count", 1));
    var_15 = 0;
    var_16 = 0;

    if(maps\_utility::_id_12DC()) {
      var_15 = _id_190A(var_12, 0, var_13);
      var_17 = 100 * (var_15 / (var_13 * 3));
    } else {
      var_15 = _id_190A(var_12, var_13, var_13 + var_14);
      var_17 = 100 * (var_15 / (var_14 * 3));
    }

    if(int(var_17 * 100) % 100 >= 0.5) {
      var_16 = int(var_17) + 1;
    } else {
      var_16 = int(var_17);
    }
    var_2 thread maps\_specialops::_id_01DF("BRAG_RAGS");
    var_2 thread maps\_specialops::_id_01DF("TACTICIAN");
    var_2 thread maps\_specialops::_id_01DF("OVERACHIEVER");
    var_22 = var_2 getlocalplayerprofiledata("percentCompleteSO");
    var_23 = int(var_22 / 100);
    var_24 = var_2 maps\_rank::getrank();

    if(maps\_utility::_id_12DC()) {
      var_25 = var_24 + var_23 * 100;
    } else {
      var_25 = var_24 + var_15 * 100;
    }
    var_2 setlocalplayerprofiledata("percentCompleteSO", var_25);
  }

  updategamerprofileall();
}

_id_17F1(var_0) {
  for(;;) {
    var_0 waittill("trigger");

    if(!maps\_utility::_id_12C1()) {
      return;
    }
    level.player thread _id_191A();
    level._id_1337 thread _id_191A();

    if(!level.player istouching(var_0)) {
      level._id_1337 thread _id_1915();
      continue;
    }

    if(!level._id_1337 istouching(var_0)) {
      level.player thread _id_1915();
      continue;
    }

    break;
  }
}

_id_17F2(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;

  for(;;) {
    var_0 waittill("trigger");

    if(!maps\_utility::_id_12C1()) {
      return;
    }
    level.player thread _id_191A();
    level._id_1337 thread _id_191A();

    if(level.player istouching(var_0)) {
      var_2 = 1;

      if(!var_3 && !level._id_1337 istouching(var_0)) {
        thread _id_1914(level.player, var_1);
        continue;
      }
    }

    if(level._id_1337 istouching(var_0)) {
      var_3 = 1;

      if(!var_2 && !level.player istouching(var_0)) {
        thread _id_1914(level._id_1337, var_1);
        continue;
      }
    }

    break;
  }
}

_id_17F0(var_0) {
  level waittill("special_op_terminated");
  var_0 common_scripts\utility::trigger_off();
}

_id_1914(var_0, var_1) {
  switch (var_1) {
    case "all":
      var_0 _id_1915();
      break;
    case "any":
      var_0 _id_1915();
      break;
    case "freeze":
      var_0 _id_1917();
      break;
  }
}

_id_1915() {
  self endon("death");
  level endon("challenge_timer_passed");
  level endon("challenge_timer_expired");
  level endon("special_op_terminated");
  level notify("players_touching_hint");
  level endon("players_touching_hint");

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self._id_1916)) {
    self._id_1916 = _id_1919(self);
  } else {
    self._id_1916.alpha = 1;
  }
  wait 0.05;
  self._id_1916 fadeovertime(0.25);
  self._id_1916.alpha = 0;
}

_id_1917() {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self._id_1918) && self._id_1918) {
    return;
  }
  self._id_1918 = 1;
  self enableinvulnerability();
  self freezecontrols(1);
  self.ignoreme = 1;
  self setblurforplayer(6, 1);
  self._id_1916 = _id_1919(self);
}

_id_1919(var_0) {
  self notify("rebuilding_waiting_hud");
  self endon("rebuilding_waiting_hud");
  var_1 = maps\_specialops::_id_16B6(3, 0, &"SPECIAL_OPS_WAITING_OTHER_PLAYER", var_0);
  var_1.alignx = "center";
  var_1.horzalign = "center";
  var_1 _id_1928();
  thread _id_191B(var_1);
  return var_1;
}

_id_191A() {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self._id_1916)) {
    return;
  }
  if(isDefined(self._id_1918) && self._id_1918) {
    return;
  }
  self._id_1916 fadeovertime(0.25);
  self._id_1916.alpha = 0;
}

_id_191B(var_0) {
  self endon("rebuilding_waiting_hud");
  level waittill("special_op_terminated");

  if(isDefined(var_0)) {
    var_0 destroy();
  }
}

_id_17D8() {
  common_scripts\utility::flag_set("disable_autosaves");

  for(;;) {
    common_scripts\utility::flag_wait("can_save");
    common_scripts\utility::flag_clear("can_save");
  }
}

_id_181F() {
  if(common_scripts\utility::flag("player_has_escaped")) {
    return 1;
  }
  if(_id_191C()) {
    return 0;
  }
  return 1;
}

_id_191C() {
  if(!isDefined(level._id_181E)) {
    return 0;
  }
  foreach(var_1 in level._id_181E) {
    if(self istouching(var_1)) {
      return 1;
    }
  }

  return 0;
}

_id_1822() {
  if(isDefined(self._id_1824)) {
    return;
  }
  self endon("death");
  self._id_1824 = maps\_specialops::_id_16B6(3.5, 0, &"SPECIAL_OPS_ESCAPE_WARNING", self);
  self._id_1824.alignx = "center";
  self._id_1824.horzalign = "center";

  while(_id_191D()) {
    self._id_1824.alpha = 1;
    self._id_1824 fadeovertime(1);
    self._id_1824.alpha = 0.5;
    self._id_1824.fontscale = 1.5;
    self._id_1824 changefontscaleovertime(1);
    self._id_1824.fontscale = 1;
    wait 1;
  }

  self._id_1824.alpha = 0.5;
  self._id_1824 fadeovertime(0.25);
  self._id_1824.alpha = 0;
  wait 0.25;
  self._id_1821 = undefined;

  if(isDefined(self._id_1824)) {
    self._id_1824 destroy();
  }
}

_id_191D() {
  if(common_scripts\utility::flag("special_op_terminated")) {
    return 0;
  }
  if(!_id_191C()) {
    return 0;
  }
  return 1;
}

_id_17DF() {
  level endon("special_op_terminated");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    if(isDefined(var_0._id_191E) && var_0._id_191E) {
      continue;
    }
    break;
  }

  maps\_specialops::_id_183F("@DEADQUOTE_SO_LEFT_PLAY_AREA");
  maps\_utility::_id_1826();
}

_id_191F() {
  if(common_scripts\utility::flag_exist("so_escape_warning") && common_scripts\utility::flag("so_escape_warning")) {
    return;
  }
  common_scripts\utility::flag_init("so_escape_warning");

  foreach(var_1 in level.players) {}
  var_1 maps\_utility::_id_1402("so_escape_hint_active");
}

_id_17DE() {
  level endon("special_op_terminated");
  _id_191F();

  for(;;) {
    self waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    if(isDefined(var_0._id_191E) && var_0._id_191E) {
      continue;
    }
    var_0 thread _id_1920(self);
  }
}

_id_1920(var_0) {
  if(maps\_utility::_id_1008("so_escape_hint_active")) {
    return;
  }
  maps\_utility::_id_13DC("so_escape_hint_active");
  thread _id_1921(var_0);
}

_id_1921(var_0) {
  self notify("so_escape_hint_ping");
  self endon("so_escape_hint_ping");
  thread _id_1924(var_0);

  if(!isDefined(self._id_1922)) {
    self._id_1922 = maps\_specialops::_id_16B6(3.5, 0, &"SPECIAL_OPS_ESCAPE_WARNING", self);
    self._id_1922.alignx = "center";
    self._id_1922.horzalign = "center";

    if(isDefined(level._id_1923)) {
      self._id_1922 thread[[level._id_1923]]();
    }
  }

  while(_id_1925()) {
    self._id_1922.alpha = 1;
    self._id_1922 fadeovertime(1);
    self._id_1922.alpha = 0.5;
    self._id_1922.fontscale = 1.5;
    self._id_1922 changefontscaleovertime(1);
    self._id_1922.fontscale = 1;
    wait 1;
  }

  self._id_1922.alpha = 0.5;
  self._id_1922 fadeovertime(0.25);
  self._id_1922.alpha = 0;
  wait 0.25;
  self._id_1922 destroy();
}

_id_1924(var_0) {
  while(self istouching(var_0)) {
    wait 0.05;
  }
  maps\_utility::_id_13DE("so_escape_hint_active");
}

_id_1925() {
  if(!isalive(self)) {
    return 0;
  }
  if(common_scripts\utility::flag("special_op_terminated")) {
    return 0;
  }
  return maps\_utility::_id_1008("so_escape_hint_active");
}

_id_1873(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    wait(var_1);
  }
  if(isDefined(var_2) && var_2) {
    maps\_utility::_id_1926();
  }
  maps\_utility::_id_11F4(var_0);
}

_id_17DA() {
  level._id_11BB["so_tf_1_plyr_prep"] = "so_tf_1_plyr_prep";
  level._id_11BB["so_tf_1_success_generic"] = "so_tf_1_success_generic";
  level._id_11BB["so_tf_1_success_jerk"] = "so_tf_1_success_jerk";
  level._id_11BB["so_tf_1_success_best"] = "so_tf_1_success_best";
  level._id_11BB["so_tf_1_fail_generic"] = "so_tf_1_fail_generic";
  level._id_11BB["so_tf_1_fail_generic_jerk"] = "so_tf_1_fail_generic_jerk";
  level._id_11BB["so_tf_1_fail_time"] = "so_tf_1_fail_time";
  level._id_11BB["so_tf_1_fail_bleedout"] = "so_tf_1_fail_bleedout";
  level._id_11BB["so_tf_1_time_generic"] = "so_tf_1_time_generic";
  level._id_11BB["so_tf_1_time_hurry"] = "so_tf_1_time_hurry";
  level._id_11BB["so_tf_1_civ_kill_warning"] = "so_tf_1_civ_kill_warning";
  level._id_11BB["so_tf_1_progress_5more"] = "so_tf_1_progress_5more";
  level._id_11BB["so_tf_1_progress_4more"] = "so_tf_1_progress_4more";
  level._id_11BB["so_tf_1_progress_3more"] = "so_tf_1_progress_3more";
  level._id_11BB["so_tf_1_progress_2more"] = "so_tf_1_progress_2more";
  level._id_11BB["so_tf_1_progress_1more"] = "so_tf_1_progress_1more";
  level._id_11BB["so_tf_1_time_status_late"] = "so_tf_1_time_status_late";
  level._id_11BB["so_tf_1_time_status_good"] = "so_tf_1_time_status_good";
  level._id_11BB["so_tf_1_progress_3quarter"] = "so_tf_1_progress_3quarter";
  level._id_11BB["so_tf_1_progress_half"] = "so_tf_1_progress_half";
  level._id_11BB["so_tf_1_progress_quarter"] = "so_tf_1_progress_quarter";
}

_id_1927() {
  maps\_specialops::_id_185D();
}

_id_1928() {
  maps\_specialops::_id_185E();
}

_id_1929() {
  maps\_specialops::_id_16AE();
}

_id_192A() {
  maps\_specialops::_id_185F();
}

_id_192B() {
  maps\_specialops::_id_16AC();
}

_id_192C() {
  maps\_specialops::_id_1860();
}

_id_1850(var_0, var_1, var_2) {
  self endon("update_hud_pulse");
  self endon("destroying");
  self endon("death");
  self.fontscale = var_0;
  self changefontscaleovertime(var_2);
  self.fontscale = var_1;
  wait(var_2);
}

_id_184C() {
  self endon("update_hud_pulse");
  self endon("destroying");
  self endon("death");

  if(self._id_192D) {
    _id_1850(self._id_184F, self._id_192E, self._id_184D);
  }
  while(isDefined(self._id_184B) && self._id_184B) {
    _id_1850(self._id_192E, self._id_1930, self._id_192F);
    _id_1850(self._id_1930, self._id_192E, self._id_192F);
  }
}

_id_1849() {
  if(!isDefined(self)) {
    return 0;
  }
  if(!isDefined(self._id_184D)) {
    self._id_184D = 0.5;
  }
  if(!isDefined(self._id_184E)) {
    self._id_184E = 1.0;
  }
  if(!isDefined(self._id_184F)) {
    self._id_184F = 1.6;
  }
  if(!isDefined(self._id_184B)) {
    self._id_184B = 0;
  }
  if(!isDefined(self._id_192F)) {
    self._id_192F = 1.0;
  }
  if(!isDefined(self._id_192E)) {
    self._id_192E = 1.0;
  }
  if(!isDefined(self._id_1930)) {
    self._id_1930 = 1.15;
  }
  if(!isDefined(self._id_192D)) {
    self._id_192D = 1;
  }
  return 1;
}

_id_17D9() {
  level endon("special_op_terminated");
  common_scripts\utility::flag_init("so_player_death_nofail");
  common_scripts\utility::array_thread(level.players, ::_id_1931);
  level waittill("so_player_has_died");

  if(common_scripts\utility::flag("so_player_death_nofail")) {
    return;
  }
  maps\_utility::_id_1826();
}

_id_1931() {
  level endon("special_op_terminated");
  self waittill("death");
  level notify("so_player_has_died");
}

_id_17ED(var_0) {
  setDvar("ui_dog_death", 0);
  setDvar("ui_vehicle_death", 0);
  setDvar("ui_destructible_death", 0);
  setDvar("ui_barrel_death", 0);
  setDvar("ui_grenade_death", 0);
  setDvar("ui_time_failure", 0);
  setDvar("ui_ff_death", 0);
  setDvar("ui_juggernaut_death", 0);
  setDvar("ui_bled_out", 0);
  setDvar("ui_icon_partner", 0);
  setDvar("ui_icon_obj", 0);
  setDvar("ui_icon_obj_offscreen", 0);
  setDvar("ui_icon_stars", 0);
  setDvar("ui_icon_claymore", 0);
  setDvar("ui_icon_stealth_stance", 0);

  if(isDefined(var_0)) {
    setDvar(var_0, 1);
  }
}

_id_17E1() {
  _id_17ED();

  foreach(var_1 in level.players) {
    var_1 thread maps\_load::_id_1932();
    var_1 thread _id_1933();
  }

  level waittill("so_generate_deathquote");
  maps\_quotes::_id_18AA();
}

_id_1933() {
  level endon("so_special_failure_hint_set");
  self waittill("death", var_0, var_1, var_2);

  if(isDefined(self._id_1886)) {
    var_0 = self._id_1886["attacker"];
    var_1 = self._id_1886["cause"];
    var_2 = self._id_1886["weapon_name"];
  }

  if(_id_1934(var_1, var_2)) {
    return;
  }
  if(_id_1935(var_0)) {
    return;
  }
  if(_id_1936(var_0)) {
    return;
  }
  if(_id_1938(var_0)) {
    return;
  }
  if(_id_193A(var_0)) {
    return;
  }
  if(_id_193E(var_1)) {
    return;
  }
  if(_id_193B(var_0, var_1)) {
    return;
  }
  if(_id_193C(var_1)) {
    return;
  }
  if(_id_1940(var_1)) {
    return;
  }
  if(_id_1941(var_0, var_1)) {
    return;
  }
}

_id_1934(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }
  if(!isDefined(var_1) || isDefined(var_1) && var_1 != "claymore") {
    return 0;
  }
  return 1;
}

_id_1935(var_0) {
  if(!maps\_utility::_id_12C1()) {
    return 0;
  }
  if(!isDefined(var_0)) {
    return 0;
  }
  var_1 = maps\_utility::_id_133A(self);

  if(var_1 != var_0) {
    return 0;
  }
  _id_1942("@DEADQUOTE_SO_FRIENDLY_FIRE_KILL", "ui_ff_death");
  return 1;
}

_id_1936(var_0) {
  if(!isDefined(var_0) || var_0.classname != "worldspawn") {
    return 0;
  }
  if(!isDefined(self._id_1937) || !self._id_1937) {
    return 0;
  }
  _id_1942("@SCRIPT_RADIATION_DEATH");
  return 1;
}

_id_1938(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }
  if(!isDefined(var_0.weapon)) {
    return 0;
  }
  if(var_0.weapon != "dog_bite") {
    return 0;
  }
  common_scripts\utility::flag_set("special_op_no_unlink");
  _id_1942(level._id_1939, "ui_dog_death");
  return 1;
}

_id_193A(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }
  if(!isDefined(var_0._id_0A37)) {
    return 0;
  }
  var_1 = [];
  var_1[0] = "@DEADQUOTE_JUGGERNAUT_FLASHBANGS";
  var_1[1] = "@DEADQUOTE_JUGGERNAUT_HEADSHOTS";
  var_1[2] = "@DEADQUOTE_JUGGERNAUT_EXPLOSIVES";
  var_1[3] = "@DEADQUOTE_JUGGERNAUT_CORNERED";
  _id_1943(var_1, "ui_juggernaut_death");
  return 1;
}

_id_193B(var_0, var_1) {
  if(!isDefined(var_1)) {
    return 0;
  }
  if(!isDefined(var_0)) {
    return 0;
  }
  if(var_1 != "MOD_EXPLOSIVE") {
    return 0;
  }
  if(!isDefined(var_0.destructible_type)) {
    return 0;
  }
  if(issubstr(var_0.destructible_type, "vehicle")) {
    _id_1942("@SCRIPT_EXPLODING_VEHICLE_DEATH", "ui_vehicle_death");
  } else {
    _id_1942("@SCRIPT_EXPLODING_DESTRUCTIBLE_DEATH", "ui_destructible_death");
  }
  return 1;
}

_id_193C(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }
  if(var_0 != "MOD_EXPLOSIVE") {
    return 0;
  }
  if(!isDefined(level._id_193D)) {
    return 0;
  }
  if(gettime() != level._id_193D["time"]) {
    return 0;
  }
  var_1 = distance(self.origin, level._id_193D["origin"]);

  if(var_1 > level._id_193D["radius"]) {
    return 0;
  }
  _id_1942("@SCRIPT_EXPLODING_BARREL_DEATH", "ui_barrel_death");
  return 1;
}

_id_193E(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }
  if(var_0 != "MOD_SUICIDE") {
    return 0;
  }
  if(self._id_193F - gettime() > 3500.0) {
    return 0;
  }
  _id_1942("@SCRIPT_GRENADE_SUICIDE_COMBINED");
  return 1;
}

_id_1940(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }
  if(var_0 != "MOD_GRENADE" && var_0 != "MOD_GRENADE_SPLASH") {
    return 0;
  }
  _id_1942("@SCRIPT_GRENADE_DEATH", "ui_grenade_death");
  return 1;
}

_id_1941(var_0, var_1) {
  if(!isDefined(var_1)) {
    return 0;
  }
  if(!isDefined(var_0)) {
    return 0;
  }
  if(var_1 != "MOD_CRUSH") {
    return 0;
  }
  if(var_0.code_classname != "script_vehicle") {
    return 0;
  }
  _id_1942("@DEADQUOTE_SO_RUN_OVER_BY_VEHICLE");
  return 1;
}

_id_1942(var_0, var_1) {
  maps\_specialops::_id_183F(var_0, var_1);
  level notify("so_special_failure_hint_set");
}

_id_1943(var_0, var_1) {
  maps\_specialops::_id_1841(var_0, var_1);
  level notify("so_special_failure_hint_set");
}

_id_0239() {
  self endon("death");
  level endon("special_op_terminated");

  for(;;) {
    self waittill("flashbang", var_0, var_1, var_2, var_3);

    if(!maps\_utility::_id_1A2C()) {
      continue;
    }
    if(isDefined(var_3) && isPlayer(var_3)) {
      var_3 maps\_damagefeedback::updatedamagefeedback(self);
    }
  }
}

_id_023A() {
  if(!maps\_utility::_id_12DC() && level.players.size == 2 && level.players[0]._id_16C6["kills"] > 0 && level.players[0]._id_16C6["kills"] == level.players[1]._id_16C6["kills"]) {
    level.players[0] maps\_utility::_id_1E39("FIFTY_FIFTY");
    level.players[1] maps\_utility::_id_1E39("FIFTY_FIFTY");
  }

  if(level.players.size >= 2 && level._id_16D1 >= 2) {
    var_0 = 0;

    foreach(var_2 in level.players) {
      if(isDefined(var_2._id_023C) && var_2._id_023C > 0) {
        var_0 = 1;
      }
      if(var_2 maps\_utility::_id_198F() < 2) {
        var_0 = 1;
      }
    }

    if(!var_0) {
      foreach(var_2 in level.players) {}
      var_2 maps\_utility::_id_1E39("NO_ASSISTANCE_REQUIRED");
    }
  }
}