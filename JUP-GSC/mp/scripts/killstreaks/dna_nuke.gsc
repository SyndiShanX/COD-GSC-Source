/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\killstreaks\dna_nuke.gsc
***********************************************/

#using script_608c50392df8c7d1;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\dialog_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\team_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;
#using scripts\mp\objidpoolmanager;
#namespace dna_nuke;

function autoexec main() {
  registerkillstreakinitfunction(getxhash("dna_nuke"), &init);
}

function private init() {
  if(issharedfuncdefined("killstreak", "registerKillstreak")) {
    [[getsharedfunc("killstreak", "registerKillstreak")]]("dna_nuke", &function_63a10439d3742bf);
  }

  if(issharedfuncdefined("dna_nuke", "init")) {
    [[getsharedfunc("dna_nuke", "init")]]();
  }

  level._effect["emp_shockwave"] = loadfx("vfx/iw8_mp/perk/vfx_emp_drone_exp_fieldupgrades.vfx");
  level._effect["predator_pod_break"] = loadfx("vfx/iw8_mp/killstreak/vfx_cruise_predator_explosion.vfx");
  level._effect["dna_nuke"] = loadfx("vfx/jup/killstreak/vfx_ks_dna_nuke_death_01.vfx");
}

function function_63a10439d3742bf(streakinfo) {
  if(!isDefined(streakinfo)) {
    streakinfo = createstreakinfo("dna_nuke", self);
  }

  return function_245ad11ce8c700da(streakinfo);
}

function function_245ad11ce8c700da(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      return false;
    }
  }

  deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(streakinfo, makeweapon("ks_gesture_phone_mp"));

  if(!istrue(deployresult)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      return false;
    }
  }

  if(isPlayer(self)) {
    if(issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
      [[getsharedfunc("sound", "playKillstreakDeployDialog")]](self, streakinfo.streakname);
      var_52a5be2e2f91d710 = 2.5;
    }

    thread playkillstreakoperatordialog(streakinfo.streakname, streakinfo.streakname + "_use", 1, var_52a5be2e2f91d710);
  }

  if(issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    self thread[[getsharedfunc("hud", "teamPlayerCardSplash")]]("used_" + streakinfo.streakname, self);
  }

  result = function_3f5928ab9073266c(streakinfo);
  snd_transient_load("kls_jup_emp");
  return true;
}

function function_3f5928ab9073266c(streakinfo) {
  heightent = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
  heightoffset = 6000;
  horizontaloffset = 8000;
  targetoffset = 5000;
  spawncenterpos = level.mapcenter;
  forwardvector = anglesToForward((0, randomint(360), 0));
  additionaltargetoffset = (0, horizontaloffset, heightoffset);

  switch (randomint(8)) {
    case 1:
      additionaltargetoffset = (horizontaloffset, 0, heightoffset);
      break;
    case 2:
      additionaltargetoffset = (0, horizontaloffset, heightoffset);
      break;
    case 3:
      additionaltargetoffset = (horizontaloffset / 2, horizontaloffset / 2, heightoffset);
      break;
    case 4:
      additionaltargetoffset = (-1 * horizontaloffset, 0, heightoffset);
      break;
    case 5:
      additionaltargetoffset = (0, -1 * horizontaloffset, heightoffset);
      break;
    case 6:
      additionaltargetoffset = (-1 * horizontaloffset / 2, -1 * horizontaloffset / 2, heightoffset);
      break;
    case 7:
      additionaltargetoffset = (-1 * horizontaloffset / 2, horizontaloffset / 2, heightoffset);
      break;
    case 8:
      additionaltargetoffset = (horizontaloffset / 2, -1 * horizontaloffset / 2, heightoffset);
      break;
    default:
      additionaltargetoffset = (0, horizontaloffset, heightoffset);
      break;
  }

  targetpos = spawncenterpos + (0, 0, targetoffset);
  missileoffset = targetpos + additionaltargetoffset;
  startpos = missileoffset - forwardvector * 3000;
  missilepod = spawn("script_model", startpos);
  missilepod setModel("wmd_vm_missile_cruise_mp");
  missilepod.owner = self;
  missilepod.origin = startpos;
  missilepod.angles = vectortoangles(targetpos - startpos);
  missilepod.type = "remote";
  missilepod.team = self.team;
  missilepod.entitynumber = missilepod getentitynumber();
  missilepod.streakinfo = streakinfo;
  missilepod.duration = 30;
  missilepod.animstate = "pod_flying";
  self.restoreangles = self.angles;
  level.rockets[missilepod.entitynumber] = missilepod;
  level.remotemissileinprogress = 1;
  result = function_4fa820930b2857d6(missilepod, targetpos, streakinfo);
  return result;
}

#using_animtree("script_model");

