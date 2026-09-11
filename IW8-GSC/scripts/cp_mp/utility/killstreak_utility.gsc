/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\killstreak_utility.gsc
********************************************************/

function createstreakinfo(var0, var1) {
  var2 = spawnStruct();
  var2.streakname = var0;
  var2.owner = var1;
  var2.id = getuniquekillstreakid(var1);
  var2.lifeid = getcurrentplayerlifeidforkillstreak();
  var2.score = 0;
  var2.shots_fired = 0;
  var2.hits = 0;
  var2.damage = 0;
  var2.kills = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "createCustomStreakData")) {
    var2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "createCustomStreakData")]](var2, var0);
  }

  return var2;
}

function getuniquekillstreakid(var0) {
  if(!isDefined(var0.pers["nextKillstreakID"])) {
    var0.pers["nextKillstreakID"] = 0;
  }

  var1 = var0.pers["nextKillstreakID"];
  var0.pers["nextKillstreakID"]++;
  return var1;
}

function getcurrentplayerlifeidforkillstreak() {
  if(!isDefined(self.pers["deaths"])) {
    return 0;
  }

  return self.pers["deaths"];
}

function getkillstreaklifeid(var0) {
  var1 = undefined;

  for(var2 = 1; var2 <= 3; var2++) {
    var3 = self.streakdata.streaks[var2];

    if(isDefined(var3) && var3.streakname == var0) {
      var1 = var3;
      break;
    }
  }

  if(isDefined(var1)) {
    return var1.lifeid;
  }

  return undefined;
}

function registervisibilityomnvarforkillstreak(var0, var1, var2) {
  if(!isDefined(level.killstreak_visbilityomnvarlist)) {
    level.killstreak_visbilityomnvarlist = [];
  }

  if(isDefined(level.killstreak_visbilityomnvarlist[var0]) && isDefined(level.killstreak_visbilityomnvarlist[var0][var1])) {
    return;
  }

  var3 = 0;

  foreach(var5 in level.killstreak_visbilityomnvarlist) {
    foreach(var7 in var5) {
      if(var2 == var7) {
        var3 = 1;
        break;
      }
    }

    if(istrue(var3)) {
      return;
    }
  }

  level.killstreak_visbilityomnvarlist[var0][var1] = var2;
}

function _setvisibiilityomnvarforkillstreak(var0, var1) {
  var2 = undefined;

  if(var1 == "off") {
    var2 = 0;
  } else {
    var2 = level.killstreak_visbilityomnvarlist[var0][var1];
  }

  self setclientomnvar("ui_killstreak_controls", var2);
}

