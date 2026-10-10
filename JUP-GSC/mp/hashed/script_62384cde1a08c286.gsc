/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_62384cde1a08c286.gsc
*************************************************/

#using script_518ae857a3d351c;
#using script_62384cde1a08c286;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\helper_drone;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\anim;
#using scripts\mp\damage;
#using scripts\mp\equipment\tactical_cover;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\wm_buildable;
#using scripts\mp\utility\outline;
#namespace namespace_db33ab6330bb5189;

function function_28c9bb84699d73b2() {
  isinit = level scripts\mp\gametypes\wm_buildable::function_e2344ec3f70a089c();

  if(istrue(isinit)) {
    function_e5c4e335df2843c();
    function_3a30249a5c64c552();
    function_566826c5ccdd0270();
    function_b4ebcfb94d5a02a6();
    function_d010329c992047c7();
    function_e688c950f545c6dc();
    function_12f730953d7999fd();
    level function_43a60391e95332e();
    level function_714ca74c07bcc71c();
    level function_259b94f62f15b4be();
    level function_503244ee309d918d();
    level._effect["sandbag_built"] = loadfx("vfx/jup/level/mp_jup_launchfacility/vfx_jup_lf_sandbags_debris_02.vfx");
    level._effect["turret_fixed"] = loadfx("vfx/jup/level/mp_jup_launchfacility/vfx_jup_lf_machinegun_repaired_glow.vfx");
  }
}

#using_animtree("animated_props");

function function_566826c5ccdd0270() {
  level.scr_animtree["Hesco"] = #animtree;
  level.scr_anim["Hesco"]["building"] = % jup_fxanim_war_military_buildable_set_cosecho_barrier_open_01;
  level.scr_animname["Hesco"]["building"] = "jup_fxanim_war_military_buildable_set_cosecho_barrier_open_01";
  level.scr_anim["Hesco"]["idle"] = % jup_fxanim_war_military_buildable_set_cosecho_barrier_idle;
  level.scr_animname["Hesco"]["idle"] = "jup_fxanim_war_military_buildable_set_cosecho_barrier_idle";
  level.var_c88bedfa8ddcb42c["Hesco"] = [];
  level.var_c88bedfa8ddcb42c["Hesco"]["models"] = ["jup_military_buildable_cosecho_barrier_02_fxanim"];
  level.var_c88bedfa8ddcb42c["Hesco"]["animations"] = ["Hesco", ["building"], ["idle"]];
}

function function_e688c950f545c6dc() {
  buildinfo = spawnStruct();
  buildinfo.models = level.var_c88bedfa8ddcb42c["Hesco"]["models"];
  buildinfo.animations = level.var_c88bedfa8ddcb42c["Hesco"]["animations"];
  buildinfo.buildusetime = 4;
  buildinfo.gestureweapon = "nothing_here";
  buildinfo.hintstring = &"MP_JUP_WM/BUILD";
  buildinfo.var_32a2681a13f18cb1 = &function_eeb5fae661444ab6;
  buildinfo.var_fc147a62066d05bd = &function_219488eeb71cf8ce;
  buildinfo.var_562da06e56403b2f = &function_f7d3423c552f1596;
  level.buildablepool["bdb_hesco"] = buildinfo;
}

function function_259b94f62f15b4be() {
  ents = getEntArray("tri_build_hesco", "targetname");

  foreach(ent in ents) {
    var_febb042dd9982690 = getStruct(ent.target, "targetname");
    var_c96dc31f024483a8 = getEntArray(var_febb042dd9982690.target, "targetname");

    if(!isDefined(var_febb042dd9982690) || !isDefined(var_c96dc31f024483a8)) {
      continue;
    }

    buildable = scripts\mp\gametypes\wm_buildable::function_e20a97a059fba2ea("bdb_hesco", ent, ent.script_noteworthy, 0, var_febb042dd9982690.origin, var_febb042dd9982690.angles);
    ent.buildable = buildable;
    ent.buildable.clips = var_c96dc31f024483a8;

    foreach(clip in var_c96dc31f024483a8) {
      clip notsolid();

      if(!isDefined(clip.script_parameters)) {
        ent.buildable.clip = clip;
        ent.buildable.clip connectpaths();
        ent.buildable.clip.origin -= (0, 0, 50);
      } else if(clip.script_parameters == "surrounding") {
        clip.origin -= (0, 0, 50);

        if(!isDefined(ent.buildable.surroundingclips)) {
          ent.buildable.surroundingclips = [];
        }

        ent.buildable.surroundingclips[ent.buildable.surroundingclips.size] = clip;
      } else if(clip.script_parameters == "pop_up") {
        ent.buildable.pushingclip = clip;
      }

      clip.moverdoesnotkill = 1;
    }

    if(isDefined(ent.buildable.models[0])) {
      ent.buildable.models[0].outlineid = scripts\mp\utility\outline::outlineenableforall(ent.buildable.models[0], "shimmer_crafting_wm_buildable", "level_script");
    }

    ent useTriggerRequireLookAt(1);
  }
}

function function_eeb5fae661444ab6(player, buildable) {
  pushingdir = 50 * anglestoright(buildable.models[0].angles);
  buildable.pushingclip solid();
  buildable.pushingclip.originpos = buildable.pushingclip.origin;
  buildable.pushingclip moveTo(buildable.pushingclip.origin + pushingdir, 0.2);
  buildable.models[0] function_adc7327a592cc4a1();

  sphere(buildable.pushingclip.origin, 10, undefined, undefined, 10000);

  foreach(clip in buildable.surroundingclips) {
    clip solid();
    clip.originpos = clip.origin;
    clip delaycall(0.2, &movez, 50, 0.2);
  }

  buildable.clip solid();
  buildable.clip.originpos = buildable.clip.origin;
  buildable.clip movez(50, 4);
}

function function_219488eeb71cf8ce(player, buildable) {
  foreach(clip in buildable.clips) {
    clip notsolid();

    if(isDefined(clip.originpos)) {
      clip.origin = clip.originpos;
    }
  }
}

function function_f7d3423c552f1596(player, buildable) {
  ent = buildable.triggerent;

  foreach(clip in buildable.clips) {
    if(isDefined(clip.script_parameters)) {
      clip notsolid();
      clip delete();
      continue;
    }

    clip disconnectPaths();
  }

  if(isDefined(buildable.models[0])) {
    playFX(level._effect["sandbag_built"], buildable.models[0].origin);
  }

  scripts\mp\utility\outline::outlinedisable(buildable.models[0].outlineid, buildable.models[0]);
  buildable.clip function_adc7327a592cc4a1();
}

function function_3a30249a5c64c552() {
  level.scr_animtree["TankTrap"] = #animtree;
  level.scr_anim["TankTrap"]["idle"] = % jup_fxanim_war_military_buildable_hedgehog_idle;
  level.scr_animname["TankTrap"]["idle"] = "jup_fxanim_war_military_buildable_hedgehog_idle";
  level.scr_anim["TankTrap"]["building"] = % jup_fxanim_war_military_buildable_hedgehog_repair;
  level.scr_animname["TankTrap"]["building"] = "jup_fxanim_war_military_buildable_hedgehog_repair";
  level.scr_anim["TankTrap"]["destroy"] = % jup_fxanim_war_military_buildable_hedgehog_destroy;
  level.scr_animname["TankTrap"]["destroy"] = "jup_fxanim_war_military_buildable_hedgehog_destroy";
  level.var_c88bedfa8ddcb42c["TankTrap"] = [];
  level.var_c88bedfa8ddcb42c["TankTrap"]["models"] = ["jup_military_buildable_hedgehog_02_fxanim"];
  level.var_c88bedfa8ddcb42c["TankTrap"]["animations"] = ["TankTrap", ["building"], ["idle"], ["destroy"]];
}

function function_12f730953d7999fd() {
  buildinfo = spawnStruct();
  buildinfo.models = level.var_c88bedfa8ddcb42c["TankTrap"]["models"];
  buildinfo.animations = level.var_c88bedfa8ddcb42c["TankTrap"]["animations"];
  buildinfo.buildusetime = 4;
  buildinfo.hintstring = &"MP_JUP_WM/BUILD";
  buildinfo.gestureweapon = "jup_war_ges_wrench_hedgehog";
  buildinfo.var_32a2681a13f18cb1 = &namespace_555f6ee22fb8fd82::function_14557abb4173c907;
  buildinfo.var_fc147a62066d05bd = &namespace_555f6ee22fb8fd82::function_e6e4ec899d114c59;
  buildinfo.var_562da06e56403b2f = &namespace_555f6ee22fb8fd82::function_18b4ff54f4110b21;
  level.buildablepool["bdb_tankTrap"] = buildinfo;
}

