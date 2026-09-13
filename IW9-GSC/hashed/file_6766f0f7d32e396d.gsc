/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6766f0f7d32e396d.gsc
***********************************************/

main() {
  _id_28B5F185A9F45899::main();
  _id_497512E9383077FC::main();
  _id_4071F60CFF3C93B6::main();
  _id_4BEB45978E7F481C::main();
  scripts\mp\load::main();
  _id_1311C5C284DD1537::_id_57D6A393B90824DC(3580);
  scripts\cp_mp\utility\game_utility::_id_9CFE515677727128();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_swap_meet");
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level _id_3C37E8E4377AA2B3();
  level.music_style = "mexico";
  level thread _id_EEF2AC625010459C();
}

_id_1682CF22619A5E55() {
  level waittill("infil_setup_complete");
  _id_6120DF12544987E8 = getEnt("static_infil_van", "targetname");

  if(scripts\mp\flags::gameflag("infil_will_run") && isDefined(_id_6120DF12544987E8))
    _id_6120DF12544987E8 hide();
}

_id_3C37E8E4377AA2B3() {
  scripts\mp\equipment\tactical_cover::_id_F41F835B1AB9DBD8((28667, -30820.5, 3148), scripts\mp\equipment\tactical_cover::_id_85555E609B23B2BE(0), undefined, -6, 0);
  scripts\mp\equipment\tactical_cover::_id_F41F835B1AB9DBD8((29059, -30733.5, 3172), scripts\mp\equipment\tactical_cover::_id_85555E609B23B2BE(0), undefined, -6, 0);
}

_id_EEF2AC625010459C() {
  level waittill("scriptables_ready");
  locations = [(28254, -26908, 3221), (28079, -27004, 3221), (28517, -26773, 3221), (28837, -26540, 3221), (29827, -30964, 3180), (29704, -31334, 3180), (31500, -31632, 3200), (28297, -32380, 3200), (28561, -32880, 3200), (28458, -32676, 3333), (26719, -32967, 3200), (26858, -33103, 3200), (27489, -33903, 3300), (28024, -32957, 3200), (24902, -29787, 3200), (24688, -29914, 3200), (25194, -32217, 3300), (25055, -32000, 3300), (24952, -31772, 3300), (24717, -28102, 3200), (24719, -27904, 3200)];
  radius = 256;

  foreach(loc in locations) {
    doors = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(loc, radius, 256);

    foreach(door in doors) {
      if(door scriptableisdoor())
        door scriptabledoorfreeze();
    }
  }
}