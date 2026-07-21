/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\estate\estate_precache.gsc
***********************************************/

main() {
  scripts\smartobjects\stealth_look_around::main();
  scripts\smartobjects\stealth_look_down::main();
  scripts\smartobjects\stealth_look_high::main();
  scripts\smartobjects\stealth_look_over::main();
  scripts\smartobjects\stealth_look_under_10::main();
  scripts\smartobjects\stealth_look_under_30::main();
  scripts\smartobjects\stealth_look_up::main();
  scripts\vehicle\decho::main("veh8_civ_lnd_decho_rebel_dirty_darkblue", "technical_civ", "script_vehicle_iw8_decho_rebel_darkbluedirty");
  scripts\vehicle\decho::main("veh8_civ_lnd_decho_rebel_dirty_darkblue_physics_estate", "decho_physics_sp", "script_vehicle_iw8_decho_rebel_darkbluedirty_physics_estate");
  scripts\vehicle\mindia8::main("veh8_mil_air_mindia8", "mindia8", "script_vehicle_iw8_mindia8_closed");
}