function function_503244ee309d918d() {
  ents = getEntArray("tri_build_tank_trap", "targetname");

  foreach(index, ent in ents) {
    var_1c59cace1457e117 = getStruct(ent.target, "targetname");
    ent.id = index;
    entparts = getEntArray(ent.target, "targetname");

    foreach(part in entparts) {
      if(!isDefined(part.script_noteworthy)) {
        continue;
      }

      if(part.script_noteworthy == "destroy_trigger") {
        ent.destroytrigger = part;
      }
    }

    var_58c4969f9f12ba44 = getEnt(var_1c59cace1457e117.target, "targetname");
    var_58c4969f9f12ba44 notsolid();
    var_58c4969f9f12ba44.origin -= (0, 0, 50);
    var_58c4969f9f12ba44.originalpos = var_58c4969f9f12ba44.origin;
    var_58c4969f9f12ba44.movingdir = anglesToForward(var_1c59cace1457e117.angles);
    c4set = getscriptablearray(ent.target, "targetname");
    buildable = scripts\mp\gametypes\wm_buildable::function_e20a97a059fba2ea("bdb_tankTrap", ent, ent.script_noteworthy, int(ent.script_label), var_1c59cace1457e117.origin, var_1c59cace1457e117.angles);
    ent.buildable = buildable;
    buildable.clip = var_58c4969f9f12ba44;
    buildable.c4 = c4set[0];

    if(isDefined(ent.buildable.models[0])) {
      ent.buildable.models[0].outlineid = scripts\mp\utility\outline::outlineenableforall(ent.buildable.models[0], "shimmer_crafting_wm_buildable", "level_script");
    }

    ent useTriggerRequireLookAt(1);
    ent thread function_17763afd915cc73c();
    buildable thread function_a0f277273d13196a();
  }
}

function function_14557abb4173c907(player, buildable) {
  buildable thread pushingplayer();
}

function pushingplayer() {
  level endon("game_ended");
  self endon("stop_building");
  self notify("start_push");
  self endon("start_push");
  var_58c4969f9f12ba44 = self.clip;
  var_58c4969f9f12ba44 solid();
  var_58c4969f9f12ba44 movez(50, 0.2);
  wait 0.2;
  goalpos = var_58c4969f9f12ba44.origin + var_58c4969f9f12ba44.movingdir * 60;
  var_58c4969f9f12ba44 moveTo(goalpos, 0.2);
  wait 0.2;
  var_58c4969f9f12ba44 notsolid();
  var_58c4969f9f12ba44.origin = var_58c4969f9f12ba44.originalpos;
}

function function_e6e4ec899d114c59(player, buildable) {
  buildable notify("stop_building");
  var_58c4969f9f12ba44 = buildable.clip;
  var_58c4969f9f12ba44 notsolid();
  var_58c4969f9f12ba44.origin = var_58c4969f9f12ba44.originalpos;
}

function function_18b4ff54f4110b21(player, buildable) {
  ent = buildable.triggerent;
  playFX(level._effect["sandbag_built"], buildable.models[0].origin);
  buildable thread function_5907a34f5fb0bf04();
  buildable.clip notsolid();
  buildable.clip.origin = buildable.clip.originalpos;
  buildable.c4 setscriptablepartstate("body", "built");
  buildable.c4.outlineid = scripts\mp\utility\outline::outlineenableforall(buildable.c4, "shimmer_crafting_wm_buildable", "level_script");
  destroyobj = scripts\mp\gametypes\wm_buildable::function_310f1a814bf9c37c(buildable, ent.destroytrigger, &"MP_JUP_LAUNCHFACILITY/REMOVETANKTRAP", 3, undefined, &function_44bc02179cd2ed83);
  setomnvar("ui_wm_escort_trap_" + ent.id, ent.progress);
  buildable thread scripts\mp\gametypes\wm_buildable::function_62602b0ea1741bd2(buildable.models[0], "hogs_destroyed");
}

function function_44bc02179cd2ed83(player) {
  self.buildable notify("trap_destroyed");
  ent = self.buildable.triggerent;
  setomnvar("ui_wm_escort_trap_" + ent.id, 0);
  oldmodel = self.buildable.models[0];

  if(isDefined(oldmodel)) {
    scripts\mp\utility\outline::outlinedisable(oldmodel.outlineid, oldmodel);
  }

  var_2642ca865799c9 = oldmodel.origin;
  var_c617038fddbdb57 = oldmodel.angles;
  newbuildable = scripts\mp\gametypes\wm_buildable::function_e20a97a059fba2ea(self.buildable.name, self.buildable.triggerent, self.buildable.zonename, 0, var_2642ca865799c9, var_c617038fddbdb57);
  ent.buildable = newbuildable;
  newbuildable.clip = self.buildable.clip;
  newmodel = newbuildable.models[0];

  if(isDefined(newmodel)) {
    newmodel.outlineid = scripts\mp\utility\outline::outlineenableforall(newmodel, "shimmer_crafting_wm_buildable", "level_script");
  }

  ent.buildable.c4 = self.buildable.c4;
  ent useTriggerRequireLookAt(1);
  ent thread function_17763afd915cc73c();
  newbuildable thread function_a0f277273d13196a();
}

function function_17763afd915cc73c() {
  self notify("stop_get_progress");
  self endon("stop_get_progress");
  level endon("game_ended");
  pathnodes = getvehiclenodearray("tank_trap_pos", "script_noteworthy");
  pathnode = sortbydistance(pathnodes, self.origin)[0];
  scripts\mp\flags::gameflagwait("tank_trap_ready");
  distsquared = distance2dsquared(self.origin, pathnode.origin);

  if(distsquared > 3000) {
    assertmsg(distsquared + "<dev string:x1c>" + self.origin + "<dev string:x3e>");
    self.buildable.useobj.trigger makeunusable();
  }

  self.progress = pathnode.progress;
}

function function_a0f277273d13196a() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("tank_trap_ready");
  tank = level.escortvehicles[0];

  while(!isDefined(self.triggerent.progress) || !isDefined(tank.progress) || !isDefined(tank.var_56df20c41f5b3159)) {
    waitframe();
  }

  var_31a72e6f2e39b666 = spawn("script_model", self.triggerent.origin);
  var_31a72e6f2e39b666.angles = self.triggerent.angles;
  var_31a72e6f2e39b666 makeusable();
  var_31a72e6f2e39b666 sethintdisplayrange(256);
  var_31a72e6f2e39b666 sethintdisplayfov(360);
  var_31a72e6f2e39b666 setuserange(256);
  var_31a72e6f2e39b666 setusefov(360);
  var_31a72e6f2e39b666 sethintonobstruction("show");
  var_31a72e6f2e39b666 setCursorHint("HINT_NOBUTTON");
  var_31a72e6f2e39b666 setHintString(&"MP/UNABLE_TO_BUILD_TRAP");

  while(self.buildphase == 0) {
    if(abs(self.triggerent.progress - tank.progress) > tank.var_56df20c41f5b3159 * 400) {
      self.useobj.trigger makeusable();

      foreach(player in level.players) {
        var_31a72e6f2e39b666 disableplayeruse(player);
      }
    } else {
      self.useobj.trigger makeunusable();

      foreach(player in level.players) {
        var_31a72e6f2e39b666 enableplayeruse(player);
      }
    }

    waitframe();
  }

  var_31a72e6f2e39b666 delete();
}

function function_5907a34f5fb0bf04() {
  level endon("game_ended");
  self endon("deleted");
  scripts\mp\flags::gameflagwait("tank_trap_ready");
  ref = self.models[0] getentitynumber();

  foreach(vehicle in level.escortvehicles) {
    if(istrue(vehicle.spawndata.var_7a1abd6499827f97)) {
      tank = vehicle;
    }
  }

  while(!isDefined(self.triggerent.progress) || !isDefined(tank.progress) || !isDefined(tank.var_56df20c41f5b3159)) {
    waitframe();
  }

  while(true) {
    if(!istrue(tank.var_7150b8620d62148[ref]) && istrue(function_4671e4cafead83aa(tank.var_56df20c41f5b3159, self.triggerent.progress, tank.progress))) {
      tank.var_7150b8620d62148[ref] = 1;

      if(self.triggerent.progress > tank.progress) {
        tank.directionblocked[ref] = "forward";
      } else {
        tank.directionblocked[ref] = "backward";
      }
    }

    msg = waittill_notify_or_timeout_return("trap_destroyed", 0.2);

    if(msg == "trap_destroyed") {
      tank.var_7150b8620d62148[ref] = 0;
      break;
    }

    if(istrue(tank.var_7150b8620d62148[ref]) && !istrue(function_4671e4cafead83aa(tank.var_56df20c41f5b3159, self.triggerent.progress, tank.progress))) {
      tank.var_7150b8620d62148[ref] = 0;
    }
  }
}

