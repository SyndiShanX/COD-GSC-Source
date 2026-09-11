/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\chopper_support.gsc
*********************************************************/

function init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("chopper_support", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("chopper_support", "init")]]();
  }

  if(!isDefined(level.grenade_effect)) {
    level.grenade_effect = &choppersupport_movetolocation;
  }

  level._effect["chopper_support_explosion"] = loadfx("vfx/iw8_mp/killstreak/vfx_chopper_support_explosion.vfx");
  level.choppersupports = [];
  init_chopper_support_vo();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("chopper_support", "set_vehicle_hit_damage_data")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("chopper_support", "set_vehicle_hit_damage_data")]]("chopper_support", 12);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]]("thermite_bolt_mp", 1, "chopper_support");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]]("chopper_support", 36, "thermite_bolt_mp");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]]("semtex_bolt_mp", 1, "chopper_support");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]]("chopper_support", 13, "semtex_bolt_mp");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]]("thermite_xmike109_mp", 1, "chopper_support");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]]("chopper_support", 100, "thermite_xmike109_mp");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]]("semtex_xmike109_mp", 1, "chopper_support");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]]("chopper_support", 24, "semtex_xmike109_mp");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]]("semtex_aalpha12_mp", 1, "chopper_support");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]]("chopper_support", 26, "semtex_aalpha12_mp");
  }

  level.heli_structs_entrances = scripts\cp_mp\utility\game_utility::removematchingents_bykey("ks_heli_entrance");
  level.heli_structs_goals = scripts\cp_mp\utility\game_utility::removematchingents_bykey("ks_heli_goal");
  level.heli_structs_paths = scripts\cp_mp\utility\game_utility::removematchingents_bykey("ks_heli_path");
  level.incomingallchoppersupports = 0;
  level.incomingchoppersupports["allies"] = 0;
  level.incomingchoppersupports["axis"] = 0;
}

function init_chopper_support_vo() {
  game["dialog"]["chopper_support_light_damage"] = "chopper_support_health_high";
  game["dialog"]["chopper_support_med_damage"] = "chopper_support_health_med";
  game["dialog"]["chopper_support_heavy_damage"] = "chopper_support_health_low";
  game["dialog"]["chopper_support_engage_target"] = "chopper_support_engage";
  game["dialog"]["chopper_support_patrol"] = "chopper_support_patrol";
  game["dialog"]["chopper_support_flares"] = "chopper_support_flares";
  game["dialog"]["chopper_support_crash"] = "chopper_support_crash";
}

function tryusechoppersupport(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(var_0, self);
  return tryusechoppersupportfromstruct(var_1);
}

function tryusechoppersupportfromstruct(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      return 0;
    }
  }

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    return 0;
  }

  var_1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(var_0, getcompleteweaponname("ks_gesture_generic_mp"));

  if(!istrue(var_1)) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return 0;
  }

  level.incomingallchoppersupports++;
  var_2 = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    var_2 = 2;
  }

  if(level.choppersupports.size >= var_2 || level.choppersupports.size + level.incomingallchoppersupports > var_2) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    level.incomingallchoppersupports--;
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return 0;
  }

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased) {
    var_3 = 1;
    level.incomingchoppersupports[self.team]++;

    if(scripts\cp_mp\utility\killstreak_utility::getnumactivekillstreakperteam(self.team, level.choppersupports) + level.incomingchoppersupports[self.team] > var_3) {
      level.incomingallchoppersupports--;
      level.incomingchoppersupports[self.team]--;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_SUPPORT_HELO");
      }

      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return 0;
    }
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return 0;
    }
  }

  var_4 = usechoppersupport(self, var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]]("chopper_support", self.origin);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_chopper_support", self);
  }

  return var_4;
}

function usechoppersupport(var_0, var_1) {
  var_2 = spawnchopper(var_0, var_1);
  level.incomingallchoppersupports--;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased) {
    level.incomingchoppersupports[var_0.team]--;
  }

  if(!isDefined(var_2)) {
    return false;
  }

  thread startchopper(var_2, var_0);

  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](var_1);
  }

  return true;
}

