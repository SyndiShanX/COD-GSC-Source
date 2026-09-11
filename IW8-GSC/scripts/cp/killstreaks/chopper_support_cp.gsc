/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\chopper_support_cp.gsc
*********************************************************/

function init_chopper_support() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_support", "set_vehicle_hit_damage_data", &chopper_support_set_vehicle_hit_damage_data);
}

function chopper_support_set_vehicle_hit_damage_data(var0, var1) {
  scripts\cp\vehicles\damage_cp::set_vehicle_hit_damage_data(var0, var1);
}

function chopper_support_create_enemy_chopper(var0) {
  var1 = spawnStruct();
  var1.streakname = "chopper_support";
  var1.owner = var0;
  var2 = spawnenemychopper(var0, var0, var1);

  if(!isDefined(var2)) {
    iprintln(" COULD NOT SPAWN ENEMY CHOPPER. RECHECK SCRIPT ^1 chopper_support_create_enemy_chopper(...)");
    return 0;
  }

  thread startenemychopper(var2, var0);
}

function spawnenemychopper(var0, var1) {
  var2 = (0, 0, 1750);
  var4 = var0.origin - anglesToForward(var0.angles) * 15000 + var2;
  var5 = var0.origin + anglesToForward(var0.angles) * 2000 + var2;
  var6 = var0.angles;
  var7 = getdvarint("scr_chopper_support_lifetime", 45);
  var9 = undefined;

  if(isDefined(level.heli_structs_entrances) && level.heli_structs_entrances.size > 0) {
    var10 = randomint(level.heli_structs_entrances.size);
    var11 = level.heli_structs_entrances[var10];
    var9 = scripts\cp_mp\killstreaks\chopper_support::choppersupport_findtargetStruct(var11.script_linkto, level.heli_structs_goals);
    var12 = var11.origin * (1, 1, 0) + var2;
    var13 = var9.origin * (1, 1, 0) + var2;
    var14 = vectorNormalize(var13 - var12);
    var4 = var13 - var14 * 15000;
    var5 = var13;
    var6 = vectortoangles(var14);
  } else {
    iprintlnbold("Level is missing heli structs, please set them up!");
  }

  var21 = "veh8_mil_air_palfa_east";
  var22 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var0, var4, var6, "veh_chopper_support_mp", var21);

  if(!isDefined(var22)) {
    iprintln(" COULD NOT SPAWN ENEMY CHOPPER. RECHECK SCRIPT - ^1 spawnEnemyChopper(...) ");
    return undefined;
  }

  var22.speed = 100;
  var22.accel = 50;
  var22.lifetime = var7;
  var22.team = "axis";
  var22.owner = var0;
  var22.angles = var6;
  var22.streakinfo = var1;
  var22.streakname = var1.streakname;
  var22.flaresreservecount = 1;
  var22.currentdamagestate = 0;
  var22.pathstart = var4;
  var22.pathgoal = var5;
  var22.currentaction = "patrol";
  var22.currenttarget = undefined;
  var22.currentpatrolstruct = var9;
  var22.heightoffset = var2;
  var22.health = 2000;
  var22.maxhealth = 2000;
  var22 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", var0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakMakeVehicle")) {
    var22[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakMakeVehicle")]](var1.streakname, "destroyed_chopper_support", undefined, "timeout_chopper_support", "callout_destroyed_chopper_support");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPreModDamageCallback")) {
    var22[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPreModDamageCallback")]](var1.streakname);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPostModDamageCallback")) {
    var22[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPostModDamageCallback")]](var1.streakname, &scripts\cp_mp\killstreaks\chopper_support::choppersupport_modifydamage);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetDeathCallback")) {
    var22[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetDeathCallback")]](var1.streakname, &scripts\cp_mp\killstreaks\chopper_support::choppersupport_handledeathdamage);
  }

  level.choppersupports[level.choppersupports.size] = var22;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var22[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var1.streakname, "Killstreak_Air", var0, 0, 1, 100);
  }

  var22 setmaxpitchroll(15, 15);
  var22 vehicle_setspeed(var22.speed, var22.accel);
  var22 sethoverparams(50, 5, 2.5);
  var22 setturningability(0.5);
  var22 setyawspeed(100, 25, 25, 0.1);
  var22 setCanDamage(1);
  var22 setneargoalnotifydist(768);
  var22 setscriptablepartstate("blinking_lights", "on", 0);
  var22 setscriptablepartstate("engine", "on", 0);
  var23 = "veh8_mil_air_ahotel64_turret_wm_east";
  var22.frontturret = spawnturret("misc_turret", var22 gettagorigin("tag_turret_front"), "chopper_support_turret_mp");
  var22.frontturret setModel(var23);
  var22.frontturret.owner = var0;
  var22.frontturret.team = "axis";
  var22.frontturret.angles = var22.angles;
  var22.frontturret.streakinfo = var1;
  var22.frontturret.turreton = 1;
  var22.frontturret.name = "front_turret";
  var22.frontturret.attackingtarget = undefined;
  var22.frontturret linkTo(var22);
  var22.frontturret setturretteam("axis");
  var22.frontturret setturretmodechangewait(0);
  var22.frontturret setmode("manual");
  var22.frontturret setdefaultdroppitch(45);
  var22.frontturret.groundtargetent = spawn("script_model", self.origin);
  var22.frontturret.groundtargetent setModel("tag_origin");
  var22.frontturret.groundtargetent dontinterpolate();
  var22.rearturret = spawnturret("misc_turret", var22 gettagorigin("tag_turret_rear"), "chopper_support_turret_mp");
  var22.rearturret setModel(var23);
  var22.rearturret.owner = var0;
  var22.rearturret.team = "axis";
  var22.rearturret.angles = var22.angles;
  var22.rearturret.streakinfo = var1;
  var22.rearturret.turreton = 1;
  var22.rearturret.name = "rear_turret";
  var22.rearturret.attackingtarget = undefined;
  var22.rearturret linkTo(var22);
  var22.rearturret setturretteam("axis");
  var22.rearturret setturretmodechangewait(0);
  var22.rearturret setmode("manual");
  var22.rearturret setdefaultdroppitch(45);
  var22.rearturret.groundtargetent = spawn("script_model", self.origin);
  var22.rearturret.groundtargetent setModel("tag_origin");
  var22.rearturret.groundtargetent dontinterpolate();
  var22.killcament = spawn("script_model", var22 gettagorigin("tag_ground"));
  var22.killcament linkTo(var22, "tag_ground", (-600, 0, 1000), (0, 0, 0));
  var22.frontturret.killcament = var22.killcament;
  var22.rearturret.killcament = var22.killcament;
  level notify("matchrecording_chopper", var22);
  return var22;
}

