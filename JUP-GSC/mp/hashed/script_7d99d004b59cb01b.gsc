/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7d99d004b59cb01b.gsc
*************************************************/

#using script_5099ea00e7cc18f2;
#using script_7b8639f512d4cfe4;
#using scripts\anim\utility;
#using scripts\asm\shared\mp\utility;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle_paths;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\anim_scene;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\airstrike;
#using scripts\cp_mp\samsite;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\anim;
#using scripts\mp\bots\bots_util;
#using scripts\mp\damage;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\obj_bombzone;
#using scripts\mp\gametypes\wm_objectives;
#using scripts\mp\gametypes\wm_utility;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\infilexfil\blima_infil;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#using scripts\mp\vehicles\damage;
#namespace namespace_cd1eecc073e237cd;

function init() {
  level endon("game_ended");

  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  level.scriptevents = [];
  level.scriptevents["zone_1"] = [];
  level.scriptevents["zone_2"] = [];
  level.scriptevents["zone_3"] = [];
  level thread function_a3bfec00164ab171();
  function_33107c3b1ce52835();
  level thread function_52e33bb2006a1adc();
  level thread function_fc90fb29ab43b241();
  level thread function_9c78ba703d9ff9a();
  level thread function_7951c17b5988d67c();
  level thread function_2c5ff68d98ef69e5();
  level thread function_2ee1875b4cc4d668();
  level thread function_30ebb63e4d42678();
  level thread function_3e1d0330ae83c995();
  var_8063e641963cd522 = &namespace_f93036508852df50::function_8063e641963cd522;
  addevent("zone_1", "HeliGroups", var_8063e641963cd522, 15, "heli_group_outside_1");
  addevent("zone_1", "HeliGroups", var_8063e641963cd522, 30, "heli_group_3");
  addevent("zone_1", "HeliGroups", var_8063e641963cd522, 45, "heli_group_8");
  addevent("zone_1", "HeliGroups", var_8063e641963cd522, 45, "heli_group_outside_3");
  addevent("zone_1", "HeliGroups", var_8063e641963cd522, 60, "heli_group_1");
  addevent("zone_1", "CruiseAir", &function_2deb8d093f97cc1b, 60, "right");
  addevent("zone_1", "HeliGroups", var_8063e641963cd522, 75, "heli_group_10");
  addevent("zone_1", "HeliGroups", var_8063e641963cd522, 75, "heli_group_outside_4");
  addevent("zone_1", "HeliGroups", var_8063e641963cd522, 90, "heli_group_4");
  addevent("zone_1", "HeliGroups", var_8063e641963cd522, 105, "heli_group_6");
  addevent("zone_1", "HeliGroups", var_8063e641963cd522, 105, "heli_group_outside_2");
  addevent("zone_1", "CruiseAir", &function_2deb8d093f97cc1b, 120, "outside_right_2");
  addevent("zone_1", "CruiseAir", &function_2deb8d093f97cc1b, 122, "outside_right_2");
  addevent("zone_1", "HeliGroups", var_8063e641963cd522, 130, "heli_group_2");
  addevent("zone_1", "HeliGroups", var_8063e641963cd522, 145, "heli_group_9");
  addevent("zone_1", "HeliGroups", var_8063e641963cd522, 160, "heli_group_5");
  addevent("zone_1", "HeliGroups", var_8063e641963cd522, 162, "heli_group_7");
  addevent("zone_1", "HeliGroups", var_8063e641963cd522, 175, "heli_group_8");
  addevent("zone_1", "CruiseAir", &function_2deb8d093f97cc1b, 180, "left");
  addevent("zone_1", "HeliGroups", var_8063e641963cd522, 190);
  addevent("zone_1", "HeliGroups", var_8063e641963cd522, 205, "heli_group_outside_1");
  addevent("zone_1", "CruiseAir", &function_2deb8d093f97cc1b, 200, "right");
  addevent("zone_1", "HeliGroups", var_8063e641963cd522, 220, "heli_group_3");
  addevent("zone_1", "HeliGroups", var_8063e641963cd522, 235, "heli_group_8");
  addevent("zone_1", "HeliGroups", var_8063e641963cd522, 250, "heli_group_1");
  addevent("zone_1", "HeliGroups", var_8063e641963cd522, 265, "heli_group_5");
  addevent("zone_1", "HeliGroups", var_8063e641963cd522, 280, "heli_group_4");
  addevent("zone_1", "HeliGroups", var_8063e641963cd522, 295, "heli_group_outside_3");
  level thread function_b3f327a076ec28fc();
  level thread function_7458093a3f00753();
  level thread function_81784a440079364d();
  level thread function_8a765b135be66467();
  callback::add("on_ai_killed", &onagentkilled);

  level thread function_fad186e07908db0c();
}

function function_a3bfec00164ab171() {
  silos = getscriptablearray("scriptable_jup_launchfacility_silo_door", "classname");

  foreach(silo in silos) {
    if(isDefined(silo.script_noteworthy) && silo.script_noteworthy == "silo_door_zone_3") {
      lid = spawn("script_model", silo gettagorigin("j_cover_1"));
      lid setModel("jup_ee_military_missile_silo_door_02_well_lid_fxanim");
      lid linkTo(silo, "j_cover_1");
      continue;
    }

    lid = spawn("script_model", silo gettagorigin("j_cover_1"));
    lid setModel("jup_ee_military_missile_silo_door_02_well_lid_fxanim");
    lid.angles += (0, 180, 0);
    lid linkTo(silo, "j_cover_1");
  }
}

function function_2c5ff68d98ef69e5() {
  level endon("game_ended");

  while(!isDefined(level.escortvehicles[0])) {
    waitframe();
  }

  tank = level.escortvehicles[0];
  level thread function_98bf9c6c9952d67d(tank);
  level thread function_5413c7d723606928(tank);
  level thread function_2f1fb04b4b9ee70d(tank);
  level thread function_658c41a1c3cbe6d6(tank);
  level thread function_6e1729cb1fcbd161(tank);
  level childthread function_e85b1519c1f2e485(tank);
}

function function_98bf9c6c9952d67d(tank) {
  level endon("game_ended");

  if(!istrue(function_29227adb79acc568("RPGAgentsEnabled", 1))) {
    return;
  }

  var_8a4ba882c5016a38 = getEntArray("rpg_trigger", "script_noteworthy");
  var_8a4ba882c5016a38 = array_sort_by_script_index(var_8a4ba882c5016a38);

  foreach(var_a14de71a1a68896a in var_8a4ba882c5016a38) {
    var_dd4b1d5d9b4ac2ab = getEnt(var_a14de71a1a68896a.target, "targetname");
    spawnnodes = getStructArray("rpg_agent_spawn_point_" + var_a14de71a1a68896a.script_index, "script_noteworthy");

    if(spawnnodes.size > 0) {
      foreach(spawnnode in spawnnodes) {
        var_b07635d65e3e7cf6 = getStruct(spawnnode.target, "targetname");
        spawnnode.var_b07635d65e3e7cf6 = var_b07635d65e3e7cf6;
      }
    } else {
      assertmsg("<dev string:x1c>" + var_a14de71a1a68896a.origin + "<dev string:x36>");
    }

    var_a14de71a1a68896a.var_dd4b1d5d9b4ac2ab = var_dd4b1d5d9b4ac2ab;
    var_a14de71a1a68896a.spawnnodes = spawnnodes;
  }

  var_54784d468c8dd24c = "jup_enemy_mp_rpg_tier1_pmc";
  team = game["defenders"];
  scripts\mp\ai_mp_controller::function_2fc80954fa70d153();
  level.var_1351748ae88ad02a = [];

  for(i = 0; i < var_8a4ba882c5016a38.size; i++) {
    while(!ispointinvolume(tank.origin, var_8a4ba882c5016a38[i])) {
      waitframe();
    }

    for(j = 0; j < var_8a4ba882c5016a38[i].spawnnodes.size; j++) {
      var_a25049f295c6098b = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent(var_54784d468c8dd24c, getclosestpointonnavmesh(var_8a4ba882c5016a38[i].spawnnodes[j].origin), var_8a4ba882c5016a38[i].spawnnodes[j].angles, "absolute", "show", "rpg", undefined, team, undefined, undefined, 1, undefined, 0, undefined);
      var_a25049f295c6098b thread function_bd80506147960d00();
      level.var_1351748ae88ad02a[level.var_1351748ae88ad02a.size] = var_a25049f295c6098b;
      var_a25049f295c6098b scripts\cp_mp\agents\agent_utils::agentpers_setagentpersdata(var_a25049f295c6098b, "team", team);
      var_a25049f295c6098b scripts\cp_mp\agents\agent_utils::function_c37c4f9d687074ff(undefined, undefined, undefined, undefined, undefined, 0, 0);
      var_a25049f295c6098b thread function_497ace892c40a30f(tank, var_8a4ba882c5016a38[i].var_dd4b1d5d9b4ac2ab, var_8a4ba882c5016a38[i].spawnnodes[j]);
    }
  }
}

function function_497ace892c40a30f(tank, var_c7207a5b46d13fba, spawnnode) {
  level endon("game_ended");
  self endon("death");
  self.var_b582b10663b5b2a9 = 0;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self clearbtgoal(4);
  self setbtgoalstationary(4);

  while(!ispointinvolume(tank.origin, var_c7207a5b46d13fba)) {
    waitframe();
  }

  wait randomintrange(1, 10) / 10;
  self clearbtgoal(4);
  self setbtgoalpos(4, getclosestpointonnavmesh(spawnnode.var_b07635d65e3e7cf6.origin));
  agentlookatent(tank);
  wait 5.5;
  var_ed39cb3233b3be2b = getdvarint(@ "hash_3ad1abefe85e5981", 6);
  var_4edfeb1c4b8b41e0 = getdvarint(@ "hash_4abcbe6f71efb1d2", 2);

  for(j = 0; j < var_4edfeb1c4b8b41e0; j++) {
    self shoot(10, tank);
    self asmsetstate(self.asmname, "exposed_reload");

    if(j != var_4edfeb1c4b8b41e0 - 1) {
      wait var_ed39cb3233b3be2b;
    }
  }

  self.bulletsinclip = 0;
  wait 2;
  self clearentitytarget();
  self clearbtgoal(4);
  self setbtgoalpos(4, getclosestpointonnavmesh(spawnnode.origin));
}

function agentlookatent(ent) {
  level endon("game_ended");
  self endon("death");
  self notify("agentLookAtEnt");
  self endon("agentLookAtEnt");

  if(!isDefined(ent)) {
    return;
  }

  self setentitytarget(ent);
  self forcethreatupdate();
  self.aiment = ent;

  while(true) {
    self.script_aimpos = self.aiment.origin;
    self.lastenemysightpos = self.aiment.origin;
    self.shootposoverride = self.aiment.origin;

    if(scripts\asm\shared\mp\utility::isweaponfacingenemy()) {
      return;
    }

    waitframe();
  }
}

function private onagentkilled(params) {
  if(self.subcategory == "rpg" || istrue(self.var_6384ebeaed4efe3e)) {
    var_8fa1351877b04c45 = 1;

    if(isDefined(self.var_8e0105c1b5cd5605)) {
      var_d795e211786915f0 = vectorNormalize(anglesToForward(self.angles + (0, randomintrange(-30, 30), 0)));
      var_d795e211786915f0 = (var_d795e211786915f0[0], var_d795e211786915f0[1], var_8fa1351877b04c45) * 6000;
    } else if(isPlayer(params.eattacker)) {
      var_d795e211786915f0 = vectorNormalize((params.vdir[0], params.vdir[1], 0)) * 1000;
      var_d795e211786915f0 = (-1 * var_d795e211786915f0[0], -1 * var_d795e211786915f0[1], var_8fa1351877b04c45);
    }

    if(isDefined(var_d795e211786915f0)) {
      self.ragdollhitloc = "head";
      self.e_corpse = self getcorpseentity();
      self.e_corpse startragdollfromimpact(self.ragdollhitloc, var_d795e211786915f0);
    }
  }
}

function function_2deb8d093f97cc1b() {
  level endon("game_ended");
  planemodel = "veh8_mil_air_alfa10";
  var_e4d26f59db05025a = "ks_airstrike_mp";
  function_5c626f8797206578();
  animname = level.scr_anim["precision_airstrike"]["airstrike_flyby"];
  strikeanimlength = getanimlength(animname);
  var_7b00721e9d1ef2a0 = get_notetrack_time(animname, "attack");
  planestartpos = getStruct("a10_spawn_" + self.context, "script_noteworthy").origin;
  var_6d29e82378e59e76 = getStruct("a10_start_" + self.context, "script_noteworthy").origin;
  var_98255165b50d8173 = getStruct("a10_end_" + self.context, "script_noteworthy").origin;
  var_7789cda8c1e3128e = vectortoangles(var_98255165b50d8173 - var_6d29e82378e59e76);
  planeflyheight = 2843.5;
  plane = spawn("script_model", planestartpos);
  plane setModel(planemodel);
  plane.angles = var_7789cda8c1e3128e;
  plane.flightdir = anglesToForward(var_7789cda8c1e3128e);
  plane.flightheight = planeflyheight;
  plane.team = game["attackers"];
  plane scriptmoveroutline();
  plane scriptmoverthermal();
  plane scriptmoverplane();
  planeicon = "hud_icon_minimap_killstreak_airstrike";

  if(scripts\engine\utility::issharedfuncdefined("game", "createObjective")) {
    plane.minimapid = plane[[scripts\engine\utility::getsharedfunc("game", "createObjective")]](planeicon, plane.team, undefined, 1, 1);
  }

  var_fafbda0eba9c0aab = var_7b00721e9d1ef2a0 - 0.75;
  var_3a20f9101e50025f = 0.05;
  var_3a020e101e2ddead = var_fafbda0eba9c0aab;
  var_7c39d972e849c204 = 8.596;
  plane thread airstrike_delayplayscriptable(0.05);
  level thread airstrike_playplaneattackfx(plane, var_fafbda0eba9c0aab);
  level thread function_aaa0134cf5ca2e67(self.context);
  level airstrike_playflyfx(plane, var_e4d26f59db05025a, var_6d29e82378e59e76, anglesToForward(var_7789cda8c1e3128e), var_3a20f9101e50025f, var_3a020e101e2ddead, var_7c39d972e849c204, strikeanimlength);
  plane.bulletpoint = spawn("script_model", plane.origin);
  plane.bulletpoint setModel("ks_airstrike_target_mp");
  plane.bulletpoint.weapon_name = "artillery_mp";
  plane.bulletpoint.angles = plane.angles;
  plane.bulletpoint dontinterpolate();
  plane.bulletpoint.streakinfo = spawnStruct();
  plane.bulletpoint.streakinfo.shots_fired = 0;
  plane.animname = "precision_airstrike";
  plane scripts\common\anim::setanimtree();
  plane.scenenode = spawn("script_model", planestartpos);
  plane.scenenode.angles = plane.angles;
  plane.scenenode setModel("tag_origin");
  targetsite = getStruct("a10_target_" + self.context, "script_noteworthy").origin;
  streakinfo = spawnStruct();
  streakinfo.streakname = "precision_airstrike";
  [owner] = scripts\mp\utility\teams::getteamdata(game["attackers"], "alivePlayers");
  level thread scripts\cp_mp\killstreaks\airstrike::callstrike_precisionbulleteffect(plane, var_fafbda0eba9c0aab, strikeanimlength, targetsite, owner, streakinfo);
  plane.scenenode scripts\common\anim::anim_single_solo(plane, "airstrike_flyby");

  if(isDefined(plane.minimapid)) {
    if(scripts\engine\utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\engine\utility::getsharedfunc("game", "returnObjectiveID")]](plane.minimapid);
    }
  }

  plane notify("delete");

  if(isDefined(plane.turrettarget)) {
    plane.turrettarget delete();
  }

  if(isDefined(plane.bulletpoint)) {
    plane.bulletpoint delete();

    if(isDefined(plane.bulletpoint.killcament)) {
      plane.bulletpoint.killcament delete();
    }
  }

  if(isDefined(plane.scenenode)) {
    plane.scenenode delete();
  }

  if(isDefined(plane)) {
    plane delete();
  }
}

