/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\killstreak_utility.gsc
********************************************************/

function createstreakinfo(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.streakname = var_0;
  var_2.owner = var_1;
  var_2.id = getuniquekillstreakid(var_1);
  var_2.lifeid = getcurrentplayerlifeidforkillstreak();
  var_2.score = 0;
  var_2.shots_fired = 0;
  var_2.hits = 0;
  var_2.damage = 0;
  var_2.kills = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "createCustomStreakData")) {
    var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "createCustomStreakData")]](var_2, var_0);
  }

  return var_2;
}

function getuniquekillstreakid(var_0) {
  if(!isDefined(var_0.pers["nextKillstreakID"])) {
    var_0.pers["nextKillstreakID"] = 0;
  }

  var_1 = var_0.pers["nextKillstreakID"];
  var_0.pers["nextKillstreakID"]++;
  return var_1;
}

function getcurrentplayerlifeidforkillstreak() {
  if(!isDefined(self.pers["deaths"])) {
    return 0;
  }

  return self.pers["deaths"];
}

function getkillstreaklifeid(var_0) {
  var_1 = undefined;

  for(var_2 = 1; var_2 <= 3; var_2++) {
    var_3 = self.streakdata.streaks[var_2];

    if(isDefined(var_3) && var_3.streakname == var_0) {
      var_1 = var_3;
      break;
    }
  }

  if(isDefined(var_1)) {
    return var_1.lifeid;
  }

  return undefined;
}

function registervisibilityomnvarforkillstreak(var_0, var_1, var_2) {
  if(!isDefined(level.killstreak_visbilityomnvarlist)) {
    level.killstreak_visbilityomnvarlist = [];
  }

  if(isDefined(level.killstreak_visbilityomnvarlist[var_0]) && isDefined(level.killstreak_visbilityomnvarlist[var_0][var_1])) {
    return;
  }

  var_3 = 0;

  foreach(var_5 in level.killstreak_visbilityomnvarlist) {
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

  level.killstreak_visbilityomnvarlist[var_0][var_1] = var_2;
}

function _setvisibiilityomnvarforkillstreak(var_0, var_1) {
  var_2 = undefined;

  if(var_1 == "off") {
    var_2 = 0;
  } else {
    var_2 = level.killstreak_visbilityomnvarlist[var_0][var_1];
  }

  self setclientomnvar("ui_killstreak_controls", var_2);
}

function killstreakcanbeusedatroundstart(var_0) {
  switch (var_0) {
    case "rcxd_rad":
    case "weapondrop":
    case "dronedrop":
    case "radar_drone_overwatch":
    case "scrambler_drone_guard":
    case "directional_uav":
    case "counter_uav":
    case "uav":
      return 1;
    default:
      return 0;
  }
}

function isridekillstreak(var_0) {
  switch (var_0) {
    case "cruise_predator":
    case "pac_sentry":
    case "assault_drone":
    case "radar_drone_recon":
    case "gunship":
    case "chopper_gunner":
      return 1;
    default:
      return 0;
  }
}

function ismapselectkillstreak(var_0) {
  switch (var_0) {
    case "multi_airstrike":
    case "white_phosphorus":
    case "scrambler_drone_guard":
    case "nuke":
      return 1;
    default:
      return 0;
  }
}

function use_contract(var_0) {
  var_1 = 0;

  switch (var_0) {
    case "ks_remote_gunship_mp":
    case "ks_remote_device_mp":
      var_1 = 1;
      break;
  }

  return var_1;
}

function starttabletscreen(var_0, var_1) {
  var_2 = int(tablelookup("mp/killstreakTable.csv", 1, var_0, 0));
  self setclientomnvar("ui_remote_control_sequence", var_2);
  thread tabletdofset(var_1);
}

function stoptabletscreen(var_0, var_1) {
  self setclientomnvar("ui_remote_control_sequence", -1);
  thread tabletdofset(var_0, 1, var_1);
}

function tabletdofset(var_0, var_1, var_2) {
  self endon("disconnect");
  self notify("dof_set_tablet");
  self endon("dof_set_tablet");

  if(istrue(var_1) && !istrue(var_2)) {
    self enablephysicaldepthoffieldscripting();
    self setphysicaldepthoffield(1.8, 15, 20, 20);
    self setphysicalviewmodeldepthoffield(30, 5);
  }

  if(isDefined(var_0) && var_0 > 0) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  }

  if(istrue(var_1)) {
    self disablephysicaldepthoffieldscripting();
    return;
  }

  self enablephysicaldepthoffieldscripting();
  self setphysicaldepthoffield(1.8, 15, 20, 20);
  self setphysicalviewmodeldepthoffield(30, 5);
}