function function_4671e4cafead83aa(var_56df20c41f5b3159, trapprogress, tankprogress) {
  return tankprogress - trapprogress > var_56df20c41f5b3159 * 170 * -1 && tankprogress - trapprogress < var_56df20c41f5b3159 * 210;
}

function function_e5c4e335df2843c() {
  level.scr_animtree["EarthenWall"] = #animtree;
  level.scr_anim["EarthenWall"]["building_1"] = % jup_fxanim_war_military_buildable_wall_repair_half;
  level.scr_animname["EarthenWall"]["building_1"] = "jup_fxanim_war_military_buildable_wall_repair_half";
  level.scr_anim["EarthenWall"]["building_2"] = % jup_fxanim_war_military_buildable_wall_repair_full;
  level.scr_animname["EarthenWall"]["building_2"] = "jup_fxanim_war_military_buildable_wall_repair_full";
  level.scr_anim["EarthenWall"]["idle_1"] = % jup_fxanim_war_military_buildable_wall_idle_half;
  level.scr_animname["EarthenWall"]["idle_1"] = "jup_fxanim_war_military_buildable_wall_idle_half";
  level.scr_anim["EarthenWall"]["idle_2"] = % jup_fxanim_war_military_buildable_wall_idle_full;
  level.scr_animname["EarthenWall"]["idle_2"] = "jup_fxanim_war_military_buildable_wall_idle_full";
  level.var_c88bedfa8ddcb42c["EarthenWall"] = [];
  level.var_c88bedfa8ddcb42c["EarthenWall"]["models"] = ["jup_military_buildable_wall_05_fxanim", "jup_military_buildable_wall_06_fxanim"];
  level.var_c88bedfa8ddcb42c["EarthenWall"]["animations"] = ["EarthenWall", ["building_1", "building_2"], ["idle_1", "idle_2"]];
}

function function_d010329c992047c7() {
  buildinfo = spawnStruct();
  buildinfo.phases = [0, 0.5, 1];
  buildinfo.models = level.var_c88bedfa8ddcb42c["EarthenWall"]["models"];
  buildinfo.animations = level.var_c88bedfa8ddcb42c["EarthenWall"]["animations"];
  buildinfo.buildusetime = 3;
  buildinfo.gestureweapon = "nothing_here";
  buildinfo.hintstring = &"MP_JUP_WM/BUILD";
  buildinfo.var_32a2681a13f18cb1 = &function_4b51ad34a0eb9787;
  buildinfo.var_b3b899b146453c0c = &function_927b512a6d2c5d6d;
  buildinfo.var_562da06e56403b2f = &function_2e4f60aab0b9caa1;
  level.buildablepool["bdb_earthen_wall"] = buildinfo;
}

function function_714ca74c07bcc71c() {
  ents = getEntArray("wm_build_wall", "targetname");

  foreach(ent in ents) {
    scriptorigin = getStruct(ent.target, "targetname");
    buildable = scripts\mp\gametypes\wm_buildable::function_e20a97a059fba2ea("bdb_earthen_wall", ent, ent.script_noteworthy, 0, scriptorigin.origin, scriptorigin.angles);
    fullclip = getEnt(scriptorigin.target, "targetname");
    buildable.fullclip = fullclip;
    halfclip = getEnt(fullclip.target, "targetname");
    buildable.halfclip = halfclip;
    buildable.fullclip.moverdoesnotkill = 1;
    buildable.halfclip.moverdoesnotkill = 1;
    buildable.fullclip connectpaths();
    buildable.halfclip connectpaths();
    buildable.fullclip notsolid();
    buildable.halfclip notsolid();
    buildable.halfclip.origin -= (0, 0, 400);
    buildable.fullclip.origin -= (0, 0, 400);
    buildable.var_aad507fcd3fa7aac = buildable.halfclip.origin;
    buildable.var_1e6b32b3a669c4a4 = buildable.fullclip.origin;
    var_8c093373c4b24c9b = getStructArray(scriptorigin.target, "targetname");

    foreach(node in var_8c093373c4b24c9b) {
      if(node.script_noteworthy == "full_warp_over") {
        buildable.var_25ce1472104e7323 = node;
        continue;
      }

      buildable.var_9add75b4f63984db = node;
    }

    foreach(model in buildable.models) {
      model.outlineid = scripts\mp\utility\outline::outlineenableforall(model, "shimmer_crafting_wm_buildable", "level_script");
    }

    c4set = getscriptablearray(ent.target, "targetname");

    foreach(c4 in c4set) {
      c4 setscriptablepartstate("body", "init");
      positionvec = c4.origin - buildable.models[0].origin;
      var_a12e637c4db09413 = vectordot(positionvec, anglesToForward(buildable.models[0].angles));

      if(var_a12e637c4db09413 > 0) {
        buildable.c4forward = c4;
        continue;
      }

      buildable.c4back = c4;
    }
  }
}

function function_4b51ad34a0eb9787(player, buildable) {
  buildable.models[0] function_adc7327a592cc4a1();
}

function function_927b512a6d2c5d6d(player, buildable, buildphase) {
  if(buildphase == 1) {
    buildable.halfclip solid();
    buildable.halfclip movez(400, 0.2);
    buildable.halfclip delaycall(1, &disconnectpaths);
    endnode = getStruct(buildable.var_9add75b4f63984db.target, "targetname");
    createnavlink("half_wall_warp_over", buildable.var_9add75b4f63984db.origin, endnode.origin, "traverse_warp_over");
    buildable thread function_aee75e15f0b3ace2();
    buildable.halfclip delaythread(0.2, &function_adc7327a592cc4a1);

    if(isDefined(buildable.zonename) && buildable.zonename == level.zone.name) {
      buildable.useobj scripts\mp\gameobjects::setobjectivestatusicons("waypoint_Buildable_Built");
    }
  }
}

function function_aee75e15f0b3ace2() {
  level endon("game_ended");
  self endon("stop_half_watch");
  self.models[0] childthread scripts\mp\gametypes\wm_buildable::function_df66656601b04226();
  self.models[0] waittillmatch("scriptableNotification", "half_wall_destroyed");
  self.halfclip.origin = self.var_aad507fcd3fa7aac;
  self.halfclip connectpaths();
  self.models[0] notsolid();
  self.models[0] connectpaths();
  function_3b27c12823e5dc9();
  self.buildphase = 0;
  self.useobj notify("destroyed_by_splash");
  self.models[0] notify("destroyed");
}

function function_2e4f60aab0b9caa1(player, buildable) {
  buildable notify("stop_half_watch");
  buildable.fullclip solid();
  buildable.fullclip movez(400, 0.2);
  buildable.fullclip delaycall(1, &disconnectpaths);
  buildable.fullclip delaythread(0.2, &function_adc7327a592cc4a1);

  if(level.mapname == "mp_jup_skydiving") {
    buildable delaythread(0.2, &function_2e82354313bdf801);
  }

  buildable.halfclip delaycall(0.2, &moveto, buildable.var_aad507fcd3fa7aac, 0.1);
  buildable.halfclip delaycall(0.2, &notsolid);
  destroynavlink("half_wall_warp_over");

  if(level.buildablepool["bdb_earthen_wall"].canmantle) {
    endnode = getStruct(buildable.var_25ce1472104e7323.target, "targetname");
    createnavlink("full_wall_warp_over", buildable.var_25ce1472104e7323.origin, endnode.origin, "traverse_warp_over");
  }

  var_96d232e2a285463c = getentarrayinradius("huge_deploy_cover_close", "targetname", buildable.triggerent.origin, 100);
  var_96d232e2a285463c = var_96d232e2a285463c[0];
  buildable.c4forward setscriptablepartstate("body", "built");
  buildable.c4forward.outlineid = scripts\mp\utility\outline::outlineenableforall(buildable.c4forward, "shimmer_crafting_wm_buildable", "level_script");
  buildable.c4back setscriptablepartstate("body", "built");
  buildable.c4back.outlineid = scripts\mp\utility\outline::outlineenableforall(buildable.c4back, "shimmer_crafting_wm_buildable", "level_script");

  foreach(model in buildable.models) {
    scripts\mp\utility\outline::outlinedisable(model.outlineid, model);
  }

  destroyobj = scripts\mp\gametypes\wm_buildable::function_310f1a814bf9c37c(buildable, var_96d232e2a285463c, &"MP_JUP_LAUNCHFACILITY/REMOVEWALL", 3, undefined, &function_1e4edfddaf68a61f);
  buildable thread scripts\mp\gametypes\wm_buildable::function_62602b0ea1741bd2(buildable.models[1], "full_wall_destroyed");
}

