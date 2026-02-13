/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2459.gsc
*************************************************/

_id_806F() {
  wait 5;
  level._id_6292 = [];
  level._id_6292 = scripts\engine\utility::getstructarray("generator", "script_noteworthy");
  scripts\engine\utility::_id_5C11("power_on");
  level._id_BAB8 = ::_id_BAB9;

  foreach(var_1 in level._id_6292) {
    _id_7F95(var_1);
  }
}

_id_7F95(var_0) {
  var_1 = getEntArray(var_0.target, "targetname");
  var_2 = scripts\engine\utility::getstruct(var_0.target, "targetname");
  var_0._id_73E3 = undefined;
  var_0._id_2968 = undefined;

  foreach(var_4 in var_1) {
    if(var_4.model == "icbm_electricpanel_switch_02") {
      var_0._id_73E3 = var_4;
      continue;
    }

    if(var_4._id_039B == "box") {
      var_0._id_2968 = var_4;
    }
  }
}

_id_BAB9(var_0, var_1) {
  var_2 = level._id_6292;

  foreach(var_4 in var_2) {
    if(istrue(var_4._id_BAD8)) {
      level thread _id_6291(var_4);
    }
  }

  level notify("power_off");
}

_id_6291(var_0) {
  while(!isDefined(level._id_417B)) {
    wait 1;
  }

  thread _id_629A(var_0);
  var_1 = var_0._id_CE18;
  var_2 = strtok(var_1, ",");

  foreach(var_4 in var_2) {
    if(var_4 == "power_all") {
      scripts\engine\utility::_id_5C04("power_on");
      continue;
    }

    if(scripts\engine\utility::_id_5C0C(var_4 + " power_on")) {
      scripts\engine\utility::_id_5C04(var_4 + " power_on");
    }
  }

  var_0._id_BAD8 = undefined;
  _id_0737::_id_1037(var_0);
}

_id_629A(var_0) {
  if(var_0._id_73E3._id_039B == "roll") {
    var_0._id_73E3 rotateroll(-60, 0.5);
  } else if(var_0._id_73E3._id_039B == "-roll") {
    var_0._id_73E3 rotateroll(60, 0.5);
  } else if(var_0._id_73E3._id_039B == "pitch") {
    var_0._id_73E3 rotatepitch(-60, 0.5);
  } else if(var_0._id_73E3._id_039B == "-pitch") {
    var_0._id_73E3 rotatepitch(60, 0.5);
  }

  if(isDefined(var_0._id_6290)) {
    var_0._id_6290 delete();
  }
}

_id_F813(var_0) {
  _id_0995::_id_974E(var_0, level._id_10C9F);
}

_id_6299(var_0, var_1) {
  _id_0737::_id_C3C5(var_0);

  if(isDefined(var_1)) {
    var_1 thread scripts\cp\utility::_id_5B75(var_1, "iw7_powerlever_zm");
  }

  if(!isDefined(var_1)) {
    var_1 = level.players[0];
  }

  if(isDefined(var_0.target)) {
    _id_629B(var_0, var_1);
  }

  var_2 = var_0._id_CE18;
  var_3 = strtok(var_2, ",");
  _id_F813(var_3[0]);
  level notify("power_on_scriptable_and_light", var_2, var_1);
  wait 2.5;

  foreach(var_5 in var_3) {
    if(!isDefined(var_5)) {}

    if(var_5 == "power_all") {
      level notify("power_on");
      scripts\engine\utility::_id_5C1B("power_on");
      level._id_BABB = 1;
      continue;
    }

    level notify(var_5 + " power_on");

    if(scripts\engine\utility::_id_5C0C(var_5 + " power_on")) {
      scripts\engine\utility::_id_5C1B(var_5 + " power_on");
    }
  }

  waitframe();
  level notify("activate_power");
  var_1 thread _id_076F::_id_F72D("activate_power", "zmb_comment_vo", "medium", 4, 0, 0, 0, 50);

  if(isDefined(level._id_BACF)) {
    thread[[level._id_BACF]](var_1);
  }

  wait 0.5;
  level thread _id_C1A6();
}

_id_C1A6() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1._id_8F31) && isDefined(var_1._id_8F31._id_C588)) {
      var_1 notify("stop_interaction_logic");
      var_1._id_8388 makeunusable();
      var_1._id_8F31 = undefined;
    }

    wait 0.05;
  }
}

_id_629B(var_0, var_1) {
  level endon("power_off");
  wait 0.2;

  if(var_0._id_73E3._id_039B == "roll") {
    var_0._id_73E3 rotateroll(75, 0.15);
  } else if(var_0._id_73E3._id_039B == "-roll") {
    var_0._id_73E3 rotateroll(-75, 0.15);
  } else if(var_0._id_73E3._id_039B == "pitch") {
    var_0._id_73E3 rotatepitch(75, 0.15);
  } else if(var_0._id_73E3._id_039B == "-pitch") {
    var_0._id_73E3 rotatepitch(-75, 0.15);
  }

  if(isDefined(var_0._id_2968)) {
    var_0._id_2968 setscriptablepartstate("box", "on");
  }

  var_0._id_BAD8 = 1;
}

_id_C1EF() {
  level._id_835D["generator"] = &"COOP_INTERACTIONS/GENERATOR_ON";
  _id_0737::_id_C1EE("generator", "generator", 1, undefined, ::_id_6299, 0);
}