function spawnchopper(var_0, var_1) {
  var_2 = (0, 0, 1750);
  var_4 = var_0.origin - anglesToForward(var_0.angles) * 15000 + var_2;
  var_5 = var_0.origin + anglesToForward(var_0.angles) * 2000 + var_2;
  var_6 = var_0.angles;
  var_7 = getdvarint("scr_chopper_support_lifetime", 45);
  var_9 = undefined;

  if(isDefined(level.heli_structs_entrances) && level.heli_structs_entrances.size > 0) {
    var_10 = randomint(level.heli_structs_entrances.size);
    var_11 = level.heli_structs_entrances[var_10];
    var_9 = choppersupport_findtargetStruct(var_11.script_linkto, level.heli_structs_goals);

    if(isDefined(var_9)) {
      var_12 = var_11.origin * (1, 1, 0) + var_2;
      var_13 = var_9.origin * (1, 1, 0) + var_2;
      var_14 = vectorNormalize(var_13 - var_12);
      var_4 = var_13 - var_14 * 15000;
      var_5 = var_13;
      var_6 = vectortoangles(var_14);
    }
  }

  var_21 = "veh8_mil_air_palfa";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var_0)) {
    var_21 = "veh8_mil_air_palfa_east";
  }

  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  var_22 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var_0, var_4, var_6, "veh_chopper_support_mp", var_21);

  if(!isDefined(var_22)) {
    return undefined;
  }

  var_22.speed = 100;
  var_22.accel = 50;
  var_22.lifetime = var_7;
  var_22.team = var_0.team;
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
  var_22.infil_complete = var_2[2] - 750;
  var_22.ref_13766 = 50;
  var_22.ref_13767 = 25;
  var_22.ref_13768 = undefined;
  var_22.ref_11c43 = 7;
  var_22.ref_11c44 = 12;
  var_22 setvehicleteam(var_22.team);
  var_22.health = 3500;
  var_22.maxhealth = 3500;
  var_22 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakMakeVehicle")) {
    var_22[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakMakeVehicle")]](var_1.streakname, "destroyed_chopper_support", undefined, "timeout_chopper_support", "callout_destroyed_chopper_support");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPreModDamageCallback")) {
    var_22[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPreModDamageCallback")]](var_1.streakname);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPostModDamageCallback")) {
    var_22[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPostModDamageCallback")]](var_1.streakname, &choppersupport_modifydamage);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetDeathCallback")) {
    var_22[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetDeathCallback")]](var_1.streakname, &choppersupport_handledeathdamage);
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
  var_22 setotherent(var_0);
  var_22 setCanDamage(1);
  var_22 setneargoalnotifydist(768);
  var_22 setscriptablepartstate("blinking_lights", "on", 0);
  var_22 setscriptablepartstate("engine", "on", 0);
  var_23 = "veh8_mil_air_ahotel64_turret_wm";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var_0)) {
    var_23 = "veh8_mil_air_ahotel64_turret_wm_east";
  }

  var_22.frontturret = spawnturret("misc_turret", var_22 gettagorigin("tag_turret_front"), "chopper_support_turret_mp");
  var_22.frontturret setModel(var_23);
  var_22.frontturret.owner = var_0;
  var_22.frontturret.team = var_0.team;
  var_22.frontturret.angles = var_22.angles;
  var_22.frontturret.streakinfo = var_1;
  var_22.frontturret.turreton = 1;
  var_22.frontturret.name = "front_turret";
  var_22.frontturret.attackingtarget = undefined;
  var_22.frontturret linkTo(var_22);
  var_22.frontturret setturretteam(var_0.team);
  var_22.frontturret setturretmodechangewait(0);
  var_22.frontturret setmode("manual");
  var_22.frontturret setotherent(var_0);
  var_22.frontturret setdefaultdroppitch(45);
  var_22.frontturret.groundtargetent = spawn("script_model", self.origin);
  var_22.frontturret.groundtargetent setModel("tag_origin");
  var_22.frontturret.groundtargetent dontinterpolate();
  var_22.rearturret = spawnturret("misc_turret", var_22 gettagorigin("tag_turret_rear"), "chopper_support_turret_mp");
  var_22.rearturret setModel(var_23);
  var_22.rearturret.owner = var_0;
  var_22.rearturret.team = var_0.team;
  var_22.rearturret.angles = var_22.angles;
  var_22.rearturret.streakinfo = var_1;
  var_22.rearturret.turreton = 1;
  var_22.rearturret.name = "rear_turret";
  var_22.rearturret.attackingtarget = undefined;
  var_22.rearturret linkTo(var_22);
  var_22.rearturret setturretteam(var_0.team);
  var_22.rearturret setturretmodechangewait(0);
  var_22.rearturret setmode("manual");
  var_22.rearturret setotherent(var_0);
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

function startchopper(var_0, var_1) {
  self endon("death");
  self setvehgoalpos(self.pathgoal, 1);
  var_2 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](var_0, var_1.streakname);
    var_2 = 2;
  }

  var_0 thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var_1.streakname, 1, var_2);
  thread choppersupport_monitorowner();
  thread choppersupport_neargoalsettings();
  self playsoundonmovingent("ks_chopper_support_approach");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]](&choppersupport_handlemissiledetection);
    return;
  }
}

function choppersupport_monitorowner() {
  self endon("death");
  self endon("leaving");

  if(!isDefined(self.owner) || self.owner.team != self.team) {
    thread choppersupport_leave();
    return;
  }

  self.owner scripts\engine\utility::ref_143a5("joined_team", "disconnect");
  thread choppersupport_leave();
}

function choppersupport_neargoalsettings() {
  self endon("leaving");
  self endon("death");
  self waittill("near_goal");
  self vehicle_setspeed(int(self.speed / 2), int(self.accel / 3));
  thread choppersupport_watchlifetime();
  thread choppersupport_watchdestoyed();
  thread choppersupport_watchgameendleave();
  thread grab_players_inside();
  thread choppersupport_patrolfield(1);
  thread choppersupport_engageturrettarget(self.frontturret);
  thread choppersupport_engageturrettarget(self.rearturret);
}

