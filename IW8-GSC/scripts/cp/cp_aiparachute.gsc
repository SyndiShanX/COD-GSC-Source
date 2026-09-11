/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_aiparachute.gsc
***********************************************/

function strict_ff_enable() {
  level.spawnfunc_registered = [];
  level.ac130_paratrooper_veh = [];
}

function request_paratroopers(var_0, var_1, var_2) {
  if(!isDefined(level.spawnfunc_registered)) {
    level.spawnfunc_registered = [];
  }

  if(!isDefined(level.spawnfunc_registered[var_0])) {
    scripts\cp\cp_modular_spawning::register_module_ai_spawn_func(var_0, &paratrooper_spawnfunc);
    level.spawnfunc_registered[var_0] = 1;
  }

  var_3 = scripts\engine\utility::getStructArray(var_0, "targetname");

  foreach(var_5 in var_3) {
    var_5 scripts\cp\cp_modular_spawning::mounted();

    if(!isDefined(var_5.parachute_land_origin)) {
      var_5.parachute_land_origin = var_5.origin;
    }
  }

  var_5 = var_3[0];
  var_7 = var_5.parachute_land_origin + (0, 0, 12000);

  if(isDefined(var_1)) {
    var_7 = var_5.parachute_land_origin + (0, 0, var_1);
  }

  var_8 = spawn("script_model", var_2);
  var_8 setModel("veh8_mil_air_acharlie130_ks");
  var_8.angles = vectortoangles(var_7 - var_8.origin);
  var_8 playLoopSound("iw8_bradley_drop_c130");
  var_8 setscriptablepartstate("lights2", "on", 0);
  var_8 setscriptablepartstate("contrails", "on", 0);

  if(!isDefined(level.ac130_paratrooper_veh)) {
    level.ac130_paratrooper_veh = [];
  }

  level.ac130_paratrooper_veh[level.ac130_paratrooper_veh.size] = var_8;
  var_8.spawngroup = var_0;
  var_8 moveTo(var_7 + anglesToForward(var_8.angles) * 4500, 10);
  wait 10;
  var_3 = scripts\engine\utility::getStructArray(var_0, "targetname");

  foreach(var_5 in var_3) {
    var_5.origin = var_8.origin;
  }

  var_11 = scripts\cp\cp_modular_spawning::run_spawn_module(var_0);
  var_8 moveTo(var_8.origin + anglesToForward(var_8.angles) * 24500, 10);
  wait 10;
  level.ac130_paratrooper_veh = scripts\engine\utility::array_remove(level.ac130_paratrooper_veh, var_8);
  var_8 stoploopsound();
  var_8 setscriptablepartstate("lights2", "off", 0);
  var_8 setscriptablepartstate("contrails", "off", 0);
  var_8 delete();
  return var_11;
}

function armored_basic_combat(var_0) {
  level endon("game_ended");
  self endon("death");
  self moveTo(var_0 + anglesToForward(self.angles) * 4500, 10);
  wait 10;
  thread player_unresolved_collision_suspend();
}

function player_unresolved_collision_suspend() {
  self moveTo(self.origin + anglesToForward(self.angles) * 24500, 10);
  wait 10;

  if(scripts\engine\utility::array_contains(level.ac130_paratrooper_veh, self)) {
    level.ac130_paratrooper_veh = scripts\engine\utility::array_remove(level.ac130_paratrooper_veh, self);
  }

  self delete();
}

function ref_135b0(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_1);
  var_3 setModel("veh8_mil_air_acharlie130_ks");
  var_3.angles = vectortoangles(var_2 - var_3.origin);
  var_3.health = 50000;
  var_3.maxhealth = 50000;
  var_3.team = "axis";

  if(!isDefined(level.ac130_paratrooper_veh)) {
    level.ac130_paratrooper_veh = [];
  }

  level.ac130_paratrooper_veh[level.ac130_paratrooper_veh.size] = var_3;
  var_3.spawngroup = var_0;
  return var_3;
}

function paratrooper_spawnfunc(var_0) {
  thread create_paratrooper();
}

function create_paratrooper() {
  self endon("death");
  thread watch_for_death();
  ref_121c4();
  ref_121c3();
  ref_121c5();
  ref_121c6();
  ref_121c1();
  parachute_idle();
}

