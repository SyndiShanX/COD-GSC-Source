/*********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\ship_assault_00\ship_assault_00_audio.gsc
*********************************************************************/

main() {}

_id_A11B() {
  thread _id_0F00::_id_A070();
  thread _id_0F00::_id_A06F();
  thread _id_0F00::_id_D050();
  level thread _id_0F00::_id_CD09("snd_battle_background_ambience", "sa_ext_battle_bg_distant", "entering_airlock");
  level thread _id_0F00::_id_CD09("snd_cap_ship_thruster_ambience", "sa_ext_cap_ship_thrusters", "entering_airlock");
}

_id_13E99() {
  level thread _id_0F00::_id_CD09("snd_battle_background_ambience", "sa_ext_battle_bg_distant", "entering_airlock");
  level thread _id_0F00::_id_CD09("snd_cap_ship_thruster_ambience", "sa_ext_cap_ship_thrusters", "entering_airlock");
}

_id_9433() {
  level thread _id_0F00::_id_CD09("snd_battle_background_ambience", "sa_ext_battle_bg_distant", "entering_airlock");
  level thread _id_0F00::_id_CD09("snd_cap_ship_thruster_ambience", "sa_ext_cap_ship_thrusters", "entering_airlock");
  level thread _id_0F00::_id_6FFD();
}

_id_8A32() {
  _id_0F00::_id_FC1D();
  wait 5;
  level thread _id_0F00::_id_CDD7("war");
}

_id_3A95() {
  _id_0F00::_id_FC1D();
  wait 5;
  level thread _id_0F00::_id_CDD7("war");
}

_id_13E98() {
  scripts\sp\utility::_id_BDEC(5);
}

_id_944B() {}

_id_1ADB() {
  wait 1;
  _id_0F00::_id_FC1B();
}