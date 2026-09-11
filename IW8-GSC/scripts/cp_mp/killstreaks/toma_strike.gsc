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

function trytomastriketriggered(var0) {
  var1 = var0.streakname;
  var2 = getdvarint("scr_toma_strike_type", 3);
  return true;
}

function weapondetonatedtomastrike(var0, var1, var2) {
  level endon("game_ended");
  var3 = getdvarint("scr_toma_strike_type", 3);
  thread tomastrike_attacktarget(var2, var3, undefined, var1);
}

function weapongiventomastrike(var0) {
  if(isDefined(level.toma_strikes) && level.toma_strikes.size >= 2) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    var0 notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  return true;
}

function weaponswitchendedtomastrike(var0, var1) {
  var2 = getdvarint("scr_toma_strike_type", 3);

  if(scripts\cp_mp\utility\game_utility::ref_140a9()) {
    thread scripts\cp_mp\killstreaks\airstrike::airstrike_watchforads(var0);
    return;
  }
}

function weaponfiredtomastrike(var0, var1, var2) {
  if(!isDefined(var0.ref_13a81)) {
    var3 = tomastrike_getownerlookat(self);

    if(!isDefined(var3)) {
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

  var4 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var0.streakname);
    var4 = 2;
  }

  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var0.streakname, 1, var4);
  return "success";
}

function tryusetomastrike() {
  var0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("toma_strike", self);
  return tryusetomastrikefromstruct(var0);
}

function tryusetomastrikefromstruct(var0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var0)) {
      return 0;
    }
  }

  var1 = getdvarint("scr_toma_strike_type", 3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();

    if(var2 == "br") {
      var1 = 5;
    }
  }

  if(var1 == 4) {
    var3 = scripts\mp\killstreaks\throwback_marker::throwbackmarker_trythrowbackmarker(var0, &weapondetonatedtomastrike);

    if(!istrue(var3)) {
      return 0;
    }
  } else if(var1 == 5 && isDefined(self.waitandunloadinfils)) {
    var0.ref_13a81 = self.waitandunloadinfils;
    self.waitandunloadinfils = undefined;
    var4 = weaponfiredtomastrike(var0, undefined, undefined);

    if(var4 != "success") {
      return 0;
    }
  } else {
    if(scripts\cp_mp\utility\game_utility::ref_140a9()) {
      var5 = getcompleteweaponname("iw8_spotter_scope_mp_ch3", ["spotterscope"]);
    } else {
      var5 = getcompleteweaponname("iw8_green_beam_mp");
    }

    var3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(var1, var5, "weapon_fired", &weapongiventomastrike, &weaponswitchendedtomastrike, &weaponfiredtomastrike);

    if(!istrue(var3)) {
      return 0;
    }
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var1)) {
      return 0;
    }
  }

  if(tomastrike_isremotevehicletype(var5)) {
    var6 = 1;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "currentActiveVehicleCount") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "currentActiveVehicleCount")]]() >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]() || level.fauxvehiclecount + var6 >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]()) {
        self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
        var1 notify("killstreak_finished_with_deploy_weapon");
        return 0;
      }
    }

    var3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var1, &weapongiventomastrike, &weaponswitchendedtomastrike);

    if(!istrue(var3)) {
      return 0;
    }
  }

  var7 = undefined;

  if(var5 == 0) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "incrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "incrementFauxVehicleCount")]]();
    }

    var7 = createtomastrikedrone(self, var1);

    if(!isDefined(var7)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
      }

      return 0;
    }
  } else if(var5 == 1) {
    if(level.toma_cameras.size == 0) {
      var8 = ["ks_strike_camera_1", "ks_strike_camera_2", "ks_strike_camera_3", "ks_strike_camera_4"];

      foreach(var10 in var8) {
        var11 = scripts\engine\utility::getStruct(var10, "targetname");

        if(!isDefined(var11)) {
          var1 notify("killstreak_finished_with_deploy_weapon");
          return;
        }

        var12 = spawn("script_model", var11.origin);
        var12.angles = var11.angles;
        var12.targetname = var11.targetname;
        var12 setModel("tag_player");
        level.toma_cameras[level.toma_cameras.size] = var12;
      }
    }
  } else if(var5 == 2) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "incrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "incrementFauxVehicleCount")]]();
    }

    var7 = createtomastrikebomber(self, var1);

    if(!isDefined(var7)) {
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
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var1.streakname, self.origin);
  }

  if(var5 != 4) {
    thread starttomastrike(var5, var7, level.toma_cameras, var1);
  }

  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](var1);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("toma_strike", "munitionUsed")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("toma_strike", "munitionUsed")]]();
  }

  return 1;
}

function ref_13bda(var0, var1, var2) {
  var3 = spawnStruct();
  var3.origin = var0;
  var3.angles = var1;
  var3.pers = [];
  var3.team = "neutral";
  var3.defaultoperatorteam = "neutral";
  var3.classname = "worldspawn";

  if(!isDefined(var2)) {
    var2 = var3 scripts\cp_mp\utility\killstreak_utility::createstreakinfo("toma_strike", var3);
  }

  var2.owner = var3;
  var2.ref_13a81 = var0;
  var2.ref_121af = anglesToForward(var1);
  var2.ref_133dc = 1;
  thread starttomastrike(var3, 5, undefined, undefined);
}

function createtomastrikedrone(var0, var1) {
  var2 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var3 = (0, 0, 0);

  if(isDefined(var2)) {
    var3 = (0, 0, var2.origin[2]);
  } else {
    var3 = (0, 0, 600);
  }

  var3 -= (0, 0, 900);
  var4 = spawnhelicopter(var0, var0.origin + (0, 0, 1000), var0.angles, "veh_toma_drone_mp", "veh8_mil_air_mquebec8");

  if(!isDefined(var4)) {
    return;
  }

  var4.speed = 100;
  var4.accel = 50;
  var4.health = 9999;
  var4.maxhealth = 2000;
  var4.lifetime = 10;
  var4.team = var0.team;
  var4.owner = var0;
  var4.angles = var0.angles;
  var4.streakinfo = var1;
  var4.streakname = var1.streakname;
  var4.currentdamagestate = 0;
  var4.scorepopup = "destroyed_toma_strike";
  var4.vodestroyed = "destroyed_toma_strike";
  var4.votimeout = "timeout_toma_strike";
  var4.destroyedsplash = "callout_destroyed_toma_strike";
  var4.currentvisionset = "proto_apache_flir_mp";
  level.toma_strikes[level.toma_strikes.size] = var4;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var4[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var1.streakname, "Killstreak_Air", var0, 0, 1, 25);
  }

  var4 setmaxpitchroll(15, 15);
  var4 vehicle_setspeed(var4.speed, var4.accel);
  var4 sethoverparams(50, 5, 2.5);
  var4 setturningability(1);
  var4 setyawspeed(500, 100, 25, 0.5);
  var4 setotherent(var0);
  var4 setentityowner(var0);
  var4 setCanDamage(1);
  var4 setneargoalnotifydist(100);
  return var4;
}

