/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_ds_bot.gsc
***************************************/

main() {
  var_0 = getdvarint("ds_bot_test");

  if(var_0 != 0) {
    thread _id_09F4();
    setDvar("scr_testclients", var_0);
    setDvar("scr_testclients_type", "0");
    setDvar("scr_devchangetimelimit", "-1");
  }
}

_id_09F4() {
  wait 5;

  for(;;) {
    if(getdvarint("scr_testclients") > 0) {
      break;
    }

    wait 1;
  }

  var_0 = getdvarint("scr_testclients");
  setDvar("scr_testclients", 0);
  var_1 = _id_9918();

  if(var_0) {
    setDvar("bot_DisableAutoConnect", "1");
  }

  if(var_1) {
    level thread[[level.bot_funcs["bots_spawn"]]](var_0, "autoassign");
  } else {
    level _id_9007(var_0);
  }

  if(maps\mp\_utility::matchmakinggame()) {
    setmatchdata("match_common", "has_bots", 1);
  }

  thread _id_8744();
  thread _id_871C();
  thread _id_09F4();
}

_id_8744() {
  var_0 = getdvarint("ds_time_limit");

  if(var_0 > 0) {
    var_1 = getdvarfloat("ds_time_limit") / 60;
    level.starttime = gettime();
    var_2 = "scr_" + level.gametype + "_timelimit";
    level.watchdvars[var_2].value = var_1;
    setDvar(var_2, var_1);
  }
}

_id_871C() {
  var_0 = getdvarint("ds_score_limit");

  if(var_0 > 0) {
    var_1 = "scr_" + level.gametype + "_scorelimit";
    level.watchdvars[var_1].value = var_0;
    setDvar(var_1, var_0);
  }
}

_id_9007(var_0) {
  var_1 = [];

  while(var_1.size < var_0) {
    waitframe();

    if(_func_367()) {
      var_2 = _func_166(1, level._id_746E);
    } else {
      var_2 = _func_166(1);
    }

    if(!isDefined(var_2)) {
      wait 1;
      continue;
    } else {
      var_3 = spawnStruct();
      var_3._id_9843 = var_2;
      var_3._id_7ABD = 0;
      var_3._id_0843 = 0;
      var_1[var_1.size] = var_3;
      var_3._id_9843 thread _id_535E("autoassign", var_3);
    }
  }

  var_4 = 0;

  while(var_4 < var_1.size) {
    var_4 = 0;

    foreach(var_3 in var_1) {
      if(var_3._id_7ABD || var_3._id_0843) {
        var_4++;
      }
    }

    waitframe();
  }
}

_id_535E(var_0, var_1) {
  while(!self canspawntestclient()) {
    waitframe();

    if(!isDefined(self)) {
      if(isDefined(var_1)) {
        var_1._id_0843 = 1;
      }

      return;
    }
  }

  self spawntestclient();
  maps\mp\gametypes\_playerlogic::_id_90A5();

  while(!isDefined(self.pers["team"])) {
    waitframe();

    if(!isDefined(self)) {
      if(isDefined(var_1)) {
        var_1._id_0843 = 1;
      }

      return;
    }
  }

  self[[level._id_1385]]();

  if(maps\mp\_utility::_id_0C1E()) {
    var_2 = "class" + randomint(5);
    self notify("luinotifyserver", "class_select", var_2);
  }

  common_scripts\utility::waittill_notify_or_timeout("spawned_player", 0.5);
  wait 0.1;

  if(isDefined(var_1)) {
    var_1._id_7ABD = 1;
  }
}

_id_9918() {
  var_0 = getdvarint("scr_testclients_type") == 0;

  if(var_0) {
    if(!isDefined(level.bot_funcs) || !isDefined(level.bot_funcs["bots_spawn"])) {
      var_0 = 0;
    }
  }

  return var_0;
}