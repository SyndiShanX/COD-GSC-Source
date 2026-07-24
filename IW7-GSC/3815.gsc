/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3815.gsc
**************************************/

_id_13C2A() {
  level._id_13C29 = spawnStruct();
  level._id_13C29._id_AF20 = [];
  level._id_13C29._id_AF20["player_locker"] = undefined;
  level._id_13C29._id_AF20["terminal_2"] = undefined;
  level._id_13C29._id_AF20["lounge_locker"] = undefined;
  level._id_13C29._id_AF20["lounge_locker_2"] = undefined;
  level._id_13C29._id_116D9 = undefined;
  var_0 = scripts\engine\utility::getStructArray("loadout_grab_interact", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_parameters)) {
      switch (var_2.script_parameters) {
        case "player_terminal":
          level._id_13C29._id_AF20["player_locker"] = var_2;
          break;
        case "lounge_terminal":
          level._id_13C29._id_AF20["lounge_locker"] = var_2;
          break;
        case "terminal_2":
          level._id_13C29._id_AF20["terminal_2"] = var_2;
          break;
        case "terminal_3":
          level._id_13C29._id_AF20["terminal_3"] = var_2;
          break;
        case "lounge_terminal_2":
          level._id_13C29._id_AF20["lounge_locker_2"] = var_2;
          break;
      }
    } else
      return;

    var_3 = [];
    var_3 = getEntArray(var_2.target, "targetname");
    var_4 = getEntArray("locker_clip", "script_noteworthy");
    var_2._id_13C28["locker_body_pieces"] = [];
    var_2._id_13C28["locker_primary_weapons"] = [];
    var_2._id_13C28["locker_misc_weapons"] = [];
    var_2._id_D8D3 = undefined;
    var_2._id_F0BA = undefined;
    var_2._id_8CED = undefined;
    var_2._id_AF14 = undefined;
    var_2.clip = undefined;
    var_2._id_CB3A = scripts\engine\utility::getStruct(var_2.target, "targetname");

    foreach(var_6 in var_4) {
      if(isDefined(var_6.script_parameters)) {
        if(var_6.script_parameters == "lounge_terminal" || var_6.script_parameters == "lounge_terminal_2") {
          var_6 hide();
        }
      }
    }

    foreach(var_9 in var_3) {
      switch (var_9.script_noteworthy) {
        case "locker_body_pieces":
          var_2._id_13C28["locker_body_pieces"] = ::scripts\engine\utility::array_add(var_2._id_13C28["locker_body_pieces"], var_9);
          break;
        case "primary":
          var_2._id_13C28["locker_primary_weapons"] = ::scripts\engine\utility::array_add(var_2._id_13C28["locker_primary_weapons"], var_9);
          var_2._id_D8D3 = var_9;
          break;
        case "secondary":
          var_2._id_13C28["locker_primary_weapons"] = ::scripts\engine\utility::array_add(var_2._id_13C28["locker_primary_weapons"], var_9);
          var_2._id_F0BA = var_9;
          break;
        case "heavy":
          var_2._id_13C28["locker_primary_weapons"] = ::scripts\engine\utility::array_add(var_2._id_13C28["locker_primary_weapons"], var_9);
          var_2._id_8CED = var_9;
          break;
        case "locker_misc_weapons":
          var_2._id_13C28["locker_misc_weapons"] = ::scripts\engine\utility::array_add(var_2._id_13C28["locker_misc_weapons"], var_9);
          break;
        case "locker_object":
          var_2._id_AF14 = var_9;
          break;
        case "handscanner":
          var_2._id_8A0A = var_9;
          var_2._id_8A0A hide();
          break;
      }
    }

    var_2 thread _id_966E();
  }

  var_12 = level._id_13C29._id_AF20["player_locker"]._id_13C28["locker_primary_weapons"];

  if(isDefined(var_12)) {
    foreach(var_14 in var_12) {
      var_14 hide();
    }
  }
}

_id_966E() {
  self._id_F0BA.angles = self._id_F0BA.angles + (0, 180, 0);

  foreach(var_1 in self._id_13C28["locker_primary_weapons"]) {
    var_1 linkTo(self._id_AF14, "gun_rack_jt");
  }

  if(isDefined(self._id_8A0A)) {
    self._id_8A0A linkTo(self._id_AF14, "gun_rack_jt");
  }

  scripts\engine\utility::waitframe();

  if(self.script_parameters == "player_terminal") {
    self._id_D8D2 = self._id_D8D3 scripts\engine\utility::spawn_tag_origin();
    self._id_D8D2 linkTo(self._id_AF14, "gun_rack_jt");
    self._id_F0B9 = self._id_F0BA scripts\engine\utility::spawn_tag_origin();
    self._id_F0B9 linkTo(self._id_AF14, "gun_rack_jt");
    self._id_8CEB = self._id_8CED scripts\engine\utility::spawn_tag_origin();
    self._id_8CEB linkTo(self._id_AF14, "gun_rack_jt");
  }

  for(;;) {
    self waittill("locker_raise");
    self notify("locker_ready");
    self notify("locker_used");
    self waittill("locker_lower");
    wait 0.5;
  }
}

_id_BC9E(var_0, var_1, var_2) {
  var_3 = 0.5;

  if(isDefined(var_2)) {
    var_3 = var_2;
  }

  var_4 = [];

  if(var_1 == "up") {
    var_5 = (0, 0, 38);
  } else {
    var_5 = (0, 0, -38);
  }

  foreach(var_7 in var_0) {
    var_4 = scripts\engine\utility::array_add(var_4, var_7.origin);
  }

  foreach(var_12, var_10 in var_0) {
    var_11 = var_4[var_12] + var_5;
    var_10 moveTo(var_11, var_3, 0.1, 0.1);
  }
}

_id_BC3D(var_0, var_1) {
  var_2 = [];

  if(var_1 == "right") {
    var_3 = anglestoright(self.angles) * -24.0;
  } else {
    var_3 = anglestoright(self.angles) * 24.0;
  }

  foreach(var_5 in var_0) {
    var_2 = scripts\engine\utility::array_add(var_2, var_5.origin);
  }

  foreach(var_10, var_8 in var_0) {
    var_9 = var_2[var_10] + var_3;
    var_8 moveTo(var_9, 0.5, 0.1, 0.1);
  }
}

_id_7D64(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "terminal_2":
      var_1 = level._id_13C29._id_AF20["terminal_2"];
      break;
    case "player":
      var_1 = level._id_13C29._id_AF20["player_locker"];
      break;
    case "lounge":
      var_1 = level._id_13C29._id_AF20["lounge_locker"];
      break;
    case "terminal_3":
      var_1 = level._id_13C29._id_AF20["terminal_3"];
      break;
    case "lounge_2":
      var_1 = level._id_13C29._id_AF20["lounge_locker_2"];
      break;
  }

  if(!isDefined(var_1)) {
    return undefined;
  } else {
    return var_1;
  }
}

_id_CD79() {
  if(isDefined(level._id_FDFA) && issubstr(level._id_FDFA, "ja_")) {
    return;
  }
  playFXOnTag(scripts\engine\utility::getfx("vfx_sc_armory_terminal_handscanner"), self._id_8A0A, "tag_handon");
  wait 4.0;
  stopFXOnTag(scripts\engine\utility::getfx("vfx_sc_armory_terminal_handscanner"), self._id_8A0A, "tag_handon");
}