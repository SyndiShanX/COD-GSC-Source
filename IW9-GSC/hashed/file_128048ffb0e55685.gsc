/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_128048ffb0e55685.gsc
***********************************************/

main() {
  _id_39476B974D936141::main();
  _id_02E378A72BB22C5E::main();
  _id_50961BBDA895ACFE::main();
  _id_4AB79785DDBA1484::main();
  scripts\mp\load::main();
  _id_1311C5C284DD1537::_id_57D6A393B90824DC(600);
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_luxury");
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level _id_3C37E8E4377AA2B3();
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  _id_8672453924241040();
}

_id_1682CF22619A5E55() {
  level waittill("infil_setup_complete");
  _id_6120DF12544987E8 = getEnt("static_infil_van", "targetname");

  if(scripts\mp\flags::gameflag("infil_will_run") && isDefined(_id_6120DF12544987E8))
    _id_6120DF12544987E8 hide();
}

_id_8672453924241040() {
  _id_2B4B28F7AE75B76A = spawn("script_origin", (0, 0, 0));
  _id_2B4B28F7AE75B76A playLoopSound("pa_luxury_lobby_mus_lp");
  _func_5A8DBA516863782A("pa_luxury");
}

_id_3C37E8E4377AA2B3() {
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((-572, 602, 0), 0);
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((1676, 1156, 80), 0);
  scripts\mp\equipment\tactical_cover::_id_C5D3D6E10BD8C8AB((1422, 1208, 80), 0);
}