#using_animtree("script_model");

function function_5c626f8797206578() {
  level.scr_animtree["precision_airstrike"] = #animtree;
  level.scr_anim["precision_airstrike"]["airstrike_flyby"] = % mp_alfa10_flyin;
  level.scr_animname["precision_airstrike"]["airstrike_flyby"] = "mp_alfa10_flyin";
}

function airstrike_delayplayscriptable(delaytime) {
  self endon("death");
  level endon("game_ended");
  wait delaytime;
  self setscriptablepartstate("bodyfx", "on", 0);
}

function airstrike_playplaneattackfx(plane, var_fafbda0eba9c0aab) {
  plane endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_fafbda0eba9c0aab);
  playsoundatpos(plane.origin, "ks_a10_fire_dist_crack");
  plane setscriptablepartstate("fire", "on", 0);
  plane waittill("fire_finished");
  plane setscriptablepartstate("fire", "off", 0);
}

function airstrike_playflyfx(plane, var_e4d26f59db05025a, planestartpos, var_7789cda8c1e3128e, var_3a20f9101e50025f, var_3a020e101e2ddead, var_7c39d972e849c204, var_a9b4b258c1167b50) {
  flyoutfx = spawn("script_model", planestartpos);
  flyoutfx setModel(var_e4d26f59db05025a);
  flyoutfx dontinterpolate();
  flyoutfx thread airstrike_playapproachfx(var_3a20f9101e50025f);
  flyoutfx thread airstrike_playflybyfx(var_3a020e101e2ddead);
  flyoutfx thread airstrike_playflyoutfx(var_7c39d972e849c204);
  flyoutfx thread airstrike_handleflyoutfxdeath(var_a9b4b258c1167b50);
  flyoutfx thread airstrike_movewithplane(plane);
  return flyoutfx;
}

function airstrike_playapproachfx(var_777fc9701bbd592b) {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_777fc9701bbd592b);
  self setscriptablepartstate("approach", "on", 0);
}

function airstrike_playflybyfx(var_3a020e101e2ddead) {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_3a020e101e2ddead);
  self setscriptablepartstate("flyby", "on", 0);
}

function airstrike_playflyoutfx(var_7c39d972e849c204) {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_7c39d972e849c204);
  self setscriptablepartstate("flyout", "on", 0);
}

function airstrike_handleflyoutfxdeath(var_b5d8ace604fc4b78) {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_b5d8ace604fc4b78 + 10);
  self delete();
}

function airstrike_movewithplane(plane) {
  self endon("death");
  level endon("game_ended");

  while(isDefined(plane)) {
    self.origin = plane.origin;
    wait 0.05;
  }
}

function function_6e1729cb1fcbd161(tank) {
  level endon("game_ended");
  var_35b6eeafcaa733c2 = getEnt("trigger_base_entrance", "script_noteworthy");
  var_38bab612a830782b = getEnt("entrance_left", "script_noteworthy");
  var_4986180a58503d9d = getEnt("entrance_damaged", "script_noteworthy");
  var_38bab612a830782b.aiclip = getEnt(var_38bab612a830782b.target, "targetname");
  var_4986180a58503d9d.aiclip = getEnt(var_4986180a58503d9d.target, "targetname");
  var_7ce13bc274d1e04e = getscriptablearray("entrance_fx", "script_noteworthy");
  var_7ce13bc274d1e04e[0] setscriptablepartstate("body", "init");

  if(!isDefined(var_35b6eeafcaa733c2) || !isDefined(var_38bab612a830782b) || !isDefined(var_4986180a58503d9d)) {
    assertmsg("<dev string:x67>");
    return;
  }

  var_38bab612a830782b.animname = "crash_door";
  var_38bab612a830782b scripts\common\anim::setanimtree();
  var_38bab612a830782b thread scripts\common\anim::anim_single_solo(var_38bab612a830782b, "door_le_close");
  var_4986180a58503d9d.animname = "crash_door";
  var_4986180a58503d9d scripts\common\anim::setanimtree();
  var_4986180a58503d9d thread scripts\common\anim::anim_single_solo(var_4986180a58503d9d, "door_dg_close");
  var_38bab612a830782b notsolid();
  var_4487c85fde37f681 = spawn("script_model", var_38bab612a830782b.origin);
  var_4487c85fde37f681 setModel("military_blockade_gate_static");
  var_4487c85fde37f681 notsolid();
  var_4487c85fde37f681.origin -= (0, 0, 200);
  var_38bab612a830782b solid();
  var_38bab612a830782b disconnectPaths();
  var_38bab612a830782b.static = var_4487c85fde37f681;
  var_4986180a58503d9d notsolid();
  var_c360e18344677063 = spawn("script_model", var_4986180a58503d9d.origin);
  var_c360e18344677063 setModel("military_blockade_gate_damaged_static");
  var_c360e18344677063 notsolid();
  var_c360e18344677063.origin -= (0, 0, 200);
  var_4986180a58503d9d solid();
  var_4986180a58503d9d disconnectPaths();
  var_4986180a58503d9d.static = var_c360e18344677063;

  while(!ispointinvolume(tank.origin, var_35b6eeafcaa733c2)) {
    waitframe();
  }

  tank.overridespeed = 4.5;

  while(tank.overridespeed < 15) {
    tank.overridespeed += 1.05;
    wait 0.1;
  }

  wait 0.2;
  var_7ce13bc274d1e04e[0] setscriptablepartstate("body", "collide");
  level thread function_dde36fdcd90851a6(var_38bab612a830782b, var_4986180a58503d9d);
  level thread function_375209ffdcc0e7c8(tank);
  wait 1;

  while(tank.overridespeed > 4.5) {
    tank.overridespeed -= 1.5;
    wait 0.2;
  }

  tank.overridespeed = undefined;
}

function function_375209ffdcc0e7c8(tank) {
  level endon("game_ended");
  var_21a3d82c2857e024 = getStruct("base_alarm", "script_noteworthy");
  var_3988214326277350 = getEnt("trigger_missile_launch", "script_noteworthy");

  if(isDefined(var_21a3d82c2857e024)) {
    var_21a3d82c2857e024 thread function_a8bd8eebc720aa13();
  }

  if(isDefined(var_3988214326277350) && isDefined(var_21a3d82c2857e024)) {
    while(!ispointinvolume(tank.origin, var_3988214326277350)) {
      waitframe();
    }

    level thread function_f49914c65896f7ed("zone_2", 0.3, 10, 6400, var_21a3d82c2857e024.origin);
  } else {
    assertmsg("<dev string:xc8>");
  }

  var_f41f0643e5780168 = getEnt("trigger_silo_door_open", "script_noteworthy");

  if(isDefined(var_f41f0643e5780168)) {
    while(!ispointinvolume(tank.origin, var_f41f0643e5780168)) {
      waitframe();
    }
  } else {
    assertmsg("<dev string:x10f>");
  }

  var_d3c3ee3b2c62604f = getscriptablearray("silo_door_zone_3", "script_noteworthy");
  var_59120b7e15335c42 = array_reverse(sortbydistance(var_d3c3ee3b2c62604f, tank.origin));

  foreach(entrance in var_59120b7e15335c42) {
    entrance setscriptablepartstate("body", "open");
    entrance delaycall(20, &setscriptablepartstate, "body", "static");
  }

  tank.overridespeed = 4.5;
}

function function_e85b1519c1f2e485(tank) {
  while(true) {
    level waittill("exit_vehicle", vehicle, player);

    if(tank == vehicle && !isalive(player) && player.sessionstate != "spectator") {
      newpos = player.origin + (0, 0, 50);
      player setOrigin(newpos);
      old = getDvar(@ "hash_de4b3f11f23b95c2");
      setDvar(@ "hash_de4b3f11f23b95c2", 0);
      wait 1;
      setDvar(@ "hash_de4b3f11f23b95c2", old);
    }
  }
}

function function_dde36fdcd90851a6(var_38bab612a830782b, var_4986180a58503d9d) {
  var_38bab612a830782b connectpaths();
  var_4986180a58503d9d connectpaths();
  var_38bab612a830782b thread scripts\common\anim::anim_single_solo(var_38bab612a830782b, "door_le_open");
  var_4986180a58503d9d thread scripts\common\anim::anim_single_solo(var_4986180a58503d9d, "door_dg_open");
  wait 5.5;

  if(isDefined(var_38bab612a830782b.aiclip) && isDefined(var_4986180a58503d9d.aiclip)) {
    var_38bab612a830782b.aiclip connectpaths();
    var_4986180a58503d9d.aiclip connectpaths();
    var_38bab612a830782b.aiclip delete();
    var_4986180a58503d9d.aiclip delete();
  }

  var_38bab612a830782b notsolid();
  var_38bab612a830782b.static dontinterpolate();
  var_38bab612a830782b.static.origin = var_38bab612a830782b.origin;
  var_38bab612a830782b.static.angles = var_38bab612a830782b.angles;
  var_38bab612a830782b.static solid();
  var_38bab612a830782b.static disconnectPaths();
  var_4986180a58503d9d notsolid();
  var_4986180a58503d9d.static dontinterpolate();
  var_4986180a58503d9d.static.origin = var_4986180a58503d9d.origin;
  var_4986180a58503d9d.static.angles = var_4986180a58503d9d.angles;
  var_4986180a58503d9d.static solid();
  var_4986180a58503d9d.static disconnectPaths();
  var_38bab612a830782b dontinterpolate();
  var_38bab612a830782b.origin -= (0, 0, 200);
  var_4986180a58503d9d dontinterpolate();
  var_4986180a58503d9d.origin -= (0, 0, 200);
}

function function_c469c23071d98b04() {
  function_f49914c65896f7ed(self.context);
}

function function_f49914c65896f7ed(context, scale, duration, radius, var_9ac90fc02f01d464) {
  level endon("game_ended");
  logstring("silo_door_" + context);
  [var_853bcd6b23aeeced] = getscriptablearray("silo_door_" + context, "script_noteworthy");
  var_853bcd6b23aeeced setscriptablepartstate("body", "open");
  var_853bcd6b23aeeced setscriptablepartstate("vfx", "smoking");
  var_853bcd6b23aeeced delaycall(20, &setscriptablepartstate, "body", "static");
  var_1f7efcdc66263db3 = getStruct("missile_" + context, "script_noteworthy");
  missile = spawn("script_model", var_1f7efcdc66263db3.origin);
  missile setModel("jup_military_launchfacility_missile_01_fxanim");
  missile.angles = var_1f7efcdc66263db3.angles;
  missile.animname = "missile";
  missile scripts\common\anim::setanimtree();
  animname = level.scr_anim["missile"]["launch"];
  animlength = 0;
  var_5804037427b7bfb7 = 8;

  if(context == "zone_1") {
    missile thread scripts\common\anim::anim_single_solo(missile, "launch02");
    animname = level.scr_anim["missile"]["launch02"];
    animlength = getanimlength(animname);
    var_5804037427b7bfb7 = 1;
  } else {
    missile thread scripts\common\anim::anim_single_solo(missile, "launch");
    animlength = getanimlength(animname);
  }

  missile thread function_a3a5173c39cc676(var_5804037427b7bfb7, animlength);
  wait var_5804037427b7bfb7;
  useradius = default_to(radius, 30000);
  origin = default_to(var_9ac90fc02f01d464, missile.origin);
  playrumbleonposition("grenade_rumble", origin);
  earthquake(scale, duration, origin, useradius);
  level notify(context + "_missile_launched");
  wait animlength - var_5804037427b7bfb7;
  missile delete();
}

function function_a8bd8eebc720aa13() {
  level endon("game_ended");
  soundent = play_loopsound_in_space("jup_icbm_siren_lp", self.origin);
  wait 20;
  soundent stop_loop_sound_on_entity("jup_icbm_siren_lp");
  soundent delete();
}

