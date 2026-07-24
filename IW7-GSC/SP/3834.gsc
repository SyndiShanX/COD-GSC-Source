/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3834.gsc
**************************************/

_id_11A4E(var_0) {
  self endon("entitydeleted");
  var_1 = getvehiclenode(var_0, "targetname");
  thread scripts\sp\vehicle::_id_1321A(var_1);
  self startpath(var_1);
  self waittill("reached_end_node");
}

_id_11A4D(var_0) {
  self endon("entitydeleted");
  var_1 = getEntArray(var_0, "targetname");
  self._id_3A5D = var_1;
  scripts\engine\utility::array_call(self._id_3A5D, ::linkto, self, "tag_body");
}

_id_11A54() {
  self endon("entitydeleted");
  scripts\engine\utility::array_call(self._id_3A5D, ::unlink);
}

_id_11A4F() {
  self endon("entitydeleted");
  self endon("stop_player_awareness");

  if(!isDefined(self.trigger)) {
    self.trigger = spawn("trigger_radius", self.origin + anglesToForward(self.angles) * 120, 0, 80, 80);
    self.trigger enablelinkTo();
    self.trigger linkTo(self);
  }

  self.trigger thread _id_11A50(self);
}

_id_11A4B() {
  self endon("entitydeleted");

  for(;;) {
    foreach(var_1 in level._id_FD6E._id_7316) {
      if(var_1._id_11083 && scripts\engine\utility::distance_2d_squared(self.origin, var_1.origin) < 38416 && _id_11A4A(var_1)) {
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

    scripts\engine\utility::waitframe();
  }
}

_id_11A50(var_0) {
  self endon("death");
  var_0 endon("entitydeleted");
  var_0 endon("stop_player_awareness");

  for(;;) {
    self waittill("trigger");
    var_0 vehicle_setspeed(0, 7, 7);
    var_0._id_11083 = 1;

    if(isDefined(var_0._id_11B0E)) {
      while(level.player istouching(self) || var_0._id_11B0E) {
        scripts\engine\utility::waitframe();
      }
    } else {
      while(level.player istouching(self)) {
        scripts\engine\utility::waitframe();
      }
    }

    var_0 resumespeed(1);
    var_0._id_11083 = 0;
  }
}

_id_11A4A(var_0) {
  self endon("entitydeleted");

  if(abs(angleclamp180(self.angles[1] - var_0.angles[1])) < 45 && scripts\sp\utility::_id_7951(self.origin, self.angles, var_0.origin) > 0.8) {
    return 1;
  } else {
    return 0;
  }
}