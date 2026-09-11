/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\toma_strike.gsc
*****************************************************/

function init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("toma_strike", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("toma_strike", "init")]]();
  }

  level.toma_strikes = [];
  init_toma_strike_vo();
}

function init_toma_strike_vo() {
  game["dialog"]["cluster_strike_hit"] = "cluster_strike_hit";
  game["dialog"]["cluster_strike_miss"] = "cluster_strike_miss";
}

function trytomastriketriggered(var_0) {
  var_1 = var_0.streakname;
  var_2 = getdvarint("scr_toma_strike_type", 3);
  return true;
}

function weapondetonatedtomastrike(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = getdvarint("scr_toma_strike_type", 3);
  thread tomastrike_attacktarget(var_2, var_3, undefined, var_1);
}

function weapongiventomastrike(var_0) {
  if(isDefined(level.toma_strikes) && level.toma_strikes.size >= 2) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    var_0 notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  return true;
}

function weaponswitchendedtomastrike(var_0, var_1) {
  var_2 = getdvarint("scr_toma_strike_type", 3);

  if(scripts\cp_mp\utility\game_utility::ref_140a9()) {
    thread scripts\cp_mp\killstreaks\airstrike::airstrike_watchforads(var_0);
    return;
  }
}

function weaponfiredtomastrike(var_0, var_1, var_2) {
  if(!isDefined(var_0.ref_13a81)) {
    var_3 = tomastrike_getownerlookat(self);

    if(!isDefined(var_3)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/INVALID_POINT");
      }

      return "continue";
    }
  }

  if(isDefined(level.gametype)) {
    if(level.gametype == "br" && isDefined(self.scrambledby)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP_BR_INGAME_TU_WZ335/JAMMED");
      }

      return "continue";
    }
  }

  if(scripts\cp_mp\emp_debuff::is_empd()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/CANNOT_BE_USED");
    }

    return "continue";
  }

  var_4 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var_0.streakname);
    var_4 = 2;
  }

  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var_0.streakname, 1, var_4);
  return "success";
}

function tryusetomastrike() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("toma_strike", self);
  return tryusetomastrikefromstruct(var_0);
}

function tryusetomastrikefromstruct(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      return 0;
    }
  }

  var_1 = getdvarint("scr_toma_strike_type", 3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();

    if(var_2 == "br") {
      var_1 = 5;
    }
  }

  if(var_1 == 4) {
    var_3 = scripts\mp\killstreaks\throwback_marker::throwbackmarker_trythrowbackmarker(var_0, &weapondetonatedtomastrike);

    if(!istrue(var_3)) {
      return 0;
    }
  } else if(var_1 == 5 && isDefined(self.waitandunloadinfils)) {
    var_0.ref_13a81 = self.waitandunloadinfils;
    self.waitandunloadinfils = undefined;
    var_4 = weaponfiredtomastrike(var_0, undefined, undefined);

    if(var_4 != "success") {
      return 0;
    }
  } else {
    if(scripts\cp_mp\utility\game_utility::ref_140a9()) {
      var_5 = getcompleteweaponname("iw8_spotter_scope_mp_ch3", ["spotterscope"]);
    } else {
      var_5 = getcompleteweaponname("iw8_green_beam_mp");
    }

    var_3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(var_1, var_5, "weapon_fired", &weapongiventomastrike, &weaponswitchendedtomastrike, &weaponfiredtomastrike);

    if(!istrue(var_3)) {
      return 0;
    }
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_1)) {
      return 0;
    }
  }

  if(tomastrike_isremotevehicletype(var_5)) {
    var_6 = 1;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "currentActiveVehicleCount") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "currentActiveVehicleCount")]]() >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]() || level.fauxvehiclecount + var_6 >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]()) {
        self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
        var_1 notify("killstreak_finished_with_deploy_weapon");
        return 0;
      }
    }

    var_3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var_1, &weapongiventomastrike, &weaponswitchendedtomastrike);

    if(!istrue(var_3)) {
      return 0;
    }
  }

  var_7 = undefined;

  if(var_5 == 0) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "incrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "incrementFauxVehicleCount")]]();
    }

    var_7 = createtomastrikedrone(self, var_1);

    if(!isDefined(var_7)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
      }

      return 0;
    }
  } else if(var_5 == 1) {
    if(level.toma_cameras.size == 0) {
      var_8 = ["ks_strike_camera_1", "ks_strike_camera_2", "ks_strike_camera_3", "ks_strike_camera_4"];

      foreach(var_10 in var_8) {
        var_11 = scripts\engine\utility::getStruct(var_10, "targetname");

        if(!isDefined(var_11)) {
          var_1 notify("killstreak_finished_with_deploy_weapon");
          return;
        }

        var_12 = spawn("script_model", var_11.origin);
        var_12.angles = var_11.angles;
        var_12.targetname = var_11.targetname;
        var_12 setModel("tag_player");
        level.toma_cameras[level.toma_cameras.size] = var_12;
      }
    }
  } else if(var_5 == 2) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "incrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "incrementFauxVehicleCount")]]();
    }

    var_7 = createtomastrikebomber(self, var_1);

    if(!isDefined(var_7)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
      }

      return 0;
    }
  } else {
    level.toma_strikes[level.toma_strikes.size] = self;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_toma_strike", self);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var_1.streakname, self.origin);
  }

  if(var_5 != 4) {
    thread starttomastrike(var_5, var_7, level.toma_cameras, var_1);
  }

  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](var_1);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("toma_strike", "munitionUsed")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("toma_strike", "munitionUsed")]]();
  }

  return 1;
}

function ref_13bda(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_0;
  var_3.angles = var_1;
  var_3.pers = [];
  var_3.team = "neutral";
  var_3.defaultoperatorteam = "neutral";
  var_3.classname = "worldspawn";

  if(!isDefined(var_2)) {
    var_2 = var_3 scripts\cp_mp\utility\killstreak_utility::createstreakinfo("toma_strike", var_3);
  }

  var_2.owner = var_3;
  var_2.ref_13a81 = var_0;
  var_2.ref_121af = anglesToForward(var_1);
  var_2.ref_133dc = 1;
  thread starttomastrike(var_3, 5, undefined, undefined);
}

function createtomastrikedrone(var_0, var_1) {
  var_2 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var_3 = (0, 0, 0);

  if(isDefined(var_2)) {
    var_3 = (0, 0, var_2.origin[2]);
  } else {
    var_3 = (0, 0, 600);
  }

  var_3 -= (0, 0, 900);
  var_4 = spawnhelicopter(var_0, var_0.origin + (0, 0, 1000), var_0.angles, "veh_toma_drone_mp", "veh8_mil_air_mquebec8");

  if(!isDefined(var_4)) {
    return;
  }

  var_4.speed = 100;
  var_4.accel = 50;
  var_4.health = 9999;
  var_4.maxhealth = 2000;
  var_4.lifetime = 10;
  var_4.team = var_0.team;
  var_4.owner = var_0;
  var_4.angles = var_0.angles;
  var_4.streakinfo = var_1;
  var_4.streakname = var_1.streakname;
  var_4.currentdamagestate = 0;
  var_4.scorepopup = "destroyed_toma_strike";
  var_4.vodestroyed = "destroyed_toma_strike";
  var_4.votimeout = "timeout_toma_strike";
  var_4.destroyedsplash = "callout_destroyed_toma_strike";
  var_4.currentvisionset = "proto_apache_flir_mp";
  level.toma_strikes[level.toma_strikes.size] = var_4;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_4[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_1.streakname, "Killstreak_Air", var_0, 0, 1, 25);
  }

  var_4 setmaxpitchroll(15, 15);
  var_4 vehicle_setspeed(var_4.speed, var_4.accel);
  var_4 sethoverparams(50, 5, 2.5);
  var_4 setturningability(1);
  var_4 setyawspeed(500, 100, 25, 0.5);
  var_4 setotherent(var_0);
  var_4 setentityowner(var_0);
  var_4 setCanDamage(1);
  var_4 setneargoalnotifydist(100);
  return var_4;
}

