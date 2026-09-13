/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_88db15b99161605.gsc
***********************************************/

main() {
  _id_1C5F6911943697C1::main();
  _id_715068D8D849D9AE::main();
  _id_6B27C87CEBA6977E::main();
  scripts\mp\load::main();
  scripts\cp_mp\utility\game_utility::_id_AC85A5AB21DB294E();

  if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::isgroundwarcoremode()) {
    if(!isDefined(level.localeid))
      setDvar("scr_localeID", 1);

    _id_3BA4F32E41F63B36::arm_initoutofbounds();
  } else {
    level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
    level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  }

  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_townhouses");
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  level thread _id_EEF2AC625010459C();
}

_id_EEF2AC625010459C() {
  level waittill("scriptables_ready");
  locations = [(5463, -5643, 315), (5654, -6199, 340), (6505, -5539, 278), (6639, -6026, 278), (5874, -9373, 181), (5984, -8949, 142), (6289, -9064, 117), (5132, -5929, 182), (4521, -6094, 182), (5359, -9164, 179), (5807, -9393, 147), (6796, -8918, 102)];
  radius = 100;

  foreach(loc in locations) {
    doors = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(loc, radius, 100);

    foreach(door in doors) {
      if(door scriptableisdoor())
        door scriptabledoorfreeze();
    }
  }
}