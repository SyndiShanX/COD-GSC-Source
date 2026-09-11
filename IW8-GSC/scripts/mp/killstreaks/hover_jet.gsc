/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\hover_jet.gsc
************************************************/

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("hover_jet", &tryusehoverjetfromstruct);
  level.hoverjets = [];
  scripts\mp\vehicles\damage::set_vehicle_hit_damage_data("hover_jet", 12);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]]("thermite_bolt_mp", 1, "hover_jet");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]]("hover_jet", 24, "thermite_bolt_mp");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]]("semtex_bolt_mp", 1, "hover_jet");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]]("hover_jet", 9, "semtex_bolt_mp");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]]("thermite_xmike109_mp", 1, "hover_jet");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]]("hover_jet", 50, "thermite_xmike109_mp");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]]("semtex_xmike109_mp", 1, "hover_jet");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]]("hover_jet", 13, "semtex_xmike109_mp");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]]("semtex_aalpha12_mp", 1, "hover_jet");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]]("hover_jet", 18, "semtex_aalpha12_mp");
  }

  init_hover_jet_anims();
  init_hover_jet_vo();
  level.incomingallhoverjets = 0;
  level.incominghoverjets["allies"] = 0;
  level.incominghoverjets["axis"] = 0;
}

#using_animtree("");

function init_hover_jet_anims() {
  level.scr_anim["hover_jet"]["airstrike_flyby"] = % mp_halfa_flyin;
  level.scr_anim["hover_jet"]["exit"] = $mp_halfa_exit;
}

function init_hover_jet_vo() {
  game["dialog"]["hover_jet_move"] = "hover_jet_acknowledge";
  game["dialog"]["hover_jet_guard"] = "hover_jet_guard";
  game["dialog"]["hover_jet_flares"] = "hover_jet_flares";
  game["dialog"]["hover_jet_damage_heavy"] = "hover_jet_health_low";
  game["dialog"]["hover_jet_damage_med"] = "hover_jet_health_med";
  game["dialog"]["hover_jet_damage_light"] = "hover_jet_health_high";
  game["dialog"]["hover_jet_crash"] = "hover_jet_crash";
  game["dialog"]["hover_jet_attack_air"] = "hover_jet_air_target";
}

function weapongivenhoverjet(var_0) {
  scripts\mp\killstreaks\mapselect::startmapselectsequence();
  return true;
}

function tryusehoverjet() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("hover_jet", self);
  return tryusehoverjetfromstruct(var_0);
}

function tryusehoverjetfromstruct(var_0) {
  var_1 = self.team;

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    return 0;
  }

  level.incomingallhoverjets++;
  var_2 = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    var_2 = 2;
  }

  if(level.hoverjets.size >= var_2 || level.hoverjets.size + level.incomingallhoverjets > var_2) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    level.incomingallhoverjets--;
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return 0;
  }

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased) {
    var_3 = 1;
    level.incominghoverjets[var_1]++;

    if(scripts\cp_mp\utility\killstreak_utility::getnumactivekillstreakperteam(var_1, level.hoverjets) + level.incominghoverjets[var_1] > var_3) {
      level.incomingallhoverjets--;
      level.incominghoverjets[var_1]--;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_VTOL_JET");
      }

      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return 0;
    }
  }

  var_4 = any_player_within_distance3d(var_0);
  var_4 = istrue(var_4);
  level.incomingallhoverjets--;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased) {
    level.incominghoverjets[var_1]--;
  }

  if(!var_4) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  }

  return var_4;
}

function any_player_within_distance3d(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      return false;
    }
  }

  var_1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(var_0, getcompleteweaponname("ks_remote_map_mp"), 1, &weapongivenhoverjet);

  if(!istrue(var_1)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      return false;
    }
  }

  var_2 = hoverjet_getmapselectioninfo(var_0, 1);

  if(!isDefined(var_2)) {
    return false;
  }

  var_0 notify("killstreak_finished_with_deploy_weapon");
  thread starthoverjetairstrikepass(self, var_0, var_2);
  var_3 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var_0.streakname);
    var_3 = 2;
  }

  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var_0.streakname, 1, var_3);
  scripts\common\utility::ref_13e0a(level.ref_11b2a, "hover_jet", self.origin);
  thread scripts\mp\hud_util::teamplayercardsplash("used_hover_jet", self);
  return true;
}

function hoverjet_getmapselectioninfo(var_0, var_1) {
  scripts\common\utility::allow_weapon_switch(0);
  self setsoundsubmix("mp_killstreak_overlay");
  var_2 = scripts\mp\killstreaks\mapselect::getselectmappoint(var_0, var_1);

  if(!isDefined(var_2)) {
    scripts\common\utility::allow_weapon_switch(1);
    self clearsoundsubmix("mp_killstreak_overlay");
    return undefined;
  }

  scripts\common\utility::allow_weapon_switch(1);
  self clearsoundsubmix("mp_killstreak_overlay");
  return var_2;
}

