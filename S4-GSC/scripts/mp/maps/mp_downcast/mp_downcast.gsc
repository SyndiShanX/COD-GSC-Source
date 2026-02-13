/*******************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_downcast\mp_downcast.gsc
*******************************************************/

main() {
  scripts\mp\maps\mp_downcast\mp_downcast_precache::main();
  scripts\mp\maps\mp_downcast\gen\mp_downcast_art::main();
  scripts\mp\maps\mp_downcast\mp_downcast_fx::main();
  scripts\mp\maps\mp_downcast\mp_downcast_lighting::main();
  _id_07EC::main();
  _id_07C0::_id_D88B("compass_map_mp_downcast");
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_prebakedTnDHighLODBeginMax", 500);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  game["allies"] = "USMC";
  game["axis"] = "ALQ";
  level._id_F7AA = 1;
  level._id_AD0F = getEntArray("OutOfBounds", "targetname");
}