function function_2e82354313bdf801() {
  level endon("game_ended");
  waitframe();
  var_9bd78a968ebb5620 = self.fullclip.origin;
  movingdir = anglesToForward(self.fullclip.angles);
  frontgoalpos = self.fullclip.origin + movingdir * 30;
  backgoalpos = self.fullclip.origin - movingdir * 30;
  self.fullclip moveTo(frontgoalpos, 0.1);
  wait 0.1;
  self.fullclip moveTo(backgoalpos, 0.1);
  wait 0.1;
  self.fullclip.origin = var_9bd78a968ebb5620;
}

function function_1e4edfddaf68a61f(player) {
  scriptorigin = getStruct(self.buildable.triggerent.target, "targetname");
  buildable = scripts\mp\gametypes\wm_buildable::function_e20a97a059fba2ea(self.buildable.name, self.buildable.triggerent, self.buildable.zonename, 0, scriptorigin.origin, scriptorigin.angles);
  fullclip = getEnt(scriptorigin.target, "targetname");
  buildable.fullclip = fullclip;
  halfclip = getEnt(fullclip.target, "targetname");
  buildable.halfclip = halfclip;
  buildable.fullclip connectpaths();
  buildable.halfclip connectpaths();
  buildable.fullclip notsolid();
  buildable.halfclip notsolid();
  buildable.var_aad507fcd3fa7aac = self.buildable.var_aad507fcd3fa7aac;
  buildable.var_1e6b32b3a669c4a4 = self.buildable.var_1e6b32b3a669c4a4;
  buildable.halfclip.origin = buildable.var_aad507fcd3fa7aac;
  buildable.fullclip.origin = buildable.var_1e6b32b3a669c4a4;

  if(level.buildablepool["bdb_earthen_wall"].canmantle) {
    destroynavlink("full_wall_warp_over");
  }

  buildable.var_9add75b4f63984db = self.buildable.var_9add75b4f63984db;
  buildable.var_25ce1472104e7323 = self.buildable.var_25ce1472104e7323;
  buildable.c4back = self.buildable.c4back;
  buildable.c4forward = self.buildable.c4forward;

  foreach(model in buildable.models) {
    model.outlineid = scripts\mp\utility\outline::outlineenableforall(model, "shimmer_crafting_wm_buildable", "level_script");
  }
}

function function_b4ebcfb94d5a02a6() {
  buildinfo = spawnStruct();
  buildinfo.buildusetime = 4;
  buildinfo.hintstring = &"MP_JUP_WM/REPAIR";
  buildinfo.gestureweapon = "jup_war_ges_wrench_turret";
  buildinfo.var_32a2681a13f18cb1 = &function_4009bbde647f8862;
  buildinfo.var_fc147a62066d05bd = &function_8735b98397aaf042;
  buildinfo.var_562da06e56403b2f = &function_723905cbc30e0b0a;
  level.buildablepool["bdb_turret"] = buildinfo;
}

function function_43a60391e95332e() {
  ents = getEntArray("tri_build_turret", "targetname");

  foreach(ent in ents) {
    turretstruct = getStruct(ent.target, "targetname");
    ent.buildable = scripts\mp\gametypes\wm_buildable::function_e20a97a059fba2ea("bdb_turret", ent, ent.script_noteworthy, 0, turretstruct.origin, turretstruct.angles);
    var_ade9e61eec747ec0 = function_68c608676c867d5e(turretstruct.origin, turretstruct.angles);
    ent.buildable.turret = var_ade9e61eec747ec0;
    ent.buildable thread function_c01e8dd2223036f6();
    ent.buildable.turret.maxhealth = 500;
    ent.buildable.turret setdefaultdroppitch(15);
    ent.buildable.turret thread function_eefc4642e9cfa7d2();
    ent.buildable.turret.scriptable = spawnscriptable("jup_launchfacility_buildable_turret", turretstruct.origin);
    var_ade9e61eec747ec0.outlineid = scripts\mp\utility\outline::outlineenableforall(var_ade9e61eec747ec0, "shimmer_crafting_wm_buildable", "level_script");
  }
}

function function_4009bbde647f8862(player, buildable) {
  scripts\mp\utility\outline::outlinedisable(buildable.turret.outlineid, buildable.turret);
  buildable.turret.outlineid = undefined;
}

function function_8735b98397aaf042(player, buildable) {
  buildable.turret.outlineid = scripts\mp\utility\outline::outlineenableforall(buildable.turret, "shimmer_crafting_wm_buildable", "level_script");
}

function function_723905cbc30e0b0a(player, buildable) {
  if(!isDefined(buildable.turret)) {
    return;
  }

  buildable.turret.outlineid = scripts\mp\utility\outline::outlineenableforall(buildable.turret, "shimmer_crafting_wm_buildable", "level_script");
  buildable.turret notify("turret_fixed");
  buildable.turret setdefaultdroppitch(0);
  buildable.turret setscriptablepartstate("shutdown", "off");
  buildable.turret.scriptable setscriptablepartstate("sfx", "completed");
  playFX(getfx("turret_fixed"), buildable.turret.origin);
  hinttag = "j_trigger";
  hintpos = buildable.turret gettagorigin(hinttag);
  var_7deb77726dd22a5a = 251;
  buildable.turret.useobj = scripts\mp\gameobjects::createhintobject(hintpos, "HINT_BUTTON", "hud_icon_turret", &"MP/USE_TURRET", undefined, var_7deb77726dd22a5a, undefined, undefined, undefined, 50);
  buildable.turret.useobj linkTo(buildable.turret, hinttag);
  buildable.turret thread function_5da085c617056ddf();
  player thread function_504539b63a8d23fb(buildable.turret);
  buildable.turret.maxhealth = 1650;
}

function function_eefc4642e9cfa7d2() {
  level endon("game_ended");
  self endon("turret_fixed");
  self endon("kill_turret");

  while(true) {
    self setscriptablepartstate("shutdown", "on");
    self playSound("jup_machine_gun_smoke");
    wait 2;
    self setscriptablepartstate("shutdown", "off");
    wait 1;
  }
}

function function_c01e8dd2223036f6() {
  level endon("game_ended");
  self.turret waittill("kill_turret");
  scripts\mp\gametypes\wm_buildable::function_7c1c6aa025f65e28();
}

function function_68c608676c867d5e(origin, angles) {
  turret = spawnturret("misc_turret", origin, "manual_turret_jup_mp", 0);
  turret.ammocount = 120;
  turret.health = 9999;
  turret.maxhealth = 1650;
  turret.team = "neutral";
  turret.angles = angles;
  turret setModel("weapon_wm_mg_mobile_turret");
  turret makeunusable();
  turret setmode("sentry_offline");
  turret setsentryowner(undefined);
  turret setdefaultdroppitch(0);
  turret setturretmodechangewait(1);
  turret setnodeploy(1);
  turret thread function_488548e8c88863f6();
  turret thread scripts\mp\damage::monitordamage(turret.maxhealth, "hitequip", &function_3098fc5fbbf03d1a, &function_97dac16042181936, 0);
  turret scripts\cp_mp\emp_debuff::allow_emp(0);
  turret.colmodel = spawn("script_model", turret.origin);
  turret.colmodel setModel("weapon_vm_mg_sentry_turret_invis_base");
  turret.colmodel dontinterpolate();
  turret.colmodel.moverdoesnotkill = 1;
  turret.colmodel.turretparent = turret;
  turret.colmodel.angles = turret.angles;
  turret.colmodel.origin = turret.origin;
  turret.colmodel linkTo(turret, "tag_aim_pivot");
  return turret;
}

function function_5da085c617056ddf() {
  level endon("game_ended");
  self endon("kill_turret");

  while(true) {
    if(!isDefined(self.useobj)) {
      break;
    }

    self.useobj waittill("trigger", player);

    if(!isalive(player) || istrue(self.inuse)) {
      continue;
    }

    self.inuse = 1;
    scripts\mp\utility\outline::outlinedisable(self.outlineid, self);
    player scripts\cp_mp\utility\weapon_utility::saveweaponstates();
    player scripts\cp_mp\utility\inventory_utility::_giveweapon("manual_turret_jup_mp", undefined, undefined, 1);
    result = player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch("manual_turret_jup_mp", 1, 0, 1);

    if(distance2d(self.useobj.origin, player.origin) > 50) {
      result = 0;
    }

    if(!istrue(result)) {
      self.inuse = undefined;

      if(isDefined(player)) {
        if(isalive(player)) {
          lastweaponobj = player scripts\cp_mp\utility\weapon_utility::restoreweaponstates(player.lastdroppableweaponobj, 1);
          player switchtoweaponimmediate(lastweaponobj);
        }

        player _takeweapon("manual_turret_jup_mp");
      }

      continue;
    }

    self setmode("manual");
    player controlturreton(self);
    self.owner = player;
    self.team = player.team;
    self.colmodel.owner = self.owner;
    self.colmodel.team = self.team;
    function_b051576de9e5c175(player);
    thread function_7aa3cf0550137f02(player);
    thread function_a37b6ca7eb2d6e8c(player);
    thread function_1fb0cef396256648(player);

    if(isDefined(self.useobj)) {
      foreach(useplayer in level.players) {
        self.useobj disableplayeruse(useplayer);
      }
    }
  }
}