function starthoverjetairstrikepass(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var_4 = 24000;
  var_5 = 6500;
  var_6 = 3250;
  var_7 = 1500;
  var_8 = (0, 0, 0);
  var_9 = 1500;
  var_10 = var_0.angles;
  var_11 = 1;

  if(isDefined(var_3)) {
    var_6 = var_3.origin[2] + 750;
  }

  var_12 = scripts\cp_mp\utility\game_utility::getlocaleid();

  if(isDefined(var_12) && var_12 == "locale_6") {
    var_6 += 500;
  }

  var_14 = var_2[0].location;
  var_10 = scripts\cp_mp\killstreaks\airstrike::callstrike_findoptimaldirection(var_0, var_14, var_6);
  var_15 = scripts\cp_mp\killstreaks\airstrike::getflightpath(var_14, var_10, var_4, var_3, var_6, var_5, var_9, var_1.streakname, var_11);
  var_16 = var_15["startPoint"];
  var_17 = var_15["endPoint"];
  var_18 = "veh8_mil_air_halfa_mp";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var_0)) {
    var_18 = "veh8_mil_air_halfa_east_mp";
  }

  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  var_19 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var_0, var_16, var_10, "veh_hover_jet_mp", var_18);

  if(!isDefined(var_19)) {
    return;
  }

  var_20 = 45;
  var_19.speed = 250;
  var_19.accel = 175;
  var_19.health = 2500;
  var_19.maxhealth = 2500;
  var_19.angles = vectortoangles(var_10);
  var_19.lifetime = var_20;
  var_19.team = var_0.team;
  var_19.owner = var_0;
  var_19.streakinfo = var_1;
  var_19.streakname = var_1.streakname;
  var_19.flaresreservecount = 1;
  var_19.returngoal = var_14;
  var_19.currentdamagestate = 0;
  var_19.flyheight = var_6;
  var_19.hoverheight = var_7;
  var_19.missiles = 6;
  var_19.pers["team"] = var_19.team;
  var_19.bestgroundtarget = undefined;
  var_19.bestairtarget = undefined;
  var_19.flightdir = var_15["directionAngles"];
  var_19 setmaxpitchroll(0, 90);
  var_19 vehicle_setspeed(var_19.speed, var_19.accel);
  var_19 sethoverparams(50, 100, 50);
  var_19 setturningability(0.05);
  var_19 setyawspeed(45, 25, 25, 0.5);
  var_19 setotherent(var_19.owner);
  var_19 setCanDamage(1);
  var_19 setneargoalnotifydist(700);
  var_19 setvehicleteam(var_19.team);
  level.hoverjets[level.hoverjets.size] = var_19;
  var_19 scripts\mp\utility\killstreak::addtoactivekillstreaklist(var_1.streakname, "Killstreak_Air", var_19.owner, 0, 1, 100);
  var_19 setscriptablepartstate("blinking_lights", "on", 0);
  var_19 setscriptablepartstate("thrusters", "active", 0);
  var_19 setscriptablepartstate("contrails", "on", 0);
  var_19.turret = spawnturret("misc_turret", var_19 gettagorigin("tag_turret"), "hover_jet_turret_mp");
  var_19.turret setModel("veh8_mil_air_halfa_turret");
  var_19.turret.owner = var_19.owner;
  var_19.turret.team = var_19.team;
  var_19.turret.angles = var_19.angles;
  var_19.turret.streakinfo = var_1;
  var_19.turret linkTo(var_19, "tag_turret", (0, 0, 5), (0, 0, 0));
  var_19.turret setturretteam(var_19.team);
  var_19.turret setturretmodechangewait(0);
  var_19.turret setmode("manual_target");
  var_19.turret setsentryowner(var_19.owner);
  var_19.turret setdefaultdroppitch(45);
  var_19.turret maketurretinoperable();
  var_19.turret setleftarc(360);
  var_19.turret setrightarc(360);
  var_19.turret setbottomarc(90);
  var_19.turret settoparc(90);
  var_19.turret setconvergencetime(0.5, "pitch");
  var_19.turret setconvergencetime(0.5, "yaw");
  var_19.turret setconvergenceheightpercent(0.65);
  var_19.killcament = spawn("script_model", var_19.turret gettagorigin("bi_center"));
  var_19.killcament linkTo(var_19, "tag_origin", (-500, 0, 500), (0, 0, 0));
  var_19.turret.groundtargetent = spawn("script_model", var_19.origin);
  var_19.turret.groundtargetent setModel("tag_origin");
  var_19.turret.groundtargetent dontinterpolate();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_19[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_1.streakname, "Killstreak_Air", var_0, 0, 1, 100);
  }

  var_19.animname = var_1.streakname;
  var_19.scenenode = spawn("script_model", var_19.returngoal * (1, 1, 0) + (0, 0, var_6));
  var_19.scenenode.angles = var_19.angles;
  var_19.scenenode setModel("tag_origin");
  thread hoverjet_firetrackermissiles(var_19);
  hoverjet_playflyfx(var_19);
  var_24 = getanimlength(level.scr_anim[var_19.animname]["airstrike_flyby"]);
  var_25 = scripts\engine\utility::get_notetrack_time(level.scr_anim[var_19.animname]["airstrike_flyby"], "contrail_off");
  var_19.scenenode thread scripts\common\anim::anim_single_solo(var_19, "airstrike_flyby");
  thread hoverjet_delaysetscriptable(var_19, var_25, "contrails");
  thread hoverjet_handledestroyed();
  thread spawn_script_model_driver_and_passengers();
  var_19 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", self);
  var_19 scripts\mp\utility\killstreak::killstreak_make_vehicle(var_1.streakname, "destroyed_hover_jet", undefined, "timeout_hover_jet", "callout_destroyed_hover_jet");
  var_19 scripts\mp\utility\killstreak::killstreak_set_pre_mod_damage_callback(var_1.streakname);
  var_19 scripts\mp\utility\killstreak::killstreak_set_post_mod_damage_callback(var_1.streakname, &hoverjet_modifydamage);
  var_19 scripts\mp\utility\killstreak::killstreak_set_death_callback(var_1.streakname, &hoverjet_handledeathdamage);
  var_19 thread scripts\mp\killstreaks\flares::flares_handleincomingstinger(&hoverjet_handlemissiledetection);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_24);

  if(!isDefined(var_19)) {
    return;
  }

  if(isDefined(var_19.scenenode)) {
    var_19.scenenode delete();
  }

  starthoverjetdefend(var_19, var_1);
}

