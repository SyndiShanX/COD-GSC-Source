/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1804.gsc
*************************************************/

init() {
  thread _id_BA29();
}

_id_BA29() {
  level._id_0F17 = 0;
  level._id_2957 = [];
  var_0 = getEntArray("boundary", "script_noteworthy");

  foreach(var_2 in var_0) {
    _id_0FA1(var_2);
  }

  for(;;) {
    level waittill("player_spawned", var_4);

    if(isDefined(var_4)) {
      var_4 thread _id_FB30();
    }
  }
}

_id_F0BB() {
  for(;;) {
    _id_0E9F("boundary_zod");
    wait 5;
    _id_436F();
    wait 5;
    _id_0E9F("boundary_zod");
    wait 5;
    _id_4371("boundary_zod");
    wait 5;
  }
}

_id_0FA1(var_0) {
  if(!scripts\engine\utility::array_contains(level._id_2957, var_0)) {
    var_0._id_0026 = 0;
    level._id_2957 = scripts\engine\utility::array_add(level._id_2957, var_0);
  }
}

_id_C386(var_0) {
  if(scripts\engine\utility::array_contains(level._id_2957, var_0)) {
    var_0._id_0026 = undefined;
    level._id_2957 = scripts\engine\utility::array_remove(level._id_2957, var_0);
  }
}

_id_0E9F(var_0) {
  var_1 = 0;

  foreach(var_3 in level._id_2957) {
    if(var_3.name == var_0) {
      if(var_3._id_0026 == 0) {
        var_3._id_0026 = 1;
        level._id_0F17++;
        level notify("boundary_activated");
      } else {}

      var_1 = 1;
    }
  }

  if(!var_1) {
    return;
  }
}

_id_4371(var_0) {
  var_1 = 0;

  foreach(var_3 in level._id_2957) {
    if(var_3.name == var_0) {
      if(var_3._id_0026 == 1) {
        var_3._id_0026 = 0;
        level._id_0F17--;
      } else {}

      var_1 = 1;
    }
  }

  if(!var_1) {
    return;
  }
}

_id_436F() {
  foreach(var_1 in level._id_2957) {
    var_1._id_0026 = 0;
  }

  level._id_0F17 = 0;
}

_id_FB30() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  thread death_watcher();
  self._id_ACA2 = 0;

  for(;;) {
    if(level._id_0F17 == 0) {
      if(istrue(self._id_ACA2)) {
        _id_E8E8();
      }

      level waittill("boundary_activated");
    }

    var_0 = 0;

    foreach(var_2 in level._id_2957) {
      var_0 = var_0 || self istouching(var_2);
    }

    if(var_0) {
      _id_E8E8();
    } else if(!istrue(self._id_ACA2)) {
      self._id_ACA2 = 1;
      thread loop_boundary_sound_on_player();
      thread _id_ED88();
    }

    waitframe();
  }
}

_id_E8E8() {
  if(istrue(self._id_ACA2)) {
    self playlocalsound("zmb_dome_enter");
  }

  self stoploopsound("zmb_dome_outside_lp");
  self._id_ACA2 = 0;
  self notify("boundary_safe");
  self setclientomnvar("zm_hint_index", 0);
}

_id_ED88() {
  thread loop_boundary_sound_on_player();
  self playlocalsound("zmb_dome_exit");
  var_0 = 1;
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("boundary_safe");
  var_1 = int(_func_0222("cp/cp_hints.csv", 1, "turn_back", 0));
  self setclientomnvar("zm_hint_index", var_1);
  var_2 = 1;

  for(;;) {
    self dodamage(1 * var_2, self.origin);
    var_2++;

    if(istrue(var_0)) {
      var_0 = 0;
    } else {
      self playlocalsound("zmb_dome_damage_tick");
    }

    wait 4;
  }
}

death_watcher() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("boundary_safe");
  self waittill("death");
  _id_E8E8();
}

loop_boundary_sound_on_player() {
  self endon("boundary_safe");
  self endon("disconnect");
  level endon("game_ended");
  level endon("objective_ended");
  thread loop_boundary_sound_on_player_watcher();

  for(;;) {
    self playlocalsound("zmb_dome_outside");
    wait 15;
  }
}

loop_boundary_sound_on_player_watcher() {
  scripts\engine\utility::_id_10882("boundary_safe", "disconnect", "game_ended", "objective_ended");

  if(isDefined(self)) {
    self _meth_83EF("zmb_dome_outside");
  }
}