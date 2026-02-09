/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1386.gsc
**************************************/

main() {
  if(getDvar("cobrapilot_surface_to_air_missiles_enabled") == "") {
    setDvar("cobrapilot_surface_to_air_missiles_enabled", "1");
  }
  _id_436B();
  thread firemissile();
  thread _id_2298();
  thread _id_4362();
}

_id_4362() {
  self waittill("death");
  self detachall();
}

_id_2298() {
  self endon("death");

  if(!isDefined(self._id_29AA)) {
    return;
  }
  if(self._id_29AA == 0) {
    return;
  }
  self._id_4363 = 30000;

  if(isDefined(self.radius)) {
    self._id_4363 = self.radius;
  }
  while(!isDefined(level._id_4364)) {
    wait 0.05;
  }
  var_0 = 1.0;

  if(level._id_4364 == "easy") {
    var_0 = 0.5;
  } else if(level._id_4364 == "medium") {
    var_0 = 1.7;
  } else if(level._id_4364 == "hard") {
    var_0 = 1.0;
  } else if(level._id_4364 == "insane") {
    var_0 = 1.5;
  }
  self._id_4363 = self._id_4363 * var_0;

  if(getDvar("cobrapilot_debug") == "1") {
    iprintln("surface-to-air missile range difficultyScaler = " + var_0);
  }
  for(;;) {
    wait(2 + randomfloat(1));
    var_1 = undefined;
    var_1 = maps\_helicopter_globals::_id_2865(self._id_4363, undefined, 0, 1);

    if(!isDefined(var_1)) {
      continue;
    }
    var_2 = var_1.origin;

    if(isDefined(var_1.script_targetoffset_z)) {
      var_2 = var_2 + (0, 0, var_1.script_targetoffset_z);
    }
    self setturrettargetvec(var_2);
    level thread _id_4365(self, 5.0);
    self waittill("turret_rotate_stopped");
    self clearturrettarget();

    if(distance(self.origin, var_1.origin) > self._id_4363) {
      continue;
    }
    var_3 = 0;
    var_3 = sighttracepassed(self.origin, var_1.origin + (0, 0, 150), 0, self);

    if(!var_3) {
      continue;
    }
    if(getDvar("cobrapilot_surface_to_air_missiles_enabled") == "1") {
      self notify("shoot_target", var_1);
      self waittill("missile_fired", var_4);

      if(isDefined(var_4)) {
        if(level._id_4364 == "hard") {
          wait(1 + randomfloat(2));
          continue;
        } else if(level._id_4364 == "insane") {
          continue;
        } else {
          var_4 waittill("death");
        }
      }

      continue;
    }
  }
}

_id_4365(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("turret_rotate_stopped");
  wait(var_1);
  var_0 notify("turret_rotate_stopped");
}

_id_4366(var_0) {
  var_1 = distance((self.origin[0], self.origin[1], 0), (var_0.origin[0], var_0.origin[1], 0));
  var_2 = var_0.origin[2] - self.origin[2];

  if(var_2 <= 750) {
    return 0;
  }
  var_3 = var_2 * 2.5;

  if(var_1 <= self._id_4363 + var_3) {
    return 1;
  }
  return 0;
}

firemissile() {
  self endon("death");

  for(;;) {
    self waittill("shoot_target", var_0);
    var_1 = undefined;

    if(!isDefined(var_0.script_targetoffset_z)) {
      var_0.script_targetoffset_z = 0;
    }
    var_2 = (0, 0, var_0.script_targetoffset_z);
    var_1 = self fireweapon(self._id_3E59[self._id_4367], var_0, var_2);

    if(getDvar("cobrapilot_debug") == "1") {
      level thread _id_436A(var_1, var_0, var_2);
    }
    if(!isDefined(var_0._id_2861)) {
      var_0._id_2861 = [];
    }
    var_0._id_2861 = maps\_utility::_id_0BC3(var_0._id_2861, var_1);
    thread maps\_helicopter_globals::_id_2864(var_1, var_0);
    self detach(self._id_4368, self._id_3E59[self._id_4367]);
    self._id_4367++;
    self._id_4369--;
    var_0 notify("incomming_missile", var_1);
    _id_436B();
    wait 0.05;
    self notify("missile_fired", var_1);
  }
}

_id_436A(var_0, var_1, var_2) {
  var_0 endon("death");

  for(;;) {
    wait 0.05;
  }
}

_id_436B() {
  if(!isDefined(self._id_4369)) {
    self._id_4369 = 0;
  }
  if(!isDefined(self._id_4367)) {
    self._id_4367 = 0;
  }
  if(self._id_4369 > 0) {
    return;
  }
  for(var_0 = 0; var_0 < self._id_3E59.size; var_0++) {
    self attach(self._id_4368, self._id_3E59[var_0]);
  }
  self._id_4369 = self._id_3E59.size;
  self._id_4367 = 0;
}