/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6561960ab1b832bd.gsc
***********************************************/

main() {
  _id_440734B387AB4AE9::main();
  _id_54DF2DB322ED6312::main();
  _id_7190B0A52F7801A6::main();
  _id_32718DF4DA4920CC::main();
  scripts\mp\load::main();
  _id_074922A76F9FD2DE = spawn("trigger_radius", (10940, -36984, 3704), 0, 128, 128);
  _id_074922A76F9FD2DE.angles = (0, 0, 0);
  _id_074922A76F9FD2DE.targetname = "OutOfBounds";
  _id_074921A76F9FD0AB = spawn("trigger_radius", (11016, -36878, 3704), 0, 128, 128);
  _id_074921A76F9FD0AB.angles = (0, 0, 0);
  _id_074921A76F9FD0AB.targetname = "OutOfBounds";
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_catedral");
  setDvar("r_umbraMinObjectContribution", 8);
  level _id_3C37E8E4377AA2B3();
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "mexico";
  level thread _id_BB224D8DCEBFE7C9();
  _id_A1BD461C63D9C43B();
  fixcollision();
}

_id_A1BD461C63D9C43B() {
  if(getdvarint("dvar_8376FAD7E91997D5", 1)) {
    _id_3FAFC39AC7463E68 = spawn("trigger_radius", (12706, -37463, 5000), 0, 4000, 1000);
    level.outofboundstriggers[level.outofboundstriggers.size] = _id_3FAFC39AC7463E68;
  }
}

fixcollision() {
  _id_B9719C616B5AF5EA = spawn("script_model", (12278, -35719.5, 3563));
  _id_B9719C616B5AF5EA setModel("hardware_plywood_bare_01");
  _id_B9719C616B5AF5EA.angles = (0, 330.679, 0);
}

_id_BB224D8DCEBFE7C9() {
  level endon("game_ended");
  level waittill("connected", player);
  _id_2B4B28F7AE75B76A = spawn("script_origin", (0, 0, 0));
  _id_2B4B28F7AE75B76A playLoopSound("pa_cat_mus_bar_radio_lp");
  _func_5A8DBA516863782A("catedral_pa");
}

_id_3C37E8E4377AA2B3() {
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((12840, -34644, 3464.27), 0);
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((14078, -35976, 3572.56), 0);
  scripts\mp\equipment\tactical_cover::_id_F41F835B1AB9DBD8((12364, -38072, 3580.99), 80, undefined, -6, 1);
}