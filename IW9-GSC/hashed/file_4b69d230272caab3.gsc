/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4b69d230272caab3.gsc
***********************************************/

main() {
  _id_3AEB1602BEF2523B::main();
  _id_4A624801FB3628F2::main();
  _id_36998BB481626140::main();
  _id_54A1EFDAB4E7909E::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::_id_5B9E95ACD14775A5();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_observatory");
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level thread _id_1682CF22619A5E55();
  level thread _id_B82D39658AFA02E9();
  level thread _id_57BE8EFC25591B9C();
}

_id_1682CF22619A5E55() {
  level endon("game_ended");
  level waittill("infil_setup_complete");
  _id_6120DF12544987E8 = getEnt("static_infil_van", "targetname");

  if(scripts\mp\flags::gameflag("infil_will_run") && isDefined(_id_6120DF12544987E8))
    _id_6120DF12544987E8 hide();
}

_id_B82D39658AFA02E9() {
  level endon("game_ended");
  wait 3;
  locations = [(1383, -11996, 4804), (-586, -9693, 4696), (-2290, -13569, 4928), (-2587, -11449, 4712)];
  radius = 64;
  _id_0067C1CB9129565E = [];

  foreach(loc in locations) {
    doors = getentitylessscriptablearray("scriptable_scriptable_door_metal_04_flat_painted_clean_mp", "classname", loc, radius);

    if(istrue(doors.size))
      _id_0067C1CB9129565E = scripts\engine\utility::array_combine(_id_0067C1CB9129565E, doors);
  }

  foreach(door in _id_0067C1CB9129565E) {
    if(door scriptableisdoor())
      door scriptabledoorfreeze(1);
  }
}

_id_57BE8EFC25591B9C() {
  trigger_radius = spawn("trigger_radius", (-1872.04, -11414.5, 4908), 0, 128, 256);
  level.outofboundstriggers = scripts\engine\utility::array_add(level.outofboundstriggers, trigger_radius);
}