/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1373.gsc
**************************************/

init() {
  _id_055B::waittill_jumpscare_initialized();
  level._id_AB58 = 0;
  level._id_AB59 = 0;
  var_0 = common_scripts\utility::_id_46B7("birds", "script_noteworthy");
  level._id_AB5A = var_0.size * 0.2;

  foreach(var_2 in var_0)
  var_2 thread _id_1769();
}

_id_1769() {
  self._id_1767 = 0;
  self._id_AA2A = self.origin + (0, 0, 16);
  var_0 = undefined;

  foreach(var_2 in getEntArray(self.target, "targetname")) {
    switch (var_2._id_003B) {
      case "trigger_radius":
        self._id_78CB = var_2;
        self._id_78CB thread _id_1768(self);
        break;
      case "trigger_damage":
        var_2 thread _id_1765(self);
        break;
    }
  }

  self._id_175F = [];

  foreach(var_5 in common_scripts\utility::_id_46B7(self.target, "targetname")) {
    if(isDefined(var_5._id_0165)) {
      switch (var_5._id_0165) {
        case "birds_anims":
          self._id_175F[self._id_175F.size] = var_5;
          break;
      }
    }
  }

  for(;;) {
    var_7 = 1;

    if(var_7)
      wait(_randomfloatrange(10.0, 30.0));

    while(level._id_AB58 >= level._id_AB5A || _id_0F0B(390) || _id_0F0D(0))
      wait 5;

    thread _id_1764();
    thread _id_1766();
    level._id_AB58++;
    self._id_1767 = 1;
    _id_0378::_id_8D74("play_bird_loop", self);
    self waittill("birds_command", var_8, var_9);
    level._id_AB58--;
    self._id_1767 = 0;
    var_10 = gettime() * 0.001;
    var_11 = 30;

    if(var_10 - level._id_AB59 < var_11)
      var_8 = "never_mind";

    switch (var_8) {
      case "fly_away":
        level._id_AB59 = var_10;

        if(isPlayer(var_9))
          _id_055B::_id_5976(var_9);

        thread _id_8FAA(var_9);
        thread _id_3D7C();
        _id_0378::_id_8D74("stop_bird_loop", self);
        _id_0378::_id_8D74("play_bird_retreat", self);
        break;
      case "never_mind":
        _id_0378::_id_8D74("stop_bird_loop", self);
        break;
      default:
    }

    wait 5;
  }
}

_id_3D7C() {
  wait 0.25;

  foreach(var_1 in level.players) {
    if(isDefined(var_1) && var_1 istouching(self._id_78CB) && var_1 _id_72E5(self._id_AA2A, 0))
      var_1 thread _id_3D7B();
  }
}

_id_3D7B() {
  self endon("death");
  self endon("disconnect");
}

_id_8FAA(var_0) {
  for(var_1 = 0; var_1 < 20; var_1++) {
    var_2 = common_scripts\utility::random(self._id_175F);
    thread _id_1763(var_2, var_0);
  }

  wait 0.1;
  _physicsexplosionsphere(self._id_AA2A, 48, 16, 1, 0);
  _glassradiusdamage(self._id_AA2A, 48, 100, 50);
  _earthquake(0.5, 1.5, self._id_78CB.origin, self._id_78CB.radius * 2);
  _playrumbleonposition("zombie_birds_rumble", self._id_78CB.origin);
}