function function_4fa820930b2857d6(pod, breakpos, streakinfo) {
  var_7b7bc27e7e8b05e2 = get_notetrack_time(%mp_cruise_missile_move_intro, "wingtrails");
  var_2cf1418bd3474069 = get_notetrack_time(%mp_cruise_missile_move_intro, "shell_break");
  var_9e0fa77c44b24bf9 = get_notetrack_time(%mp_cruise_missile_move_intro, "second_missile_thruster");
  var_6431d9c900610f5b = get_notetrack_time(%mp_cruise_missile_move_intro, "anim_end");
  stage1delay = var_7b7bc27e7e8b05e2;
  stage2delay = var_2cf1418bd3474069 - var_7b7bc27e7e8b05e2;
  stage3delay = var_9e0fa77c44b24bf9 - var_2cf1418bd3474069;
  stage4delay = var_6431d9c900610f5b - var_9e0fa77c44b24bf9;
  podmoveanim = "mp_cruise_missile_move_intro";
  pod scriptmodelplayanimdeltamotion(podmoveanim);
  pod setscriptablepartstate("main_dna_nuke_thruster", "on", 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(stage1delay);
  pod setscriptablepartstate("wing_trails", "on");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(stage2delay);
  pod.animstate = "pod_break";
  pod setscriptablepartstate("wing_trails", "off");
  pod setscriptablepartstate("main_dna_nuke_thruster", "off", 0);
  playFXOnTag(getfx("predator_pod_break"), pod, "tag_missile");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(stage3delay);
  pod.animstate = "missile_thrusters";
  pod setscriptablepartstate("dna_nuke_sub_thruster", "on", 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(stage4delay - 0.05);
  thread function_861e303c08602058(pod, streakinfo, breakpos);
  return true;
}

function function_861e303c08602058(pod, streakinfo, targetpos) {
  pod endon("death");
  self endon("disconnect");
  level endon("game_ended");
  pod setscriptablepartstate("dna_nuke_sub_thruster", "off", 0);
  missile = spawn("script_model", pod gettagorigin("tag_missile"));
  missile.angles = pod.angles;
  missile setModel("wmd_vm_missile_cruise_warhead_mp");
  missile.team = self.team;
  missile.streakinfo = streakinfo;
  missile.owner = self;
  missile.lifetime = 10;
  missile.weapon_name = "cruise_proj_mp";
  streakinfo.shots_fired++;
  missile setscriptablepartstate("warhead_dna_nuke_thruster", "on", 0);
  missile thread function_ecc8ce9e6c65dae6();
  missile thread function_f292f763187b6ac5();
  missile endon("death");
  fxent = spawn("script_model", missile gettagorigin("tag_fx"));
  fxent setModel("ks_cruise_predator_jup_mp");
  fxent.angles = missile gettagangles("tag_fx");
  fxent.team = missile.team;
  fxent.owner = missile.owner;
  fxent.streakinfo = missile.streakinfo;
  fxent linkTo(missile, "tag_fx");
  fxent setscriptablepartstate("fake_trail_dna_nuke", "on", 0);
  fxent setotherent(self);
  fxent thread function_11126110d38cf99e(missile, streakinfo);
  fxent thread function_7750c53508718dbd(missile);
  fxent thread function_9d55bde0bcef1158(missile);
  missile thread function_9814fc51454dfe88("disconnect");
  missile thread function_9814fc51454dfe88("joined_team");
  missile thread function_9814fc51454dfe88("joined_spectators");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);
  missile thread function_6c9d4dd877455600(self);
  missile thread function_76178b6493ecf6d7(self, targetpos);
  waitframe();

  if(isDefined(pod)) {
    pod delete();
  }
}

function function_ecc8ce9e6c65dae6() {
  if(scripts\engine\utility::issharedfuncdefined("game", "requestObjectiveID")) {
    objid = [[scripts\engine\utility::getsharedfunc("game", "requestObjectiveID")]](99);
    self.var_49be89641b10a107 = objid;
    scripts\mp\objidpoolmanager::objective_add_objective(objid, "active", self.origin, "hud_icon_minimap_killstreak_cruise_missile", "icon_medium");
    scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(objid, 0);

    foreach(player in level.players) {
      if(!isDefined(player) || isbot(player) || player == self) {
        continue;
      }

      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(objid, player);
    }

    scripts\mp\objidpoolmanager::update_objective_onentitywithrotation(objid, self);
    scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);

    if(level.teambased) {
      scripts\mp\objidpoolmanager::update_objective_ownerteam(objid, self.team);
      return;
    }

    scripts\mp\objidpoolmanager::update_objective_ownerclient(objid, self.owner);
  }
}