function function_504539b63a8d23fb(turret) {
  level endon("game_ended");
  turret endon("kill_turret");

  while(true) {
    waittill_any_3("killstreakActionCalled", "super_started", "assaultDroneCalled");
    val::set("bdb_turret", "usability", 0);
    wait 2;
    val::reset("bdb_turret", "usability");
  }
}

function function_b051576de9e5c175(player) {
  player scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("manual_turret", "on");
  player setclientomnvar("ui_killstreak_countdown", 0);
  player setclientomnvar("ui_mobile_turret_controls", 1);
  player setclientomnvar("ui_killstreak_weapon_1_ammo", self.ammocount);
}

function function_68e5a6da697b6ff(player) {
  player scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak("manual_turret", "off");
  player setclientomnvar("ui_mobile_turret_controls", 0);
}

function function_7aa3cf0550137f02(player) {
  level endon("game_ended");
  self endon("kill_turret");
  player endon("end_turret_use");
  player endon("disconnect");
  player endon("death");
  self.hideammoindex = 1;
  var_83fb464c27e79a0e = weaponfiretime("manual_turret_jup_mp");
  assertex(isDefined(var_83fb464c27e79a0e) && var_83fb464c27e79a0e > 0, "<dev string:xac>");

  while(player isusingturret()) {
    while(player attackButtonPressed()) {
      self.ammocount--;
      player setclientomnvar("ui_killstreak_weapon_1_ammo", self.ammocount);

      if(self.ammocount <= 12) {
        self setscriptablepartstate("hide_ammo_" + self.hideammoindex, "on", 0);
        self.hideammoindex++;
      }

      if(self.ammocount <= 0) {
        self notify("kill_turret");
        break;
      }

      wait var_83fb464c27e79a0e;
    }

    waitframe();
  }
}

function function_88a41bba2ebcecdc(player) {
  self.inuse = undefined;
  self.owner = undefined;
  self.team = "neutral";
  self.colmodel.owner = self.owner;
  self.colmodel.team = self.team;
  self setmode("sentry_offline");

  if(isDefined(self.useobj)) {
    foreach(useplayer in level.players) {
      self.useobj enableplayeruse(useplayer);
    }
  }

  self.outlineid = scripts\mp\utility\outline::outlineenableforall(self, "shimmer_crafting_wm_buildable", "level_script");

  if(isDefined(player)) {
    player controlturretoff(self);
    function_68e5a6da697b6ff(player);

    if(isalive(player)) {
      lastweaponobj = player scripts\cp_mp\utility\weapon_utility::restoreweaponstates(player.lastdroppableweaponobj, 1);
      player switchtoweaponimmediate(lastweaponobj);
      player setplayerangles(self.lastuserangles);
    }

    player _takeweapon("manual_turret_jup_mp");
    player notify("end_turret_use");
  }
}

function function_a37b6ca7eb2d6e8c(player) {
  level endon("game_ended");
  self endon("kill_turret");
  player endon("disconnect");
  player endon("end_turret_use");

  while(player useButtonPressed()) {
    waitframe();
  }

  while(true) {
    if(player useButtonPressed() || player isinexecutionvictim()) {
      function_88a41bba2ebcecdc(player);
      break;
    }

    self.lastuserangles = player getplayerangles();
    waitframe();
  }
}

function function_1fb0cef396256648(player) {
  level endon("game_ended");
  self endon("kill_turret");
  player endon("end_turret_use");
  player waittill_any_3("death_or_disconnect", "last_stand_start", "death");
  function_88a41bba2ebcecdc(player);
}

function function_97dac16042181936(data) {
  modifieddamage = data.damage;
  return modifieddamage;
}

function function_3098fc5fbbf03d1a(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  explosivedamage = 0;

  if(type == "MOD_EXPLOSIVE" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH" || type == "MOD_GRENADE_SPLASH") {
    explosivedamage = 1;
  }

  self notify("kill_turret", explosivedamage, attacker);
}

function function_488548e8c88863f6() {
  level endon("game_ended");
  self waittill("kill_turret", skipshutdown, killer);
  function_88a41bba2ebcecdc(self.owner);

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  if(!istrue(skipshutdown)) {
    self playSound("jup_machine_gun_smoke");
    self setscriptablepartstate("shutdown", "on");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
    self setscriptablepartstate("explode", "regular");
  } else {
    self setscriptablepartstate("explode", "violent");
  }

  self playSound("jup_machine_gun_explode");

  if(isDefined(killer)) {
    if(isDefined(killer.owner) && isPlayer(killer.owner)) {
      killer = killer.owner;
    }

    killer function_2591bed1172e3c08(0);
  }

  self.colmodel delete();
  wait 0.2;
  self delete();
}

function function_61359962e417f21() {
  level.scr_animtree["Baffle"] = #animtree;
  level.scr_anim["Baffle"]["idle"] = % jup_fxanim_war_military_buildable_security_bollards_idle;
  level.scr_animname["Baffle"]["idle"] = "jup_fxanim_war_military_buildable_security_bollards_idle";
  level.scr_anim["Baffle"]["building"] = % jup_fxanim_war_military_buildable_security_bollards_repair;
  level.scr_animname["Baffle"]["building"] = "jup_fxanim_war_military_buildable_security_bollards_repair";
  level.scr_anim["Baffle"]["destroy"] = % jup_fxanim_war_military_buildable_security_bollards_destroy;
  level.scr_animname["Baffle"]["destroy"] = "jup_fxanim_war_military_buildable_security_bollards_destroy";
  level.var_c88bedfa8ddcb42c["Baffle"] = [];
  level.var_c88bedfa8ddcb42c["Baffle"]["models"] = ["jup_military_security_bollards_fxanim"];
  level.var_c88bedfa8ddcb42c["Baffle"]["animations"] = ["Baffle", ["building"], ["idle"], ["destroy"]];
}

function function_a622792cc81eaea2() {
  buildinfo = spawnStruct();
  buildinfo.models = level.var_c88bedfa8ddcb42c["Baffle"]["models"];
  buildinfo.animations = level.var_c88bedfa8ddcb42c["Baffle"]["animations"];
  buildinfo.buildusetime = 4;
  buildinfo.hintstring = &"MP_JUP_WM/BUILD";
  buildinfo.gestureweapon = "jup_war_ges_wrench_bollard";
  buildinfo.var_32a2681a13f18cb1 = &namespace_555f6ee22fb8fd82::function_2cd909ef45d6629a;
  buildinfo.var_fc147a62066d05bd = &namespace_555f6ee22fb8fd82::function_736d94f76d0d49a;
  buildinfo.var_562da06e56403b2f = &namespace_555f6ee22fb8fd82::function_8da7f2ee4b0a5572;
  level.buildablepool["bdb_Baffle"] = buildinfo;
}

function function_51311df691f23540() {
  ents = getEntArray("tri_build_tank_trap", "targetname");

  foreach(index, ent in ents) {
    var_1c59cace1457e117 = getStruct(ent.target, "targetname");
    buildable = scripts\mp\gametypes\wm_buildable::function_e20a97a059fba2ea("bdb_Baffle", ent, ent.script_noteworthy, 0, var_1c59cace1457e117.origin, var_1c59cace1457e117.angles);
    ent.buildable = buildable;
    ent.id = index;

    if(isDefined(ent.buildable.models[0])) {
      ent.buildable.models[0].outlineid = scripts\mp\utility\outline::outlineenableforall(ent.buildable.models[0], "shimmer_crafting_wm_buildable", "level_script");
    }

    var_58c4969f9f12ba44 = getEnt(var_1c59cace1457e117.target, "targetname");
    var_58c4969f9f12ba44.var_7a64011f0deec917 = var_58c4969f9f12ba44.origin;
    var_58c4969f9f12ba44 connectpaths();
    var_58c4969f9f12ba44 notsolid();
    var_58c4969f9f12ba44.origin -= (0, 0, 50);
    var_58c4969f9f12ba44.originalpos = var_58c4969f9f12ba44.origin;
    buildable.clip = var_58c4969f9f12ba44;
    entparts = getEntArray(ent.target, "targetname");

    foreach(part in entparts) {
      if(!isDefined(part.script_noteworthy)) {
        continue;
      }

      if(part.script_noteworthy == "destroy_trigger") {
        ent.destroytrigger = part;
      }
    }

    c4set = getscriptablearray(ent.target, "targetname");

    foreach(c4 in c4set) {
      c4 setscriptablepartstate("body", "init");
      positionvec = c4.origin - buildable.models[0].origin;
      var_a12e637c4db09413 = vectordot(positionvec, anglesToForward(buildable.models[0].angles));

      if(var_a12e637c4db09413 > 0) {
        buildable.c4forward = c4;
        continue;
      }

      buildable.c4back = c4;
    }

    var_8c093373c4b24c9b = getStructArray(var_58c4969f9f12ba44.target, "targetname");

    foreach(node in var_8c093373c4b24c9b) {
      if(node.script_noteworthy == "forward") {
        buildable.var_27d08fc3c69c0059 = node;
        continue;
      }

      buildable.var_e336e2182bf34119 = node;
    }

    ent useTriggerRequireLookAt(1);
    ent thread function_380b6579f5fa4cd();
    buildable thread function_819c53825b132b02("zone_2");
  }
}