function createtomastrikebomber(var_0, var_1) {
  var_2 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var_3 = (0, 0, 0);

  if(isDefined(var_2)) {
    var_3 = (0, 0, var_2.origin[2] + 8000);
  } else {
    var_3 = (0, 0, 5000);
  }

  var_3 -= (0, 0, 900);
  var_4 = level.mapcenter - anglesToForward(var_0.angles) * 5000 + var_3;
  var_5 = level.mapcenter + anglesToForward(var_0.angles) * 20000 + var_3;
  var_6 = spawn("script_model", var_4);
  var_6 setModel("veh8_mil_air_acharlie130");
  var_6.health = 9999;
  var_6.maxhealth = 2000;
  var_6.angles = var_0.angles;
  var_6.owner = var_0;
  var_6.team = var_0.team;
  var_6.streakinfo = var_1;
  var_6.streakname = var_1.streakname;
  var_6.pathstart = var_4;
  var_6.pathgoal = var_5;
  var_6.flaresreservecount = 1;
  var_6 setotherent(var_0);
  var_6 setentityowner(var_0);
  var_6 setCanDamage(1);
  var_6 scriptmoveroutline();
  var_6 scriptmoverthermal();
  var_6.camera = spawn("script_model", var_6.origin - (0, 0, 10));
  var_6.camera setModel("tag_player");
  var_6.camera.angles = vectortoangles(level.mapcenter - var_6.camera.origin);
  var_6.camera linkTo(var_6);
  var_6.cloudsfx = spawn("script_model", var_6.camera.origin - (0, 0, 10));
  var_6.cloudsfx setModel("ks_toma_strike_mp");
  var_6.cloudsfx.angles = var_6.angles;
  var_6.cloudsfx linkTo(var_6.camera);
  level.toma_strikes[level.toma_strikes.size] = var_6;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_6[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_1.streakname, "Killstreak_Air", var_0, 0, 1, 25);
  }

  return var_6;
}

function starttomastrike(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  level endon("game_ended");

  if(tomastrike_isremotevehicletype(var_0)) {
    scripts\common\utility::allow_fire(0);
    scripts\common\utility::allow_weapon_switch(0);
    scripts\common\utility::allow_crouch(0);
    scripts\common\utility::allow_prone(0);
    scripts\common\utility::allow_usability(0);
    scripts\common\utility::allow_killstreaks(0);
    self.restoreangles = self.angles;
    var_4 = 1;
    var_5 = spawn("script_model", self.origin);
    var_5 setModel("ks_toma_strike_marker_mp");
    var_5 setotherent(self);
    var_6 = [];

    foreach(var_8 in level.players) {
      if(level.teambased && var_8.team == self.team) {
        continue;
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
        if(var_8[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
          continue;
        }
      }

      var_6 = var_8;
    }

    var_10 = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionenemydefault", self, var_6, self, 0, 1, 1);
    var_11 = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionfriendlydefault", self, self, self);

    if(var_0 == 0) {
      if(!isDefined(var_1)) {
        return;
      }

      self setplayerangles(var_1.angles);
      self cameralinkTo(var_1, "tag_origin");
      self remotecontrolvehicle(var_1);
      thread tomastrike_watchearlyexit();
      thread tomastrike_watchdamage();
      thread tomastrike_watchowner();
      thread tomastrike_watchdestroyed(var_1);
      thread tomastrike_watchlifetime(var_5, var_1);
      var_1.playersfx = spawn("script_origin", var_1.origin);
      var_1.playersfx linkTo(var_1);
      var_1.playersfx playLoopSound("veh_apache_killstreak_amb_lr");
      self setclientomnvar("ui_killstreak_health", (var_1.maxhealth - var_1.damagetaken) / var_1.maxhealth);
    } else if(var_0 == 1) {
      if(!isDefined(var_2) || var_2.size == 0) {
        return;
      }

      var_4 = 0;
      scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "tomaStrike");
      thread tomastrike_watchcameraswitch(var_2, var_5);
      thread tomastrike_watchlifetime(var_5, var_1);
    } else if(var_0 == 2) {
      if(!isDefined(var_1)) {
        return;
      }

      self playerlinkweaponviewtodelta(var_1.camera, "tag_player", 1, 180, 180, 10, 90, 0);
      self playerlinkedsetviewznear(0);
      thread tomastrike_watchearlyexit();
      thread tomastrike_watchdamage();
      thread tomastrike_watchowner();
      thread tomastrike_watchdestroyed(var_1);
      thread tomastrike_watchleave(var_1);
      thread tomastrike_playearthquakeloop();

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger")) {
        var_1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]](&tomastrike_handlemissiledetection);
      }

      if(isPlayer(var_1.owner)) {
        var_1.owner setclienttriggeraudiozone("cluster_strike", 2);
      }

      var_1.cloudsfx setscriptablepartstate("clouds", "on");
      var_1 moveTo(var_1.pathgoal, 70);
    }

    self.clusterammoleft = 3;
    self setclientomnvar("ui_cluster_controls", 1);
    self setclientomnvar("ui_cluster_missiles_left", self.clusterammoleft);
    self visionsetkillstreakforplayer("proto_toma_strike_mp");
    thread tomastrike_movetargetguide(var_5, var_1);
    thread tomastrike_watchammousage(var_5, var_1, var_4);
    thread tomastrike_watchlasertarget(var_0, var_5, var_1, var_3);
    thread tomastrike_watchreturnplayer(var_3, var_0, var_10, var_11);
    return;
  }

  thread tomastrike_attacktarget(var_0, undefined, undefined, var_3);
  var_3 notify("killstreak_finished_with_deploy_weapon");
  thread ref_13bd9(var_3);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(20);
  self notify("cluster_strike_finished");
  scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var_3);
}

function tomastrike_handlemissiledetection(var_0, var_1, var_2, var_3) {
  self endon("death");

  for(;;) {
    if(!isDefined(var_2)) {
      break;
    }

    var_4 = var_2 getpointinbounds(0, 0, 0);
    var_5 = distance(self.origin, var_4);

    if(var_5 < 4000 && var_2.flaresreservecount > 0) {
      var_2.flaresreservecount--;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "playFx")) {
        var_2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "playFx")]](undefined, var_3);
      }

      var_6 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "deploy")) {
        var_6 = var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "deploy")]]();
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "updateScrapAssistDataForceCredit")) {
        var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "updateScrapAssistDataForceCredit")]](var_0);
      }

      self missile_settargetEnt(var_6);
      self notify("missile_pairedWithFlare");
      return;
    }

    waitframe();
  }
}

function tomastrike_watchearlyexit() {
  self.owner endon("disconnect");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "allowRideKillstreakPlayerExit")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "allowRideKillstreakPlayerExit")]]("death");
  }

  self waittill("killstreakExit");
  self notify("death");
}

