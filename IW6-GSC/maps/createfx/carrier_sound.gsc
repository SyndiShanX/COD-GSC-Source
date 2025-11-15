/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createfx\carrier_sound.gsc
*******************************************/

main() {
  var_0 = common_scripts\_createfx::createloopsound();
  var_0 common_scripts\_createfx::set_origin_and_angles((-679.934, 7544.54, 1363.88), (270, 0, 0));
  var_0.v["soundalias"] = "emt_carr_vent_01";
  var_0 = common_scripts\_createfx::createloopsound();
  var_0 common_scripts\_createfx::set_origin_and_angles((-724.751, 7491.98, 1351.69), (270, 0, 0));
  var_0.v["soundalias"] = "emt_carr_light_hum_02_lp";
  var_0 = common_scripts\_createfx::createloopsound();
  var_0 common_scripts\_createfx::set_origin_and_angles((-1007.7, 6319.65, 1365.88), (270, 0, 0));
  var_0.v["soundalias"] = "emt_carr_vent_tone_01";
  var_0 = common_scripts\_createfx::createloopsound();
  var_0 common_scripts\_createfx::set_origin_and_angles((-1140.93, 5544.03, 1366.45), (270, 0, 0));
  var_0.v["soundalias"] = "emt_carr_vent_02";
  var_0 = common_scripts\_createfx::createloopsound();
  var_0 common_scripts\_createfx::set_origin_and_angles((-1059.13, 5972.25, 1318.13), (270, 0, 0));
  var_0.v["soundalias"] = "emt_carr_vent_tone_02";
  var_0 = common_scripts\_createfx::createloopsound();
  var_0 common_scripts\_createfx::set_origin_and_angles((-1203.1, 6312.26, 1366.44), (270, 0, 0));
  var_0.v["soundalias"] = "emt_carr_vent_04";
  var_0 = common_scripts\_createfx::createloopsound();
  var_0 common_scripts\_createfx::set_origin_and_angles((-868.847, 6903.19, 1374.87), (270, 0, 0));
  var_0.v["soundalias"] = "emt_carr_vent_02";
  var_0 = common_scripts\_createfx::createintervalsound();
  var_0 common_scripts\_createfx::set_origin_and_angles((-754.564, 7447.27, 1268.13), (270, 0, 0));
  var_0.v["delay_min"] = 2.9;
  var_0.v["delay_max"] = 3.5;
  var_0.v["soundalias"] = "emt_dog_pants_med";
}