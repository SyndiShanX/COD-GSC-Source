/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_440a6f7f2d90cc3c.gsc
*************************************************/

#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace namespace_be7e08635722cc83;
#using_animtree("mp_vehicles_always_loaded");

function function_3e3a73f1039ca16d() {
  level.scr_anim["cargo_delivery_extract"]["heli_in"] = % iw9_dmz_cargo_heli_in;
  level.scr_anim["cargo_delivery_extract"]["heli_loop"] = % iw9_dmz_cargo_heli_loop;
  level.scr_anim["cargo_delivery_extract"]["heli_out"] = % iw9_dmz_cargo_heli_out;
  function_885b229aee63b402();
}

#using_animtree("script_model");

function function_885b229aee63b402() {
  level.scr_animtree["cargo_delivery_extract_props"] = #animtree;
  level.scr_anim["cargo_delivery_extract_props"]["rope_in"] = % iw9_dmz_cargo_heli_rope_in;
  level.scr_anim["cargo_delivery_extract_props"]["rope_loop"] = % iw9_dmz_cargo_heli_rope_loop;
  level.scr_anim["cargo_delivery_extract_props"]["rope_out"] = % iw9_dmz_cargo_heli_rope_out;
  level.scr_anim["cargo_delivery_extract_props"]["hook_in"] = % iw9_dmz_cargo_heli_hook_in;
  level.scr_anim["cargo_delivery_extract_props"]["hook_loop"] = % iw9_dmz_cargo_heli_hook_loop;
  level.scr_anim["cargo_delivery_extract_props"]["hook_out"] = % iw9_dmz_cargo_heli_hook_out;
}

function function_5a081e065a93bd08(var_b4ef83e4ca39c8ec, offset, var_367433161de52ca2) {
  extractgroundpos = getgroundposition(var_b4ef83e4ca39c8ec, 1) + offset;
  var_db4adba9675a31aa = extractgroundpos + (0, 0, 4000);
  spawnposoffset = extractgroundpos + (0, 0, 8000);
  var_7ce2ef2a1efe71a6 = extractgroundpos + (0, 0, 850);
  flightyaw = 0;
  flightangles = (0, 0, 0);
  flightyaw = function_b89378e2e51cf825(spawnposoffset, var_db4adba9675a31aa);
  flightangles = (0, flightyaw, 0);
  enterposition = spawnposoffset - anglesToForward(flightangles) * 20000;
  var_87cef10bf5729579 = 1;
  var_1d4278103ba47a16 = vectortoangles(var_db4adba9675a31aa * (1, 1, 0) - enterposition * (1, 1, 0));
  spawndata = spawnStruct();
  spawndata.origin = enterposition;
  spawndata.angles = var_1d4278103ba47a16;
  spawndata.var_699ac4a9c9e9f0ec = 1;
  spawndata.var_24993ee24f7c7c0 = 1;

  if(istrue(var_367433161de52ca2)) {
    heli = vehicle_spawn("veh_jup_blima", spawndata);
  } else {
    heli = vehicle_spawn("veh9_blima", spawndata);
  }

  if(!isDefined(heli)) {
    return;
  }

  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable(heli);
  heli function_247ad6a91f6a4ffe(1);
  heli vehphys_forcekeyframedmotion();
  heli.speed = 100;
  heli.accel = 125;
  heli.health = 999999;
  heli.maxhealth = heli.health;
  heli.lifeid = 0;
  heli.flaresreservecount = var_87cef10bf5729579;
  heli.enterpos = enterposition;
  heli.descendpos = var_db4adba9675a31aa;
  heli.hoverpos = var_7ce2ef2a1efe71a6;
  heli.extractgroundpos = extractgroundpos;
  heli.sceneangles = var_1d4278103ba47a16;
  heli.var_177d31bd38d64887 = 1;
  heli.animname = "cargo_delivery_extract";
  heli scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  heli setmaxpitchroll(10, 25);
  heli vehicle_setspeed(heli.speed, heli.accel);
  heli sethoverparams(1, 1, 1);
  heli setturningability(0.05);
  heli setyawspeed(45, 25, 25, 0.5);

  if(isent(self)) {
    if(isDefined(self.team)) {
      heli.team = self.team;
    }

    heli.owner = self;
    heli setotherent(self);
  }

  heli setscriptablepartstate("engine", "on");
  heli setscriptablepartstate("running_lights", "on");
  heli setscriptablepartstate("infil_lights", "on");
  heli.scenenode = spawn("script_model", var_b4ef83e4ca39c8ec + (0, 0, -15) + offset);
  heli.scenenode.angles = heli.sceneangles;
  heli.scenenode setModel("tag_origin");
  heli.scenenode scripts\common\anim::anim_first_frame_solo(heli, "heli_in");
  level.var_f3b18a363ae14d7a = heli;
  function_542344d67fb5ee7a(heli);
  heli thread function_b525fa38baf87839(var_b4ef83e4ca39c8ec + offset);
  return heli;
}