function tomastrike_watchlifetime(var_0, var_1) {
  self endon("disconnect");
  self endon("stop_marker_guide");
  var_2 = 1;

  if(isDefined(var_1)) {
    var_1 endon("death");
    var_1 endon("leaving");
    var_2 = 0;
  }

  level endon("game_ended");
  self setclientomnvar("ui_killstreak_countdown", gettime() + int(10000));
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(10);
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("timeout_toma_strike");

  if(isDefined(var_1)) {
    var_1 notify("death");
  }

  self notify("tomaStrike_returnPlayer", var_2);

  if(isDefined(var_0)) {
    var_0 delete();
  }

  self notify("stop_marker_guide");
}

function tomastrike_watchdamage() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("toma_strike", "monitorDamage")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("toma_strike", "monitorDamage")]](self.maxhealth, "hitequip", &tomastrike_watchdeathdamage, &tomastrike_modifydamage, 1);
    return;
  }
}

function tomastrike_modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = var_4;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage")) {
    var_6 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](var_1, var_2, var_3, var_6, self.maxhealth, 2, 3, 4);
  }

  if(isDefined(self.owner) && self.owner scripts\cp_mp\utility\player_utility::isusingremote()) {
    if(istrue(self.largeprojectiledamage)) {
      earthquake(0.25, 0.2, self.origin, 150);
      self.owner playRumbleOnEntity("damage_heavy");
    } else {
      earthquake(0.15, 0.15, self.origin, 150);
      self.owner playRumbleOnEntity("damage_light");
    }
  }

  self.currenthealth = self.maxhealth - self.damagetaken + var_6;
  self.owner setclientomnvar("ui_killstreak_health", self.currenthealth / self.maxhealth);
  return var_6;
}

function tomastrike_watchdeathdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "onKillstreakKilled")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "onKillstreakKilled")]](self.streakname, var_1, var_2, var_3, var_4, self.scorepopup, self.vodestroyed, self.destroyedsplash);
  }

  self notify("death");
}

function tomastrike_watchdestroyed(var_0) {
  self endon("gone");
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }

  self.owner notify("toma_strike_end");

  if(isDefined(self.owner) && self.owner scripts\cp_mp\utility\player_utility::isusingremote()) {
    self.owner notify("tomaStrike_returnPlayer", 0);
  }

  thread tomastrike_explode(self.owner, self.origin, "toma_proj_mp", var_0);
}

function tomastrike_watchleave(var_0) {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(35);
  self notify("leaving");

  if(isDefined(self.owner) && self.owner scripts\cp_mp\utility\player_utility::isusingremote()) {
    self.owner notify("tomaStrike_returnPlayer", 0);
  }

  if(isDefined(self.turret)) {
    self.turret delete();
  }

  if(isDefined(self.camera)) {
    self.camera delete();
  }

  if(isDefined(self.cloudsfx)) {
    self.cloudsfx delete();
  }

  if(isDefined(var_0)) {
    var_0 delete();
  }

  thread tomastrike_watchgoal(var_0);
}

function tomastrike_watchgoal(var_0) {
  self endon("death");
  level endon("game_ended");

  while(self.origin != self.pathgoal) {
    waitframe();
  }

  level.toma_strikes = scripts\engine\utility::array_remove(level.toma_strikes, self);

  if(isDefined(self.playersfx)) {
    self.playersfx stoploopsound();
    self.playersfx delete();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
  }

  self delete();
}

function tomastrike_playearthquakeloop() {
  self endon("death");
  self endon("leaving");
  level endon("game_ended");

  for(;;) {
    self.owner earthquakeforplayer(0.07, 0.1, self gettagorigin("tag_origin"), 700);
    wait 0.1;
  }
}

function tomastrike_watchowner() {
  self endon("death");
  level endon("game_ended");
  self.owner scripts\engine\utility::ref_143a6("disconnect", "joined_team", "joined_spectators");
  self notify("death");
}

function tomastrike_watchcameraswitch(var_0, var_1) {
  self endon("disconnect");
  self endon("stop_marker_guide");
  var_2 = var_0[0];
  self playerlinkweaponviewtodelta(var_2, "tag_player", 1, 45, 45, 20, 70, 0);
  self setplayerangles(var_2.angles);
  self.currentclustercamera = var_2;
  self notifyonplayercommand("switch_camera_left", "+actionslot 3");
  self notifyonplayercommand("switch_camera_left", "+moveleft");
  self notifyonplayercommand("switch_camera_right", "+actionslot 4");
  self notifyonplayercommand("switch_camera_right", "+moveright");
  var_3 = 0;
  var_4 = var_0.size - 1;
  var_5 = var_3;

  for(;;) {
    var_6 = scripts\engine\utility::ref_143ad("switch_camera_left", "switch_camera_right");
    var_7 = var_0[var_5].origin;
    var_8 = self getplayerangles();

    if(!isDefined(var_6)) {
      continue;
    }

    switch (var_6) {
      case "switch_camera_left":
        var_5++;

        if(var_5 > var_4) {
          var_5 = var_3;
        }

        break;
      case "switch_camera_right":
        var_5--;

        if(var_5 < var_3) {
          var_5 = var_4;
        }

        break;
    }

    tomastrike_playercameratransition(var_7, var_8, var_0[var_5], var_1);
    waitframe();
  }
}

function tomastrike_playercameratransition(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_4 = spawn("script_model", var_0);
  var_4 setModel("tag_player");
  var_4.owner = self;
  var_4.angles = var_1;
  self playerlinkweaponviewtodelta(var_4, "tag_player", 1, 0, 0, 0, 0, 0);
  self playerlinkedsetviewznear(0);
  self visionsetfadetoblackforplayer("bw", 0.25);
  self visionsetkillstreakforplayer("");
  self visionsetnakedforplayer("tac_ops_slamzoom", 0.25);
  self setclientomnvar("ui_cluster_controls", 0);
  var_3 setscriptablepartstate("target", "off", 0);
  var_4 moveTo(var_2.origin, 0.25);
  var_4 rotateTo(var_2.angles, 0.25);
  var_4 waittill("rotatedone");
  scripts\mp\utility\player::restorebasevisionset(0.2);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
  self setclientomnvar("ui_cluster_controls", 1);
  self visionsetfadetoblackforplayer("", 0);
  self visionsetkillstreakforplayer("proto_toma_strike_mp");
  scripts\mp\utility\player::restorebasevisionset(0);
  var_3 setscriptablepartstate("target", "guide", 0);
  self playerlinkweaponviewtodelta(var_2, "tag_player", 1, 45, 45, 20, 70, 0);
  self.currentclustercamera = var_2;
  var_4 delete();
}

function tomastrike_watchreturnplayer(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  self waittill("tomaStrike_returnPlayer", var_4);
  tomastrike_returnplayer(var_0, var_1, var_4, var_2, var_3);
}

function tomastrike_watchlasertarget(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  self endon("stop_marker_guide");

  if(isDefined(var_2)) {
    var_2 endon("death");
    var_2 endon("leaving");
  }

  level endon("game_ended");
  self notifyonplayercommand("drone_target_start", "+attack");

  for(;;) {
    self waittill("drone_target_start");

    if(self.clusterammoleft == 0) {
      continue;
    }

    var_4 = spawn("script_model", self.origin);
    var_4 setModel("ks_toma_strike_marker_mp");
    var_4 setotherent(self);
    var_4.owner = self;
    thread tomastrike_startlasertarget(var_0, var_2, var_1, var_4, var_3);

    if(var_0 == 2) {
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
    }
  }
}

