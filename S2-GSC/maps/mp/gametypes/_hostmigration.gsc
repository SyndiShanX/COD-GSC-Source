/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_hostmigration.gsc
************************************************/

func_1E65() {
  level.var_4E08 = 0;
  if(level.var_3F9D) {
    return;
  }

  var_00 = getmatchdata("match_common", "hostMigrationCount");
  var_00++;
  setmatchdata("match_common", "hostMigrationCount", var_00);
  foreach(var_02 in function_02D1()) {
    var_02.var_4E05 = 0;
  }

  level.var_4E09 = 1;
  setDvar("ui_inhostmigration", 1);
  level notify("host_migration_begin");
  maps\mp\gametypes\_gamelogic::func_A17B();
  foreach(var_02 in function_02D1()) {
    if(isDefined(var_02.waterwakevfxdeletefunc)) {
      var_02[[var_02.waterwakevfxdeletefunc]]();
    }

    if(isDefined(var_02.onhostmigrationbeginfunc)) {
      var_02[[var_02.onhostmigrationbeginfunc]]();
    }

    var_02 thread func_4E0A();
    if(isPlayer(var_02)) {
      var_02 setclientomnvar("ui_session_state", var_02.var_0178);
      var_02 luinotifyevent(&"host_migration_show_hud", 0);
    }
  }

  setDvar("2523", game["state"]);
  level endon("host_migration_begin");
  func_4E0C();
  level.var_4E09 = undefined;
  setDvar("ui_inhostmigration", 0);
  level notify("host_migration_end");
  maps\mp\gametypes\_gamelogic::func_A17B();
  level thread maps\mp\gametypes\_gamelogic::func_A11E();
}

func_4E0C() {
  level endon("game_ended");
  level.var_5139 = 25;
  thread maps\mp\gametypes\_gamelogic::func_6037(20);
  func_4E0D();
  level.var_5139 = 10;
  thread maps\mp\gametypes\_gamelogic::func_6037(5);
  wait(5);
  level.var_5139 = 0;
}

func_4E0D() {
  level endon("hostmigration_enoughplayers");
  wait(15);
}

func_4E07(param_00) {
  if(!isDefined(param_00)) {
    return "<removed_ent>";
  }

  var_01 = -1;
  var_02 = "?";
  if(isDefined(param_00.var_37CD)) {
    var_01 = param_00.var_37CD;
  }

  if(isPlayer(param_00) && isDefined(param_00.var_0109)) {
    var_02 = param_00.var_0109;
  }

  if(isPlayer(param_00)) {
    return "player <" + var_02 + "> (entNum " + var_01 + " )";
  }

  if(function_01EF(param_00) && maps\mp\_utility::func_56FF(param_00)) {
    return "participant agent <" + var_01 + ">";
  }

  if(function_01EF(param_00)) {
    return "non-participant agent <" + var_01 + ">";
  }

  return "unknown entity <" + var_01 + ">";
}

func_4E0B() {
  level endon("host_migration_begin");
  level endon("host_migration_end");
  self endon("disconnect");
  self.var_4E05 = 1;
  while(!maps\mp\_utility::func_57A0(self)) {
    self waittill("spawned");
  }

  maps\mp\_utility::func_3E8E(1);
  self method_800F();
  level waittill("host_migration_end");
}

func_4E0A() {
  level endon("host_migration_begin");
  self endon("disconnect");
  if(function_01EF(self)) {
    self endon("death");
  }

  func_4E0B();
  if(self.var_4E05) {
    if(maps\mp\_utility::func_3FA0("prematch_done")) {
      maps\mp\_utility::func_3E8E(0);
      self method_800E();
    }

    self.var_4E05 = undefined;
  }
}

func_A782() {
  if(!isDefined(level.var_4E09)) {
    return 0;
  }

  var_00 = gettime();
  level waittill("host_migration_end");
  return gettime() - var_00;
}

func_A783(param_00) {
  if(isDefined(level.var_4E09)) {
    return;
  }

  level endon("host_migration_begin");
  wait(param_00);
}

func_A6F5(param_00) {
  if(param_00 == 0) {
    return;
  }

  var_01 = gettime();
  var_02 = gettime() + param_00 * 1000;
  while(gettime() < var_02) {
    func_A783(var_02 - gettime() / 1000);
    if(isDefined(level.var_4E09)) {
      var_03 = func_A782();
      var_02 = var_02 + var_03;
    }
  }

  func_A782();
  return gettime() - var_01;
}

func_A74C(param_00, param_01) {
  self endon(param_00);
  if(param_01 == 0) {
    return;
  }

  var_02 = gettime();
  var_03 = gettime() + param_01 * 1000;
  while(gettime() < var_03) {
    func_A783(var_03 - gettime() / 1000);
    if(isDefined(level.var_4E09)) {
      var_04 = func_A782();
      var_03 = var_03 + var_04;
    }
  }

  func_A782();
  return gettime() - var_02;
}

func_A6F4(param_00) {
  if(param_00 == 0) {
    return;
  }

  var_01 = gettime();
  var_02 = gettime() + param_00 * 1000;
  while(gettime() < var_02) {
    func_A783(var_02 - gettime() / 1000);
    while(isDefined(level.var_4E09)) {
      var_02 = var_02 + 1000;
      setgameendtime(int(var_02));
      wait(1);
    }
  }

  while(isDefined(level.var_4E09)) {
    var_02 = var_02 + 1000;
    setgameendtime(int(var_02));
    wait(1);
  }

  return gettime() - var_01;
}