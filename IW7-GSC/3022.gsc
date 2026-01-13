/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3022.gsc
*********************************************/

main(var_0) {
  if(!isDefined(level.var_A3B9)) {
    level.var_A3B9 = spawnStruct();
    level.var_A3B9.var_11888 = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_rear_thrust_fly_atmosphere.vfx");
    level.var_A3B9.var_10573 = loadfx("vfx\old\space_fighter\space_particulate_player_oneshot.vfx");
    level.var_A3B9.var_375D = var_0;
    level.var_A3B9.var_375D.var_444F = ::init;
    func_A22F(var_0);
  }
}

func_A22F(var_0) {
  var_1 = getEntArray("script_vehicle", "code_classname");
  foreach(var_3 in var_1) {
    if(isspawner(var_3) || !isaircraft(var_3) || !func_1312C(var_3)) {
      continue;
    }

    var_3 init();
  }
}

func_1312C(var_0) {
  var_1 = ["script_vehicle_jackal_friendly", "script_vehicle_jackal_friendly_moon", "script_vehicle_jackal_friendly_heist", "script_vehicle_jackal_friendly_pearl", "script_vehicle_jackal_friendly_marsbase_cheap", "script_vehicle_jackal_enemy", "script_vehicle_jackal_enemy_marsbase_cheap", "script_vehicle_jackal_fake_friendly", "script_vehicle_jackal_fake_enemy"];
  if(scripts\engine\utility::array_contains(var_1, var_0.classname)) {
    return 1;
  }

  return 0;
}

init() {
  if(isDefined(level.var_A3B9) && !isDefined(self.var_A3B9)) {
    var_0 = level.var_A3B9.var_375D;
    self.var_A3B9 = spawnStruct();
    self.var_A3B9.var_375D = var_0;
    func_9639();
    self[[var_0.init]]();
  }
}

func_9639() {
  self.var_5958 = 1;
  self.var_C1DB = 0;
  self _meth_8455(self.origin);
}

func_A2B2(var_0, var_1, var_2) {
  var_0 notify("enter_jackal");
  self setplayerangles(var_0.angles);
  var_0.triggerportableradarping = self;
  self.ignoreme = 1;
  self remotecontrolvehicle(var_0);
  var_0 makeentitysentient(self.team, 0);
  var_0 setvehicleteam(self.team);
  if(isDefined(var_1)) {
    self.var_E473 = self getorigin();
    self setorigin(var_1);
  }

  if(!isDefined(var_2)) {
    var_2 = "fly";
  }

  var_0 _meth_8491(var_2);
  self _meth_8490("disable_pilot_move_assist", 1);
  thread monitorboost(var_0, self);
}

func_A2B1(var_0) {
  self notify("exit_jackal");
  self remotecontrolvehicleoff();
  if(isDefined(self.var_E473)) {
    self setorigin(self.var_E473);
  }

  self.ignoreme = 0;
  var_0.triggerportableradarping = undefined;
}

func_104FE() {
  level notify("stop_particulates");
  level endon("stop_particulates");
  thread func_104FF();
  for(;;) {
    var_0 = anglesToForward(level.var_D127.angles) * 300;
    playFX(scripts\engine\utility::getfx("space_particulate_player"), level.var_D127.origin + var_0);
    wait(0.6);
  }
}

func_104FF() {
  level endon("stop_particulates");
  for(;;) {
    var_0 = level.var_D127.origin;
    wait(0.1);
    if(distance(var_0, level.var_D127.origin) > 1) {
      var_1 = vectortoangles(level.var_D127.origin - var_0);
      var_2 = anglesToForward(var_1) * 256;
      playFX(scripts\engine\utility::getfx("space_particulate_player"), level.var_D127.origin + var_2);
    }
  }
}

monitorboost(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("disconnect");
  var_1 endon("exit_jackal");
  var_0 endon("death");
  for(;;) {
    while(!var_0.isnonentspawner) {
      scripts\engine\utility::waitframe();
    }

    var_1 notify("engage boost");
    while(var_0.isnonentspawner) {
      scripts\engine\utility::waitframe();
    }

    var_1 notify("disengage boost");
  }
}

func_7DB5() {
  var_0 = [];
  var_1 = vehicle_getarray();
  foreach(var_3 in var_1) {
    if(isaircraft(var_3)) {
      var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}

func_10056() {
  if(isDefined(level.var_241D) && level.var_241D) {
    return 0;
  }

  return 1;
}