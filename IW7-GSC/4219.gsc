/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 4219.gsc
**************************************/

main() {
  _id_0B1E::_id_59CB();
  _id_0BA8::main("veh_mil_air_ca_carrier_rig", undefined, "script_vehicle_capitalship_carrier_ca");
  _id_0BA8::main("veh_mil_air_ca_carrier_sa_rig", undefined, "script_vehicle_capitalship_carrier_ca_sa_rig");
  _id_0BAE::main("veh_mil_air_un_destroyer_rig", undefined, "script_vehicle_capitalship_destroyer_un");
  _id_0BBD::main("veh_mil_air_ca_dropship", "dropship", "script_vehicle_dropship_enemy_space");
  _id_0BC2::main("tag_origin", "empty_nocollision", "script_vehicle_empty_nocollision");
  _id_0BDA::main("veh_mil_air_ca_jackal_01", "jackal_un", "script_vehicle_jackal_enemy");
  _id_0BDA::main("veh_mil_air_ca_jackal_01_ace", "jackal_un", "script_vehicle_jackal_enemy_ace", undefined, 1);
  _id_0BDA::main("veh_mil_air_un_jackal_02", "jackal_un", "script_vehicle_jackal_friendly", "jackal_un_space");
  _id_0BDA::main("veh_mil_air_un_jackal_02", "jackal_un", "script_vehicle_jackal_friendly_moon", "jackal_un_space");
  _id_0BF0::main("veh_mil_air_un_pocketdrone", undefined, "script_vehicle_support_drone");
}