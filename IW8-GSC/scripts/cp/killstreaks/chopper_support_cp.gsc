/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\chopper_support_cp.gsc
*********************************************************/

function init_chopper_support() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_support", "set_vehicle_hit_damage_data", &chopper_support_set_vehicle_hit_damage_data);
}

function chopper_support_set_vehicle_hit_damage_data(var_0, var_1) {
  scripts\cp\vehicles\damage_cp::set_vehicle_hit_damage_data(var_0, var_1);
}

function chopper_support_create_enemy_chopper(var_0) {
  var_1 = spawnStruct();
  var_1.streakname = "chopper_support";
  var_1.owner = var_0;
  var_2 = spawnenemychopper(var_0, var_0, var_1);

  if(!isDefined(var_2)) {
    iprintln(" COULD NOT SPAWN ENEMY CHOPPER. RECHECK SCRIPT ^1 chopper_support_create_enemy_chopper(...)");
    return 0;
  }

  thread startenemychopper(var_2, var_0);
}

function spawnenemychopper(var_0, var_1) {
  var_2 = (0, 0, 1750);
  var_4 = var_0.origin - anglesToForward(var_0.angles) * 15000 + var_2;
  var_5 = var_0.origin + anglesToForward(var_0.angles) * 2000 + var_2;
  var_6 = var_0.angles;
  var_7 = getdvarint("scr_chopper_support_lifetime", 45);
  var_9 = undefined;

  if(isDefined(level.heli_structs_entrances) && level.heli_structs_entrances.size > 0) {
    var_10 = randomint(level.heli_structs_entrances.size);
    var_11 = level.heli_structs_entrances[var_10];
    var_9 = scripts\cp_mp\killstreaks\chopper_support::choppersupport_findtargetStruct(var_11.script_linkto, level.heli_structs_goals);
    var_12 = var_11.origin * (1, 1, 0) + var_2;
    var_13 = var_9.origin * (1, 1, 0) + var_2;
    var_14 = vectorNormalize(var_13 - var_12);
    var_4 = var_13 - var_14 * 15000;
    var_5 = var_13;
    var_6 = vectortoangles(var_14);
  } else {
    iprintlnbold("Level is missing heli structs, please set them up!");
  }

  var_21 = "veh8_mil_air_palfa_east";
  var_22 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var_0, var_4, var_6, "veh_chopper_support_mp", var_21);

  if(!isDefined(var_22)) {
    iprintln(" COULD NOT SPAWN ENEMY CHOPPER. RECHECK SCRIPT - ^1 spawnEnemyChopper(...) ");
    return undefined;
  }

  var_22.speed = 100;
  var_22.accel = 50;
  var_22.lifetime = var_7;
  var_22.team = "axis";
  var_22.owner = var_0;
  var_22.angles = var_6;
  var_22.streakinfo = var_1;
  var_22.streakname = var_1.streakname;
  var_22.flaresreservecount = 1;
  var_22.currentdamagestate = 0;
  var_22.pathstart = var_4;
  var_22.pathgoal = var_5;
  var_22.currentaction = "patrol";
  var_22.currenttarget = undefined;
  var_22.currentpatrolstruct = var_9;
  var_22.heightoffset = var_2;
  var_22.health = 2000;
  var_22.maxhealth = 2000;
  var_22 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakMakeVehicle")) {
    var_22[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakMakeVehicle")]](var_1.streakname, "destroyed_chopper_support", undefined, "timeout_chopper_support", "callout_destroyed_chopper_support");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPreModDamageCallback")) {
    var_22[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPreModDamageCallback")]](var_1.streakname);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPostModDamageCallback")) {
    var_22[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPostModDamageCallback")]](var_1.streakname, &scripts\cp_mp\killstreaks\chopper_support::choppersupport_modifydamage);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetDeathCallback")) {
    var_22[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetDeathCallback")]](var_1.streakname, &scripts\cp_mp\killstreaks\chopper_support::choppersupport_handledeathdamage);
  }

  level.choppersupports[level.choppersupports.size] = var_22;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_22[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_1.streakname, "Killstreak_Air", var_0, 0, 1, 100);
  }

  var_22 setmaxpitchroll(15, 15);
  var_22 vehicle_setspeed(var_22.speed, var_22.accel);
  var_22 sethoverparams(50, 5, 2.5);
  var_22 setturningability(0.5);
  var_22 setyawspeed(100, 25, 25, 0.1);
  var_22 setCanDamage(1);
  var_22 setneargoalnotifydist(768);
  var_22 setscriptablepartstate("blinking_lights", "on", 0);
  var_22 setscriptablepartstate("engine", "on", 0);
  var_23 = "veh8_mil_air_ahotel64_turret_wm_east";
  var_22.frontturret = spawnturret("misc_turret", var_22 gettagorigin("tag_turret_front"), "chopper_support_turret_mp");
  var_22.frontturret setModel(var_23);
  var_22.frontturret.owner = var_0;
  var_22.frontturret.team = "axis";
  var_22.frontturret.angles = var_22.angles;
  var_22.frontturret.streakinfo = var_1;
  var_22.frontturret.turreton = 1;
  var_22.frontturret.name = "front_turret";
  var_22.frontturret.attackingtarget = undefined;
  var_22.frontturret linkTo(var_22);
  var_22.frontturret setturretteam("axis");
  var_22.frontturret setturretmodechangewait(0);
  var_22.frontturret setmode("manual");
  var_22.frontturret setdefaultdroppitch(45);
  var_22.frontturret.groundtargetent = spawn("script_model", self.origin);
  var_22.frontturret.groundtargetent setModel("tag_origin");
  var_22.frontturret.groundtargetent dontinterpolate();
  var_22.rearturret = spawnturret("misc_turret", var_22 gettagorigin("tag_turret_rear"), "chopper_support_turret_mp");
  var_22.rearturret setModel(var_23);
  var_22.rearturret.owner = var_0;
  var_22.rearturret.team = "axis";
  var_22.rearturret.angles = var_22.angles;
  var_22.rearturret.streakinfo = var_1;
  var_22.rearturret.turreton = 1;
  var_22.rearturret.name = "rear_turret";
  var_22.rearturret.attackingtarget = undefined;
  var_22.rearturret linkTo(var_22);
  var_22.rearturret setturretteam("axis");
  var_22.rearturret setturretmodechangewait(0);
  var_22.rearturret setmode("manual");
  var_22.rearturret setdefaultdroppitch(45);
  var_22.rearturret.groundtargetent = spawn("script_model", self.origin);
  var_22.rearturret.groundtargetent setModel("tag_origin");
  var_22.rearturret.groundtargetent dontinterpolate();
  var_22.killcament = spawn("script_model", var_22 gettagorigin("tag_ground"));
  var_22.killcament linkTo(var_22, "tag_ground", (-600, 0, 1000), (0, 0, 0));
  var_22.frontturret.killcament = var_22.killcament;
  var_22.rearturret.killcament = var_22.killcament;
  level notify("matchrecording_chopper", var_22);
  return var_22;
}