function killstreakcanbeusedatroundstart(var0) {
  switch (var0) {
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

function isridekillstreak(var0) {
  switch (var0) {
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

function ismapselectkillstreak(var0) {
  switch (var0) {
    case "multi_airstrike":
    case "white_phosphorus":
    case "scrambler_drone_guard":
    case "nuke":
      return 1;
    default:
      return 0;
  }
}

function use_contract(var0) {
  var1 = 0;

  switch (var0) {
    case "ks_remote_gunship_mp":
    case "ks_remote_device_mp":
      var1 = 1;
      break;
  }

  return var1;
}

function starttabletscreen(var0, var1) {
  var2 = int(tablelookup("mp/killstreakTable.csv", 1, var0, 0));
  self setclientomnvar("ui_remote_control_sequence", var2);
  thread tabletdofset(var1);
}

function stoptabletscreen(var0, var1) {
  self setclientomnvar("ui_remote_control_sequence", -1);
  thread tabletdofset(var0, 1, var1);
}

function tabletdofset(var0, var1, var2) {
  self endon("disconnect");
  self notify("dof_set_tablet");
  self endon("dof_set_tablet");

  if(istrue(var1) && !istrue(var2)) {
    self enablephysicaldepthoffieldscripting();
    self setphysicaldepthoffield(1.8, 15, 20, 20);
    self setphysicalviewmodeldepthoffield(30, 5);
  }

  if(isDefined(var0) && var0 > 0) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var0);
  }

  if(istrue(var1)) {
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

function playkillstreakoperatordialog(var0, var1, var2) {
  var3 = undefined;

  if(isPlayer(self)) {
    var3 = self;
  } else if(isDefined(self.owner)) {
    var3 = self.owner;
  }

  if(isDefined(var2) && var2 > 0) {
    var3 endon("disconnect");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var2);
  }

  if(isDefined(var3)) {
    if(!isDefined(var3.currentkillstreakopvo) || istrue(var1)) {
      var3 scripts\cp_mp\utility\dialog_utility::operatordialogonplayer(var0);
      var3.currentkillstreakopvo = var0;
      thread clearstoredkillstreakoperatordialog(var3);
      return;
    }

    return;
  }
}

function clearstoredkillstreakoperatordialog(var0) {
  self endon("disconnect");
  self notify("clear_stored_dialog");
  self endon("clear_stored_dialog");
  wait var0;

  if(isDefined(self.currentkillstreakopvo)) {
    self.currentkillstreakopvo = undefined;
    return;
  }
}

function killstreak_createdangerzone(var0, var1, var2, var3, var4, var5) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "lpcFeatureGated") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "lpcFeatureGated")]]()) {
    return;
  }

  killstreak_destroydangerzone();
  var6 = undefined;

  if(isDefined(var4) && isDefined(var5)) {
    var6 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var0, var1, var2, var5, var3, var4, 1);
  } else if(isDefined(var5)) {
    var6 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var0, var1, var2, var5, var3, undefined, 1);
  } else {
    var6 = killstreak_spawnuniversaldangerzone(var0, var1, var2, var3);
  }

  self.dangerzoneid = var6;
  return var6;
}

function killstreak_spawnuniversaldangerzone(var0, var1, var2, var3) {
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    return;
  }

  var4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var0, var1, var2, undefined, var3, level.players[randomint(level.players.size)], 1);
  self.dangerzoneid = var4;
  return var4;
}

function killstreak_destroydangerzone(var0) {
  if(!isDefined(var0) && !isDefined(self.dangerzoneid)) {
    return;
  }

  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "isSpawnDangerZoneAlive") || !scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "removeSpawnDangerZone")) {
    return;
  }

  if(!isDefined(var0)) {
    var0 = self.dangerzoneid;
  }

  if(isDefined(var0) && [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "isSpawnDangerZoneAlive")]](var0)) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "removeSpawnDangerZone")]](var0);
  }

  self.dangerzoneid = undefined;
}

function streakcanseetarget(var0, var1, var2) {
  var3 = 0;
  var4 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0);

  if(scripts\engine\trace::ray_trace_passed(var0, var1, var2, var4)) {
    var3 = 1;
  }

  return var3;
}

function teamhasuav(var0) {
  var1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "squadAsTeamEnabled")) {
    var1 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "squadAsTeamEnabled")]]();
    var1 = var1 && getdvarint("scr_uav_for_squad_only", 1);
  }

  foreach(var3 in level.teamnamelist) {
    if(var3 == var0) {
      continue;
    }

    if(isDefined(level.uavmodels)) {
      if(istrue(var1)) {
        foreach(var10, var5 in level.squaddata[var3]) {
          var6 = var3 + var10;

          if(isDefined(level.uavmodels[var6]) && level.uavmodels[var6].size > 0) {
            foreach(var8 in level.uavmodels[var6]) {
              if(!isDefined(var8)) {
                continue;
              }

              if(var8.uavtype == "counter_uav") {
                return false;
              }
            }
          }
        }

        continue;
      }

      if(isDefined(level.uavmodels[var3]) && level.uavmodels[var3].size > 0) {
        foreach(var8 in level.uavmodels[var3]) {
          if(!isDefined(var8)) {
            continue;
          }

          if(var8.uavtype == "counter_uav") {
            return false;
          }
        }
      }
    }
  }

  if(isDefined(level.uavmodels)) {
    if(istrue(var1)) {
      foreach(var5 in level.squaddata[var0]) {
        var6 = var0 + var10;

        if(isDefined(level.uavmodels[var6]) && level.uavmodels[var6].size > 0) {
          foreach(var8 in level.uavmodels[var6]) {
            if(!isDefined(var8)) {
              continue;
            }

            if(var8.uavtype == "uav" || var8.uavtype == "directional_uav") {
              return true;
            }
          }
        }
      }
    } else if(isDefined(level.uavmodels[var0]) && level.uavmodels[var0].size > 0) {
      foreach(var8 in level.uavmodels[var0]) {
        if(!isDefined(var8)) {
          continue;
        }

        if(var8.uavtype == "uav" || var8.uavtype == "directional_uav") {
          return true;
        }
      }
    }
  }

  return false;
}

