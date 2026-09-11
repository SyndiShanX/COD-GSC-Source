/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\vehicles\cp_helicopter_mi8.gsc
*****************************************************/

function _precache() {
  level._effect["rocket_flash"] = loadfx("vfx/iw8_cp/level/cp_stk_embassy/vfx_mi_8_rocket_flash.vfx");
}

function spawn_helicopter(var0, var1, var2, var3, var4) {
  setdvarifuninitialized("enable_vehicle_ai_using_BT", 1);
  var5 = spawnVehicle("veh8_mil_air_mindia8_open_back", "mindia8_infil", "veh_mindia8", var1, var2);
  var5.owner = var0;
  var5.spawn_pos = var1;
  var5.animname = "mindia8";
  var5.team = var0.team;

  if(isDefined(var3)) {
    var5.team = var3;
  }

  var5 setvehicleteam(var5.team);
  var5 setmaxpitchroll(20, 20);
  agent_init_anims(var5);
  vehicle_init_anims(var5);
  script_model_init_anims(var5);

  if(istrue(var4)) {
    heli_add_mg(var5);
  }

  return var5;
}

#using_animtree("");

function script_model_init_anims() {
  level.scr_anim["pilot"]["idle"] = % vh_mindia8_pilot_idle;
  level.scr_animname["pilot"]["idle"] = "vh_mindia8_pilot_idle";
  level.scr_anim["copilot"]["idle"] = $vh_mindia8_copilot_idle;
  level.scr_animname["copilot"]["idle"] = "vh_mindia8_copilot_idle";
}