function startenemychopper(var_0, var_1) {
  self endon("death");
  self setvehgoalpos(self.pathgoal, 1);
  var_0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var_1.streakname, 1);
  thread choppersupport_neargoalsettings_enemy();
  self playsoundonmovingent("ks_chopper_support_approach");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]](&scripts\cp_mp\killstreaks\chopper_support::choppersupport_handlemissiledetection);
    return;
  }
}

function choppersupport_neargoalsettings_enemy() {
  self endon("leaving");
  self endon("death");
  self waittill("near_goal");
  self vehicle_setspeed(int(self.speed / 2), int(self.accel / 3));
  thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_watchdestoyed();
  thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_watchgameendleave();
  thread choppersupport_leaveoncommand_enemy();
  thread choppersupport_patrolfield_enemy(1);
  thread choppersupport_engageturrettarget_enemy(self.frontturret);
  thread choppersupport_engageturrettarget_enemy(self.rearturret);
}

function choppersupport_leaveoncommand_enemy() {
  self endon("death");
  self endon("leaving");
  level waittill("all_enemy_vehicles_leave");
  scripts\cp_mp\killstreaks\chopper_support::choppersupport_cleanup();
}

function choppersupport_patrolfield_enemy(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self endon("engaging_target");

  if(self.currentaction != "patrol") {
    self.currentaction = "patrol";
  } else if(self.currentaction == "patrol" && !istrue(var_0)) {
    return;
  }

  self setneargoalnotifydist(100);
  var_1 = 0;

  for(;;) {
    if(self.currentaction == "attacking") {
      if(!istrue(var_1)) {
        var_1 = 1;
      }

      waitframe();
      continue;
    }

    if(!istrue(var_0) && istrue(var_1)) {
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_support_patrol");
      var_1 = 0;
    }

    var_2 = scripts\cp_mp\killstreaks\chopper_support::choppersupport_findclosestpatrolstruct();

    if(isDefined(var_2)) {
      scripts\cp_mp\killstreaks\chopper_support::choppersupport_movetolocation(var_2, 1);
    } else {
      var_4 = [];
      var_5 = (0, 0, 0);
      var_6 = self.pathgoal;

      foreach(var_8 in level.players) {
        if(!var_8 scripts\cp_mp\utility\player_utility::_isalive()) {
          continue;
        }

        var_5 += var_8.origin;
        var_4 = var_8;
      }

      if(isDefined(var_5) && var_4.size > 0) {
        var_10 = var_5 / var_4.size;
        scripts\cp_mp\killstreaks\chopper_support::choppersupport_movetolocation(var_10);
      }
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
  }
}

function choppersupport_engageturrettarget_enemy(var_0) {
  self endon("leaving");
  self endon("death");

  for(;;) {
    if(!istrue(var_0.turreton)) {
      waitframe();
      continue;
    }

    var_1 = choppersupport_gettargets_enemy();

    if(isDefined(var_1) && var_1.size > 0) {
      var_2 = choppersupport_acquireturrettarget_enemy(var_0, var_1);

      if(isDefined(var_2) && var_2 == "stopped_firing") {
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
      }

      if(!scripts\cp_mp\killstreaks\chopper_support::choppersupport_checkifactivetargets()) {
        thread scripts\cp_mp\killstreaks\chopper_support::choppersupport_patrolfield();
      }
    }

    wait 0.05;
  }
}

function choppersupport_gettargets_enemy() {
  self endon("death");
  self endon("leaving");
  var_0 = [];
  var_1 = level.players;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(choppersupport_istarget_enemy(var_3)) {
      if(isDefined(var_1[var_2])) {
        var_0 = var_1[var_2];
      }
    } else {
      continue;
    }

    wait 0.05;
  }

  return var_0;
}

