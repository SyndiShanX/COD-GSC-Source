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

function tryusechoppersupport(var0) {
  var1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(var0, self);
  return tryusechoppersupportfromstruct(var1);
}

function tryusechoppersupportfromstruct(var0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var0)) {
      return 0;
    }
  }

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    return 0;
  }

  var1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(var0, getcompleteweaponname("ks_gesture_generic_mp"));

  if(!istrue(var1)) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return 0;
  }

  level.incomingallchoppersupports++;
  var2 = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    var2 = 2;
  }

  if(level.choppersupports.size >= var2 || level.choppersupports.size + level.incomingallchoppersupports > var2) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    level.incomingallchoppersupports--;
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return 0;
  }

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased) {
    var3 = 1;
    level.incomingchoppersupports[self.team]++;

    if(scripts\cp_mp\utility\killstreak_utility::getnumactivekillstreakperteam(self.team, level.choppersupports) + level.incomingchoppersupports[self.team] > var3) {
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
    if(!level[[level.killstreakbeginusefunc]](var0)) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return 0;
    }
  }

  var4 = usechoppersupport(self, var0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]]("chopper_support", self.origin);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_chopper_support", self);
  }

  return var4;
}

function usechoppersupport(var0, var1) {
  var2 = spawnchopper(var0, var1);
  level.incomingallchoppersupports--;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased) {
    level.incomingchoppersupports[var0.team]--;
  }

  if(!isDefined(var2)) {
    return false;
  }

  thread startchopper(var2, var0);

  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](var1);
  }

  return true;
}

function spawnchopper(var0, var1) {
  var2 = (0, 0, 1750);
  var4 = var0.origin - anglesToForward(var0.angles) * 15000 + var2;
  var5 = var0.origin + anglesToForward(var0.angles) * 2000 + var2;
  var6 = var0.angles;
  var7 = getdvarint("scr_chopper_support_lifetime", 45);
  var9 = undefined;

  if(isDefined(level.heli_structs_entrances) && level.heli_structs_entrances.size > 0) {
    var10 = randomint(level.heli_structs_entrances.size);
    var11 = level.heli_structs_entrances[var10];
    var9 = choppersupport_findtargetStruct(var11.script_linkto, level.heli_structs_goals);

    if(isDefined(var9)) {
      var12 = var11.origin * (1, 1, 0) + var2;
      var13 = var9.origin * (1, 1, 0) + var2;
      var14 = vectorNormalize(var13 - var12);
      var4 = var13 - var14 * 15000;
      var5 = var13;
      var6 = vectortoangles(var14);
    }
  }

  var21 = "veh8_mil_air_palfa";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var0)) {
    var21 = "veh8_mil_air_palfa_east";
  }

  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  var22 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var0, var4, var6, "veh_chopper_support_mp", var21);

  if(!isDefined(var22)) {
    return undefined;
  }

  var22.speed = 100;
  var22.accel = 50;
  var22.lifetime = var7;
  var22.team = var0.team;
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
  var22.infil_complete = var2[2] - 750;
  var22.ref_13766 = 50;
  var22.ref_13767 = 25;
  var22.ref_13768 = undefined;
  var22.ref_11c43 = 7;
  var22.ref_11c44 = 12;
  var22 setvehicleteam(var22.team);
  var22.health = 3500;
  var22.maxhealth = 3500;
  var22 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", var0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakMakeVehicle")) {
    var22[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakMakeVehicle")]](var1.streakname, "destroyed_chopper_support", undefined, "timeout_chopper_support", "callout_destroyed_chopper_support");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPreModDamageCallback")) {
    var22[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPreModDamageCallback")]](var1.streakname);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPostModDamageCallback")) {
    var22[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPostModDamageCallback")]](var1.streakname, &choppersupport_modifydamage);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetDeathCallback")) {
    var22[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetDeathCallback")]](var1.streakname, &choppersupport_handledeathdamage);
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
  var22 setotherent(var0);
  var22 setCanDamage(1);
  var22 setneargoalnotifydist(768);
  var22 setscriptablepartstate("blinking_lights", "on", 0);
  var22 setscriptablepartstate("engine", "on", 0);
  var23 = "veh8_mil_air_ahotel64_turret_wm";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var0)) {
    var23 = "veh8_mil_air_ahotel64_turret_wm_east";
  }

  var22.frontturret = spawnturret("misc_turret", var22 gettagorigin("tag_turret_front"), "chopper_support_turret_mp");
  var22.frontturret setModel(var23);
  var22.frontturret.owner = var0;
  var22.frontturret.team = var0.team;
  var22.frontturret.angles = var22.angles;
  var22.frontturret.streakinfo = var1;
  var22.frontturret.turreton = 1;
  var22.frontturret.name = "front_turret";
  var22.frontturret.attackingtarget = undefined;
  var22.frontturret linkTo(var22);
  var22.frontturret setturretteam(var0.team);
  var22.frontturret setturretmodechangewait(0);
  var22.frontturret setmode("manual");
  var22.frontturret setotherent(var0);
  var22.frontturret setdefaultdroppitch(45);
  var22.frontturret.groundtargetent = spawn("script_model", self.origin);
  var22.frontturret.groundtargetent setModel("tag_origin");
  var22.frontturret.groundtargetent dontinterpolate();
  var22.rearturret = spawnturret("misc_turret", var22 gettagorigin("tag_turret_rear"), "chopper_support_turret_mp");
  var22.rearturret setModel(var23);
  var22.rearturret.owner = var0;
  var22.rearturret.team = var0.team;
  var22.rearturret.angles = var22.angles;
  var22.rearturret.streakinfo = var1;
  var22.rearturret.turreton = 1;
  var22.rearturret.name = "rear_turret";
  var22.rearturret.attackingtarget = undefined;
  var22.rearturret linkTo(var22);
  var22.rearturret setturretteam(var0.team);
  var22.rearturret setturretmodechangewait(0);
  var22.rearturret setmode("manual");
  var22.rearturret setotherent(var0);
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