function function_52e33bb2006a1adc() {
  level endon("game_ended");
  sam_struct = getStruct("sam_spawn_point", "script_noteworthy");
  turret = function_fefa23bed4e70fb2(sam_struct, "military_samsite_01_launchfacility");
  function_f7c5fc38fdc4df8c(turret, "military_missile_rig_skeleton_02");
  struct = getStruct("mp_jup_launch_facility_heli_spawn", "targetname");
  goal = getStruct(struct.target, "targetname");
  var_c1392b0434c69167 = getStruct("samsite_default_tareget", "targetname");
  defaulttarget = spawn("script_model", var_c1392b0434c69167.origin);
  turret.target_entity = defaulttarget;
  turret settargetentity(turret.target_entity);
  turret thread scripts\mp\gametypes\wm_objectives::function_3683331ec49168ba();
  flag_wait("scriptables_ready");
  turret.missile1 setCanDamage(0);
  turret.missile2 setCanDamage(0);
  turret.missile3 setCanDamage(0);
  turret setscriptablepartstate("usable_left", "unusable", 1);
  turret setscriptablepartstate("usable_left_defuse", "unusable", 1);
  turret setscriptablepartstate("usable_front", "unusable", 1);
  turret setscriptablepartstate("usable_front_defuse", "unusable", 1);
  turret setscriptablepartstate("usable_right", "unusable", 1);
  turret setscriptablepartstate("usable_right_defuse", "unusable", 1);

  if(!isDefined(level.zones["zone_1"].capture_zones)) {
    return;
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  missilecount = 3;
  missileindex = 1;
  var_e3b21a2cb7fb297 = 60;
  turret.team = "neutral";

  if(getdvarint(@ "hash_902adb2aa0926318", 0) == 1) {
    var_e3b21a2cb7fb297 = 15;
  }

  var_eb407f7b45bbd5ad = 1;
  var_b347c9c771e0363b = 2;
  var_dbfa63f38e0d7dc9 = [var_eb407f7b45bbd5ad, var_b347c9c771e0363b];
  var_dbfa63f38e0d7dc9 = array_randomize(var_dbfa63f38e0d7dc9);

  if(getdvarint(@ "hash_902adb2aa0926318", 0) == 1) {
    var_dbfa63f38e0d7dc9 = [var_eb407f7b45bbd5ad];
  }

  while(missilecount > 1) {
    wait var_e3b21a2cb7fb297;

    if(!flag("zone1_enableSamsite")) {
      return;
    }

    if(var_dbfa63f38e0d7dc9[missileindex - 1] == var_eb407f7b45bbd5ad) {
      turret function_8141c7ee58e8ad59(defaulttarget);
    } else if(var_dbfa63f38e0d7dc9[missileindex - 1] == var_b347c9c771e0363b) {
      turret function_4f603cae8184144f(defaulttarget);
    }

    damageorigin = (0, 0, 0);

    if(missileindex > 1) {
      damageorigin = turret gettagorigin("tag_fx_0" + missileindex);
    } else {
      damageorigin = turret gettagorigin("tag_fx");
    }

    turret radiusdamage(damageorigin, 128, 75, 30, turret);
    missilecount--;
    missileindex++;

    if(getdvarint(@ "hash_902adb2aa0926318", 0) == 1) {
      var_12b83fd2a7916e14 = randomfloatrange(0, 1);
      var_12b82cd2a791444b = randomfloatrange(0, 1);
      sphere(damageorigin, 128, (var_12b83fd2a7916e14, var_12b82cd2a791444b, 0), 0, 60);

      if(missilecount <= 1) {
        function_f7c5fc38fdc4df8c(turret);
        missilecount = 3;
        missileindex = 1;
      }

      if(var_dbfa63f38e0d7dc9.size == 1) {
        function_f7c5fc38fdc4df8c(turret);
        missilecount = 3;
        missileindex = 1;
      }
    }

  }
}

function function_8141c7ee58e8ad59(var_bb5fa24f4a5c3b42) {
  level endon("game_ended");
  self endon("death");
  var_81d84bb5b65f498e = function_92193bb27fce01fd();
  var_81d84bb5b65f498e.var_7d1a90814c8500ff = var_81d84bb5b65f498e scripts\mp\infilexfil\blima_infil::spawn_anim_model("rope_l", "origin_animate_jnt", "equipment_fast_rope_wm_01_infil_heli_l");
  var_81d84bb5b65f498e.roper = var_81d84bb5b65f498e scripts\mp\infilexfil\blima_infil::spawn_anim_model("rope_r", "origin_animate_jnt", "equipment_fast_rope_wm_01_infil_heli_l");
  var_81d84bb5b65f498e waittill("reached_dynamic_path_end");
  var_81d84bb5b65f498e.actors = [];
  var_81d84bb5b65f498e.actors[var_81d84bb5b65f498e.actors.size] = var_81d84bb5b65f498e scripts\mp\infilexfil\blima_infil::spawn_anim_model("crew1", "body_animate_jnt", "fullbody_sp_ally_helicopter_crew_chief");
  var_81d84bb5b65f498e.actors[var_81d84bb5b65f498e.actors.size] = var_81d84bb5b65f498e scripts\mp\infilexfil\blima_infil::spawn_anim_model("crew2", "body_animate_jnt", "fullbody_sp_ally_helicopter_crew_chief");
  var_81d84bb5b65f498e thread anim_single_solo(var_81d84bb5b65f498e, "reinforce_open_gate");
  wait 1.6;
  var_81d84bb5b65f498e thread anim_single(var_81d84bb5b65f498e.actors, "blima_infil", "body_animate_jnt");
  var_81d84bb5b65f498e.var_7d1a90814c8500ff anim_first_frame_solo(var_81d84bb5b65f498e.var_7d1a90814c8500ff, "blima_infil");
  var_81d84bb5b65f498e.roper anim_first_frame_solo(var_81d84bb5b65f498e.roper, "blima_infil");
  var_81d84bb5b65f498e thread anim_single_solo(var_81d84bb5b65f498e.var_7d1a90814c8500ff, "blima_infil", "origin_animate_jnt");
  var_81d84bb5b65f498e thread anim_single_solo(var_81d84bb5b65f498e.roper, "blima_infil", "origin_animate_jnt");
  var_81d84bb5b65f498e.var_4df0c0e7ce492d0c = var_81d84bb5b65f498e scripts\mp\infilexfil\blima_infil::spawn_anim_model("slot_0", "body_animate_jnt", "fullbody_sp_ally_helicopter_crew_chief");
  var_81d84bb5b65f498e thread anim_single_solo(var_81d84bb5b65f498e.var_4df0c0e7ce492d0c, "blima_infil", "body_animate_jnt");
  var_81d84bb5b65f498e.seat1 = var_81d84bb5b65f498e scripts\mp\infilexfil\blima_infil::spawn_anim_model("slot_1", "body_animate_jnt", "fullbody_sp_ally_helicopter_crew_chief");
  var_81d84bb5b65f498e thread anim_single_solo(var_81d84bb5b65f498e.seat1, "blima_infil", "body_animate_jnt");
  self.target_entity = var_81d84bb5b65f498e;
  self settargetentity(self.target_entity, (0, 0, -30));
  thread scripts\cp_mp\samsite::function_2add68d4c86e555b();
  thread function_daeb63bc80d43e0b();
  scripts\cp_mp\samsite::function_71cf043af949590c();

  if(flag("zone1_enableSamsite")) {
    thread function_44e4433ebac52609();
  } else {
    if(isDefined(var_81d84bb5b65f498e)) {
      var_9ac90fc02f01d464 = var_81d84bb5b65f498e.origin;
      var_81d84bb5b65f498e scripts\cp_mp\vehicles\vehicle_damage::function_d0df49de517ded03();
      var_81d84bb5b65f498e scripts\cp_mp\vehicles\vehicle::vehicle_explode();
      playrumbleonposition("grenade_rumble", var_9ac90fc02f01d464);
      earthquake(0.3, 1, var_9ac90fc02f01d464, 30000);
    }

    self.target_entity = var_bb5fa24f4a5c3b42;
    self settargetentity(self.target_entity);
    return;
  }

  function_70b538f30430b274();

  if(isDefined(var_81d84bb5b65f498e)) {
    var_9ac90fc02f01d464 = var_81d84bb5b65f498e.origin;
    var_81d84bb5b65f498e scripts\cp_mp\vehicles\vehicle_damage::function_d0df49de517ded03();
    var_81d84bb5b65f498e scripts\cp_mp\vehicles\vehicle::vehicle_explode();
    playrumbleonposition("grenade_rumble", var_9ac90fc02f01d464);
    earthquake(0.3, 1, var_9ac90fc02f01d464, 30000);
  }

  wait 1.5;
  self.target_entity = var_bb5fa24f4a5c3b42;
  self settargetentity(self.target_entity);
}

function function_4f603cae8184144f(var_bb5fa24f4a5c3b42) {
  level endon("game_ended");
  self endon("death");
  var_f0c137dba73fc2eb = spawnStruct();
  var_f0c137dba73fc2eb.context = "heli_group_samsite_show";
  var_f0c137dba73fc2eb.dontremove = 1;
  var_f0c137dba73fc2eb thread namespace_f93036508852df50::function_8063e641963cd522();
  ahotel64 = level.heligroups["heli_group_samsite_show"][0];
  ahotel64 waittill("reached_dynamic_path_end");
  ahotel64 thread function_8297ebf5f7c0e769();
  function_b8ac169f667da4a7(ahotel64);

  if(flag("zone1_enableSamsite")) {
    thread function_44e4433ebac52609();
  } else {
    if(isDefined(ahotel64)) {
      ahotel64 namespace_f93036508852df50::function_8d81149252d80ceb(0);
      var_9ac90fc02f01d464 = ahotel64.origin;
      playrumbleonposition("grenade_rumble", var_9ac90fc02f01d464);
      earthquake(0.3, 1, var_9ac90fc02f01d464, 30000);
    }

    self.target_entity = var_bb5fa24f4a5c3b42;
    self settargetentity(self.target_entity);
    return;
  }

  function_70b538f30430b274();

  if(isDefined(ahotel64)) {
    var_9ac90fc02f01d464 = ahotel64.origin;
    ahotel64 thread namespace_f93036508852df50::function_11f0ee09b3a8c382();
    playrumbleonposition("grenade_rumble", var_9ac90fc02f01d464);
    earthquake(0.3, 1, var_9ac90fc02f01d464, 30000);
    level.heligroups["heli_group_samsite_show"] = undefined;
  }

  wait 1.5;
  self.target_entity = var_bb5fa24f4a5c3b42;
  self settargetentity(self.target_entity);
}

function function_70b538f30430b274() {
  rangesq = 10000;
  missile = self.var_da525e753988f579;
  target = self.target_entity;

  while(isDefined(missile) && isDefined(target)) {
    dst = distancesquared(missile.origin, target.origin);

    if(dst < rangesq) {
      break;
    }

    waitframe();
  }

  if(isDefined(missile)) {
    missile hide();
  }
}

function function_92193bb27fce01fd() {
  struct = getStruct("mp_jup_launch_facility_heli_spawn", "targetname");
  spawndata = spawnStruct();
  spawndata.origin = struct.origin;
  spawndata.angles = struct.angles;
  goal = getStruct(struct.target, "targetname");
  endstruct = spawnStruct();
  endstruct.origin = goal.origin;
  endstruct.angles = goal.angles;
  vehicle = vehicle_spawn("veh9_blima", spawndata);
  vehicle setscriptablepartstate("running_lights", "on");
  vehicle.animname = "blima";
  vehicle.team = game["attackers"];
  vehicle setvehicleteam(vehicle.team);
  vehicle vehicleshowonminimap(0);
  vehicle.var_918c5a31037e00ee = spawnStruct();
  vehicle.var_918c5a31037e00ee.speed = 85;
  vehicle setanimrate(scripts\engine\utility::getanim_from_animname("blima_infil_alpha", "blima"), 0);
  vehicle scripts\common\anim::anim_first_frame_solo(vehicle, "blima_infil_alpha");
  vehicle thread scripts\common\vehicle_paths::vehicle_paths_helicopter(endstruct);
  return vehicle;
}

function function_b8ac169f667da4a7(var_d2d0b4ab45a004b3) {
  self.target_entity = var_d2d0b4ab45a004b3;
  self settargetentity(self.target_entity, (0, 0, -30));
  thread scripts\cp_mp\samsite::function_2add68d4c86e555b();
  thread function_daeb63bc80d43e0b();
  idle_points = function_37cc51487b6e95dc(self.origin + (0, 0, 800), 12, 512);
  startingpoint = getclosest(self.target_entity.origin, idle_points);
  var_741f5a182dd662c0 = 0;
  thread function_2add68d4c86e555b();
  count = 0;

  foreach(point in idle_points) {
    if(startingpoint != point && !var_741f5a182dd662c0) {
      continue;
    }

    self.target_entity moveTo(point.origin, 1.5);
    wait 0.5;
    count++;

    if(count > 2) {
      break;
    }
  }

  self notify("launching");
}

function function_8297ebf5f7c0e769() {
  self endon("death");
  var_f02a7578af6a43e1 = 0.125;
  var_3180e2519441f60a = 40;
  shots = 0;
  turret = self.turret;
  targetent = turret.targetent;

  while(shots < var_3180e2519441f60a) {
    targetent.origin = turret.origin + anglesToForward(turret.angles) * 100 + (0, 0, -100);

    if(turret turretcantarget(targetent.origin)) {
      turret snaptotargetentity(targetent);
    }

    turret shootturret();
    shots++;
    wait var_f02a7578af6a43e1;
  }
}

function function_fc90fb29ab43b241() {
  level endon("game_ended");
  var_74384acd3881d1dd = getStruct("zone_1_radar_antenna", "script_noteworthy");
  satellite = getEnt("zone_1_radar_satellite", "script_noteworthy");

  if(!isDefined(var_74384acd3881d1dd) || !isDefined(satellite)) {
    assertmsg("<dev string:x150>");
    return;
  }

  tagorigin = satellite gettagorigin("tag_radar_antenna");
  antenna = spawn_model("military_mobile_radar_satellite_antenna_fxanim", tagorigin, var_74384acd3881d1dd.angles);
  var_104068cf7b6ef7e0 = spawn("script_model", antenna.origin + (0, 0, 50));
  scripts\mp\flags::gameflagwait("prematch_done");
  var_104068cf7b6ef7e0 playLoopSound("jup_radar_rotate_lp");
  rotatetime = 1;

  while(level.zone.name == "zone_1") {
    if(istrue(level.objectives["_a"].complete)) {
      break;
    }

    for(index = 0; index < 12; index++) {
      if(istrue(level.objectives["_a"].complete)) {
        break;
      }

      antenna rotateYaw(-30, rotatetime);

      if(index % 2 == 0) {
        playsoundatpos(antenna.origin + (0, 0, 50), "jup_radar_rotate_ping");
      }

      wait rotatetime;
    }
  }

  antenna rotateYaw(-105, 6, 0, 5);
  wait 6;
  var_104068cf7b6ef7e0 stoploopsound("jup_radar_rotate_lp");
  var_104068cf7b6ef7e0 delete();
  playsoundatpos(antenna.origin + (0, 0, 50), "jup_radar_rotate_end");
}

function function_658c41a1c3cbe6d6(tank) {
  level endon("game_ended");

  if(getdvarint(@ "hash_6f976b4880b59d4c", 0) == 1) {
    return;
  }

  var_1ab85e427d3d60f4 = getEntArray("tank_fire_event", "script_noteworthy");
  var_1ab85e427d3d60f4 = array_sort_by_script_index(var_1ab85e427d3d60f4);

  for(i = 0; i < var_1ab85e427d3d60f4.size; i++) {
    while(!ispointinvolume(tank.origin, var_1ab85e427d3d60f4[i])) {
      waitframe();
    }

    var_9bda87deda5b3dcf = getStructArray(var_1ab85e427d3d60f4[i].target, "targetname");

    if(var_9bda87deda5b3dcf.size > 1) {
      var_9bda87deda5b3dcf = array_sort_by_script_index(var_9bda87deda5b3dcf);
    }

    if(tank getscriptablepartstate("damageHeavy", 1) != "stopped") {
      tank.godmode = 1;
      tank.var_6decdc73003db8d0 = 1;

      foreach(turrettarget in var_9bda87deda5b3dcf) {
        if(turrettarget != var_9bda87deda5b3dcf[0]) {
          wait 1.5;
        }

        tank setturrettargetvec(turrettarget.origin);
        tank waittill("turret_on_target");
        wait 0.5;
        tank fireweapon();
        earthquake(0.4, 0.6, tank.origin, 720);

        foreach(player in level.players) {
          if(isalive(player) && distance(player.origin, tank.origin) < 360) {
            player shellshock("groundpoundshock_tinnitus_mp", 0.5);
          }
        }

        level thread function_b8a462eb85f0f2b0(i, turrettarget);

        if(isDefined(level.var_f7914aa9690e3289)) {
          var_f0fa347d3f1d1e98 = sortbydistance(level.var_f7914aa9690e3289, turrettarget.origin);

          foreach(mgturret in var_f0fa347d3f1d1e98) {
            if(isDefined(mgturret.owner) && isalive(mgturret.owner)) {
              if(distancesquared(mgturret.owner.origin, turrettarget.origin) < 45000) {
                mgturret.owner stopuseturret();
                mgturret.owner.var_8e0105c1b5cd5605 = 1;
                killagent(mgturret.owner);
                mgturret.owner = undefined;
              } else {
                mgturret.owner.ignoreall = 0;
                mgturret.owner clearbtgoal(4);
              }
            }

            var_1850a1f2470152e8 = distancesquared(mgturret.origin, turrettarget.origin);

            if(var_1850a1f2470152e8 < 45000) {
              mgturret thread function_a2ecb2ea6c59a87c();
            }
          }
        }

        if(isDefined(level.var_1351748ae88ad02a)) {
          var_1351748ae88ad02a = [];

          foreach(agent in level.var_1351748ae88ad02a) {
            if(!isDefined(agent) || !isalive(agent)) {
              continue;
            }

            var_1351748ae88ad02a[var_1351748ae88ad02a.size] = agent;
          }

          level.var_1351748ae88ad02a = var_1351748ae88ad02a;
          var_1351748ae88ad02a = sortbydistance(var_1351748ae88ad02a, turrettarget.origin);

          foreach(var_235c7d9fd94ee95d in var_1351748ae88ad02a) {
            var_1850a1f2470152e8 = distancesquared(var_235c7d9fd94ee95d.origin, turrettarget.origin);

            if(var_1850a1f2470152e8 < 45000) {
              var_235c7d9fd94ee95d.var_8e0105c1b5cd5605 = 1;
              killagent(var_235c7d9fd94ee95d);
              continue;
            }

            break;
          }
        }

        wait 1;
      }
    }

    var_cc78a942e51cb6ac = spawn("script_origin", tank.origin + vectornormalize2(anglesToForward(tank.angles)) * 150 + (0, 0, 75));
    var_cc78a942e51cb6ac linkTo(tank);
    tank setturrettargetEnt(var_cc78a942e51cb6ac);
    tank.var_6decdc73003db8d0 = 0;
    tank.godmode = 0;
    tank waittill("turret_on_target");
    tank clearturrettarget();
  }
}

function function_a2ecb2ea6c59a87c() {
  self notify("agent_mg_destroyed");
  self maketurretinoperable();
  waitframe();
  self setModel("jup_military_buildable_mobile_turret_01");
}

function function_b8a462eb85f0f2b0(var_5064dc2a7a46a8df, var_3c483767dfd35827) {
  level endon("game_ended");
  buildings = getscriptablearray("manual_collapse_building_" + var_5064dc2a7a46a8df, "script_noteworthy");

  if(buildings.size == 0) {
    return;
  }

  building = buildings[0];
  wait 0.2;

  if(building getscriptablepartstate("base") == "collapsed") {
    return;
  }

  building setscriptablepartstate("base", "collapsed");
  spawnmayhem("collapse_building_" + var_5064dc2a7a46a8df, "vfx_mayh_launchfacility_dmg_01_v1", building.origin, building.angles);
  wait 3;
  killmayhem("collapse_building_" + var_5064dc2a7a46a8df);
}

function function_7951c17b5988d67c() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("zone_1" + "_objective_end");
  dropnode = getvehiclenode("wm_escort_tank_path", "targetname");
  var_b78922004b1ccfcc = spawn_tag_origin(dropnode.origin, dropnode.angles);
  var_b78922004b1ccfcc show();
  playFXOnTag(getfx("tank_drop_zone"), var_b78922004b1ccfcc, "tag_origin");
  wait 45;
  stopFXOnTag(getfx("tank_drop_zone"), var_b78922004b1ccfcc, "tag_origin");
}

