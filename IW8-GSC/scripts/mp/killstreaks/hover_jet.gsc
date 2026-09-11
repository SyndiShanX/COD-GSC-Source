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

function weapongivenhoverjet(var0) {
  scripts\mp\killstreaks\mapselect::startmapselectsequence();
  return true;
}

function tryusehoverjet() {
  var0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("hover_jet", self);
  return tryusehoverjetfromstruct(var0);
}

function tryusehoverjetfromstruct(var0) {
  var1 = self.team;

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    return 0;
  }

  level.incomingallhoverjets++;
  var2 = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    var2 = 2;
  }

  if(level.hoverjets.size >= var2 || level.hoverjets.size + level.incomingallhoverjets > var2) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    level.incomingallhoverjets--;
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return 0;
  }

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased) {
    var3 = 1;
    level.incominghoverjets[var1]++;

    if(scripts\cp_mp\utility\killstreak_utility::getnumactivekillstreakperteam(var1, level.hoverjets) + level.incominghoverjets[var1] > var3) {
      level.incomingallhoverjets--;
      level.incominghoverjets[var1]--;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_VTOL_JET");
      }

      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return 0;
    }
  }

  var4 = any_player_within_distance3d(var0);
  var4 = istrue(var4);
  level.incomingallhoverjets--;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased) {
    level.incominghoverjets[var1]--;
  }

  if(!var4) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  }

  return var4;
}

function any_player_within_distance3d(var0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var0)) {
      return false;
    }
  }

  var1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(var0, getcompleteweaponname("ks_remote_map_mp"), 1, &weapongivenhoverjet);

  if(!istrue(var1)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var0)) {
      return false;
    }
  }

  var2 = hoverjet_getmapselectioninfo(var0, 1);

  if(!isDefined(var2)) {
    return false;
  }

  var0 notify("killstreak_finished_with_deploy_weapon");
  thread starthoverjetairstrikepass(self, var0, var2);
  var3 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var0.streakname);
    var3 = 2;
  }

  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var0.streakname, 1, var3);
  scripts\common\utility::ref_13e0a(level.ref_11b2a, "hover_jet", self.origin);
  thread scripts\mp\hud_util::teamplayercardsplash("used_hover_jet", self);
  return true;
}

function hoverjet_getmapselectioninfo(var0, var1) {
  scripts\common\utility::allow_weapon_switch(0);
  self setsoundsubmix("mp_killstreak_overlay");
  var2 = scripts\mp\killstreaks\mapselect::getselectmappoint(var0, var1);

  if(!isDefined(var2)) {
    scripts\common\utility::allow_weapon_switch(1);
    self clearsoundsubmix("mp_killstreak_overlay");
    return undefined;
  }

  scripts\common\utility::allow_weapon_switch(1);
  self clearsoundsubmix("mp_killstreak_overlay");
  return var2;
}