function tomastrike_watchammousage(var_0, var_1, var_2) {
  self endon("disconnect");
  self endon("stop_marker_guide");
  var_3 = 1;

  if(isDefined(var_1)) {
    var_1 endon("death");
    var_1 endon("leaving");
    var_3 = 0;
  }

  for(;;) {
    self waittill("ammo_used");
    self.clusterammoleft--;
    self setclientomnvar("ui_cluster_missiles_left", self.clusterammoleft);

    if(self.clusterammoleft == 0 && istrue(var_2)) {
      var_0 setscriptablepartstate("target", "off", 0);
      self setclientomnvar("ui_cluster_controls", 2);
      wait 5;
      var_0 setscriptablepartstate("target", "guide", 0);
      self.clusterammoleft = 3;
      self setclientomnvar("ui_cluster_controls", 1);
      self setclientomnvar("ui_cluster_missiles_left", self.clusterammoleft);
      continue;
    }

    self setclientomnvar("ui_cluster_missiles_left", self.clusterammoleft);

    if(self.clusterammoleft == 0) {
      self notify("tomaStrike_returnPlayer", var_3);

      if(isDefined(var_0)) {
        var_0 delete();
      }

      self notify("stop_marker_guide");
      break;
    }
  }
}

function tomastrike_movetargetguide(var_0, var_1) {
  self endon("disconnect");
  self endon("stop_marker_guide");

  if(isDefined(var_1)) {
    var_1 endon("death");
    var_1 endon("leaving");
  }

  var_0 setscriptablepartstate("target", "guide", 0);

  for(;;) {
    var_2 = tomastrike_getownerlookat(self);
    var_0.origin = var_2;
    waitframe();
  }
}

function tomastrike_getownerlookat(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "aim_override")) {
    return var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "aim_override")]]();
  }

  var_1 = ["physicscontents_solid", "physicscontents_water", "physicscontents_sky", "physicscontents_glass", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_ainosight", "physicscontents_vehicleclip"];
  var_2 = physics_createcontents(var_1);
  var_3 = var_0 getvieworigin();
  var_4 = var_3 + anglesToForward(var_0 getplayerangles()) * 50000;
  var_5 = var_0 scripts\cp_mp\utility\killstreak_utility::ref_125f8();
  var_6 = scripts\engine\trace::ray_trace(var_3, var_4, var_5, var_2);
  var_7 = undefined;

  if(isDefined(var_6["hittype"]) && var_6["hittype"] != "hittype_none") {
    var_7 = var_6["position"];
  }

  return var_7;
}

function tomastrike_watchlaserrelease(var_0) {
  var_1 = self.owner;
  var_1 endon("disconnect");
  var_1 endon("drone_target_placed");
  self endon("death");
  level endon("game_ended");
  thread tomastrike_watchdronedeath();
  var_1 waittill("drone_target_release");
  var_1 notify("drone_target_cancel");
  var_0 setscriptablepartstate("target", "off", 0);
}

function tomastrike_watchdronedeath() {
  var_0 = self.owner;
  var_0 endon("disconnect");
  var_0 endon("drone_target_release");
  self waittill("death");
  var_0 notify("toma_strike_end");
  var_0 notify("drone_target_cancel");
}

function tomastrike_startlasertarget(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  var_3.origin = var_2.origin;
  var_3 setscriptablepartstate("target", "placed", 0);

  if(var_0 == 1) {
    thread delayscriptablechangethread(var_3);
  } else {
    thread delayscriptablechangethread(var_3);
  }

  self playlocalsound("weap_cluster_target_beep");
  self notify("ammo_used");

  if(isDefined(self)) {
    thread tomastrike_attacktarget(var_0, var_1, var_3, var_4);
    return;
  }
}

function tomastrike_attacktarget(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("drone_target_placed");
  var_3.shots_fired++;
  var_4 = undefined;
  var_5 = undefined;

  if(var_0 == 0 || var_0 == 2) {
    var_4 = var_1.origin - (0, 0, 10) + anglesToForward(var_1.angles) * 20;
    var_5 = var_1.angles;
  } else if(var_0 == 1) {
    var_4 = self.currentclustercamera.origin - (0, 0, 3000);
    var_5 = anglestoright(self.currentclustercamera.angles);
  } else {
    var_4 = self.origin + (0, 0, 5000);

    if(!istrue(var_3.vehicle_process_node_when_at_goal)) {
      var_4 -= anglesToForward(self.angles) * 5000;
    }

    var_5 = anglestoright(self.angles);
  }

  var_6 = undefined;

  if(isDefined(var_2)) {
    if(isvector(var_2)) {
      var_6 = var_2;
    } else {
      var_6 = var_2.origin;
    }
  } else {
    if(var_0 == 5 && isDefined(var_3.ref_13a81)) {
      var_6 = var_3.ref_13a81;
    } else {
      var_6 = tomastrike_getownerlookat(self);
    }

    if(!istrue(var_3.ref_11eae)) {
      var_2 = spawn("script_model", var_6);
      var_2 setModel("ks_toma_strike_marker_mp");

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "requestObjectiveID")) {
        var_2.objidnum = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "requestObjectiveID")]](99);
      }

      var_7 = scripts\cp_mp\utility\script_utility::ref_140de("game", "isGameTypeBR", 0);

      if(var_7) {
        var_2.icon = "icon_waypoint_clusterstrike_ww2";
      } else {
        var_2.icon = "icon_waypoint_clusterstrike";
      }

      if(isPlayer(self)) {
        var_2 setotherent(self);
      }

      if(!istrue(var_3.ref_133dc)) {
        toma_strike_setmarkerobjective(var_2, var_2.objidnum, var_2.icon, self, 50);
      }

      thread toma_strike_handlemarkerscriptable();
    }
  }

  var_8 = 6;
  var_9 = 300;

  if(var_0 == 5) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br", "challengeEvaluator")) {
      var_10 = spawnStruct();
      var_10.streakinfo = var_3;
      var_10.ref_13a8a = var_6;
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br", "challengeEvaluator")]]("br_mastery_pointBlank_tomahawk", var_10);
    }

    var_8 = 6;

    if(isDefined(var_3.ref_11f47)) {
      var_8 = var_3.ref_11f47;
    }

    var_9 = 900;

    if(isDefined(var_3.ref_129e3)) {
      var_9 = var_3.ref_129e3;
    }

    var_11 = var_9;

    if(isDefined(var_3.ref_11ece)) {
      var_11 = var_3.ref_11ece;
    }

    if(!istrue(var_3.ref_133c9) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "dangerNotifyPlayersInRange")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "dangerNotifyPlayersInRange")]](var_6, var_11 + 300, var_3.streakname);
    }
  }

  if(var_0 == 0 || var_0 == 2) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.3);
    var_4 = var_1.origin - (0, 0, 10) + anglesToForward(var_1.angles) * 20;
    var_12 = var_6;
    var_13 = spawnStruct();
    var_13.sourcepos = var_4;
    var_13.goalpos = var_12;
    var_13.initvelocity = var_13.goalpos - var_13.sourcepos;
    thread tomastrike_firestrike(var_13, var_3, var_1);
    return;
  }

  if(var_0 == 1 || var_0 == 3 || var_0 == 4 || var_0 == 5) {
    var_14 = 2;

    if(isDefined(var_3.ref_121af)) {
      var_15 = var_3.ref_121af;
    } else {
      var_15 = anglesToForward(self getplayerangles());
    }

    var_16 = anglesToForward(self.angles);
    var_17 = anglestoright(self.angles);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_15);

    for(var_19 = 0; var_19 < var_9; var_19++) {
      var_20 = undefined;

      if(istrue(var_4.vehicle_process_node_when_at_goal)) {
        var_20 = var_5;
      }

      var_13 = findunobstructedfiringinfo(var_8, var_14, var_15, var_16, var_17, var_20);
      thread tomastrike_firestrike(var_13, var_4);
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(randomfloatrange(1.35, 2.5));
    }

    level.toma_strikes = scripts\engine\utility::array_remove(level.toma_strikes, self);
    return;
  }
}