function choppersupport_handlemissiledetection(var_0, var_1, var_2, var_3) {
  self endon("death");

  for(;;) {
    if(!isDefined(var_2)) {
      break;
    }

    var_4 = var_2 getpointinbounds(0, 0, 0);
    var_5 = distance(self.origin, var_4);

    if(var_5 < 4000 && var_2.flaresreservecount > 0) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "reduceReserves")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "reduceReserves")]](var_2);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "playFx")) {
        var_2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "playFx")]](undefined, var_3);
      }

      if(isDefined(var_2.streakinfo)) {
        var_2 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_support_flares");
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

function choppersupport_engageturrettarget(var_0) {
  self endon("leaving");
  self endon("death");

  for(;;) {
    if(!istrue(var_0.turreton) || istrue(var_0.ref_13e86)) {
      waitframe();
      continue;
    }

    var_1 = choppersupport_gettargets(var_0, 6000, 1, 1);

    if(isDefined(var_1) && var_1.size > 0) {
      var_2 = choppersupport_acquireturrettarget(var_0, var_1);

      if(isDefined(var_2) && var_2 == "stopped_firing") {
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
      }

      if(!choppersupport_checkifactivetargets()) {
        if(istrue(self.chopper_boss_explosion) && isDefined(self.intro_enemy_respawner)) {
          self thread[[self.intro_enemy_respawner]]();
        } else if(isDefined(self.ref_1220c)) {
          self thread[[self.ref_1220c]]();
        } else {
          thread choppersupport_patrolfield();
        }
      }
    }

    wait 0.05;
  }
}

function choppersupport_acquireturrettarget(var_0, var_1) {
  self notify("engaging_target");
  var_2 = undefined;
  var_3 = choppersupport_getbesttarget(var_0, var_1);
  var_4 = var_3[0];
  var_5 = var_3[1];
  var_6 = var_3[2];
  var_3 = undefined;

  if(isDefined(var_4)) {
    var_7 = undefined;

    if(istrue(var_6)) {
      var_7 = var_4 scripts\cp_mp\utility\player_utility::getvehicle();
    }

    choppersupport_setcurrenttarget(var_0, var_4);

    if(istrue(var_5) && self.currenttarget == var_4 && !istrue(self.chopper_boss_explosion)) {
      self thread[[level.grenade_effect]](var_4, 1);
    }

    choppersupport_fireonturrettarget(var_0, var_4, var_7, 1, var_5);
    var_2 = "stopped_firing";
  } else {
    var_2 = "continue_searching";
  }

  return var_2;
}

function choppersupport_setcurrenttarget(var_0, var_1) {
  var_0 settargetentity(var_0.groundtargetent);
  var_0.attackingtarget = var_1;

  if(!isDefined(self.currenttarget)) {
    self.currenttarget = var_1;
    self setlookatent(self.currenttarget);
    return;
  }
}

function choppersupport_clearcurrenttarget(var_0) {
  if(isDefined(self.currenttarget) && self.currenttarget == var_0.attackingtarget) {
    self.currenttarget = undefined;
  }

  if(istrue(var_0.ref_13a71)) {
    var_0.ref_13a71 = undefined;
  }

  var_0.attackingtarget = undefined;
  var_0 cleartargetentity();
  var_0.groundtargetent unlink();
  var_1 = choppersupport_getactivetargets();

  if(self.currentaction != "patrol") {
    if(var_1.size == 0) {
      self clearlookatent();
    }
  }

  var_0 notify("lost_target");
}

function choppersupport_fireonturrettarget(var_0, var_1, var_2, var_3, var_4) {
  if(self.currentaction != "attacking") {
    self.currentaction = "attacking";
  }

  if(istrue(var_3) && isDefined(self.owner) && self.owner scripts\cp_mp\utility\player_utility::_isalive() && (!isDefined(self.lastfiretime) || self.lastfiretime + 15000 <= gettime())) {
    scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_support_engage_target");
    self.lastfiretime = gettime();
  }

  choppersupport_watchforlosttarget(var_0);
  thread greenlight(var_0);
  thread choppersupport_watchtargetlos(var_0, var_2);
  thread choppersupport_watchtargettimeout(var_0);
  thread grab_entities_inside(var_0);
  var_5 = weaponfiretime("chopper_support_turret_mp");
  var_6 = 0;
  var_7 = 100;

  if(isDefined(self.ref_13766)) {
    var_7 = self.ref_13766;
  }

  var_8 = 20;

  if(isDefined(self.ref_11c43)) {
    var_8 = self.ref_11c43;
  }

  var_9 = 40;

  if(isDefined(self.ref_11c44)) {
    var_9 = self.ref_11c44;
  }

  if(istrue(var_4)) {
    var_10 = 3750;

    while(istrue(goalyaw(var_0, var_1))) {
      if(distance2dsquared(self.origin, var_1.origin) < var_10 * var_10) {
        break;
      }

      waitframe();
    }
  }

  thread grenade_chances(var_0);

  while(istrue(goalyaw(var_0, var_1))) {
    if(istrue(var_0.ref_13a71)) {
      if(isDefined(self.currenttarget) && var_1 == self.currenttarget && !istrue(self.chopper_boss_explosion)) {
        self[[level.grenade_effect]](self.currenttarget, 1);
      } else {
        var_0 notify("chopperSupport_targetBrokeLOS");
      }
    } else if(choppersupport_turretlookingattarget(var_0)) {
      var_11 = undefined;

      if(isDefined(var_2)) {
        var_11 = var_1.origin;
      } else {
        var_11 = var_1 gettagorigin("j_mainroot");
      }

      choppersupport_setattackpoint(var_0, var_1, var_11, var_7);

      if(var_6 == var_8) {
        var_7 = 50;

        if(isDefined(self.ref_13767)) {
          var_7 = self.ref_13767;
        }
      } else if(var_6 == var_9) {
        var_7 = undefined;

        if(isDefined(self.ref_13768)) {
          var_7 = self.ref_13768;
        }
      }

      var_0 shootturret("tag_flash");
      var_6++;

      if(isDefined(var_0.streakinfo)) {
        var_0.streakinfo.shots_fired++;
      }
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_5);
  }
}

function goalyaw(var_0, var_1) {
  return isDefined(self) && isDefined(var_0) && isDefined(var_1) && !isDefined(self.iscrashing) && !isDefined(self.isleaving) && isDefined(var_0.attackingtarget);
}

function choppersupport_setattackpoint(var_0, var_1, var_2, var_3) {
  var_4 = var_2;

  if(isDefined(var_3)) {
    var_5 = [self, var_0];
    var_6 = randomint(var_3);
    var_7 = randomint(360);
    var_8 = var_2[0] + var_6 * cos(var_7);
    var_9 = var_2[1] + var_6 * sin(var_7);
    var_10 = var_2[2];
    var_4 = (var_8, var_9, var_10);
    var_0.groundtargetent.origin = var_4;
    return;
  }

  if(!var_0.groundtargetent islinked()) {
    var_0.groundtargetent linkTo(var_1, "tag_origin", (0, 0, 30), (0, 0, 0));
    return;
  }
}

function choppersupport_turretlookingattarget() {
  var_0 = 0.992;
  var_1 = anglesToForward(self gettagangles("tag_flash"));
  var_2 = vectorNormalize(self.groundtargetent.origin - self.origin);
  var_3 = vectordot(var_1, var_2);

  if(isDefined(self gettargetentity(1)) && var_3 >= var_0) {
    return true;
  }

  return false;
}

function choppersupport_watchforlosttarget(var_0) {
  thread choppersupport_watchforlosttargetaction(var_0, "death_or_disconnect");
  thread choppersupport_watchforlosttargetaction(var_0, "chopperSupport_maxAggroRange");
  thread choppersupport_watchforlosttargetaction(var_0, "chopperSupport_targetLeftRange");
  thread choppersupport_watchforlosttargetaction(var_0, "chopperSupport_targetBrokeLOS");
  thread choppersupport_watchforlosttargetaction(var_0, "chopperSupport_targetTimeout");
  thread choppersupport_watchforlosttargetaction(var_0, "chopperSupport_targetLastStand");
}

function choppersupport_watchforlosttargetaction(var_0, var_1) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  self endon("crashing");
  var_0 endon("lost_target");
  var_2 = var_0;

  if(var_1 == "death_or_disconnect") {
    var_2 = var_0.attackingtarget;
  }

  var_2 waittill(var_1);
  choppersupport_clearcurrenttarget(var_0);
}