function function_5413c7d723606928(tank) {
  level endon("game_ended");
  tank_sfx = spawn("script_model", (0, 0, 0));
  tank_sfx linkTo(tank, "tag_origin", (-85, 0, 45), (0, 0, 0));

  if(getdvarint(@ "hash_84dcf3cb7db8cb68", 0) == 1) {
    return;
  }

  scripts\mp\outofbounds::enableoobimmunity(tank);
  tank.var_6decdc73003db8d0 = 1;
  tank.team = "neutral";
  tank waittill("landed");
  startnode = getvehiclenode("escort_start_point", "script_noteworthy");

  if(getdvarint(@ "hash_d9d29efba6cd803e") != 1) {
    var_431dac06e73b164 = getEnt("tank_breach_trigger", "script_noteworthy");

    while(true) {
      var_431dac06e73b164 waittill("trigger", player);

      if(is_equal(player.pers["team"], game["attackers"])) {
        break;
      }
    }
  }

  tank.var_6decdc73003db8d0 = 0;
  tank.overridespeed = 12;
  wait 1.1;
  tank_sfx playsoundonmovingent("jup_mode_wm_tank_intro_crush_wall");
  playFXOnTag(level._effect["tank_body_smk"], tank, "tag_origin");
  playFXOnTag(level._effect["tank_track_dust"], tank, "tag_reactive_armor_right_fx");
  playFXOnTag(level._effect["tank_track_dust"], tank, "tag_reactive_armor_left_fx");

  while(distance2dsquared(tank.origin, startnode.origin) > 900) {
    waitframe();
  }

  tank.team = game["attackers"];

  while(tank.overridespeed > 0) {
    tank.overridespeed -= 0.6;
    wait 0.2;
  }

  wait 1;
  tank.overridespeed = undefined;
  tank_sfx delete();
}

function function_2f1fb04b4b9ee70d(tank) {
  level endon("game_ended");
  tank.tankhit = 0;

  if(!isDefined(tank gettagorigin("tag_fix_fx"))) {
    assertmsg("<dev string:x1b3>");
    return;
  }

  level.vehicles.damagecallback = &function_17845e3d3254431e;
}

function function_17845e3d3254431e(inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid) {
  foreach(vehicle in level.escortvehicles) {
    if(self == vehicle) {
      function_65e7481319080680(inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid);
      return;
    }
  }

  scripts\mp\vehicles\damage::callback_vehicledamage(inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid);
}

