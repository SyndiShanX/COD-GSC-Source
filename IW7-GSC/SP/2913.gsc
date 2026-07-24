/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2913.gsc
**************************************/

_id_95A4() {
  level._id_D1D4 = [];
  level._id_D1D4["pitch"]["min"] = 2;
  level._id_D1D4["pitch"]["max"] = 5;
  level._id_D1D4["yaw"]["min"] = -8;
  level._id_D1D4["yaw"]["max"] = 5;
  level._id_D1D4["roll"]["min"] = 3;
  level._id_D1D4["roll"]["max"] = 5;
  level.player._id_ACDE = 0;
}

_id_F324(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    level._id_D1D4["pitch"]["min"] = var_0["min"];
    level._id_D1D4["pitch"]["max"] = var_0["max"];
  }

  if(isDefined(var_1)) {
    level._id_D1D4["yaw"]["min"] = var_1["min"];
    level._id_D1D4["yaw"]["max"] = var_1["max"];
  }

  if(isDefined(var_2)) {
    level._id_D1D4["roll"]["min"] = var_2["min"];
    level._id_D1D4["roll"]["max"] = var_2["max"];
  }
}

_id_554E() {
  level.player notify("stop_limp");

  if(isDefined(level.player._id_8632)) {
    var_0 = level.player _id_186F((0, 0, 0));
    level.player._id_8632 rotateTo(var_0, 0.05, 0, 0.05);
    level.player._id_8632 waittill("rotatedone");
    level.player _meth_823F(undefined);
    level.player._id_8632 delete();
  }

  level.player._id_ACDE = 0;
}

_id_ACDE(var_0, var_1, var_2, var_3) {
  self endon("stop_limp");
  self._id_ACDE = 1;
  _id_48F7();
  thread _id_3DB3(var_0, var_1);

  for(;;) {
    if(level.player getstance() == "prone") {
      wait 0.05;
      continue;
    }

    _id_36DC(var_0, var_2, var_1, var_3);

    if(var_1) {
      if(var_0 == "leg_left")
        var_0 = "leg_right";
      else
        var_0 = "leg_left";
    }

    var_3 = 0;
    var_2 = 0;
    wait 0.05;
  }
}

_id_3DB3(var_0, var_1) {
  self endon("stop_limp");
  var_2 = 1;
  var_3 = level.player getvelocity();
  var_4 = _id_7B8E();

  for(;;) {
    if(var_2) {
      var_2 = 0;
      wait 0.05;
      continue;
    }

    if(level.player getstance() == "prone") {
      wait 0.05;
      continue;
    }

    if(_id_9BBB(var_4)) {
      thread _id_E2AC(var_0, var_1, 1.5, 0);
      break;
    }

    if(_id_9D0D(var_3)) {
      thread _id_E2AC(var_0, var_1, 1, 0);
      break;
    }

    var_3 = level.player getvelocity();
    var_4 = _id_7B8E();
    wait 0.05;
  }
}

_id_9BBB(var_0) {
  if(_id_7B8E() != var_0)
    return 1;
  else
    return 0;
}

_id_7B8E() {
  var_0 = vectortoangles(level.player getnormalizedmovement())[1];

  if(var_0 >= 315 || var_0 <= 45)
    var_1 = "forward";
  else if(var_0 > 45 && var_0 < 135)
    var_1 = "right";
  else if(var_0 > 225 && var_0 < 315)
    var_1 = "left";
  else
    var_1 = "backward";

  return var_1;
}

_id_9D0D(var_0) {
  var_1 = length(var_0);
  var_0 = length(level.player getvelocity());
  return var_0 - var_1 >= 20;
}