function createtomastrikebomber(var0, var1) {
  var2 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var3 = (0, 0, 0);

  if(isDefined(var2)) {
    var3 = (0, 0, var2.origin[2] + 8000);
  } else {
    var3 = (0, 0, 5000);
  }

  var3 -= (0, 0, 900);
  var4 = level.mapcenter - anglesToForward(var0.angles) * 5000 + var3;
  var5 = level.mapcenter + anglesToForward(var0.angles) * 20000 + var3;
  var6 = spawn("script_model", var4);
  var6 setModel("veh8_mil_air_acharlie130");
  var6.health = 9999;
  var6.maxhealth = 2000;
  var6.angles = var0.angles;
  var6.owner = var0;
  var6.team = var0.team;
  var6.streakinfo = var1;
  var6.streakname = var1.streakname;
  var6.pathstart = var4;
  var6.pathgoal = var5;
  var6.flaresreservecount = 1;
  var6 setotherent(var0);
  var6 setentityowner(var0);
  var6 setCanDamage(1);
  var6 scriptmoveroutline();
  var6 scriptmoverthermal();
  var6.camera = spawn("script_model", var6.origin - (0, 0, 10));
  var6.camera setModel("tag_player");
  var6.camera.angles = vectortoangles(level.mapcenter - var6.camera.origin);
  var6.camera linkTo(var6);
  var6.cloudsfx = spawn("script_model", var6.camera.origin - (0, 0, 10));
  var6.cloudsfx setModel("ks_toma_strike_mp");
  var6.cloudsfx.angles = var6.angles;
  var6.cloudsfx linkTo(var6.camera);
  level.toma_strikes[level.toma_strikes.size] = var6;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var6[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var1.streakname, "Killstreak_Air", var0, 0, 1, 25);
  }

  return var6;
}

function starttomastrike(var0, var1, var2, var3) {
  self endon("disconnect");
  level endon("game_ended");

  if(tomastrike_isremotevehicletype(var0)) {
    scripts\common\utility::allow_fire(0);
    scripts\common\utility::allow_weapon_switch(0);
    scripts\common\utility::allow_crouch(0);
    scripts\common\utility::allow_prone(0);
    scripts\common\utility::allow_usability(0);
    scripts\common\utility::allow_killstreaks(0);
    self.restoreangles = self.angles;
    var4 = 1;
    var5 = spawn("script_model", self.origin);
    var5 setModel("ks_toma_strike_marker_mp");
    var5 setotherent(self);
    var6 = [];

    foreach(var8 in level.players) {
      if(level.teambased && var8.team == self.team) {
        continue;
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
        if(var8[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
          continue;
        }
      }

      var6 = var8;
    }

    var10 = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionenemydefault", self, var6, self, 0, 1, 1);
    var11 = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionfriendlydefault", self, self, self);

    if(var0 == 0) {
      if(!isDefined(var1)) {
        return;
      }

      self setplayerangles(var1.angles);
      self cameralinkTo(var1, "tag_origin");
      self remotecontrolvehicle(var1);
      thread tomastrike_watchearlyexit();
      thread tomastrike_watchdamage();
      thread tomastrike_watchowner();
      thread tomastrike_watchdestroyed(var1);
      thread tomastrike_watchlifetime(var5, var1);
      var1.playersfx = spawn("script_origin", var1.origin);
      var1.playersfx linkTo(var1);
      var1.playersfx playLoopSound("veh_apache_killstreak_amb_lr");
      self setclientomnvar("ui_killstreak_health", (var1.maxhealth - var1.damagetaken) / var1.maxhealth);
    } else if(var0 == 1) {
      if(!isDefined(var2) || var2.size == 0) {
        return;
      }

      var4 = 0;
      scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "tomaStrike");
      thread tomastrike_watchcameraswitch(var2, var5);
      thread tomastrike_watchlifetime(var5, var1);
    } else if(var0 == 2) {
      if(!isDefined(var1)) {
        return;
      }

      self playerlinkweaponviewtodelta(var1.camera, "tag_player", 1, 180, 180, 10, 90, 0);
      self playerlinkedsetviewznear(0);
      thread tomastrike_watchearlyexit();
      thread tomastrike_watchdamage();
      thread tomastrike_watchowner();
      thread tomastrike_watchdestroyed(var1);
      thread tomastrike_watchleave(var1);
      thread tomastrike_playearthquakeloop();

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger")) {
        var1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]](&tomastrike_handlemissiledetection);
      }

      if(isPlayer(var1.owner)) {
        var1.owner setclienttriggeraudiozone("cluster_strike", 2);
      }

      var1.cloudsfx setscriptablepartstate("clouds", "on");
      var1 moveTo(var1.pathgoal, 70);
    }

    self.clusterammoleft = 3;
    self setclientomnvar("ui_cluster_controls", 1);
    self setclientomnvar("ui_cluster_missiles_left", self.clusterammoleft);
    self visionsetkillstreakforplayer("proto_toma_strike_mp");
    thread tomastrike_movetargetguide(var5, var1);
    thread tomastrike_watchammousage(var5, var1, var4);
    thread tomastrike_watchlasertarget(var0, var5, var1, var3);
    thread tomastrike_watchreturnplayer(var3, var0, var10, var11);
    return;
  }

  thread tomastrike_attacktarget(var0, undefined, undefined, var3);
  var3 notify("killstreak_finished_with_deploy_weapon");
  thread ref_13bd9(var3);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(20);
  self notify("cluster_strike_finished");
  scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var3);
}