function greenlight(var_0) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  var_0 endon("lost_target");

  if(!scripts\cp_mp\utility\game_utility::update_ai_volumes()) {
    return;
  }

  var_1 = self.pathgoal;

  for(;;) {
    if(isDefined(var_0.attackingtarget)) {
      if(distance2dsquared(var_1, self.origin) > 100000000) {
        if(!istrue(self.spawn_lbravo)) {
          self.spawn_lbravo = 1;
        }

        var_0 notify("chopperSupport_maxAggroRange");
        break;
      }
    }

    waitframe();
  }
}

function grenade_chances(var_0) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  var_0 endon("lost_target");

  for(;;) {
    if(isDefined(var_0.attackingtarget)) {
      var_1 = var_0.attackingtarget;

      if(distance2dsquared(var_0.origin, var_1.origin) > 20250000) {
        wait 2;
        var_0 notify("chopperSupport_targetLeftRange");
        break;
      }
    }

    waitframe();
  }
}

function choppersupport_watchtargetlos(var_0, var_1) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  var_0 endon("lost_target");
  var_2 = undefined;
  var_3 = 500;
  var_4 = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);
  var_5 = [var_0];

  if(isDefined(var_1)) {
    GscBinSkip0(0x2e, var_5.size, var_1);
  }

  for(;;) {
    if(!istrue(var_0.ref_13a71) && isDefined(var_0.attackingtarget)) {
      var_7 = scripts\engine\trace::ray_trace_passed(var_0 gettagorigin("tag_barrel"), var_0.attackingtarget gettagorigin("j_head"), var_5, var_4);

      if(!istrue(var_7)) {
        if(!isDefined(var_2)) {
          var_2 = gettime();
        }

        if(gettime() - var_2 > var_3) {
          var_0.ref_13a71 = 1;
        }
      } else {
        var_2 = undefined;
      }
    }

    wait 0.25;
  }
}

function choppersupport_watchtargettimeout(var_0) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  var_0 endon("lost_target");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  var_0 notify("chopperSupport_targetTimeout");
}

function grab_entities_inside(var_0) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  var_0 endon("lost_target");

  for(;;) {
    if(isDefined(var_0.attackingtarget) && istrue(var_0.attackingtarget.inlaststand)) {
      var_0 notify("chopperSupport_targetLastStand");
      break;
    }

    waitframe();
  }
}

function choppersupport_isactivetarget(var_0) {
  var_1 = 0;

  if(!isDefined(var_0)) {
    return 0;
  }

  if(isDefined(self.frontturret.attackingtarget)) {
    if(self.frontturret.attackingtarget == var_0) {
      var_1 = 1;
    }
  }

  if(isDefined(self.rearturret.attackingtarget)) {
    if(self.rearturret.attackingtarget == var_0) {
      var_1 = 1;
    }
  }

  return var_1;
}

function choppersupport_checkifactivetargets() {
  return isDefined(self.frontturret.attackingtarget) || isDefined(self.rearturret.attackingtarget);
}

function choppersupport_getactivetargets() {
  var_0 = [];

  if(isDefined(self.frontturret.attackingtarget)) {
    GscBinSkip0(0x2e, var_0.size, self.frontturret.attackingtarget);
  }

  if(isDefined(self.rearturret.attackingtarget)) {
    GscBinSkip0(0x2e, var_0.size, self.rearturret.attackingtarget);
  }

  return var_0;
}

function choppersupport_patrolfield(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self endon("engaging_target");

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
  }

  if(isDefined(self.ref_1220c)) {
    self[[self.ref_1220c]](var_0);
    return;
  }

  if(self.currentaction != "patrol") {
    self.currentaction = "patrol";
  } else if(self.currentaction == "patrol" && !istrue(var_0)) {
    return;
  }

  self clearlookatent();
  var_1 = 500;

  if(goodjobplayer()) {
    var_1 = 50;
  }

  self setneargoalnotifydist(var_1);
  var_2 = 0;

  for(;;) {
    if(self.currentaction == "attacking") {
      if(!istrue(var_2)) {
        var_2 = 1;
      }

      waitframe();
      continue;
    }

    if(!istrue(var_0) && istrue(var_2)) {
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_support_patrol");
      var_2 = 0;
    }

    var_3 = choppersupport_findclosestpatrolstruct();

    if(isDefined(var_3) && !istrue(self.chopper_boss_explosion)) {
      self[[level.grenade_effect]](var_3, 1);
    } else {
      var_5 = [];
      var_6 = (0, 0, 0);
      var_7 = self.pathgoal;

      foreach(var_9 in level.players) {
        if(var_9 == self.owner) {
          continue;
        }

        if(level.teambased && var_9.team == self.owner.team) {
          continue;
        }

        if(!var_9 scripts\cp_mp\utility\player_utility::_isalive()) {
          continue;
        }

        var_6 += var_9.origin;
        var_5 = var_9;
      }

      if(isDefined(var_6) && var_5.size > 0 && !istrue(self.chopper_boss_explosion)) {
        var_11 = var_6 / var_5.size;
        self[[level.grenade_effect]](var_11);
      }
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
  }
}