function killstreak_savenvgstate() {
  if(!isDefined(self.pers["useNVG"])) {
    return;
  }

  if(self isnightvisionon()) {
    self.pers["useNVG"] = 1;
    self.pers["killstreak_forcedNVGOff"] = 1;
    self nightvisionviewoff(1);
    return;
  }

  self.pers["useNVG"] = 0;
  self.pers["killstreak_forcedNVGOff"] = 0;
}

function killstreak_restorenvgstate() {
  if(!isDefined(self.pers["useNVG"])) {
    return;
  }

  if(istrue(self.pers["useNVG"])) {
    self nightvisionviewon(1);
    self.pers["killstreak_forcedNVGOff"] = 0;
    return;
  }
}

function playkillstreakoperatordialog(var_0, var_1, var_2) {
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
    if(!isDefined(var_3.currentkillstreakopvo) || istrue(var_1)) {
      var_3 scripts\cp_mp\utility\dialog_utility::operatordialogonplayer(var_0);
      var_3.currentkillstreakopvo = var_0;
      thread clearstoredkillstreakoperatordialog(var_3);
      return;
    }

    return;
  }
}

function clearstoredkillstreakoperatordialog(var_0) {
  self endon("disconnect");
  self notify("clear_stored_dialog");
  self endon("clear_stored_dialog");
  wait var_0;

  if(isDefined(self.currentkillstreakopvo)) {
    self.currentkillstreakopvo = undefined;
    return;
  }
}

function killstreak_createdangerzone(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "lpcFeatureGated") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "lpcFeatureGated")]]()) {
    return;
  }

  killstreak_destroydangerzone();
  var_6 = undefined;

  if(isDefined(var_4) && isDefined(var_5)) {
    var_6 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var_0, var_1, var_2, var_5, var_3, var_4, 1);
  } else if(isDefined(var_5)) {
    var_6 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var_0, var_1, var_2, var_5, var_3, undefined, 1);
  } else {
    var_6 = killstreak_spawnuniversaldangerzone(var_0, var_1, var_2, var_3);
  }

  self.dangerzoneid = var_6;
  return var_6;
}

function killstreak_spawnuniversaldangerzone(var_0, var_1, var_2, var_3) {
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    return;
  }

  var_4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var_0, var_1, var_2, undefined, var_3, level.players[randomint(level.players.size)], 1);
  self.dangerzoneid = var_4;
  return var_4;
}

function killstreak_destroydangerzone(var_0) {
  if(!isDefined(var_0) && !isDefined(self.dangerzoneid)) {
    return;
  }

  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "isSpawnDangerZoneAlive") || !scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "removeSpawnDangerZone")) {
    return;
  }

  if(!isDefined(var_0)) {
    var_0 = self.dangerzoneid;
  }

  if(isDefined(var_0) && [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "isSpawnDangerZoneAlive")]](var_0)) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "removeSpawnDangerZone")]](var_0);
  }

  self.dangerzoneid = undefined;
}

function streakcanseetarget(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0);

  if(scripts\engine\trace::ray_trace_passed(var_0, var_1, var_2, var_4)) {
    var_3 = 1;
  }

  return var_3;
}