function startchopper(var0, var1) {
  self endon("death");
  self setvehgoalpos(self.pathgoal, 1);
  var2 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](var0, var1.streakname);
    var2 = 2;
  }

  var0 thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var1.streakname, 1, var2);
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

function choppersupport_handlemissiledetection(var0, var1, var2, var3) {
  self endon("death");

  for(;;) {
    if(!isDefined(var2)) {
      break;
    }

    var4 = var2 getpointinbounds(0, 0, 0);
    var5 = distance(self.origin, var4);

    if(var5 < 4000 && var2.flaresreservecount > 0) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "reduceReserves")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "reduceReserves")]](var2);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "playFx")) {
        var2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "playFx")]](undefined, var3);
      }

      if(isDefined(var2.streakinfo)) {
        var2 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_support_flares");
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

function choppersupport_engageturrettarget(var0) {
  self endon("leaving");
  self endon("death");

  for(;;) {
    if(!istrue(var0.turreton) || istrue(var0.ref_13e86)) {
      waitframe();
      continue;
    }

    var1 = choppersupport_gettargets(var0, 6000, 1, 1);

    if(isDefined(var1) && var1.size > 0) {
      var2 = choppersupport_acquireturrettarget(var0, var1);

      if(isDefined(var2) && var2 == "stopped_firing") {
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

function choppersupport_acquireturrettarget(var0, var1) {
  self notify("engaging_target");
  var2 = undefined;
  var3 = choppersupport_getbesttarget(var0, var1);
  var4 = var3[0];
  var5 = var3[1];
  var6 = var3[2];
  var3 = undefined;

  if(isDefined(var4)) {
    var7 = undefined;

    if(istrue(var6)) {
      var7 = var4 scripts\cp_mp\utility\player_utility::getvehicle();
    }

    choppersupport_setcurrenttarget(var0, var4);

    if(istrue(var5) && self.currenttarget == var4 && !istrue(self.chopper_boss_explosion)) {
      self thread[[level.grenade_effect]](var4, 1);
    }

    choppersupport_fireonturrettarget(var0, var4, var7, 1, var5);
    var2 = "stopped_firing";
  } else {
    var2 = "continue_searching";
  }

  return var2;
}

function choppersupport_setcurrenttarget(var0, var1) {
  var0 settargetentity(var0.groundtargetent);
  var0.attackingtarget = var1;

  if(!isDefined(self.currenttarget)) {
    self.currenttarget = var1;
    self setlookatent(self.currenttarget);
    return;
  }
}

function choppersupport_clearcurrenttarget(var0) {
  if(isDefined(self.currenttarget) && self.currenttarget == var0.attackingtarget) {
    self.currenttarget = undefined;
  }

  if(istrue(var0.ref_13a71)) {
    var0.ref_13a71 = undefined;
  }

  var0.attackingtarget = undefined;
  var0 cleartargetentity();
  var0.groundtargetent unlink();
  var1 = choppersupport_getactivetargets();

  if(self.currentaction != "patrol") {
    if(var1.size == 0) {
      self clearlookatent();
    }
  }

  var0 notify("lost_target");
}

function choppersupport_fireonturrettarget(var0, var1, var2, var3, var4) {
  if(self.currentaction != "attacking") {
    self.currentaction = "attacking";
  }

  if(istrue(var3) && isDefined(self.owner) && self.owner scripts\cp_mp\utility\player_utility::_isalive() && (!isDefined(self.lastfiretime) || self.lastfiretime + 15000 <= gettime())) {
    scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_support_engage_target");
    self.lastfiretime = gettime();
  }

  choppersupport_watchforlosttarget(var0);
  thread greenlight(var0);
  thread choppersupport_watchtargetlos(var0, var2);
  thread choppersupport_watchtargettimeout(var0);
  thread grab_entities_inside(var0);
  var5 = weaponfiretime("chopper_support_turret_mp");
  var6 = 0;
  var7 = 100;

  if(isDefined(self.ref_13766)) {
    var7 = self.ref_13766;
  }

  var8 = 20;

  if(isDefined(self.ref_11c43)) {
    var8 = self.ref_11c43;
  }

  var9 = 40;

  if(isDefined(self.ref_11c44)) {
    var9 = self.ref_11c44;
  }

  if(istrue(var4)) {
    var10 = 3750;

    while(istrue(goalyaw(var0, var1))) {
      if(distance2dsquared(self.origin, var1.origin) < var10 * var10) {
        break;
      }

      waitframe();
    }
  }

  thread grenade_chances(var0);

  while(istrue(goalyaw(var0, var1))) {
    if(istrue(var0.ref_13a71)) {
      if(isDefined(self.currenttarget) && var1 == self.currenttarget && !istrue(self.chopper_boss_explosion)) {
        self[[level.grenade_effect]](self.currenttarget, 1);
      } else {
        var0 notify("chopperSupport_targetBrokeLOS");
      }
    } else if(choppersupport_turretlookingattarget(var0)) {
      var11 = undefined;

      if(isDefined(var2)) {
        var11 = var1.origin;
      } else {
        var11 = var1 gettagorigin("j_mainroot");
      }

      choppersupport_setattackpoint(var0, var1, var11, var7);

      if(var6 == var8) {
        var7 = 50;

        if(isDefined(self.ref_13767)) {
          var7 = self.ref_13767;
        }
      } else if(var6 == var9) {
        var7 = undefined;

        if(isDefined(self.ref_13768)) {
          var7 = self.ref_13768;
        }
      }

      var0 shootturret("tag_flash");
      var6++;

      if(isDefined(var0.streakinfo)) {
        var0.streakinfo.shots_fired++;
      }
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var5);
  }
}

function goalyaw(var0, var1) {
  return isDefined(self) && isDefined(var0) && isDefined(var1) && !isDefined(self.iscrashing) && !isDefined(self.isleaving) && isDefined(var0.attackingtarget);
}

function choppersupport_setattackpoint(var0, var1, var2, var3) {
  var4 = var2;

  if(isDefined(var3)) {
    var5 = [self, var0];
    var6 = randomint(var3);
    var7 = randomint(360);
    var8 = var2[0] + var6 * cos(var7);
    var9 = var2[1] + var6 * sin(var7);
    var10 = var2[2];
    var4 = (var8, var9, var10);
    var0.groundtargetent.origin = var4;
    return;
  }

  if(!var0.groundtargetent islinked()) {
    var0.groundtargetent linkTo(var1, "tag_origin", (0, 0, 30), (0, 0, 0));
    return;
  }
}

function choppersupport_turretlookingattarget() {
  var0 = 0.992;
  var1 = anglesToForward(self gettagangles("tag_flash"));
  var2 = vectorNormalize(self.groundtargetent.origin - self.origin);
  var3 = vectordot(var1, var2);

  if(isDefined(self gettargetentity(1)) && var3 >= var0) {
    return true;
  }

  return false;
}

function choppersupport_watchforlosttarget(var0) {
  thread choppersupport_watchforlosttargetaction(var0, "death_or_disconnect");
  thread choppersupport_watchforlosttargetaction(var0, "chopperSupport_maxAggroRange");
  thread choppersupport_watchforlosttargetaction(var0, "chopperSupport_targetLeftRange");
  thread choppersupport_watchforlosttargetaction(var0, "chopperSupport_targetBrokeLOS");
  thread choppersupport_watchforlosttargetaction(var0, "chopperSupport_targetTimeout");
  thread choppersupport_watchforlosttargetaction(var0, "chopperSupport_targetLastStand");
}

function choppersupport_watchforlosttargetaction(var0, var1) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  self endon("crashing");
  var0 endon("lost_target");
  var2 = var0;

  if(var1 == "death_or_disconnect") {
    var2 = var0.attackingtarget;
  }

  var2 waittill(var1);
  choppersupport_clearcurrenttarget(var0);
}

function greenlight(var0) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  var0 endon("lost_target");

  if(!scripts\cp_mp\utility\game_utility::update_ai_volumes()) {
    return;
  }

  var1 = self.pathgoal;

  for(;;) {
    if(isDefined(var0.attackingtarget)) {
      if(distance2dsquared(var1, self.origin) > 100000000) {
        if(!istrue(self.spawn_lbravo)) {
          self.spawn_lbravo = 1;
        }

        var0 notify("chopperSupport_maxAggroRange");
        break;
      }
    }

    waitframe();
  }
}

function grenade_chances(var0) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  var0 endon("lost_target");

  for(;;) {
    if(isDefined(var0.attackingtarget)) {
      var1 = var0.attackingtarget;

      if(distance2dsquared(var0.origin, var1.origin) > 20250000) {
        wait 2;
        var0 notify("chopperSupport_targetLeftRange");
        break;
      }
    }

    waitframe();
  }
}

function choppersupport_watchtargetlos(var0, var1) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  var0 endon("lost_target");
  var2 = undefined;
  var3 = 500;
  var4 = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);
  var5 = [var0];

  if(isDefined(var1)) {
    GscBinSkip0(0x2e, var5.size, var1);
  }

  for(;;) {
    if(!istrue(var0.ref_13a71) && isDefined(var0.attackingtarget)) {
      var7 = scripts\engine\trace::ray_trace_passed(var0 gettagorigin("tag_barrel"), var0.attackingtarget gettagorigin("j_head"), var5, var4);

      if(!istrue(var7)) {
        if(!isDefined(var2)) {
          var2 = gettime();
        }

        if(gettime() - var2 > var3) {
          var0.ref_13a71 = 1;
        }
      } else {
        var2 = undefined;
      }
    }

    wait 0.25;
  }
}