function function_d1a514fda655e409() {
  ents = getEntArray("tri_build_tank_trap", "targetname");

  foreach(ent in ents) {
    var_1c59cace1457e117 = getStruct(ent.target, "targetname");
    var_58c4969f9f12ba44 = getEnt(var_1c59cace1457e117.target, "targetname");
    var_58c4969f9f12ba44 notsolid();
    var_58c4969f9f12ba44 connectpaths();
  }
}

function function_2cd909ef45d6629a(player, buildable) {
  buildable thread function_3f4db4dc27eadcb0(player);
  buildable.models[0] function_adc7327a592cc4a1();
}

function function_3f4db4dc27eadcb0(player) {
  level endon("game_ended");
  self endon("stop_building");
  self notify("start_push");
  self endon("start_push");
  var_58c4969f9f12ba44 = self.clip;
  var_b7e0e91fb38920df = var_58c4969f9f12ba44.originalpos + (0, 0, 50);
  var_58c4969f9f12ba44 solid();
  var_58c4969f9f12ba44 movez(40, 0.2);
  positionvec = player.origin - self.models[0].origin;
  var_5f6cefedf599151 = vectordot(positionvec, anglesToForward(self.models[0].angles));

  if(var_5f6cefedf599151 > 0) {
    pushgoal = self.models[0].origin + anglesToForward(self.models[0].angles) * 10;
  } else {
    pushgoal = self.models[0].origin - anglesToForward(self.models[0].angles) * 10;
  }

  var_58c4969f9f12ba44 function_ad9433aab9fcdf04(0.2, "stop_building", &moveto, pushgoal, 0.2);
  var_58c4969f9f12ba44 function_ad9433aab9fcdf04(0.4, "stop_building", &movez, 10, 0.1);
  var_58c4969f9f12ba44 function_ad9433aab9fcdf04(0.5, "stop_building", &moveto, var_b7e0e91fb38920df, 0.2);
}

function function_736d94f76d0d49a(player, buildable) {
  buildable notify("stop_building");
  var_58c4969f9f12ba44 = buildable.clip;
  var_58c4969f9f12ba44 notify("stop_building");
  var_58c4969f9f12ba44 notsolid();
  var_58c4969f9f12ba44.origin = var_58c4969f9f12ba44.originalpos;
}

function function_8da7f2ee4b0a5572(player, buildable) {
  ent = buildable.triggerent;
  playFX(level._effect["sandbag_built"], buildable.models[0].origin);
  buildable thread function_9017bcad2eca0813("zone_2");
  buildable.clip disconnectPaths();
  buildable.clip function_adc7327a592cc4a1();
  buildable.c4forward setscriptablepartstate("body", "built");
  buildable.c4forward.outlineid = scripts\mp\utility\outline::outlineenableforall(buildable.c4forward, "shimmer_crafting_wm_buildable", "level_script");
  buildable.c4back setscriptablepartstate("body", "built");
  buildable.c4back.outlineid = scripts\mp\utility\outline::outlineenableforall(buildable.c4back, "shimmer_crafting_wm_buildable", "level_script");
  forwardendnode = getStruct(buildable.var_27d08fc3c69c0059.target, "targetname");
  backendnode = getStruct(buildable.var_e336e2182bf34119.target, "targetname");
  createnavlink("baffle_forward_warp_over", buildable.var_27d08fc3c69c0059.origin, forwardendnode.origin, "traverse_warp_over");
  createnavlink("baffle_back_warp_over", buildable.var_e336e2182bf34119.origin, backendnode.origin, "traverse_warp_over");
  destroyobj = scripts\mp\gametypes\wm_buildable::function_310f1a814bf9c37c(buildable, ent.destroytrigger, &"MP_JUP_LAUNCHFACILITY/REMOVETANKTRAP", 3, undefined, &function_acb62a89095ed874);
  setomnvar("ui_wm_escort_trap_" + ent.id, ent.progress);
  buildable thread scripts\mp\gametypes\wm_buildable::function_62602b0ea1741bd2(buildable.models[0], "hogs_destroyed");
}

function function_acb62a89095ed874(player) {
  self.buildable notify("trap_destroyed");
  ent = self.buildable.triggerent;
  setomnvar("ui_wm_escort_trap_" + ent.id, 0);
  oldmodel = self.buildable.models[0];

  if(isDefined(oldmodel)) {
    scripts\mp\utility\outline::outlinedisable(oldmodel.outlineid, oldmodel);
  }

  var_2642ca865799c9 = oldmodel.origin;
  var_c617038fddbdb57 = oldmodel.angles;
  newbuildable = scripts\mp\gametypes\wm_buildable::function_e20a97a059fba2ea(self.buildable.name, self.buildable.triggerent, self.buildable.zonename, 0, var_2642ca865799c9, var_c617038fddbdb57);
  ent.buildable = newbuildable;
  newbuildable.clip = self.buildable.clip;
  newmodel = newbuildable.models[0];

  if(isDefined(newmodel)) {
    newmodel.outlineid = scripts\mp\utility\outline::outlineenableforall(newmodel, "shimmer_crafting_wm_buildable", "level_script");
  }

  ent.buildable.c4back = self.buildable.c4back;
  ent.buildable.c4forward = self.buildable.c4forward;
  destroynavlink("baffle_forward_warp_over");
  destroynavlink("baffle_back_warp_over");
  ent.buildable.var_27d08fc3c69c0059 = self.buildable.var_27d08fc3c69c0059;
  ent.buildable.var_e336e2182bf34119 = self.buildable.var_e336e2182bf34119;
  ent.buildable.clip connectpaths();
  ent.buildable.clip notsolid();
  ent.buildable.clip movez(-50, 0.2);
  ent useTriggerRequireLookAt(1);
  ent thread function_380b6579f5fa4cd();
  newbuildable thread function_819c53825b132b02("zone_2");
}

function function_380b6579f5fa4cd() {
  self notify("stop_get_progress");
  self endon("stop_get_progress");
  level endon("game_ended");
  pathnodes = getvehiclenodearray("tank_trap_pos", "script_noteworthy");
  pathnode = sortbydistance(pathnodes, self.origin)[0];
  scripts\mp\flags::gameflagwait("zone_2" + "_objective_start");
  distsquared = distance2dsquared(self.origin, pathnode.origin);

  if(distsquared > 3000) {
    assertmsg(distsquared + "<dev string:x1c>" + self.origin + "<dev string:x3e>");
    self.buildable.useobj.trigger makeunusable();
  }

  self.progress = pathnode.progress;
}

function function_819c53825b132b02(zoneinfo) {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait(zoneinfo + "_objective_start");
  tank = level.escortvehicles[0];

  while(!isDefined(self.triggerent.progress) || !isDefined(tank.progress) || !isDefined(tank.var_56df20c41f5b3159)) {
    waitframe();
  }

  var_31a72e6f2e39b666 = spawn("script_model", self.triggerent.origin);
  var_31a72e6f2e39b666.angles = self.triggerent.angles;
  var_31a72e6f2e39b666 makeusable();
  var_31a72e6f2e39b666 sethintdisplayrange(128);
  var_31a72e6f2e39b666 sethintdisplayfov(360);
  var_31a72e6f2e39b666 setuserange(128);
  var_31a72e6f2e39b666 setusefov(360);
  var_31a72e6f2e39b666 sethintonobstruction("show");
  var_31a72e6f2e39b666 setCursorHint("HINT_NOBUTTON");
  var_31a72e6f2e39b666 setHintString(&"MP_JUP_WM/UNABLE_TO_BUILD_BAFFLE");

  while(self.buildphase == 0 && isDefined(tank)) {
    if(abs(self.triggerent.progress - tank.progress) > tank.var_56df20c41f5b3159 * 200) {
      self.useobj.trigger makeusable();

      foreach(player in level.players) {
        var_31a72e6f2e39b666 disableplayeruse(player);
      }
    } else {
      self.useobj.trigger makeunusable();

      foreach(player in level.players) {
        var_31a72e6f2e39b666 enableplayeruse(player);
      }
    }

    waitframe();
  }

  var_31a72e6f2e39b666 delete();
}

