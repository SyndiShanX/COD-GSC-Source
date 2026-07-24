/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3856.gsc
**************************************/

_id_FCFE() {
  precachemodel("beacon_intel_tablet");
  level._id_FD49 = [];
  level.player._id_FD49 = [];
}

_id_FCFC(var_0) {
  level._id_FD49[var_0.keyname] = var_0;
  level._id_FD49[var_0.keyname]._id_A594 = spawn("script_model", var_0.origin);
  level._id_FD49[var_0.keyname]._id_A594.angles = var_0.angles;
  level._id_FD49[var_0.keyname]._id_A594 setModel(var_0.model);

  if(isDefined(level._id_FD49[var_0.keyname]._id_CB2B)) {
    if(!scripts\engine\utility::flag_exist(level._id_FD49[var_0.keyname]._id_CB2B))
      scripts\engine\utility::flag_init(level._id_FD49[var_0.keyname]._id_CB2B);
  }

  if(isDefined(level._id_FD49[var_0.keyname]._id_FFFE) && level._id_FD49[var_0.keyname]._id_FFFE) {
    var_1 = level._id_FD49[var_0.keyname].owner.origin;
    var_2 = level._id_FD49[var_0.keyname].owner.origin;

    for(;;) {
      wait 0.05;
      var_3 = (randomfloatrange(-60, 60), randomfloatrange(-60, 60), 0);
      var_2 = var_1 + var_3;

      if(sighttracepassed(var_2, var_2 + (0, 0, 60), 1, undefined)) {
        break;
      }
    }
  }

  if(isDefined(level._id_FD49[var_0.keyname]._id_4C25))
    level._id_FD49[var_0.keyname]._id_A594 _id_0E46::_id_48C4(level._id_FD49[var_0.keyname]._id_4C25[0], level._id_FD49[var_0.keyname]._id_4C25[1], level._id_FD49[var_0.keyname]._id_4C25[2], level._id_FD49[var_0.keyname]._id_4C25[3], level._id_FD49[var_0.keyname]._id_4C25[4], level._id_FD49[var_0.keyname]._id_4C25[5], level._id_FD49[var_0.keyname]._id_4C25[6], level._id_FD49[var_0.keyname]._id_4C25[7], level._id_FD49[var_0.keyname]._id_4C25[8]);
  else
    level._id_FD49[var_0.keyname]._id_A594 _id_0E46::_id_48C4(undefined, undefined, &"SHIP_ASSAULT_CAPTAINS_KEY", undefined, 700, 128, 1);

  level._id_FD49[var_0.keyname]._id_A594 thread _id_FCFD(var_0);
}

_id_FCFD(var_0) {
  self waittill("trigger");
  level.player._id_FD49[var_0.keyname] = var_0;

  if(isDefined(level._id_FD49[var_0.keyname]._id_CB2B))
    scripts\engine\utility::flag_set(level._id_FD49[var_0.keyname]._id_CB2B);

  thread _id_0F05::_id_D0A5(var_0.keyname);

  if(isDefined(level._id_FD49[var_0.keyname]._id_4F4C)) {}

  self hide();
  wait 1;
  self delete();
}

_id_E1B4() {
  if(isDefined(self._id_E1B3)) {
    if(isDefined(level.player._id_FD49)) {
      foreach(var_1 in level.player._id_FD49) {
        if(var_1.keyname == self._id_E1B3) {
          thread scripts\sp\utility::play_sound_on_entity("sa_hack_finish");
          self._id_E1B3 = undefined;

          if(isDefined(self._id_E99A) && self._id_E99A == 1)
            _id_0F05::_id_12BD3();

          return 1;
        }

        return 0;
      }

      thread scripts\sp\utility::play_sound_on_entity("sa_hack_fail");
      wait 2.0;
      return 0;
    } else
      return 0;
  } else
    return 0;
}

_id_8B8A() {
  if(isDefined(self._id_E1B3)) {
    if(isDefined(level.player._id_FD49)) {
      foreach(var_1 in level.player._id_FD49) {
        if(var_1.keyname == self._id_E1B3) {
          thread scripts\sp\utility::play_sound_on_entity("sa_hack_finish");
          self._id_E1B3 = undefined;
          return 1;
        }
      }

      return 0;
    } else
      return 0;
  } else
    return 0;
}