function private function_542344d67fb5ee7a(heli) {
  rope = spawn("script_model", (0, 0, 0));
  rope setModel("misc_rapelling_rope_01_fiber_br");
  rope linkTo(heli, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));
  rope notsolid();
  rope show();
  rope.animname = "cargo_delivery_extract_props";
  rope scripts\common\anim::setanimtree();
  heli scripts\common\anim::anim_first_frame_solo(rope, "rope_in", "origin_animate_jnt");
  crate = spawn("script_model", (0, 0, 0));
  crate setModel("construction_lattice_boom_crane_01_hook");
  crate linkTo(heli, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));
  crate notsolid();
  crate show();
  crate.animname = "cargo_delivery_extract_props";
  crate scripts\common\anim::setanimtree();
  heli scripts\common\anim::anim_first_frame_solo(crate, "hook_in", "origin_animate_jnt");
  heli.rope = rope;
  heli.crate = crate;
}

function function_8a0f37ea918fa970(distinches, speedmph, accelmph) {
  distmiles = distinches * 1.57828e-05;
  a = 0.5 * accelmph;
  b = speedmph;
  c = -1 * distmiles;
  flytime = (-1 * b + sqrt(b * b - 4 * a * c)) / 2 * a;
  flytime *= 3600;
  flytime += 1.5;
  return flytime;
}

function function_63e41ce3a6457cc1(var_625180ce8d2f8f77) {
  arrivetime = function_8a0f37ea918fa970(20000, 100, 125);
  descendtime = function_8a0f37ea918fa970(var_625180ce8d2f8f77, 25, 31.25);
  totaltime = arrivetime + descendtime;
  return totaltime;
}

function function_b525fa38baf87839(var_3d5095c68e5c2b99) {
  self endon("death");
  self endon("leaving");
  groundz = self.extractgroundpos[2];
  var_625180ce8d2f8f77 = self.descendpos[2] - groundz;
  self.flytime = function_63e41ce3a6457cc1(var_625180ce8d2f8f77);
  thread function_f5d7c70a275e3c17();
  self.preventleave = 1;
  function_e3a16387941bbbc8();
  self.preventleave = undefined;
  self setscriptablepartstate("vector_field", "on");

  if(istrue(level.gameended)) {
    thread function_acd83be80ff2e711();
    return;
  }

  thread function_acd83be80ff2e711();
}