function startenemychopper(var0, var1) {
  self endon("death");
  self setvehgoalpos(self.pathgoal, 1);
  var0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var1.streakname, 1);
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

function choppersupport_patrolfield_enemy(var0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self endon("engaging_target");

  if(self.currentaction != "patrol") {
    self.currentaction = "patrol";
  } else if(self.currentaction == "patrol" && !istrue(var0)) {
    return;
  }

  self setneargoalnotifydist(100);
  var1 = 0;

  for(;;) {
    if(self.currentaction == "attacking") {
      if(!istrue(var1)) {
        var1 = 1;
      }

      waitframe();
      continue;
    }

    if(!istrue(var0) && istrue(var1)) {
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_support_patrol");
      var1 = 0;
    }

    var2 = scripts\cp_mp\killstreaks\chopper_support::choppersupport_findclosestpatrolstruct();

    if(isDefined(var2)) {
      scripts\cp_mp\killstreaks\chopper_support::choppersupport_movetolocation(var2, 1);
    } else {
      var4 = [];
      var5 = (0, 0, 0);
      var6 = self.pathgoal;

      foreach(var8 in level.players) {
        if(!var8 scripts\cp_mp\utility\player_utility::_isalive()) {
          continue;
        }

        var5 += var8.origin;
        var4 = var8;
      }

      if(isDefined(var5) && var4.size > 0) {
        var10 = var5 / var4.size;
        scripts\cp_mp\killstreaks\chopper_support::choppersupport_movetolocation(var10);
      }
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
  }
}

function choppersupport_engageturrettarget_enemy(var0) {
  self endon("leaving");
  self endon("death");

  for(;;) {
    if(!istrue(var0.turreton)) {
      waitframe();
      continue;
    }

    var1 = choppersupport_gettargets_enemy();

    if(isDefined(var1) && var1.size > 0) {
      var2 = choppersupport_acquireturrettarget_enemy(var0, var1);

      if(isDefined(var2) && var2 == "stopped_firing") {
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
  var0 = [];
  var1 = level.players;

  for(var2 = 0; var2 < var1.size; var2++) {
    var3 = var1[var2];

    if(choppersupport_istarget_enemy(var3)) {
      if(isDefined(var1[var2])) {
        var0 = var1[var2];
      }
    } else {
      continue;
    }

    wait 0.05;
  }

  return var0;
}

function choppersupport_istarget_enemy(var0) {
  self endon("death");
  self endon("leaving");

  if(!isalive(var0) || var0.sessionstate != "playing") {
    return false;
  }

  if(!isDefined(var0.pers["team"])) {
    return false;
  }

  if(var0.pers["team"] == "spectator") {
    return false;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    if(var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_blindeye")) {
      return false;
    }
  }

  if(var0 scripts\cp_mp\utility\player_utility::isinvehicle()) {
    return false;
  }

  if(scripts\cp_mp\killstreaks\chopper_support::choppersupport_isactivetarget(var0)) {
    return false;
  }

  if(distance2dsquared(self.origin, var0.origin) > 16000000) {
    return false;
  }

  if(var0 sightconetrace(self.origin, self) < 1) {
    return false;
  }

  return true;
}

function choppersupport_acquireturrettarget_enemy(var0, var1) {
  self notify("engaging_target");
  var2 = undefined;
  var3 = choppersupport_getbesttarget_enemy(var0, var1);

  if(isDefined(var3)) {
    scripts\cp_mp\killstreaks\chopper_support::choppersupport_setcurrenttarget(var0, var3);
    scripts\cp_mp\killstreaks\chopper_support::choppersupport_fireonturrettarget(var0, var3, 1);
    var2 = "stopped_firing";
  } else {
    var2 = "continue_searching";
  }

  return var2;
}

function choppersupport_getbesttarget_enemy(var0, var1) {
  var2 = undefined;
  var3 = undefined;

  foreach(var5 in var1) {
    if(!choppersupport_istarget_enemy(var5)) {
      continue;
    }

    var6 = abs(vectortoangles(var5.origin - self.origin)[1]);
    var7 = abs(self gettagangles("tag_flash")[1]);
    var6 = abs(var6 - var7);
    var8 = var5 getweaponslistitems();

    foreach(var10 in var8) {
      var11 = weaponclass(var10);

      if(var11 == "rocketlauncher") {
        var6 -= 40;
      }
    }

    if(distancesquared(self.origin, var5.origin) > 16000000) {
      var6 += 40;
    }

    if(!isDefined(var2) || var2 > var6) {
      var2 = var6;
      var3 = var5;
    }
  }

  return var3;
}