function choppersupport_watchtargettimeout(var0) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  var0 endon("lost_target");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  var0 notify("chopperSupport_targetTimeout");
}

function grab_entities_inside(var0) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  var0 endon("lost_target");

  for(;;) {
    if(isDefined(var0.attackingtarget) && istrue(var0.attackingtarget.inlaststand)) {
      var0 notify("chopperSupport_targetLastStand");
      break;
    }

    waitframe();
  }
}

function choppersupport_isactivetarget(var0) {
  var1 = 0;

  if(!isDefined(var0)) {
    return 0;
  }

  if(isDefined(self.frontturret.attackingtarget)) {
    if(self.frontturret.attackingtarget == var0) {
      var1 = 1;
    }
  }

  if(isDefined(self.rearturret.attackingtarget)) {
    if(self.rearturret.attackingtarget == var0) {
      var1 = 1;
    }
  }

  return var1;
}

function choppersupport_checkifactivetargets() {
  return isDefined(self.frontturret.attackingtarget) || isDefined(self.rearturret.attackingtarget);
}

function choppersupport_getactivetargets() {
  var0 = [];

  if(isDefined(self.frontturret.attackingtarget)) {
    GscBinSkip0(0x2e, var0.size, self.frontturret.attackingtarget);
  }

  if(isDefined(self.rearturret.attackingtarget)) {
    GscBinSkip0(0x2e, var0.size, self.rearturret.attackingtarget);
  }

  return var0;
}