function function_b89378e2e51cf825(var_e58119f7c6eb5b4d, var_d3970a3e6c77212e) {
  var_3fb4a86293ed25a6 = 10;
  contents = create_contents(0, 1, 1, 1, 1, 0, 1, 1, 0);
  var_3674d96c61e2dd0d = 0;
  yaw = 0;

  while(yaw < 360) {
    var_3674d96c61e2dd0d += yaw;
    testangles = (0, var_3674d96c61e2dd0d, 0);
    approachstartpos = var_e58119f7c6eb5b4d - anglesToForward(testangles) * 20000;
    approachendpos = var_d3970a3e6c77212e;
    approachtrace = sphere_trace(approachstartpos, approachendpos, 100, undefined, contents, 1);

    if(approachtrace["fraction"] == 1) {
      line(approachstartpos, approachendpos, (0, 1, 0), 1, 0, 2000);

      return var_3674d96c61e2dd0d;
    }

    if(yaw % 3 == 0) {
      waitframe();
    }

    yaw += var_3fb4a86293ed25a6;
  }

  return var_3674d96c61e2dd0d;
}

function function_4bba7bf68035a122() {
  if(isDefined(self.rope)) {
    self.rope delete();
  }

  if(isDefined(self.crate)) {
    self.crate delete();
  }

  if(isDefined(self.scenenode)) {
    self.scenenode delete();
  }
}

function function_4b7dd160447d4825() {
  function_4bba7bf68035a122();
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function function_acd83be80ff2e711() {
  if(istrue(self.tryingtoleave) || istrue(self.leaving)) {
    return;
  }

  self endon("death");
  self notify("try_to_leave");
  self.tryingtoleave = 1;
  self waittill("ready_to_leave");
  self notify("leaving");
  self.leaving = 1;
  self.tryingtoleave = undefined;
  animtime_out = getanimlength(level.scr_anim[self.animname]["heli_out"]);
  self.scenenode thread scripts\common\anim::anim_single_solo(self, "heli_out");
  thread scripts\common\anim::anim_single_solo(self.rope, "rope_out", "origin_animate_jnt");
  thread scripts\common\anim::anim_single_solo(self.crate, "hook_out", "origin_animate_jnt");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(animtime_out);
  self stoploopsound();
  self notify("heli_gone");
  function_4b7dd160447d4825();
}

function function_e3a16387941bbbc8() {
  self endon("death");
  animtime_in = getanimlength(level.scr_anim[self.animname]["heli_in"]);
  self.scenenode thread scripts\common\anim::anim_single_solo(self, "heli_in");
  thread scripts\common\anim::anim_single_solo(self.rope, "rope_in", "origin_animate_jnt");
  thread scripts\common\anim::anim_single_solo(self.crate, "hook_in", "origin_animate_jnt");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(animtime_in);
  thread function_f0f206969743ba63();
  thread function_92a59e0004116c97();
  thread function_106caebe9f0dd820();
}

function function_f0f206969743ba63() {
  self endon("death");
  self.scenenode endon("death");
  animtime = getanimlength(level.scr_anim[self.animname]["heli_loop"]);

  while(true) {
    self.scenenode thread scripts\common\anim::anim_single_solo(self, "heli_loop");
    wait animtime;

    if(istrue(self.readytoleave) && !istrue(self.preventleave)) {
      self notify("ready_to_leave");
      break;
    }
  }
}

function function_92a59e0004116c97() {
  self endon("death");
  animtime = getanimlength(level.scr_anim[self.rope.animname]["rope_loop"]);

  while(true) {
    thread scripts\common\anim::anim_single_solo(self.rope, "rope_loop", "origin_animate_jnt");
    wait animtime;

    if(istrue(self.readytoleave)) {
      break;
    }
  }
}

function function_106caebe9f0dd820() {
  self endon("death");
  animtime = getanimlength(level.scr_anim[self.crate.animname]["hook_loop"]);

  while(true) {
    thread scripts\common\anim::anim_single_solo(self.crate, "hook_loop", "origin_animate_jnt");
    wait animtime;

    if(istrue(self.readytoleave)) {
      break;
    }
  }
}

function function_f5d7c70a275e3c17() {
  self endon("death");
  self endon("try_to_leave");
  level waittill("game_ended");
  thread function_acd83be80ff2e711();
}