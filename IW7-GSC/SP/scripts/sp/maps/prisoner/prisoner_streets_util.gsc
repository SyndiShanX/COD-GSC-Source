/**************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\prisoner\prisoner_streets_util.gsc
**************************************************************/

_id_D85C() {
  level.player disableweapons();
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
}

_id_DF3E() {
  level.player unlink();
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player enableweapons();
}

_id_4356(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size - 1; var_3++) {
    var_2[var_2.size] = pointonsegmentnearesttopoint(var_0[var_3].origin, var_0[var_3 + 1].origin, var_1);
  }

  var_4 = distancesquared(var_2[0], var_1);
  var_5 = var_2[0];

  foreach(var_7 in var_2) {
    var_8 = distancesquared(var_7, var_1);

    if(var_8 < var_4) {
      var_5 = var_7;
      var_4 = var_8;
    }
  }

  return var_5;
}

_id_4355(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "targetname");
  var_2 = [];
  var_3 = var_1[0];
  var_2 = scripts\engine\utility::array_add(var_2, var_3);

  while(isDefined(var_3.target)) {
    var_4 = scripts\engine\utility::getStruct(var_3.target, "targetname");

    if(isDefined(var_4)) {
      var_2 = scripts\engine\utility::array_add(var_2, var_4);
      var_3 = var_4;
      continue;
    }

    break;
  }

  return var_2;
}

_id_10DDA() {
  level._id_5EE3 = [];
  level._id_5D6C = scripts\sp\maps\prisoner\prisoner_util::_id_106B5("vehicle_dropship", "church_dropship_spot_1");
  wait 0.1;
  level._id_5EE6 = _id_0BBF::_id_5EC1(level._id_5D6C);
}

_id_106B7() {
  level._id_5D6C = scripts\sp\maps\prisoner\prisoner_util::_id_106B5("vehicle_dropship", "collapse_dropship_spot2");
  scripts\sp\maps\prisoner\prisoner_util::_id_10616("salter");
  level._id_5D6C sethoverparams(0, 0, 0);
  level._id_5D6C setyawspeed(0, 10);
}

_id_11120(var_0) {
  var_1 = scripts\engine\utility::getStruct("hvr_streets_pip_spot", "targetname");
  scripts\sp\maps\prisoner\prisoner_util::_id_10616("hvt", 1);
  level._id_920F _meth_83B9(var_1.origin, var_1.angles);
  level._id_920F setgoalpos(level._id_920F.origin);
  level._id_920F scripts\sp\utility::_id_F3E0(24);
  level._id_920F scripts\sp\pip_util::_id_6A67();
  thread scripts\sp\utility::_id_16C5("hvt", var_0);
  wait 4.0;
  scripts\sp\pip_util::_id_CBA3();
  level._id_920F scripts\sp\utility::_id_1101B();
  level._id_920F delete();
}

_id_E587() {
  self endon("death");

  for(;;) {
    if(self buttonPressed("DPAD_LEFT")) {
      _id_E586();
    }

    wait 0.1;
  }
}

_id_E586() {
  scripts\sp\utility::_id_D090("ges_radio");
  wait 0.7;
  self playlocalsound("scatter_sight_beep_1");
  var_0 = self.origin + (0, 0, 60) + anglesToForward(self getplayerangles(1)) * 600;
  var_1 = getrandomnavpoints(var_0, 600, 64);
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = spawnStruct();
    var_5.origin = var_4;
    var_5._id_56E8 = distance(var_4, self.origin);
    var_2[var_2.size] = var_5;
  }

  var_2 = scripts\sp\utility::_id_22C1(var_2, ::_id_5AC6);
  var_7 = 5;
  var_8 = 0;
  var_9 = (0, 0, -4);
  var_10 = (0, 0, 8);
  var_11 = undefined;

  foreach(var_13 in var_2) {
    var_8++;
    thread scripts\engine\utility::draw_line_for_time(var_13.origin + var_9, var_13.origin + var_9 + var_10, 1, 1, 1, 2.0);

    if(var_8 >= var_7) {
      var_8 = 0;
      wait 0.05;
    }
  }

  scripts\sp\utility::_id_1102B();
}

_id_5AC6() {
  return self._id_56E8;
}

_id_276B(var_0) {
  self._id_8632 = spawn("script_model", (0, 0, 0));
  self _meth_823F(self._id_8632);
  var_1 = 1;
  var_2 = gettime() + var_0 * 1000.0;
  self allowsprint(0);
  self allowjump(0);
  scripts\sp\utility::_id_2B76(0.2, 0.01);
  scripts\engine\utility::delaythread(0.05 + var_0, scripts\sp\utility::_id_2B76, 1.0, 1.0);
  self _meth_80D8(0.5, 0.5);

  for(;;) {
    if(var_1) {
      var_3 = _id_186F((randomfloatrange(-3, -1), 0, randomfloatrange(-2, 6)));
      var_4 = randomfloatrange(1.4, 1.8);
      self._id_8632 rotateTo(var_3, var_4, var_4 * 3 / 4, var_4 / 4);
      self._id_8632 waittill("rotatedone");
      var_1 = 0;
    } else {
      var_3 = _id_186F((randomfloatrange(1, 3), 0, randomfloatrange(-2, 6)));
      var_4 = randomfloatrange(1.4, 1.8);
      self._id_8632 rotateTo(var_3, var_4, var_4 * 3 / 4, var_4 / 4);
      self._id_8632 waittill("rotatedone");
      var_1 = 1;
    }

    if(gettime() >= var_2) {
      break;
    }
  }

  self allowsprint(1);
  self allowjump(1);
  self _meth_80A6();
  self._id_8632 rotateTo((0, 0, 0), 1.0, 0.75, 0.25);
  self._id_8632 waittill("rotatedone");
  self _meth_823F(undefined);
  self._id_8632 delete();
}

_id_186F(var_0) {
  var_1 = var_0[0];
  var_2 = var_0[2];
  var_3 = anglestoright(self.angles);
  var_4 = anglesToForward(self.angles);
  var_5 = (var_3[0], 0, var_3[1] * -1);
  var_6 = (var_4[0], 0, var_4[1] * -1);
  var_7 = var_5 * var_1;
  var_7 = var_7 + var_6 * var_2;
  return var_7 + (0, var_0[1], 0);
}