function ref_121c4() {
  self allowedstances("stand");
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.scripted_mode = 1;
  self.playing_skit = 1;
  self.do_immediate_ragdoll = 1;
  scripts\cp\cp_modular_spawning::set_kill_off_time(1000);
  var_0 = undefined;

  foreach(var_2 in level.ac130_paratrooper_veh) {
    if(var_2.spawngroup != self.enemy_group) {
      continue;
    }

    var_0 = var_2;
  }

  if(isDefined(var_0)) {
    self.ac130 = var_0;
    self asmsetstate(self.asmname, "parachute_freefall");
    self._blackboard.ref_121d3 = "freefall";
    self setOrigin(var_0.origin + (0, 0, 50), 0);
    return;
  }
}

function ref_121c3() {
  self endon("death");
  self.landing_spot = getgroundposition(self.spawnpoint.parachute_land_origin, 64);
  var_0 = (0, 0, 0);

  if(isDefined(self.spawnpoint.brjugg_oncratedestroy)) {
    var_1 = vectortoangles(self.origin - self.landing_spot);
    var_0 = anglesToForward(var_1) * 3500;
  }

  self.skydive_dest = self.landing_spot + (0, 0, 1500) + (var_0[0], var_0[1], 0);
}

function ref_121c5() {
  self endon("death");

  if(isDefined(self.ac130)) {
    self.anchor = spawn("script_origin", self.origin);
    self.anchor.angles = (0, self.angles[1], 0);
    self linkTo(self.anchor);
    self.anchor rotateTo((0, self.ac130.angles[1], 0) + (0, 180, 0), 2);
    self.anchor moveTo(self.skydive_dest, 12);
    wait 10;
    return;
  }

  self.nocorpse = 1;
  self dodamage(self.health + 100, self.origin);
}

function ref_121c6() {
  var_0 = spawn("script_model", self gettagorigin("j_spine4"));
  var_0.angles = self gettagangles("j_spine4");
  var_0 setModel("misc_wm_br_parachute");
  var_0 linkTo(self, "j_spine4", (0, 0, 0), (0, 0, 0));
  self.chute = var_0;
  thread ref_13f11(var_0);
}

function ref_121c1() {
  self.chute scriptmodelplayanim("sdr_com_parachute_pullcord");
  self._blackboard.ref_121d3 = "parachuting";
  self asmsetstate(self.asmname, "parachute_deploy");
  thread ks_circleclosetime();
}

function ks_circleclosetime() {
  self endon("death");
  wait 3.5;
  self asmfireevent(self.asmname, "finish");
}

function parachute_idle() {
  thread parachute_move();
  thread parachute_idle_internal();
}

function parachute_idle_internal() {
  self endon("death");
  wait 1.5;
  self.chute scriptmodelplayanim("sdr_com_parachute_idle");
}

function parachute_move() {
  self endon("death");
  var_0 = 6;

  if(isDefined(self.spawnpoint.brjugg_oncratedestroy)) {
    var_0 = 9;
  }

  var_1 = 3;
  self.anchor moveTo(self.landing_spot, var_0, 3, var_1);
  wait var_0 - 1.5;
  self._blackboard.ref_121d3 = "landing";
  self.chute scriptmodelplayanim("sdr_com_parachute_prepare_for_landing");
  wait 3.4;
  self.chute delete();
  self.chute notify("parachute_detached");
  thread do_landing();
}

function do_landing() {
  self endon("death");
  self.anchor.origin = self.landing_spot;
  self setplayerangles((0, self.anchor.angles[1], 0));
  self unlink();
  self setplayerangles((0, self.anchor.angles[1], 0));

  if(isDefined(self.anchor)) {
    self.anchor delete();
  }

  self allowedstances("prone", "stand", "crouch");
  self.playing_skit = undefined;
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.scripted_mode = 0;
  self.ac130 = undefined;

  if(!ispointonnavmesh(self.origin, self, 1)) {
    scripts\cp\cp_modular_spawning::teleport_to_nearby_spawner("Landed off NavMesh", self.origin);
  } else {
    scripts\cp\cp_modular_spawning::set_kill_off_time(20);
    thread scripts\cp\cp_modular_spawning::enter_combat();
  }

  self notify("delete_chute");
  wait 1;
  self.do_immediate_ragdoll = undefined;
}

function watch_for_death() {
  self endon("parachute_detached");
  self waittill("death");

  if(isDefined(self.anchor)) {
    self.anchor delete();
    return;
  }
}

function ref_13f11(var_0) {
  self endon("death");
  var_0 endon("parachute_detached");
  var_0 waittill("death");
  self unlink();
  self movez(100, 2);
  wait 2;
  self delete();
}