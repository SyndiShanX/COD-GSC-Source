/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4aa189ea258a7eb5.gsc
***********************************************/

main() {
  _id_3CDE4217F9FF88C4::main();
  _id_07719CD57D3F570E::main();
  _id_0B3B7F369D748B54::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::registersmallmap();
  scripts\cp_mp\utility\game_utility::registerarenamap();
  thread _id_B2F8F087CEB71FEA();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_m_canal");
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
}

_id_B2F8F087CEB71FEA() {
  _id_1E15CC204F179CEC = getEnt("mantle32", "targetname");
  _id_45428B56EF07EA91 = spawn("script_model", (136, 1383, -138));
  _id_45428B56EF07EA91.angles = (0, 71, 0);
  _id_45428B56EF07EA91 clonebrushmodeltoscriptmodel(_id_1E15CC204F179CEC, 1);
  _id_1E15CF204F17A385 = getEnt("mantle32", "targetname");
  _id_AF5DF9A502E8811A = spawn("script_model", (153, 1408, -138));
  _id_AF5DF9A502E8811A.angles = (0, 43.7, 0);
  _id_AF5DF9A502E8811A clonebrushmodeltoscriptmodel(_id_1E15CF204F17A385, 1);
  _id_1E15CE204F17A152 = getEnt("mantle32", "targetname");
  _id_70F1AB88B4C446AF = spawn("script_model", (171, 1408, -138));
  _id_70F1AB88B4C446AF.angles = (0, 313.4, 0);
  _id_70F1AB88B4C446AF clonebrushmodeltoscriptmodel(_id_1E15CE204F17A152, 1);
  _id_1E15C9204F179653 = getEnt("mantle32", "targetname");
  _id_9964A913AA94CF90 = spawn("script_model", (187, 1382, -138));
  _id_9964A913AA94CF90.angles = (0, 108.8, 0);
  _id_9964A913AA94CF90 clonebrushmodeltoscriptmodel(_id_1E15C9204F179653, 1);
  _id_CBC7EAFF04EB54D5 = spawn("script_model", (281.5, -237.5, 4.5));
  _id_CBC7EAFF04EB54D5 setModel("trim_riverbank_concrete_01_corner");
  _id_CBC7EAFF04EB54D5.angles = (78.015, 181.633, -88.974);
  _id_51D3A9451C22C04E = spawn("script_model", (-151.5, -18.5, 4.5));
  _id_51D3A9451C22C04E setModel("trim_riverbank_concrete_01_corner");
  _id_51D3A9451C22C04E.angles = (78.015, 1.633, -88.974);
  _id_10688B3021ACC893 = spawn("script_model", (-159.5, 1262.5, -1.5));
  _id_10688B3021ACC893 setModel("trim_riverbank_concrete_01_corner");
  _id_10688B3021ACC893.angles = (90, 0, -90);
  _id_5514BA2EB35CC4D4 = spawn("script_model", (311.5, 1261.5, -32.5));
  _id_5514BA2EB35CC4D4 setModel("trim_riverbank_concrete_01_corner");
  _id_5514BA2EB35CC4D4.angles = (352, 180, 89.9);
  _id_86EAEC1A0D17D509 = spawn("script_model", (309.5, 1034.5, -35.5));
  _id_86EAEC1A0D17D509 setModel("trim_riverbank_concrete_01_corner");
  _id_86EAEC1A0D17D509.angles = (349.8, 180, 89.9);
}