function hoverjet_delaysetscriptable(var_0, var_1, var_2) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self setscriptablepartstate(var_1, var_2, 0);
}

function hoverjet_playflyfx() {
  thread scripts\engine\utility::delaythread(0.05, &hoverjet_playapproachfx);
  thread scripts\engine\utility::delaythread(6, &hoverjet_playflybyfx);
  thread scripts\engine\utility::delaythread(14, &hoverjet_playreturnfx);
}

function hoverjet_playapproachfx() {
  self playsoundonmovingent("ks_hoverjet_approach");
}

function hoverjet_playflybyfx() {
  self playsoundonmovingent("ks_hoverjet_flyby");
}

function hoverjet_playreturnfx() {
  self playsoundonmovingent("ks_hoverjet_return");
}

function hoverjet_firetrackermissiles(var_0) {
  self endon("death");
  level endon("game_ended");
  var_1 = scripts\engine\utility::get_notetrack_time(level.scr_anim["hover_jet"]["airstrike_flyby"], "attack");
  var_2 = var_1 - 4;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  var_3 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid"];
  var_4 = physics_createcontents(var_3);
  var_5 = self.angles * (0, 1, 0);
  var_6 = anglesToForward(var_5);
  var_7 = anglestoright(var_5);
  var_8 = [var_0 - var_6 * 2250 + var_7 * 750, var_0 - var_6 * 1500 - var_7 * 750, var_0 - var_6 * 750 + var_7 * 250, var_0 - var_7 * 250, var_0 + var_6 * 750 + var_7 * 750, var_0 + var_6 * 1500 - var_7 * 750, var_0 + var_6 * 2250 + var_7 * 250, var_0 + var_6 * 3000 - var_7 * 250];
  var_9 = ["tag_right_aphid_missile", "tag_left_aphid_missile", "tag_right_archer_missile", "tag_left_archer_missile"];
  var_10 = 0;
  var_11 = [];

  foreach(var_13 in var_8) {
    var_14 = var_13 + (0, 0, 10000);
    var_15 = var_13 - (0, 0, 10000);
    var_16 = scripts\engine\trace::ray_trace(var_14, var_15, level.characters, var_4);
    var_17 = scripts\common\utility::playersinsphere(var_16["position"], 1000);
    var_18 = hoverjet_findmissiletarget(var_17, var_11);
    var_19 = self gettagorigin(var_9[var_10]) + anglesToForward(self gettagangles(var_9[var_10])) * 300;
    var_20 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("hover_jet_proj_mp"), var_19, var_16["position"], self.owner);
    var_20.killcament = spawn("script_model", var_20.origin);
    var_20.killcament linkTo(var_20, "tag_origin", (-100, 0, 500), (0, 0, 0));
    thread hoverjet_missilekillcammove(var_20.killcament, var_16["position"]);
    var_20.streakinfo = self.streakinfo;
    self.streakinfo.shots_fired++;
    thread hoverjet_firemissilescriptable(var_10 + 1);

    if(isDefined(var_18)) {
      var_13 = var_18.origin;
      var_11 = var_18;
      thread hoverjet_delaymissiletracking(var_20, 0.05, var_18);
    }

    wait 0.5;
    var_10++;

    if(var_10 > var_9.size - 1) {
      var_10 = 0;
    }
  }

  var_11 = undefined;
}

function hoverjet_missilekillcammove(var_0, var_1) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
  self unlink();
  self moveTo(var_0 - anglesToForward(var_1) * 750, 6);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(7);
  self delete();
}

