/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_aiparachute.gsc
***********************************************/

function strict_ff_enable() {
  level.spawnfunc_registered = [];
  level.ac130_paratrooper_veh = [];
}

function request_paratroopers(var0, var1, var2) {
  if(!isDefined(level.spawnfunc_registered)) {
    level.spawnfunc_registered = [];
  }

  if(!isDefined(level.spawnfunc_registered[var0])) {
    scripts\cp\cp_modular_spawning::register_module_ai_spawn_func(var0, &paratrooper_spawnfunc);
    level.spawnfunc_registered[var0] = 1;
  }

  var3 = scripts\engine\utility::getStructArray(var0, "targetname");

  foreach(var5 in var3) {
    var5 scripts\cp\cp_modular_spawning::mounted();

    if(!isDefined(var5.parachute_land_origin)) {
      var5.parachute_land_origin = var5.origin;
    }
  }

  var5 = var3[0];
  var7 = var5.parachute_land_origin + (0, 0, 12000);

  if(isDefined(var1)) {
    var7 = var5.parachute_land_origin + (0, 0, var1);
  }

  var8 = spawn("script_model", var2);
  var8 setModel("veh8_mil_air_acharlie130_ks");
  var8.angles = vectortoangles(var7 - var8.origin);
  var8 playLoopSound("iw8_bradley_drop_c130");
  var8 setscriptablepartstate("lights2", "on", 0);
  var8 setscriptablepartstate("contrails", "on", 0);

  if(!isDefined(level.ac130_paratrooper_veh)) {
    level.ac130_paratrooper_veh = [];
  }

  level.ac130_paratrooper_veh[level.ac130_paratrooper_veh.size] = var8;
  var8.spawngroup = var0;
  var8 moveTo(var7 + anglesToForward(var8.angles) * 4500, 10);
  wait 10;
  var3 = scripts\engine\utility::getStructArray(var0, "targetname");

  foreach(var5 in var3) {
    var5.origin = var8.origin;
  }

  var11 = scripts\cp\cp_modular_spawning::run_spawn_module(var0);
  var8 moveTo(var8.origin + anglesToForward(var8.angles) * 24500, 10);
  wait 10;
  level.ac130_paratrooper_veh = scripts\engine\utility::array_remove(level.ac130_paratrooper_veh, var8);
  var8 stoploopsound();
  var8 setscriptablepartstate("lights2", "off", 0);
  var8 setscriptablepartstate("contrails", "off", 0);
  var8 delete();
  return var11;
}

function armored_basic_combat(var0) {
  level endon("game_ended");
  self endon("death");
  self moveTo(var0 + anglesToForward(self.angles) * 4500, 10);
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

function ref_135b0(var0, var1, var2) {
  var3 = spawn("script_model", var1);
  var3 setModel("veh8_mil_air_acharlie130_ks");
  var3.angles = vectortoangles(var2 - var3.origin);
  var3.health = 50000;
  var3.maxhealth = 50000;
  var3.team = "axis";

  if(!isDefined(level.ac130_paratrooper_veh)) {
    level.ac130_paratrooper_veh = [];
  }

  level.ac130_paratrooper_veh[level.ac130_paratrooper_veh.size] = var3;
  var3.spawngroup = var0;
  return var3;
}

function paratrooper_spawnfunc(var0) {
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
  var0 = undefined;

  foreach(var2 in level.ac130_paratrooper_veh) {
    if(var2.spawngroup != self.enemy_group) {
      continue;
    }

    var0 = var2;
  }

  if(isDefined(var0)) {
    self.ac130 = var0;
    self asmsetstate(self.asmname, "parachute_freefall");
    self._blackboard.ref_121d3 = "freefall";
    self setOrigin(var0.origin + (0, 0, 50), 0);
    return;
  }
}

function ref_121c3() {
  self endon("death");
  self.landing_spot = getgroundposition(self.spawnpoint.parachute_land_origin, 64);
  var0 = (0, 0, 0);

  if(isDefined(self.spawnpoint.brjugg_oncratedestroy)) {
    var1 = vectortoangles(self.origin - self.landing_spot);
    var0 = anglesToForward(var1) * 3500;
  }

  self.skydive_dest = self.landing_spot + (0, 0, 1500) + (var0[0], var0[1], 0);
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
  var0 = spawn("script_model", self gettagorigin("j_spine4"));
  var0.angles = self gettagangles("j_spine4");
  var0 setModel("misc_wm_br_parachute");
  var0 linkTo(self, "j_spine4", (0, 0, 0), (0, 0, 0));
  self.chute = var0;
  thread ref_13f11(var0);
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
  var0 = 6;

  if(isDefined(self.spawnpoint.brjugg_oncratedestroy)) {
    var0 = 9;
  }

  var1 = 3;
  self.anchor moveTo(self.landing_spot, var0, 3, var1);
  wait var0 - 1.5;
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

function ref_13f11(var0) {
  self endon("death");
  var0 endon("parachute_detached");
  var0 waittill("death");
  self unlink();
  self movez(100, 2);
  wait 2;
  self delete();
}