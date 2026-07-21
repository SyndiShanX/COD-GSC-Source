/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\highway\highway_precache.gsc
************************************************/

main() {
  scripts\vehicle\pindia::main("veh8_mil_lnd_pindia", undefined, "script_vehicle_iw8_truck_pindia_white");
  scripts\vehicle\pindia::main("veh8_mil_lnd_pindia_cream", undefined, "script_vehicle_iw8_truck_pindia_cream");
  scripts\vehicle\pindia::main("veh8_mil_lnd_pindia_red", undefined, "script_vehicle_iw8_truck_pindia_red");
  scripts\vehicle\suniform25::main("veh8_mil_air_suniform25", undefined, "script_vehicle_iw8_jet_suniform25");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_dirty", undefined, "script_vehicle_iw8_truck_techo_whitedirty");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_dirty_black", undefined, "script_vehicle_iw8_truck_techo_blackdirty");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_dirty_black_physics", "techo_physics_sp", "script_vehicle_iw8_truck_techo_blackdirty_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_dirty_physics", "techo_physics_sp", "script_vehicle_iw8_truck_techo_whitedirty_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_dirty_red", undefined, "script_vehicle_iw8_truck_techo_reddirty");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_dirty_red_physics", "techo_physics_sp", "script_vehicle_iw8_truck_techo_reddirty_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_dirty_tan", undefined, "script_vehicle_iw8_truck_techo_tandirty");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_dirty_tan_physics", "techo_physics_sp", "script_vehicle_iw8_truck_techo_tandirty_physics");
  scripts\vehicle\techo::main("veh8_civ_lnd_techo_rebel", undefined, "script_vehicle_iw8_truck_techo_rebel");
  scripts\vehicle\vindia::main("veh8_mil_lnd_vindia_a2", "vindia", "script_vehicle_iw8_vindia_a2");
  scripts\vehicle\zuniform::main("veh8_civ_lnd_zuniform", undefined, "script_vehicle_iw8_truck_zuniform_white");
}