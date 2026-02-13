/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_texas\mp_texas.gsc
*************************************************/

main() {
  scripts\mp\maps\mp_texas\mp_texas_precache::main();
  scripts\mp\maps\mp_texas\gen\mp_texas_art::main();
  scripts\mp\maps\mp_texas\mp_texas_fx::main();
  scripts\mp\maps\mp_texas\mp_texas_lighting::main();
  _id_07EC::main();
  _id_07C0::_id_D88B("compass_map_mp_texas");
  setDvar("#x32ee39981452e9751", 8);
  setDvar("#x3e634b52165a47381", 8196);
  setDvar("#x3d2f3327c3c633b22", 8196);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  game["allies"] = "USMC";
  game["axis"] = "ALQ";
  level._id_F7AA = 1;
  level._id_AD0F = getEntArray("OutOfBounds", "targetname");
  level.airstrikeheightoffset = 2000;
}

animateplanes() {
  var_0 = getEntArray("plane_animated_01", "targetname");

  foreach(var_2 in var_0) {
    var_2 _meth_82CC("s4_usa_texas_plane_kindia_00_anim");
  }
}