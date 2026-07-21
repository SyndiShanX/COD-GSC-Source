/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_aiparachute.gsc
***********************************************/

strict_ff_enable() {
  level.spawnfunc_registered = [];
  level.ac130_paratrooper_veh = [];
}

request_paratroopers(var_0, var_1, var_2) {
  if(!isDefined(level.spawnfunc_registered))
    level.spawnfunc_registered = [];

  if(!isDefined(level.spawnfunc_registered[var_0])) {
    scripts\cp\cp_modular_spawning::register_module_ai_spawn_func(var_0, ::paratrooper_spawnfunc);
    level.spawnfunc_registered[var_0] = 1;
  }

  var_3 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_5 in var_3) {
    var_5 scripts\cp\cp_modular_spawning::mounted();

    if(!isDefined(var_5.parachute_land_origin))
      var_5.parachute_land_origin = var_5.origin;
  }

  var_5 = var_3[0];
  var_7 = var_5.parachute_land_origin + (0, 0, 12000);

  if(isDefined(var_1))
    var_7 = var_5.parachute_land_origin + (0, 0, var_1);

  var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  var_8 setModel("_encstr_990B1C90532CF2E013E390766B4B32295251A22EDAB04B7291E62F9F07DA");
  var_8.angles = vectortoangles(var_7 - var_8.origin);
  var_8 playLoopSound("_encstr_BD6616AB57C2CEEDB22218201A08DFE1B3E7AF08DB0EBB91");
  var_8 setscriptablepartstate("_encstr_BE2908C47B90B4630EFB", "_encstr_AB0703DBB9", 0);
  var_8 setscriptablepartstate("_encstr_BD7D0A1E904061166A7C49B3", "_encstr_AB0703DBB9", 0);

  if(!isDefined(level.ac130_paratrooper_veh))
    level.ac130_paratrooper_veh = [];

  level.ac130_paratrooper_veh[level.ac130_paratrooper_veh.size] = var_8;
  var_8.spawngroup = var_0;
  var_8 moveTo(var_7 + anglesToForward(var_8.angles) * 4500, 10);
  wait 10;
  var_3 = scripts\engine\utility::getStructArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_5 in var_3)
  var_5.origin = var_8.origin;

  var_11 = scripts\cp\cp_modular_spawning::run_spawn_module(var_0);
  var_8 moveTo(var_8.origin + anglesToForward(var_8.angles) * 24500, 10);
  wait 10;
  level.ac130_paratrooper_veh = scripts\engine\utility::array_remove(level.ac130_paratrooper_veh, var_8);
  var_8 stoploopsound();
  var_8 setscriptablepartstate("_encstr_BE2908C47B90B4630EFB", "_encstr_BA19049F4B2D", 0);
  var_8 setscriptablepartstate("_encstr_BD7D0A1E904061166A7C49B3", "_encstr_BA19049F4B2D", 0);
  var_8 delete();
  return var_11;
}

armored_basic_combat(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self moveTo(var_0 + anglesToForward(self.angles) * 4500, 10);
  wait 10;
  thread player_unresolved_collision_suspend();
}

player_unresolved_collision_suspend() {
  self moveTo(self.origin + anglesToForward(self.angles) * 24500, 10);
  wait 10;

  if(scripts\engine\utility::array_contains(level.ac130_paratrooper_veh, self))
    level.ac130_paratrooper_veh = scripts\engine\utility::array_remove(level.ac130_paratrooper_veh, self);

  self delete();
}

_id_135B0(var_0, var_1, var_2) {
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_3 setModel("_encstr_990B1C90532CF2E013E390766B4B32295251A22EDAB04B7291E62F9F07DA");
  var_3.angles = vectortoangles(var_2 - var_3.origin);
  var_3.health = 50000;
  var_3.maxhealth = 50000;
  var_3.team = "_encstr_8E8405EA382B2A";

  if(!isDefined(level.ac130_paratrooper_veh))
    level.ac130_paratrooper_veh = [];

  level.ac130_paratrooper_veh[level.ac130_paratrooper_veh.size] = var_3;
  var_3.spawngroup = var_0;
  return var_3;
}

paratrooper_spawnfunc(var_0) {
  thread create_paratrooper();
}

create_paratrooper() {
  self endon("_encstr_AD75063D571AE108");
  thread watch_for_death();
  _id_121C4();
  _id_121C3();
  _id_121C5();
  _id_121C6();
  _id_121C1();
  parachute_idle();
}

_id_121C4() {
  self allowedstances("_encstr_A5AD069B231F0BAF");
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
    self asmsetstate(self.asmname, "_encstr_92AD135177A2F71B686D0B3FD9974B0D72B089E92B");
    self._blackboard._id_121D3 = "_encstr_AFB7098753307D72BFD1B3";
    self setOrigin(var_0.origin + (0, 0, 50), 0);
  }
}