function starthoverjetairstrikepass(var0, var1, var2) {
  level endon("game_ended");
  var3 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var4 = 24000;
  var5 = 6500;
  var6 = 3250;
  var7 = 1500;
  var8 = (0, 0, 0);
  var9 = 1500;
  var10 = var0.angles;
  var11 = 1;

  if(isDefined(var3)) {
    var6 = var3.origin[2] + 750;
  }

  var12 = scripts\cp_mp\utility\game_utility::getlocaleid();

  if(isDefined(var12) && var12 == "locale_6") {
    var6 += 500;
  }

  var14 = var2[0].location;
  var10 = scripts\cp_mp\killstreaks\airstrike::callstrike_findoptimaldirection(var0, var14, var6);
  var15 = scripts\cp_mp\killstreaks\airstrike::getflightpath(var14, var10, var4, var3, var6, var5, var9, var1.streakname, var11);
  var16 = var15["startPoint"];
  var17 = var15["endPoint"];
  var18 = "veh8_mil_air_halfa_mp";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var0)) {
    var18 = "veh8_mil_air_halfa_east_mp";
  }

  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  var19 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var0, var16, var10, "veh_hover_jet_mp", var18);

  if(!isDefined(var19)) {
    return;
  }

  var20 = 45;
  var19.speed = 250;
  var19.accel = 175;
  var19.health = 2500;
  var19.maxhealth = 2500;
  var19.angles = vectortoangles(var10);
  var19.lifetime = var20;
  var19.team = var0.team;
  var19.owner = var0;
  var19.streakinfo = var1;
  var19.streakname = var1.streakname;
  var19.flaresreservecount = 1;
  var19.returngoal = var14;
  var19.currentdamagestate = 0;
  var19.flyheight = var6;
  var19.hoverheight = var7;
  var19.missiles = 6;
  var19.pers["team"] = var19.team;
  var19.bestgroundtarget = undefined;
  var19.bestairtarget = undefined;
  var19.flightdir = var15["directionAngles"];
  var19 setmaxpitchroll(0, 90);
  var19 vehicle_setspeed(var19.speed, var19.accel);
  var19 sethoverparams(50, 100, 50);
  var19 setturningability(0.05);
  var19 setyawspeed(45, 25, 25, 0.5);
  var19 setotherent(var19.owner);
  var19 setCanDamage(1);
  var19 setneargoalnotifydist(700);
  var19 setvehicleteam(var19.team);
  level.hoverjets[level.hoverjets.size] = var19;
  var19 scripts\mp\utility\killstreak::addtoactivekillstreaklist(var1.streakname, "Killstreak_Air", var19.owner, 0, 1, 100);
  var19 setscriptablepartstate("blinking_lights", "on", 0);
  var19 setscriptablepartstate("thrusters", "active", 0);
  var19 setscriptablepartstate("contrails", "on", 0);
  var19.turret = spawnturret("misc_turret", var19 gettagorigin("tag_turret"), "hover_jet_turret_mp");
  var19.turret setModel("veh8_mil_air_halfa_turret");
  var19.turret.owner = var19.owner;
  var19.turret.team = var19.team;
  var19.turret.angles = var19.angles;
  var19.turret.streakinfo = var1;
  var19.turret linkTo(var19, "tag_turret", (0, 0, 5), (0, 0, 0));
  var19.turret setturretteam(var19.team);
  var19.turret setturretmodechangewait(0);
  var19.turret setmode("manual_target");
  var19.turret setsentryowner(var19.owner);
  var19.turret setdefaultdroppitch(45);
  var19.turret maketurretinoperable();
  var19.turret setleftarc(360);
  var19.turret setrightarc(360);
  var19.turret setbottomarc(90);
  var19.turret settoparc(90);
  var19.turret setconvergencetime(0.5, "pitch");
  var19.turret setconvergencetime(0.5, "yaw");
  var19.turret setconvergenceheightpercent(0.65);
  var19.killcament = spawn("script_model", var19.turret gettagorigin("bi_center"));
  var19.killcament linkTo(var19, "tag_origin", (-500, 0, 500), (0, 0, 0));
  var19.turret.groundtargetent = spawn("script_model", var19.origin);
  var19.turret.groundtargetent setModel("tag_origin");
  var19.turret.groundtargetent dontinterpolate();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var19[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var1.streakname, "Killstreak_Air", var0, 0, 1, 100);
  }

  var19.animname = var1.streakname;
  var19.scenenode = spawn("script_model", var19.returngoal * (1, 1, 0) + (0, 0, var6));
  var19.scenenode.angles = var19.angles;
  var19.scenenode setModel("tag_origin");
  thread hoverjet_firetrackermissiles(var19);
  hoverjet_playflyfx(var19);
  var24 = getanimlength(level.scr_anim[var19.animname]["airstrike_flyby"]);
  var25 = scripts\engine\utility::get_notetrack_time(level.scr_anim[var19.animname]["airstrike_flyby"], "contrail_off");
  var19.scenenode thread scripts\common\anim::anim_single_solo(var19, "airstrike_flyby");
  thread hoverjet_delaysetscriptable(var19, var25, "contrails");
  thread hoverjet_handledestroyed();
  thread spawn_script_model_driver_and_passengers();
  var19 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", self);
  var19 scripts\mp\utility\killstreak::killstreak_make_vehicle(var1.streakname, "destroyed_hover_jet", undefined, "timeout_hover_jet", "callout_destroyed_hover_jet");
  var19 scripts\mp\utility\killstreak::killstreak_set_pre_mod_damage_callback(var1.streakname);
  var19 scripts\mp\utility\killstreak::killstreak_set_post_mod_damage_callback(var1.streakname, &hoverjet_modifydamage);
  var19 scripts\mp\utility\killstreak::killstreak_set_death_callback(var1.streakname, &hoverjet_handledeathdamage);
  var19 thread scripts\mp\killstreaks\flares::flares_handleincomingstinger(&hoverjet_handlemissiledetection);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var24);

  if(!isDefined(var19)) {
    return;
  }

  if(isDefined(var19.scenenode)) {
    var19.scenenode delete();
  }

  starthoverjetdefend(var19, var1);
}