function choppersupport_patrolfield(var0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self endon("engaging_target");

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
  }

  if(isDefined(self.ref_1220c)) {
    self[[self.ref_1220c]](var0);
    return;
  }

  if(self.currentaction != "patrol") {
    self.currentaction = "patrol";
  } else if(self.currentaction == "patrol" && !istrue(var0)) {
    return;
  }

  self clearlookatent();
  var1 = 500;

  if(goodjobplayer()) {
    var1 = 50;
  }

  self setneargoalnotifydist(var1);
  var2 = 0;

  for(;;) {
    if(self.currentaction == "attacking") {
      if(!istrue(var2)) {
        var2 = 1;
      }

      waitframe();
      continue;
    }

    if(!istrue(var0) && istrue(var2)) {
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_support_patrol");
      var2 = 0;
    }

    var3 = choppersupport_findclosestpatrolstruct();

    if(isDefined(var3) && !istrue(self.chopper_boss_explosion)) {
      self[[level.grenade_effect]](var3, 1);
    } else {
      var5 = [];
      var6 = (0, 0, 0);
      var7 = self.pathgoal;

      foreach(var9 in level.players) {
        if(var9 == self.owner) {
          continue;
        }

        if(level.teambased && var9.team == self.owner.team) {
          continue;
        }

        if(!var9 scripts\cp_mp\utility\player_utility::_isalive()) {
          continue;
        }

        var6 += var9.origin;
        var5 = var9;
      }

      if(isDefined(var6) && var5.size > 0 && !istrue(self.chopper_boss_explosion)) {
        var11 = var6 / var5.size;
        self[[level.grenade_effect]](var11);
      }
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
  }
}

function choppersupport_findclosestpatrolstruct() {
  var0 = scripts\engine\utility::array_combine(level.heli_structs_goals, level.heli_structs_paths);
  var1 = undefined;
  var2 = undefined;
  var3 = undefined;

  foreach(var5 in var0) {
    if(isDefined(self.currentpatrolstruct) && var5 == self.currentpatrolstruct) {
      continue;
    }

    var6 = distance2dsquared(var5.origin, self.origin);

    if(!isDefined(var3) || var6 < var3) {
      var3 = var6;
      var2 = var5;
    }
  }

  if(isDefined(var2)) {
    var1 = choppersupport_findtargetStruct(var2.script_linkto, var0);
    self.currentpatrolstruct = var2;
  }

  return var1;
}