function hoverjet_firemissilescriptable(var_0) {
  self endon("death");
  level endon("game_ended");
  self setscriptablepartstate("fire_missile_" + var_0, "on", 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);
  self setscriptablepartstate("fire_missile_" + var_0, "off", 0);
}

function hoverjet_findmissiletarget(var_0, var_1) {
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(level.teambased && var_4.team == self.team) {
      continue;
    }

    if(var_4 == self.owner) {
      continue;
    }

    if(scripts\engine\utility::array_contains(var_1, var_4)) {
      continue;
    }

    if(var_4 scripts\mp\utility\perk::_hasperk("specialty_blindeye")) {
      continue;
    }

    var_2 = var_4;
    break;
  }

  return var_2;
}

function hoverjet_delaymissiletracking(var_0, var_1, var_2) {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);

  if(isDefined(var_0)) {
    var_0 missile_settargetEnt(var_2, (0, 0, 10));
    return;
  }
}

function hoverjet_delayresetscriptable(var_0) {
  self endon("death");
  level endon("game_ended");
  self setscriptablepartstate("explode" + var_0, "active", 0);
  wait 1;
  self setscriptablepartstate("explode" + var_0, "neutral", 0);
}

function starthoverjetdefend(var_0) {
  thread hoverjet_defendlocation();
}

function hoverjet_defendlocation() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  thread hoverjet_watchlifetime(self.lifetime);
  thread hoverjet_watchowner();
  thread hoverjet_startcombatlogic();
  thread hoverjet_movetolocation(self.returngoal);
}

function hoverjet_handlemissiledetection(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(var_2)) {
      break;
    }

    var_4 = var_2 getpointinbounds(0, 0, 0);
    var_5 = distance(self.origin, var_4);

    if(var_5 < 4000 && var_2.flaresreservecount > 0) {
      var_2 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("hover_jet_flares", 1);
      scripts\mp\killstreaks\flares::flares_reducereserves(var_2);
      var_2 thread scripts\mp\killstreaks\flares::flares_playFX("jet_flares", var_3);
      var_6 = var_2 scripts\mp\killstreaks\flares::flares_deploy();
      self missile_settargetEnt(var_6);
      self notify("missile_pairedWithFlare");
      return;
    }

    waitframe();
  }
}

function hoverjet_watchlifetime(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("timeout_" + self.streakinfo.streakname, 1);
  thread hoverjet_leave();
}

function spawn_script_model_driver_and_passengers() {
  self endon("death");
  level waittill("game_ended");
  self.ref_12aa4 = 1;
  self.owner scripts\cp_mp\utility\killstreak_utility::ref_12aa7(self.streakinfo);
}

function hoverjet_watchowner() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  thread hoverjet_leaveonownernotify("disconnect");
  thread hoverjet_leaveonownernotify("joined_team");
}

function hoverjet_leaveonownernotify(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  self.owner waittill(var_0);
  thread hoverjet_leave();
}

function hoverjet_startcombatlogic() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  self.turret.killcament = self.killcament;
  self setmaxpitchroll(15, 15);
  self vehicle_setspeed(45, 10);
  thread hoverjet_watchforreposition();
  thread hoverjet_engagegroundtargets();
  self setscriptablepartstate("thrusters", "idle", 0);
}

function hoverjet_movetolocation(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  var_1 = [self, self.turret];

  for(;;) {
    var_2 = self.origin;
    var_3 = var_0 * (1, 1, 0) + (0, 0, self.origin[2]);
    var_4 = scripts\engine\trace::sphere_trace(var_2, var_3, 256, var_1);
    var_5 = 0;
    var_6 = var_0[0];
    var_7 = var_0[1];

    if(isDefined(var_4)) {
      if(var_4["hittype"] != "hittype_none") {
        var_6 = var_4["position"][0];
        var_7 = var_4["position"][1];
        var_5 = 1;
      }
    }

    var_8 = hoverjet_getcorrectheight(var_6, var_7, 20);
    var_9 = (var_6, var_7, var_8);
    self setvehgoalpos(var_9, 1);
    self waittill("near_goal");

    if(!istrue(var_5)) {
      self.currentguardlocation = var_9;
      self notify("hoverJet_moveToNewlocation", var_9);
      break;
    }
  }

  self clearlookatent();
}

function hoverjet_getcorrectheight(var_0, var_1, var_2) {
  var_3 = self.hoverheight;
  var_5 = hoverjet_tracegroundpoint(var_0, var_1);
  var_6 = var_5 + var_3;
  var_6 += randomint(var_2);
  return var_6;
}

function hoverjet_tracegroundpoint(var_0, var_1) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  var_2 = -99999;
  var_3 = self.origin[2];
  var_4 = level.averagealliesz;
  var_5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 0, 0, 0, 0);
  var_6 = scripts\engine\trace::sphere_trace((var_0, var_1, var_3), (var_0, var_1, var_2), 512, self, var_5, 1);

  if(var_6["position"][2] < var_4) {
    var_7 = var_4;
  } else {
    var_7 = var_7["position"][2];
  }

  return var_7;
}