function function_f292f763187b6ac5() {
  destpoint = self.origin + anglesToForward(self.angles) * 50000;
  missilemovetime = 16.6667;
  self moveTo(destpoint, missilemovetime);
}

function function_76178b6493ecf6d7(rider, targetpos) {
  self endon("death");
  rider endon("disconnect");
  level endon("game_ended");

  while(true) {
    var_1d9b2df64a70f35a = self gettagorigin("tag_missile");
    var_7a7468a3f3fd54b = distancesquared(targetpos, var_1d9b2df64a70f35a);

    if(var_7a7468a3f3fd54b <= 10000) {
      self notify("explode");
      break;
    }

    waitframe();
  }
}

function function_11126110d38cf99e(missile, streakinfo) {
  missile endon("death");
  missile endon("cruise_missile_explode");
  self endon("death");
  self.owner endon("disconnect");
  level waittill_any_2("start_game_ended", "game_ended");
  missile notify("cruise_missile_force_eject");

  if(isDefined(missile)) {
    missile delete();
  }
}

function function_7750c53508718dbd(missile) {
  self endon("death");

  while(true) {
    self.missilelastpos = missile.origin;
    self.missilelastangle = missile.angles;
    waitframe();
  }
}

function function_9d55bde0bcef1158(missile) {
  missile endon("cruise_missile_force_eject");
  explodepos = undefined;
  missileangles = undefined;
  streakinfo = missile.streakinfo;
  explodeinfo = undefined;

  while(true) {
    explodeinfo = missile function_db4cffecf38064e7("collision", "explode", "death", "disowned", "emp_defused", "trophy_blocked");

    if(isDefined(explodeinfo.msg) && explodeinfo.msg == "collision") {
      surface = physics_getsurfacetypefromflags(explodeinfo.param4);
      surfacetype = getsubstr(surface["name"], 9);
      collisiondebug = getdvarint(@ "hash_b1fa07a51b801b6b", 0);

      if(collisiondebug) {
        iprintln("<dev string:x1c>" + surfacetype);
        continue;
      }

      if(surfacetype == "glass_pane") {
        continue;
      }
    }

    break;
  }

  if(isDefined(missile)) {
    missile setscriptablepartstate("warhead_dna_nuke_thruster", "off", 0);
    missile notify("cruise_missile_explode");
    scripts\engine\utility::callsharedfunc("game", "returnObjectiveID", missile.var_49be89641b10a107);
  }

  if(isDefined(self)) {
    self setscriptablepartstate("fake_trail_dna_nuke", "off", 0);
    explodepos = self.missilelastpos;
    missileangles = self.missilelastangle;

    if(isDefined(missile)) {
      missile delete();
    }

    if(!isDefined(explodeinfo) || explodeinfo.msg != "emp_defused" && explodeinfo.msg != "trophy_blocked") {
      explosionradius = 600;
      cruisemeansofdeath = "MOD_EXPLOSIVE";
      cruiseweapon = "cruise_proj_mp";
    }

    if(issharedfuncdefined("shellshock", "artillery_earthQuake")) {
      [[getsharedfunc("shellshock", "artillery_earthQuake")]](explodepos);
    }

    thread function_d09b046309c9310(explodeinfo, missile.owner, streakinfo);
  }
}

function function_db4cffecf38064e7(var_e127af0eab592c1a, var_e127ae0eab5929e7, var_e127ad0eab5927b4, var_e127ac0eab592581, var_e127ab0eab59234e, var_e127aa0eab59211b) {
  ent = spawnStruct();

  if(isDefined(var_e127af0eab592c1a)) {
    thread waittill_explodestring(var_e127af0eab592c1a, ent);
  }

  if(isDefined(var_e127ae0eab5929e7)) {
    thread waittill_explodestring(var_e127ae0eab5929e7, ent);
  }

  if(isDefined(var_e127ad0eab5927b4)) {
    thread waittill_explodestring(var_e127ad0eab5927b4, ent);
  }

  if(isDefined(var_e127ac0eab592581)) {
    thread waittill_explodestring(var_e127ac0eab592581, ent);
  }

  if(isDefined(var_e127ab0eab59234e)) {
    thread waittill_explodestring(var_e127ab0eab59234e, ent);
  }

  if(isDefined(var_e127aa0eab59211b)) {
    thread waittill_explodestring(var_e127aa0eab59211b, ent);
  }

  ent waittill("returned", msg, param1, param2, param3, param4, param5, param6, param7, param8);
  ent notify("die");
  explodeinfo = spawnStruct();
  explodeinfo.msg = msg;
  explodeinfo.param1 = param1;
  explodeinfo.param2 = param2;
  explodeinfo.param3 = param3;
  explodeinfo.param4 = param4;
  explodeinfo.param5 = param5;
  explodeinfo.param6 = param6;
  explodeinfo.param7 = param7;
  explodeinfo.param8 = param8;
  return explodeinfo;
}