function function_65e7481319080680(inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid) {
  if(!function_29227adb79acc568("tankRepair", 0)) {
    if(isPlayer(attacker)) {
      if(issharedfuncdefined("damage", "updateDamageFeedback")) {
        var_f56fb412974c87c8 = getsharedfunc("damage", "updateDamageFeedback");
        attacker thread[[var_f56fb412974c87c8]]("hitnobulletdamage_wm", undefined, undefined, undefined, 1);
      }
    }

    return;
  }

  if(!isDefined(self.tankhit) || !isDefined(self.var_5fb0e90d5b2a8aae)) {
    scripts\mp\vehicles\damage::callback_vehicledamage(inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid);
    return;
  }

  tankmaxhealth = function_29227adb79acc568("tankMaxHealth", 5);

  if(objweapon.basename == "bomb_site_mp") {
    if(self.var_5fb0e90d5b2a8aae == 0) {
      self.tankhit = tankmaxhealth;
      scripts\mp\utility\points::function_2a66e9acc30896c(game["defenders"], #"hash_32da3aab2ac19f9e");
      function_b3b50e25bdbdc513();
    }

    return;
  }

  var_d03ed93ff9059e75 = 1;

  var_d03ed93ff9059e75 = getdvarint(@ "hash_84dcf3cb7db8cb68", 0) != 1;

  if(var_d03ed93ff9059e75) {
    if(!isDefined(attacker.agentteam) || attacker.agentteam != game["defenders"]) {
      return;
    }
  }

  if(self.tankhit < tankmaxhealth) {
    self.tankhit += 1;

    if(self.tankhit == 1) {
      scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setstate("light", "pristine");
    }

    if(self.tankhit >= tankmaxhealth && self.var_5fb0e90d5b2a8aae == 0) {
      function_b3b50e25bdbdc513();
    }
  }
}

function function_b3b50e25bdbdc513() {
  self.var_5fb0e90d5b2a8aae = 1;
  self.godmode = 1;
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setstate("medium", "light");

  if(istrue(level.tankturretusable)) {
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(self, 0);
  }

  scripts\mp\objidpoolmanager::update_objective_icon(level.objectives[self.objectivekey].objidnum, "icon_waypoint_tank_damaged");
  scripts\mp\objidpoolmanager::update_objective_setenemylabel(level.objectives[self.objectivekey].objidnum, &"MP_INGAME_ONLY/OBJ_TANK_DAMAGED");
  scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(level.objectives[self.objectivekey].objidnum, &"MP_INGAME_ONLY/OBJ_TANK_DAMAGED");
  level notify("tank_damaged");

  while(scripts\mp\gametypes\wm_objectives::function_796a1097d8a12f6a() > 0) {
    waitframe();
  }

  self.var_1ca48f5e7cae39b2 = self gettagorigin("tag_fix_fx");
  self setscriptablepartstate("damageStateSounds", "damageHeavySound", 1);
  self setscriptablepartstate("damageEngine", "explode", 1);
  playFXOnTag(getfx("tank_damaged"), self, "tag_fix_fx");
  self.repairguy = undefined;
  covertrigger = spawn("script_model", self.origin);
  covertrigger.angles = self.angles;
  self.covertrigger = covertrigger;
  covertrigger makeusable();
  covertrigger sethintdisplayrange(256);
  covertrigger sethintdisplayfov(360);
  covertrigger setuserange(256);
  covertrigger setusefov(360);
  covertrigger sethintonobstruction("show");
  covertrigger setCursorHint("HINT_NOBUTTON");
  covertrigger setHintString(&"MP/TANK_REPAIR_BY_TEAMMATES");
  repairtrigger = spawn("script_model", self.var_1ca48f5e7cae39b2);
  repairtrigger.angles = self.angles;
  self.repairtrigger = repairtrigger;
  repairtrigger makeusable();
  repairtrigger setusefov(60);
  repairtrigger sethintonobstruction("show");
  repairtrigger setCursorHint("HINT_BUTTON");
  repairtrigger setHintString(&"MP/HOLD_TO_REPAIR_TANK");
  repairtrigger.curorigin = repairtrigger.origin;
  repairtrigger.offset3d = (0, 0, 0);
  repairtrigger.ownerteam = game["attackers"];
  repairtrigger scripts\mp\gameobjects::requestid(1, 0, undefined, 1);
  objid = repairtrigger.objidnum;
  scripts\mp\objidpoolmanager::update_objective_position(objid, repairtrigger.origin + (0, 0, 5));
  scripts\mp\objidpoolmanager::objective_pin_global(objid, 1);
  repairtrigger thread function_2586198c11123bd4(self, covertrigger);
  repairtrigger thread function_c1f50d88c810fd3e(self, covertrigger);
}

function function_2586198c11123bd4(tank, covertrigger) {
  level endon("game_ended");
  tank endon("reached_goal");
  tank endon("tank_repaired");
  attackers = scripts\mp\utility\teams::getteamdata(game["attackers"], "alivePlayers");

  foreach(player in attackers) {
    player scripts\mp\hud_message::showsplash("jup_wm_escort_tank_damaged");
  }

  while(isDefined(self) && isDefined(covertrigger)) {
    sphere(self.origin, 20);
    sphere(covertrigger.origin, 256, (0, 0, 1));

    if(!isDefined(tank.repairguy)) {
      foreach(player in level.players) {
        if(is_equal(player.pers["team"], game["defenders"])) {
          self disableplayeruse(player);
        } else {
          self enableplayeruse(player);
        }

        covertrigger disableplayeruse(player);
      }
    } else {
      foreach(player in level.players) {
        if(player == tank.repairguy) {
          self enableplayeruse(player);
          covertrigger disableplayeruse(player);
          continue;
        }

        if(is_equal(player.pers["team"], game["attackers"])) {
          covertrigger enableplayeruse(player);
          self disableplayeruse(player);
          continue;
        }

        covertrigger disableplayeruse(player);
        self disableplayeruse(player);
      }
    }

    waitframe();
  }
}

function function_c1f50d88c810fd3e(tank, covertrigger) {
  level endon("game_ended");
  self.progress = 0;
  var_4ad3bc39018314e8 = 0;
  self.var_f04462cd99576d1 = getdvarint(@ "hash_6364c27ebfd1d7e4", 10);
  var_3dc70af44e157fd3 = squared(144);

  while(true) {
    scripts\mp\objidpoolmanager::update_objective_icon(self.objidnum, "ui_map_icon_repair");
    scripts\mp\objidpoolmanager::update_objective_ownerteam(self.objidnum, game["attackers"]);
    scripts\mp\objidpoolmanager::update_objective_setbackground(self.objidnum, 1);
    scripts\mp\objidpoolmanager::update_objective_state(self.objidnum, "current");
    scripts\mp\objidpoolmanager::objective_teammask_addtomask(self.objidnum, game["attackers"]);
    self waittill("trigger", player);

    while(true) {
      if(isalive(player) && player useButtonPressed() && distancesquared(self.origin, player.origin) <= var_3dc70af44e157fd3 && math::anglebetweenvectors(anglesToForward(player getplayerangles()), tank.origin - player.origin) <= 60 && is_equal(player.pers["team"], game["attackers"])) {
        tank.repairguy = player;
        tank.repairguy scripts\mp\gametypes\wm_utility::function_31325dbf3212f5ec("jup_war_ges_wrench_02", 0.5);
        self setCursorHint("HINT_NOBUTTON");
        self setHintString("");
        var_4ad3bc39018314e8 = min(self.var_f04462cd99576d1, var_4ad3bc39018314e8 + level.framedurationseconds);
        self.progress = var_4ad3bc39018314e8 / self.var_f04462cd99576d1;
        self.var_e9c36927989c0cb3 = self.progress;

        print3d(player.origin + (0, 0, 70), "<dev string:x22b>");
        print3d(tank.origin + (0, 0, 70), self.progress);
        print3d(tank.origin + (0, 0, 80), "<dev string:x239>" + tank.repairguy.name);
      } else {
        tank.repairguy scripts\mp\gametypes\wm_utility::function_dac4b69b3dfb574e();
        scripts\mp\gametypes\wm_utility::function_c470fe81662c7d70(tank.repairguy);
        tank.repairguy = undefined;
        self setCursorHint("HINT_BUTTON");
        self setHintString(&"MP/HOLD_TO_REPAIR_TANK");
        break;
      }

      scripts\mp\gametypes\wm_utility::function_3b593f41f5abb32b(player, "repair_tank");

      if(!isDefined(self.var_5a833b3579172f20)) {
        self.var_5a833b3579172f20 = 0;
      } else if(self.progress >= (self.var_5a833b3579172f20 + 1) / 3) {
        self.var_5a833b3579172f20++;
        player scripts\mp\utility\points::doscoreevent(#"hash_70456407e088f468");
      }

      if(self.progress >= 1) {
        foreach(member in getteamdata(player.team, "players")) {
          scripts\mp\objidpoolmanager::function_26259bd38697b5ad(self.objidnum, member);
        }

        scripts\mp\objidpoolmanager::objective_teammask_removefrommask(self.objidnum, player.team);
        tank scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setstate("pristine", "medium");
        scripts\mp\objidpoolmanager::update_objective_icon(level.objectives[tank.objectivekey].objidnum, "icon_waypoint_escort_tank");
        scripts\mp\objidpoolmanager::update_objective_setenemylabel(level.objectives[tank.objectivekey].objidnum, &"MP_INGAME_ONLY/OBJ_HALT_CAPS");
        scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(level.objectives[tank.objectivekey].objidnum, &"MP_INGAME_ONLY/OBJ_ESCORT_CAPS");
        scripts\mp\gametypes\wm_utility::function_c470fe81662c7d70(tank.repairguy);
        tank.var_5fb0e90d5b2a8aae = 0;
        tank.tankhit = 0;
        tank.godmode = 0;
        self.progress = 0;
        var_4ad3bc39018314e8 = 0;
        tank.repairguy = undefined;
        tank.repairtrigger = undefined;

        if(istrue(level.tankturretusable)) {
          scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(tank, 1);
        }

        tank setscriptablepartstate("damageStateSounds", "resetDamageStateSounds", 1);
        tank setscriptablepartstate("damageEngine", "off", 1);
        tank notify("tank_repaired");
        level notify("tank_repaired");
        player scripts\mp\gametypes\wm_utility::function_dac4b69b3dfb574e();
        covertrigger delete();
        killfxontag(getfx("tank_damaged"), tank, "tag_fix_fx");
        playFX(getfx("tank_repaired"), tank.var_1ca48f5e7cae39b2);
        playsoundatpos(tank.origin + (-80, 0, 45), "jup_mode_wm_tank_repair_complete");
        scripts\mp\utility\points::function_2a66e9acc30896c(player.team, #"hash_168b32093420e2f");
        scripts\mp\gameobjects::releaseid(1, 1);
        self delete();
        return;
      }

      waitframe();
    }
  }
}

function function_2ee1875b4cc4d668() {
  if(!istrue(function_29227adb79acc568("IEDBombEnabled", 1))) {
    bombname = "IED_bomb";
    visuals = getEntArray(bombname, "targetname");

    if(!isDefined(visuals[0])) {
      error("No " + bombname + " script_model found in map.");
      return;
    }

    foreach(visual in visuals) {
      visual hide();
    }

    return;
  }

  level.var_ca38c83d85ce5479 = getscriptablearray("IED_vehicles", "script_noteworthy");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_IED_PickUp", 1, "friendly", &"MP_JUP_LAUNCHFACILITY/PICKUP_IED", "icon_waypoint_ied");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_IED_Picked", 1, "friendly", undefined, "icon_waypoint_ied");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_IED_Being_Planted", 1, "friendly", &"MP_JUP_LAUNCHFACILITY/IED_PLANTING", "icon_waypoint_ied");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_IED_Planted", 1, "friendly", &"MP_JUP_LAUNCHFACILITY/IED_PLANTED", "icon_waypoint_ied_planted");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_Veh_ToPlant", 1, "friendly", &"MP_JUP_LAUNCHFACILITY/PLANT_IED", "icon_waypoint_ied_plant");
  game["bomb_dropped_sound"] = "iw9_mp_ui_objective_lost";
  game["bomb_recovered_sound"] = "iw9_mp_ui_objective_taken";

  while(!isDefined(level.escortvehicles[0])) {
    waitframe();
  }

  bombname = "IED_bomb";
  level.bombplanted = 0;
  trigger = getEnt(bombname + "_pickup_trig", "targetname");

  if(!isDefined(trigger)) {
    error("No " + bombname + "_pickup_trig trigger found in map.");
    return;
  }

  visuals = getEntArray(bombname, "targetname");

  if(!isDefined(visuals[0])) {
    error("No " + bombname + " script_model found in map.");
    return;
  }

  foreach(visual in visuals) {
    visual setnonstick(1);
  }

  level.sdbomb = scripts\mp\gameobjects::createcarryobject(game["defenders"], trigger, visuals, (0, 0, 32), undefined, 1);
  level.sdbomb scripts\mp\gameobjects::allowcarry("friendly");
  level.sdbomb.allowweapons = 1;
  level.sdbomb.requireslos = 1;
  level.sdbomb.onpickup = &function_2b03782c418d29ba;
  level.sdbomb.ondrop = &function_cd32a1014592af53;
  level.sdbomb.firstpickup = 1;
  level thread bombsitewatcher();
  level.bombrespawnpoint = level.sdbomb.visuals[0].origin;
  level.bombrespawnangles = level.sdbomb.visuals[0].angles;
  level.sdbomb.visualgroundoffset = (0, 0, 0);
  triggers = getEntArray("IED_bombzone", "targetname");

  foreach(trigger in triggers) {
    trigger.originalpos = trigger.origin;
    visuals = getentitylessscriptablearray(trigger.target, "targetname");
    reservedobjid = undefined;
    bombzone = scripts\mp\gameobjects::createuseobject(game["defenders"], trigger, visuals, (0, 0, 64), reservedobjid, 1);
    bombzone scripts\mp\gameobjects::allowuse("friendly");
    bombzone.id = "wm_IED";
    bombzone.trigger setusepriority(-1 - 1 - 1 - 1);
    bombzone scripts\mp\gameobjects::setusetime(getdvarint(@ "hash_61adfc997b946e7c", 2.5));
    bombzone scripts\mp\gameobjects::setwaitweaponchangeonuse(0);
    bombzone scripts\mp\gameobjects::setusehinttext(&"MP_JUP_LAUNCHFACILITY/PLANT_IED");
    bombzone.trigger setuseholdduration("duration_none");
    bombzone scripts\mp\gameobjects::setkeyobject(level.sdbomb);

    foreach(player in level.players) {
      bombzone.trigger disableplayeruse(player);
    }

    bombzone.onbeginuse = &ied_onbeginuse;
    bombzone.onenduse = &ied_onenduse;
    bombzone.onuse = &ied_onuseplantobject;
    bombzone.bombplanted = 0;
    bombzone.bombexploded = undefined;
    bombzone.resetprogress = 1;

    for(i = 0; i < visuals.size; i++) {
      if(isDefined(visuals[i].script_exploder)) {
        bombzone.exploderindex = visuals[i].script_exploder;
        visuals[i] thread scripts\mp\gametypes\obj_bombzone::function_f1ce924cd6279917(bombzone);
        visuals[i] thread scripts\mp\gametypes\obj_bombzone::setupkillcament(bombzone);
        break;
      }
    }

    bombzone.noweapondropallowedtrigger = spawn("trigger_radius", bombzone.trigger.origin, 0, 140, 100);
    scripts\mp\gametypes\obj_bombzone::function_2db76423768ca0f5(bombzone);

    foreach(visual in bombzone.visuals) {
      visual setscriptablepartstate("model", "hide", 1);
    }

    if(!isDefined(level.iedzones)) {
      level.iedzones = [];
    }

    level.iedzones[level.iedzones.size] = bombzone;

    foreach(veh in level.var_ca38c83d85ce5479) {
      if(ispointinvolume(veh.origin, bombzone.trigger)) {
        bombzone.veh = veh;
        bombzone thread function_4add7af576989191();
        continue;
      }
    }
  }

  level.sdbomb.offset3d = (0, 0, 16);
  level.sdbomb scripts\mp\gameobjects::requestid(1, 1);
  level.sdbomb scripts\mp\gameobjects::setobjectivestatusicons("waypoint_IED_PickUp");
  level.sdbomb scripts\mp\gameobjects::setvisibleteam("friendly");
  scripts\mp\objidpoolmanager::function_98ba077848896a3(level.sdbomb.objidnum, 0);

  foreach(visual in level.sdbomb.visuals) {
    visual.var_6153cb74ab3762c3 = scripts\mp\utility\outline::outlineenableforteam(visual, game["defenders"], "outline_nodepth_white", "level_script");
  }

  objective_setspecialobjectivedisplay(level.sdbomb.objidnum, 1);
  scripts\mp\objidpoolmanager::objective_set_play_intro(level.sdbomb.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(level.sdbomb.objidnum, 0);
  level.sdbomb scripts\mp\gameobjects::create_manual_drop_data_struct(level.sdbomb.visuals, level.sdbomb.trigger, 1, 80, 0, &function_745c1786b3409d7a);

  foreach(bombzone in level.iedzones) {
    bombzone.var_b8cc16dcaf5a0746 = "icon_small";
    bombzone.offset3d = (0, 0, 33);
    bombzone scripts\mp\gameobjects::requestid(1, 1);
    bombzone scripts\mp\gameobjects::setobjectivestatusicons("waypoint_Veh_ToPlant", "waypoint_Veh_ToPlant");
    bombzone scripts\mp\gameobjects::setvisibleteam("friendly");
    scripts\mp\objidpoolmanager::function_98ba077848896a3(bombzone.objidnum, 0);
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(bombzone.objidnum);
  }

  level thread function_74abe389fe487d49();
}

function function_4add7af576989191() {
  level endon("game_ended");
  level endon("IED_planted");
  self.veh waittill("rocked");
  scripts\mp\gameobjects::releaseid(1, 1);

  foreach(visual in self.visuals) {
    visual setscriptablepartstate("model", "hide", 1);
  }

  self.trigger delete();

  foreach(i, bombzone in level.iedzones) {
    if(bombzone == self) {
      level.iedzones[i] = undefined;
      break;
    }
  }
}

function function_2b03782c418d29ba(player, playervo, defused) {
  player.isbombcarrier = 1;
  player setclientomnvar("ui_carry_object_can_drop", 0);
  player setclientomnvar("ui_carrying_bomb", 1);
  setomnvar("ui_bomb_carrier", player getentitynumber());

  foreach(visual in self.visuals) {
    scripts\mp\utility\outline::outlinedisable(visual.var_6153cb74ab3762c3, visual);
  }

  self.offset3d = (0, 0, 75);
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_IED_Picked");
  scripts\mp\gameobjects::setvisibleteam("friendly");
  scripts\mp\utility\sound::playsoundonplayers(game["bomb_recovered_sound"], game["defenders"]);
  level thread scripts\mp\hud_util::function_7b2653a588f28e29(player, "jup_wm_iedpickup", "jup_wm_iedpickup_team", "");
  level notify("bomb_carrier_changed", player, 1);
}

function function_cd32a1014592af53(player) {
  silentdrop = isDefined(self.var_c7945be244726ad0) && self.var_c7945be244726ad0 < gettime() + 1000;
  level notify("bomb_carrier_changed", player, 0);
  setomnvar("ui_bomb_carrier", -1);

  foreach(visual in self.visuals) {
    visual.var_6153cb74ab3762c3 = scripts\mp\utility\outline::outlineenableforteam(visual, game["defenders"], "outline_nodepth_white", "level_script");
  }

  self.offset3d = (0, 0, 16);

  foreach(bombzone in level.iedzones) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(bombzone.objidnum);
  }

  left = 0;
  right = 0;

  foreach(i, visual in self.visuals) {
    visual.angles = (0, 0, 0);

    if(!isDefined(visual.script_noteworthy)) {
      visual.angles -= (0, 0, 90);
      visual.origin += (0, 0, 3);

      if(!left) {
        visual.origin -= (6, 0, 0);
        left = 1;
      } else if(!right) {
        visual.origin += (6, 0, 0);
        right = 1;
      }
    } else if(visual.script_noteworthy == "detonator") {
      visual.origin += (0, 10, 6);
    }

    if(i != 0) {
      visual linkTo(self.visuals[0]);
    }
  }

  self.visuals[0].angles += (0, player.angles[1] - 90, 0);
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_IED_PickUp");
  scripts\mp\gameobjects::setvisibleteam("friendly");

  if(!silentdrop) {
    scripts\mp\utility\sound::playsoundonplayers(game["bomb_dropped_sound"], game["defenders"]);
  }

  if(isDefined(player)) {
    player.isbombcarrier = 0;
  }
}

function bombsitewatcher() {
  level endon("game_ended");
  level endon("IED_planted");

  while(true) {
    level waittill("bomb_carrier_changed", player, iscarrying);
    assert(isDefined(player) && isDefined(iscarrying));

    foreach(bombzone in level.iedzones) {
      if(iscarrying) {
        bombzone.trigger enableplayeruse(player);
        scripts\mp\objidpoolmanager::objective_playermask_single(bombzone.objidnum, player);
        continue;
      }

      bombzone.trigger disableplayeruse(player);
      scripts\mp\objidpoolmanager::function_17db39bd195cc5b1(bombzone.objidnum);
    }
  }
}

function ied_onbeginuse(player) {
  player playlocalsound("mp_bomb_raise_noise");
  player scripts\mp\bots\bots_util::notify_enemy_bots_bomb_used("plant");
  player notify("super_obj_drain");
  player.isplanting = 1;
  scripts\mp\utility\dialog::statusdialog("bomb_planting", player.team, "status");
  player scripts\mp\objidpoolmanager::function_160f522b63c32d76(2, &"MP_JUP_LAUNCHFACILITY/PLANTING_IED");
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_IED_Being_Planted", "waypoint_IED_Being_Planted");
  scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(self.objidnum, player);
  player thread scripts\mp\gametypes\obj_bombzone::startnpcbombusesound("briefcase_bomb_mp", "equip_suitcase_raise_button");
}

function ied_onenduse(team, player, result) {
  scripts\mp\gametypes\obj_bombzone::bombzone_onenduse(team, player, result);
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_Veh_ToPlant", "waypoint_Veh_ToPlant");
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objidnum);
  scripts\mp\objidpoolmanager::objective_playermask_single(self.objidnum, player);
}