function hoverjet_engagegroundtargets() {
  self notify("engageGround");
  self endon("engageGround");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");

  for(;;) {
    var_0 = undefined;

    if(!isDefined(self.bestgroundtarget)) {
      var_1 = hoverjet_getbestgroundtarget();
      self.bestgroundtarget = var_1[0];
      var_0 = var_1[1];
      var_1 = undefined;
      self notify("acquiringTarget", self.bestgroundtarget);

      if(!isDefined(self.bestgroundtarget)) {
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.25);
        continue;
      }
    }

    var_2 = undefined;

    if(istrue(var_0)) {
      var_2 = self.bestgroundtarget scripts\cp_mp\utility\player_utility::getvehicle();
    }

    self.turret settargetentity(self.turret.groundtargetent);

    if(!isDefined(self.bestairtarget)) {
      self setlookatent(self.bestgroundtarget);
    }

    thread hoverjet_watchtargetstatus(self.bestgroundtarget);
    thread hoverjet_watchtargetlos(self.bestgroundtarget, undefined, var_2);
    thread hoverjet_watchtargettimeout(self.bestgroundtarget);
    hoverjet_fireongroundtarget(var_0);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  }
}

function hoverjet_getbestgroundtarget() {
  self endon("death");
  self endon("leaving");
  var_0 = scripts\cp_mp\killstreaks\chopper_support::choppersupport_gettargets(self.turret, 3000, 0, 1);
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_0) {
    if(!scripts\cp_mp\killstreaks\chopper_support::goliath_init(var_5.player)) {
      continue;
    }

    var_6 = 0;
    var_7 = 0;
    var_8 = abs(vectortoangles(var_5.player.origin - self.origin)[1]);
    var_9 = abs(self gettagangles("tag_flash")[1]);
    var_8 = abs(var_8 - var_9);
    var_10 = var_5.player getweaponslistitems();

    foreach(var_12 in var_10) {
      var_13 = weaponclass(var_12);

      if(var_13 == "rocketlauncher") {
        var_8 -= 40;
      }
    }

    if(istrue(var_5.ref_13a93)) {
      var_7 = 1;
      var_8 += 40;
    }

    if(!isDefined(var_1) || var_1 > var_8) {
      var_1 = var_8;
      var_2 = var_5.player;
      var_3 = var_7;
    }
  }

  return [var_2, var_3];
}

function hoverjet_fireongroundtarget(var_0) {
  var_1 = weaponfiretime("hover_jet_turret_mp");
  var_2 = 0;
  var_3 = 0;
  var_4 = 100;

  while(isDefined(self) && isDefined(self.bestgroundtarget) && !isDefined(self.iscrashing) && !isDefined(self.isleaving)) {
    if(hoverjet_turretlookingattarget(self.turret)) {
      var_6 = undefined;

      if(istrue(var_0)) {
        var_6 = self.bestgroundtarget.origin;
      } else {
        var_6 = self.bestgroundtarget gettagorigin("j_mainroot");
      }

      scripts\cp_mp\killstreaks\chopper_support::choppersupport_setattackpoint(self.turret, self.bestgroundtarget, var_6, var_4);

      if(var_3 == 15) {
        var_4 = 50;
      } else if(var_3 == 30) {
        var_4 = undefined;
      }

      self.turret shootturret("tag_flash");
      var_3++;
      self.turret.streakinfo.shots_fired++;
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  }
}

function hoverjet_turretlookingattarget() {
  var_0 = 0.996;
  var_1 = anglesToForward(self gettagangles("tag_flash"));
  var_2 = vectorNormalize(self.groundtargetent.origin - self.origin);
  var_3 = vectordot(var_1, var_2);

  if(isDefined(self gettargetentity(1)) && var_3 >= var_0) {
    return true;
  }

  return false;
}

function hoverjet_engageairtargets() {
  self notify("engageAir");
  self endon("engageAir");
  self endon("death");
  self endon("leaving");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(self.bestairtarget)) {
      var_0 = [];
      var_0 = scripts\engine\utility::array_combine(level.helis, level.littlebirds, level.supportdrones);
      self.bestairtarget = hoverjet_getbestairtarget(var_0);
      self notify("hoverJet_acquiringAirTarget", self.bestairtarget);

      if(!isDefined(self.bestairtarget)) {
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);
        continue;
      }
    }

    thread hoverjet_watchtargetstatus(self.bestairtarget);
    hoverjet_fireonairtarget();
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  }
}