_id_E2AC(var_0, var_1, var_2, var_3) {
  self notify("stop_limp");
  var_4 = [];
  self._id_ACDE = 0;
  var_5 = _id_7B8E();

  if(var_5 == "forward") {
    var_4["pitch"]["min"] = 1;
    var_4["pitch"]["max"] = 1.5;
    var_4["yaw"]["min"] = -1.5;
    var_4["yaw"]["max"] = -1;
    var_4["roll"]["min"] = 2.25;
    var_4["roll"]["max"] = 3;
  } else if(var_5 == "right") {
    var_4["pitch"]["min"] = 1.7;
    var_4["pitch"]["max"] = 2;
    var_4["yaw"]["min"] = 2;
    var_4["yaw"]["max"] = 4;
    var_4["roll"]["min"] = -4;
    var_4["roll"]["max"] = -3;
  } else if(var_5 == "left") {
    var_4["pitch"]["min"] = 1.7;
    var_4["pitch"]["max"] = 2;
    var_4["yaw"]["min"] = 2;
    var_4["yaw"]["max"] = 4;
    var_4["roll"]["min"] = -4;
    var_4["roll"]["max"] = -3;
  } else if(var_5 == "backward") {
    var_4["pitch"]["min"] = 2;
    var_4["pitch"]["max"] = 4;
    var_4["yaw"]["min"] = 4;
    var_4["yaw"]["max"] = 5;
    var_4["roll"]["min"] = -5;
    var_4["roll"]["max"] = -3;
  }

  scripts\engine\utility::waitframe();
  _id_F324(var_4["pitch"], var_4["yaw"], var_4["roll"]);
  _id_ACDE(var_0, var_1, var_2, var_3);
}

_id_36DC(var_0, var_1, var_2, var_3) {
  self endon("stop_limp");
  var_4 = level.player getstance();
  var_5 = _id_D2CC();

  if(length(level.player getnormalizedmovement()) <= 0.1 && !var_3) {
    return;
  }
  var_6 = randomfloatrange(level._id_D1D4["pitch"]["min"], level._id_D1D4["pitch"]["max"]);
  var_7 = randomfloatrange(level._id_D1D4["roll"]["min"], level._id_D1D4["roll"]["max"]);
  var_8 = randomfloatrange(level._id_D1D4["yaw"]["min"], level._id_D1D4["yaw"]["max"]);

  if(randomint(100) < 20 && !var_1) {
    var_6 = var_6 * 1.25;
    var_7 = var_7 * 1.25;
    var_8 = var_8 * 1.25;
  }

  var_9 = (var_6, var_8, var_7);

  if(var_0 == "leg_left")
    var_9 = (var_9[0] * -1.5, var_9[1] * -1.5, var_9[2]);

  if(var_1 && !level.player playerads() || var_3) {
    var_5 = var_1;
    var_10 = 0.75;
    var_11 = var_10 / 2.5;
  } else {
    var_11 = var_5 * 0.5;
    var_11 = 1 - clamp(var_11, 0, 0.7);
    var_10 = var_11 * 1.5;

    if(_id_7B8E() == "backwards") {
      var_11 = var_11 * 6;
      var_10 = var_10 * 3;
    }
  }

  var_9 = var_9 * var_5;

  if(level.player playerads()) {
    var_9 = var_9 * 0.65;
    var_10 = var_10 * 1.35;
  }

  if(var_2)
    var_10 = var_10 * 0.5;

  _id_11182(var_9, var_11, var_10, var_5);
}

_id_11182(var_0, var_1, var_2, var_3) {
  self endon("stop_stumble");
  self endon("stop_limp");
  var_0 = _id_186F(var_0);
  self._id_8632 rotateTo(var_0, var_1, var_1 / 4 * 3, var_1 / 4);
  self._id_8632 waittill("rotatedone");

  if(isDefined(self._id_883D) && self._id_883D != "none")
    thread _id_D0E5(var_3);
  else
    thread _id_D0E6(var_3);

  var_4 = (randomfloat(4) - 4, randomfloat(5), 0);
  var_4 = _id_186F(var_4);
  self._id_8632 rotateTo(var_4, var_2, 0, var_2 / 2);
  self._id_8632 waittill("rotatedone");
}

_id_D2CC() {
  var_0 = length(level.player getvelocity());
  return var_0 / 100;
}

_id_D0E5(var_0) {
  if(isDefined(self._id_883B) && soundexists(self._id_883B))
    self playSound(self._id_883B);
}

_id_D0E6(var_0) {
  if(var_0 > randomfloatrange(0.7, 1)) {
    level.player playRumbleOnEntity("damage_light");
    thread scripts\engine\utility::play_sound_in_space("breathing_limp");
    scripts\engine\utility::play_sound_in_space("breathing_heartbeat");
  } else
    scripts\engine\utility::play_sound_in_space("breathing_limp_better");
}

_id_D221() {
  level.player playSound("player_death_generic");
  thread scripts\sp\utility::_id_D020();
  wait 0.75;
  level.player stopsounds();
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

_id_48F7() {
  if(isDefined(self._id_8632)) {
    return;
  }
  self._id_8632 = spawn("script_model", (0, 0, 0));
  self _meth_823F(self._id_8632);
}