function choppersupport_findclosestpatrolstruct() {
  var_0 = scripts\engine\utility::array_combine(level.heli_structs_goals, level.heli_structs_paths);
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_0) {
    if(isDefined(self.currentpatrolstruct) && var_5 == self.currentpatrolstruct) {
      continue;
    }

    var_6 = distance2dsquared(var_5.origin, self.origin);

    if(!isDefined(var_3) || var_6 < var_3) {
      var_3 = var_6;
      var_2 = var_5;
    }
  }

  if(isDefined(var_2)) {
    var_1 = choppersupport_findtargetStruct(var_2.script_linkto, var_0);
    self.currentpatrolstruct = var_2;
  }

  return var_1;
}

function choppersupport_canseeenemy(var_0) {
  var_1 = 0;
  var_2 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0);
  var_3 = [var_0 gettagorigin("j_head"), var_0 gettagorigin("j_mainroot"), var_0 gettagorigin("tag_origin")];

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(!scripts\engine\trace::ray_trace_passed(self.origin, var_3[var_4], self, var_2)) {
      continue;
    }

    var_1 = 1;
    break;
  }

  return var_1;
}

function choppersupport_movetolocation(var_0, var_1) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  var_2 = undefined;
  var_3 = var_0;

  if(!isvector(var_0)) {
    var_3 = var_0.origin;
  }

  var_4 = [self, self.frontturret, self.rearturret];

  for(;;) {
    var_5 = self.origin;
    var_6 = var_3 * (1, 1, 0) + (0, 0, self.origin[2]);
    var_7 = scripts\engine\trace::sphere_trace(var_5, var_6, 256, var_4);
    var_8 = 0;
    var_9 = var_3[0];
    var_10 = var_3[1];

    if(isDefined(var_7)) {
      if(var_7["hittype"] != "hittype_none") {
        var_9 = var_7["position"][0];
        var_10 = var_7["position"][1];
        var_8 = 1;
      }
    }

    if(istrue(self.evasivemaneuvers)) {
      var_11 = var_9 + randomintrange(-500, 500);
      var_12 = var_10 + randomintrange(-500, 500);
      var_13 = getcorrectheight(var_11, var_12, 350);
      var_2 = (var_11, var_12, var_13);
    } else {
      var_13 = getcorrectheight(var_9, var_10, 20);
      var_2 = (var_9, var_10, var_13);
    }

    var_14 = 0;

    if(istrue(var_1) && !istrue(var_8)) {
      var_14 = var_1;
    }

    self setvehgoalpos(var_2, var_14);
    scripts\engine\utility::ref_143a5("near_goal", "begin_evasive_maneuvers");

    if(!istrue(var_8)) {
      break;
    }
  }
}

function debugtimedelta(var_0, var_1) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  var_2 = undefined;
  var_3 = var_0;

  if(!isvector(var_0)) {
    var_3 = var_0.origin;
  }

  if(getdvarint("scr_chopper_support_use_min_spacing") > 0) {
    var_3 = going_to(var_3);
  }

  var_4 = [self, self.frontturret, self.rearturret];

  for(;;) {
    var_5 = self.origin;
    var_6 = var_3;

    if(istrue(self.chopper_boss_explosion) && isDefined(self.intro_driver_logic)) {
      break;
    }

    var_7 = 20;
    var_8 = scripts\engine\utility::ter_op(istrue(self.evasivemaneuvers), 350, var_7);
    var_9 = getcorrectheight(var_3[0], var_3[1], var_8);
    var_6 = (var_6[0], var_6[1], var_9);
    var_10 = 512;
    var_11 = scripts\engine\trace::sphere_trace(var_5, var_6, var_10, var_4);
    var_12 = 0;
    var_13 = var_6[0];
    var_14 = var_6[1];
    var_15 = var_6[2];

    if(isDefined(var_11)) {
      if(var_11["hittype"] != "hittype_none") {
        var_13 = var_11["position"][0];
        var_14 = var_11["position"][1];
        var_15 = getcorrectheight(var_13, var_14, var_8);
        var_12 = 1;
      }
    }

    if(istrue(self.evasivemaneuvers)) {
      var_13 += randomintrange(-500, 500);
      var_14 += randomintrange(-500, 500);
      var_15 = getcorrectheight(var_13, var_14, var_8);
    }

    var_16 = 0;

    if(istrue(var_1) && !istrue(var_12)) {
      var_16 = var_1;
    }

    var_2 = (var_13, var_14, var_15);
    self setvehgoalpos(var_2, var_16);
    scripts\engine\utility::ref_143a5("near_goal", "begin_evasive_maneuvers");

    if(!istrue(var_12)) {
      break;
    }
  }
}

function going_to(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  if(!isDefined(level.ref_119e7) || level.ref_119e7.size == 0) {
    return var_0;
  }

  var_1 = 0;
  var_2 = var_0[2];
  var_3 = getdvarfloat("scr_chopper_support_min_spacing", 1500);
  var_4 = 0;

  while(!var_4 && var_1 < 360) {
    for(var_5 = 0; var_5 < level.ref_119e7.size; var_5++) {
      if(self == level.ref_119e7[var_5]) {
        continue;
      }

      var_4 = distance2d(var_0, level.ref_119e7[var_5].pathgoal) >= var_3;

      if(!var_4) {
        break;
      }
    }

    if(var_4) {
      return var_0;
    }

    var_1 += 10;
    var_0 = rotatepointaroundvector(self.ref_1220d, var_0, var_1);
    var_0 = (var_0[0], var_0[1], var_2);
  }

  return var_0;
}

function choppersupport_leave() {
  self endon("death");
  self playsoundonmovingent("ks_chopper_support_leave");
  self setmaxpitchroll(0, 0);
  self notify("leaving");
  self.isleaving = 1;
  self clearlookatent();
  var_0 = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
  var_0 += (0, 0, 1000);
  self setvehgoalpos(var_0, 1);
  self setneargoalnotifydist(100);
  self waittill("near_goal");
  var_1 = getpathend();
  self setmaxpitchroll(15, 15);
  self vehicle_setspeed(self.speed, self.accel);
  self setvehgoalpos(var_1, 1);
  self waittill("goal");
  self stoploopsound();
  self notify("chopperSupport_gone");
  thread choppersupport_cleanup();
}