function hoverjet_fireonairtarget() {
  var_0 = "right";
  var_1 = getcompleteweaponname("hover_jet_proj_mp");
  var_2 = undefined;
  self setlookatent(self.bestairtarget);

  while(isDefined(self) && isDefined(self.bestairtarget)) {
    var_3 = 5;

    if(!istrue(var_2)) {
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("hover_jet_attack_air");
      var_2 = 1;
    }

    while(var_3 > 0 && isDefined(self.bestairtarget) && !hoverjet_airtargetiswithinview(self.bestairtarget)) {
      var_3 -= level.framedurationseconds;
      waitframe();
    }

    if(isDefined(self.bestairtarget)) {
      hoverjet_moveawayfromtarget(self.bestairtarget);
    } else {
      break;
    }

    if(isDefined(self.bestairtarget)) {
      var_5 = self gettagorigin("tag_" + var_0 + "_archer_missile") + anglesToForward(self.angles) * 100;
      var_6 = var_5 + anglesToForward(self.angles) * 100;
      var_7 = scripts\cp_mp\utility\weapon_utility::_magicbullet(var_1, var_5, var_6, self.owner);
      var_8 = hoverjet_setmissileoffset(self.bestairtarget);
      var_7 missile_settargetEnt(self.bestairtarget, var_8);
      var_7.streakinfo = self.streakinfo;

      if(var_0 == "right") {
        var_0 = "left";
      } else {
        var_0 = "right";
      }
    } else {
      break;
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
  }

  if(istrue(self.movedoffguardlocation)) {
    thread hoverjet_movetolocation(self.currentguardlocation);
    self.movedoffguardlocation = undefined;
    return;
  }
}

function hoverjet_setmissileoffset(var_0) {
  var_1 = (0, 0, 0);

  if(isDefined(var_0.streakinfo)) {
    switch (var_0.streakinfo.streakname) {
      case "chopper_support":
      case "chopper_gunner":
        var_1 = (0, 0, -50);
        break;
      case "radar_drone_overwatch":
        var_1 = (0, 0, -30);
        break;
      case "hover_jet":
        var_1 = (0, 0, 20);
        break;
      case "scrambler_drone_guard":
        var_1 = (0, 0, 10);
        break;
    }
  }

  return var_1;
}

function hoverjet_airtargetiswithinview(var_0) {
  var_1 = 0.866;
  var_2 = anglesToForward(self.angles);
  var_3 = vectorNormalize(var_0.origin - self.origin);
  var_4 = vectordot(var_2, var_3);
  return scripts\engine\utility::ter_op(var_4 >= var_1, 1, 0);
}

function hoverjet_airtargetistooclose(var_0) {
  return scripts\engine\utility::ter_op(distance2dsquared(var_0.origin, self.origin) < 1000000, 1, 0);
}

function hoverjet_moveawayfromtarget(var_0) {
  while(isDefined(var_0) && hoverjet_airtargetistooclose(var_0)) {
    var_1 = undefined;
    var_2 = anglesToForward(self.angles);
    var_3 = anglestoright(self.angles);
    var_4 = self.origin - var_2 * 1000;
    var_5 = self.origin + 707 * (var_3 - var_2);
    var_6 = self.origin + 707 * (-1 * var_2 - var_3);
    var_7 = [var_4, var_5, var_6];
    var_8 = [self, var_0];

    foreach(var_10 in var_7) {
      if(scripts\engine\trace::sphere_trace_passed(self.origin, var_10, 256, var_8)) {
        var_1 = var_10 * (1, 1, 0) + (0, 0, var_0.origin[2]);
      }
    }

    if(isDefined(var_1)) {
      self.movedoffguardlocation = 1;
      self setvehgoalpos(var_1, 1);
    }

    waitframe();
  }
}

function hoverjet_watchforreposition() {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  self setneargoalnotifydist(100);
  self.useobj = spawn("script_model", self.origin);
  self.useobj setModel("tag_origin");
  self.useobj scripts\mp\utility\killstreak::setkillstreakcontrolpriority(self.owner, &"KILLSTREAKS_HINTS/HOVER_JET_GUARD", 360, 360, 30000, 30000, 2);
  self.useobj linkTo(self);

  while(isDefined(self.useobj)) {
    self.useobj waittill("trigger", var_0);
    scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("hover_jet_move");
    self setscriptablepartstate("thrusters", "active", 0);

    if(isDefined(var_0)) {
      thread hoverjet_movetolocation(var_0.origin);
      thread hoverjet_watchfornearmovementgoal();
    }
  }
}

function hoverjet_watchfornearmovementgoal() {
  self endon("death");
  self endon("leaving");
  self waittill("near_goal");
  self setscriptablepartstate("thrusters", "idle", 0);
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("hover_jet_guard");
}

function hoverjet_randomizemovement() {
  self notify("random_movement");
  self endon("random_movement");
  self endon("stopRand");
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
}

function hoverjet_modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  self.currenthealth = self.health - var_4;

  if(self.currenthealth > 0) {
    if(self.currenthealth <= 2000 && self.currentdamagestate == 0) {
      self.currentdamagestate = 1;
      self setscriptablepartstate("body_damage_light", "on");
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("hover_jet_damage_light");
    } else if(self.currenthealth <= 1000 && self.currentdamagestate == 1) {
      self.currentdamagestate = 2;
      self setscriptablepartstate("body_damage_medium", "on");
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("hover_jet_damage_med");
    } else if(self.currenthealth <= 500 && self.currentdamagestate == 2) {
      self.currentdamagestate = 3;
      self setscriptablepartstate("body_damage_heavy", "on");
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("hover_jet_damage_heavy");
    }
  }

  return true;
}