function teamhasuav(var_0) {
  var_1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "squadAsTeamEnabled")) {
    var_1 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "squadAsTeamEnabled")]]();
    var_1 = var_1 && getdvarint("scr_uav_for_squad_only", 1);
  }

  foreach(var_3 in level.teamnamelist) {
    if(var_3 == var_0) {
      continue;
    }

    if(isDefined(level.uavmodels)) {
      if(istrue(var_1)) {
        foreach(var_10, var_5 in level.squaddata[var_3]) {
          var_6 = var_3 + var_10;

          if(isDefined(level.uavmodels[var_6]) && level.uavmodels[var_6].size > 0) {
            foreach(var_8 in level.uavmodels[var_6]) {
              if(!isDefined(var_8)) {
                continue;
              }

              if(var_8.uavtype == "counter_uav") {
                return false;
              }
            }
          }
        }

        continue;
      }

      if(isDefined(level.uavmodels[var_3]) && level.uavmodels[var_3].size > 0) {
        foreach(var_8 in level.uavmodels[var_3]) {
          if(!isDefined(var_8)) {
            continue;
          }

          if(var_8.uavtype == "counter_uav") {
            return false;
          }
        }
      }
    }
  }

  if(isDefined(level.uavmodels)) {
    if(istrue(var_1)) {
      foreach(var_5 in level.squaddata[var_0]) {
        var_6 = var_0 + var_10;

        if(isDefined(level.uavmodels[var_6]) && level.uavmodels[var_6].size > 0) {
          foreach(var_8 in level.uavmodels[var_6]) {
            if(!isDefined(var_8)) {
              continue;
            }

            if(var_8.uavtype == "uav" || var_8.uavtype == "directional_uav") {
              return true;
            }
          }
        }
      }
    } else if(isDefined(level.uavmodels[var_0]) && level.uavmodels[var_0].size > 0) {
      foreach(var_8 in level.uavmodels[var_0]) {
        if(!isDefined(var_8)) {
          continue;
        }

        if(var_8.uavtype == "uav" || var_8.uavtype == "directional_uav") {
          return true;
        }
      }
    }
  }

  return false;
}

function ref_13AAF(var_0) {
  var_1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "squadAsTeamEnabled")) {
    var_1 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "squadAsTeamEnabled")]]();
  }

  if(isDefined(level.uavmodels)) {
    if(istrue(var_1) && getdvarint("scr_uav_for_squad_only", 1)) {
      foreach(var_3 in level.squaddata[var_0]) {
        var_4 = var_0 + var_8;

        if(isDefined(level.uavmodels[var_4]) && level.uavmodels[var_4].size > 0) {
          foreach(var_6 in level.uavmodels[var_4]) {
            if(!isDefined(var_6)) {
              continue;
            }

            if(var_6.uavtype == "uav" || var_6.uavtype == "directional_uav") {
              return true;
            }
          }
        }
      }
    } else if(isDefined(level.uavmodels[var_0]) && level.uavmodels[var_0].size > 0) {
      foreach(var_6 in level.uavmodels[var_0]) {
        if(!isDefined(var_6)) {
          continue;
        }

        if(var_6.uavtype == "uav" || var_6.uavtype == "directional_uav") {
          return true;
        }
      }
    }
  }

  return false;
}

function enemyhascuav(var_0) {
  if(isDefined(level.supportdrones) && level.supportdrones.size > 0) {
    foreach(var_2 in level.supportdrones) {
      if(level.teambased && var_2.team == var_0) {
        continue;
      }

      if(var_2.helperdronetype == "scrambler_drone_guard") {
        return true;
      }
    }
  }

  return false;
}

function isuavactiveforteam(var_0) {
  if(!isDefined(level.uavmodels)) {
    return false;
  }

  if(!isDefined(level.uavmodels[var_0])) {
    return false;
  }

  return level.uavmodels[var_0].size > 0;
}