function hoverjet_delaysetscriptable(var0, var1, var2) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var0);
  self setscriptablepartstate(var1, var2, 0);
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

function hoverjet_firetrackermissiles(var0) {
  self endon("death");
  level endon("game_ended");
  var1 = scripts\engine\utility::get_notetrack_time(level.scr_anim["hover_jet"]["airstrike_flyby"], "attack");
  var2 = var1 - 4;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var2);
  var3 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid"];
  var4 = physics_createcontents(var3);
  var5 = self.angles * (0, 1, 0);
  var6 = anglesToForward(var5);
  var7 = anglestoright(var5);
  var8 = [var0 - var6 * 2250 + var7 * 750, var0 - var6 * 1500 - var7 * 750, var0 - var6 * 750 + var7 * 250, var0 - var7 * 250, var0 + var6 * 750 + var7 * 750, var0 + var6 * 1500 - var7 * 750, var0 + var6 * 2250 + var7 * 250, var0 + var6 * 3000 - var7 * 250];
  var9 = ["tag_right_aphid_missile", "tag_left_aphid_missile", "tag_right_archer_missile", "tag_left_archer_missile"];
  var10 = 0;
  var11 = [];

  foreach(var13 in var8) {
    var14 = var13 + (0, 0, 10000);
    var15 = var13 - (0, 0, 10000);
    var16 = scripts\engine\trace::ray_trace(var14, var15, level.characters, var4);
    var17 = scripts\common\utility::playersinsphere(var16["position"], 1000);
    var18 = hoverjet_findmissiletarget(var17, var11);
    var19 = self gettagorigin(var9[var10]) + anglesToForward(self gettagangles(var9[var10])) * 300;
    var20 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("hover_jet_proj_mp"), var19, var16["position"], self.owner);
    var20.killcament = spawn("script_model", var20.origin);
    var20.killcament linkTo(var20, "tag_origin", (-100, 0, 500), (0, 0, 0));
    thread hoverjet_missilekillcammove(var20.killcament, var16["position"]);
    var20.streakinfo = self.streakinfo;
    self.streakinfo.shots_fired++;
    thread hoverjet_firemissilescriptable(var10 + 1);

    if(isDefined(var18)) {
      var13 = var18.origin;
      var11 = var18;
      thread hoverjet_delaymissiletracking(var20, 0.05, var18);
    }

    wait 0.5;
    var10++;

    if(var10 > var9.size - 1) {
      var10 = 0;
    }
  }

  var11 = undefined;
}

function hoverjet_missilekillcammove(var0, var1) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
  self unlink();
  self moveTo(var0 - anglesToForward(var1) * 750, 6);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(7);
  self delete();
}

function hoverjet_firemissilescriptable(var0) {
  self endon("death");
  level endon("game_ended");
  self setscriptablepartstate("fire_missile_" + var0, "on", 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);
  self setscriptablepartstate("fire_missile_" + var0, "off", 0);
}

