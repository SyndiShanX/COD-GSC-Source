/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_29dd4ba61d6bcf7.gsc
***********************************************/

main() {
  _id_2522297DB341B71F::main();
  _id_2613F1C13EBE88DA::main();
  _id_2B632FC981F7ABCC::main();
  _id_73AE6AEE4CC3501A::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::_id_5B9E95ACD14775A5();
  _id_91190DDB02ED2F9B = spawn("trigger_radius", (-8776, 8800, 768), 0, 10000, 10000);
  _id_91190DDB02ED2F9B.targetname = "OutOfBounds";
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_hydro");
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("cg_defaultWindFrequencyScale", 1);
  setDvar("cg_defaultWindAmplitudeScale", 4);
  setDvar("cg_defaultWindAreaScale", 50);
  setDvar("cg_defaultWindNoiseScale", 0.7);
  setDvar("cg_defaultWindStrength", 2);
  setDvar("cg_defaultWindDir", (1, 0, 0));
  setDvar("r_vertexDeformCutOffDist", 10000);
  setDvar("r_vertexDeformFadeDist", 1500);
  setDvar("r_st_displacementDistance", 1000);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level _id_3C37E8E4377AA2B3();
  thread _id_B2F8F087CEB71FEA();
  level.music_style = "middle_east";
}

_id_3C37E8E4377AA2B3() {
  scripts\mp\equipment\tactical_cover::_id_F41F835B1AB9DBD8((-10248, 8500, 345), 100, 96, -6, 0);
  scripts\mp\equipment\tactical_cover::_id_F41F835B1AB9DBD8((-10044, 8704, 345), 100, 96, -6, 0);
  scripts\mp\equipment\tactical_cover::_id_F41F835B1AB9DBD8((-9333, 8351, 305), 100, 96, -6, 0);
  scripts\mp\equipment\tactical_cover::_id_F41F835B1AB9DBD8((-7740, 8876, 305), 100, 96, -6, 0);
}

_id_B2F8F087CEB71FEA() {
  _id_45428B56EF07EA91 = spawn("script_model", (-9555.5, 7725, 365));
  _id_45428B56EF07EA91 setModel("hardware_plywood_painted_white_01_48");
  _id_45428B56EF07EA91.angles = (0.021182, 314.597, 2.24779);
  _id_AF5DF9A502E8811A = spawn("script_model", (-9556, 7731, 328));
  _id_AF5DF9A502E8811A setModel("mx_barrier_gas_station_bollard");
  _id_AF5DF9A502E8811A.angles = (0, 45.9999, 0);
  _id_70F1AB88B4C446AF = spawn("script_model", (-9587.35, 7701.15, 328));
  _id_70F1AB88B4C446AF setModel("hardware_plywood_painted_white_01_48");
  _id_70F1AB88B4C446AF.angles = (0.000000660278, 135, 3.00406);
  _id_9964A913AA94CF90 = spawn("script_model", (-9598.5, 7720.5, 481.5));
  _id_9964A913AA94CF90 setModel("building_corrugated_metal2x8_simple");
  _id_9964A913AA94CF90.angles = (0.000000660291, 45, 3.00412);
  _id_9964A913AA94CF90 = spawn("script_model", (-9581.35, 7737.35, 481.5));
  _id_9964A913AA94CF90 setModel("building_corrugated_metal2x8_simple");
  _id_9964A913AA94CF90.angles = (0.00000259256, 222.923, -2.44062);
}