function tomastrike_handlemissiledetection(var0, var1, var2, var3) {
  self endon("death");

  for(;;) {
    if(!isDefined(var2)) {
      break;
    }

    var4 = var2 getpointinbounds(0, 0, 0);
    var5 = distance(self.origin, var4);

    if(var5 < 4000 && var2.flaresreservecount > 0) {
      var2.flaresreservecount--;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "playFx")) {
        var2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "playFx")]](undefined, var3);
      }

      var6 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "deploy")) {
        var6 = var2[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "deploy")]]();
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "updateScrapAssistDataForceCredit")) {
        var2[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "updateScrapAssistDataForceCredit")]](var0);
      }

      self missile_settargetEnt(var6);
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

function tomastrike_watchlifetime(var0, var1) {
  self endon("disconnect");
  self endon("stop_marker_guide");
  var2 = 1;

  if(isDefined(var1)) {
    var1 endon("death");
    var1 endon("leaving");
    var2 = 0;
  }

  level endon("game_ended");
  self setclientomnvar("ui_killstreak_countdown", gettime() + int(10000));
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(10);
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("timeout_toma_strike");

  if(isDefined(var1)) {
    var1 notify("death");
  }

  self notify("tomaStrike_returnPlayer", var2);

  if(isDefined(var0)) {
    var0 delete();
  }

  self notify("stop_marker_guide");
}

function tomastrike_watchdamage() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("toma_strike", "monitorDamage")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("toma_strike", "monitorDamage")]](self.maxhealth, "hitequip", &tomastrike_watchdeathdamage, &tomastrike_modifydamage, 1);
    return;
  }
}

function tomastrike_modifydamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflags;
  var6 = var4;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage")) {
    var6 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](var1, var2, var3, var6, self.maxhealth, 2, 3, 4);
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

  self.currenthealth = self.maxhealth - self.damagetaken + var6;
  self.owner setclientomnvar("ui_killstreak_health", self.currenthealth / self.maxhealth);
  return var6;
}

function tomastrike_watchdeathdamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflags;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "onKillstreakKilled")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "onKillstreakKilled")]](self.streakname, var1, var2, var3, var4, self.scorepopup, self.vodestroyed, self.destroyedsplash);
  }

  self notify("death");
}

function tomastrike_watchdestroyed(var0) {
  self endon("gone");
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }

  self.owner notify("toma_strike_end");

  if(isDefined(self.owner) && self.owner scripts\cp_mp\utility\player_utility::isusingremote()) {
    self.owner notify("tomaStrike_returnPlayer", 0);
  }

  thread tomastrike_explode(self.owner, self.origin, "toma_proj_mp", var0);
}

function tomastrike_watchleave(var0) {
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

  if(isDefined(var0)) {
    var0 delete();
  }

  thread tomastrike_watchgoal(var0);
}

function tomastrike_watchgoal(var0) {
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

function tomastrike_watchcameraswitch(var0, var1) {
  self endon("disconnect");
  self endon("stop_marker_guide");
  var2 = var0[0];
  self playerlinkweaponviewtodelta(var2, "tag_player", 1, 45, 45, 20, 70, 0);
  self setplayerangles(var2.angles);
  self.currentclustercamera = var2;
  self notifyonplayercommand("switch_camera_left", "+actionslot 3");
  self notifyonplayercommand("switch_camera_left", "+moveleft");
  self notifyonplayercommand("switch_camera_right", "+actionslot 4");
  self notifyonplayercommand("switch_camera_right", "+moveright");
  var3 = 0;
  var4 = var0.size - 1;
  var5 = var3;

  for(;;) {
    var6 = scripts\engine\utility::ref_143ad("switch_camera_left", "switch_camera_right");
    var7 = var0[var5].origin;
    var8 = self getplayerangles();

    if(!isDefined(var6)) {
      continue;
    }

    switch (var6) {
      case "switch_camera_left":
        var5++;

        if(var5 > var4) {
          var5 = var3;
        }

        break;
      case "switch_camera_right":
        var5--;

        if(var5 < var3) {
          var5 = var4;
        }

        break;
    }

    tomastrike_playercameratransition(var7, var8, var0[var5], var1);
    waitframe();
  }
}

function tomastrike_playercameratransition(var0, var1, var2, var3) {
  level endon("game_ended");
  var4 = spawn("script_model", var0);
  var4 setModel("tag_player");
  var4.owner = self;
  var4.angles = var1;
  self playerlinkweaponviewtodelta(var4, "tag_player", 1, 0, 0, 0, 0, 0);
  self playerlinkedsetviewznear(0);
  self visionsetfadetoblackforplayer("bw", 0.25);
  self visionsetkillstreakforplayer("");
  self visionsetnakedforplayer("tac_ops_slamzoom", 0.25);
  self setclientomnvar("ui_cluster_controls", 0);
  var3 setscriptablepartstate("target", "off", 0);
  var4 moveTo(var2.origin, 0.25);
  var4 rotateTo(var2.angles, 0.25);
  var4 waittill("rotatedone");
  scripts\mp\utility\player::restorebasevisionset(0.2);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
  self setclientomnvar("ui_cluster_controls", 1);
  self visionsetfadetoblackforplayer("", 0);
  self visionsetkillstreakforplayer("proto_toma_strike_mp");
  scripts\mp\utility\player::restorebasevisionset(0);
  var3 setscriptablepartstate("target", "guide", 0);
  self playerlinkweaponviewtodelta(var2, "tag_player", 1, 45, 45, 20, 70, 0);
  self.currentclustercamera = var2;
  var4 delete();
}

function tomastrike_watchreturnplayer(var0, var1, var2, var3) {
  self endon("disconnect");
  self waittill("tomaStrike_returnPlayer", var4);
  tomastrike_returnplayer(var0, var1, var4, var2, var3);
}

function tomastrike_watchlasertarget(var0, var1, var2, var3) {
  self endon("disconnect");
  self endon("stop_marker_guide");

  if(isDefined(var2)) {
    var2 endon("death");
    var2 endon("leaving");
  }

  level endon("game_ended");
  self notifyonplayercommand("drone_target_start", "+attack");

  for(;;) {
    self waittill("drone_target_start");

    if(self.clusterammoleft == 0) {
      continue;
    }

    var4 = spawn("script_model", self.origin);
    var4 setModel("ks_toma_strike_marker_mp");
    var4 setotherent(self);
    var4.owner = self;
    thread tomastrike_startlasertarget(var0, var2, var1, var4, var3);

    if(var0 == 2) {
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
    }
  }
}

function tomastrike_watchammousage(var0, var1, var2) {
  self endon("disconnect");
  self endon("stop_marker_guide");
  var3 = 1;

  if(isDefined(var1)) {
    var1 endon("death");
    var1 endon("leaving");
    var3 = 0;
  }

  for(;;) {
    self waittill("ammo_used");
    self.clusterammoleft--;
    self setclientomnvar("ui_cluster_missiles_left", self.clusterammoleft);

    if(self.clusterammoleft == 0 && istrue(var2)) {
      var0 setscriptablepartstate("target", "off", 0);
      self setclientomnvar("ui_cluster_controls", 2);
      wait 5;
      var0 setscriptablepartstate("target", "guide", 0);
      self.clusterammoleft = 3;
      self setclientomnvar("ui_cluster_controls", 1);
      self setclientomnvar("ui_cluster_missiles_left", self.clusterammoleft);
      continue;
    }

    self setclientomnvar("ui_cluster_missiles_left", self.clusterammoleft);

    if(self.clusterammoleft == 0) {
      self notify("tomaStrike_returnPlayer", var3);

      if(isDefined(var0)) {
        var0 delete();
      }

      self notify("stop_marker_guide");
      break;
    }
  }
}

function tomastrike_movetargetguide(var0, var1) {
  self endon("disconnect");
  self endon("stop_marker_guide");

  if(isDefined(var1)) {
    var1 endon("death");
    var1 endon("leaving");
  }

  var0 setscriptablepartstate("target", "guide", 0);

  for(;;) {
    var2 = tomastrike_getownerlookat(self);
    var0.origin = var2;
    waitframe();
  }
}

function tomastrike_getownerlookat(var0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "aim_override")) {
    return var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "aim_override")]]();
  }

  var1 = ["physicscontents_solid", "physicscontents_water", "physicscontents_sky", "physicscontents_glass", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_ainosight", "physicscontents_vehicleclip"];
  var2 = physics_createcontents(var1);
  var3 = var0 getvieworigin();
  var4 = var3 + anglesToForward(var0 getplayerangles()) * 50000;
  var5 = var0 scripts\cp_mp\utility\killstreak_utility::ref_125f8();
  var6 = scripts\engine\trace::ray_trace(var3, var4, var5, var2);
  var7 = undefined;

  if(isDefined(var6["hittype"]) && var6["hittype"] != "hittype_none") {
    var7 = var6["position"];
  }

  return var7;
}