function choppersupport_canseeenemy(var0) {
  var1 = 0;
  var2 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0);
  var3 = [var0 gettagorigin("j_head"), var0 gettagorigin("j_mainroot"), var0 gettagorigin("tag_origin")];

  for(var4 = 0; var4 < var3.size; var4++) {
    if(!scripts\engine\trace::ray_trace_passed(self.origin, var3[var4], self, var2)) {
      continue;
    }

    var1 = 1;
    break;
  }

  return var1;
}

function choppersupport_movetolocation(var0, var1) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  var2 = undefined;
  var3 = var0;

  if(!isvector(var0)) {
    var3 = var0.origin;
  }

  var4 = [self, self.frontturret, self.rearturret];

  for(;;) {
    var5 = self.origin;
    var6 = var3 * (1, 1, 0) + (0, 0, self.origin[2]);
    var7 = scripts\engine\trace::sphere_trace(var5, var6, 256, var4);
    var8 = 0;
    var9 = var3[0];
    var10 = var3[1];

    if(isDefined(var7)) {
      if(var7["hittype"] != "hittype_none") {
        var9 = var7["position"][0];
        var10 = var7["position"][1];
        var8 = 1;
      }
    }

    if(istrue(self.evasivemaneuvers)) {
      var11 = var9 + randomintrange(-500, 500);
      var12 = var10 + randomintrange(-500, 500);
      var13 = getcorrectheight(var11, var12, 350);
      var2 = (var11, var12, var13);
    } else {
      var13 = getcorrectheight(var9, var10, 20);
      var2 = (var9, var10, var13);
    }

    var14 = 0;

    if(istrue(var1) && !istrue(var8)) {
      var14 = var1;
    }

    self setvehgoalpos(var2, var14);
    scripts\engine\utility::ref_143a5("near_goal", "begin_evasive_maneuvers");

    if(!istrue(var8)) {
      break;
    }
  }
}

function debugtimedelta(var0, var1) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  var2 = undefined;
  var3 = var0;

  if(!isvector(var0)) {
    var3 = var0.origin;
  }

  if(getdvarint("scr_chopper_support_use_min_spacing") > 0) {
    var3 = going_to(var3);
  }

  var4 = [self, self.frontturret, self.rearturret];

  for(;;) {
    var5 = self.origin;
    var6 = var3;

    if(istrue(self.chopper_boss_explosion) && isDefined(self.intro_driver_logic)) {
      break;
    }

    var7 = 20;
    var8 = scripts\engine\utility::ter_op(istrue(self.evasivemaneuvers), 350, var7);
    var9 = getcorrectheight(var3[0], var3[1], var8);
    var6 = (var6[0], var6[1], var9);
    var10 = 512;
    var11 = scripts\engine\trace::sphere_trace(var5, var6, var10, var4);
    var12 = 0;
    var13 = var6[0];
    var14 = var6[1];
    var15 = var6[2];

    if(isDefined(var11)) {
      if(var11["hittype"] != "hittype_none") {
        var13 = var11["position"][0];
        var14 = var11["position"][1];
        var15 = getcorrectheight(var13, var14, var8);
        var12 = 1;
      }
    }

    if(istrue(self.evasivemaneuvers)) {
      var13 += randomintrange(-500, 500);
      var14 += randomintrange(-500, 500);
      var15 = getcorrectheight(var13, var14, var8);
    }

    var16 = 0;

    if(istrue(var1) && !istrue(var12)) {
      var16 = var1;
    }

    var2 = (var13, var14, var15);
    self setvehgoalpos(var2, var16);
    scripts\engine\utility::ref_143a5("near_goal", "begin_evasive_maneuvers");

    if(!istrue(var12)) {
      break;
    }
  }
}

function going_to(var0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  if(!isDefined(level.ref_119e7) || level.ref_119e7.size == 0) {
    return var0;
  }

  var1 = 0;
  var2 = var0[2];
  var3 = getdvarfloat("scr_chopper_support_min_spacing", 1500);
  var4 = 0;

  while(!var4 && var1 < 360) {
    for(var5 = 0; var5 < level.ref_119e7.size; var5++) {
      if(self == level.ref_119e7[var5]) {
        continue;
      }

      var4 = distance2d(var0, level.ref_119e7[var5].pathgoal) >= var3;

      if(!var4) {
        break;
      }
    }

    if(var4) {
      return var0;
    }

    var1 += 10;
    var0 = rotatepointaroundvector(self.ref_1220d, var0, var1);
    var0 = (var0[0], var0[1], var2);
  }

  return var0;
}