function findunobstructedfiringinfo(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();

  if(isDefined(var_5)) {
    var_7 = var_5;
  } else {
    var_7 = ref_13bd5(var_1, var_3, var_4, var_5);
  }

  var_8 = vectorNormalize(var_1 - (var_7[0], var_7[1], 0));
  var_9 = ref_13bd6(var_1, var_2, var_8);
  var_10 = (0, 0, -1 * getdvarint("NPOQPMP", 800));
  var_11 = (var_9.point - 0.5 * var_10 * squared(4) - var_7) / 4;
  var_13 = var_7 + var_11 * 3.925 + 0.5 * var_10 * squared(3.925);
  var_7.sourcepos = var_7;
  var_7.num_of_frame_frozen = var_9.num_of_frame_frozen;
  var_7.num_of_subway_cars = var_9.num_of_subway_cars;
  var_7.goalpos = var_9.point;
  var_7.preexplpos = var_13;
  var_7.initvelocity = var_11;
  return var_7;
}

function delayscriptablechangethread(var_0) {
  self.owner endon("disconnect");
  self endon("death");
  self.owner scripts\engine\utility::ref_143b9(var_0, "stop_marker_guide");
  self setscriptablepartstate("target", "off", 0);
  self delete();
}

function tomastrike_screeninterference(var_0, var_1) {
  var_2 = self.owner;
  var_2 endon("disconnect");

  if(isDefined(var_2)) {
    var_2 visionsetthermalforplayer(var_1);

    if(isDefined(var_0)) {
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
      var_2 visionsetthermalforplayer(self.currentvisionset);
      return;
    }

    return;
  }
}

function ref_13bd6(var_0, var_1, var_2) {
  var_3 = randomint(var_1);
  var_4 = randomint(360);
  var_5 = var_0[0] + var_3 * cos(var_4);
  var_6 = var_0[1] + var_3 * sin(var_4);
  var_7 = var_0[2];
  var_8 = (var_5, var_6, var_7);

  if(isDefined(var_2)) {
    var_8 -= var_2 * 100;
  }

  var_9 = 10000;

  if(isDefined(level.ref_13bd3)) {
    var_9 = level.ref_13bd3;
  }

  var_10 = spawnStruct();
  var_11 = scripts\engine\trace::create_default_contents(1);
  var_12 = scripts\engine\trace::ray_trace(var_8 + (0, 0, var_9), var_8 - (0, 0, var_9), undefined, var_11);

  if(isDefined(var_12["entity"])) {
    var_13 = var_12["entity"];
    var_10.num_of_frame_frozen = var_13;

    if(ref_13bd8(var_13) || ref_13bd7(var_13)) {
      var_10.num_of_subway_cars = "flying";
    }
  }

  if(isDefined(var_12["position"])) {
    var_8 = var_12["position"];
  }

  var_10.point = var_8;
  return var_10;
}

function ref_13bd8(var_0) {
  return var_0 scripts\cp_mp\vehicles\vehicle::isvehicle() && istrue(var_0 scripts\cp_mp\vehicles\vehicle::vehiclecanfly());
}

function ref_13bd7(var_0) {
  return isDefined(var_0.streakinfo) && isDefined(var_0.sentientpool) && var_0.sentientpool == "Killstreak_Air";
}

function tomastrike_firestrike(var_0, var_1, var_2) {
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(var_2)) {
    self earthquakeforplayer(0.35, 1, var_2.origin, 1000);
    self playlocalsound("weap_cluster_fire");
  }

  var_3 = isPlayer(self) || isagent(self);

  if(var_3) {
    var_4 = magicgrenademanual("toma_proj_mp", var_0.sourcepos, var_0.initvelocity, 5, self);
    var_4 setmissileminimapvisible(1);
    var_4 setentityowner(self);
    var_4 setotherent(self);
  } else {
    var_4 = magicgrenademanual("toma_proj_mp", var_1.sourcepos, var_1.initvelocity, 5);
    var_4 setmissileminimapvisible(1);
  }

  var_4 setscriptablepartstate("launch", "active", 0);
  var_4 setscriptablepartstate("trail", "active", 0);

  if(isDefined(var_2.ref_121a9)) {
    var_5 = var_2.ref_121a9;
  } else {
    var_5 = "ks_toma_strike_missile_mp";
  }

  var_5.explodeent = spawn("script_model", var_5.origin);
  var_5.explodeent setModel(var_5);
  var_5.explodeent linkTo(var_5);
  var_5.explodeent dontinterpolate();

  if(var_4) {
    var_5.explodeent setentityowner(self);
  }

  var_6 = spawn("script_model", var_2.sourcepos);
  var_6 linkTo(var_5, "tag_origin", (10, 0, 10), (0, 0, 0));
  var_5.killcament = var_6;
  var_5.owner = self;
  var_5.streakinfo = var_3;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var_2.goalpos, 512, 300, self.team, 6, self, 1);
  }

  thread ref_13bd4();
  thread toma_strike_watch_airexplosion(var_5, var_2.preexplpos, var_2.num_of_frame_frozen);
  thread toma_strike_watch_stuck(var_5, vectortoangles(var_2.initvelocity), gettime());
}

function tomastrike_getmissileendpos(var_0) {
  var_1 = var_0;

  foreach(var_3 in level.players) {
    if(level.teambased && var_3.team == self.team) {
      continue;
    } else if(!level.teambased && var_3 == self) {
      continue;
    }

    if(!var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(istrue(var_3.markedfortoma)) {
      continue;
    }

    if(distancesquared(var_0, var_3.origin) > 250000) {
      continue;
    }

    var_3.markedfortoma = 1;
    var_1 = var_3.origin;
    thread clearmarkonrespawn();
    break;
  }

  return var_1;
}

function clearmarkonrespawn() {
  self endon("disconnect");
  scripts\engine\utility::ref_143b9(10, "death");
  self.markedfortoma = undefined;
}

function tomastrike_returnplayer(var_0, var_1, var_2, var_3, var_4) {
  scripts\common\utility::allow_fire(1);
  scripts\common\utility::allow_weapon_switch(1);
  scripts\common\utility::allow_crouch(1);
  scripts\common\utility::allow_prone(1);
  scripts\common\utility::allow_usability(1);
  scripts\common\utility::allow_killstreaks(1);
  self clearclienttriggeraudiozone(1);

  if(var_1 == 1) {
    scripts\cp_mp\utility\player_utility::_freezecontrols(0, undefined, "tomaStrike");
  }

  if(!istrue(var_2)) {
    if(var_1 == 0) {
      self remotecontrolvehicleoff();
      self cameraunlink();
      self setplayerangles(self.restoreangles);
      self.restoreangles = undefined;
    } else if(var_1 == 2) {
      self unlink();
    }
  } else {
    self unlink();
    self setplayerangles(self.restoreangles);
    self.restoreangles = undefined;
  }

  self setclientomnvar("ui_cluster_controls", 0);
  self setclientomnvar("ui_cluster_missiles_left", 0);
  self visionsetkillstreakforplayer("", 0);
  self visionsetfadetoblackforplayer("", 0);
  scripts\mp\utility\player::restorebasevisionset(0);
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var_3);
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var_4);
  var_0 notify("killstreak_finished_with_deploy_weapon");
}