function tomastrike_watchlaserrelease(var0) {
  var1 = self.owner;
  var1 endon("disconnect");
  var1 endon("drone_target_placed");
  self endon("death");
  level endon("game_ended");
  thread tomastrike_watchdronedeath();
  var1 waittill("drone_target_release");
  var1 notify("drone_target_cancel");
  var0 setscriptablepartstate("target", "off", 0);
}

function tomastrike_watchdronedeath() {
  var0 = self.owner;
  var0 endon("disconnect");
  var0 endon("drone_target_release");
  self waittill("death");
  var0 notify("toma_strike_end");
  var0 notify("drone_target_cancel");
}

function tomastrike_startlasertarget(var0, var1, var2, var3, var4) {
  level endon("game_ended");
  var3.origin = var2.origin;
  var3 setscriptablepartstate("target", "placed", 0);

  if(var0 == 1) {
    thread delayscriptablechangethread(var3);
  } else {
    thread delayscriptablechangethread(var3);
  }

  self playlocalsound("weap_cluster_target_beep");
  self notify("ammo_used");

  if(isDefined(self)) {
    thread tomastrike_attacktarget(var0, var1, var3, var4);
    return;
  }
}

function tomastrike_attacktarget(var0, var1, var2, var3) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("drone_target_placed");
  var3.shots_fired++;
  var4 = undefined;
  var5 = undefined;

  if(var0 == 0 || var0 == 2) {
    var4 = var1.origin - (0, 0, 10) + anglesToForward(var1.angles) * 20;
    var5 = var1.angles;
  } else if(var0 == 1) {
    var4 = self.currentclustercamera.origin - (0, 0, 3000);
    var5 = anglestoright(self.currentclustercamera.angles);
  } else {
    var4 = self.origin + (0, 0, 5000);

    if(!istrue(var3.vehicle_process_node_when_at_goal)) {
      var4 -= anglesToForward(self.angles) * 5000;
    }

    var5 = anglestoright(self.angles);
  }

  var6 = undefined;

  if(isDefined(var2)) {
    if(isvector(var2)) {
      var6 = var2;
    } else {
      var6 = var2.origin;
    }
  } else {
    if(var0 == 5 && isDefined(var3.ref_13a81)) {
      var6 = var3.ref_13a81;
    } else {
      var6 = tomastrike_getownerlookat(self);
    }

    if(!istrue(var3.ref_11eae)) {
      var2 = spawn("script_model", var6);
      var2 setModel("ks_toma_strike_marker_mp");

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "requestObjectiveID")) {
        var2.objidnum = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "requestObjectiveID")]](99);
      }

      var7 = scripts\cp_mp\utility\script_utility::ref_140de("game", "isGameTypeBR", 0);

      if(var7) {
        var2.icon = "icon_waypoint_clusterstrike_ww2";
      } else {
        var2.icon = "icon_waypoint_clusterstrike";
      }

      if(isPlayer(self)) {
        var2 setotherent(self);
      }

      if(!istrue(var3.ref_133dc)) {
        toma_strike_setmarkerobjective(var2, var2.objidnum, var2.icon, self, 50);
      }

      thread toma_strike_handlemarkerscriptable();
    }
  }

  var8 = 6;
  var9 = 300;

  if(var0 == 5) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br", "challengeEvaluator")) {
      var10 = spawnStruct();
      var10.streakinfo = var3;
      var10.ref_13a8a = var6;
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br", "challengeEvaluator")]]("br_mastery_pointBlank_tomahawk", var10);
    }

    var8 = 6;

    if(isDefined(var3.ref_11f47)) {
      var8 = var3.ref_11f47;
    }

    var9 = 900;

    if(isDefined(var3.ref_129e3)) {
      var9 = var3.ref_129e3;
    }

    var11 = var9;

    if(isDefined(var3.ref_11ece)) {
      var11 = var3.ref_11ece;
    }

    if(!istrue(var3.ref_133c9) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "dangerNotifyPlayersInRange")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "dangerNotifyPlayersInRange")]](var6, var11 + 300, var3.streakname);
    }
  }

  if(var0 == 0 || var0 == 2) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.3);
    var4 = var1.origin - (0, 0, 10) + anglesToForward(var1.angles) * 20;
    var12 = var6;
    var13 = spawnStruct();
    var13.sourcepos = var4;
    var13.goalpos = var12;
    var13.initvelocity = var13.goalpos - var13.sourcepos;
    thread tomastrike_firestrike(var13, var3, var1);
    return;
  }

  if(var0 == 1 || var0 == 3 || var0 == 4 || var0 == 5) {
    var14 = 2;

    if(isDefined(var3.ref_121af)) {
      var15 = var3.ref_121af;
    } else {
      var15 = anglesToForward(self getplayerangles());
    }

    var16 = anglesToForward(self.angles);
    var17 = anglestoright(self.angles);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var15);

    for(var19 = 0; var19 < var9; var19++) {
      var20 = undefined;

      if(istrue(var4.vehicle_process_node_when_at_goal)) {
        var20 = var5;
      }

      var13 = findunobstructedfiringinfo(var8, var14, var15, var16, var17, var20);
      thread tomastrike_firestrike(var13, var4);
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(randomfloatrange(1.35, 2.5));
    }

    level.toma_strikes = scripts\engine\utility::array_remove(level.toma_strikes, self);
    return;
  }
}