function hoverjet_findmissiletarget(var0, var1) {
  var2 = undefined;

  foreach(var4 in var0) {
    if(level.teambased && var4.team == self.team) {
      continue;
    }

    if(var4 == self.owner) {
      continue;
    }

    if(scripts\engine\utility::array_contains(var1, var4)) {
      continue;
    }

    if(var4 scripts\mp\utility\perk::_hasperk("specialty_blindeye")) {
      continue;
    }

    var2 = var4;
    break;
  }

  return var2;
}

function hoverjet_delaymissiletracking(var0, var1, var2) {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var1);

  if(isDefined(var0)) {
    var0 missile_settargetEnt(var2, (0, 0, 10));
    return;
  }
}

function hoverjet_delayresetscriptable(var0) {
  self endon("death");
  level endon("game_ended");
  self setscriptablepartstate("explode" + var0, "active", 0);
  wait 1;
  self setscriptablepartstate("explode" + var0, "neutral", 0);
}

function starthoverjetdefend(var0) {
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

function hoverjet_handlemissiledetection(var0, var1, var2, var3) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");

  for(;;) {
    if(!isDefined(var2)) {
      break;
    }

    var4 = var2 getpointinbounds(0, 0, 0);
    var5 = distance(self.origin, var4);

    if(var5 < 4000 && var2.flaresreservecount > 0) {
      var2 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("hover_jet_flares", 1);
      scripts\mp\killstreaks\flares::flares_reducereserves(var2);
      var2 thread scripts\mp\killstreaks\flares::flares_playFX("jet_flares", var3);
      var6 = var2 scripts\mp\killstreaks\flares::flares_deploy();
      self missile_settargetEnt(var6);
      self notify("missile_pairedWithFlare");
      return;
    }

    waitframe();
  }
}

function hoverjet_watchlifetime(var0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var0);
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

function hoverjet_leaveonownernotify(var0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  self.owner waittill(var0);
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

function hoverjet_movetolocation(var0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  var1 = [self, self.turret];

  for(;;) {
    var2 = self.origin;
    var3 = var0 * (1, 1, 0) + (0, 0, self.origin[2]);
    var4 = scripts\engine\trace::sphere_trace(var2, var3, 256, var1);
    var5 = 0;
    var6 = var0[0];
    var7 = var0[1];

    if(isDefined(var4)) {
      if(var4["hittype"] != "hittype_none") {
        var6 = var4["position"][0];
        var7 = var4["position"][1];
        var5 = 1;
      }
    }

    var8 = hoverjet_getcorrectheight(var6, var7, 20);
    var9 = (var6, var7, var8);
    self setvehgoalpos(var9, 1);
    self waittill("near_goal");

    if(!istrue(var5)) {
      self.currentguardlocation = var9;
      self notify("hoverJet_moveToNewlocation", var9);
      break;
    }
  }

  self clearlookatent();
}

function hoverjet_getcorrectheight(var0, var1, var2) {
  var3 = self.hoverheight;
  var5 = hoverjet_tracegroundpoint(var0, var1);
  var6 = var5 + var3;
  var6 += randomint(var2);
  return var6;
}

function hoverjet_tracegroundpoint(var0, var1) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  var2 = -99999;
  var3 = self.origin[2];
  var4 = level.averagealliesz;
  var5 = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 0, 0, 0, 0);
  var6 = scripts\engine\trace::sphere_trace((var0, var1, var3), (var0, var1, var2), 512, self, var5, 1);

  if(var6["position"][2] < var4) {
    var7 = var4;
  } else {
    var7 = var7["position"][2];
  }

  return var7;
}

