/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4e498726c139c17d.gsc
***********************************************/

main() {
  _id_013ED6770A8671A9::main();
  _id_2F40360D926B119A::main();
  _id_3142215E2BC27466::main();
  _id_13756E31CBAEBF8C::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_fort");
  scripts\cp_mp\utility\game_utility::_id_5B9E95ACD14775A5();
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_st_displacementDistance", 1000);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "middle_east";
  thread _id_B2F8F087CEB71FEA();
}

_id_B2F8F087CEB71FEA() {
  _id_45428B56EF07EA91 = spawn("script_model", (15652, -54024, 1016));
  _id_45428B56EF07EA91 setModel("barrier_wooden_fence_01_mp");
  _id_45428B56EF07EA91.angles = (0, 270, 0);
}