function findunobstructedfiringinfo(var0, var1, var2, var3, var4, var5) {
  var6 = spawnStruct();

  if(isDefined(var5)) {
    var7 = var5;
  } else {
    var7 = ref_13bd5(var1, var3, var4, var5);
  }

  var8 = vectorNormalize(var1 - (var7[0], var7[1], 0));
  var9 = ref_13bd6(var1, var2, var8);
  var10 = (0, 0, -1 * getdvarint("NPOQPMP", 800));
  var11 = (var9.point - 0.5 * var10 * squared(4) - var7) / 4;
  var13 = var7 + var11 * 3.925 + 0.5 * var10 * squared(3.925);
  var7.sourcepos = var7;
  var7.num_of_frame_frozen = var9.num_of_frame_frozen;
  var7.num_of_subway_cars = var9.num_of_subway_cars;
  var7.goalpos = var9.point;
  var7.preexplpos = var13;
  var7.initvelocity = var11;
  return var7;
}

function delayscriptablechangethread(var0) {
  self.owner endon("disconnect");
  self endon("death");
  self.owner scripts\engine\utility::ref_143b9(var0, "stop_marker_guide");
  self setscriptablepartstate("target", "off", 0);
  self delete();
}

function tomastrike_screeninterference(var0, var1) {
  var2 = self.owner;
  var2 endon("disconnect");

  if(isDefined(var2)) {
    var2 visionsetthermalforplayer(var1);

    if(isDefined(var0)) {
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var0);
      var2 visionsetthermalforplayer(self.currentvisionset);
      return;
    }

    return;
  }
}

function ref_13bd6(var0, var1, var2) {
  var3 = randomint(var1);
  var4 = randomint(360);
  var5 = var0[0] + var3 * cos(var4);
  var6 = var0[1] + var3 * sin(var4);
  var7 = var0[2];
  var8 = (var5, var6, var7);

  if(isDefined(var2)) {
    var8 -= var2 * 100;
  }

  var9 = 10000;

  if(isDefined(level.ref_13bd3)) {
    var9 = level.ref_13bd3;
  }

  var10 = spawnStruct();
  var11 = scripts\engine\trace::create_default_contents(1);
  var12 = scripts\engine\trace::ray_trace(var8 + (0, 0, var9), var8 - (0, 0, var9), undefined, var11);

  if(isDefined(var12["entity"])) {
    var13 = var12["entity"];
    var10.num_of_frame_frozen = var13;

    if(ref_13bd8(var13) || ref_13bd7(var13)) {
      var10.num_of_subway_cars = "flying";
    }
  }

  if(isDefined(var12["position"])) {
    var8 = var12["position"];
  }

  var10.point = var8;
  return var10;
}

function ref_13bd8(var0) {
  return var0 scripts\cp_mp\vehicles\vehicle::isvehicle() && istrue(var0 scripts\cp_mp\vehicles\vehicle::vehiclecanfly());
}

function ref_13bd7(var0) {
  return isDefined(var0.streakinfo) && isDefined(var0.sentientpool) && var0.sentientpool == "Killstreak_Air";
}

function tomastrike_firestrike(var0, var1, var2) {
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(var2)) {
    self earthquakeforplayer(0.35, 1, var2.origin, 1000);
    self playlocalsound("weap_cluster_fire");
  }

  var3 = isPlayer(self) || isagent(self);

  if(var3) {
    var4 = magicgrenademanual("toma_proj_mp", var0.sourcepos, var0.initvelocity, 5, self);
    var4 setmissileminimapvisible(1);
    var4 setentityowner(self);
    var4 setotherent(self);
  } else {
    var4 = magicgrenademanual("toma_proj_mp", var1.sourcepos, var1.initvelocity, 5);
    var4 setmissileminimapvisible(1);
  }

  var4 setscriptablepartstate("launch", "active", 0);
  var4 setscriptablepartstate("trail", "active", 0);

  if(isDefined(var2.ref_121a9)) {
    var5 = var2.ref_121a9;
  } else {
    var5 = "ks_toma_strike_missile_mp";
  }

  var5.explodeent = spawn("script_model", var5.origin);
  var5.explodeent setModel(var5);
  var5.explodeent linkTo(var5);
  var5.explodeent dontinterpolate();

  if(var4) {
    var5.explodeent setentityowner(self);
  }

  var6 = spawn("script_model", var2.sourcepos);
  var6 linkTo(var5, "tag_origin", (10, 0, 10), (0, 0, 0));
  var5.killcament = var6;
  var5.owner = self;
  var5.streakinfo = var3;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var2.goalpos, 512, 300, self.team, 6, self, 1);
  }

  thread ref_13bd4();
  thread toma_strike_watch_airexplosion(var5, var2.preexplpos, var2.num_of_frame_frozen);
  thread toma_strike_watch_stuck(var5, vectortoangles(var2.initvelocity), gettime());
}

