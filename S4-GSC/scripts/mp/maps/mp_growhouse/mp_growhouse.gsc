/*********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_growhouse\mp_growhouse.gsc
*********************************************************/

main() {
  scripts\mp\maps\mp_growhouse\mp_growhouse_precache::main();
  scripts\mp\maps\mp_growhouse\gen\mp_growhouse_art::main();
  scripts\mp\maps\mp_growhouse\mp_growhouse_fx::main();
  scripts\mp\maps\mp_growhouse\mp_growhouse_lighting::main();
  _id_07EC::main();
  _id_07C0::_id_D88B("compass_map_mp_growhouse");
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  game["allies"] = "USMC";
  game["axis"] = "ALQ";
  level._id_F7AA = 1;
  level._id_AD0F = getEntArray("OutOfBounds", "targetname");
  level.airstrikeheightoffset = 2800;
  _func_01AF("s4_mp_electronics_fan_box_01_spin");
  thread animate_fan();
}

animate_fan() {
  var_0 = getent("sphere_fan_animated_01", "targetname");
  var_0 _meth_82CC("s4_mp_electronics_fan_box_01_spin");
}