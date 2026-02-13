/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametypes.gsc
*************************************************/

init() {
  level._id_2BB5 = spawnStruct();
  level._id_2BB5._id_6035 = [];
  level._id_2BB5._id_4A9B = [];
  level._id_2BB5._id_5246 = [];
  level._id_2BB5._id_4350 = [];
  level._id_2BB5.name = getDvar("#x3f59526763711edc4", "");

  if(level._id_2BB5.name == "none") {
    level._id_2BB5.name = "";
  }

  switch (level._id_2BB5.name) {
    case "extract":
      scripts\mp\gametypes\br_gametype_extraction::init();
      break;
    case "evac":
      scripts\mp\gametypes\br_gametype_evac::init();
      break;
    case "dmz":
      scripts\mp\gametypes\br_gametype_dmz::init();
      break;
    case "sandbox":
      scripts\mp\gametypes\br_gametype_sandbox::init();
      break;
    case "":
      break;
    default:
      break;
  }
}

_id_C243(var_0, var_1) {
  level._id_2BB5._id_6035[var_0] = var_1;
}

_id_CA24(var_0, var_1, var_2) {
  if(isDefined(level._id_2BB5._id_6035[var_0])) {
    if(isDefined(var_2)) {
      return [[level._id_2BB5._id_6035[var_0]]](var_1, var_2);
    } else {
      return [[level._id_2BB5._id_6035[var_0]]](var_1);
    }
  }
}

_id_8792(var_0) {
  return isDefined(level._id_2BB5._id_6035[var_0]);
}

_id_4AB8(var_0) {
  level._id_2BB5._id_4A9B[var_0] = 1;
}

_id_8853(var_0) {
  return istrue(level._id_2BB5._id_4A9B[var_0]);
}

_id_5254(var_0) {
  level._id_2BB5._id_5246[var_0] = 1;
}

_id_8854(var_0) {
  return istrue(level._id_2BB5._id_5246[var_0]);
}

_id_C242(var_0, var_1) {
  level._id_2BB5._id_4350[var_0] = var_1;
}

_id_692C(var_0) {
  return level._id_2BB5._id_4350[var_0];
}