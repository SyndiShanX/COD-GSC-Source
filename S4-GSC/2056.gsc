/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2056.gsc
*************************************************/

init() {
  level._id_7C7E = "icon_waypoint_vehicle_apc";
  level._id_7C7F = "icon_waypoint_vehicle_little_bird";
}

_id_9A08(var_0) {
  if(istrue(var_0._id_89D8)) {
    return;
  }
  var_0._id_89D8 = 1;
  var_0._id_C256 = [];
  var_0._id_1F50 = getdvarint("#x38805b9fa0b0f283c");

  if(!isDefined(level._id_BFC6)) {
    level._id_BFC6 = [];
  }

  level._id_BFC6[level._id_BFC6.size] = var_0;
  thread _id_10B3A(var_0);
  thread _id_10B45(var_0);
}

_id_C29E(var_0, var_1) {
  if(!istrue(var_1._id_89D8)) {
    _id_44EE("Trying to register a player with an object that is not a rally point.");
    return;
  }

  _id_44EE(var_0.name + " has been registered wtih rally point: " + var_1._id_0481);
  var_0._id_BFBD = var_1;
  var_0._id_24C6 = 0;
  var_1._id_C256[var_1._id_C256.size] = var_0;
}

_id_10B3A(var_0) {
  while(isDefined(var_0)) {
    foreach(var_2 in var_0._id_C256) {
      if(!isDefined(var_2)) {
        var_0._id_C256 = scripts\engine\utility::array_remove(var_0._id_C256, var_2);
        continue;
      }

      if(!scripts\mp\utility\player::isreallyalive(var_2) && isDefined(var_2._id_BFBD) && !var_2._id_24C6) {
        _id_BBBD(var_2, var_0);
      }
    }

    wait 0.1;
  }
}

_id_BBBD(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("team_eliminated");
  var_2 = ["rally_point_respawn", "rally_point_destroyed"];
  var_3 = var_0 scripts\engine\utility::_id_10890(var_2, var_1._id_1F50);

  if(var_3 == "rally_point_destroyed") {
    if(isDefined(var_0) || !scripts\mp\utility\player::isreallyalive(var_0)) {
      return;
    }
    var_4 = var_0 _id_0A99::_id_6B27();
    var_5 = var_4._id_F1E8;
    var_0 _id_0A99::_id_D5EA(28, int(gettime() + self._id_F283 * 1000));
    waitframe();
    var_0._id_98CB _meth_8391(var_0._id_F215);
    return;
  }

  var_0._id_24C6 = 1;
  var_6 = vectornormalize(anglesToForward(var_1.angles));
  var_6 = var_6 * -175 + var_1.origin;
  var_0._id_5EC7 = _func_02AB(var_6);
  waitframe();
  _id_44EE("Player respawning at rally point location:" + var_0._id_5EC7);
  var_0._id_5EC2 = (0, 90, 0);
  var_0 notify("last_stand_revived");
  var_0 scripts\mp\utility\player::_freezecontrols(0);
  var_0 thread _id_081F::_id_C671();
  var_0 setclientomnvar("ui_securing", 0);
  var_0 setclientomnvar("ui_securing_progress", 0.01);
  var_0._id_F913 = undefined;

  while(!scripts\mp\utility\player::isreallyalive(var_0)) {
    wait 0.1;
  }

  var_0._id_24C6 = 0;
}

_id_10B45(var_0) {
  var_0 waittill("death");

  foreach(var_2 in var_0._id_C256) {
    var_2 notify("rally_point_destroyed");
    var_2 iprintlnbold("Your Rally Point has been destroyed");
  }
}

_id_44EE(var_0) {
  if(1) {
    return;
  }
}

_id_BFC7(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle_tracking::_id_6E3F(var_0);
  var_2 = var_0.team;
  var_3 = var_1._id_C189;
  var_0._id_89D9 = 1;
  thread _id_0819::_id_10311(var_0);

  if(var_2 == "axis") {
    _id_0819::_id_10A5(var_2, var_0, var_3, (0, 0, 128));

    if(!isDefined(level._id_1FED)) {
      level._id_1FED = [];
    }

    level._id_1FED[level._id_1FED.size] = var_3;
    _id_0819::_id_D6D8(level._id_1FED, var_2);
  } else {
    _id_0819::_id_10A5(var_2, var_0, var_3, (0, 0, 128));

    if(!isDefined(level._id_1516)) {
      level._id_1516 = [];
    }

    level._id_1516[level._id_1516.size] = var_3;
    _id_0819::_id_D6D8(level._id_1516, var_2);
  }

  var_0._id_C189 = var_3;
  _id_BFBE(var_0);
  thread _id_BFC3(var_0);
  thread _id_BFC4(var_0);
}

