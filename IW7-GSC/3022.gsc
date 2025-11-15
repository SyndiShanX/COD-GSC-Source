/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3022.gsc
************************/

main(param_00) {
  if(!isDefined(level.var_A3B9)) {
    level.var_A3B9 = spawnStruct();
    level.var_A3B9.var_11888 = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_rear_thrust_fly_atmosphere.vfx");
    level.var_A3B9.var_10573 = loadfx("vfx\old\space_fighter\space_particulate_player_oneshot.vfx");
    level.var_A3B9.var_375D = param_00;
    level.var_A3B9.var_375D.var_444F = ::init;
    func_A22F(param_00);
  }
}

func_A22F(param_00) {
  var_01 = getEntArray("script_vehicle", "code_classname");
  foreach(var_03 in var_01) {
    if(isspawner(var_03) || !isaircraft(var_03) || !func_1312C(var_03)) {
      continue;
    }

    var_03 init();
  }
}

func_1312C(param_00) {
  var_01 = ["script_vehicle_jackal_friendly", "script_vehicle_jackal_friendly_moon", "script_vehicle_jackal_friendly_heist", "script_vehicle_jackal_friendly_pearl", "script_vehicle_jackal_friendly_marsbase_cheap", "script_vehicle_jackal_enemy", "script_vehicle_jackal_enemy_marsbase_cheap", "script_vehicle_jackal_fake_friendly", "script_vehicle_jackal_fake_enemy"];
  if(scripts\engine\utility::array_contains(var_01, param_00.classname)) {
    return 1;
  }

  return 0;
}

init() {
  if(isDefined(level.var_A3B9) && !isDefined(self.var_A3B9)) {
    var_00 = level.var_A3B9.var_375D;
    self.var_A3B9 = spawnStruct();
    self.var_A3B9.var_375D = var_00;
    func_9639();
    self[[var_00.init]]();
  }
}

func_9639() {
  self.var_5958 = 1;
  self.var_C1DB = 0;
  self _meth_8455(self.origin);
}

func_A2B2(param_00, param_01, param_02) {
  param_00 notify("enter_jackal");
  self setplayerangles(param_00.angles);
  param_00.triggerportableradarping = self;
  self.ignoreme = 1;
  self remotecontrolvehicle(param_00);
  param_00 makeentitysentient(self.team, 0);
  param_00 setvehicleteam(self.team);
  if(isDefined(param_01)) {
    self.var_E473 = self getorigin();
    self setorigin(param_01);
  }

  if(!isDefined(param_02)) {
    param_02 = "fly";
  }

  param_00 _meth_8491(param_02);
  self _meth_8490("disable_pilot_move_assist", 1);
  thread monitorboost(param_00, self);
}

func_A2B1(param_00) {
  self notify("exit_jackal");
  self remotecontrolvehicleoff();
  if(isDefined(self.var_E473)) {
    self setorigin(self.var_E473);
  }

  self.ignoreme = 0;
  param_00.triggerportableradarping = undefined;
}

func_104FE() {
  level notify("stop_particulates");
  level endon("stop_particulates");
  thread func_104FF();
  for(;;) {
    var_00 = anglesToForward(level.var_D127.angles) * 300;
    playFX(scripts\engine\utility::getfx("space_particulate_player"), level.var_D127.origin + var_00);
    wait(0.6);
  }
}

func_104FF() {
  level endon("stop_particulates");
  for(;;) {
    var_00 = level.var_D127.origin;
    wait(0.1);
    if(distance(var_00, level.var_D127.origin) > 1) {
      var_01 = vectortoangles(level.var_D127.origin - var_00);
      var_02 = anglesToForward(var_01) * 256;
      playFX(scripts\engine\utility::getfx("space_particulate_player"), level.var_D127.origin + var_02);
    }
  }
}

monitorboost(param_00, param_01) {
  level endon("game_ended");
  param_01 endon("disconnect");
  param_01 endon("exit_jackal");
  param_00 endon("death");
  for(;;) {
    while(!param_00.isnonentspawner) {
      scripts\engine\utility::waitframe();
    }

    param_01 notify("engage boost");
    while(param_00.isnonentspawner) {
      scripts\engine\utility::waitframe();
    }

    param_01 notify("disengage boost");
  }
}

func_7DB5() {
  var_00 = [];
  var_01 = vehicle_getarray();
  foreach(var_03 in var_01) {
    if(isaircraft(var_03)) {
      var_00[var_00.size] = var_03;
    }
  }

  return var_00;
}

func_10056() {
  if(isDefined(level.var_241D) && level.var_241D) {
    return 0;
  }

  return 1;
}