function agent_init_anims() {
  var0 = "mindia8_";
  var1 = "_idle";
  var2 = "_exit";
  self.loc_array = ["front_l_1", "front_l_2", "front_l_3", "front_r_1", "front_r_2", "front_r_3", "rear_l_1", "rear_l_2", "rear_l_3", "rear_r_1", "rear_r_2", "rear_r_3"];
  self.agent_anims = [];

  foreach(var4 in self.loc_array) {
    self.agent_anims[var4] = spawnStruct();
    self.agent_anims[var4].idle_anim = var0 + var4 + var1;
    self.agent_anims[var4].exit_anim = var0 + var4 + var2;
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

function add_veh_anim(var0, var1, var2, var3) {
  level.scr_anim[var0][var1] = var2;
  level.scr_animname[var0][var1] = var3;
}

function play_vehicle_anim(var0, var1) {
  self animScripted("blah", self.origin, self.angles, level.scr_anim[self.animname][var0]);
  var2 = getanimlength(level.scr_anim[self.animname][var0]);
  wait var2;
}

function agent_spawnai(var0, var1) {
  var2 = [[level.mindia8_spawnaifunc]](self);

  if(isDefined(var2)) {
    agent_put_on_heli(var2, var0, var1, self);
    return var2;
  }
}

function agent_put_on_heli(var0, var1, var2) {
  self.ignoreall = 1;
  self.heli_loc = var0;

  if(!getdvarint("enable_vehicle_ai_using_BT")) {
    self.scripted_mode = 1;
    scripts\asm\asm_mp::carepackage_get_dropped_entities();
  }

  var3 = scripts\asm\asm::asm_lookupanimfromalias("animscripted", var2.agent_anims[var0].idle_anim);
  var4 = scripts\asm\asm::asm_getxanim("animscripted", var3);
  var5 = var2 gettagorigin("body_animate_jnt");
  var6 = var2 gettagangles("body_animate_jnt");
  var7 = getstartorigin(var5, var6, var4);
  var8 = getstartangles(var5, var6, var4);
  self setplayerangles((0, var2.angles[1], 0));
  self setOrigin(var7, 0);

  if(!getdvarint("enable_vehicle_ai_using_BT")) {
    self aisetanim("animscripted", var3);
    self linkTo(var2);
    self playerlinkedoffsetenable();
    return;
  }

  var9 = spawnStruct();
  var9.origin = var7;
  var9.angles = (0, var2.angles[1], 0);
  var9.vehicle_position = var1;
  var10 = spawnStruct();
  var10.exittag = "body_animate_jnt";
  scripts\vehicle\vehicle_common::requestentervehicle(var2, 1, var9, var10);
}

function mindia8_unload(var0) {
  self endon("death");
  self endon("unload_interrupt");
  crew_spawn();
  self setneargoalnotifydist(250);

  if(isDefined(level.mindia8_unloadinterruptfunc)) {
    self thread[[level.mindia8_unloadinterruptfunc]](var0);
  }

  var1 = var0.origin + (0, 0, 527);
  self.goalradius = 4;
  self vehicle_setspeed(40, 25, 7);
  self setvehgoalpos(var1, 1);
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
    var0 = anglesToForward((0, self.angles[1], 0));
    var1 = vec_multiply(var0, 5000);
    self setmaxpitchroll(35, 35);
    self vehicle_setspeed(50, 30, 7);
    self setvehgoalpos(self.origin + var1 + (0, 0, 400), 1);
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
  var0 = 2;

  if(randomint(100) > 50) {
    var0 = 4;

    if(randomint(100) > 50) {
      var0 = 6;
    }

    if(randomint(100) > 50) {
      var0 = 8;
    }
  }

  self vehicle_cleardrivingstate();
  play_vehicle_anim("exit_" + var0);
  var1 = anglesToForward((0, self.angles[1], 0));
  var2 = vec_multiply(var1, 5000);
  self setmaxpitchroll(35, 35);
  self vehicle_setspeedimmediate(50, 50, 7);
  self setvehgoalpos(self.origin + var2 + (0, 0, 200), 1);
  wait 10;
}

function crew_spawn() {
  self.agents = [];

  foreach(var1 in self.loc_array) {
    self.agents[var2] = agent_spawnai(var1, var2 + 2);
  }

  spawn_pilots();
}

#using_animtree("generic_human");

function crew_unload() {
  if(isDefined(level.mindia8_customunloadfunc)) {
    [[level.mindia8_customunloadfunc]](self);
  }

  foreach(var1 in self.agents) {
    thread agent_exit_heli(var1);
  }

  var3 = % vh_mindia8_rear_r_3_exit;
  wait getanimlength(var3) + 3;
  self notify("unloaded");
}

function agent_exit_heli(var0) {
  self endon("death");

  if(!getdvarint("enable_vehicle_ai_using_BT")) {
    self unlink();
    self.deathstate = "animscripted";
    self.deathalias = "death_mindia8_fastrope";
    self.health = 1;
    scripts\asm\shared\mp\utility::burningpartlogic(var0.agent_anims[self.heli_loc].exit_anim, var0, "body_animate_jnt");
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
  var0 = self gettagorigin("body_animate_jnt");
  var1 = self gettagangles("body_animate_jnt");
  var2 = getstartorigin(var0, var1, level.scr_anim["pilot"]["idle"]);
  var3 = getstartangles(var0, var1, level.scr_anim["pilot"]["idle"]);
  var4 = getstartorigin(var0, var1, level.scr_anim["copilot"]["idle"]);
  var5 = getstartangles(var0, var1, level.scr_anim["copilot"]["idle"]);
  self.pilot = spawn("script_model", var2);
  self.pilot.angles = var3;
  self.pilot setModel("aq_pilot_fullbody_1");
  self.copilot = spawn("script_model", var4);
  self.copilot.angles = var5;
  self.copilot setModel("aq_pilot_fullbody_2");
  self.copilot linkTo(self);
  self.pilot linkTo(self);
  self.pilot scriptmodelplayanimdeltamotionfrompos(level.scr_animname["pilot"]["idle"], var0, var1);
  self.copilot scriptmodelplayanimdeltamotionfrompos(level.scr_animname["copilot"]["idle"], var0, var1);
}

function heli_add_mg() {
  var0 = "tag_turret";
  var1 = self gettagorigin(var0);
  var2 = spawnturret("misc_turret", var1, "minida8_turret");
  var2.angles = self gettagangles(var0);
  var2 setModel("veh8_mil_air_mindia8_turret");
  var2 linkTo(self, var0);
  var2 setturretteam("axis");
  var2 setmode("manual");
  var2 setdefaultdroppitch(0);
  var2 setleftarc(360);
  var2 setrightarc(360);
  var2 settoparc(45);
  var2 setbottomarc(90);
  var2 setconvergencetime(0.05, "yaw");
  var2 setconvergencetime(0.05, "pitch");
  var2.heli = self;
  thread scripts\engine\utility::delete_on_death(var2);
  self.mg = var2;
}

function vec_multiply(var0, var1) {
  return (var0[0] * var1, var0[1] * var1, var0[2] * var1);
}