function hoverjet_engagegroundtargets() {
  self notify("engageGround");
  self endon("engageGround");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");

  for(;;) {
    var0 = undefined;

    if(!isDefined(self.bestgroundtarget)) {
      var1 = hoverjet_getbestgroundtarget();
      self.bestgroundtarget = var1[0];
      var0 = var1[1];
      var1 = undefined;
      self notify("acquiringTarget", self.bestgroundtarget);

      if(!isDefined(self.bestgroundtarget)) {
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.25);
        continue;
      }
    }

    var2 = undefined;

    if(istrue(var0)) {
      var2 = self.bestgroundtarget scripts\cp_mp\utility\player_utility::getvehicle();
    }

    self.turret settargetentity(self.turret.groundtargetent);

    if(!isDefined(self.bestairtarget)) {
      self setlookatent(self.bestgroundtarget);
    }

    thread hoverjet_watchtargetstatus(self.bestgroundtarget);
    thread hoverjet_watchtargetlos(self.bestgroundtarget, undefined, var2);
    thread hoverjet_watchtargettimeout(self.bestgroundtarget);
    hoverjet_fireongroundtarget(var0);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  }
}

function hoverjet_getbestgroundtarget() {
  self endon("death");
  self endon("leaving");
  var0 = scripts\cp_mp\killstreaks\chopper_support::choppersupport_gettargets(self.turret, 3000, 0, 1);
  var1 = undefined;
  var2 = undefined;
  var3 = undefined;

  foreach(var5 in var0) {
    if(!scripts\cp_mp\killstreaks\chopper_support::goliath_init(var5.player)) {
      continue;
    }

    var6 = 0;
    var7 = 0;
    var8 = abs(vectortoangles(var5.player.origin - self.origin)[1]);
    var9 = abs(self gettagangles("tag_flash")[1]);
    var8 = abs(var8 - var9);
    var10 = var5.player getweaponslistitems();

    foreach(var12 in var10) {
      var13 = weaponclass(var12);

      if(var13 == "rocketlauncher") {
        var8 -= 40;
      }
    }

    if(istrue(var5.ref_13a93)) {
      var7 = 1;
      var8 += 40;
    }

    if(!isDefined(var1) || var1 > var8) {
      var1 = var8;
      var2 = var5.player;
      var3 = var7;
    }
  }

  return [var2, var3];
}

function hoverjet_fireongroundtarget(var0) {
  var1 = weaponfiretime("hover_jet_turret_mp");
  var2 = 0;
  var3 = 0;
  var4 = 100;

  while(isDefined(self) && isDefined(self.bestgroundtarget) && !isDefined(self.iscrashing) && !isDefined(self.isleaving)) {
    if(hoverjet_turretlookingattarget(self.turret)) {
      var6 = undefined;

      if(istrue(var0)) {
        var6 = self.bestgroundtarget.origin;
      } else {
        var6 = self.bestgroundtarget gettagorigin("j_mainroot");
      }

      scripts\cp_mp\killstreaks\chopper_support::choppersupport_setattackpoint(self.turret, self.bestgroundtarget, var6, var4);

      if(var3 == 15) {
        var4 = 50;
      } else if(var3 == 30) {
        var4 = undefined;
      }

      self.turret shootturret("tag_flash");
      var3++;
      self.turret.streakinfo.shots_fired++;
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var1);
  }
}

