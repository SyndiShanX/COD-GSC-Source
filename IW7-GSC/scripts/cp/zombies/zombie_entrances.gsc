/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombie_entrances.gsc
***************************************************/

init_zombie_entrances() {
  level._id_13D37 = [];
  level.window_entrances = scripts\engine\utility::getStructArray("window_entrance", "targetname");
  scripts\engine\utility::array_thread(level.window_entrances, ::_id_97A8);
}

_id_4F32() {
  wait 5;

  for(;;) {
    var_0 = scripts\engine\utility::getclosest(level.players[0].origin, level.window_entrances);
    var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
    var_1 = scripts\engine\utility::add_to_array(var_1, var_0);

    foreach(var_3 in var_1) {
      var_4 = 0;

      if(isDefined(var_3.angles)) {
        var_4 = var_3.angles[1];
      }

      var_5 = (0, 1, 0);

      if(_id_9CD3(var_3)) {
        var_5 = (1, 0, 0);
      }
    }

    wait 0.25;
  }
}

_id_97A8() {
  self.enabled = 0;
  self._id_C2D0 = undefined;
  var_0 = getEntArray(self.target, "targetname");

  if(var_0.size) {
    foreach(var_2 in var_0) {
      if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "clip") {
        self.clip = var_2;
        continue;
      }

      self.barrier = var_2;
    }
  }

  self.barrier._id_C1DE = 6;
  self.barrier._id_2BEB = [];
  self.barrier._id_2BEB[0] = "boarded";
  self.barrier._id_2BEB[1] = "boarded";
  self.barrier._id_2BEB[2] = "boarded";
  self.barrier._id_2BEB[3] = "boarded";
  self.barrier._id_2BEB[4] = "boarded";
  self.barrier._id_2BEB[5] = "boarded";
  var_4 = scripts\engine\utility::getStructArray(self.target, "targetname");

  foreach(var_6 in var_4) {
    if(isDefined(var_6.script_noteworthy) && var_6.script_noteworthy == "attack_spot") {
      self.attack_position = var_6;
      continue;
    }

    var_6._id_C2D0 = undefined;
    var_6.enabled = 0;
    level._id_13D37[level._id_13D37.size] = var_6;
  }

  level._id_13D37[level._id_13D37.size] = self;
  var_8 = scripts\engine\utility::getclosest(self.origin, scripts\engine\utility::getStructArray("secure_window", "script_noteworthy"));
  self.script_noteworthy = _id_7D7E(var_8);
  self.script_label = "mid";

  if(isDefined(self._id_EED9) && self._id_EED9 == "extended") {
    self._id_2A9F = 1;
  }

  var_9 = anglestoright(self.angles);

  foreach(var_6 in var_4) {
    var_11 = var_6.origin - self.origin;
    var_12 = vectordot(var_11, var_9);

    if(var_12 > 0) {
      var_6.script_label = "left";
    } else {
      var_6.script_label = "right";
    }

    if(scripts\engine\utility::is_true(self._id_2A9F)) {
      var_6._id_2A9F = 1;
    }
  }
}

_id_7D7E(var_0) {
  var_1 = getEntArray("spawn_volume", "targetname");

  foreach(var_3 in var_1) {
    if(ispointinvolume(var_0.origin, var_3)) {
      return var_3.script_linkname;
    }
  }

  return undefined;
}

_id_6259(var_0) {
  var_0.enabled = 1;
  var_0._id_C2D0 = undefined;
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_3._id_C2D0 = undefined;
    var_3.enabled = 1;
  }
}

_id_55A8(var_0) {
  var_0.enabled = 0;
  var_0._id_C2D0 = undefined;
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_3._id_C2D0 = undefined;
    var_3.enabled = 0;
  }
}

enable_windows_in_area(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "script_noteworthy");

  foreach(var_3 in var_1) {
    _id_6259(var_3);
  }
}

_id_7998(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0._id_130C8; var_2++) {
    if(var_0._id_130D0[var_2] == var_1) {
      return var_2;
    }
  }

  return undefined;
}

_id_E005(var_0) {
  if(!isDefined(var_0._id_130D0)) {
    return;
  }
  var_1 = _id_7998(var_0, self);

  if(!isDefined(var_1)) {
    return;
  }
  if(var_0._id_130C8 == 1) {
    var_0._id_130D0 = [];
    var_0._id_130C8 = 0;
  } else {
    var_0._id_130D0[var_1] = var_0._id_130D0[var_0._id_130C8 - 1];
    var_0._id_130D0[var_0._id_130C8 - 1] = undefined;
    var_0._id_130C8--;
  }
}

_id_16D1(var_0) {
  _id_E005(var_0);

  if(!isDefined(var_0._id_130D0)) {
    var_0._id_130D0 = [];
    var_0._id_130C8 = 0;
  }

  var_1 = var_0._id_130C8;
  var_0._id_130D0[var_1] = self;
  var_0._id_130C8++;
}

_id_61D1() {
  foreach(var_1 in level.window_entrances) {
    _id_6259(var_1);
  }
}

_id_7B4D(var_0) {
  var_1 = scripts\engine\utility::get_array_of_closest(var_0, level.window_entrances);

  foreach(var_3 in var_1) {
    if(!entrance_has_barriers(var_3)) {
      return var_3;
    }
  }

  return undefined;
}

_id_7B14(var_0, var_1) {
  var_2 = sortbydistance(level.window_entrances, var_0);

  foreach(var_4 in var_2) {
    if(isDefined(var_1)) {
      if(var_4 == var_1) {
        var_1 = undefined;
      }

      continue;
    }

    if(var_4.enabled) {
      return var_4;
    }
  }

  return undefined;
}