function choppersupport_cleanup(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - jackal", self.owner);
  }

  if(isDefined(self.frontturret)) {
    self.frontturret setentityowner(undefined);
    self.frontturret.groundtargetent delete();
    self.frontturret delete();
  }

  if(isDefined(self.rearturret)) {
    self.rearturret setentityowner(undefined);
    self.rearturret.groundtargetent delete();
    self.rearturret delete();
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  if(isDefined(self.has_ammo_drain_passive)) {
    self[[self.has_ammo_drain_passive]]();
  }

  if(isDefined(self.streakinfo)) {
    self.streakinfo.onspray = istrue(var_0);
  }

  if(!istrue(self.ref_12aa4)) {
    if(isDefined(self.streakinfo)) {
      self.owner scripts\cp_mp\utility\killstreak_utility::ref_12aa7(self.streakinfo);
    }
  }

  if(isDefined(level.choppersupports)) {
    level.choppersupports = scripts\engine\utility::array_remove(level.choppersupports, self);
  }

  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function choppersupport_watchlifetime() {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(self.lifetime);
  thread choppersupport_leave();
}

function choppersupport_watchgameendleave() {
  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
  }

  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level waittill("game_ended");
  self.ref_12aa4 = 1;

  if(isDefined(self.streakinfo)) {
    self.owner scripts\cp_mp\utility\killstreak_utility::ref_12aa7(self.streakinfo);
  }

  thread choppersupport_leave();
}

function grab_players_inside() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  if(!scripts\cp_mp\utility\game_utility::update_ai_volumes()) {
    return;
  }

  for(;;) {
    if(istrue(self.spawn_lbravo)) {
      self.frontturret.turreton = 0;
      self.rearturret.turreton = 0;
      var_0 = 8000;

      for(;;) {
        if(distance2dsquared(self.origin, self.pathgoal) <= var_0 * var_0) {
          self.spawn_lbravo = undefined;
          self.frontturret.turreton = 1;
          self.rearturret.turreton = 1;
          break;
        }

        waitframe();
      }
    }

    waitframe();
  }
}

function choppersupport_gettargets(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("leaving");
  var_4 = [];
  var_5 = level.players;

  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    var_6 = 4500;

    if(isDefined(var_1)) {
      var_6 = var_1;
    }

    var_5 = scripts\common\utility::playersinsphere(self.origin, var_6);
  }

  for(var_7 = 0; var_7 < var_5.size; var_7++) {
    var_8 = var_5[var_7];
    var_9 = choppersupport_istarget(var_0, var_8, var_2, var_3);
    var_10 = var_9[0];
    var_11 = var_9[1];
    var_12 = var_9[2];
    var_9 = undefined;

    if(istrue(var_10)) {
      var_13 = spawnStruct();
      var_13.player = var_8;
      var_13.ref_12fa2 = var_11;
      var_13.ref_13a93 = var_12;
      var_4 = var_13;
    } else {
      continue;
    }

    wait 0.05;
  }

  return var_4;
}

function choppersupport_istarget(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("leaving");

  if(isDefined(self.va_standard_spawnpoint_valid) && ![[self.va_standard_spawnpoint_valid]](var_1)) {
    return [0, 0, 0];
  }

  if(!goliath_init(var_1)) {
    return [0, 0, 0];
  }

  if(isDefined(self.owner) && var_1 == self.owner) {
    return [0, 0, 0];
  }

  if(!isDefined(var_1.pers["team"])) {
    return [0, 0, 0];
  }

  if(level.teambased && var_1.pers["team"] == self.team) {
    return [0, 0, 0];
  }

  if(var_1.pers["team"] == "spectator") {
    return [0, 0, 0];
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    if(var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_blindeye")) {
      return [0, 0, 0];
    }
  }

  if(istrue(var_1.inlaststand)) {
    return [0, 0, 0];
  }

  if(scripts\cp_mp\parachute::isparachutegametype() && (var_1 isparachuting() || var_1 isskydiving())) {
    return [0, 0, 0];
  }

  var_5 = 0;

  if(istrue(var_2)) {
    if(distance2dsquared(self.origin, var_1.origin) > 20250000) {
      if(distance2dsquared(self.origin, var_1.origin) > 36000000) {
        return [0, 0, 0];
      }

      var_5 = 1;
    }
  }

  var_6 = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);
  var_7 = [var_0];
  var_8 = 0;

  if(istrue(var_3)) {
    var_8 = var_1 scripts\cp_mp\utility\player_utility::isinvehicle();

    if(istrue(var_8)) {
      var_9 = var_1 scripts\cp_mp\utility\player_utility::getvehicle();
      var_7 = var_9;
      var_10 = var_9 getlinkedchildren();

      if(isDefined(var_10) && var_10.size > 0) {
        var_7 = scripts\engine\utility::array_combine(var_7, var_10);
      }
    }
  }

  var_11 = scripts\engine\trace::ray_trace_passed(var_0 gettagorigin("tag_barrel"), var_1 gettagorigin("j_head"), var_7, var_6);

  if(!istrue(var_11)) {
    return [0, 0, 0];
  }

  return [1, var_5, var_8];
}

function goliath_init(var_0) {
  return isDefined(var_0) && var_0 scripts\cp_mp\utility\player_utility::_isalive() && var_0.sessionstate == "playing";
}

function choppersupport_getbesttarget(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  foreach(var_7 in var_1) {
    if(!goliath_init(var_7.player)) {
      continue;
    }

    if(choppersupport_isactivetarget(var_7.player) && !istrue(var_7.ref_13a93)) {
      continue;
    }

    var_8 = 0;
    var_9 = 0;
    var_10 = abs(vectortoangles(var_7.player.origin - self.origin)[1]);
    var_11 = abs(self gettagangles("tag_flash")[1]);
    var_10 = abs(var_10 - var_11);
    var_12 = var_7.player getweaponslistitems();

    foreach(var_14 in var_12) {
      var_15 = weaponclass(var_14);

      if(var_15 == "rocketlauncher") {
        var_10 -= 40;
      }
    }

    if(istrue(var_7.ref_12fa2)) {
      var_8 = 1;
      var_10 += 40;
    }

    if(istrue(var_7.ref_13a93)) {
      var_9 = 1;
      var_10 += 20;
    }

    if(!isDefined(var_2) || var_2 > var_10) {
      var_2 = var_10;
      var_3 = var_7.player;
      var_5 = var_9;
      var_4 = var_8;
    }
  }

  return [var_3, var_4, var_5];
}

