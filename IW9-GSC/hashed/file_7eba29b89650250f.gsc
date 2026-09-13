/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7eba29b89650250f.gsc
***********************************************/

main() {
  _id_72E23080A62E4487::main();
  _id_42F4027537FAB342::main();
  _id_214D58C008016194::main();
  _id_47B0FD77895A43E2::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  _id_1311C5C284DD1537::_id_57D6A393B90824DC(350);
  scripts\mp\compass::setupminimap("compass_map_mp_farm_18");
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level _id_3C37E8E4377AA2B3();
  thread play_movie("mp_farm18_screens");
  thread scripts\mp\animation_suite::animationsuite();
  _id_A1BD461C63D9C43B();
  level.modifiedspawnpoints["-1272 -1872"]["mp_dm_spawn_start"]["origin"] = (-1280, -1664, 24);
}

_id_1682CF22619A5E55() {}

_id_A1BD461C63D9C43B() {
  if(getdvarint("dvar_CEFB6AED35221A1D", 1)) {
    _id_3FAFC39AC7463E68 = spawn("trigger_radius", (517, -156, 1055), 0, 4000, 1000);
    level.outofboundstriggers[level.outofboundstriggers.size] = _id_3FAFC39AC7463E68;
  }
}

play_movie(bink) {
  if(getdvarint("r_reflectionprobegenerate") == 1) {
    return;
  }
  for(;;) {
    _func_CE942237D1ECA7D8(bink);
    wait 3;
  }
}

_id_3C37E8E4377AA2B3() {
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((1016, 93, 8), 0);
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((-824, -820, 66), 0);
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((64, -468, 8), 0);
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((64, -220, 8), 0);
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((-842, 162, -128), 0);
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((-780.005, -735.283, 8), 1);
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((-959.417, -824.306, -80.4122), 1);
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((1202, 306, 16), 0);
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((1422, 426, 16), 0);
}