/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3821.gsc
**************************************/

_id_730A(var_0) {
  self endon("entitydeleted");
  var_1 = getvehiclenode(var_0, "targetname");
  thread scripts\sp\vehicle::_id_1321A(var_1);
  self startpath(var_1);
  self waittill("reached_end_node");
}

#using_animtree("vehicles");

_id_7305(var_0, var_1) {
  self endon("entitydeleted");
  var_2 = 4;

  switch (var_0) {
    case "raised":
      self setanimknob(%vehicle_forklift_lift_raised, 1, var_2);
      wait(var_2 + 0.05);
      break;
    case "lowered":
      self setanimknob(%vehicle_forklift_lift_lowered, 1, var_2);
      wait(var_2 + 0.05);
      break;
    case "percentage":
      self setanimknob(%vehicle_forklift_lift_range, 1, var_2);
      self _meth_82B0(%vehicle_forklift_lift_range, 0);

      for(var_3 = self islegacyagent(%vehicle_forklift_lift_range); var_3 < var_1; var_3 = self islegacyagent(%vehicle_forklift_lift_range)) {
        scripts\engine\utility::waitframe();
      }

      self _meth_82B1(%vehicle_forklift_lift_range, 0);
      break;
  }
}

_id_7309(var_0) {
  self endon("entitydeleted");
  var_1 = getEntArray(var_0, "targetname");
  var_2 = getEntArray(var_0 + "_col", "targetname");

  if(var_2.size > 0 && var_1.size > 0) {
    scripts\engine\utility::array_call(var_2, ::linkto, var_1[0]);
  }

  self._id_3A5D = var_1;
  scripts\engine\utility::array_call(self._id_3A5D, ::linkto, self, "j_lifter_backboard");
  _id_7305("percentage", 0.6);
}

_id_7315() {
  self endon("entitydeleted");

  for(;;) {
    var_0 = distance2dsquared(self.origin, level.player.origin);
    var_1 = 262144;

    if(var_0 >= var_1) {
      break;
    } else
      scripts\engine\utility::waitframe();
  }

  _id_7305("lowered", 2);
  scripts\engine\utility::array_call(self._id_3A5D, ::unlink);
}

_id_730B() {
  self endon("entitydeleted");
  self endon("stop_player_awareness");

  if(!isDefined(self.trigger)) {
    self.trigger = spawn("trigger_radius", self.origin + anglesToForward(self.angles) * 120, 0, 80, 80);
    self.trigger enablelinkTo();
    self.trigger linkTo(self);
  }

  self.trigger thread _id_730D(self);
}

_id_7302() {
  self endon("entitydeleted");

  for(;;) {
    foreach(var_1 in level._id_FD6E._id_7316) {
      if(var_1 != self) {
        if(var_1._id_11083 && scripts\engine\utility::distance_2d_squared(self.origin, var_1.origin) < 38416 && _id_7301(var_1)) {
          self.trigger notify("trigger");
          self._id_11B0E = 1;

          while(var_1._id_11083) {
            scripts\engine\utility::waitframe();
          }

          wait 0.5;
          self._id_11B0E = 0;
          break;
        }
      }
    }

    scripts\engine\utility::waitframe();
  }
}

_id_730D(var_0) {
  self endon("death");
  var_0 endon("entitydeleted");
  var_0 endon("stop_player_awareness");

  for(;;) {
    self waittill("trigger");
    var_0 vehicle_setspeed(0, 7, 7);
    var_0._id_11083 = 1;

    while(level.player istouching(self) || var_0._id_11B0E) {
      scripts\engine\utility::waitframe();
    }

    var_0 resumespeed(1);
    var_0._id_11083 = 0;
  }
}

_id_7301(var_0) {
  self endon("entitydeleted");

  if(abs(angleclamp180(self.angles[1] - var_0.angles[1])) < 45 && scripts\sp\utility::_id_7951(self.origin, self.angles, var_0.origin) > 0.8) {
    return 1;
  } else {
    return 0;
  }
}