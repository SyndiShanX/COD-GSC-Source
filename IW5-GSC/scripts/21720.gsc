/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\21720.gsc
**************************************/

main(var_0, var_1, var_2, var_3) {
  _id_54AA::_id_54A7(var_0, var_2, var_3, "weapon_m2_50cal_center", "50cal_turret_technical");
  _id_54AA::_id_54A8();

  if(issubstr(var_3, "instant_death")) {
    _id_54AE(var_0, var_1, var_3);
    maps\_vehicle::_id_2ACE(2750, 2500, 3000);
  } else {
    _id_54A9(var_0, var_1, var_3);
  }
}

_id_54A9(var_0, var_1, var_2) {
  maps\_vehicle::_id_2ABE(var_0, var_1, 3, var_2);
  maps\_vehicle::_id_2A02("fire/firelp_med_pm_nolight", "tag_fx_tank", "smallfire", undefined, undefined, 1, 0);
  maps\_vehicle::_id_2A02("explosions/ammo_cookoff", "tag_fx_bed", undefined, undefined, undefined, undefined, 0.5);
  maps\_vehicle::_id_2A02("explosions/Vehicle_Explosion_Pickuptruck", "tag_deathfx", "car_explode", undefined, undefined, undefined, 2.9);
  maps\_vehicle::_id_2A02("fire/firelp_small_pm_a", "tag_fx_tire_right_r", "smallfire", undefined, undefined, 1, 3);
  maps\_vehicle::_id_2A02("fire/firelp_med_pm_nolight_hood", "tag_fx_cab", "fire_metal_medium", undefined, undefined, 1, 3.01);
  maps\_vehicle::_id_2A02("fire/firelp_small_pm_a", "tag_engine_left", "smallfire", undefined, undefined, 1, 3.01);
  maps\_vehicle::_id_2AEA(0.5, 3, 512, 700, "axis", "allies");
  maps\_vehicle::_id_2AEB(2.9);
  maps\_vehicle::_id_29F3((0, 0, 53), 512, 175, 20, 1, 2.9);
}

_id_54AE(var_0, var_1, var_2) {
  maps\_vehicle::_id_2ABE(var_0, var_1, 0.1, var_2);
  maps\_vehicle::_id_2A02("fire/firelp_med_pm_nolight", "tag_fx_tank", "smallfire", undefined, undefined, 1, 0);
  maps\_vehicle::_id_2A02("explosions/ammo_cookoff", "tag_fx_bed", undefined, undefined, undefined, undefined, 0.1);
  maps\_vehicle::_id_2A02("explosions/Vehicle_Explosion_technical", "tag_deathfx", "car_explode", undefined, undefined, undefined, 0.1);
  maps\_vehicle::_id_2A02("fire/firelp_small_pm_a", "tag_fx_tire_right_r", "smallfire", undefined, undefined, 1, 0.1);
  maps\_vehicle::_id_2A02("fire/firelp_med_pm_nolight", "tag_fx_cab", "fire_metal_medium", undefined, undefined, 1, 0.11);
  maps\_vehicle::_id_2A02("fire/firelp_small_pm_a", "tag_engine_left", "smallfire", undefined, undefined, 1, 0.11);
  maps\_vehicle::_id_2AEB(0.05);
  maps\_vehicle::_id_29F3((0, 0, 53), 512, 175, 20, 1, 0.05);
}