function tomastrike_explode(var_0, var_1, var_2, var_3) {
  self playSound("weap_hellfire_impact");

  if(isDefined(self.playersfx)) {
    self.playersfx stoploopsound();
    self.playersfx delete();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "grenade_earthQuakeAtPosition")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "grenade_earthQuakeAtPosition")]](var_1, 1.2);
  }

  level.toma_strikes = scripts\engine\utility::array_remove(level.toma_strikes, self);

  if(isDefined(self.turret)) {
    self.turret delete();
  }

  if(isDefined(self.camera)) {
    self.camera delete();
  }

  if(isDefined(self.cloudsfx)) {
    self.cloudsfx delete();
  }

  if(isDefined(var_3)) {
    var_3 delete();
  }

  self delete();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    return;
  }
}

function toma_strike_missile_explode(var_0) {
  self endon("death");
  self.exploding = 1;
  self.explodeent unlink();
  self.explodeent.origin = var_0;
  self.explodeent setscriptablepartstate("explode", "active", 0);
  thread toma_strike_delay_hide();
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);

  if(isDefined(self.explodeent)) {
    self.explodeent delete();
  }

  self delete();
}

function toma_strike_delay_hide() {
  self endon("death");
  wait 0.05;
  self setscriptablepartstate("trail", "neutral", 0);
  self hide();
}

function ref_13bd4() {
  self endon("death");
  var_0 = self.owner;
  var_0 waittill("disconnect");

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  self setmissileminimapvisible(0);
  thread toma_strike_missile_explode(self.origin);
  self notify("missile_dest_failed");
}

function toma_strike_watch_airexplosion(var_0, var_1, var_2) {
  self endon("death");
  self endon("missile_dest_failed");
  thread toma_strike_move_killcam(self.killcament, 3.675);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.925);
  self setmissileminimapvisible(0);
  thread toma_strike_missile_explode(var_0);

  if(isDefined(var_1) && isDefined(var_2) && var_2 == "flying") {
    var_3 = self.owner;

    if(!isPlayer(var_3)) {
      var_3 = self;
    }

    var_1 dodamage(500, var_0, var_3, self, "MOD_EXPLOSIVE", getcompleteweaponname("toma_proj_mp"));
    return;
  }
}

function toma_strike_move_killcam(var_0, var_1) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self unlink();
  self moveTo(var_1, 3);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(7);
  self delete();
}

function toma_strike_watch_stuck(var_0, var_1, var_2) {
  self endon("death");
  self endon("missile_dest_failed");
  self waittill("missile_stuck", var_3);
  self setmissileminimapvisible(0);

  if(gettime() - var_1 < 3925) {
    thread toma_strike_missile_explode(self.origin);
    self notify("missile_dest_failed");
    return;
  }

  wait 0.05;
  var_4 = -1 * getdvarint("NPOQPMP", 800);
  var_5 = (gettime() - var_1) / 1000;
  var_6 = var_2 + (0, 0, var_4 * var_5);

  if(isDefined(var_3) && isPlayer(var_3)) {
    toma_strike_stuck_player(self, var_3, var_0, var_6);
    return;
  }

  toma_strike_stuck(var_3, var_0, var_6);
}

function toma_strike_stuck(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = vectorNormalize(var_2);
  var_5 = anglestoup(self.angles);
  var_6 = anglestoright(var_1);

  if(abs(vectordot(var_4, var_5)) >= 0.9848) {
    var_3 = toma_strike_rebuild_angles_up_right(var_5, var_6);
  } else {
    var_3 = toma_strike_rebuild_angles_up_forward(var_5, var_4);
  }

  self.angles = var_3;
  thread toma_strike_launch_cluster(self, self.origin, var_3, var_0, gettime());
}

function toma_strike_stuck_player(var_0, var_1, var_2, var_3) {
  var_3 *= (0, 0, 1);
  var_4 = var_0.origin;
  var_5 = (0, 0, -1);
  var_6 = var_4 + var_5 * 128;
  var_7 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle"]);
  var_8 = physics_raycast(var_4, var_6, var_7, var_0, 0, "physicsquery_closest", 1);

  if(isDefined(var_8) && var_8.size > 0) {
    var_6 = var_8[0]["position"];
    var_9 = var_8[0]["normal"];
    var_10 = var_8[0]["entity"];
    var_6 -= var_9 * 1;
    var_11 = -1 * getdvarint("NPOQPMP", 800);
    var_12 = vectordot(var_6 - var_4, var_5);
    var_13 = sqrt(2 * var_12 / -1 * var_11);
    var_14 = var_9;
    var_15 = anglestoright(var_2);
    var_16 = toma_strike_rebuild_angles_up_right(var_14, var_15);
    thread toma_strike_launch_cluster(var_0, var_6, var_16, var_10, gettime() + var_13 * 1000);
    return;
  }
}

function toma_strike_launch_cluster(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0.owner;
  var_6 = var_0.killcament;
  var_7 = anglestoup(var_2);
  var_8 = var_1 + var_7 * 1;
  var_9 = var_8 + var_7 * 25;
  var_10 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle"]);
  var_11 = physics_raycast(var_8, var_9, var_10, var_0, 0, "physicsquery_closest", 1);

  if(isDefined(var_11) && var_11.size > 0) {
    var_9 = var_11[0]["position"] - var_7 * 1;
  }

  var_12 = var_9;
  var_13 = toma_strike_get_shared_data(var_5, var_0.streakinfo, var_4, var_6);
  var_14 = toma_strike_get_cast_data();
  var_15 = toma_strike_create_branch(var_13, var_14, undefined, var_12, var_2, var_3, 0, undefined, undefined);
  var_13.branches[var_13.branches.size] = var_15;
  var_15.killcament = var_6;
  var_16 = anglesToForward(var_2);
  var_17 = anglestoright(var_2);
  var_18 = anglestoup(var_2);
  var_19 = rotatepointaroundvector(var_18, var_16, 30);
  var_20 = vectorNormalize(vectorcross(var_19, var_18));
  var_21 = vectorcross(var_20, var_16);
  var_22 = axistoangles(var_19, var_20, var_21);
  var_14 = toma_strike_get_cast_data();
  var_15 = toma_strike_create_branch(var_13, var_14, undefined, var_12, var_22, var_3, 0, undefined, undefined);
  var_15.killcament = var_6;
  var_13.branches[var_13.branches.size] = var_15;
  var_19 = rotatepointaroundvector(var_18, var_16, -30);
  var_20 = vectorNormalize(vectorcross(var_19, var_18));
  var_21 = vectorcross(var_20, var_16);
  var_22 = axistoangles(var_19, var_20, var_21);
  var_14 = toma_strike_get_cast_data();
  var_15 = toma_strike_create_branch(var_13, var_14, undefined, var_12, var_22, var_3, 0, undefined, undefined);
  var_15.killcament = var_6;
  var_13.branches[var_13.branches.size] = var_15;
  toma_strike_shared_data_register_cast(var_13);

  foreach(var_15 in var_13.branches) {
    thread toma_strike_start_branch();
  }
}

