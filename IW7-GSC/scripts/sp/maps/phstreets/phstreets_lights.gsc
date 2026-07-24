/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\phstreets\phstreets_lights.gsc
**********************************************************/

main() {
  _id_1121D();
}

_id_1121D() {
  var_0 = scripts\sp\utility::_id_4960("phstreets_crash_sun");
  var_0.position = (-38, 62, 0);
  var_0 = scripts\sp\utility::_id_4960("phstreets_square_sun");
  var_0.position = (-42, -60, 0);
  var_0 = scripts\sp\utility::_id_4960("phstreets_911_sun");
  var_0.position = (-28, 16, 0);
  var_0 = scripts\sp\utility::_id_4960("phstreets_droppods_sun");
  var_0.position = (-47, 74, 0);
  var_0 = scripts\sp\utility::_id_4960("phstreets_bus_sun");
  var_0.position = (-54, 18, 0);
  var_0 = scripts\sp\utility::_id_4960("phstreets_hill_sun");
  var_0.position = (-31, 0, 0);
  var_0 = scripts\sp\utility::_id_4960("default");
  var_0.position = (-32, 38, 0);
  _id_0B0A::_id_1121E("default", 0);
}