function tomastrike_getmissileendpos(var0) {
  var1 = var0;

  foreach(var3 in level.players) {
    if(level.teambased && var3.team == self.team) {
      continue;
    } else if(!level.teambased && var3 == self) {
      continue;
    }

    if(!var3 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(istrue(var3.markedfortoma)) {
      continue;
    }

    if(distancesquared(var0, var3.origin) > 250000) {
      continue;
    }

    var3.markedfortoma = 1;
    var1 = var3.origin;
    thread clearmarkonrespawn();
    break;
  }

  return var1;
}

function clearmarkonrespawn() {
  self endon("disconnect");
  scripts\engine\utility::ref_143b9(10, "death");
  self.markedfortoma = undefined;
}

function tomastrike_returnplayer(var0, var1, var2, var3, var4) {
  scripts\common\utility::allow_fire(1);
  scripts\common\utility::allow_weapon_switch(1);
  scripts\common\utility::allow_crouch(1);
  scripts\common\utility::allow_prone(1);
  scripts\common\utility::allow_usability(1);
  scripts\common\utility::allow_killstreaks(1);
  self clearclienttriggeraudiozone(1);

  if(var1 == 1) {
    scripts\cp_mp\utility\player_utility::_freezecontrols(0, undefined, "tomaStrike");
  }

  if(!istrue(var2)) {
    if(var1 == 0) {
      self remotecontrolvehicleoff();
      self cameraunlink();
      self setplayerangles(self.restoreangles);
      self.restoreangles = undefined;
    } else if(var1 == 2) {
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
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var3);
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var4);
  var0 notify("killstreak_finished_with_deploy_weapon");
}

function tomastrike_explode(var0, var1, var2, var3) {
  self playSound("weap_hellfire_impact");

  if(isDefined(self.playersfx)) {
    self.playersfx stoploopsound();
    self.playersfx delete();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "grenade_earthQuakeAtPosition")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "grenade_earthQuakeAtPosition")]](var1, 1.2);
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

  if(isDefined(var3)) {
    var3 delete();
  }

  self delete();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    return;
  }
}

function toma_strike_missile_explode(var0) {
  self endon("death");
  self.exploding = 1;
  self.explodeent unlink();
  self.explodeent.origin = var0;
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
  var0 = self.owner;
  var0 waittill("disconnect");

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  self setmissileminimapvisible(0);
  thread toma_strike_missile_explode(self.origin);
  self notify("missile_dest_failed");
}

function toma_strike_watch_airexplosion(var0, var1, var2) {
  self endon("death");
  self endon("missile_dest_failed");
  thread toma_strike_move_killcam(self.killcament, 3.675);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.925);
  self setmissileminimapvisible(0);
  thread toma_strike_missile_explode(var0);

  if(isDefined(var1) && isDefined(var2) && var2 == "flying") {
    var3 = self.owner;

    if(!isPlayer(var3)) {
      var3 = self;
    }

    var1 dodamage(500, var0, var3, self, "MOD_EXPLOSIVE", getcompleteweaponname("toma_proj_mp"));
    return;
  }
}

function toma_strike_move_killcam(var0, var1) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var0);
  self unlink();
  self moveTo(var1, 3);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(7);
  self delete();
}

function toma_strike_watch_stuck(var0, var1, var2) {
  self endon("death");
  self endon("missile_dest_failed");
  self waittill("missile_stuck", var3);
  self setmissileminimapvisible(0);

  if(gettime() - var1 < 3925) {
    thread toma_strike_missile_explode(self.origin);
    self notify("missile_dest_failed");
    return;
  }

  wait 0.05;
  var4 = -1 * getdvarint("NPOQPMP", 800);
  var5 = (gettime() - var1) / 1000;
  var6 = var2 + (0, 0, var4 * var5);

  if(isDefined(var3) && isPlayer(var3)) {
    toma_strike_stuck_player(self, var3, var0, var6);
    return;
  }

  toma_strike_stuck(var3, var0, var6);
}

function toma_strike_stuck(var0, var1, var2) {
  var3 = undefined;
  var4 = vectorNormalize(var2);
  var5 = anglestoup(self.angles);
  var6 = anglestoright(var1);

  if(abs(vectordot(var4, var5)) >= 0.9848) {
    var3 = toma_strike_rebuild_angles_up_right(var5, var6);
  } else {
    var3 = toma_strike_rebuild_angles_up_forward(var5, var4);
  }

  self.angles = var3;
  thread toma_strike_launch_cluster(self, self.origin, var3, var0, gettime());
}

function toma_strike_stuck_player(var0, var1, var2, var3) {
  var3 *= (0, 0, 1);
  var4 = var0.origin;
  var5 = (0, 0, -1);
  var6 = var4 + var5 * 128;
  var7 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle"]);
  var8 = physics_raycast(var4, var6, var7, var0, 0, "physicsquery_closest", 1);

  if(isDefined(var8) && var8.size > 0) {
    var6 = var8[0]["position"];
    var9 = var8[0]["normal"];
    var10 = var8[0]["entity"];
    var6 -= var9 * 1;
    var11 = -1 * getdvarint("NPOQPMP", 800);
    var12 = vectordot(var6 - var4, var5);
    var13 = sqrt(2 * var12 / -1 * var11);
    var14 = var9;
    var15 = anglestoright(var2);
    var16 = toma_strike_rebuild_angles_up_right(var14, var15);
    thread toma_strike_launch_cluster(var0, var6, var16, var10, gettime() + var13 * 1000);
    return;
  }
}

function toma_strike_launch_cluster(var0, var1, var2, var3, var4) {
  var5 = var0.owner;
  var6 = var0.killcament;
  var7 = anglestoup(var2);
  var8 = var1 + var7 * 1;
  var9 = var8 + var7 * 25;
  var10 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle"]);
  var11 = physics_raycast(var8, var9, var10, var0, 0, "physicsquery_closest", 1);

  if(isDefined(var11) && var11.size > 0) {
    var9 = var11[0]["position"] - var7 * 1;
  }

  var12 = var9;
  var13 = toma_strike_get_shared_data(var5, var0.streakinfo, var4, var6);
  var14 = toma_strike_get_cast_data();
  var15 = toma_strike_create_branch(var13, var14, undefined, var12, var2, var3, 0, undefined, undefined);
  var13.branches[var13.branches.size] = var15;
  var15.killcament = var6;
  var16 = anglesToForward(var2);
  var17 = anglestoright(var2);
  var18 = anglestoup(var2);
  var19 = rotatepointaroundvector(var18, var16, 30);
  var20 = vectorNormalize(vectorcross(var19, var18));
  var21 = vectorcross(var20, var16);
  var22 = axistoangles(var19, var20, var21);
  var14 = toma_strike_get_cast_data();
  var15 = toma_strike_create_branch(var13, var14, undefined, var12, var22, var3, 0, undefined, undefined);
  var15.killcament = var6;
  var13.branches[var13.branches.size] = var15;
  var19 = rotatepointaroundvector(var18, var16, -30);
  var20 = vectorNormalize(vectorcross(var19, var18));
  var21 = vectorcross(var20, var16);
  var22 = axistoangles(var19, var20, var21);
  var14 = toma_strike_get_cast_data();
  var15 = toma_strike_create_branch(var13, var14, undefined, var12, var22, var3, 0, undefined, undefined);
  var15.killcament = var6;
  var13.branches[var13.branches.size] = var15;
  toma_strike_shared_data_register_cast(var13);

  foreach(var15 in var13.branches) {
    thread toma_strike_start_branch();
  }
}