_id_BFC8(var_0) {}

_id_BFC0(var_0) {
  var_0 endon("death");
  _id_07D1::_id_60C2("prematch_done");

  foreach(var_2 in level.players) {
    if(var_2.team == var_0.team) {
      _id_07F9::_id_A89D(var_0._id_9B4D._id_A908, var_2);
      var_2 _id_0A99::_id_D5EA(63, undefined, 5);
    }
  }
}

_id_BFC3(var_0) {
  var_0 waittill("death");

  if(var_0.team == "axis") {
    level._id_1FED = scripts\engine\utility::array_remove(level._id_1FED, var_0._id_C189);
  } else {
    level._id_1516 = scripts\engine\utility::array_remove(level._id_1516, var_0._id_C189);
  }

  _id_BFBF(var_0);
  _id_0819::_id_C496(var_0.team, var_0._id_C189);
  _id_0819::_id_C521(var_0._id_C189, var_0.team);
}

_id_BFBE(var_0) {
  var_1 = "friendly";
  var_2 = var_0.origin + (0, 0, 128);
  var_3 = _id_07D6::_id_4026(var_2, "neutral", (0, 0, 0), undefined, var_1, 0);
  _id_07F9::_id_FB96(var_3._id_A908, var_0.team);
  var_0._id_9B4D = var_3;

  if(_id_07D1::_id_60BE("prematch_done")) {
    foreach(var_5 in level.players) {
      if(var_5.team == var_0.team) {
        _id_07F9::_id_A89D(var_0._id_9B4D._id_A908, var_5);
        var_5 _id_0A99::_id_D5EA(63, undefined, 5);
      }
    }
  } else {
    _id_07F9::_id_A89F(var_3._id_A908);
    thread _id_BFC0(var_0);
  }

  _id_07F9::_id_A8B1(var_3._id_A908, 0);
  var_3._id_970A = 0;
  _id_07F9::_id_A89A(var_3._id_A908, 0);
  _id_07F9::_id_FB8F(var_3._id_A908, scripts\engine\utility::ter_op(var_0._id_1031E == "little_bird", level._id_7C7F, level._id_7C7E));
  _id_07F9::_id_FB98(var_3._id_A908, 0);
  _id_07F9::_id_FB93(var_3._id_A908, var_0);
  _id_07F9::_id_FB9D(var_0._id_9B4D._id_A908, 128);
  var_3._id_970A = 1;
  var_0._id_9B4D = var_3;
}

_id_BFBF(var_0) {
  var_0._id_9B4D _id_07D6::_id_D8E0("none");
  var_0._id_9B4D _id_07D6::_id_C300();
  var_0._id_9B4D._id_1041A = "none";
}

_id_BFC4(var_0) {
  var_0 endon("death");

  while(!_id_07D1::_id_60BE("prematch_done")) {
    waitframe();
  }

  var_1 = spawn("trigger_radius", var_0.origin - (0, 0, 512), 0, 1024, 1536);
  var_1 thread _id_10BEF(var_0);
  var_1 waittill("rallyPoint_revealed");
  var_1 delete();
}

_id_10BEF(var_0) {
  self endon("rallyPoint_revealed");
  var_0 endon("death");

  for(;;) {
    self waittill("trigger", var_1);
    waitframe();

    if(!isPlayer(var_1)) {
      continue;
    }
    if(!isalive(var_1)) {
      continue;
    }
    if(var_1.team == var_0.team) {
      continue;
    }
    var_0._id_C7B0 = 1;

    foreach(var_3 in level.players) {
      _id_07F9::_id_A89D(var_0._id_9B4D._id_A908, var_3);
    }

    self notify("rallyPoint_revealed");
  }
}

_id_BFC1(var_0) {
  var_0 endon("death_or_disconnect");

  while(!_id_07D1::_id_60BE("prematch_done")) {
    waitframe();
  }

  while(!isDefined(var_0.team) || var_0.team == "spectator") {
    waitframe();
  }

  if(isDefined(level._id_BFC9)) {
    foreach(var_2 in level._id_BFC9) {
      if(!isDefined(var_2)) {
        continue;
      }
      if(var_0.team == var_2.team) {
        _id_07F9::_id_A89D(var_2._id_9B4D._id_A908, var_0);
      }
    }
  }
}