function function_9017bcad2eca0813(zoneinfo) {
  level endon("game_ended");
  self endon("deleted");
  scripts\mp\flags::gameflagwait(zoneinfo + "_objective_start");
  ref = self.models[0] getentitynumber();
  tank = level.escortvehicles[0];

  while(!isDefined(self.triggerent.progress) || !isDefined(tank.progress) || !isDefined(tank.var_56df20c41f5b3159)) {
    waitframe();
  }

  while(true) {
    if(!istrue(tank.var_7150b8620d62148[ref]) && istrue(function_a8fd08ad364df689(tank.var_56df20c41f5b3159, self.triggerent.progress, tank.progress))) {
      tank.var_7150b8620d62148[ref] = 1;

      if(self.triggerent.progress > tank.progress) {
        tank.directionblocked[ref] = "forward";
      } else {
        tank.directionblocked[ref] = "backward";
      }
    }

    msg = waittill_notify_or_timeout_return("trap_destroyed", level.framedurationseconds);

    if(msg == "trap_destroyed") {
      tank.var_7150b8620d62148[ref] = 0;
      break;
    }

    if(istrue(tank.var_7150b8620d62148[ref]) && !istrue(function_a8fd08ad364df689(tank.var_56df20c41f5b3159, self.triggerent.progress, tank.progress))) {
      tank.var_7150b8620d62148[ref] = 0;
    }
  }
}

function function_a8fd08ad364df689(var_56df20c41f5b3159, trapprogress, tankprogress) {
  return tankprogress - trapprogress > var_56df20c41f5b3159 * 45 * -1 && tankprogress - trapprogress < var_56df20c41f5b3159 * 90;
}

function function_4f6fdee5d536dbc6() {
  buildinfo = spawnStruct();
  buildinfo.buildusetime = 2.5;
  buildinfo.hintstring = &"MP_JUP_WM/BUILD";
  buildinfo.gestureweapon = "jup_war_ges_wrench_turret";
  buildinfo.var_32a2681a13f18cb1 = &function_ccfeb6ffd88791c0;
  buildinfo.var_fc147a62066d05bd = &function_2f7f31fd23d0f3b4;
  buildinfo.var_562da06e56403b2f = &function_d75c2c4738e6ea9c;
  level.buildablepool["bdb_laser_trap"] = buildinfo;
}

function function_60897351370d2636() {
  scripts\engine\utility::registersharedfunc("lasertrap", "customDefuseScoreEventFunc", &function_1f4f0653f2db0e27);
  scripts\engine\scriptable::scriptable_addnotifycallback("wm_laser_trap_c4_disabled", &function_1e9f18ce193adc1b);
  ents = getEntArray("tri_build_laser", "targetname");

  foreach(ent in ents) {
    c4struct = getStruct(ent.target, "targetname");
    emitterstruct = getStruct(c4struct.target, "targetname");

    if(isDefined(c4struct.script_index)) {
      c4struct.script_index = string(c4struct.script_index);
    }

    var_8aafe272251dbaea = spawn_model("", emitterstruct.origin, emitterstruct.angles);
    ent.emitter = var_8aafe272251dbaea;
    ent.emitterstruct = emitterstruct;
    ent.emitterstruct.script_groupname = "nomove";
    ent.c4struct = c4struct;
    [controlpanel] = getentitylessscriptablearray(c4struct.target + "_panel", "script_noteworthy");
    ent.controlpanel = controlpanel;

    if(isDefined(ent.script_noteworthy) && ent.script_noteworthy == "built") {
      ent.buildable = scripts\mp\gametypes\wm_buildable::function_e20a97a059fba2ea("bdb_laser_trap", ent, ent.script_noteworthy, 1, emitterstruct.origin, emitterstruct.angles);
    } else {
      ent.buildable = scripts\mp\gametypes\wm_buildable::function_e20a97a059fba2ea("bdb_laser_trap", ent, ent.script_noteworthy, 0, emitterstruct.origin, emitterstruct.angles);
      ent.controlpanel function_3677f2be30fdd581("model", "visible_with_outline");
      ent.buildable.triggerent playLoopSound("jup_skydiving_laser_trap_idle");
    }

    ent.buildable.useobj.trigger setusefov(360);
    ent.buildable.useobj.trigger sethintdisplayfov(360);
  }
}

function function_ccfeb6ffd88791c0(player, buildable) {
  if(player.team == "allies") {
    buildable.gestureweapon = "jup_war_ges_phone_laser";
    buildable.triggerent.controlpanel function_3677f2be30fdd581("screen", "building_0");
  } else if(player.team == "axis") {
    buildable.gestureweapon = "nothing_here";
    buildable.triggerent.controlpanel function_3677f2be30fdd581("screen", "building_defender_0");
  }

  buildable.triggerent.controlpanel function_3677f2be30fdd581("model", "visible");
  buildable.triggerent playLoopSound("jup_skydiving_laser_building");
}

function function_2f7f31fd23d0f3b4(player, buildable) {
  buildable.triggerent.controlpanel function_3677f2be30fdd581("model", "visible_with_outline");
  buildable.triggerent.controlpanel function_3677f2be30fdd581("screen", "init");
  buildable.triggerent stoploopsound();
  wait 1;
  buildable.triggerent playLoopSound("jup_skydiving_laser_trap_idle");
}

function function_d75c2c4738e6ea9c(player, buildable) {
  var_3a84039ec9a5370a = player.pers["team"];
  buildable.triggerent.emitter notify("emitter_fixed");
  buildable.triggerent.c4struct.turrets[0] = namespace_66ade5cda10fe3aa::setup_sentry(buildable.triggerent.emitterstruct, var_3a84039ec9a5370a, undefined, undefined, buildable.triggerent.c4struct, "laser_trap_skydiving");
  level thread namespace_66ade5cda10fe3aa::function_2cc59ea2a67bd2f4(buildable.triggerent.c4struct, buildable.triggerent.c4struct.turrets, "jup_skydiving_laser_trap_c4", player);
  buildable.triggerent.c4struct.parentent = buildable.triggerent;
  buildable.triggerent.controlpanel function_3677f2be30fdd581("screen", "built");
  buildable.triggerent stoploopsound();
  buildable.triggerent playSound("jup_skydiving_laser_armed");
  buildable.triggerent.headiconid = buildable.triggerent scripts\cp_mp\entityheadicons::setheadicon_singleimage(var_3a84039ec9a5370a, "hud_icon_head_equipment_friendly", 10, undefined, undefined, undefined, undefined, undefined, undefined, buildable.triggerent.controlpanel.origin);
}

function function_1f4f0653f2db0e27(player) {
  player scripts\mp\gametypes\wm_buildable::function_2591bed1172e3c08(0);
}

function function_1e9f18ce193adc1b(instance, strnote, params, var_535d9c3fdddab5a9) {
  assertex(isDefined(instance.parent_struct), "<dev string:x118>");
  assertex(isDefined(instance.parent_struct.parentent), "<dev string:x12f>");
  c4struct = instance.parent_struct;

  if(isDefined(c4struct) && isDefined(c4struct.parentent)) {
    setheadicon_deleteicon(c4struct.parentent.headiconid);
    c4struct.parentent.headiconid = undefined;
  }
}

function function_7d79e0a416280c35() {
  level endon("game_ended");
  self endon("touch_player");

  while(true) {
    foreach(player in level.players) {
      if(player istouching(self)) {
        self hide();
        self notify("touch_player");
      }
    }

    waitframe();
  }
}

function function_adc7327a592cc4a1() {
  var_29c5e5c42368a131 = self physics_getentityaabb();
  itemcontents = physics_createcontents(["physicscontents_item", "physicscontents_vehicle"]);
  var_646389193279e8ec = [self];
  var_f3f22330151d410a = physics_aabbbroadphasequery(var_29c5e5c42368a131["min"], var_29c5e5c42368a131["max"], itemcontents, var_646389193279e8ec);

  foreach(ent in var_f3f22330151d410a) {
    if(isDefined(ent.equipmentref) && ent.equipmentref == "equip_tac_cover" && !istrue(ent.beingdestroyed)) {
      ent.beingdestroyed = 1;
      ent thread scripts\mp\equipment\tactical_cover::tac_cover_destroy(undefined, 0);
      continue;
    }

    if(isDefined(ent.vehiclename) && ent.vehiclename == "radar_drone_recon" && !istrue(ent.beingdestroyed)) {
      ent.beingdestroyed = 1;
      ent thread scripts\cp_mp\killstreaks\helper_drone::function_6edfda4764129e3(1);
    }
  }
}

