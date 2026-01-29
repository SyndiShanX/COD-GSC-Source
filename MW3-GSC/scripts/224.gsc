/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\224.gsc
**************************************/

main() {
  common_scripts\utility::flag_init("coop_game");

  if(!maps\_utility::_id_12C1()) {
    return;
  }
  common_scripts\utility::flag_set("coop_game");
  common_scripts\utility::flag_init("coop_show_constant_icon");
  setdvarifuninitialized("coop_show_constant_icon", 1);

  if(getdvarint("coop_show_constant_icon") == 1) {
    common_scripts\utility::flag_set("coop_show_constant_icon");

  }
  precacheshader("hint_health");
  precacheshader("coop_player_location");
  precacheshader("coop_player_location_fire");
  level._id_1A31 = 7;
  level._id_1A32 = 0.375;
  level._id_1A33 = 20;

  foreach(var_1 in level.players) {
    var_1._id_01D1 = var_1 getlocalplayerprofiledata("colorBlind");
    var_1 thread _id_1A34(var_1._id_01D1);
    var_1 thread _id_1A44();
  }
}

_id_1A34(var_0) {
  if(var_0) {
    var_1 = (0.35, 1, 1);
    var_2 = (1, 0.65, 0.2);
    var_3 = (1, 1, 1);
    self._id_1A35 = var_1;
    self._id_1A36 = var_2;
    self._id_1A37 = var_1;
    self._id_1A38 = var_3;
    self._id_1A39 = var_2;
    self._id_1A3A = var_3;
  } else {
    var_4 = (0.635, 0.929, 0.604);
    var_5 = (1, 1, 0.2);
    var_2 = (1, 0.65, 0.2);
    var_6 = (1, 0.2, 0.2);
    var_3 = (1, 1, 1);
    self._id_1A35 = var_4;
    self._id_1A36 = var_5;
    self._id_1A37 = var_4;
    self._id_1A38 = var_2;
    self._id_1A39 = var_6;
    self._id_1A3A = var_3;
  }
}

_id_1A3B(var_0, var_1, var_2) {
  if(isDefined(self._id_1A3C)) {
    return;
  }
  if(!isDefined(self._id_1A3D) || self._id_1A3D._id_1A3E != var_1) {
    _id_1A3F(var_1);

  }
  self._id_1A3D.color = var_0;

  if(isDefined(var_2) && var_2) {
    self._id_1A3D setwaypointedgestyle_rotatingicon();
  }
}

_id_1A3F(var_0) {
  if(isDefined(self._id_1A3D)) {
    self._id_1A3D destroy();

  }
  self._id_1A3D = newclienthudelem(self);
  self._id_1A3D setshader(var_0, 1, 1);
  self._id_1A3D setwaypoint(1, 1, 0);
  self._id_1A3D setwaypointiconoffscreenonly();
  self._id_1A3D settargetent(maps\_utility::_id_133A(self));
  self._id_1A3D._id_1A3E = var_0;
  self._id_1A3D.hidewheninmenu = 1;

  if(common_scripts\utility::flag("coop_show_constant_icon")) {
    self._id_1A3D.alpha = 1.0;
  } else {
    self._id_1A3D.alpha = 0.0;
  }
}

_id_1A40() {
  self endon("death");

  for(;;) {
    self waittill("weapon_fired");
    var_0 = maps\_utility::_id_133A(self);
    var_0 thread _id_1A42(var_0._id_1A37, "coop_player_location_fire", 1);
  }
}

_id_1A41() {
  self endon("death");

  for(;;) {
    self waittill("damage");
    var_0 = maps\_utility::_id_133A(self);
    var_0 thread _id_1A42(var_0._id_1A38, "coop_player_location", 1);
  }
}

_id_1A42(var_0, var_1, var_2) {
  if(isDefined(self._id_1A3C)) {
    return;
  }
  self endon("death");
  self notify("flash_color_thread");
  self endon("flash_color_thread");
  var_3 = maps\_utility::_id_133A(self);

  if(maps\_utility::_id_1A43(var_3)) {
    return;
  }
  _id_1A3B(var_0, var_1, var_2);
  wait 0.5;
  var_1 = _id_1A4F();
  var_4 = _id_1A50();
  _id_1A3B(self._id_1A35, var_1, var_4);
}

_id_1A44() {
  level endon("special_op_terminated");
  _id_1A4B();
  thread _id_1A40();
  thread _id_1A41();
  thread _id_1A51();
  thread _id_1A45();

  if(isDefined(self._id_1A3C)) {
    return;
  }
  self._id_1A3D.alpha = 0.0;

  for(;;) {
    common_scripts\utility::flag_wait("coop_show_constant_icon");
    self._id_1A3D.alpha = 1.0;
    common_scripts\utility::flag_waitopen("coop_show_constant_icon");
    self._id_1A3D.alpha = 0.0;
  }
}

_id_1A45() {
  level waittill("special_op_terminated");

  foreach(var_1 in level.players) {}
  var_1 _id_1A46();
}

_id_1A46() {
  if(isDefined(self._id_1A3D)) {
    self._id_1A3D destroy();
  }
}

_id_1A47() {
  common_scripts\utility::flag_clear("coop_show_constant_icon");
}

_id_1A48() {
  common_scripts\utility::flag_set("coop_show_constant_icon");
}

_id_1A49() {
  self._id_1A3C = 1;
  _id_1A46();
}

_id_1A4A() {
  self._id_1A3C = undefined;

  if(!isDefined(self._id_1A3D)) {
    _id_1A4B();
  }
}

_id_1A4B() {
  if(!common_scripts\utility::flag("coop_game")) {
    return;
  }
  self._id_1A4C = "ICON_STATE_NORMAL";
  var_0 = _id_1A4F();
  var_1 = _id_1A50();
  _id_1A3B(self._id_1A35, var_0, var_1);
}

_id_1A4D() {
  if(!common_scripts\utility::flag("coop_game")) {
    return;
  }
  self._id_1A4C = "ICON_STATE_DOWNED";
  var_0 = _id_1A4F();
  var_1 = _id_1A50();
  _id_1A3B(self._id_1A36, var_0, var_1);
}

_id_1A4E(var_0) {
  if(!common_scripts\utility::flag("coop_game")) {
    return;
  }
  var_1 = _id_1A4F();
  var_2 = _id_1A50();
  _id_1A3B(var_0, var_1, var_2);
}

_id_1A4F() {
  var_0 = "coop_player_location";

  switch (self._id_1A4C) {
    case "ICON_STATE_NORMAL":
      var_0 = "coop_player_location";
      break;
    case "ICON_STATE_DOWNED":
      var_0 = "hint_health";
      break;
    default:
      break;
  }

  return var_0;
}

_id_1A50() {
  var_0 = 0;

  switch (self._id_1A4C) {
    case "ICON_STATE_NORMAL":
      var_0 = 1;
      break;
    case "ICON_STATE_DOWNED":
      var_0 = 0;
      break;
    default:
      break;
  }

  return var_0;
}

_id_1A51() {
  for(;;) {
    if(self getlocalplayerprofiledata("colorBlind") != self._id_01D1) {
      self._id_01D1 = self getlocalplayerprofiledata("colorBlind");
      _id_1A34(self._id_01D1);

      switch (self._id_1A4C) {
        case "ICON_STATE_NORMAL":
          _id_1A4B();
          break;
        case "ICON_STATE_DOWNED":
          _id_1A4D();
          break;
      }
    }

    wait 0.05;
  }
}