function getcorrectheight(var_0, var_1, var_2) {
  var_3 = self.heightoffset[2];
  var_4 = tracegroundpoint(var_0, var_1);
  var_5 = var_4 + var_3;
  var_5 += randomint(var_2);
  return var_5;
}

function choppersupport_watchdestoyed() {
  level endon("game_ended");
  self endon("chopperSupport_gone");
  var_0 = self.owner;
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "isKillstreakWeapon")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "isKillstreakWeapon")]](self.killedbyweapon)) {
      choppersupport_crash(100);
    }
  }

  choppersupport_explode();
}

function choppersupport_explode() {
  self notify("explode");
  self radiusdamage(self.origin, 1000, 200, 200, self.owner, "MOD_EXPLOSIVE", "chopper_support_turret_mp");
  self setscriptablepartstate("explode", "on", 0);

  if(isDefined(self.intermissionspawntime)) {
    [[self.intermissionspawntime]]();
  }

  if(isDefined(self.lootfunc)) {
    self[[self.lootfunc]]();
  }

  wait 0.35;
  choppersupport_cleanup(1);
}

function choppersupport_crash(var_0) {
  var_1 = 0;
  self endon("explode");
  self setscriptablepartstate("crash", "on", 0);

  if(isDefined(self.killcament)) {
    self.killcament unlink();
    self.killcament.origin = self.origin + (0, 0, 100);
  }

  self clearlookatent();
  self notify("crashing");
  self.iscrashing = 1;
  self vehicle_setspeed(var_0, 20, 20);
  self setneargoalnotifydist(100);
  var_2 = undefined;

  if(istrue(self.chopper_boss_explosion) && isDefined(self.interaction_is_floor_is_lava_client)) {
    self setneargoalnotifydist(300);
    var_1 = 1;
    var_2 = [[self.interaction_is_floor_is_lava_client]]();
  } else {
    var_2 = choppersupport_findcrashposition(3500, 500, 1000);
  }

  if(!isDefined(var_2)) {
    return;
  }

  if(istrue(level.ref_14088) && isscriptabledefined()) {
    var_3 = getclosestpointonnavmesh(var_2);
    var_2 = goto_goal_and_snipe(var_3 + (0, 0, 1500), var_3);
  }

  if(isDefined(self.streakinfo)) {
    scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_support_crash", 1);
  }

  self setvehgoalpos(var_2, var_1);
  thread choppersupport_spinout(var_0);
  self vehicle_turnengineoff();
  self waittill("near_goal");

  if(isDefined(self.streakinfo)) {
    scripts\cp_mp\utility\dialog_utility::playoperatorstaticinterrupt();
    return;
  }
}

function choppersupport_findcrashposition(var_0, var_1, var_2) {
  var_3 = self.origin;
  var_4 = self.infil_complete;
  var_5 = undefined;
  var_6 = anglesToForward(self.angles);
  var_7 = anglestoright(self.angles);
  var_8 = var_3 + var_6 * var_0 - (0, 0, var_4);

  if(scripts\engine\trace::ray_trace_passed(var_3, var_8, self)) {
    var_5 = var_8;
    return var_5;
  }

  var_8 = var_3 - var_6 * var_0 - (0, 0, var_4);

  if(scripts\engine\trace::ray_trace_passed(var_3, var_8, self)) {
    var_5 = var_8;
    return var_5;
  }

  var_8 = var_3 + var_7 * var_0 - (0, 0, var_4);

  if(scripts\engine\trace::ray_trace_passed(var_3, var_8, self)) {
    var_5 = var_8;
    return var_5;
  }

  var_8 = var_3 - var_7 * var_0 - (0, 0, var_4);

  if(scripts\engine\trace::ray_trace_passed(var_3, var_8, self)) {
    var_5 = var_8;
    return var_5;
  }

  var_8 = var_3 + 0.707 * var_0 * (var_6 + var_7) - (0, 0, var_4);

  if(scripts\engine\trace::ray_trace_passed(var_3, var_8, self)) {
    var_5 = var_8;
    return var_5;
  }

  var_8 = var_3 + 0.707 * var_0 * (var_6 - var_7) - (0, 0, var_4);

  if(scripts\engine\trace::ray_trace_passed(var_3, var_8, self)) {
    var_5 = var_8;
    return var_5;
  }

  var_8 = var_3 + 0.707 * var_0 * (var_7 - var_6) - (0, 0, var_4);
  var_9 = scripts\engine\trace::ray_trace(var_3, var_8, self);

  if(scripts\engine\trace::ray_trace_passed(var_3, var_8, self)) {
    var_5 = var_8;
    return var_5;
  }

  var_8 = var_3 + 0.707 * var_0 * (-1 * var_6 - var_7) - (0, 0, var_4);

  if(scripts\engine\trace::ray_trace_passed(var_3, var_8, self)) {
    var_5 = var_8;
    return var_5;
  }

  return var_5;
}

function goto_goal_and_snipe(var_0, var_1) {
  var_2 = var_1;
  var_3 = 335;
  var_4 = [self, self.frontturret, self.rearturret];
  var_5 = scripts\engine\trace::sphere_trace(var_0, var_1, var_3, var_4);

  if(isDefined(var_5) && var_5["hittype"] != "hittype_none") {
    var_2 = var_5["position"];
  }

  return var_2;
}

function choppersupport_spinout(var_0) {
  self endon("death");
  self setyawspeed(var_0, 50, 50, 0.5);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + var_0 * 0.4);
    wait 0.5;
  }
}