function hoverjet_handledeathdamage(var_0) {
  self.killedbyweapon = var_0.objweapon;
  return true;
}

function hoverjet_handledestroyed() {
  level endon("game_ended");
  self endon("hover_jet_gone");
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }

  if(!scripts\mp\utility\weapon::iskillstreakweapon(self.killedbyweapon)) {
    hoverjet_crash(75);
  }

  thread hoverjet_explode();
}

function hoverjet_crash(var_0) {
  self endon("explode");
  self.iscrashing = 1;
  self.killcament unlink();
  self.killcament.origin = self.origin + (0, 0, 100);

  if(isDefined(self.useobj) && isDefined(self.owner)) {
    self.useobj disableplayeruse(self.owner);
  }

  self clearlookatent();
  self notify("crashing");
  self playsoundonmovingent("ks_hoverjet_crash");
  self setmaxpitchroll(10, 50);
  self vehicle_setspeed(var_0, 20, 20);
  self setneargoalnotifydist(100);
  var_1 = hoverjet_findcrashposition(2500);

  if(!isDefined(var_1)) {
    return;
  }

  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("hover_jet_crash", 1);
  self setvehgoalpos(var_1, 0);
  thread hoverjet_spinout(var_0);
  self waittill("near_goal");
  scripts\cp_mp\utility\dialog_utility::playoperatorstaticinterrupt();
}

function hoverjet_spinout(var_0) {
  self endon("death");
  self setyawspeed(var_0, 50, 50, 0.5);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + var_0 * 0.5);
    wait 0.5;
  }
}

function hoverjet_findcrashposition(var_0) {
  var_1 = self.origin;
  var_2 = 1000;
  var_3 = undefined;
  var_4 = anglesToForward(self.angles);
  var_5 = anglestoright(self.angles);
  var_6 = var_1 + var_4 * var_0 - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 - var_4 * var_0 - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 + var_5 * var_0 - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 - var_5 * var_0 - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 + 0.707 * var_0 * (var_4 + var_5) - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 + 0.707 * var_0 * (var_4 - var_5) - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 + 0.707 * var_0 * (var_5 - var_4) - (0, 0, var_2);
  var_7 = scripts\engine\trace::ray_trace(var_1, var_6, self);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 + 0.707 * var_0 * (-1 * var_4 - var_5) - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  return var_3;
}

function hoverjet_explode() {
  self notify("explode");
  self radiusdamage(self.origin, 1000, 200, 200, self.owner, "MOD_EXPLOSIVE", "hover_jet_turret_mp");
  self setscriptablepartstate("explode", "on", 0);
  wait 0.35;
  thread hoverjet_cleanup(1);
}

function hoverjet_leave() {
  self endon("death");
  self.isleaving = 1;
  self notify("leaving");

  if(isDefined(self.useobj) && isDefined(self.owner)) {
    self.useobj disableplayeruse(self.owner);
  }

  hoverjet_breakofftarget(undefined, 1);
  self setmaxpitchroll(0, 0);
  self vehicle_setspeed(35, 25);
  var_0 = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
  var_0 += (0, 0, 900);
  self setvehgoalpos(var_0, 1);
  self vehicleplayanim(level.scr_anim["hover_jet"]["exit"]);
  self playsoundonmovingent("ks_hoverjet_leave");
  self waittill("goal");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  self setscriptablepartstate("contrails", "on", 0);
  var_1 = self.origin + anglesToForward(self.angles) * 24000;
  self vehicle_setspeed(250, 75);
  self setvehgoalpos(var_1, 1);
  self waittill("goal");
  self notify("hover_jet_gone");
  hoverjet_cleanup();
}

