/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1ffb2f471c28fad.gsc
***********************************************/

main() {
  _id_1340A85ED25B5FD9::main();
  _id_5B2B86275FAD8056::main();
  _id_32BB6466BA45B7F6::main();
  scripts\mp\load::main();
  _id_1311C5C284DD1537::_id_57D6A393B90824DC(3580);
  scripts\cp_mp\utility\game_utility::_id_AC85A5AB21DB294E();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_floatinghouses");
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_st_displacementDistance", 1000);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level thread _id_EEF2AC625010459C();
  level thread _id_713F089988EE955E();
}

_id_EEF2AC625010459C() {
  level waittill("scriptables_ready");
  locations = [(-13433, -11207, 83), (-12492, -11393, 30), (-12597, -10379, 133), (-13584, -10490, 108), (-13577, -11494, 221), (-14501, -10340, 87), (-14452, -10206, 229), (-15957, -10355, 91), (-15957, -11082, 106), (-15415, -11282, 75), (-12438, -11064, 81), (-15496, -11126, 201), (-16111, -9004, 87), (-16381, -9004, 87), (-16002, -11017, 242), (-16013, -10369, 227)];
  radius = 100;

  foreach(loc in locations) {
    doors = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(loc, radius, 100);

    foreach(door in doors) {
      if(door scriptableisdoor())
        door scriptabledoorfreeze();
    }
  }
}

_id_713F089988EE955E() {
  level endon("game_ended");

  if(getdvarint("dvar_742F605ED5F90DF9", 0)) {
    return;
  }
  _id_994221FD735CA3BB = getEnt("delta_windmill_01_axle", "targetname");
  parts = getEntArray("delta_windmill_01_part", "targetname");
  _id_994221FD735CA3BB forcenetfieldhighlod(1);

  foreach(part in parts) {
    part linkTo(_id_994221FD735CA3BB);
    part forcenetfieldhighlod(1);
  }

  for(;;) {
    _id_994221FD735CA3BB rotateroll(360, 60);
    wait 60;
  }
}