/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_e8c3aba7f313913.gsc
***********************************************/

main() {
  _id_0DD91B2C913B5E5B::main();
  _id_199CFEDC988E52F2::main();
  _id_3BD1307C7A0AD4E0::main();
  _id_164E928B2FD0063E::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::_id_5B9E95ACD14775A5();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_embassy");
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_st_displacementDistance", 1000);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level.music_style = "middle_east";
  level _id_3C37E8E4377AA2B3();
  thread _id_6B543B63FB205E4E();
  level._id_6E31FB115404C96D = ::_id_9762CCE80DEE4DE3;
}

_id_3C37E8E4377AA2B3() {
  scripts\mp\equipment\tactical_cover::_id_F41F835B1AB9DBD8((15040, 29445, 259), 40, 96, -6, 0);
  scripts\mp\equipment\tactical_cover::_id_F41F835B1AB9DBD8((15040, 29505, 257), 40, 96, -6, 0);
}

_id_6B543B63FB205E4E() {
  wait 3.0;
  _id_923DA517C504BBDE = spawn("script_model", (16156, 29808, 590));
  _id_923DA517C504BBDE.angles = (0, 180, -90);
  _id_923DA517C504BBDE setModel("aluminum_panel_wall_128x64");
  _id_923DA417C504B9AB = spawn("script_model", (16156, 29694, 590));
  _id_923DA417C504B9AB.angles = (0, 180, -90);
  _id_923DA417C504B9AB setModel("aluminum_panel_wall_128x64");
  _id_923DA417C504B9AB = spawn("script_model", (16156, 29672, 590));
  _id_923DA417C504B9AB.angles = (0, 180, -90);
  _id_923DA417C504B9AB setModel("aluminum_panel_wall_128x64");
  _id_923DAA17C504C6DD = spawn("script_model", (16156, 29740, 422));
  _id_923DAA17C504C6DD.angles = (0, 180, -90);
  _id_923DAA17C504C6DD setModel("aluminum_panel_wall_128x128");
}

_id_9762CCE80DEE4DE3() {
  _id_183BA55FED386936::_id_6E31FB115404C96D("a", (16856, 28664, 263));
}