function hoverjet_turretlookingattarget() {
  var0 = 0.996;
  var1 = anglesToForward(self gettagangles("tag_flash"));
  var2 = vectorNormalize(self.groundtargetent.origin - self.origin);
  var3 = vectordot(var1, var2);

  if(isDefined(self gettargetentity(1)) && var3 >= var0) {
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
      var0 = [];
      var0 = scripts\engine\utility::array_combine(level.helis, level.littlebirds, level.supportdrones);
      self.bestairtarget = hoverjet_getbestairtarget(var0);
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
  var0 = "right";
  var1 = getcompleteweaponname("hover_jet_proj_mp");
  var2 = undefined;
  self setlookatent(self.bestairtarget);

  while(isDefined(self) && isDefined(self.bestairtarget)) {
    var3 = 5;

    if(!istrue(var2)) {
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("hover_jet_attack_air");
      var2 = 1;
    }

    while(var3 > 0 && isDefined(self.bestairtarget) && !hoverjet_airtargetiswithinview(self.bestairtarget)) {
      var3 -= level.framedurationseconds;
      waitframe();
    }

    if(isDefined(self.bestairtarget)) {
      hoverjet_moveawayfromtarget(self.bestairtarget);
    } else {
      break;
    }

    if(isDefined(self.bestairtarget)) {
      var5 = self gettagorigin("tag_" + var0 + "_archer_missile") + anglesToForward(self.angles) * 100;
      var6 = var5 + anglesToForward(self.angles) * 100;
      var7 = scripts\cp_mp\utility\weapon_utility::_magicbullet(var1, var5, var6, self.owner);
      var8 = hoverjet_setmissileoffset(self.bestairtarget);
      var7 missile_settargetEnt(self.bestairtarget, var8);
      var7.streakinfo = self.streakinfo;

      if(var0 == "right") {
        var0 = "left";
      } else {
        var0 = "right";
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

function hoverjet_setmissileoffset(var0) {
  var1 = (0, 0, 0);

  if(isDefined(var0.streakinfo)) {
    switch (var0.streakinfo.streakname) {
      case "chopper_support":
      case "chopper_gunner":
        var1 = (0, 0, -50);
        break;
      case "radar_drone_overwatch":
        var1 = (0, 0, -30);
        break;
      case "hover_jet":
        var1 = (0, 0, 20);
        break;
      case "scrambler_drone_guard":
        var1 = (0, 0, 10);
        break;
    }
  }

  return var1;
}

function hoverjet_airtargetiswithinview(var0) {
  var1 = 0.866;
  var2 = anglesToForward(self.angles);
  var3 = vectorNormalize(var0.origin - self.origin);
  var4 = vectordot(var2, var3);
  return scripts\engine\utility::ter_op(var4 >= var1, 1, 0);
}

function hoverjet_airtargetistooclose(var0) {
  return scripts\engine\utility::ter_op(distance2dsquared(var0.origin, self.origin) < 1000000, 1, 0);
}

function hoverjet_moveawayfromtarget(var0) {
  while(isDefined(var0) && hoverjet_airtargetistooclose(var0)) {
    var1 = undefined;
    var2 = anglesToForward(self.angles);
    var3 = anglestoright(self.angles);
    var4 = self.origin - var2 * 1000;
    var5 = self.origin + 707 * (var3 - var2);
    var6 = self.origin + 707 * (-1 * var2 - var3);
    var7 = [var4, var5, var6];
    var8 = [self, var0];

    foreach(var10 in var7) {
      if(scripts\engine\trace::sphere_trace_passed(self.origin, var10, 256, var8)) {
        var1 = var10 * (1, 1, 0) + (0, 0, var0.origin[2]);
      }
    }

    if(isDefined(var1)) {
      self.movedoffguardlocation = 1;
      self setvehgoalpos(var1, 1);
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
    self.useobj waittill("trigger", var0);
    scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("hover_jet_move");
    self setscriptablepartstate("thrusters", "active", 0);

    if(isDefined(var0)) {
      thread hoverjet_movetolocation(var0.origin);
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

function hoverjet_modifydamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflags;
  self.currenthealth = self.health - var4;

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

function hoverjet_handledeathdamage(var0) {
  self.killedbyweapon = var0.objweapon;
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

function hoverjet_crash(var0) {
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
  self vehicle_setspeed(var0, 20, 20);
  self setneargoalnotifydist(100);
  var1 = hoverjet_findcrashposition(2500);

  if(!isDefined(var1)) {
    return;
  }

  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("hover_jet_crash", 1);
  self setvehgoalpos(var1, 0);
  thread hoverjet_spinout(var0);
  self waittill("near_goal");
  scripts\cp_mp\utility\dialog_utility::playoperatorstaticinterrupt();
}

function hoverjet_spinout(var0) {
  self endon("death");
  self setyawspeed(var0, 50, 50, 0.5);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + var0 * 0.5);
    wait 0.5;
  }
}

function hoverjet_findcrashposition(var0) {
  var1 = self.origin;
  var2 = 1000;
  var3 = undefined;
  var4 = anglesToForward(self.angles);
  var5 = anglestoright(self.angles);
  var6 = var1 + var4 * var0 - (0, 0, var2);

  if(scripts\engine\trace::ray_trace_passed(var1, var6, self)) {
    var3 = var6;
    return var3;
  }

  var6 = var1 - var4 * var0 - (0, 0, var2);

  if(scripts\engine\trace::ray_trace_passed(var1, var6, self)) {
    var3 = var6;
    return var3;
  }

  var6 = var1 + var5 * var0 - (0, 0, var2);

  if(scripts\engine\trace::ray_trace_passed(var1, var6, self)) {
    var3 = var6;
    return var3;
  }

  var6 = var1 - var5 * var0 - (0, 0, var2);

  if(scripts\engine\trace::ray_trace_passed(var1, var6, self)) {
    var3 = var6;
    return var3;
  }

  var6 = var1 + 0.707 * var0 * (var4 + var5) - (0, 0, var2);

  if(scripts\engine\trace::ray_trace_passed(var1, var6, self)) {
    var3 = var6;
    return var3;
  }

  var6 = var1 + 0.707 * var0 * (var4 - var5) - (0, 0, var2);

  if(scripts\engine\trace::ray_trace_passed(var1, var6, self)) {
    var3 = var6;
    return var3;
  }

  var6 = var1 + 0.707 * var0 * (var5 - var4) - (0, 0, var2);
  var7 = scripts\engine\trace::ray_trace(var1, var6, self);

  if(scripts\engine\trace::ray_trace_passed(var1, var6, self)) {
    var3 = var6;
    return var3;
  }

  var6 = var1 + 0.707 * var0 * (-1 * var4 - var5) - (0, 0, var2);

  if(scripts\engine\trace::ray_trace_passed(var1, var6, self)) {
    var3 = var6;
    return var3;
  }

  return var3;
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
  var0 = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
  var0 += (0, 0, 900);
  self setvehgoalpos(var0, 1);
  self vehicleplayanim(level.scr_anim["hover_jet"]["exit"]);
  self playsoundonmovingent("ks_hoverjet_leave");
  self waittill("goal");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  self setscriptablepartstate("contrails", "on", 0);
  var1 = self.origin + anglesToForward(self.angles) * 24000;
  self vehicle_setspeed(250, 75);
  self setvehgoalpos(var1, 1);
  self waittill("goal");
  self notify("hover_jet_gone");
  hoverjet_cleanup();
}

function hoverjet_cleanup(var0) {
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
  self.streakinfo.onspray = istrue(var0);

  if(!istrue(self.ref_12aa4)) {
    self.owner scripts\cp_mp\utility\killstreak_utility::ref_12aa7(self.streakinfo);
  }

  level.hoverjets = scripts\engine\utility::array_remove(level.hoverjets, self);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function hoverjet_watchtargetstatus(var0) {
  var1 = var0 getentitynumber();
  self endon("hoverJet_breakOffTarget " + var1);
  self endon("hoverJet_breakOffAllTargets");
  self endon("death");
  self endon("leaving");

  if(isPlayer(var0)) {
    thread hoverjet_watchgroundtargetdeathdisconnect(var0);
  } else {
    thread hoverjet_watchairtargetdeath(var0);
  }

  thread hoverjet_watchforbreakaction(var0, "hoverJet_targetLost " + var1);
  thread hoverjet_watchforbreakaction(var0, "hoverJet_targetNotInView " + var1);
  thread hoverjet_watchforbreakaction(var0, "hoverJet_moveToNewlocation");
  thread hoverjet_watchforbreakaction(var0, "hoverJet_targetTimeout");
}

function hoverjet_watchgroundtargetdeathdisconnect(var0) {
  var1 = var0 getentitynumber();
  self endon("hoverJet_breakOffTarget " + var1);
  self endon("hoverJet_breakOffAllTargets");
  self endon("death");
  self endon("leaving");
  var0 waittill("death_or_disconnect");
  self notify("hoverJet_targetLost " + var1);
}

function hoverjet_watchairtargetdeath(var0) {
  var1 = var0 getentitynumber();
  self endon("hoverJet_breakOffTarget " + var1);
  self endon("hoverJet_breakOffAllTargets");
  self endon("death");
  self endon("leaving");
  var0 waittill("death");
  self notify("hoverJet_targetLost " + var1);
}

function hoverjet_watchforbreakaction(var0, var1) {
  var2 = var0 getentitynumber();
  self endon("hoverJet_breakOffTarget " + var2);
  self endon("hoverJet_breakOffAllTargets");
  self endon("death");
  self endon("leaving");
  self waittill(var1);
  hoverjet_breakofftarget(var2);
}

function hoverjet_watchtargetlos(var0, var1, var2) {
  var3 = var0 getentitynumber();
  self endon("death");
  self endon("leaving");
  self endon("hoverJet_breakOffTarget " + var3);
  self endon("hoverJet_breakOffAllTargets");
  self.bestgroundtarget endon("death_or_disconnect");
  var4 = undefined;

  if(!isDefined(var1)) {
    var1 = 500;
  }

  var5 = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);
  var6 = [self.turret];
  jumpiffalse(isDefined(var2)) LOC_00000086;
  GscBinSkip0(0x2e, var6.size, var2);

  for(;;) {
    var8 = scripts\engine\trace::ray_trace_passed(self.turret gettagorigin("tag_barrel"), var0 gettagorigin("j_head"), var6, var5);

    if(!istrue(var8)) {
      if(!isDefined(var4)) {
        var4 = gettime();
      }

      if(gettime() - var4 > var1) {
        self notify("hoverJet_targetNotInView " + var3);
        return;
      }
    } else {
      var4 = undefined;
    }

    wait 0.25;
  }
}

function hoverjet_watchtargettimeout(var0) {
  var1 = var0 getentitynumber();
  self endon("death");
  self endon("leaving");
  self endon("hoverJet_breakOffTarget " + var1);
  self endon("hoverJet_breakOffAllTargets");
  self.bestgroundtarget endon("death_or_disconnect");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  self notify("hoverJet_targetTimeout");
}

function hoverjet_breakofftarget(var0, var1) {
  var2 = undefined;

  if(!isDefined(var0) || istrue(var1)) {
    self.bestgroundtarget = undefined;
    self.bestairtarget = undefined;
    self clearlookatent();
    self.turret cleartargetentity();
    self.turret.groundtargetent unlink();
    var2 = "Breaking off all targets";
    self notify("hoverJet_breakOffAllTargets");
    return;
  } else {
    if(isDefined(self.bestgroundtarget) && var0 == self.bestgroundtarget getentitynumber()) {
      var2 = "Breaking off ground target: " + self.bestgroundtarget.name;
      self.bestgroundtarget = undefined;
      self.turret cleartargetentity();
      self.turret.groundtargetent unlink();
    } else if(isDefined(self.bestairtarget) && var0 == self.bestairtarget getentitynumber()) {
      var2 = "Breaking off air target: " + self.bestairtarget.model;
      self.bestairtarget = undefined;
    } else {
      var2 = "Breaking off removed target: " + var0;
    }

    if(!isDefined(self.bestgroundtarget) && !isDefined(self.bestairtarget)) {
      self clearlookatent();
    }
  }

  self notify("hoverJet_breakOffTarget " + var0);
}

function hoverjet_getbestairtarget(var0) {
  self endon("death");
  self endon("leaving");
  var1 = undefined;
  var2 = undefined;
  var3 = 0;

  foreach(var5 in var0) {
    if(!isDefined(var5)) {
      continue;
    }

    if(!istrue(var3)) {
      if(level.teambased && var5.team == self.team) {
        continue;
      }

      if(var5.owner == self.owner) {
        continue;
      }
    }

    var7 = distance2dsquared(var5.origin, self.origin);

    if(var7 >= 6250000) {
      continue;
    }

    if(!isDefined(var2) || var7 < var2) {
      var1 = var5;
      var2 = var7;
    }
  }

  return var1;
}