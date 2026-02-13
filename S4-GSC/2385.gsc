/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2385.gsc
*************************************************/

main() {
  _id_95CE();
  _id_C1EF();
  _id_0961::_id_C28D(scripts\cp\utility::_id_7908);
}

_id_95CE() {
  _id_0724::main();
}

_id_C1EF() {
  _id_8080();
}

_id_D6BA() {
  wait 10;
  thread _id_D6BB();
}

_id_D6BB() {
  self endon("unsetRShieldScrambler");
  self waittill("death_or_disconnect");

  if(isDefined(self)) {
    _id_FAF5();
  }
}

_id_FAF5() {
  self notify("unsetRShieldScrambler");
}

_id_8080() {
  var_0 = [(14603.2, 15402.2, 242.65), (-372, 15255.8, -263.87), (-19501.8, 56249.3, 4280.82), (-38927.2, -5669.34, -77.89), (-21837.8, -20546.2, -182.41), (-150.85, 47187.2, 1795.04)];
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = spawnStruct();
    var_4.origin = var_3;
    var_4._id_806B = var_4.origin;
    var_4.angles = (0, 0, 0);
    var_4._id_1883 = "wm_eq_fusebox_turn_on_plr";
    var_4.model = "body_spetsnaz_ar";
    var_4.target = "lever";
    var_4._id_0481 = "switch_interact";
    var_4._id_C01B = 1000;
    var_5 = spawn("script_model", var_4.origin + (25.5, -0.5, 56));
    var_5 setModel("uk_electrical_box_medium_02_animated");
    var_5.angles = var_4.angles + (0, 180, 0);
    var_5._id_1883 = "wm_eq_fusebox_turn_on_plr";
    var_5._id_0481 = "lever";
    var_4._id_935D = var_5;
    var_5._id_EA6A = var_4;
    var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  waitframe();
  var_7 = var_1;
  level._id_BF33 = [];

  foreach(var_9 in var_7) {
    var_10 = _id_D82A(var_9);
    var_10 thread _id_FE11();
    level._id_BF33 = scripts\engine\utility::array_add(level._id_BF33, var_10);
  }
}

_id_D82A(var_0) {
  var_1 = var_0._id_935D;
  var_1 scripts\cp\utility::_id_D5A6("j_handle", "HINT_BUTTON", "icon_electrical_box", &"CP_STRIKE/TURN_ON_ALARM", 25, "duration_short", "hide", 128, 120, 70, 45);
  var_2 = spawnStruct();
  var_1._id_CBD0 = var_0;
  var_1 scripts\engine\utility::_id_5473("switch_on");

  if(isDefined(var_1)) {
    var_1 thread _id_0724::_id_EC26();
  }

  return var_1;
}

_id_FE11() {
  for(;;) {
    self waittill("interact", var_0);

    if(self._id_546E["switch_on"]) {
      iprintln(" minimap Activated! ");
      thread _id_0942::_id_D813(self.origin, var_0, self);
      scripts\engine\utility::_id_1BE2(level.players, ::_id_10A59, self);
      _id_0961::_id_C28D(::_id_10A59);
      continue;
    }

    iprintln(" minimap DeActivated! ");
    self._id_F8E9 notify("uav_disabled");
  }
}

_id_EC26() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    self makeunusable();
    var_1 = _id_0788::_id_182C(var_0, "player_rig", 1);
    var_2 = _id_0788::_id_182C(self, "fusebox_prop");

    if(!scripts\engine\utility::_id_546E("switch_on")) {
      var_3 = self._id_CBD0 _id_0788::_id_182B([var_1, var_2], "interact_on");

      if(var_3) {
        scripts\engine\utility::_id_5474("switch_on");
        self sethintstring(&"CP_STRIKE/TURN_OFF_ALARM");
      }
    } else {
      var_3 = self._id_CBD0 _id_0788::_id_182B([var_1, var_2], "interact");

      if(var_3) {
        scripts\engine\utility::_id_5470("switch_on");
        self sethintstring(&"CP_STRIKE/TURN_ON_ALARM");
      }
    }

    self notify("interact", var_0);
    self makeuseable();
    var_1 = undefined;
    var_2 = undefined;
  }
}

_id_10A59(var_0) {
  self notify("watch_for_player_out_of_range");
  self endon("watch_for_player_out_of_range");

  if(!isDefined(self._id_BF0A)) {
    self._id_BF0A = 0;
  }

  for(;;) {
    wait 1;

    if(distance2dsquared(self.origin, var_0.origin) > _func_0219(var_0._id_EA6A._id_C01B)) {
      if(!istrue(self._id_024A)) {
        self._id_BF0A++;
        scripts\cp\utility::_id_7908();
        self._id_024A = 1;
      }

      continue;
    }

    if(istrue(self._id_024A)) {
      self._id_BF0A--;
      scripts\cp\utility::_id_DCC4();
      self._id_024A = 0;
    }
  }
}