function hoverjet_cleanup(var_0) {
  if(isDefined(self.turret)) {
    self.turret setentityowner(undefined);
    self.turret delete();
  }

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  if(isDefined(self.turret.groundtargetent)) {
    self.turret.groundtargetent delete();
  }

  if(isDefined(self.scenenode)) {
    self.scenenode delete();
  }

  self setscriptablepartstate("blinking_lights", "off", 0);
  self setscriptablepartstate("thrusters", "off", 0);
  self.streakinfo.onspray = istrue(var_0);

  if(!istrue(self.ref_12aa4)) {
    self.owner scripts\cp_mp\utility\killstreak_utility::ref_12aa7(self.streakinfo);
  }

  level.hoverjets = scripts\engine\utility::array_remove(level.hoverjets, self);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function hoverjet_watchtargetstatus(var_0) {
  var_1 = var_0 getentitynumber();
  self endon("hoverJet_breakOffTarget " + var_1);
  self endon("hoverJet_breakOffAllTargets");
  self endon("death");
  self endon("leaving");

  if(isPlayer(var_0)) {
    thread hoverjet_watchgroundtargetdeathdisconnect(var_0);
  } else {
    thread hoverjet_watchairtargetdeath(var_0);
  }

  thread hoverjet_watchforbreakaction(var_0, "hoverJet_targetLost " + var_1);
  thread hoverjet_watchforbreakaction(var_0, "hoverJet_targetNotInView " + var_1);
  thread hoverjet_watchforbreakaction(var_0, "hoverJet_moveToNewlocation");
  thread hoverjet_watchforbreakaction(var_0, "hoverJet_targetTimeout");
}

function hoverjet_watchgroundtargetdeathdisconnect(var_0) {
  var_1 = var_0 getentitynumber();
  self endon("hoverJet_breakOffTarget " + var_1);
  self endon("hoverJet_breakOffAllTargets");
  self endon("death");
  self endon("leaving");
  var_0 waittill("death_or_disconnect");
  self notify("hoverJet_targetLost " + var_1);
}

function hoverjet_watchairtargetdeath(var_0) {
  var_1 = var_0 getentitynumber();
  self endon("hoverJet_breakOffTarget " + var_1);
  self endon("hoverJet_breakOffAllTargets");
  self endon("death");
  self endon("leaving");
  var_0 waittill("death");
  self notify("hoverJet_targetLost " + var_1);
}

function hoverjet_watchforbreakaction(var_0, var_1) {
  var_2 = var_0 getentitynumber();
  self endon("hoverJet_breakOffTarget " + var_2);
  self endon("hoverJet_breakOffAllTargets");
  self endon("death");
  self endon("leaving");
  self waittill(var_1);
  hoverjet_breakofftarget(var_2);
}

function hoverjet_watchtargetlos(var_0, var_1, var_2) {
  var_3 = var_0 getentitynumber();
  self endon("death");
  self endon("leaving");
  self endon("hoverJet_breakOffTarget " + var_3);
  self endon("hoverJet_breakOffAllTargets");
  self.bestgroundtarget endon("death_or_disconnect");
  var_4 = undefined;

  if(!isDefined(var_1)) {
    var_1 = 500;
  }

  var_5 = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);
  var_6 = [self.turret];
  jumpiffalse(isDefined(var_2)) LOC_00000086;
  GscBinSkip0(0x2e, var_6.size, var_2);

  for(;;) {
    var_8 = scripts\engine\trace::ray_trace_passed(self.turret gettagorigin("tag_barrel"), var_0 gettagorigin("j_head"), var_6, var_5);

    if(!istrue(var_8)) {
      if(!isDefined(var_4)) {
        var_4 = gettime();
      }

      if(gettime() - var_4 > var_1) {
        self notify("hoverJet_targetNotInView " + var_3);
        return;
      }
    } else {
      var_4 = undefined;
    }

    wait 0.25;
  }
}

function hoverjet_watchtargettimeout(var_0) {
  var_1 = var_0 getentitynumber();
  self endon("death");
  self endon("leaving");
  self endon("hoverJet_breakOffTarget " + var_1);
  self endon("hoverJet_breakOffAllTargets");
  self.bestgroundtarget endon("death_or_disconnect");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  self notify("hoverJet_targetTimeout");
}

function hoverjet_breakofftarget(var_0, var_1) {
  var_2 = undefined;

  if(!isDefined(var_0) || istrue(var_1)) {
    self.bestgroundtarget = undefined;
    self.bestairtarget = undefined;
    self clearlookatent();
    self.turret cleartargetentity();
    self.turret.groundtargetent unlink();
    var_2 = "Breaking off all targets";
    self notify("hoverJet_breakOffAllTargets");
    return;
  } else {
    if(isDefined(self.bestgroundtarget) && var_0 == self.bestgroundtarget getentitynumber()) {
      var_2 = "Breaking off ground target: " + self.bestgroundtarget.name;
      self.bestgroundtarget = undefined;
      self.turret cleartargetentity();
      self.turret.groundtargetent unlink();
    } else if(isDefined(self.bestairtarget) && var_0 == self.bestairtarget getentitynumber()) {
      var_2 = "Breaking off air target: " + self.bestairtarget.model;
      self.bestairtarget = undefined;
    } else {
      var_2 = "Breaking off removed target: " + var_0;
    }

    if(!isDefined(self.bestgroundtarget) && !isDefined(self.bestairtarget)) {
      self clearlookatent();
    }
  }

  self notify("hoverJet_breakOffTarget " + var_0);
}

function hoverjet_getbestairtarget(var_0) {
  self endon("death");
  self endon("leaving");
  var_1 = undefined;
  var_2 = undefined;
  var_3 = 0;

  foreach(var_5 in var_0) {
    if(!isDefined(var_5)) {
      continue;
    }

    if(!istrue(var_3)) {
      if(level.teambased && var_5.team == self.team) {
        continue;
      }

      if(var_5.owner == self.owner) {
        continue;
      }
    }

    var_7 = distance2dsquared(var_5.origin, self.origin);

    if(var_7 >= 6250000) {
      continue;
    }

    if(!isDefined(var_2) || var_7 < var_2) {
      var_1 = var_5;
      var_2 = var_7;
    }
  }

  return var_1;
}