/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\807.gsc
**************************************/

main() {
  _id_55BA::main("vehicle_jeep_rubicon", undefined, "script_vehicle_jeep_rubicon_payback");
  vehicle_scripts\_hind::main("payback_vehicle_hind", undefined, "script_vehicle_payback_hind");
  _id_54D8::main("vehicle_pickup_technical_pb_rusted", "vehicle_pickup_technical_pb_destroyed", undefined, "script_vehicle_pickup_technical_payback");
  _id_54D8::main("vehicle_pickup_technical_pb_rusted", "vehicle_pickup_technical_pb_destroyed", undefined, "script_vehicle_pickup_technical_payback_instant_death");
  _id_55BB::main("vehicle_uaz_fabric", undefined, "script_vehicle_uaz_fabric");
  common_scripts\_destructible_types_anim_chicken::main();
  common_scripts\_destructible_types_anim_light_fluo_on::main();
  common_scripts\_destructible_types_anim_me_fanceil1_spin::main();
}