_id_121C3() {
  self endon("_encstr_AD75063D571AE108");
  self.landing_spot = getgroundposition(self.spawnpoint.parachute_land_origin, 64);
  var_0 = (0, 0, 0);

  if(isDefined(self.spawnpoint.brjugg_oncratedestroy)) {
    var_1 = vectortoangles(self.origin - self.landing_spot);
    var_0 = anglesToForward(var_1) * 3500;
  }

  self.skydive_dest = self.landing_spot + (0, 0, 1500) + (var_0[0], var_0[1], 0);
}

_id_121C5() {
  self endon("_encstr_AD75063D571AE108");

  if(isDefined(self.ac130)) {
    self.anchor = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
    self.anchor.angles = (0, self.angles[1], 0);
    self linkTo(self.anchor);
    self.anchor rotateTo((0, self.ac130.angles[1], 0) + (0, 180, 0), 2);
    self.anchor moveTo(self.skydive_dest, 12);
    wait 10;
  } else {
    self.nocorpse = 1;
    self dodamage(self.health + 100, self.origin);
  }
}

_id_121C6() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self gettagorigin("_encstr_8EEC09159F6238030BFA23"));
  var_0.angles = self gettagangles("_encstr_8EEC09159F6238030BFA23");
  var_0 setModel("_encstr_8B1515E55B1056EF2C30518AFB100B8E70336378CB901F");
  var_0 linkTo(self, "_encstr_8EEC09159F6238030BFA23", (0, 0, 0), (0, 0, 0));
  self.chute = var_0;
  var_0 thread _id_13F11(self);
}

_id_121C1() {
  self.chute scriptmodelplayanim("_encstr_A9CD1BB9464E7DC6DE5BAF8316E42C3643EA3AACEB835736366CDE278C");
  self._blackboard._id_121D3 = "_encstr_B6200C1308902F6F20507333FDCC";
  self asmsetstate(self.asmname, "_encstr_972411902370BE67DB5BBB52E625B732589721");
  thread ks_circleclosetime();
}

ks_circleclosetime() {
  self endon("_encstr_AD75063D571AE108");
  wait 3.5;
  self asmfireevent(self.asmname, "_encstr_B4BA07CC5ADCB4CDD0");
}

parachute_idle() {
  thread parachute_move();
  thread parachute_idle_internal();
}

parachute_idle_internal() {
  self endon("_encstr_AD75063D571AE108");
  wait 1.5;
  self.chute scriptmodelplayanim("_encstr_B80617528480F1E085B5CF430B2DE3C77B639C5FF9E47B729F");
}

parachute_move() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = 6;

  if(isDefined(self.spawnpoint.brjugg_oncratedestroy))
    var_0 = 9;

  var_1 = 3;
  self.anchor moveTo(self.landing_spot, var_0, 3, var_1);
  wait(var_0 - 1.5);
  self._blackboard._id_121D3 = "_encstr_8820081976CAE1084E87";
  self.chute scriptmodelplayanim("_encstr_8D412686271B87595F9FD998977AD137628BFD05719365C128C7B8388786284D7975FF18177A1549");
  wait 3.4;
  self.chute delete();
  self.chute notify("_encstr_AD2413BBFAF6AF2651C7638128C383D3A14A5C9F9D");
  thread do_landing();
}

do_landing() {
  self endon("_encstr_AD75063D571AE108");
  self.anchor.origin = self.landing_spot;
  self setplayerangles((0, self.anchor.angles[1], 0));
  self unlink();
  self setplayerangles((0, self.anchor.angles[1], 0));

  if(isDefined(self.anchor))
    self.anchor delete();

  self allowedstances("_encstr_922406F1A6FD5E05", "_encstr_A5AD069B231F0BAF", "_encstr_B13D076BED70539F23");
  self.playing_skit = undefined;
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.scripted_mode = 0;
  self.ac130 = undefined;

  if(!ispointonnavmesh(self.origin, self, 1))
    scripts\cp\cp_modular_spawning::teleport_to_nearby_spawner("_encstr_A3D0130B30F02412815F8DC7543198E95BC9270F90", self.origin);
  else {
    scripts\cp\cp_modular_spawning::set_kill_off_time(20);
    thread scripts\cp\cp_modular_spawning::enter_combat();
  }

  self notify("_encstr_B6EB0DE209913FB39807A3A03B78BF");
  wait 1;
  self.do_immediate_ragdoll = undefined;
}

watch_for_death() {
  self endon("_encstr_AD2413BBFAF6AF2651C7638128C383D3A14A5C9F9D");
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(self.anchor))
    self.anchor delete();
}

_id_13F11(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD2413BBFAF6AF2651C7638128C383D3A14A5C9F9D");
  var_0 waittill("_encstr_AD75063D571AE108");
  self unlink();
  self movez(100, 2);
  wait 2;
  self delete();
}