function choppersupport_istarget_enemy(var_0) {
  self endon("death");
  self endon("leaving");

  if(!isalive(var_0) || var_0.sessionstate != "playing") {
    return false;
  }

  if(!isDefined(var_0.pers["team"])) {
    return false;
  }

  if(var_0.pers["team"] == "spectator") {
    return false;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    if(var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_blindeye")) {
      return false;
    }
  }

  if(var_0 scripts\cp_mp\utility\player_utility::isinvehicle()) {
    return false;
  }

  if(scripts\cp_mp\killstreaks\chopper_support::choppersupport_isactivetarget(var_0)) {
    return false;
  }

  if(distance2dsquared(self.origin, var_0.origin) > 16000000) {
    return false;
  }

  if(var_0 sightconetrace(self.origin, self) < 1) {
    return false;
  }

  return true;
}

function choppersupport_acquireturrettarget_enemy(var_0, var_1) {
  self notify("engaging_target");
  var_2 = undefined;
  var_3 = choppersupport_getbesttarget_enemy(var_0, var_1);

  if(isDefined(var_3)) {
    scripts\cp_mp\killstreaks\chopper_support::choppersupport_setcurrenttarget(var_0, var_3);
    scripts\cp_mp\killstreaks\chopper_support::choppersupport_fireonturrettarget(var_0, var_3, 1);
    var_2 = "stopped_firing";
  } else {
    var_2 = "continue_searching";
  }

  return var_2;
}

function choppersupport_getbesttarget_enemy(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_1) {
    if(!choppersupport_istarget_enemy(var_5)) {
      continue;
    }

    var_6 = abs(vectortoangles(var_5.origin - self.origin)[1]);
    var_7 = abs(self gettagangles("tag_flash")[1]);
    var_6 = abs(var_6 - var_7);
    var_8 = var_5 getweaponslistitems();

    foreach(var_10 in var_8) {
      var_11 = weaponclass(var_10);

      if(var_11 == "rocketlauncher") {
        var_6 -= 40;
      }
    }

    if(distancesquared(self.origin, var_5.origin) > 16000000) {
      var_6 += 40;
    }

    if(!isDefined(var_2) || var_2 > var_6) {
      var_2 = var_6;
      var_3 = var_5;
    }
  }

  return var_3;
}