_id_1763(var_0, var_1) {
  var_2 = 2;
  var_3 = 40;
  var_4 = 10;
  wait(_randomfloatrange(0, var_2));
  var_5 = undefined;

  if(isPlayer(var_1)) {
    if(distance(var_1.origin, self.origin) > 96)
      var_5 = common_scripts\utility::_id_4461(self.origin, maps\mp\agents\_agent_utility::_id_43FD("all"));
    else
      var_5 = var_1;
  }

  if(isDefined(var_1)) {
    var_6 = var_1.origin - self.origin;
    var_7 = vectortoangles(var_6)[1];
    var_8 = var_7 - self.angles[1];
    var_8 = var_8 + _randomfloatrange(0 - var_4, var_4);

    if(_isendstr(var_0.setlookatent, "_v1") || _isendstr(var_0.setlookatent, "_v3")) {
      var_9 = 0 - var_3;
      var_10 = 0;
    } else {
      var_9 = 0;
      var_10 = var_3;
    }

    var_8 = clamp(var_8, var_9, var_10);
    var_11 = _transformmove(self.origin, self.angles + (0, var_8, 0), self.origin, self.angles, var_0.origin, var_0.angles);
    var_12 = var_11["origin"];
    var_13 = var_11["angles"];
  } else {
    var_12 = var_0.origin;
    var_13 = var_0.angles;
  }

  var_14 = spawn("script_model", var_12);
  var_14.angles = var_13;
  var_14 setModel("ani_raven_rig");
  var_14 scriptmodelplayanimdeltamotion(var_0.setlookatent, "bird_anim");
  var_14 thread _id_1760();
  var_14 waittillmatch("bird_anim", "end");
  var_14 delete();
}

_id_1760() {
  var_0 = 32;
  var_1 = 3;
  var_2 = 50;
  var_3 = 50;
  self endon("death");

  for(;;) {
    var_4 = 0;
    var_5 = 9999;

    foreach(var_7 in level.players) {
      if(distance(var_7.origin, self.origin) < var_0 + 128) {
        var_4 = 1;

        if(var_7.health < var_5)
          var_5 = var_7.health;
      }
    }

    if(var_4 && var_5 - var_1 < var_3) {
      waitframe();
      continue;
    }

    if(var_4)
      var_9 = var_1;
    else
      var_9 = var_2;

    radiusdamage(self.origin, var_0, var_9, var_9 * 0.5, undefined, undefined, undefined, undefined, 0);
    break;
  }
}

_id_0F0B(var_0) {
  if(!isDefined(level.players))
    return 0;

  foreach(var_2 in level.players) {
    if(distance(var_2.origin, self.origin) < var_0)
      return 1;
  }

  return 0;
}

_id_0F0D(var_0) {
  if(var_0 == 0)
    return 0;

  foreach(var_2 in maps\mp\agents\_agent_utility::_id_43FD("all")) {
    if(distance(var_2.origin, self.origin) < var_0)
      return 1;
  }

  return 0;
}

_id_1765(var_0) {
  for(;;) {
    self waittill("trigger", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(_randomfloat(1) < 0.9) {
      var_0 notify("birds_command", "fly_away", var_1);
      continue;
    }

    var_0 notify("never_mind");
  }
}

_id_1768(var_0) {
  var_1 = _cos(32.5);
  var_0 _id_055B::loadcostumemodels("birds");

  for(;;) {
    self waittill("trigger", var_2);

    if(!isPlayer(var_2)) {
      continue;
    }
    if(!var_0._id_1767) {
      continue;
    }
    var_3 = var_2 _id_72E5(var_0._id_AA2A, var_1) && var_0 _id_055B::_id_5977(var_2);

    if(var_3) {
      var_0 notify("birds_command", "fly_away", var_2);
      continue;
    }

    var_0 notify("never_mind");

    while(isalive(var_2) && var_2 istouching(self))
      wait 1;

    wait 10;
  }
}

_id_1764() {
  self endon("birds_command");

  for(;;) {
    wait 5;

    if(_id_0F0D(0))
      self notify("birds_command", "never_mind");
  }
}

_id_1766() {
  self endon("birds_command");
  wait(_randomfloatrange(15.0, 45.0));
  self notify("birds_command", "never_mind");
}

_id_72E5(var_0, var_1) {
  return vectordot(vectorNormalize(var_0 - self getEye()), anglesToForward(self getplayerangles())) > var_1;
}