function toma_strike_start_branch() {
  var_0 = self.killcament;

  if(!isDefined(self.preventstarttime)) {
    self.preventstarttime = gettime();
  }

  if(!isDefined(self.startingcasttype)) {
    if(!toma_strike_shared_data_is_complete(self.shareddata)) {
      var_1 = toma_strike_branch_create_explosion(self.startingorigin, self.startingangles, self.startingstuckto, self.shareddata.streakinfo);
      var_1.killcament = var_0;
      thread toma_strike_start_explosion();
      self.iscomplete = 1;
      toma_strike_shared_data_is_complete(self.shareddata, 1);
      return;
    }

    return;
  }

  self.caststart = self.startingorigin;
  self.castend = undefined;
  self.castangles = self.startingangles;
  self.castdir = undefined;
  self.casttype = self.startingcasttype;
  self.startingorigin = undefined;
  self.startingangles = undefined;
  self.startingcasttype = undefined;

  for(;;) {
    if(toma_strike_shared_data_is_complete(self.shareddata)) {
      break;
    }

    if(toma_strike_branch_is_complete()) {
      break;
    }

    if(!toma_strike_shared_data_can_cast_this_frame(self.shareddata)) {
      waitframe();
      continue;
    }

    if(self.casttype == 0) {
      var_2 = self.castdata.firstforwardmodanglesfunc;

      if(isDefined(var_2)) {
        self.castangles = [[var_2]](self.castangles);
        self.castdata.firstforwardmodanglesfunc = undefined;
      }
    }

    self.castdir = toma_strike_get_cast_dir(self.castangles, self.casttype);
    self.castend = self.caststart + self.castdir * toma_strike_get_cast_dist(self.casttype, self.castdata);
    var_3 = undefined;
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;
    var_7 = undefined;
    var_8 = physics_raycast(self.caststart, self.castend, self.shareddata.castcontents, undefined, 0, "physicsquery_closest", 1);

    if(isDefined(var_8) && var_8.size > 0) {
      var_3 = 1;
      var_4 = var_8[0]["position"];
      var_5 = var_8[0]["normal"];
      var_6 = var_8[0]["entity"];
    }

    switch (self.casttype) {
      case 0:
        if(istrue(var_3)) {
          toma_strike_branch_register_cast(self.casttype, 0, var_4);
          var_9 = 1;

          if(isDefined(self.castdata.firstforwarddist)) {
            var_10 = var_4 - self.caststart;
            var_11 = vectordot(var_10, self.castdir);
            self.castdata.firstforwarddist -= var_11;

            if(self.castdata.firstforwarddist > self.castdata.firstforwardmindist) {
              var_9 = 0;
            } else {
              self.castdata.firstforwarddist = undefined;
            }
          }

          var_7 = toma_strike_rebuild_angles_up_right(var_5, anglestoright(self.castangles));

          if(var_9) {
            var_1 = toma_strike_branch_create_explosion(var_4, var_7, var_6, self.shareddata.streakinfo);
            var_1.killcament = var_1;
            thread toma_strike_start_explosion();
          }

          self.casttype = 2;
          self.caststart = var_4 + var_5 * 1;
          self.castangles = var_7;
        } else {
          toma_strike_branch_register_cast(self.casttype, undefined, undefined);

          if(isDefined(self.castdata.firstforwarddist)) {
            var_10 = self.castend - self.caststart;
            var_11 = vectordot(var_10, self.castdir);
            self.castdata.firstforwarddist -= var_11;

            if(self.castdata.firstforwarddist <= self.castdata.firstforwardmindist) {
              self.castdata.firstforwarddist = undefined;
            }
          }

          self.casttype = 1;
          self.caststart = self.castend;
        }

        break;
      case 1:
        if(istrue(var_3)) {
          var_7 = toma_strike_rebuild_angles_up_right(var_5, anglestoright(self.castangles));
          var_1 = toma_strike_branch_create_explosion(var_4, var_7, var_6, self.shareddata.streakinfo);
          var_1.killcament = var_1;
          thread toma_strike_start_explosion();
          var_12 = vectordot(anglestoup(self.castangles), var_5);

          if(var_12 < 0.9848) {
            toma_strike_branch_register_cast(self.casttype, 2, var_4);
            self.casttype = 2;
            self.caststart = var_4 + var_5 * 1;
            self.castangles = var_7;
          } else {
            toma_strike_branch_register_cast(self.casttype, 1, var_4);
            self.casttype = 0;
          }
        } else {
          toma_strike_branch_register_cast(self.casttype, undefined, undefined);
          self.caststart = self.castend;
        }

        break;
      case 2:
        if(istrue(var_3)) {
          toma_strike_branch_register_cast(self.casttype, 3, var_4);
          self.casttype = 0;
          self.caststart = var_4 + var_5 * 1;
        } else {
          toma_strike_branch_register_cast(self.casttype, undefined, undefined);
          self.casttype = 0;
        }

        break;
    }

    waittillframeend();
  }

  self.iscomplete = 1;
  toma_strike_shared_data_is_complete(self.shareddata, 1);
  self.shareddata.branches = [];
}

function toma_strike_branch_create_explosion(var_0, var_1, var_2, var_3) {
  var_4 = 50;

  if(true) {
    var_4 = randomintrange(50, 350);
  }

  var_5 = self.preventstarttime + var_4;
  var_6 = toma_strike_create_explosion(var_0 + anglestoup(var_1), var_1, var_2, self.shareddata.owner, var_5, var_3);
  self.preventstarttime = var_5;
  self.ents[self.ents.size] = var_6;
  toma_strike_shared_data_register_ent(self.shareddata);
  return var_6;
}

function toma_strike_create_explosion(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawn("script_model", var_0);
  var_6.angles = var_1;
  var_6.stuckto = var_2;
  var_6.owner = var_3;
  var_6.starttime = var_4;
  var_6.streakinfo = var_5;

  if(isDefined(var_5.ref_121a8)) {
    var_7 = var_5.ref_121a8;
  } else {
    var_7 = "ks_toma_strike_cluster_mp";
  }

  var_7 setModel(var_7);

  if(isPlayer(var_4)) {
    var_7 setotherent(var_4);
    var_7 setentityowner(var_4);
  }

  if(isDefined(var_3)) {
    var_7 linkTo(var_3);
  }

  return var_7;
}

function toma_strike_start_explosion() {
  self endon("death");
  self.owner endon("disconnect");
  self.owner endon("joined_team");

  if(isDefined(self.stuckto)) {
    self.stuckto endon("death");
  }

  while(gettime() < self.starttime) {
    waitframe();
  }

  thread toma_strike_explosion_end();
}

function toma_strike_explosion_end() {
  self setscriptablepartstate("explode", "active", 0);
  wait 1;
  self delete();
}

function toma_strike_shared_data_register_cast() {
  self.caststotal++;
  self.caststhisframe++;
  self.frametimestamp = gettime();
}

function toma_strike_shared_data_register_ent() {
  self.entstotal++;
}

function toma_strike_shared_data_can_cast_this_frame() {
  if(self.frametimestamp < gettime()) {
    self.frametimestamp = gettime();
    self.caststhisframe = 0;
  }

  return self.caststhisframe < 3;
}