function waittill_explodestring(msg, ent) {
  self endon("death");
  ent endon("die");
  self waittill(msg, param1, param2, param3, param4, param5, param6);
  ent notify("returned", msg, param1, param2, param3, param4, param5, param6);
}

function function_d09b046309c9310(explodeinfo, owner, streakinfo) {
  self endon("death");
  self unlink();

  if(!isDefined(explodeinfo) || explodeinfo.msg == "explode" || explodeinfo.msg == "disowned" || explodeinfo.msg == "emp_defused" || explodeinfo.msg == "trophy_blocked") {
    self setscriptablepartstate("dna_nuke_air_explosion", "on", 0);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.2);
    owner function_bdd2da5ebac80af9(streakinfo);
    self delete();
    return;
  }

  worldup = (0, 0, 1);
  surfacenormal = explodeinfo.param6;
  self.angles = vectortoangles(surfacenormal);
  angledirection = vectordot(surfacenormal, worldup);

  if(angledirection >= 0.7) {
    self setscriptablepartstate("emp_ground_explosion", "on", 0);
  } else {
    self setscriptablepartstate("dna_nuke_air_explosion", "on", 0);
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  owner function_bdd2da5ebac80af9(streakinfo);
  self delete();
}

function function_9814fc51454dfe88(action) {
  self endon("death");
  self endon("disowned");
  level endon("game_ended");
  missileowner = self.owner;
  missileowner waittill(action);
  self notify("disowned");
}

function function_43bec35d6ecff18b() {
  self endon("death");
  self endon("cruise_missile_explode");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.75);
  self vehphys_enablecollisioncallback(1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1.25);
}

function function_6c9d4dd877455600(rider) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(500.1);
  self notify("explode", self.origin);
}

function function_bdd2da5ebac80af9(streakinfo) {
  level endon("game_ended");

  if(istrue(level.teambased)) {
    enemyplayers = getenemyplayers(self.team, 1);
  } else {
    enemyplayers = level.players;
    enemyplayers = array_remove(enemyplayers, self);
  }

  spawncenterpos = isDefined(level.mapcenter) ? level.mapcenter : (0, 0, 0);
  nukeinfo = spawnStruct();
  nukeinfo.team = self.pers["team"];
  nukeinfo.streakinfo = streakinfo;
  nukeinfo.weapon = makeweapon("dna_nuke_mp");
  nukeinfo.targetloc = spawncenterpos + (0, 0, 5000);
  nukeinfo.inflictor = spawn("script_model", nukeinfo.targetloc);
  nukeinfo.inflictor setModel("tag_origin");
  nukeinfo.inflictor.team = nukeinfo.team;
  nukeinfo.inflictor.owner = self;
  nukeinfo.inflictor.streakinfo = streakinfo;

  if(isPlayer(self)) {
    nukeinfo.player = self;
  }

  bundle = level.streakglobals.streakbundles["dna_nuke"];

  if(isDefined(enemyplayers)) {
    foreach(enemy in enemyplayers) {
      enemy dodamage(999999, nukeinfo.inflictor.origin, self, nukeinfo.inflictor, "MOD_EXPLOSIVE", nukeinfo.weapon, "none");
    }
  }

  vehiclelist = undefined;

  if(isDefined(level.vehicle) && isDefined(level.vehicle.interact) && isDefined(level.vehicle.interact.vehicles)) {
    vehiclelist = level.vehicle.interact.vehicles;
  }

  if(isDefined(vehiclelist)) {
    foreach(vehicle in vehiclelist) {
      occupants = vehicle_occupancy::vehicle_occupancy_getalloccupants(vehicle);

      foreach(player in occupants) {
        if(isenemy(player)) {
          player.donotmodifydamage = 1;
          player dodamage(999999, nukeinfo.inflictor.origin, self, nukeinfo.inflictor, "MOD_EXPLOSIVE", nukeinfo.weapon, "none");
          player thread function_fa1f6bc26884af64();
        }
      }
    }
  }

  thread function_a1560cbf0f2ff9aa();
  scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(streakinfo);
  level callback::callback("killstreak_finish_use", {
    #streakinfo: streakinfo
  });
}

function function_a1560cbf0f2ff9aa() {
  level endon("game_ended");

  foreach(player in level.players) {
    if(isPlayer(player)) {
      player visionsetnakedforplayer("mp_jup_killstreak_dna", 0);
    }
  }

  wait 0.05;

  foreach(player in level.players) {
    if(isPlayer(player)) {
      player visionsetnakedforplayer("", 15);
    }
  }
}

function function_fa1f6bc26884af64() {
  wait 0.1;

  if(isDefined(self)) {
    self.donotmodifydamage = undefined;
  }
}