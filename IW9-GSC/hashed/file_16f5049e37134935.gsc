/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_16f5049e37134935.gsc
***********************************************/

main() {
  _id_131AB51C35CD3CEA::main();
  _id_4780B21BA6099A8E::main();
  _id_7ABA55492E3292D4::main();
  scripts\mp\load::main();
  _id_1311C5C284DD1537::_id_57D6A393B90824DC(895);
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_museum");
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread scripts\mp\animation_suite::animationsuite();
  thread _id_7FFC6137BE566238();

  if(getdvarint("dvar_8610CCD25560C117") == 0)
    thread play_movie("mp_museum_screens");

  thread _id_B2F8F087CEB71FEA();
}

play_movie(bink) {
  if(getdvarint("r_reflectionprobegenerate") == 1) {
    return;
  }
  for(;;) {
    _func_CE942237D1ECA7D8(bink);
    wait 40;
  }
}

_id_1682CF22619A5E55() {
  level waittill("infil_setup_complete");
  _id_6120DF12544987E8 = getEnt("static_infil_van", "targetname");

  if(scripts\mp\flags::gameflag("infil_will_run") && isDefined(_id_6120DF12544987E8))
    _id_6120DF12544987E8 hide();
}

_id_7FFC6137BE566238() {
  level endon("game_ended");
  level waittill("connected", player);
  _id_2B4B28F7AE75B76A = spawn("script_origin", (-454, -1591, 895));
  wait(randomfloatrange(20, 70));

  for(;;) {
    _id_2B4B28F7AE75B76A playSound("dx_mp_musm_misc_trma_welcome_sp");
    wait 15;
    _id_2B4B28F7AE75B76A playSound("dx_mp_musm_misc_trma_welcome_eng");
    wait 165;
  }
}

_id_B2F8F087CEB71FEA() {
  wait 3.0;
  _id_45428B56EF07EA91 = spawn("script_model", (-2488, 248, 578));
  _id_45428B56EF07EA91 setModel("travertine_panel_wall_64x32");
  _id_45428B56EF07EA91.angles = (0, 180, 0);
  _id_AF5DF9A502E8811A = spawn("script_model", (-2488, 248, 546));
  _id_AF5DF9A502E8811A setModel("travertine_panel_wall_64x32");
  _id_AF5DF9A502E8811A.angles = (0, 180, 0);
}