function toma_strike_shared_data_is_complete(var_0) {
  var_1 = 0;

  if(self.caststotal >= 60) {
    var_1 = 1;
  } else if(self.entstotal >= 20) {
    var_1 = 1;
  } else if(istrue(var_0)) {
    var_2 = 1;

    foreach(var_4 in self.branches) {
      if(!toma_strike_branch_is_complete(var_4)) {
        var_2 = 0;
        break;
      }
    }

    if(var_2) {
      var_1 = 1;
    }
  }

  if(var_1) {
    self.iscomplete = 1;
  }

  return var_1;
}

function toma_strike_branch_register_cast(var_0, var_1, var_2) {
  toma_strike_shared_data_register_cast(self.shareddata);
  self.casts++;

  if(isDefined(var_1)) {
    if(var_1 == 0 || var_1 == 1 || var_1 == 2) {
      self.castfails = 0;
      return;
    }

    return;
  }

  if(var_0 == 1) {
    self.castfails++;
    return;
  }
}

function toma_strike_branch_is_complete(var_0) {
  var_1 = 0;
  var_2 = undefined;

  if(toma_strike_shared_data_is_complete(self.shareddata)) {
    var_1 = 1;
  } else if(isDefined(self.castdata) && self.castfails >= self.castdata.maxfails) {
    var_1 = 1;
  } else if(isDefined(self.castdata) && self.casts >= self.castdata.maxcasts) {
    var_1 = 1;
  } else if(isDefined(self.castdata) && self.ents.size >= self.castdata.maxents) {
    var_1 = 1;
  } else if(istrue(var_0)) {
    var_2 = 1;

    foreach(var_4 in self.branches) {
      if(!toma_strike_branch_is_complete(var_4)) {
        var_2 = 0;
        break;
      }
    }

    if(var_2) {
      var_1 = 1;
    }
  }

  if(var_1 && !istrue(self.iscomplete)) {
    var_6 = self.oncompletedfunc;

    if(isDefined(var_6)) {
      self[[var_6]]();
    }

    if(istrue(var_2)) {
      var_1 = 0;

      foreach(var_4 in self.branches) {
        if(!toma_strike_branch_is_complete(var_4)) {
          var_2 = 0;
          break;
        }
      }

      if(var_2) {
        var_1 = 1;
      }
    }
  }

  if(var_1) {
    self.iscomplete = 1;
  }

  return var_1;
}

function toma_strike_create_branch(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = spawnStruct();
  var_9.shareddata = var_0;
  var_9.castdata = var_1;
  var_9.startingorigin = var_3;
  var_9.startingangles = var_4;
  var_9.startingstuckto = var_5;
  var_9.startingcasttype = var_6;
  var_9.oncompletedfunc = var_8;
  var_9.ents = [];
  var_9.branches = [];
  var_9.hitpositions = [];
  var_9.hittypes = [];
  var_9.casts = 0;
  var_9.castfails = 0;
  var_9.preventstarttime = var_7;
  return var_9;
}

function toma_strike_get_shared_data(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.owner = var_0;
  var_4.team = var_0.team;
  var_4.streakinfo = var_1;
  var_4.impacttime = var_2;
  var_4.branches = [];
  var_4.entstotal = 0;
  var_4.caststotal = 0;
  var_4.caststhisframe = 0;
  var_4.frametimestamp = gettime();
  var_4.castcontents = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle"]);
  return var_4;
}

function toma_strike_get_cast_data() {
  var_0 = spawnStruct();
  var_0.distforward = 125;
  var_0.distdown = 50;
  var_0.distup = 25;
  var_0.maxcasts = 12;
  var_0.maxfails = 3;
  var_0.maxents = 4;
  return var_0;
}

function toma_strike_get_cast_dir(var_0, var_1) {
  switch (var_1) {
    case 0:
      return anglesToForward(var_0);
    case 1:
      return (-1 * anglestoup(var_0));
    case 2:
      return anglestoup(var_0);
  }

  return undefined;
}

function toma_strike_get_cast_dist(var_0, var_1) {
  switch (var_0) {
    case 0:
      if(isDefined(var_1.firstforwarddist)) {
        return var_1.firstforwarddist;
      } else {
        return var_1.distforward;
      }
    case 1:
      return var_1.distdown;
    case 2:
      return var_1.distup;
  }

  return undefined;
}

function toma_strike_rebuild_angles_up_right(var_0, var_1) {
  var_2 = vectorNormalize(vectorcross(var_0, var_1));
  var_1 = vectorcross(var_2, var_0);
  return axistoangles(var_2, var_1, var_0);
}

function toma_strike_rebuild_angles_up_forward(var_0, var_1) {
  var_2 = vectorNormalize(vectorcross(var_1, var_0));
  var_1 = vectorcross(var_0, var_2);
  return axistoangles(var_1, var_2, var_0);
}

function tomastrike_isremotevehicletype(var_0) {
  var_1 = 0;

  switch (var_0) {
    case 2:
    case 1:
    case 0:
      var_1 = 1;
      break;
  }

  return var_1;
}

function tomastrike_ismarkertype(var_0) {
  var_1 = 0;

  switch (var_0) {
    case 4:
    case 3:
      var_1 = 1;
      break;
  }

  return var_1;
}

function toma_strike_setmarkerobjective(var_0, var_1, var_2, var_3) {
  objective_icon(var_0, var_1);
  objective_showtoplayersinmask(var_0);

  if(isPlayer(var_2)) {
    objective_addclienttomask(var_0, var_2);
  }

  objective_onentity(var_0, self);
  objective_setzoffset(var_0, var_3);
  objective_setplayintro(var_0, 0);
  objective_setplayoutro(var_0, 0);
  objective_setbackground(var_0, 1);

  if(level.teambased || !isPlayer(var_2)) {
    objective_setownerteam(var_0, var_2.team);
  } else {
    objective_setownerclient(var_0, var_2);
  }

  objective_state(var_0, "current");
}

function toma_strike_handlemarkerscriptable() {
  self endon("death");
  self setscriptablepartstate("target", "on", 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(10);

  if(isDefined(self)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self.objidnum);
    }

    self delete();
    return;
  }
}

function ref_13bd5(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\trace::create_default_contents(1);
  var_5 = scripts\engine\trace::ray_trace(var_0 - var_1 * 30, var_0 + var_1 * 1000, undefined, var_4);
  var_6 = var_5["position"] + var_5["normal"] * 20;
  var_7 = var_6;
  var_8 = 5000;
  var_9 = 5000;
  var_10 = [var_7 + var_2 * 100, var_7 - var_2 * 100, var_7 + var_3 * 100, var_7 - var_3 * 100, var_7 + (var_2 + var_3) * 100, var_7 + (var_2 - var_3) * 100, var_7 + (var_3 - var_2) * 100, var_7 + (-1 * var_2 - var_3) * 100];
  var_11 = var_7 + (0, 0, var_8 * 1.5);

  foreach(var_13 in var_10) {
    var_14 = vectorNormalize(var_13 - var_7);
    var_15 = var_7 + (0, 0, var_8) - var_14 * var_9;
    var_16 = var_7;
    var_17 = scripts\engine\trace::ray_trace_passed(var_15, var_16, undefined, var_4);

    if(!istrue(var_17)) {
      wait 0.05;
      continue;
    }

    var_11 = var_15;
    break;
  }

  return var_11;
}

function ref_13bd9(var_0) {
  self endon("cluster_strike_finished");
  self endon("disconnect");
  level waittill("game_ended");
  scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var_0);
}