function tracenewpoint(var_0, var_1, var_2) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  self endon("randMove");
  var_3 = scripts\engine\trace::sphere_trace(self.origin, (var_0, var_1, var_2), 256, self, undefined, 1);

  if(var_3["surfacetype"] != "surftype_none") {
    return 0;
  }

  var_4 = (var_0, var_1, var_2);
  return var_4;
}

function tracegroundpoint(var_0, var_1) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  var_2 = -99999;
  var_3 = self.origin[2] + 2000;
  var_4 = level.averagealliesz;
  var_5 = [self];

  if(isDefined(self.dropcrates)) {
    foreach(var_7 in self.dropcrates) {
      var_5 = var_7;
    }
  }

  var_9 = scripts\engine\trace::sphere_trace((var_0, var_1, var_3), (var_0, var_1, var_2), 800, var_5, undefined, 1);

  if(var_9["position"][2] < var_4) {
    var_10 = var_4;
  } else {
    var_10 = var_10["position"][2];
  }

  return var_10;
}

function beginevasivemaneuvers() {
  self endon("death");
  self notify("begin_evasive_maneuvers");
  self endon("begin_evasive_maneuvers");
  self.evasivemaneuvers = 1;
  var_0 = scripts\engine\utility::ref_143b9(3, "death");

  if(var_0 == "timeout") {
    self.evasivemaneuvers = 0;
    return;
  }
}

function getcorrectheightescort(var_0, var_1, var_2, var_3) {
  var_4 = 200;

  if(isDefined(var_3)) {
    var_4 = var_3;
  }

  var_5 = tracegroundpoint(var_0, var_1);
  var_6 = var_5 + var_4;
  var_6 += randomint(var_2);
  return var_6;
}

function choppersupport_modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  self.currenthealth = self.health - var_4;

  if(self.currenthealth <= 1500 && self.currentdamagestate == 0) {
    self.currentdamagestate = 1;
    self setscriptablepartstate("body_damage_light", "on");

    if(isDefined(self.streakinfo)) {
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_support_light_damage");
    }
  } else if(self.currenthealth <= 1000 && self.currentdamagestate == 1) {
    self.currentdamagestate = 2;
    self setscriptablepartstate("body_damage_medium", "on");

    if(isDefined(self.streakinfo)) {
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_support_med_damage");
    }
  } else if(self.currenthealth <= 500 && self.currentdamagestate == 2) {
    self.currentdamagestate = 3;
    self setscriptablepartstate("body_damage_heavy", "on");

    if(isDefined(self.streakinfo)) {
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_support_heavy_damage");
    }
  }

  return true;
}

function choppersupport_handledeathdamage(var_0) {
  self.killedbyweapon = var_0.objweapon;

  if(istrue(self.usefuncoverride) && isDefined(level.ref_13457)) {
    if(isDefined(var_0.objweapon)) {
      [[level.ref_13457.ref_1346a]](var_0.objweapon.basename);
    } else {
      [[level.ref_13457.ref_1346a]]("none");
    }
  }

  return true;
}

function choppersipport_randommovement() {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  self.lastaction = "randomMovement";
  var_0 = self.defendloc;
  var_1 = getrandompoint(self.origin);
  self setvehgoalpos(var_1, 1);
  thread scripts\cp_mp\utility\debug_utility::drawline(self.origin, var_1, 5, (1, 0, 1));
  self waittill("goal");
}

function getrandompoint(var_0) {
  self clearlookatent();

  if(distance2dsquared(self.origin, self.owner.origin) > 4194304) {
    var_1 = self.owner.origin[0];
    var_2 = self.owner.origin[1];
    var_3 = getcorrectheight(var_1, var_2, 20);
    var_4 = (var_1, var_2, var_3);
    self setlookatent(self.owner);
    return var_4;
  }

  var_5 = self.angles[1];
  var_6 = int(var_5 - 60);
  var_7 = int(var_5 + 60);
  var_8 = randomintrange(var_6, var_7);
  var_9 = (0, var_8, 0);
  [var_11] = self.origin + anglesToForward(var_9) * randomintrange(400, 800);
  var_12 = var_10[1];
  var_13 = getcorrectheight(var_11, var_12, 20);
  var_14 = tracenewpoint(var_11, var_12, var_13);

  if(var_14 != 0) {
    return var_14;
  }

  var_11 = randomfloatrange(var_4[0] - 1200, var_4[0] + 1200);
  var_12 = randomfloatrange(var_4[1] - 1200, var_4[1] + 1200);
  var_15 = (var_11, var_12, var_13);
  return var_15;
}

function getnewpoint(var_0, var_1) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = [];

  foreach(var_4 in level.players) {
    if(var_4 == self) {
      continue;
    }

    if(!level.teambased || var_4.team != self.team) {
      var_2 = var_4.origin;
    }
  }

  jumpiffalse(var_2.size > 0) LOC_0000009a;
  [var_7] = averagepoint(var_2);
  var_8 = var_6[1];
  goto LOC_000000d1;
}

function getpathstart(var_0) {
  var_1 = 100;
  var_2 = 15000;
  var_3 = randomfloat(360);
  var_4 = (0, var_3, 0);
  var_5 = var_0 + anglesToForward(var_4) * -1 * var_2;
  var_5 += ((randomfloat(2) - 1) * var_1, (randomfloat(2) - 1) * var_1, 0);
  return var_5;
}

function getpathend() {
  var_0 = 150;
  var_1 = 15000;
  var_2 = self.angles[1];
  var_3 = (0, var_2, 0);
  var_4 = self.origin + anglesToForward(var_3) * var_1;
  return var_4;
}

function choppersupport_findtargetStruct(var_0, var_1) {
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(var_4.script_linkname == var_0) {
      var_2 = var_4;
      break;
    }
  }

  return var_2;
}

function goodjobplayer() {
  var_0 = 0;

  switch (level.mapname) {
    case "mp_m_speed":
    case "mp_shipment":
      var_0 = 1;
      break;
  }

  return var_0;
}