/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2644.gsc
*************************************************/

init() {}

_id_6B2E() {
  return "ks_remote_map_mp";
}

_id_6D1F(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  var_3 = 0;

  if(scripts\mp\utility\killstreak::_id_893E(var_0.streakname)) {
    var_3 = 1;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  thread _id_10BA6(var_0);
  thread _id_10BA7();
  thread _id_10BC7();
  var_4 = undefined;
  scripts\cp_mp\utility\killstreak_utility::_id_E72A(var_0.streakname, 0.05);
  var_4 = _id_6212(var_1, var_2);
  scripts\cp_mp\utility\killstreak_utility::_id_E941(0.75);
  return var_4;
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

    var_5 = var_4._id_96CF + (0, 0, 10000);
    var_6 = var_4._id_96CF - (0, 0, 10000);
    var_7 = scripts\cp_mp\vehicles\vehicle_tracking::_id_102BD();
    var_8 = level._id_0F4C;
    var_9 = scripts\engine\utility::array_combine(var_7, var_8);
    var_10 = scripts\engine\trace::_id_3EE5(0, 1, 0, 1, 1, 0, 0, 0, 0);
    var_11 = scripts\engine\trace::ray_trace(var_5, var_6, var_9, var_10, 0, 1);
    var_4._id_96CF = var_11["position"];
    var_3[var_3.size] = var_4;
    self._id_9AC6++;

    if(istrue(var_2)) {
      self setclientomnvar("ui_map_select_uses", var_0 - self._id_9AC6);
    }
  }

  self setclientomnvar("ui_map_select_count", -1);
  self notify("map_select_exit");

  if(isDefined(var_3)) {
    self.pers["startedMapSelect"] = 0;
  }

  return var_3;
}

_id_10BA8() {
  self endon("map_select_exit");

  for(;;) {
    var_0 = self getcurrentweapon();

    if(var_0.basename != "ks_remote_map_mp") {
      self notify("cancel_location");
      break;
    }

    waitframe();
  }
}

_id_10BA6(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("map_select_exit");
  _id_E916(var_0);
}

_id_10BA7() {
  self endon("disconnect");
  self endon("map_select_exit");
  level endon("game_ended");

  for(;;) {
    if(_id_078D::_id_85B3()) {
      self notify("cancel_location");
      break;
    }

    waitframe();
  }
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
  if(!self.pers["startedMapSelect"]) {
    _func_0253(self);
    self.pers["startedMapSelect"] = 1;
  }

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

_id_E916(var_0) {
  self._id_9AC6 = undefined;
  self._id_9AC5 = undefined;
  self._id_BC3A = undefined;

  if(scripts\mp\utility\player::isreallyalive(self)) {
    var_0 notify("killstreak_finished_with_deploy_weapon");
  } else {
    self.pers["startedMapSelect"] = 0;
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.25);

  if(isDefined(self)) {
    self _meth_80E7();
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