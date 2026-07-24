/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3813.gsc
**************************************/

_id_202D(var_0, var_1, var_2) {
  self endon("death");
  _id_2033();

  if(!isDefined(var_2)) {
    var_3 = _id_0EF1::_id_789F();
  } else {
    var_3 = var_2;
  }

  var_4 = _id_2034(var_0);

  switch (var_4) {
    case "Defined Reaction":
      _id_2031(var_0, var_1, var_3);
      break;
    case "Defined Idle":
      _id_2030(var_0, var_1, var_3);
      break;
    case "Undefined":
      _id_2038(var_1, var_3);
      break;
    default:
  }
}

_id_10FC4() {
  if(isai(self)) {
    self notify("reaction_end");
    self notify("stop_smart_reaction");
    thread scripts\sp\utility::_id_77B9(0.5);
    scripts\sp\interaction::_id_9A0F();
  } else {
    self notify("reaction_end");
    self notify("stop_smart_reaction");
    thread scripts\sp\utility::_id_77B9(0.5);
  }
}

_id_DB62(var_0, var_1) {
  self endon("death");

  if(isDefined(var_1)) {
    var_1 = self;
  }

  var_1 waittill(var_0);
  _id_10FC4();
}

_id_2031(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = _id_0EF1::_id_7BEA(var_2);
  }

  var_0 = _id_3DC8(var_0);
  thread scripts\sp\interaction::_id_CE18(var_0, var_1, var_2);
}

_id_2030(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = _id_0EF1::_id_7BEA(var_2);
  }

  var_3 = _id_80E0(var_0);
  thread scripts\sp\interaction::_id_CE1A(var_3, var_1, var_2);
}

_id_2038(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = _id_0EF1::_id_7BEA(var_1);
  }

  thread scripts\sp\interaction::_id_CE16(var_0, var_1);
}

_id_2037(var_0, var_1, var_2) {
  _id_2033();
  _id_10FC4();

  if(!scripts\sp\interaction::_id_9C27(var_0)) {
    return;
  }
  if(!isDefined(var_2)) {
    var_3 = _id_0EF1::_id_789F();
  } else {
    var_3 = var_2;
  }

  if(!isDefined(var_1) || !isstring(var_1)) {
    var_1 = _id_0EF1::_id_7BEA(var_3);
  }

  scripts\engine\utility::delaythread(0.05, scripts\sp\interaction::_id_CE1A, var_0, var_1, var_3);
}

_id_2036(var_0) {
  _id_2033();
  var_1 = _id_80E0(var_0);
  thread scripts\sp\interaction::_id_CE1B(var_1);
}

_id_2033() {
  if(!scripts\engine\utility::flag_exist("antiZombie_initialized")) {
    _id_9838();
    scripts\engine\utility::flag_init("antiZombie_initialized");
  }
}

_id_2034(var_0) {
  var_1 = "unknown";

  if(isDefined(var_0)) {
    if(isnumber(var_0)) {
      var_1 = "Defined Idle";
    } else if(scripts\sp\interaction::_id_9C27(var_0)) {
      var_1 = "Defined Reaction";
    } else {
      var_1 = "Undefined";
    }
  } else
    var_1 = "Undefined";

  return var_1;
}

_id_7823() {
  var_0 = [];
  var_0[var_0.size] = "Captain.";
  var_0[var_0.size] = "Sir.";
  return var_0;
}

_id_7D9B() {
  return 4;
}

_id_80E0(var_0) {
  var_1 = "none";

  switch (var_0) {
    case 1:
      var_1 = "stand_idle_1_right_reaction";
      break;
    case 2:
      var_1 = "stand_idle_2_right_reaction";
      break;
    case 3:
      var_1 = "stand_idle_3_right_reaction";
      break;
    case 4:
      var_1 = "stand_idle_4_right_reaction";
      break;
    case 5:
      var_1 = "stand_idle_5_right_reaction";
      break;
    default:
  }

  if(self._id_1FBB == "salter") {
    var_1 = var_1 + "_xo";
  }

  return var_1;
}

_id_7F0E(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case 1:
      var_1 = "shipcrib_stand_stationary_talk_idle_01";
      break;
    case 2:
      var_1 = "shipcrib_stand_stationary_talk_idle_02";
      break;
    case 3:
      var_1 = "shipcrib_stand_stationary_talk_idle_03";
      break;
    case 4:
      var_1 = "shipcrib_stand_stationary_talk_idle_04";
      break;
    case 5:
      var_1 = "shipcrib_stand_stationary_talk_idle_05";
      break;
    default:
  }

  return var_1;
}

_id_3DC8(var_0) {
  if(self._id_1FBB == "salter") {
    if(scripts\sp\interaction::_id_9C27(var_0 + "_xo")) {
      var_0 = var_0 + "_xo";
    }
  }

  return var_0;
}

_id_9838() {
  _id_983A();
}

_id_983A() {
  _id_0EB9::main();
  _id_0EBF::main();
  _id_0EC5::main();
  _id_0ECB::main();
  _id_0ED1::main();
  _id_0EB7::main();
  _id_0EBD::main();
  _id_0EC3::main();
  _id_0EC9::main();
  _id_0ECF::main();
  _id_0EB5::main();
  _id_0EBB::main();
  _id_0EC1::main();
  _id_0EC7::main();
  _id_0ECD::main();
  _id_0EBA::main();
  _id_0EC0::main();
  _id_0EC6::main();
  _id_0ECC::main();
  _id_0ED2::main();
  _id_0EB8::main();
  _id_0EBE::main();
  _id_0EC4::main();
  _id_0ECA::main();
  _id_0ED0::main();
  _id_0EB6::main();
  _id_0EBC::main();
  _id_0EC2::main();
  _id_0EC8::main();
  _id_0ECE::main();
}

_id_2032(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    var_4 endon("death");
  }

  if(!isDefined(var_1)) {
    var_1 = [];
    var_6 = 0;

    foreach(var_4 in var_0) {
      var_1[var_6] = var_4 _id_0EF1::_id_7BF4();
      var_6++;
    }
  }

  if(!isDefined(var_2)) {
    var_9 = [];
    var_10 = 0;

    foreach(var_4 in var_0) {
      var_9[var_10] = var_4 _id_0EF1::_id_789F();
      var_10++;
    }
  } else
    var_9 = var_2;

  thread scripts\sp\interaction::_id_CE15(var_0, var_1, var_9);
}

_id_202E(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = level.player;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  _id_2033();
  var_4 = _id_7F0E(var_1);
  thread _id_0B6A::_id_EC0B(var_0, var_4, undefined, undefined, undefined, undefined, undefined, var_3);

  while(distance2d(self.origin, var_0.origin) > 16) {
    scripts\engine\utility::waitframe();
  }

  childthread scripts\sp\utility::_id_7799(var_2, 2, 1.2);
  childthread scripts\sp\utility::_id_7798(var_2, 2, 1.2);
  self waittill("sceneblock_reachidle_finished");
}

_id_2039(var_0) {
  var_1 = getarraykeys(var_0);

  for(var_2 = undefined; isDefined(self); var_3 = var_0[var_1[0]]) {}

  var_4 = randomint(0, var_1.size - 1);
}