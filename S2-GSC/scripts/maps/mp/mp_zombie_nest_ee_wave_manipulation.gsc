/*******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_ee_wave_manipulation.gsc
*******************************************************************/

main() {
  level._id_294B = "wave_mod_normal";
}

_id_8606() {
  if(level._id_294B != "wave_mod_maxed") {
    level._id_294B = "wave_mod_maxed";
  } else {
    return;
  }

  _id_056D::_id_8A6E(0);
  level thread _id_3DF2("cancel_max_zombie_count");
}

_id_8607() {
  if(level._id_294B != "wave_mod_normal") {
    level._id_294B = "wave_mod_normal";
  } else {
    return;
  }

  level notify("cancel_max_zombie_count");
  _id_056D::_id_8A6E(0);
}

_id_8608() {
  if(level._id_294B != "wave_mod_paused") {
    level._id_294B = "wave_mod_paused";
  } else {
    return;
  }

  level notify("cancel_max_zombie_count");
  _id_056D::_id_8A6E(1);
}

_id_3DF2(var_0) {
  level endon(var_0);

  if(!isDefined(level.means_of_skipping_rounds_func)) {
    level thread _id_8C8E(var_0);
  } else {
    level thread[[level.means_of_skipping_rounds_func]](var_0);
  }

  for(;;) {
    var_1 = _id_0547::_id_408F();

    foreach(var_3 in var_1) {
      var_3._id_6816 = 1;

      if(common_scripts\utility::_id_562E(level.maxed_zombies_sprint) && _id_0547::_id_5565(var_3._id_0A4B, "zombie_generic")) {
        var_3._id_6941 = 1;
      }
    }

    wait 0.5;
  }
}

is_zombie_wave_maxed() {
  return _id_0547::_id_5565(level._id_294B, "wave_mod_maxed");
}

_id_8C8E(var_0) {
  self endon(var_0);
  level notify("zombies_skip_round_intermission");

  for(;;) {
    level waittill("round complete");
    waitframe();
    level notify("zombies_skip_round_intermission");
  }
}

skiproundwait2(var_0) {
  self endon(var_0);
  level notify("zombies_skip_round_intermission");
  level childthread disable_round_intermission();
}

disable_round_intermission() {
  for(;;) {
    waitframe();
    level notify("zombies_skip_round_intermission");
  }
}

enforce_zombie_limit(var_0, var_1) {
  self endon(var_0);
  waitframe();

  for(;;) {
    var_2 = _id_0547::_id_408F();

    if(var_2.size >= self.zombie_count) {
      _id_8608();
    } else {
      _id_8606();
    }

    if(isDefined(var_1)) {
      if(self.zombie_count > var_1) {
        foreach(var_4 in var_2) {
          var_4._id_6941 = 1;
        }
      }
    }

    waitframe();
  }
}

restore_normal_rounds(var_0) {
  self waittill(var_0);
  _id_8607();
}

hint_position_internal(var_0) {
  if(level.console) {
    self.elm.fontscale = 1;
  } else {
    self.elm.fontscale = 0.08;
  }

  self.elm.x = 0;
  self.elm.y = -40;
  self.elm.alignx = "left";
  self.elm.aligny = "bottom";
  self.elm._id_00C6 = "left";
  self.elm._id_01CA = "middle";
  self.elm.sort = 1;
  self.elm.alpha = 0.8;

  if(!isDefined(self.bg)) {
    return;
  }
  self.bg.x = 0;
  self.bg.y = -40;
  self.bg.alignx = "center";
  self.bg.aligny = "middle";
  self.bg._id_00C6 = "center";
  self.bg._id_01CA = "middle";
  self.bg.sort = -1;

  if(level.console) {
    self.bg setshader("popmenu_bg", 650, 52);
  } else {
    self.bg setshader("popmenu_bg", 650, 42);
  }

  if(!isDefined(var_0)) {
    var_0 = 0.5;
  }

  self.bg.alpha = var_0;
}