function ref_13aaf(var0) {
  var1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "squadAsTeamEnabled")) {
    var1 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "squadAsTeamEnabled")]]();
  }

  if(isDefined(level.uavmodels)) {
    if(istrue(var1) && getdvarint("scr_uav_for_squad_only", 1)) {
      foreach(var3 in level.squaddata[var0]) {
        var4 = var0 + var8;

        if(isDefined(level.uavmodels[var4]) && level.uavmodels[var4].size > 0) {
          foreach(var6 in level.uavmodels[var4]) {
            if(!isDefined(var6)) {
              continue;
            }

            if(var6.uavtype == "uav" || var6.uavtype == "directional_uav") {
              return true;
            }
          }
        }
      }
    } else if(isDefined(level.uavmodels[var0]) && level.uavmodels[var0].size > 0) {
      foreach(var6 in level.uavmodels[var0]) {
        if(!isDefined(var6)) {
          continue;
        }

        if(var6.uavtype == "uav" || var6.uavtype == "directional_uav") {
          return true;
        }
      }
    }
  }

  return false;
}

function enemyhascuav(var0) {
  if(isDefined(level.supportdrones) && level.supportdrones.size > 0) {
    foreach(var2 in level.supportdrones) {
      if(level.teambased && var2.team == var0) {
        continue;
      }

      if(var2.helperdronetype == "scrambler_drone_guard") {
        return true;
      }
    }
  }

  return false;
}

function isuavactiveforteam(var0) {
  if(!isDefined(level.uavmodels)) {
    return false;
  }

  if(!isDefined(level.uavmodels[var0])) {
    return false;
  }

  return level.uavmodels[var0].size > 0;
}

function getkillstreakdeployweapon(var0) {
  var1 = undefined;

  switch (var0) {
    case "airdrop_multiple":
    case "airdrop":
      var1 = "deploy_airdrop_mp";
      break;
    case "juggernaut":
      var1 = "deploy_juggernaut_mp";
      break;
    case "bradley":
    case "radar_drone_overwatch":
    case "directional_uav":
    case "uav":
    case "chopper_support":
      var1 = "ks_gesture_generic_mp";

      if(scripts\cp_mp\utility\game_utility::ref_140a9()) {
        var1 = "ks_gesture_generic_mp_ch3";
      }

      break;
    case "toma_strike":
      var1 = "iw8_green_beam_mp";

      if(scripts\cp_mp\utility\game_utility::ref_140a9()) {
        var1 = "iw8_spotter_scope_mp_ch3";
      }

      break;
    case "precision_airstrike":
      var1 = "iw8_spotter_scope_mp";

      if(scripts\cp_mp\utility\game_utility::ref_140a9()) {
        var1 = "iw8_spotter_scope_mp_ch3";
      }

      break;
    case "cruise_predator":
    case "pac_sentry":
    case "gunship":
    case "chopper_gunner":
      var1 = "ks_remote_device_mp";
      break;
    case "white_phosphorus":
    case "hover_jet":
    case "scrambler_drone_guard":
      var1 = "ks_remote_map_mp";
      break;
    case "manual_turret":
      var1 = "deploy_manual_turret_mp";
      break;
    case "sentry_gun":
      var1 = "deploy_sentry_mp";
      break;
    case "nuke":
      var1 = "ks_remote_nuke_mp";
      break;
  }

  return var1;
}

