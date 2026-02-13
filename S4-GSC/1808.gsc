/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1808.gsc
*************************************************/

_id_354B() {
  if(isDefined(level._id_C253)) {
    return;
  }
  level._id_C253 = [];
  var_0 = [[level._id_3545]]();
  var_1 = [[level._id_353F]]();

  if(var_0.size < 1 || var_1.size < 1) {
    return;
  }
  var_2 = scripts\engine\utility::array_combine(var_0, var_1);

  foreach(var_5, var_4 in var_2) {
    if(!isDefined(level._id_C253[var_4._id_353A])) {
      level._id_C253[var_4._id_353A] = [];
    }

    level._id_C253[var_4._id_353A][var_5] = var_4;
  }
}

_id_3546(var_0, var_1) {
  if(!isDefined(level._id_C252)) {
    level._id_C252 = [];
  }

  level._id_C252[var_0] = var_1;
}

_id_3549(var_0) {
  setDvar("#x37c07c0ad254a7b86", var_0);
  setDvar(_func_0483("#x3ecead486797add6d", level.mapname, "_start_obj"), "");
  setomnvar("ui_cp_checkpoint", 1);
}

_id_3543(var_0, var_1) {
  var_2 = level._id_C253[var_0];

  foreach(var_4 in var_2) {
    if(var_4.type != var_1) {
      continue;
    }
    if(var_4._id_353A != var_0) {
      continue;
    }
    if(isDefined(var_4._id_84EF)) {
      continue;
    }
    switch (var_1) {
      case "player_spawn":
        var_4._id_84EF = 1;
        return var_4;
      case "carepackage":
        return var_4;
    }
  }
}

_id_3547(var_0) {
  var_0 scripts\engine\utility::waittill_any_2("spawned_player", "disconnect");

  while(scripts\cp\utility::_id_190A(self.origin, 64)) {
    wait 1;
  }

  self._id_84EF = undefined;
}

_id_3541(var_0) {
  level endon("game_ended");
  var_1 = _id_3543(var_0, "carepackage");
  var_2 = spawn("script_model", var_1.origin);
  var_2.angles = var_1.angles;
  var_2 setModel("military_carepackage_01_friendly");
  var_3 = getent("care_package_col", "targetname");
  var_4 = spawn("script_model", var_1.origin);
  var_4.angles = var_1.angles;
  var_4 clonebrushmodeltoscriptmodel(var_3);
  var_4 linkto(var_2);
  var_5 = spawn("script_model", var_1.origin + (0, 0, 35));
  var_5 setModel("tag_origin");
  var_5 scripts\cp\utility::_id_D5A6(undefined, "HINT_BUTTON", undefined, &"CP_STRIKE/EDIT_LOADOUT", 25, "duration_short", "hide", 256, 75, 128, 75);
  var_5._id_75E9 = _func_0353(var_2);
  _func_0355(var_5._id_75E9, "hud_icon_survival_weapon");
  _func_035B(var_5._id_75E9, 0);
  _func_035A(var_5._id_75E9, 1024);
  _func_0359(var_5._id_75E9, 256);
  _func_035D(var_5._id_75E9, -5);
  var_2._id_3A5F = var_4;
  var_2._id_8350 = var_5;
  var_5 thread _id_353E(var_2);
  return var_2;
}

_id_353E(var_0) {
  self endon("death");
  var_0 endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(!var_1 scripts\cp\utility::_id_8708()) {
      continue;
    }
    var_1 thread _id_3542(self);
  }
}

_id_3542(var_0) {
  self endon("disconnect");
  self endon("last_stand");
  level endon("game_ended");
  var_0 disableplayeruse(self);
  self setclientomnvar("cp_open_cac", -1);
  self setclientomnvar("ui_options_menu", 2);
  scripts\engine\utility::waittill_any_2("loadout_given", "loadout_menu_closed");
  wait 1;
  self setclientomnvar("cp_open_cac", -2);
  var_0 _meth_80E0(self);
}

_id_353C(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_1;
  var_3.angles = var_2;
  var_3.type = "player_spawn";
  var_3._id_353A = var_0;
  return var_3;
}

_id_353B(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_1;
  var_3.angles = var_2;
  var_3.type = "carepackage";
  var_3._id_353A = var_0;
  return var_3;
}