function choppersupport_leave() {
  self endon("death");
  self playsoundonmovingent("ks_chopper_support_leave");
  self setmaxpitchroll(0, 0);
  self notify("leaving");
  self.isleaving = 1;
  self clearlookatent();
  var0 = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
  var0 += (0, 0, 1000);
  self setvehgoalpos(var0, 1);
  self setneargoalnotifydist(100);
  self waittill("near_goal");
  var1 = getpathend();
  self setmaxpitchroll(15, 15);
  self vehicle_setspeed(self.speed, self.accel);
  self setvehgoalpos(var1, 1);
  self waittill("goal");
  self stoploopsound();
  self notify("chopperSupport_gone");
  thread choppersupport_cleanup();
}

function choppersupport_cleanup(var0) {
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
    self.streakinfo.onspray = istrue(var0);
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
      var0 = 8000;

      for(;;) {
        if(distance2dsquared(self.origin, self.pathgoal) <= var0 * var0) {
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

function choppersupport_gettargets(var0, var1, var2, var3) {
  self endon("death");
  self endon("leaving");
  var4 = [];
  var5 = level.players;

  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    var6 = 4500;

    if(isDefined(var1)) {
      var6 = var1;
    }

    var5 = scripts\common\utility::playersinsphere(self.origin, var6);
  }

  for(var7 = 0; var7 < var5.size; var7++) {
    var8 = var5[var7];
    var9 = choppersupport_istarget(var0, var8, var2, var3);
    var10 = var9[0];
    var11 = var9[1];
    var12 = var9[2];
    var9 = undefined;

    if(istrue(var10)) {
      var13 = spawnStruct();
      var13.player = var8;
      var13.ref_12fa2 = var11;
      var13.ref_13a93 = var12;
      var4 = var13;
    } else {
      continue;
    }

    wait 0.05;
  }

  return var4;
}

function choppersupport_istarget(var0, var1, var2, var3) {
  self endon("death");
  self endon("leaving");

  if(isDefined(self.va_standard_spawnpoint_valid) && ![[self.va_standard_spawnpoint_valid]](var1)) {
    return [0, 0, 0];
  }

  if(!goliath_init(var1)) {
    return [0, 0, 0];
  }

  if(isDefined(self.owner) && var1 == self.owner) {
    return [0, 0, 0];
  }

  if(!isDefined(var1.pers["team"])) {
    return [0, 0, 0];
  }

  if(level.teambased && var1.pers["team"] == self.team) {
    return [0, 0, 0];
  }

  if(var1.pers["team"] == "spectator") {
    return [0, 0, 0];
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    if(var1[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_blindeye")) {
      return [0, 0, 0];
    }
  }

  if(istrue(var1.inlaststand)) {
    return [0, 0, 0];
  }

  if(scripts\cp_mp\parachute::isparachutegametype() && (var1 isparachuting() || var1 isskydiving())) {
    return [0, 0, 0];
  }

  var5 = 0;

  if(istrue(var2)) {
    if(distance2dsquared(self.origin, var1.origin) > 20250000) {
      if(distance2dsquared(self.origin, var1.origin) > 36000000) {
        return [0, 0, 0];
      }

      var5 = 1;
    }
  }

  var6 = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);
  var7 = [var0];
  var8 = 0;

  if(istrue(var3)) {
    var8 = var1 scripts\cp_mp\utility\player_utility::isinvehicle();

    if(istrue(var8)) {
      var9 = var1 scripts\cp_mp\utility\player_utility::getvehicle();
      var7 = var9;
      var10 = var9 getlinkedchildren();

      if(isDefined(var10) && var10.size > 0) {
        var7 = scripts\engine\utility::array_combine(var7, var10);
      }
    }
  }

  var11 = scripts\engine\trace::ray_trace_passed(var0 gettagorigin("tag_barrel"), var1 gettagorigin("j_head"), var7, var6);

  if(!istrue(var11)) {
    return [0, 0, 0];
  }

  return [1, var5, var8];
}

function goliath_init(var0) {
  return isDefined(var0) && var0 scripts\cp_mp\utility\player_utility::_isalive() && var0.sessionstate == "playing";
}

function choppersupport_getbesttarget(var0, var1) {
  var2 = undefined;
  var3 = undefined;
  var4 = undefined;
  var5 = undefined;

  foreach(var7 in var1) {
    if(!goliath_init(var7.player)) {
      continue;
    }

    if(choppersupport_isactivetarget(var7.player) && !istrue(var7.ref_13a93)) {
      continue;
    }

    var8 = 0;
    var9 = 0;
    var10 = abs(vectortoangles(var7.player.origin - self.origin)[1]);
    var11 = abs(self gettagangles("tag_flash")[1]);
    var10 = abs(var10 - var11);
    var12 = var7.player getweaponslistitems();

    foreach(var14 in var12) {
      var15 = weaponclass(var14);

      if(var15 == "rocketlauncher") {
        var10 -= 40;
      }
    }

    if(istrue(var7.ref_12fa2)) {
      var8 = 1;
      var10 += 40;
    }

    if(istrue(var7.ref_13a93)) {
      var9 = 1;
      var10 += 20;
    }

    if(!isDefined(var2) || var2 > var10) {
      var2 = var10;
      var3 = var7.player;
      var5 = var9;
      var4 = var8;
    }
  }

  return [var3, var4, var5];
}

function getcorrectheight(var0, var1, var2) {
  var3 = self.heightoffset[2];
  var4 = tracegroundpoint(var0, var1);
  var5 = var4 + var3;
  var5 += randomint(var2);
  return var5;
}

function choppersupport_watchdestoyed() {
  level endon("game_ended");
  self endon("chopperSupport_gone");
  var0 = self.owner;
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

function choppersupport_crash(var0) {
  var1 = 0;
  self endon("explode");
  self setscriptablepartstate("crash", "on", 0);

  if(isDefined(self.killcament)) {
    self.killcament unlink();
    self.killcament.origin = self.origin + (0, 0, 100);
  }

  self clearlookatent();
  self notify("crashing");
  self.iscrashing = 1;
  self vehicle_setspeed(var0, 20, 20);
  self setneargoalnotifydist(100);
  var2 = undefined;

  if(istrue(self.chopper_boss_explosion) && isDefined(self.interaction_is_floor_is_lava_client)) {
    self setneargoalnotifydist(300);
    var1 = 1;
    var2 = [[self.interaction_is_floor_is_lava_client]]();
  } else {
    var2 = choppersupport_findcrashposition(3500, 500, 1000);
  }

  if(!isDefined(var2)) {
    return;
  }

  if(istrue(level.ref_14088) && isscriptabledefined()) {
    var3 = getclosestpointonnavmesh(var2);
    var2 = goto_goal_and_snipe(var3 + (0, 0, 1500), var3);
  }

  if(isDefined(self.streakinfo)) {
    scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_support_crash", 1);
  }

  self setvehgoalpos(var2, var1);
  thread choppersupport_spinout(var0);
  self vehicle_turnengineoff();
  self waittill("near_goal");

  if(isDefined(self.streakinfo)) {
    scripts\cp_mp\utility\dialog_utility::playoperatorstaticinterrupt();
    return;
  }
}

function choppersupport_findcrashposition(var0, var1, var2) {
  var3 = self.origin;
  var4 = self.infil_complete;
  var5 = undefined;
  var6 = anglesToForward(self.angles);
  var7 = anglestoright(self.angles);
  var8 = var3 + var6 * var0 - (0, 0, var4);

  if(scripts\engine\trace::ray_trace_passed(var3, var8, self)) {
    var5 = var8;
    return var5;
  }

  var8 = var3 - var6 * var0 - (0, 0, var4);

  if(scripts\engine\trace::ray_trace_passed(var3, var8, self)) {
    var5 = var8;
    return var5;
  }

  var8 = var3 + var7 * var0 - (0, 0, var4);

  if(scripts\engine\trace::ray_trace_passed(var3, var8, self)) {
    var5 = var8;
    return var5;
  }

  var8 = var3 - var7 * var0 - (0, 0, var4);

  if(scripts\engine\trace::ray_trace_passed(var3, var8, self)) {
    var5 = var8;
    return var5;
  }

  var8 = var3 + 0.707 * var0 * (var6 + var7) - (0, 0, var4);

  if(scripts\engine\trace::ray_trace_passed(var3, var8, self)) {
    var5 = var8;
    return var5;
  }

  var8 = var3 + 0.707 * var0 * (var6 - var7) - (0, 0, var4);

  if(scripts\engine\trace::ray_trace_passed(var3, var8, self)) {
    var5 = var8;
    return var5;
  }

  var8 = var3 + 0.707 * var0 * (var7 - var6) - (0, 0, var4);
  var9 = scripts\engine\trace::ray_trace(var3, var8, self);

  if(scripts\engine\trace::ray_trace_passed(var3, var8, self)) {
    var5 = var8;
    return var5;
  }

  var8 = var3 + 0.707 * var0 * (-1 * var6 - var7) - (0, 0, var4);

  if(scripts\engine\trace::ray_trace_passed(var3, var8, self)) {
    var5 = var8;
    return var5;
  }

  return var5;
}

function goto_goal_and_snipe(var0, var1) {
  var2 = var1;
  var3 = 335;
  var4 = [self, self.frontturret, self.rearturret];
  var5 = scripts\engine\trace::sphere_trace(var0, var1, var3, var4);

  if(isDefined(var5) && var5["hittype"] != "hittype_none") {
    var2 = var5["position"];
  }

  return var2;
}

function choppersupport_spinout(var0) {
  self endon("death");
  self setyawspeed(var0, 50, 50, 0.5);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + var0 * 0.4);
    wait 0.5;
  }
}

function tracenewpoint(var0, var1, var2) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  self endon("randMove");
  var3 = scripts\engine\trace::sphere_trace(self.origin, (var0, var1, var2), 256, self, undefined, 1);

  if(var3["surfacetype"] != "surftype_none") {
    return 0;
  }

  var4 = (var0, var1, var2);
  return var4;
}