function ied_onuseplantobject(player) {
  foreach(visual in self.visuals) {
    visual setscriptablepartstate("model", "show", 1);
  }

  self.visuals[0] setscriptablepartstate("sound", "planted");
  self.veh setscriptablepartstate("Window_Blast", "destroyed");
  self.showprogressforteam = undefined;
  level thread bombzone_onbombplanted(self, player);
  player notify("IED_planted");
  player scripts\mp\utility\points::doscoreevent(#"hash_93fa2b505b757a38");
  level.bombowner = player;
  player.bombplantedtime = gettime();
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_IED_Planted", "waypoint_IED_Planted");

  foreach(i, bombzone in level.iedzones) {
    if(bombzone == self) {
      continue;
    }

    bombzone scripts\mp\gameobjects::releaseid(1, 1);
    bombzone.trigger delete();
    level.iedzones[i] = undefined;
  }

  self.trigger disableplayeruse(player);
  scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(self.objidnum, player);
}

function function_745c1786b3409d7a(player) {
  player setclientomnvar("ui_carrying_bomb", 0);
}

function bombzone_onbombplanted(destroyedobj, player) {
  level endon("bombs_canceled");
  level endon("IED_defused");
  level notify("IED_planted", destroyedobj);
  plantteam = player.team;
  level.bombdefused = 0;
  destroyedobj.bombdefused = 0;
  level.bombplanted = 1;
  level.bombsplanted += 1;
  level.destroyedobject = destroyedobj;
  level.destroyedobject.bombplanted = 1;
  player setclientomnvar("ui_carrying_bomb", 0);
  setomnvar("ui_bomb_carrier", -1);
  level.tickingobject = destroyedobj.visuals[0];
  level.sdbomb scripts\mp\gameobjects::allowcarry("none");
  level.sdbomb scripts\mp\gameobjects::setvisibleteam("none");
  var_8f59c9f0558fa031 = scripts\mp\gametypes\obj_bombzone::function_5784fd1cddbd00d3();
  level.sdbomb scripts\mp\gameobjects::setdropped(undefined, ter_op(var_8f59c9f0558fa031 > 0, var_8f59c9f0558fa031, undefined), getdvarint(@ "hash_9cf963b64e1223e7", 0) == 1);

  foreach(i, visual in level.sdbomb.visuals) {
    if(i != 0) {
      visual unlink();
    }

    scripts\mp\utility\outline::outlinedisable(visual.var_6153cb74ab3762c3, visual);

    if(!isDefined(visual.script_noteworthy)) {
      visual hide();
      continue;
    }

    if(visual.script_noteworthy == "detonator") {
      level.sdbombmodel = visual;
    }
  }

  var_b4305ef8c598b87e = getStruct(destroyedobj.trigger.target, "targetname");
  level.sdbombmodel.origin = var_b4305ef8c598b87e.origin;
  level.sdbombmodel.angles = var_b4305ef8c598b87e.angles;
  level.sdbomb scripts\mp\gameobjects::releaseid(1, 1);
  destroyedobj function_54cf80955c067c99();
  destroyedobj function_f3ac6b64a0344dad(player, 0);
}

function function_f3ac6b64a0344dad(player, defused) {
  scripts\mp\gameobjects::releaseid(1, 1);

  foreach(visual in self.visuals) {
    visual setscriptablepartstate("model", "hide", 1);
    visual setscriptablepartstate("sound", "none");
  }

  if(level.gameended) {
    return;
  }

  if(!defused) {
    level notify("bomb_exploded");
  }

  explosionorigin = level.sdbombmodel.origin;
  playFX(getfx("ied_explosion"), self.veh.origin, anglesToForward(self.veh.angles));
  damageoriginbase = self.visuals[0].origin + (0, 0, 60);
  damageoriginoffset = anglestoright(self.visuals[0].angles) * 24;
  damageorigin1 = damageoriginbase + damageoriginoffset;
  damageorigin2 = damageoriginbase - damageoriginoffset;

  if(isDefined(player)) {
    radiusdamage(damageorigin1, 512, 200, 20, player, "MOD_EXPLOSIVE", "bomb_site_mp");
    radiusdamage(damageorigin2, 512, 200, 20, player, "MOD_EXPLOSIVE", "bomb_site_mp");
  } else {
    radiusdamage(damageorigin1, 512, 200, 20, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");
    radiusdamage(damageorigin2, 512, 200, 20, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");
  }

  effect = "bomb_explosion";
  explosioneffect = spawnfx(scripts\engine\utility::getfx(effect), explosionorigin);
  triggerfx(explosioneffect);
  physicsexplosionsphere(explosionorigin, 200, 100, 3);
  playrumbleonposition("grenade_rumble", explosionorigin);
  earthquake(0.5, 2, explosionorigin, 2000);
  playsoundatpos(explosionorigin, "exp_bombsite_lr");

  foreach(visual in level.sdbomb.visuals) {
    visual delete();
  }

  level.sdbomb.trigger delete();
  level.sdbomb = undefined;
  self.trigger delete();
  level.iedzones = undefined;
}

function function_54cf80955c067c99() {
  level endon("game_ended");
  level endon("IED_defused");
  thread function_34214d20324fb8d();

  foreach(visual in self.visuals) {
    if(isDefined(visual.target)) {
      var_1b10420643377d2b = getEnt(visual.target, "targetname");
      continue;
    }
  }

  tank = level.escortvehicles[0];

  while(true) {
    if(ispointinvolume(tank.origin, var_1b10420643377d2b)) {
      return;
    }

    drawtrigger(var_1b10420643377d2b);

    waitframe();
  }
}

function function_34214d20324fb8d() {
  level endon("game_ended");
  level endon("IED_defused");
  level endon("bomb_exploded");
  self.veh waittill("rocked");
  function_f3ac6b64a0344dad(undefined, 1);
  level notify("IED_defused");
}

function function_74abe389fe487d49() {
  level endon("game_ended");
  level endon("IED_planted");
  scripts\mp\flags::gameflagwait("zone_2" + "_objective_end");

  foreach(i, bombzone in level.iedzones) {
    bombzone scripts\mp\gameobjects::releaseid(1, 1);

    foreach(visual in bombzone.visuals) {
      visual setscriptablepartstate("model", "hide", 1);
    }

    bombzone.trigger delete();
    level.iedzones[i] = undefined;
  }

  if(isDefined(level.sdbomb) && isDefined(level.sdbomb.trigger)) {
    level.sdbomb scripts\mp\gameobjects::releaseid(1, 1);

    foreach(visual in level.sdbomb.visuals) {
      visual delete();
    }

    level.sdbomb.trigger delete();
    level.sdbomb = undefined;
  }
}

function function_30ebb63e4d42678() {
  level endon("game_ended");

  if(getdvarint(@ "hash_c1a52c1fb42ce", 0)) {
    return;
  }

  scripts\mp\damage::function_3e0f845008bbd48d(&function_f30ccc935e3c5af9);
  var_5731a50da1307842 = getStructArray("MGpoint", "script_noteworthy");
  team = game["defenders"];
  scripts\mp\flags::gameflagwait("zone_2" + "_objective_start");

  foreach(point in var_5731a50da1307842) {
    turret = spawnmgturret(point, undefined, undefined, undefined, team);
    turret thread function_3cd75d5bf0fc9989(point, undefined, undefined, undefined, team);
  }
}

function function_f30ccc935e3c5af9(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime) {
  if(isDefined(eattacker) && isDefined(eattacker.var_3763391e00ccdd58)) {
    return 5;
  }

  return undefined;
}

function spawnmgturret(spawndata, weaponname, modelname, aitype, team) {
  level endon("game_ended");

  if(!isDefined(weaponname)) {
    weaponname = "jup_cougar_mg_gunner_turret_mp";
  }

  if(!isDefined(modelname)) {
    modelname = "weapon_wm_mg_mobile_turret";
  }

  turret = spawnturret("misc_turret", spawndata.origin, weaponname, 0);
  turret.var_3763391e00ccdd58 = 1;
  turret setModel(modelname);

  if(isDefined(spawndata.angles)) {
    turret.angles = spawndata.angles;
  }

  turret setmode("sentry_offline");
  turret makeunusable();
  turret setdefaultdroppitch(0);
  turret.usemode = "manual_target";
  turret.colmodel = spawn("script_model", turret.origin);
  turret.colmodel.team = turret.team;
  turret.colmodel setModel("weapon_vm_mg_sentry_turret_invis_base");
  turret.colmodel dontinterpolate();

  if(!isDefined(level.var_f7914aa9690e3289)) {
    level.var_f7914aa9690e3289 = [];
  }

  level.var_f7914aa9690e3289[level.var_f7914aa9690e3289.size] = turret;
  turret startfiring();
  turret setmode("manual");
  return turret;
}

function function_3cd75d5bf0fc9989(spawndata, weaponname, modelname, aitype, team) {
  level endon("game_ended");
  scripts\mp\ai_mp_controller::function_2fc80954fa70d153();

  if(!isDefined(aitype)) {
    aitype = "jup_enemy_mp_lmg_tier1_pmc";
  }

  var_9ba5cef5b2b49421 = getStruct(spawndata.target, "targetname");
  agent = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent(aitype, var_9ba5cef5b2b49421.origin, var_9ba5cef5b2b49421.angles, "absolute", "show", "rpg", undefined, team, undefined, undefined, 1, undefined, 0, undefined);
  agent scripts\cp_mp\agents\agent_utils::agentpers_setagentpersdata(agent, "team", team);
  agent scripts\cp_mp\agents\agent_utils::function_c37c4f9d687074ff(undefined, undefined, undefined, undefined, undefined, 0, 0);
  agent.var_b582b10663b5b2a9 = 0;
  agent.ignoreall = 1;
  agent clearbtgoal(4);
  agent setbtgoalstationary(4);
  agent.var_6384ebeaed4efe3e = 1;

  if(isDefined(spawndata.script_label)) {
    var_99fe65bbdb024783 = getEnt("mg_agent_mount_trigger" + spawndata.script_label, "targetname");

    if(!isDefined(var_99fe65bbdb024783)) {
      assertmsg("<dev string:x245>");
    } else {
      while(true) {
        var_99fe65bbdb024783 waittill("trigger", player);

        if(!is_equal(player.pers["team"], game["attackers"])) {
          continue;
        }

        break;
      }
    }
  }

  if(!isalive(agent)) {
    return;
  }

  agent clearbtgoal(4);
  agent setbtgoalpos(4, getclosestpointonnavmesh(spawndata.origin));
  aimpos = spawn("script_model", self.origin + anglesToForward(self.origin) * 100);
  self.aimpos = aimpos;
  self settargetentity(aimpos);

  level thread function_6b6a08026758fca9(aimpos);

  if(istrue(level.var_2f006c7490fb7639)) {
    scripts\common\ai::ai_operate_turret(agent, self);
    self.owner = agent;
    thread function_86880084e476db84();
    return;
  }

  wait 3;

  if(isalive(agent)) {
    scripts\common\ai::ai_operate_turret(agent, self);
    self.owner = agent;
    self.colmodel.owner = self.owner;
    agent.var_859f7cb544b5801d = self;
    self.owner thread function_bd80506147960d00();
    thread function_69c4dd9b2bc55b1b();
  }
}

function function_69c4dd9b2bc55b1b() {
  level endon("game_ended");
  self endon("death");
  self endon("agent_mg_destroyed");
  turret = self;
  burst = 9;

  while(true) {
    if(!istrue(function_a233031a44bbbb0d(turret, turret.owner))) {
      return;
    }

    blackboard = turret.owner._blackboard;

    if(!isDefined(blackboard) || !isDefined(blackboard.aigroundturretstate) || blackboard.aigroundturretstate != "turret_mounted") {
      waitframe();
      continue;
    }

    break;
  }

  wait 1.5;

  while(true) {
    if(!istrue(function_a233031a44bbbb0d(turret, turret.owner))) {
      return;
    }

    attackers = scripts\mp\utility\teams::getteamdata(game["attackers"], "alivePlayers");
    var_95f2a51e7b487eb2 = sortbydistancecullbyradius(attackers, self.origin, 2400);
    var_1e1dd312897f5c42 = [];

    foreach(attacker in var_95f2a51e7b487eb2) {
      var_de72f19d4de18b4f = distance2dsquared(attacker.origin, self.origin);

      if(var_de72f19d4de18b4f >= 100000) {
        var_1e1dd312897f5c42[var_1e1dd312897f5c42.size] = attacker;
      }
    }

    target = array_random(var_1e1dd312897f5c42);

    if(isDefined(target)) {
      function_597e32613762e969(target, self.aimpos, burst);
      wait randomfloatrange(3, 3.5);
      continue;
    }

    wait 0.2;
  }
}

function function_86880084e476db84() {
  level endon("game_ended");
  turret = self;
  burst = 6;

  while(true) {
    if(isDefined(self.var_57abfc2b0a18dd65)) {
      function_597e32613762e969(self.var_57abfc2b0a18dd65, self.aimpos, burst);
    }

    wait 0.5;
  }
}

function function_597e32613762e969(target, aimpos, burst) {
  self endon("agent_mg_destroyed");
  turret = self;
  var_bd2a07ce8b285aa4 = target.origin + vectornormalize2(turret.origin - target.origin) * 600;

  if(distance2dsquared(var_bd2a07ce8b285aa4, self.origin) > 100000) {
    aimpos moveTo(var_bd2a07ce8b285aa4, 0.2);
    var_777a0430627e00a8 = vectornormalize2(target.origin - turret.origin) * 1000;
  } else {
    aimpos moveTo(target.origin + vectornormalize2(target.origin - turret.origin) * 100, 0.2);
    var_777a0430627e00a8 = undefined;
  }

  wait 0.2;

  for(i = 0; i < burst; i++) {
    if(!istrue(function_a233031a44bbbb0d(turret, turret.owner))) {
      return;
    }

    if(turret.owner isflashed()) {
      turret.owner._blackboard.aigroundturretstate = "none";
      turret.owner.ignoreall = 1;
      turret.owner.ignoreme = 1;
      turret.owner.var_ab002334e3a455a5 = 1;
      wait 2;
      break;
    }

    if(istrue(turret.owner.var_ab002334e3a455a5)) {
      scripts\common\ai::ai_operate_turret(turret.owner, turret);
      turret.owner.var_ab002334e3a455a5 = undefined;

      while(true) {
        if(!istrue(function_a233031a44bbbb0d(turret, turret.owner))) {
          return;
        }

        blackboard = turret.owner._blackboard;

        if(!isDefined(blackboard) || !isDefined(blackboard.aigroundturretstate) || blackboard.aigroundturretstate != "turret_mounted") {
          waitframe();
          continue;
        }

        break;
      }

      wait 1.5;
    }

    if(isDefined(turret.owner)) {
      turret shootturret();
    }

    if(isDefined(var_777a0430627e00a8)) {
      aimpos moveTo(aimpos.origin + var_777a0430627e00a8 / burst, 0.05);
    }

    wait 0.13;
  }
}

function function_6b6a08026758fca9(aimpos) {
  while(isDefined(aimpos)) {
    sphere(aimpos.origin, 50);
    waitframe();
  }
}

function function_a233031a44bbbb0d(turret, owner) {
  if(!isDefined(owner) || !isalive(owner)) {
    turret setmode("sentry_offline");
    turret cleartargetentity();
    turret.owner = undefined;
    turret hudoutlinedisable();

    if(isDefined(turret.aimpos)) {
      turret.aimpos delete();
    }

    return false;
  }

  return true;
}

function function_bd80506147960d00() {
  level endon("game_ended");
  self endon("death");
  var_68e6f05a4ee24dee = scripts\engine\trace::create_contents(1, 1);
  outlinetype = "outlinefill_enemy_hvt";

  while(isalive(self) == 1) {
    foreach(player in level.players) {
      forward = anglesToForward(player getplayerangles());

      if(within_fov(player getEye(), player getplayerangles(), self.origin, cos(60))) {
        hits = physics_raycast(player getEye(), player getEye() + forward * 150000, var_68e6f05a4ee24dee, undefined, 0, "physicsquery_closest");
      }

      if(isDefined(hits) && hits.size > 0) {
        foreach(hit in hits) {
          if(isDefined(hit["entity"]) && hit["entity"] == self) {
            if(is_equal(player.pers["team"], self.pers["team"])) {} else {
              self hudoutlineenableforclient(player, outlinetype);

              if(isDefined(self.var_859f7cb544b5801d) && isDefined(self._blackboard) && isDefined(self._blackboard.aigroundturretstate) && self._blackboard.aigroundturretstate == "turret_mounted") {
                self.var_859f7cb544b5801d hudoutlineenableforclient(player, outlinetype);
              }
            }

            break;
          }

          self hudoutlinedisableforclient(player);

          if(isDefined(self.var_859f7cb544b5801d)) {
            self.var_859f7cb544b5801d hudoutlinedisableforclient(player);
          }
        }
      }
    }

    waitframe();
  }
}

function function_3e1d0330ae83c995() {
  level endon("game_ended");

  if(getdvarint(@ "hash_e4f8d3bb6d55cfbe", 0) == 1) {
    return;
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  var_10b581109fb854a2 = getEntArray("crash_vehicle_trigger", "script_noteworthy");
  var_6c77531dd8acb417 = getStructArray("crashed_vehicles", "script_noteworthy");
  var_b06d11b18dcc70d7 = getEntArray("crashed_vehicles_clips", "targetname");

  if(isDefined(var_b06d11b18dcc70d7)) {
    foreach(clip in var_b06d11b18dcc70d7) {
      clip moveTo(clip.origin + (0, 0, -4000), 0.5, 0.05, 0.05);
    }
  }

  if(var_10b581109fb854a2.size == 0 || var_6c77531dd8acb417.size == 0) {
    assertmsg("<dev string:x28b>");
    return;
  }

  var_10b581109fb854a2 = array_sort_by_script_index(var_10b581109fb854a2);
  vehs = [];

  foreach(var_46dcf41326948afe in var_6c77531dd8acb417) {
    veh = spawn("script_model", var_46dcf41326948afe.origin);
    veh setModel("jup_urz_veh9_civ_lnd_pickup_launchfacility_dst_air");
    veh.angles = var_46dcf41326948afe.angles;
    veh.animname = "crashed_pickup";
    veh scripts\common\anim::setanimtree();
    vehs[vehs.size] = veh;
    veh notsolid();
    staticveh = spawn("script_model", var_46dcf41326948afe.origin);
    staticveh setModel("jup_urz_veh9_civ_lnd_pickup_launchfacility_dst_air_static");
    staticveh.angles = veh.angles;
    staticveh notsolid();
    staticveh.origin -= (0, 0, 200);
    veh solid();
    veh.static = staticveh;
  }

  while(!isDefined(level.escortvehicles[0])) {
    waitframe();
  }

  tank = level.escortvehicles[0];

  foreach(var_d2d8f892e65d8aa5 in var_10b581109fb854a2) {
    while(!ispointinvolume(level.escortvehicles[0].origin, var_d2d8f892e65d8aa5)) {
      waitframe();
    }

    [pickup] = sortbydistance(vehs, tank.origin);
    pickup thread scripts\common\anim::anim_single_solo(pickup, "crash");
    playsoundatpos(pickup.origin + (0, 0, 15), "dst_vehicle_crush_wm");
    tank.var_6decdc73003db8d0 = 1;
    animendpos = tank scripts\anim\utility::getanimendpos(level.scr_anim["veh_jup_cougar_mg"]["crash"]);

    sphere(animendpos, 10, (1, 0, 0), 0, 10000);

    [nextnode] = sortbydistance(tank.pathnodes, animendpos);

    if(isDefined(nextnode)) {
      sphere(nextnode.origin, 10, (0, 1, 0), 0, 10000);

      tank attachpath(nextnode);
    }

    tank scripts\common\anim::anim_single_solo(tank, "crash", undefined, 0.2);
    var_77e02f2bb854467f = getanimlength(level.scr_anim["crashed_pickup"]["crash"]);
    var_dfce25e9a7fe12f3 = getanimlength(level.scr_anim["veh_jup_cougar_mg"]["crash"]);
    timetowait = var_77e02f2bb854467f - var_dfce25e9a7fe12f3 + 0.5;
    pickup notsolid();
    pickup.static dontinterpolate();
    pickup.static.origin += (0, 0, 200);
    pickup.static solid();
    wait timetowait;
    pickup dontinterpolate();
    pickup.origin -= (0, 0, 200);
    tank.var_6decdc73003db8d0 = 0;
  }
}

function function_b3f327a076ec28fc() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(objectivestr in level.objectiveorder) {
    scripts\mp\flags::gameflagwait(objectivestr + "_objective_start");

    if(isDefined(level.scriptevents[objectivestr])) {
      foreach(event in level.scriptevents[objectivestr]) {
        event thread function_d2957f8c3bb2978(objectivestr);
      }
    }
  }
}

function function_7458093a3f00753() {
  level endon("game_ended");
  gameflagwait("zone_1" + "_objective_start");
  var_bc437b0c19707e34 = 0;
  flag_set("zone1_enableSamsite");
  var_bac111ac8b75435e = level.objectives["_b"];

  while(level.zone.name == "zone_1") {
    if(isDefined(var_bac111ac8b75435e) && isDefined(var_bac111ac8b75435e.curprogress) && isDefined(var_bac111ac8b75435e.usetime)) {
      captureprogress = var_bac111ac8b75435e.curprogress / var_bac111ac8b75435e.usetime * 100;

      if(captureprogress >= 75 && !istrue(var_bc437b0c19707e34)) {
        var_bc437b0c19707e34 = 1;
        level thread function_f49914c65896f7ed("zone_1", 0.3, 5);
      }

      if(istrue(var_bac111ac8b75435e.complete)) {
        flag_clear("zone1_enableSamsite");
        return;
      }
    }

    waitframe();
  }
}

function addevent(zone, eventname, var_c99f96abc50e7cd6, delaytime, context) {
  if(!isDefined(zone) || !isDefined(level.scriptevents[zone])) {
    assertmsg("<dev string:x2d0>");
    return;
  }

  event = spawnStruct();
  event.eventname = eventname;
  event.var_57b9b5a4757c3b88 = var_c99f96abc50e7cd6;
  event.delaytime = delaytime;
  event.context = context;
  level.scriptevents[zone][level.scriptevents[zone].size] = event;
}

function function_d2957f8c3bb2978(objectivestr) {
  level endon("game_ended");
  level endon(objectivestr + "_objective_end");
  wait self.delaytime;

  if(isDefined(self.var_57b9b5a4757c3b88)) {
    self[[self.var_57b9b5a4757c3b88]]();
  }
}

function function_9c78ba703d9ff9a() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  wait 30;
  exploder("vista_action");
  scripts\mp\flags::gameflagwait("zone_1" + "_objective_end");
  kill_exploder("vista_action");
}

function function_aaa0134cf5ca2e67(context) {
  level endon("game_ended");

  if(!isDefined(context)) {
    return;
  }

  explosions = getStructArray("a10_explo_" + context, "script_noteworthy");

  if(!isDefined(explosions)) {
    return;
  }

  wait 8;
  exploder("a10_explo_" + context);

  foreach(explo in explosions) {
    playsoundatpos(explo.origin + (0, 0, 100), "rocket_explode");
    earthquake(0.3, 0.5, explo.origin, 5000);
    wait 0.25;
  }
}

function function_33107c3b1ce52835() {
  level thread function_6a3f1832efc2f017();
  level thread function_a82dda36038fb064();
}

function function_6a3f1832efc2f017() {
  infil = getStruct("infil_blima", "script_noteworthy");
  scene_node = getStruct(infil.target, "targetname");
  gameflagwait("infil_started");
  var_3f9f823964d96e08 = scene_node.origin;
  missilemodel = "weapon_wm_la_juliet_missile";
  missile = spawn("script_model", var_3f9f823964d96e08);
  missile.angles = scene_node.angles;
  missile setModel(missilemodel);
  missile.animname = "attacker_infil";
  missile scripts\common\anim::setanimtree();

  if(getdvarint(@ "hash_38e6b69749384789", 0) == 1) {
    missile thread function_1e2fd113d6f91a8a();
  }

  animlength = getanimlength(level.scr_anim["attacker_infil"]["infil_missile"]);
  missile thread function_72a7d86ef87559af(animlength);
  missile thread function_b363558aefabb60a(animlength);
  missile scripts\common\anim::anim_single_solo(missile, "infil_missile");
  var_cb0b638e99aabf51 = game["infil"]["allies"][1]["infil_blima"]["alpha"];
  var_d78d4fd9040f2a9c = var_cb0b638e99aabf51.linktoent;

  if(isDefined(var_d78d4fd9040f2a9c)) {
    missile delete();
    playFXOnTag(level._effect["infil_heli_hited"], var_d78d4fd9040f2a9c, "tag_origin");
    var_d78d4fd9040f2a9c setscriptablepartstate("engine", "on", 0);
    var_d78d4fd9040f2a9c setscriptablepartstate("damageEngine", "explode", 0);
  }
}

function function_72a7d86ef87559af(animlength) {
  level endon("game_ended");
  wait animlength;
  earthquake(0.5, 1, self.origin, 30000);
}

function function_a82dda36038fb064() {
  var_2b76d31270ba8d75 = getStruct("infil_heli_crash", "script_noteworthy");

  if(!isDefined(var_2b76d31270ba8d75)) {
    return;
  }

  gameflagwait("infil_started");
  var_b386134394fe8499 = getanimlength(level.scr_anim["blima"]["blima_infil_alphaexit"]);
  wait 20 + var_b386134394fe8499 - 0.7;
  var_5feb774f6235a752 = "veh8_mil_air_blima_dst";
  var_681e03ef8fd54379 = spawn("script_model", var_2b76d31270ba8d75.origin);
  var_681e03ef8fd54379 setModel(var_5feb774f6235a752);
  var_681e03ef8fd54379.angles = var_2b76d31270ba8d75.angles;
  playFXOnTag(level._effect["infil_heli_explosion"], var_681e03ef8fd54379, "tag_origin");
  earthquake(0.3, 1, var_2b76d31270ba8d75.origin, 30000);
  wait 0.1;
  playFXOnTag(level._effect["infil_heli_crashed"], var_681e03ef8fd54379, "tag_origin");
}

function function_1e2fd113d6f91a8a() {
  level endon("<dev string:x2e4>");
  var_f010e552f292a480 = (0, 1, 0);
  var_58e7b7390381f53b = 128;

  while(true) {
    sphere(self.origin, var_58e7b7390381f53b, var_f010e552f292a480);
    waitframe();
  }
}

function function_a3a5173c39cc676(soundwait, animlength) {
  level endon("game_ended");
  missile_sfx = spawn("script_model", self.origin);
  missile_sfx linkTo(self, "tag_origin");
  soundwait -= 1;

  if(soundwait < 0) {
    soundwait = 0;
  }

  wait soundwait;
  missile_sfx playsoundonmovingent("jup_icbm_launch_fire");
  wait animlength;
  missile_sfx delete();
}

function function_b363558aefabb60a(animlength) {
  level endon("game_ended");
  var_a0cf1b8eab268213 = spawn("script_model", self.origin);
  var_a0cf1b8eab268213 linkTo(self);
  thread function_13a4bb51aa20f4b5(animlength, 0.5);
  level waittill("prematch_done");
  wait 4.5;
  var_a0cf1b8eab268213 playLoopSound("weap_samsite_proj_lp");
  wait 2.2;
  var_a0cf1b8eab268213 stoploopsound("weap_samsite_proj_lp");
  wait 1;
  var_a0cf1b8eab268213 delete();
}

function function_13a4bb51aa20f4b5(animlength, timeoffset) {
  var_6af226f5080f5d2a = spawn("script_model", self.origin);
  var_6af226f5080f5d2a linkTo(self);
  wait animlength - timeoffset;
  var_6af226f5080f5d2a playsoundonmovingent("jup_infil_blima_heli_ext_wm_missile_whoosh");
  wait timeoffset;
  playsoundatpos(self.origin, "rocket_explode");
  playsoundatpos(self.origin, "jup_infil_blima_heli_ext_wm_missile_impact");
  wait 3;
  var_6af226f5080f5d2a delete();
}

function function_daeb63bc80d43e0b() {
  level endon("game_ended");
  self waittill("launching");
  wait 0.3;
  playsoundatpos(self.origin + (-50, 0, 50), "weap_sam_turret_target_lock_beep");
}

function function_81784a440079364d() {
  level endon("game_ended");
  level endon("alertFastStarted");
  scripts\mp\flags::gameflagwait("prematch_done");
  var_f2333bfbdeb72d6 = getEnt("red_alert_tri", "script_noteworthy");
  var_7ab0e3294ef9d307 = getentitylessscriptablearray("red_alert", "script_noteworthy");
  level thread function_b8d8557dbd75e3a7(var_7ab0e3294ef9d307);
  level thread function_d0399482d4036ad4(var_7ab0e3294ef9d307);

  while(true) {
    waitframe();

    if(level.zone.name != "zone_3") {
      continue;
    }

    if(istrue(level.zone.compelete)) {
      break;
    }

    var_29ce077fe30013a4 = 0;

    foreach(player in level.players) {
      if(isalive(player) && player.pers["team"] == game["attackers"] && player istouching(var_f2333bfbdeb72d6)) {
        var_29ce077fe30013a4 = 1;
        break;
      }
    }

    if(var_29ce077fe30013a4) {
      break;
    }
  }

  foreach(redalert in var_7ab0e3294ef9d307) {
    redalert setscriptablepartstate("Alert", "slow");
  }

  thread function_68a6cb3769a5b5f0(var_7ab0e3294ef9d307[0]);
  msg = waittill_any_timeout_1(30, "obj_hack_zone_uploaded");

  if(msg != "obj_hack_zone_uploaded") {
    foreach(redalert in var_7ab0e3294ef9d307) {
      redalert setscriptablepartstate("Alert", "init");
    }
  }
}

function function_b8d8557dbd75e3a7(var_7ab0e3294ef9d307) {
  level endon("game_ended");
  level endon("alertFastStarted");
  level waittill("obj_hack_zone_uploaded");

  foreach(redalert in var_7ab0e3294ef9d307) {
    redalert setscriptablepartstate("Alert", "mid");
  }

  wait 30;

  foreach(redalert in var_7ab0e3294ef9d307) {
    redalert setscriptablepartstate("Alert", "init");
  }
}

function function_d0399482d4036ad4(var_7ab0e3294ef9d307) {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("zone_3" + "_objective_start");
  timelimit = getdvarfloat(@ "hash_1466f43b92459194");

  if(timelimit - 30 > 0) {
    wait timelimit - 30;
  } else {
    return;
  }

  level notify("alertFastStarted");

  foreach(redalert in var_7ab0e3294ef9d307) {
    redalert setscriptablepartstate("Alert", "fast");
  }

  var_1a39b1bef756699c = getStruct("zone3_speaker", "script_noteworthy");
  playsoundatpos(var_1a39b1bef756699c.origin, "jup_icbm_siren");
  wait 10;
  playsoundatpos(var_1a39b1bef756699c.origin, "jup_icbm_siren");
  wait 10;
  playsoundatpos(var_1a39b1bef756699c.origin, "jup_icbm_launch_fire");
  wait 2;
  level thread function_685f21e11f3ea9a0(0.3, 10, "large");
}

function function_68a6cb3769a5b5f0(redalert) {
  level endon("game_ended");

  while(true) {
    var_24de026211ede8e8 = redalert getscriptablepartstate("Alert");

    if(var_24de026211ede8e8 == "fast") {
      playsoundatpos((39919.6, 32059.9, 1090.32), "jup_launchfacility_alarm_lvl_3_dry");
      playsoundatpos((39845.1, 34096.2, 1120.03), "jup_launchfacility_alarm_lvl_3_dry");
      playsoundatpos((37377.1, 34178.1, 1154.44), "jup_launchfacility_alarm_lvl_3_dry");
      playsoundatpos((39449.1, 35610.1, 1120.38), "jup_launchfacility_alarm_lvl_3_dry");
      playsoundatpos((37480.7, 35403.8, 1205.17), "jup_launchfacility_alarm_lvl_3_dry");
      playsoundatpos((37346.6, 32180.4, 1153.13), "jup_launchfacility_alarm_lvl_3_dry");
      playsoundatpos((38415.2, 33812.5, 1171.39), "jup_launchfacility_alarm_lvl_3_wet");
      wait 0.5;
      continue;
    }

    if(var_24de026211ede8e8 == "mid") {
      playsoundatpos((39919.6, 32059.9, 1090.32), "jup_launchfacility_alarm_lvl_2_dry");
      playsoundatpos((39845.1, 34096.2, 1120.03), "jup_launchfacility_alarm_lvl_2_dry");
      playsoundatpos((37377.1, 34178.1, 1154.44), "jup_launchfacility_alarm_lvl_2_dry");
      playsoundatpos((39449.1, 35610.1, 1120.38), "jup_launchfacility_alarm_lvl_2_dry");
      playsoundatpos((37480.7, 35403.8, 1205.17), "jup_launchfacility_alarm_lvl_2_dry");
      playsoundatpos((37346.6, 32180.4, 1153.13), "jup_launchfacility_alarm_lvl_2_dry");
      playsoundatpos((38415.2, 33812.5, 1171.39), "jup_launchfacility_alarm_lvl_2_wet");
      wait 0.5;
      continue;
    }

    if(var_24de026211ede8e8 == "slow") {
      playsoundatpos((39919.6, 32059.9, 1090.32), "jup_launchfacility_alarm_lvl_1_dry");
      playsoundatpos((39845.1, 34096.2, 1120.03), "jup_launchfacility_alarm_lvl_1_dry");
      playsoundatpos((37377.1, 34178.1, 1154.44), "jup_launchfacility_alarm_lvl_1_dry");
      playsoundatpos((39449.1, 35610.1, 1120.38), "jup_launchfacility_alarm_lvl_1_dry");
      playsoundatpos((37480.7, 35403.8, 1205.17), "jup_launchfacility_alarm_lvl_1_dry");
      playsoundatpos((37346.6, 32180.4, 1153.13), "jup_launchfacility_alarm_lvl_1_dry");
      playsoundatpos((38415.2, 33812.5, 1171.39), "jup_launchfacility_alarm_lvl_1_wet");
      wait 1;
      continue;
    }

    wait 1;
  }
}

function function_8a765b135be66467() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("zone_3" + "_objective_start");
  namespace_82f05772526a4798::function_c25a40ae517ef340();
  function_bb5fe40cb68c5d9a();
}

function function_bb5fe40cb68c5d9a() {
  var_f878c4955c12458c = getEntArray("c4_wall", "script_noteworthy");
  var_e62df0718b7dcbca = (0, 0, 0);

  foreach(trigger in var_f878c4955c12458c) {
    visuals = getEntArray(trigger.target, "targetname");

    if(isDefined(visuals[0])) {
      zone3_wall = getentitylessscriptablearray(visuals[0].target, "targetname");
      trigger setuseholdduration("duration_none");
      destructible_wall_zone = scripts\mp\gameobjects::createuseobject(game["attackers"], trigger, visuals, var_e62df0718b7dcbca, 0, 1);
      destructible_wall_zone scripts\mp\gameobjects::requestid(0, 0);
      destructible_wall_zone.origin = visuals[0].origin;
      destructible_wall_zone.angles = visuals[0].angles;
      destructible_wall_zone.wall = zone3_wall[0];
      destructible_wall_zone.var_6b5c5def5715d409 = var_f878c4955c12458c;
      destructible_wall_zone scripts\mp\gameobjects::allowuse("friendly");
      destructible_wall_zone scripts\mp\gameobjects::setusehinttext(&"CP_MISSION_ESC/PLANT_CHARGE");
      destructible_wall_zone.onbeginuse = &function_4b57f9478a34a03e;
      destructible_wall_zone.onenduse = &function_2b31f73315396a96;
      destructible_wall_zone.onuse = &function_a56fa8b6404c0125;
    }
  }
}

function function_4b57f9478a34a03e(player) {
  thread function_71ab78bf1a1cf312(player);
  function_4601ae1cfe7b3a82(player);
}

function function_2b31f73315396a96(team, player, result) {
  var_e1e93ae309da32ae = self.origin;
  dangericonent = player scripts\mp\utility\weapon::_launchgrenade("safe_c4_danger_icon_mp", var_e1e93ae309da32ae, (0, 0, 0), 100, 1);
  dangericonent setModel("tag_origin");
  dangericonent.weapon_object = makeweapon("safe_c4_danger_icon_mp");

  if(istrue(self.var_d8d60361701406)) {
    namespace_82f05772526a4798::function_236a1fe93e41c498(self.c4);
    self.c4 setscriptablepartstate("effects", "explode");
    self.wall setscriptablepartstate("wall", "destructed");
    dangericonent delete();

    foreach(trigger in self.var_6b5c5def5715d409) {
      if(isDefined(trigger)) {
        trigger makeunusable();
      }
    }
  }
}

function function_a56fa8b6404c0125() {
  self.c4 delete();
  scripts\mp\gameobjects::deleteuseobject();
}

function function_4601ae1cfe7b3a82(player) {
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  player endon("interact_interrupt");
  self.var_d8d60361701406 = 0;

  foreach(trigger in self.var_6b5c5def5715d409) {
    if(isDefined(trigger)) {
      trigger makeunusable();
    }
  }

  player playlocalsound("mp_bomb_raise_noise");
  player scripts\mp\bots\bots_util::notify_enemy_bots_bomb_used("plant");
  player notify("super_obj_drain");
  player.isplanting = 1;
  player thread scripts\mp\gametypes\obj_bombzone::startnpcbombusesound("briefcase_bomb_mp", "equip_suitcase_raise_button");
  actorplayer = scripts\cp_mp\anim_scene::anim_scene_create_actor(player, "player_rig_sm", 1);
  c4 = spawn("script_model", actorplayer.entity gettagorigin("tag_accessory_right"));
  self.c4 = c4;
  c4 hide();
  c4.angles = actorplayer.entity gettagangles("tag_accessory_right");
  c4 dontinterpolate();
  c4 linkTo(actorplayer.entity, "tag_accessory_right");

  if(isDefined(level.var_2179c46fc54fd9ce)) {
    c4 setModel(level.var_2179c46fc54fd9ce);
  } else {
    c4 setModel("offhand_2h_c4_prop_cp");
  }

  thread namespace_82f05772526a4798::showc4(c4);
  c4 thread namespace_82f05772526a4798::function_e9508a0db7cc3e83();
  scripts\cp_mp\anim_scene::anim_scene([actorplayer], "samsite_plant_f");
  c4 unlink();

  if(isreallyalive(player)) {
    player notify("interact_finished");
  }

  self.var_d8d60361701406 = 1;
  self.trigger makeunusable();
}

function function_71ab78bf1a1cf312(player) {
  player endon("interact_finished");
  player scripts\engine\utility::waittill_any_3("death_or_disconnect", "enter_live_ragdoll", "last_stand_start");
  player notify("interact_interrupt");

  if(!istrue(self.var_d8d60361701406)) {
    foreach(trigger in self.var_6b5c5def5715d409) {
      if(isDefined(trigger)) {
        trigger makeusable();
      }
    }
  }

  scripts\mp\gameobjects::setusehinttext(&"CP_MISSION_ESC/PLANT_CHARGE");
  player stopanimscriptsceneevent();

  if(isDefined(player.linktoent)) {
    player unlink();
    player.linktoent delete();
    player.linktoent = undefined;
  }

  player notify("remove_rig");
  self.var_d8d60361701406 = 0;
}

function function_685f21e11f3ea9a0(scale, duration, size) {
  level endon("game_ended");
  [var_db5de25308b03fa5] = getscriptablearray("silo_door_" + "zone_1", "script_noteworthy");
  radius = 30000;
  earthquake(scale, duration, var_db5de25308b03fa5.origin, radius);
  level thread function_900644db82e41e5(size);
  level thread function_6a36b0fad02abd53(size);
}

function function_900644db82e41e5(size) {
  level endon("game_ended");
  var_3e2f6048d81569f2 = getentitylessscriptablearray("dust", "script_noteworthy");

  foreach(dust in var_3e2f6048d81569f2) {
    dust setscriptablepartstate("dust", size);
  }
}

function function_6a36b0fad02abd53(size) {
  level endon("game_ended");
  var_1925d61ff3bb598c = getentitylessscriptablearray("steam", "script_noteworthy");

  foreach(steam in var_1925d61ff3bb598c) {
    steam setscriptablepartstate("steam", size);
  }
}

function function_bb058b6844da1142(var_1925d61ff3bb598c, size) {
  foreach(steam in var_1925d61ff3bb598c) {
    if(size == "small") {
      steam playLoopSound("amb_jup_shared_steam_medium_lp");
      continue;
    }

    if(size == "large") {
      steam playLoopSound("amb_jup_shared_steam_large_lp");
      continue;
    }

    return;
  }
}

function function_fad186e07908db0c() {
  level endon("<dev string:x2e4>");

  while(true) {
    number = getdvarint(@ "hash_469dff56ec452d6f", 0);
    setDvar(@ "hash_469dff56ec452d6f", 0);

    if(number > 0 && number <= 2) {
      function_f49914c65896f7ed("<dev string:x2f2>" + number);
    }

    waitframe();
  }
}

# /