function function_a6f990dd811a998c() {
  level.var_c88bedfa8ddcb42c["Bridge"] = [];
  level.var_c88bedfa8ddcb42c["Bridge"]["models"] = ["electrical_box_small_02", "electrical_box_small_02", "electrical_box_small_02", "electrical_box_small_02", "electrical_box_small_02", "electrical_box_small_02", "electrical_box_small_02", "electrical_box_small_02", "electrical_box_small_02", "electrical_box_small_02", "electrical_box_small_02", "electrical_box_small_02", "electrical_box_small_02", "electrical_box_small_02", "electrical_box_small_02", "electrical_box_small_02", "electrical_box_small_02", "electrical_box_small_02", "electrical_box_small_02", "electrical_box_small_02", "electrical_box_small_02", "electrical_box_small_02"];
}

function function_65c3caaffb3e304b() {
  buildinfo = spawnStruct();
  buildinfo.phases = [0, 0.043, 0.086, 0.129, 0.172, 0.215, 0.258, 0.301, 0.344, 0.387, 0.43, 0.473, 0.516, 0.559, 0.602, 0.645, 0.688, 0.731, 0.774, 0.817, 0.86, 0.903, 0.946, 1];
  buildinfo.models = level.var_c88bedfa8ddcb42c["Bridge"]["models"];
  buildinfo.animations = level.var_c88bedfa8ddcb42c["Bridge"]["animations"];
  buildinfo.buildusetime = getdvarint(@ "hash_2c5fc8c91bb452f1", 10);
  buildinfo.gestureweapon = "jup_war_ges_wrench_hedgehog";
  buildinfo.hintstring = &"MP_JUP_WM/BUILD";
  buildinfo.var_32a2681a13f18cb1 = &function_67566d2e6de4c38d;
  buildinfo.var_b3b899b146453c0c = &function_9bbede70805c424b;
  buildinfo.var_562da06e56403b2f = &function_9b5ff909d4adaabb;
  level.buildablepool["bdb_bridge"] = buildinfo;
}

function function_5a307f566d10f3cc() {
  ents = getEntArray("wm_build_bridge", "targetname");

  foreach(ent in ents) {
    if(ent.script_noteworthy == "bridge_1") {
      function_d5d4c733847741f7(ent);
      continue;
    }

    function_fbbc7b350d9324bb(ent);
  }
}

function function_d5d4c733847741f7(ent) {
  scriptorigin = getStruct(ent.target, "targetname");
  buildable = scripts\mp\gametypes\wm_buildable::function_e20a97a059fba2ea("bdb_bridge", ent, ent.script_noteworthy, 0, scriptorigin.origin, scriptorigin.angles);
  buildable.var_74e771c59c46ae7f = 1;
  var_149af173dea41b16 = getEntArray(ent.target, "targetname");
  buildable.var_688ed792fe4b13d6 = [];

  foreach(part in var_149af173dea41b16) {
    if(isDefined(part.script_noteworthy)) {
      var_bb33a728a47d585c = int(getsubstr(part.script_noteworthy, 6));

      if(!isDefined(buildable.var_688ed792fe4b13d6[var_bb33a728a47d585c])) {
        buildable.var_688ed792fe4b13d6[var_bb33a728a47d585c] = [];
      }

      arraysize = buildable.var_688ed792fe4b13d6[var_bb33a728a47d585c].size;
      buildable.var_688ed792fe4b13d6[var_bb33a728a47d585c][arraysize] = part;

      if(var_bb33a728a47d585c != 0) {
        part hide();
      }
    }
  }

  ent thread function_4b5d56c4149d8b52();
  buildable thread function_b91d0931cb179a42("zone_1");
}

function function_fbbc7b350d9324bb(ent) {
  var_149af173dea41b16 = getEntArray(ent.target, "targetname");

  foreach(part in var_149af173dea41b16) {
    part hide();
  }

  ent thread function_4b5d56c4149d8b52();
}

function function_4b5d56c4149d8b52() {
  self notify("stop_get_progress");
  self endon("stop_get_progress");
  level endon("game_ended");
  pathnodes = getvehiclenodearray("bridge_pos", "script_noteworthy");
  pathnode = sortbydistance(pathnodes, self.origin)[0];
  scripts\mp\flags::gameflagwait("zone_1" + "_objective_start");
  distsquared = distance2dsquared(self.origin, pathnode.origin);

  if(distsquared > 3000) {
    assertmsg(distsquared + "<dev string:x1c>" + self.origin + "<dev string:x156>");
    self.buildable.useobj.trigger makeunusable();
  }

  self.progress = pathnode.progress;
}

function function_67566d2e6de4c38d(player, buildable) {
  buildable.models[0] function_adc7327a592cc4a1();
}

function function_9bbede70805c424b(player, buildable, buildphase) {
  foreach(part in buildable.var_688ed792fe4b13d6[buildphase]) {
    part show();
  }
}

function function_9b5ff909d4adaabb(player, buildable) {
  buildable notify("bridge_built");

  foreach(model in buildable.models) {
    model delete();
  }
}

function function_3a30653162283c01() {
  ents = getEntArray("wm_build_bridge", "targetname");

  foreach(ent in ents) {
    if(ent.script_noteworthy == "bridge_2") {
      scriptorigin = getStruct(ent.target, "targetname");
      buildable = scripts\mp\gametypes\wm_buildable::function_e20a97a059fba2ea("bdb_bridge", ent, ent.script_noteworthy, 0, scriptorigin.origin, scriptorigin.angles);
      var_149af173dea41b16 = getEntArray(ent.target, "targetname");

      foreach(part in var_149af173dea41b16) {
        if(isDefined(part.script_noteworthy)) {
          if(part.script_noteworthy == "stage_0") {
            part show();
            continue;
          }

          var_bb33a728a47d585c = int(getsubstr(part.script_noteworthy, 6));

          if(!isDefined(buildable.var_688ed792fe4b13d6[var_bb33a728a47d585c])) {
            buildable.var_688ed792fe4b13d6[var_bb33a728a47d585c] = [];
          }

          arraysize = buildable.var_688ed792fe4b13d6[var_bb33a728a47d585c].size;
          buildable.var_688ed792fe4b13d6[var_bb33a728a47d585c][arraysize] = part;
          part hide();
        }
      }

      buildable thread function_b91d0931cb179a42("zone_1");
    }
  }
}

function function_b91d0931cb179a42(zoneinfo) {
  level endon("game_ended");
  self endon("deleted");
  scripts\mp\flags::gameflagwait(zoneinfo + "_objective_start");
  ref = self.models[0] getentitynumber();

  foreach(vehicle in level.escortvehicles) {
    if(istrue(vehicle.spawndata.var_949ddd9ee6a3aaf5)) {
      tank = vehicle;
    }
  }

  assert(!isDefined(tank), "<dev string:x1c1>");

  while(!isDefined(self.triggerent.progress) || !isDefined(tank.progress) || !isDefined(tank.var_56df20c41f5b3159)) {
    waitframe();
  }

  while(true) {
    if(!istrue(tank.var_7150b8620d62148[ref]) && istrue(function_d7cd093af2c174(tank.var_56df20c41f5b3159, self.triggerent.progress, tank.progress))) {
      tank.var_7150b8620d62148[ref] = 1;

      if(self.triggerent.progress > tank.progress) {
        tank.directionblocked[ref] = "forward";
      } else {
        tank.directionblocked[ref] = "backward";
      }
    }

    msg = waittill_notify_or_timeout_return("bridge_built", level.framedurationseconds);

    if(msg == "bridge_built") {
      tank.var_7150b8620d62148[ref] = 0;
      break;
    }

    if(istrue(tank.var_7150b8620d62148[ref]) && !istrue(function_d7cd093af2c174(tank.var_56df20c41f5b3159, self.triggerent.progress, tank.progress))) {
      tank.var_7150b8620d62148[ref] = 0;
    }
  }
}

function function_d7cd093af2c174(var_56df20c41f5b3159, trapprogress, tankprogress) {
  return tankprogress - trapprogress > var_56df20c41f5b3159 * 45 * -1 && tankprogress - trapprogress < var_56df20c41f5b3159 * 90;
}