function tracegroundpoint(var0, var1) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  var2 = -99999;
  var3 = self.origin[2] + 2000;
  var4 = level.averagealliesz;
  var5 = [self];

  if(isDefined(self.dropcrates)) {
    foreach(var7 in self.dropcrates) {
      var5 = var7;
    }
  }

  var9 = scripts\engine\trace::sphere_trace((var0, var1, var3), (var0, var1, var2), 800, var5, undefined, 1);

  if(var9["position"][2] < var4) {
    var10 = var4;
  } else {
    var10 = var10["position"][2];
  }

  return var10;
}

function beginevasivemaneuvers() {
  self endon("death");
  self notify("begin_evasive_maneuvers");
  self endon("begin_evasive_maneuvers");
  self.evasivemaneuvers = 1;
  var0 = scripts\engine\utility::ref_143b9(3, "death");

  if(var0 == "timeout") {
    self.evasivemaneuvers = 0;
    return;
  }
}

function getcorrectheightescort(var0, var1, var2, var3) {
  var4 = 200;

  if(isDefined(var3)) {
    var4 = var3;
  }

  var5 = tracegroundpoint(var0, var1);
  var6 = var5 + var4;
  var6 += randomint(var2);
  return var6;
}

function choppersupport_modifydamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflags;
  self.currenthealth = self.health - var4;

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

