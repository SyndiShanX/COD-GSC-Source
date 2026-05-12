/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_ds_bot.gsc
*********************************************/

func_00F9() {
  var_00 = getdvarint("ds_bot_test");
  if(var_00 != 0) {
    thread func_09F4();
    setDvar("scr_testclients", var_00);
    setDvar("scr_testclients_type", "0");
    setDvar("scr_devchangetimelimit", "-1");
  }
}

func_09F4() {
  wait(5);
  for(;;) {
    if(getdvarint("scr_testclients") > 0) {
      break;
    }

    wait(1);
  }

  var_00 = getdvarint("scr_testclients");
  setDvar("scr_testclients", 0);
  var_01 = func_9918();
  if(var_00) {
    setDvar("bot_DisableAutoConnect", "1");
  }

  if(var_01) {
    level thread[[level.var_19D5["bots_spawn"]]](var_00, "autoassign");
  } else {
    level func_9007(var_00);
  }

  if(maps\mp\_utility::func_602B()) {
    setmatchdata("match_common", "has_bots", 1);
  }

  thread func_8744();
  thread func_871C();
  thread func_09F4();
}

func_8744() {
  var_00 = getdvarint("ds_time_limit");
  if(var_00 > 0) {
    var_01 = getdvarfloat("ds_time_limit") / 60;
    level.var_9309 = gettime();
    var_02 = "scr_" + level.var_3FDC + "_timelimit";
    level.var_A901[var_02].var_A281 = var_01;
    setDvar(var_02, var_01);
  }
}

func_871C() {
  var_00 = getdvarint("ds_score_limit");
  if(var_00 > 0) {
    var_01 = "scr_" + level.var_3FDC + "_scorelimit";
    level.var_A901[var_01].var_A281 = var_00;
    setDvar(var_01, var_00);
  }
}

func_9007(param_00) {
  var_01 = [];
  while(var_01.size < param_00) {
    wait 0.05;
    if(function_0367()) {
      var_02 = function_0166(1, level.var_746E);
    } else {
      var_02 = function_0166(1);
    }

    if(!isDefined(var_02)) {
      wait(1);
      continue;
    } else {
      var_03 = spawnStruct();
      var_03.var_9843 = var_02;
      var_03.var_7ABD = 0;
      var_03.var_0843 = 0;
      var_01[var_01.size] = var_03;
      var_03.var_9843 thread func_535E("autoassign", var_03);
    }
  }

  var_04 = 0;
  while(var_04 < var_01.size) {
    var_04 = 0;
    foreach(var_03 in var_01) {
      if(var_03.var_7ABD || var_03.var_0843) {
        var_04++;
      }
    }

    wait 0.05;
  }
}

func_535E(param_00, param_01) {
  while(!self canspawntestclient()) {
    wait 0.05;
    if(!isDefined(self)) {
      if(isDefined(param_01)) {
        param_01.var_0843 = 1;
      }

      return;
    }
  }

  self spawntestclient();
  maps\mp\gametypes\_playerlogic::func_90A5();
  while(!isDefined(self.var_012C["team"])) {
    wait 0.05;
    if(!isDefined(self)) {
      if(isDefined(param_01)) {
        param_01.var_0843 = 1;
      }

      return;
    }
  }

  self[[level.var_1385]]();
  if(maps\mp\_utility::func_0C1E()) {
    var_02 = "class" + randomint(5);
    self notify("luinotifyserver", "class_select", var_02);
  }

  common_scripts\utility::func_A74B("spawned_player", 0.5);
  wait(0.1);
  if(isDefined(param_01)) {
    param_01.var_7ABD = 1;
  }
}

func_9918() {
  var_00 = getdvarint("scr_testclients_type") == 0;
  if(var_00) {
    if(!isDefined(level.var_19D5) || !isDefined(level.var_19D5["bots_spawn"])) {
      var_00 = 0;
    }
  }

  return var_00;
}