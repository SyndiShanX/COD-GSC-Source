/*******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_monsters\mp_monsters.gsc
*******************************************************/

main() {
  scripts\mp\maps\mp_monsters\mp_monsters_precache::main();
  scripts\mp\maps\mp_monsters\gen\mp_monsters_art::main();
  scripts\mp\maps\mp_monsters\mp_monsters_fx::main();
  scripts\mp\maps\mp_monsters\mp_monsters_lighting::main();
  _id_07EC::main();
  _id_07C0::_id_D88B("compass_map_mp_monsters");
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  game["allies"] = "USMC";
  game["axis"] = "ALQ";
  level._id_F7AA = 1;
  level.airstrikeheightoffset = 800;
}