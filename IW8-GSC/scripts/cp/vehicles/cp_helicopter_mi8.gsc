/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\cp_helicopter_mi8.gsc
*****************************************************/

function _precache() {
  level._effect["rocket_flash"] = loadfx("vfx/iw8_cp/level/cp_stk_embassy/vfx_mi_8_rocket_flash.vfx");
}

function spawn_helicopter(var_0, var_1, var_2, var_3, var_4) {
  setdvarifuninitialized("enable_vehicle_ai_using_BT", 1);
  var_5 = spawnVehicle("veh8_mil_air_mindia8_open_back", "mindia8_infil", "veh_mindia8", var_1, var_2);
  var_5.owner = var_0;
  var_5.spawn_pos = var_1;
  var_5.animname = "mindia8";
  var_5.team = var_0.team;

  if(isDefined(var_3)) {
    var_5.team = var_3;
  }

  var_5 setvehicleteam(var_5.team);
  var_5 setmaxpitchroll(20, 20);
  agent_init_anims(var_5);
  vehicle_init_anims(var_5);
  script_model_init_anims(var_5);

  if(istrue(var_4)) {
    heli_add_mg(var_5);
  }

  return var_5;
}

#using_animtree("");

function script_model_init_anims() {
  level.scr_anim["pilot"]["idle"] = % vh_mindia8_pilot_idle;
  level.scr_animname["pilot"]["idle"] = "vh_mindia8_pilot_idle";
  level.scr_anim["copilot"]["idle"] = $vh_mindia8_copilot_idle;
  level.scr_animname["copilot"]["idle"] = "vh_mindia8_copilot_idle";
}

function agent_init_anims() {
  var_0 = "mindia8_";
  var_1 = "_idle";
  var_2 = "_exit";
  self.loc_array = ["front_l_1", "front_l_2", "front_l_3", "front_r_1", "front_r_2", "front_r_3", "rear_l_1", "rear_l_2", "rear_l_3", "rear_r_1", "rear_r_2", "rear_r_3"];
  self.agent_anims = [];

  foreach(var_4 in self.loc_array) {
    self.agent_anims[var_4] = spawnStruct();
    self.agent_anims[var_4].idle_anim = var_0 + var_4 + var_1;
    self.agent_anims[var_4].exit_anim = var_0 + var_4 + var_2;
  }

  self.vehicleanimalias = "mindia8";
}

function vehicle_init_anims() {
  level.scr_animtree["mindia8"] = #animtree;
  add_veh_anim("mindia8", "idle", $vh_mindia8_heli_idle, "vh_mindia8_heli_idle");
  add_veh_anim("mindia8", "arrival2", %vh_mindia8_heli_arrival_2, "vh_mindia8_heli_arrival_2");
  add_veh_anim("mindia8", "exit_2", %vh_mindia8_heli_exit_2, "vh_mindia8_heli_exit_2");
  add_veh_anim("mindia8", "exit_4", %vh_mindia8_heli_exit_4, "vh_mindia8_heli_exit_4");
  add_veh_anim("mindia8", "exit_6", %vh_mindia8_heli_exit_6, "vh_mindia8_heli_exit_6");
  add_veh_anim("mindia8", "exit_8", %vh_mindia8_heli_exit_8, "vh_mindia8_heli_exit_8");
}

function add_veh_anim(var_0, var_1, var_2, var_3) {
  level.scr_anim[var_0][var_1] = var_2;
  level.scr_animname[var_0][var_1] = var_3;
}

function play_vehicle_anim(var_0, var_1) {
  self animScripted("blah", self.origin, self.angles, level.scr_anim[self.animname][var_0]);
  var_2 = getanimlength(level.scr_anim[self.animname][var_0]);
  wait var_2;
}

function agent_spawnai(var_0, var_1) {
  var_2 = [[level.mindia8_spawnaifunc]](self);

  if(isDefined(var_2)) {
    agent_put_on_heli(var_2, var_0, var_1, self);
    return var_2;
  }
}

function agent_put_on_heli(var_0, var_1, var_2) {
  self.ignoreall = 1;
  self.heli_loc = var_0;

  if(!getdvarint("enable_vehicle_ai_using_BT")) {
    self.scripted_mode = 1;
    scripts\asm\asm_mp::carepackage_get_dropped_entities();
  }

  var_3 = scripts\asm\asm::asm_lookupanimfromalias("animscripted", var_2.agent_anims[var_0].idle_anim);
  var_4 = scripts\asm\asm::asm_getxanim("animscripted", var_3);
  var_5 = var_2 gettagorigin("body_animate_jnt");
  var_6 = var_2 gettagangles("body_animate_jnt");
  var_7 = getstartorigin(var_5, var_6, var_4);
  var_8 = getstartangles(var_5, var_6, var_4);
  self setplayerangles((0, var_2.angles[1], 0));
  self setOrigin(var_7, 0);

  if(!getdvarint("enable_vehicle_ai_using_BT")) {
    self aisetanim("animscripted", var_3);
    self linkTo(var_2);
    self playerlinkedoffsetenable();
    return;
  }

  var_9 = spawnStruct();
  var_9.origin = var_7;
  var_9.angles = (0, var_2.angles[1], 0);
  var_9.vehicle_position = var_1;
  var_10 = spawnStruct();
  var_10.exittag = "body_animate_jnt";
  scripts\vehicle\vehicle_common::requestentervehicle(var_2, 1, var_9, var_10);
}

