/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1855.gsc
*************************************************/

init() {
  level._effect["map_target_mark"] = loadfx("vfx/iw8_cp/vfx_marker_map_target.vfx");
}

_id_EC77() {
  if(getdvarint("#x32b46e543e0b47dda", 0) == 0) {
    return 0;
  }

  return 0;
}

_id_6D1F(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = 0;

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  thread _id_10BC7();
  var_3 = undefined;
  var_3 = _id_6212(var_1, var_2);
  return var_3;
}

_id_6212(var_0, var_1) {
  var_2 = 1;

  if(var_0 <= 1) {
    self setclientomnvar("ui_map_select_uses", -1);
    var_2 = 0;
  }

  self._id_9AC6 = 0;
  self._id_BC3A = undefined;
  var_3 = [];
  thread _id_10BA8();

  if(istrue(var_2)) {
    self setclientomnvar("ui_map_select_uses", var_0);
    self setclientomnvar("ui_map_select_count", var_0);
  }

  while(self._id_9AC6 < var_0) {
    var_4 = _id_108BB("confirm_location", "cancel_location");

    if(!isDefined(var_4) || var_4._id_EA52 == "cancel_location") {
      var_3 = undefined;
      break;
    }

    var_3[var_3.size] = var_4;
    self._id_9AC6++;

    if(istrue(var_2)) {
      self setclientomnvar("ui_map_select_uses", var_0 - self._id_9AC6);
    }
  }

  self setclientomnvar("ui_map_select_count", -1);
  self notify("map_select_exit");
  level notify("vision_set_change_request", "", self, 0);

  if(isDefined(var_3)) {
    self.pers["startedMapSelect"] = 0;
  }

  return var_3;
}

_id_10BA8() {
  self endon("map_select_exit");

  for(;;) {
    var_0 = self getcurrentweapon();

    if(var_0.basename != "ks_remote_map_cp") {
      self notify("cancel_location");
      break;
    }

    waitframe();
  }
}

_id_10BA6() {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("map_select_exit");
  _id_E916();
}

_id_10BC7() {
  self endon("disconnect");
  self endon("map_select_exit");
  level endon("game_ended");
  self setclientomnvar("ui_location_selection_countdown", gettime() + 30000);
  scripts\engine\utility::_id_108A7(30, "death");
  self notify("cancel_location");
}

_id_E6E4(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  self _meth_8026(var_0, var_1, var_2, 1, var_3);
}

_id_E916() {
  self _meth_80E7();
  self._id_9AC6 = undefined;
  self._id_BC3A = undefined;

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    self notify("killstreak_finished_with_deploy_weapon");
  }
}

_id_108BB(var_0, var_1, var_2) {
  if((!isDefined(var_0) || var_0 != "death") && (!isDefined(var_1) || var_1 != "death")) {
    self endon("death");
  }

  var_3 = spawnStruct();

  if(isDefined(var_0)) {
    childthread _id_1091E(var_0, var_3);
  }

  if(isDefined(var_1)) {
    childthread _id_1091E(var_1, var_3);
  }

  if(isDefined(var_2)) {
    childthread _id_1091E(var_2, var_3);
  }

  var_3 waittill("returned", var_4, var_5, var_6);
  var_3 notify("die");
  var_7 = spawnStruct();
  var_7._id_96CF = var_4;
  var_7.angles = var_5;
  var_7._id_EA52 = var_6;
  return var_7;
}

_id_1091E(var_0, var_1) {
  if(var_0 != "death") {
    self endon("death");
  }

  var_1 endon("die");
  self waittill(var_0, var_2, var_3);
  var_1 notify("returned", var_2, var_3, var_0);
}

_id_D5EF() {}

_id_D3FD(var_0) {
  var_1 = _func_00E3();
  var_0._id_0358 = var_1;
}