function toma_strike_start_branch() {
  var0 = self.killcament;

  if(!isDefined(self.preventstarttime)) {
    self.preventstarttime = gettime();
  }

  if(!isDefined(self.startingcasttype)) {
    if(!toma_strike_shared_data_is_complete(self.shareddata)) {
      var1 = toma_strike_branch_create_explosion(self.startingorigin, self.startingangles, self.startingstuckto, self.shareddata.streakinfo);
      var1.killcament = var0;
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
      var2 = self.castdata.firstforwardmodanglesfunc;

      if(isDefined(var2)) {
        self.castangles = [[var2]](self.castangles);
        self.castdata.firstforwardmodanglesfunc = undefined;
      }
    }

    self.castdir = toma_strike_get_cast_dir(self.castangles, self.casttype);
    self.castend = self.caststart + self.castdir * toma_strike_get_cast_dist(self.casttype, self.castdata);
    var3 = undefined;
    var4 = undefined;
    var5 = undefined;
    var6 = undefined;
    var7 = undefined;
    var8 = physics_raycast(self.caststart, self.castend, self.shareddata.castcontents, undefined, 0, "physicsquery_closest", 1);

    if(isDefined(var8) && var8.size > 0) {
      var3 = 1;
      var4 = var8[0]["position"];
      var5 = var8[0]["normal"];
      var6 = var8[0]["entity"];
    }

    switch (self.casttype) {
      case 0:
        if(istrue(var3)) {
          toma_strike_branch_register_cast(self.casttype, 0, var4);
          var9 = 1;

          if(isDefined(self.castdata.firstforwarddist)) {
            var10 = var4 - self.caststart;
            var11 = vectordot(var10, self.castdir);
            self.castdata.firstforwarddist -= var11;

            if(self.castdata.firstforwarddist > self.castdata.firstforwardmindist) {
              var9 = 0;
            } else {
              self.castdata.firstforwarddist = undefined;
            }
          }

          var7 = toma_strike_rebuild_angles_up_right(var5, anglestoright(self.castangles));

          if(var9) {
            var1 = toma_strike_branch_create_explosion(var4, var7, var6, self.shareddata.streakinfo);
            var1.killcament = var1;
            thread toma_strike_start_explosion();
          }

          self.casttype = 2;
          self.caststart = var4 + var5 * 1;
          self.castangles = var7;
        } else {
          toma_strike_branch_register_cast(self.casttype, undefined, undefined);

          if(isDefined(self.castdata.firstforwarddist)) {
            var10 = self.castend - self.caststart;
            var11 = vectordot(var10, self.castdir);
            self.castdata.firstforwarddist -= var11;

            if(self.castdata.firstforwarddist <= self.castdata.firstforwardmindist) {
              self.castdata.firstforwarddist = undefined;
            }
          }

          self.casttype = 1;
          self.caststart = self.castend;
        }

        break;
      case 1:
        if(istrue(var3)) {
          var7 = toma_strike_rebuild_angles_up_right(var5, anglestoright(self.castangles));
          var1 = toma_strike_branch_create_explosion(var4, var7, var6, self.shareddata.streakinfo);
          var1.killcament = var1;
          thread toma_strike_start_explosion();
          var12 = vectordot(anglestoup(self.castangles), var5);

          if(var12 < 0.9848) {
            toma_strike_branch_register_cast(self.casttype, 2, var4);
            self.casttype = 2;
            self.caststart = var4 + var5 * 1;
            self.castangles = var7;
          } else {
            toma_strike_branch_register_cast(self.casttype, 1, var4);
            self.casttype = 0;
          }
        } else {
          toma_strike_branch_register_cast(self.casttype, undefined, undefined);
          self.caststart = self.castend;
        }

        break;
      case 2:
        if(istrue(var3)) {
          toma_strike_branch_register_cast(self.casttype, 3, var4);
          self.casttype = 0;
          self.caststart = var4 + var5 * 1;
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

function toma_strike_branch_create_explosion(var0, var1, var2, var3) {
  var4 = 50;

  if(true) {
    var4 = randomintrange(50, 350);
  }

  var5 = self.preventstarttime + var4;
  var6 = toma_strike_create_explosion(var0 + anglestoup(var1), var1, var2, self.shareddata.owner, var5, var3);
  self.preventstarttime = var5;
  self.ents[self.ents.size] = var6;
  toma_strike_shared_data_register_ent(self.shareddata);
  return var6;
}

function toma_strike_create_explosion(var0, var1, var2, var3, var4, var5) {
  var6 = spawn("script_model", var0);
  var6.angles = var1;
  var6.stuckto = var2;
  var6.owner = var3;
  var6.starttime = var4;
  var6.streakinfo = var5;

  if(isDefined(var5.ref_121a8)) {
    var7 = var5.ref_121a8;
  } else {
    var7 = "ks_toma_strike_cluster_mp";
  }

  var7 setModel(var7);

  if(isPlayer(var4)) {
    var7 setotherent(var4);
    var7 setentityowner(var4);
  }

  if(isDefined(var3)) {
    var7 linkTo(var3);
  }

  return var7;
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

function toma_strike_shared_data_is_complete(var0) {
  var1 = 0;

  if(self.caststotal >= 60) {
    var1 = 1;
  } else if(self.entstotal >= 20) {
    var1 = 1;
  } else if(istrue(var0)) {
    var2 = 1;

    foreach(var4 in self.branches) {
      if(!toma_strike_branch_is_complete(var4)) {
        var2 = 0;
        break;
      }
    }

    if(var2) {
      var1 = 1;
    }
  }

  if(var1) {
    self.iscomplete = 1;
  }

  return var1;
}

function toma_strike_branch_register_cast(var0, var1, var2) {
  toma_strike_shared_data_register_cast(self.shareddata);
  self.casts++;

  if(isDefined(var1)) {
    if(var1 == 0 || var1 == 1 || var1 == 2) {
      self.castfails = 0;
      return;
    }

    return;
  }

  if(var0 == 1) {
    self.castfails++;
    return;
  }
}

function toma_strike_branch_is_complete(var0) {
  var1 = 0;
  var2 = undefined;

  if(toma_strike_shared_data_is_complete(self.shareddata)) {
    var1 = 1;
  } else if(isDefined(self.castdata) && self.castfails >= self.castdata.maxfails) {
    var1 = 1;
  } else if(isDefined(self.castdata) && self.casts >= self.castdata.maxcasts) {
    var1 = 1;
  } else if(isDefined(self.castdata) && self.ents.size >= self.castdata.maxents) {
    var1 = 1;
  } else if(istrue(var0)) {
    var2 = 1;

    foreach(var4 in self.branches) {
      if(!toma_strike_branch_is_complete(var4)) {
        var2 = 0;
        break;
      }
    }

    if(var2) {
      var1 = 1;
    }
  }

  if(var1 && !istrue(self.iscomplete)) {
    var6 = self.oncompletedfunc;

    if(isDefined(var6)) {
      self[[var6]]();
    }

    if(istrue(var2)) {
      var1 = 0;

      foreach(var4 in self.branches) {
        if(!toma_strike_branch_is_complete(var4)) {
          var2 = 0;
          break;
        }
      }

      if(var2) {
        var1 = 1;
      }
    }
  }

  if(var1) {
    self.iscomplete = 1;
  }

  return var1;
}

function toma_strike_create_branch(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var9 = spawnStruct();
  var9.shareddata = var0;
  var9.castdata = var1;
  var9.startingorigin = var3;
  var9.startingangles = var4;
  var9.startingstuckto = var5;
  var9.startingcasttype = var6;
  var9.oncompletedfunc = var8;
  var9.ents = [];
  var9.branches = [];
  var9.hitpositions = [];
  var9.hittypes = [];
  var9.casts = 0;
  var9.castfails = 0;
  var9.preventstarttime = var7;
  return var9;
}

function toma_strike_get_shared_data(var0, var1, var2, var3) {
  var4 = spawnStruct();
  var4.owner = var0;
  var4.team = var0.team;
  var4.streakinfo = var1;
  var4.impacttime = var2;
  var4.branches = [];
  var4.entstotal = 0;
  var4.caststotal = 0;
  var4.caststhisframe = 0;
  var4.frametimestamp = gettime();
  var4.castcontents = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle"]);
  return var4;
}

function toma_strike_get_cast_data() {
  var0 = spawnStruct();
  var0.distforward = 125;
  var0.distdown = 50;
  var0.distup = 25;
  var0.maxcasts = 12;
  var0.maxfails = 3;
  var0.maxents = 4;
  return var0;
}

function toma_strike_get_cast_dir(var0, var1) {
  switch (var1) {
    case 0:
      return anglesToForward(var0);
    case 1:
      return (-1 * anglestoup(var0));
    case 2:
      return anglestoup(var0);
  }

  return undefined;
}

function toma_strike_get_cast_dist(var0, var1) {
  switch (var0) {
    case 0:
      if(isDefined(var1.firstforwarddist)) {
        return var1.firstforwarddist;
      } else {
        return var1.distforward;
      }
    case 1:
      return var1.distdown;
    case 2:
      return var1.distup;
  }

  return undefined;
}

function toma_strike_rebuild_angles_up_right(var0, var1) {
  var2 = vectorNormalize(vectorcross(var0, var1));
  var1 = vectorcross(var2, var0);
  return axistoangles(var2, var1, var0);
}

function toma_strike_rebuild_angles_up_forward(var0, var1) {
  var2 = vectorNormalize(vectorcross(var1, var0));
  var1 = vectorcross(var0, var2);
  return axistoangles(var1, var2, var0);
}

function tomastrike_isremotevehicletype(var0) {
  var1 = 0;

  switch (var0) {
    case 2:
    case 1:
    case 0:
      var1 = 1;
      break;
  }

  return var1;
}

function tomastrike_ismarkertype(var0) {
  var1 = 0;

  switch (var0) {
    case 4:
    case 3:
      var1 = 1;
      break;
  }

  return var1;
}

function toma_strike_setmarkerobjective(var0, var1, var2, var3) {
  objective_icon(var0, var1);
  objective_showtoplayersinmask(var0);

  if(isPlayer(var2)) {
    objective_addclienttomask(var0, var2);
  }

  objective_onentity(var0, self);
  objective_setzoffset(var0, var3);
  objective_setplayintro(var0, 0);
  objective_setplayoutro(var0, 0);
  objective_setbackground(var0, 1);

  if(level.teambased || !isPlayer(var2)) {
    objective_setownerteam(var0, var2.team);
  } else {
    objective_setownerclient(var0, var2);
  }

  objective_state(var0, "current");
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

function ref_13bd5(var0, var1, var2, var3) {
  var4 = scripts\engine\trace::create_default_contents(1);
  var5 = scripts\engine\trace::ray_trace(var0 - var1 * 30, var0 + var1 * 1000, undefined, var4);
  var6 = var5["position"] + var5["normal"] * 20;
  var7 = var6;
  var8 = 5000;
  var9 = 5000;
  var10 = [var7 + var2 * 100, var7 - var2 * 100, var7 + var3 * 100, var7 - var3 * 100, var7 + (var2 + var3) * 100, var7 + (var2 - var3) * 100, var7 + (var3 - var2) * 100, var7 + (-1 * var2 - var3) * 100];
  var11 = var7 + (0, 0, var8 * 1.5);

  foreach(var13 in var10) {
    var14 = vectorNormalize(var13 - var7);
    var15 = var7 + (0, 0, var8) - var14 * var9;
    var16 = var7;
    var17 = scripts\engine\trace::ray_trace_passed(var15, var16, undefined, var4);

    if(!istrue(var17)) {
      wait 0.05;
      continue;
    }

    var11 = var15;
    break;
  }

  return var11;
}

function ref_13bd9(var0) {
  self endon("cluster_strike_finished");
  self endon("disconnect");
  level waittill("game_ended");
  scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var0);
}