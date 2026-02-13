/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2063.gsc
*************************************************/

_id_A20D() {
  var_0 = getent("weapon_loc_screenshot_1", "targetname");
  var_1 = var_0.origin + (0, 0, 0);
  var_2 = var_0.angles + (0, 0, 0);
  level._id_B0B9.origin = var_1;
  level._id_B0B9.angles = var_2;
  var_3 = getent("camera_weapon_screenshot_1", "targetname");
  var_4 = var_3.origin + (100, 0, 0);
  var_5 = var_3.angles + (0, 0, 0);
  level._id_2FF9 dontinterpolate();
  level._id_2FF9.origin = var_4;
  level._id_2FF9.angles = var_5;
}

_id_A20E() {
  var_0 = getent("weapon_loc_screenshot_1", "targetname");
  var_1 = var_0.origin + (0, 0, 0);
  var_2 = var_0.angles + (0, -25, 0);
  level._id_B0B9.origin = var_1;
  level._id_B0B9.angles = var_2;
  var_3 = getent("camera_weapon_screenshot_1", "targetname");
  var_4 = var_3.origin + (100, 0, 0);
  var_5 = var_3.angles + (0, 0, 0);
  level._id_2FF9 dontinterpolate();
  level._id_2FF9.origin = var_4;
  level._id_2FF9.angles = var_5;
}

_id_A212() {
  var_0 = getent("weapon_loc_screenshot_2", "targetname");
  var_1 = var_0.origin + (0, 0, 0);
  var_2 = var_0.angles + (0, 0, 0);
  level._id_B0B9.origin = var_1;
  level._id_B0B9.angles = var_2;
  var_3 = getent("camera_weapon_screenshot_2", "targetname");
  var_4 = var_3.origin + (100, 0, 0);
  var_5 = var_3.angles + (0, 0, 0);
  level._id_2FF9 dontinterpolate();
  level._id_2FF9.origin = var_4;
  level._id_2FF9.angles = var_5;
}

_id_A213() {
  var_0 = getent("weapon_loc_screenshot_2", "targetname");
  var_1 = var_0.origin + (0, 0, 0);
  var_2 = var_0.angles + (0, -25, 0);
  level._id_B0B9.origin = var_1;
  level._id_B0B9.angles = var_2;
  var_3 = getent("camera_weapon_screenshot_2", "targetname");
  var_4 = var_3.origin + (100, 0, 0);
  var_5 = var_3.angles + (0, 0, 0);
  level._id_2FF9 dontinterpolate();
  level._id_2FF9.origin = var_4;
  level._id_2FF9.angles = var_5;
}

_id_ED9C(var_0) {
  var_1 = _func_0222("mp/weaponScreenshotList.csv", 0, var_0, 1);
  _id_A20D();
  wait 2;
  wait 2;
  _id_A20E();
  wait 2;
  wait 2;
  _id_A212();
  wait 2;
  wait 2;
  _id_A213();
  wait 2;
  wait 2;
}