_id_9BD6(var_0) {
  return var_0.enabled;
}

entrance_has_barriers(var_0) {
  if(isDefined(var_0.barrier) && var_0.barrier._id_C1DE > 0) {
    return 1;
  }

  return 0;
}

release_attack_spot(var_0) {
  var_0._id_C2D0 = undefined;
}

_id_3FF0(var_0) {
  var_0._id_C2D0 = self;
}

_id_9CD3(var_0) {
  if(isDefined(var_0._id_C2D0) && isalive(var_0._id_C2D0)) {
    return 1;
  }

  return 0;
}

_id_9CD2(var_0) {
  return !_id_9CD3(var_0);
}

_id_F95E() {
  var_0 = anglestoright(self.angles);
  var_1 = scripts\engine\utility::getStructArray(self.target, "targetname");

  foreach(var_3 in var_1) {
    var_4 = var_3.origin - self.origin;
    var_5 = vectordot(var_4, var_0);

    if(var_5 > 0) {
      self._id_E529 = var_3;
      continue;
    }

    self._id_AB4E = var_3;
  }
}

_id_36CF() {
  var_0 = (0, 0, 0);

  foreach(var_2 in self._id_130D0) {
    var_0 = var_0 + var_2.origin;
  }

  var_4 = (var_0[0] / self._id_130C8, var_0[1] / self._id_130C8, var_0[2] / self._id_130C8);
  var_5 = sortbydistance(self._id_130D0, var_4);
  return var_5[0];
}

_id_9CF6(var_0, var_1) {
  var_2 = self.origin - var_0.origin;
  var_3 = (var_2[0], var_2[1], 0);
  var_4 = vectordot(var_3, var_1);

  if(var_4 > 0) {
    return 1;
  }

  return 0;
}

_id_7A29(var_0) {
  if(!isDefined(var_0._id_AB4E) && !isDefined(var_0._id_E529)) {
    var_0 _id_F95E();
  }

  if(var_0._id_130C8 <= 1) {
    return var_0;
  }

  if(var_0._id_130C8 > 1) {
    var_2 = var_0 _id_36CF();
    var_3 = anglestoright(var_0.angles);
    var_4 = anglestoleft(var_0.angles);

    if(self == var_2) {
      return var_0;
    }

    if(isDefined(var_0._id_E529) && _id_9CF6(var_2, var_3)) {
      return var_0._id_E529;
    }

    if(isDefined(var_0._id_AB4E) && _id_9CF6(var_2, var_4)) {
      return var_0._id_AB4E;
    }
  }

  var_5 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  var_5 = scripts\engine\utility::add_to_array(var_5, var_0);
  var_6 = sortbydistance(var_5, self.origin);
  return var_6[0];
}

get_open_attack_spot(var_0) {
  var_1 = _id_7A29(var_0);

  if(isDefined(var_1) && _id_9CD2(var_1)) {
    return var_1;
  }

  var_2 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  var_2 = scripts\engine\utility::add_to_array(var_2, var_0);
  var_2 = scripts\engine\utility::array_randomize(var_2);

  foreach(var_4 in var_2) {
    if(_id_9CD2(var_4)) {
      return var_4;
    }
  }

  if(isDefined(var_1)) {
    return var_1;
  }

  return scripts\engine\utility::random(var_2);
}

_id_F2E3(var_0, var_1, var_2) {
  var_0.barrier._id_2BEB[var_1] = var_2;
}

_id_7872(var_0, var_1) {
  return var_0.barrier._id_2BEB[var_1];
}

_id_7B12(var_0) {
  for(var_1 = 0; var_1 < 6; var_1++) {
    if(var_0.barrier._id_2BEB[var_1] == "boarded") {
      return var_1 + 1;
    }
  }
}

_id_7B13(var_0) {
  for(var_1 = 5; var_1 >= 0; var_1--) {
    if(var_0.barrier._id_2BEB[var_1] == "destroyed") {
      return var_1 + 1;
    }
  }
}

remove_barrier_from_entrance(var_0, var_1) {
  if(!entrance_has_barriers(var_0)) {
    return;
  }
  var_2 = scripts\engine\utility::getStructArray("secure_window", "script_noteworthy");
  var_3 = scripts\engine\utility::getclosest(var_0.origin, var_2);

  if(!isDefined(var_1)) {
    var_1 = var_0.barrier._id_C1DE;

    if(var_1 > 6) {
      var_1 = 6;
    } else if(var_1 < 1) {
      var_1 = 1;
    }
  }

  var_0.barrier _id_F2D7("board_" + var_1, "destroy");
  var_0.barrier._id_C1DE--;

  if(!scripts\engine\utility::array_contains(level.current_interaction_structs, var_3)) {
    level.current_interaction_structs = scripts\engine\utility::array_add(level.current_interaction_structs, var_3);
  }

  var_3.disabled = 0;

  if(var_0.barrier._id_C1DE < 1) {
    var_3.disabled = 0;
  }
}

_id_F2D7(var_0, var_1) {
  if(var_0 == "all" && var_1 == "rebuild") {
    self setscriptablepartstate("board_1", "instant_rebuild");
    self setscriptablepartstate("board_2", "instant_rebuild");
    self setscriptablepartstate("board_3", "instant_rebuild");
    self setscriptablepartstate("board_4", "instant_rebuild");
    self setscriptablepartstate("board_5", "instant_rebuild");
    self setscriptablepartstate("board_6", "instant_rebuild");
  } else
    self setscriptablepartstate(var_0, var_1);
}