function choppersupport_handledeathdamage(var0) {
  self.killedbyweapon = var0.objweapon;

  if(istrue(self.usefuncoverride) && isDefined(level.ref_13457)) {
    if(isDefined(var0.objweapon)) {
      [[level.ref_13457.ref_1346a]](var0.objweapon.basename);
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
  var0 = self.defendloc;
  var1 = getrandompoint(self.origin);
  self setvehgoalpos(var1, 1);
  thread scripts\cp_mp\utility\debug_utility::drawline(self.origin, var1, 5, (1, 0, 1));
  self waittill("goal");
}

function getrandompoint(var0) {
  self clearlookatent();

  if(distance2dsquared(self.origin, self.owner.origin) > 4194304) {
    var1 = self.owner.origin[0];
    var2 = self.owner.origin[1];
    var3 = getcorrectheight(var1, var2, 20);
    var4 = (var1, var2, var3);
    self setlookatent(self.owner);
    return var4;
  }

  var5 = self.angles[1];
  var6 = int(var5 - 60);
  var7 = int(var5 + 60);
  var8 = randomintrange(var6, var7);
  var9 = (0, var8, 0);
  [var11] = self.origin + anglesToForward(var9) * randomintrange(400, 800);
  var12 = var10[1];
  var13 = getcorrectheight(var11, var12, 20);
  var14 = tracenewpoint(var11, var12, var13);

  if(var14 != 0) {
    return var14;
  }

  var11 = randomfloatrange(var4[0] - 1200, var4[0] + 1200);
  var12 = randomfloatrange(var4[1] - 1200, var4[1] + 1200);
  var15 = (var11, var12, var13);
  return var15;
}

function getnewpoint(var0, var1) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");

  if(!isDefined(var1)) {
    return;
  }

  var2 = [];

  foreach(var4 in level.players) {
    if(var4 == self) {
      continue;
    }

    if(!level.teambased || var4.team != self.team) {
      var2 = var4.origin;
    }
  }

  jumpiffalse(var2.size > 0) LOC_0000009a;
  [var7] = averagepoint(var2);
  var8 = var6[1];
  goto LOC_000000d1;
}

function getpathstart(var0) {
  var1 = 100;
  var2 = 15000;
  var3 = randomfloat(360);
  var4 = (0, var3, 0);
  var5 = var0 + anglesToForward(var4) * -1 * var2;
  var5 += ((randomfloat(2) - 1) * var1, (randomfloat(2) - 1) * var1, 0);
  return var5;
}

function getpathend() {
  var0 = 150;
  var1 = 15000;
  var2 = self.angles[1];
  var3 = (0, var2, 0);
  var4 = self.origin + anglesToForward(var3) * var1;
  return var4;
}

function choppersupport_findtargetStruct(var0, var1) {
  var2 = undefined;

  foreach(var4 in var1) {
    if(var4.script_linkname == var0) {
      var2 = var4;
      break;
    }
  }

  return var2;
}

function goodjobplayer() {
  var0 = 0;

  switch (level.mapname) {
    case "mp_m_speed":
    case "mp_shipment":
      var0 = 1;
      break;
  }

  return var0;
}