function mindia8_unload(var_0) {
  self endon("death");
  self endon("unload_interrupt");
  crew_spawn();
  self setneargoalnotifydist(250);

  if(isDefined(level.mindia8_unloadinterruptfunc)) {
    self thread[[level.mindia8_unloadinterruptfunc]](var_0);
  }

  var_1 = var_0.origin + (0, 0, 527);
  self.goalradius = 4;
  self vehicle_setspeed(40, 25, 7);
  self setvehgoalpos(var_1, 1);
  self setyawspeed(40, 20, 20, 0.3);
  self waittill("goal");
  self vehicle_setspeed(0, 1, 1);
  self setmaxpitchroll(5, 5);
  wait 1;
  self notify("start_infil");
  self vehicle_cleardrivingstate();
  self vehicleplayanim(level.scr_anim[self.animname]["idle"]);
  thread crew_unload();
  self waittill("unloaded");
  thread heli_depart();
}

function heli_depart() {
  self endon("death");
  self setmaxpitchroll(20, 20);

  if(should_use_exit_anim()) {
    use_exit_anim();
  } else {
    var_0 = anglesToForward((0, self.angles[1], 0));
    var_1 = vec_multiply(var_0, 5000);
    self setmaxpitchroll(35, 35);
    self vehicle_setspeed(50, 30, 7);
    self setvehgoalpos(self.origin + var_1 + (0, 0, 400), 1);
    self waittill("goal");
  }

  self.pilot delete();
  self.copilot delete();
  self delete();
}

function should_use_exit_anim() {
  return false;
}

function use_exit_anim() {
  var_0 = 2;

  if(randomint(100) > 50) {
    var_0 = 4;

    if(randomint(100) > 50) {
      var_0 = 6;
    }

    if(randomint(100) > 50) {
      var_0 = 8;
    }
  }

  self vehicle_cleardrivingstate();
  play_vehicle_anim("exit_" + var_0);
  var_1 = anglesToForward((0, self.angles[1], 0));
  var_2 = vec_multiply(var_1, 5000);
  self setmaxpitchroll(35, 35);
  self vehicle_setspeedimmediate(50, 50, 7);
  self setvehgoalpos(self.origin + var_2 + (0, 0, 200), 1);
  wait 10;
}

function crew_spawn() {
  self.agents = [];

  foreach(var_1 in self.loc_array) {
    self.agents[var_2] = agent_spawnai(var_1, var_2 + 2);
  }

  spawn_pilots();
}

#using_animtree("generic_human");

function crew_unload() {
  if(isDefined(level.mindia8_customunloadfunc)) {
    [[level.mindia8_customunloadfunc]](self);
  }

  foreach(var_1 in self.agents) {
    thread agent_exit_heli(var_1);
  }

  var_3 = % vh_mindia8_rear_r_3_exit;
  wait getanimlength(var_3) + 3;
  self notify("unloaded");
}

function agent_exit_heli(var_0) {
  self endon("death");

  if(!getdvarint("enable_vehicle_ai_using_BT")) {
    self unlink();
    self.deathstate = "animscripted";
    self.deathalias = "death_mindia8_fastrope";
    self.health = 1;
    scripts\asm\shared\mp\utility::burningpartlogic(var_0.agent_anims[self.heli_loc].exit_anim, var_0, "body_animate_jnt");
    self.deathstate = undefined;
    self.deathalias = undefined;
    self.scripted_mode = 0;
    self.ignoreall = 0;
    self.deathstate = undefined;
    self.deathalias = undefined;
  } else {
    self.health = 1;
    scripts\vehicle\vehicle_common::exitvehicle();
    self.ignoreall = 0;
  }

  wait 5;
  self dodamage(self.health + 100, self.origin, level.players[0], level.players[0]);
}

function spawn_pilots() {
  var_0 = self gettagorigin("body_animate_jnt");
  var_1 = self gettagangles("body_animate_jnt");
  var_2 = getstartorigin(var_0, var_1, level.scr_anim["pilot"]["idle"]);
  var_3 = getstartangles(var_0, var_1, level.scr_anim["pilot"]["idle"]);
  var_4 = getstartorigin(var_0, var_1, level.scr_anim["copilot"]["idle"]);
  var_5 = getstartangles(var_0, var_1, level.scr_anim["copilot"]["idle"]);
  self.pilot = spawn("script_model", var_2);
  self.pilot.angles = var_3;
  self.pilot setModel("aq_pilot_fullbody_1");
  self.copilot = spawn("script_model", var_4);
  self.copilot.angles = var_5;
  self.copilot setModel("aq_pilot_fullbody_2");
  self.copilot linkTo(self);
  self.pilot linkTo(self);
  self.pilot scriptmodelplayanimdeltamotionfrompos(level.scr_animname["pilot"]["idle"], var_0, var_1);
  self.copilot scriptmodelplayanimdeltamotionfrompos(level.scr_animname["copilot"]["idle"], var_0, var_1);
}

function heli_add_mg() {
  var_0 = "tag_turret";
  var_1 = self gettagorigin(var_0);
  var_2 = spawnturret("misc_turret", var_1, "minida8_turret");
  var_2.angles = self gettagangles(var_0);
  var_2 setModel("veh8_mil_air_mindia8_turret");
  var_2 linkTo(self, var_0);
  var_2 setturretteam("axis");
  var_2 setmode("manual");
  var_2 setdefaultdroppitch(0);
  var_2 setleftarc(360);
  var_2 setrightarc(360);
  var_2 settoparc(45);
  var_2 setbottomarc(90);
  var_2 setconvergencetime(0.05, "yaw");
  var_2 setconvergencetime(0.05, "pitch");
  var_2.heli = self;
  thread scripts\engine\utility::delete_on_death(var_2);
  self.mg = var_2;
}

function vec_multiply(var_0, var_1) {
  return (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
}