function getkillstreakdeployweapon(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "airdrop_multiple":
    case "airdrop":
      var_1 = "deploy_airdrop_mp";
      break;
    case "juggernaut":
      var_1 = "deploy_juggernaut_mp";
      break;
    case "bradley":
    case "radar_drone_overwatch":
    case "directional_uav":
    case "uav":
    case "chopper_support":
      var_1 = "ks_gesture_generic_mp";

      if(scripts\cp_mp\utility\game_utility::ref_140A9()) {
        var_1 = "ks_gesture_generic_mp_ch3";
      }

      break;
    case "toma_strike":
      var_1 = "iw8_green_beam_mp";

      if(scripts\cp_mp\utility\game_utility::ref_140A9()) {
        var_1 = "iw8_spotter_scope_mp_ch3";
      }

      break;
    case "precision_airstrike":
      var_1 = "iw8_spotter_scope_mp";

      if(scripts\cp_mp\utility\game_utility::ref_140A9()) {
        var_1 = "iw8_spotter_scope_mp_ch3";
      }

      break;
    case "cruise_predator":
    case "pac_sentry":
    case "gunship":
    case "chopper_gunner":
      var_1 = "ks_remote_device_mp";
      break;
    case "white_phosphorus":
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

function unsetobjectivemarker(var_0) {
  var_1 = 0;

  switch (var_0.basename) {
    case "deploy_airdrop_mp":
    case "ks_remote_nuke_mp":
    case "deploy_sentry_mp":
    case "deploy_manual_turret_mp":
    case "ks_remote_map_mp":
    case "iw8_spotter_scope_mp":
    case "iw8_spotter_scope_mp_ch3":
    case "iw8_green_beam_mp":
    case "ks_gesture_generic_mp_ch3":
    case "ks_gesture_generic_mp":
    case "deploy_juggernaut_mp":
    case "ks_remote_device_mp":
      var_1 = 1;
      break;
  }

  return var_1;
}

function getkillstreakgameweapons(var_0) {
  var_1 = [];
  var_2 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br";

  switch (var_0) {
    case "juggernaut":
      var_1 = ["iw8_minigunksjugg_mp", "iw8_minigunksjugg_reload_mp", "iw8_lm_dblmg_mp"];
      break;
    case "manual_turret":
      var_1 = ["manual_turret_mp"];
      break;
    case "sentry_gun":
      if(var_2) {
        var_1 = ["sentry_turret_wz"];
        break;
      }

      var_1 = ["sentry_turret_mp"];
      break;
  }

  return var_1;
}

function getnumactivekillstreakperteam(var_0, var_1) {
  var_2 = 0;

  foreach(var_4 in var_1) {
    if(var_4.team == var_0) {
      var_2++;
    }
  }

  return var_2;
}

function removeextracthelipad() {
  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    return scripts\cp_mp\utility\game_utility::getlocaleent("airstrikeheight");
  }

  var_0 = getEntArray("airstrikeheight", "targetname");

  if(var_0.size > 1) {}

  return var_0[0];
}

function ref_12CC6(var_0) {
  var_0 endon("death_or_disconnect");
  level endon("game_ended");

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }

  var_1 = 0.5;

  if(!isDefined(var_0.restoreangles)) {
    return;
  }

  while(var_1 > 0) {
    var_0 setplayerangles((var_0.restoreangles[0], var_0.restoreangles[1], 0));
    var_1 -= 0.05;
    wait 0.05;
  }

  var_0.restoreangles = undefined;
}

function ref_12AA7(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onKillStreakEnd")) {
    var_1 = var_0.mpstreaksysteminfo;

    if(isDefined(var_1)) {
      var_2 = var_1.streakname;
      var_3 = gettime();
      var_4 = var_3 - var_1.attackerisinflictor;
      var_5 = var_0.kills;
      var_6 = 0;
      var_7 = 0;
      var_8 = 0;
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onKillStreakEnd")]](var_2, var_4, var_3, var_5, var_6, var_7, var_8);
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("dlog", "killStreakExpired")) {
    var_1 = var_0.mpstreaksysteminfo;

    if(isDefined(var_1)) {
      var_9 = var_1.ref_13913;
      var_10 = var_1.streakname;
      var_11 = var_1.isgimme;
      var_3 = gettime();
      var_12 = self.origin;
      var_13 = istrue(var_0.onspray);
      var_14 = var_0.shots_fired;
      var_15 = var_0.hits;
      var_16 = var_0.kills;
      var_17 = var_0.score;
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("dlog", "killStreakExpired")]](self, var_9, var_10, var_11, var_3, var_12, var_13, var_14, var_15, var_16, var_17);
      return;
    }

    return;
  }
}

function ref_125F8() {
  var_0 = undefined;

  if(isDefined(self.vehicle)) {
    var_0 = [self.vehicle];
  } else {
    var_1 = self getgroundentity();

    if(isDefined(var_1) && isDefined(var_1.classname) && var_1.classname == "script_vehicle") {
      var_0 = [var_1];
    }
  }

  return var_0;
}

function ref_11DC0(var_0) {
  var_1 = var_0 getmovingplatformparent();

  if(isDefined(var_1) && _calloutmarkerping_handleluinotify_enemyrepinged::trophy_tryreflectsnapshot(var_1) || scripts\cp_mp\utility\script_utility::issharedfuncdefined("entity", "isGondolaBrush") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("entity", "isGondolaBrush")]](var_1)) {
    var_0 playerlinkTo(var_1);
    var_0 playerlinkedoffsetenable();
    var_0.ref_11DC2 = var_1;
    return;
  }
}

function ref_11DC1(var_0) {
  if(isDefined(var_0.ref_11DC2)) {
    var_0.ref_11DC2 = undefined;
    var_0 unlink();
    return;
  }
}