/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 4249.gsc
**************************************/

main() {
  scripts\vehicle\apache::main("veh_mil_lnd_un_apc_drive", "apc", "script_vehicle_apc_turret");
  _id_0BA6::main("veh_mil_lnd_ca_4x4_atv_drive", "atv", "script_vehicle_atv");
  _id_0BA6::main("veh_mil_lnd_ca_4x4_atv_drive", "atv", "script_vehicle_atv_turret");
  _id_0BAF::main("veh_ind_air_un_small_cargo_ship_01", "capital_ship", "script_vehicle_capitalship_freighter_small");
  _id_0BB4::main("veh_mil_air_ca_olympus_mons", undefined, "script_vehicle_capitalship_mons_periph");
  _id_0BB5::main("veh_mil_air_un_retribution_rig", undefined, "script_vehicle_capitalship_retribution_periph");
  _id_0BBC::main("veh_mil_air_un_dropship_hero", "dropship", "script_vehicle_dropship_friendly");
  _id_0BBD::main("veh_mil_air_ca_dropship", "dropship", "script_vehicle_dropship_enemy");
  _id_0BBD::main("veh_mil_air_ca_dropship", "dropship_plane", "script_vehicle_dropship_enemy_plane");
  _id_0BBF::_id_B1C7("veh_mil_air_un_dropship_hero_player", "dropship", "script_vehicle_dropship_player");
  _id_0BC2::main("tag_origin", "empty_nocollision", "script_vehicle_empty_nocollision");
  _id_0BDA::main("veh_mil_air_ca_jackal_01", "jackal_un", "script_vehicle_jackal_enemy");
  _id_0BDA::main("veh_mil_air_ca_jackal_01", "jackal_un", "script_vehicle_jackal_fake_enemy");
  _id_0BDA::main("veh_mil_air_un_jackal_02", "jackal_un", "script_vehicle_jackal_friendly", "jackal_un_space");
  _id_0BF0::main("veh_mil_air_un_pocketdrone", undefined, "script_vehicle_support_drone");
}