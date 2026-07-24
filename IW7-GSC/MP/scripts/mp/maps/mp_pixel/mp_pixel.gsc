/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_pixel\mp_pixel.gsc
*************************************************/

main() {
  scripts\mp\maps\mp_pixel\mp_pixel_precache::main();
  scripts\mp\maps\mp_pixel\gen\mp_pixel_art::main();
  scripts\mp\maps\mp_pixel\mp_pixel_fx::main();
  scripts\mp\load::main();
  level._id_C7B3 = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_pixel");
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);
  setDvar("r_umbraMinObjectContribution", 3);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
}