function unsetobjectivemarker(var0) {
  var1 = 0;

  switch (var0.basename) {
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
      var1 = 1;
      break;
  }

  return var1;
}

function getkillstreakgameweapons(var0) {
  var1 = [];
  var2 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br";

  switch (var0) {
    case "juggernaut":
      var1 = ["iw8_minigunksjugg_mp", "iw8_minigunksjugg_reload_mp", "iw8_lm_dblmg_mp"];
      break;
    case "manual_turret":
      var1 = ["manual_turret_mp"];
      break;
    case "sentry_gun":
      if(var2) {
        var1 = ["sentry_turret_wz"];
        break;
      }

      var1 = ["sentry_turret_mp"];
      break;
  }

  return var1;
}

function getnumactivekillstreakperteam(var0, var1) {
  var2 = 0;

  foreach(var4 in var1) {
    if(var4.team == var0) {
      var2++;
    }
  }

  return var2;
}

function removeextracthelipad() {
  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    return scripts\cp_mp\utility\game_utility::getlocaleent("airstrikeheight");
  }

  var0 = getEntArray("airstrikeheight", "targetname");

  if(var0.size > 1) {}

  return var0[0];
}

function ref_12cc6(var0) {
  var0 endon("death_or_disconnect");
  level endon("game_ended");

  if(!var0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }

  var1 = 0.5;

  if(!isDefined(var0.restoreangles)) {
    return;
  }

  while(var1 > 0) {
    var0 setplayerangles((var0.restoreangles[0], var0.restoreangles[1], 0));
    var1 -= 0.05;
    wait 0.05;
  }

  var0.restoreangles = undefined;
}

function ref_12aa7(var0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onKillStreakEnd")) {
    var1 = var0.mpstreaksysteminfo;

    if(isDefined(var1)) {
      var2 = var1.streakname;
      var3 = gettime();
      var4 = var3 - var1.attackerisinflictor;
      var5 = var0.kills;
      var6 = 0;
      var7 = 0;
      var8 = 0;
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onKillStreakEnd")]](var2, var4, var3, var5, var6, var7, var8);
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("dlog", "killStreakExpired")) {
    var1 = var0.mpstreaksysteminfo;

    if(isDefined(var1)) {
      var9 = var1.ref_13913;
      var10 = var1.streakname;
      var11 = var1.isgimme;
      var3 = gettime();
      var12 = self.origin;
      var13 = istrue(var0.onspray);
      var14 = var0.shots_fired;
      var15 = var0.hits;
      var16 = var0.kills;
      var17 = var0.score;
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("dlog", "killStreakExpired")]](self, var9, var10, var11, var3, var12, var13, var14, var15, var16, var17);
      return;
    }

    return;
  }
}

function ref_125f8() {
  var0 = undefined;

  if(isDefined(self.vehicle)) {
    var0 = [self.vehicle];
  } else {
    var1 = self getgroundentity();

    if(isDefined(var1) && isDefined(var1.classname) && var1.classname == "script_vehicle") {
      var0 = [var1];
    }
  }

  return var0;
}

function ref_11dc0(var0) {
  var1 = var0 getmovingplatformparent();

  if(isDefined(var1) && _calloutmarkerping_handleluinotify_enemyrepinged::trophy_tryreflectsnapshot(var1) || scripts\cp_mp\utility\script_utility::issharedfuncdefined("entity", "isGondolaBrush") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("entity", "isGondolaBrush")]](var1)) {
    var0 playerlinkTo(var1);
    var0 playerlinkedoffsetenable();
    var0.ref_11dc2 = var1;
    return;
  }
}

function ref_11dc1(var0) {
  if(isDefined(var0.ref_11dc2)) {
    var0.ref_11dc2 = undefined;
    var0 unlink();
    return;
  }
}