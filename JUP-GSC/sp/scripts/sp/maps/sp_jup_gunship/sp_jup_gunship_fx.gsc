/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\sp_jup_gunship\sp_jup_gunship_fx.gsc
****************************************************************/



#using scripts\anim\utility;
#using scripts\engine\sp\utility;
#namespace sp_jup_gunship_fx;

function main() {
  level._effect["vfx/iw9/level/gunship/vfx_gs_water_tank_broken_fall.vfx"] = loadfx("vfx/iw9/level/gunship/vfx_gs_water_tank_broken_fall.vfx");
  level._effect["vfx_gs_wt_tank_broken_water_flow"] = loadfx("vfx/iw9/level/gunship/vfx_gs_wt_tank_broken_water_flow.vfx");
  level._effect["vfx_gunship_footstep_dust"] = loadfx("vfx/iw9/level/gunship/vfx_gunship_footstep_dust.vfx");
  level._effect["vfx_gunship_treadfx_truck"] = loadfx("vfx/jup/level/sp_jup_gunship/vfx_gns_treadfx_vehicle_01.vfx");
  level._effect["vfx_gunship_treadfx_truck_half"] = loadfx("vfx/jup/level/sp_jup_gunship/vfx_gns_treadfx_vehicle_half_01.vfx");
  level._effect["vfx_gns_treadfx_heli_wash_01"] = loadfx("vfx/jup/level/sp_jup_gunship/vfx_gns_treadfx_heli_wash_01.vfx");
  level._effect["vfx_thermal_beacon_ai"] = loadfx("vfx/iw9/level/gunship/vfx_thermal_beacon_ai.vfx");
  level._effect["vfx_gunship_gib_kill_lrg"] = loadfx("vfx/iw9/level/gunship/vfx_gunship_gib_kill_lrg.vfx");
  level._effect["vfx_shdb_building_explo"] = loadfx("vfx/iw9/level/shadowbase/vfx_shdb_building_explo.vfx");
  level._effect["vfx_player_missile"] = loadfx("vfx/jup/level/sp_jup_gunship/vfx_gns_exp_missile_explosion_01.vfx");
  level._effect["vfx_player_missile_air"] = loadfx("vfx/jup/level/sp_jup_gunship/vfx_gns_exp_missile_explosion_01_air.vfx");
  level._effect["vfx_sam_exp"] = loadfx("vfx/jup/prop/scriptables/vfx_gns_jup_urz_military_chemical_missile_stacked_01_air.vfx");
  level._effect["vfx_heli_missile"] = loadfx("vfx/jup/level/sp_jup_gunship/vfx_gns_exp_missile_explosion_01.vfx");
  level._effect["vfx_jet_thruster"] = loadfx("vfx/jup/level/sp_jup_gunship/vfx_gns_jet_thrusters_origin.vfx");
  level._effect["jup_urz_military_airstrip_suniform25_jet_01_air"] = loadfx("vfx/jup/prop/scriptables/jup_urz_military_airstrip_suniform25_jet_01_air.vfx");
  level._effect["jup_urz_military_airstrip_suniform25_jet_01_air_moving_death"] = loadfx("vfx/jup/prop/scriptables/jup_urz_military_airstrip_suniform25_jet_01_air_moving_death.vfx");
  level._effect["vfx_mortar_trail_01"] = loadfx("vfx/jup/level/sp_jup_gunship/vfx_mortar_trail_01.vfx");
  level._effect["vfx_mortar_exp_01"] = loadfx("vfx/jup/level/sp_jup_gunship/vfx_mortar_exp_01.vfx");
  level._effect["jup_urz_military_airstrip_heli_medium_01_air"] = loadfx("vfx/jup/prop/scriptables/jup_urz_military_airstrip_heli_medium_01_air.vfx");
  level._effect["jup_urz_military_airstrip_plane_death_fire"] = loadfx("vfx/jup/prop/scriptables/jup_urz_military_airstrip_plane_death_fire.vfx");
  level._effect["heli_boss_death"] = loadfx("vfx/jup/level/sp_jup_gunship/vfx_gns_exp_missile_explosion_01.vfx");
  level._effect["vfx_gunship_intro_sunflare"] = loadfx("vfx/jup/level/sp_jup_gunship/vfx_gunship_intro_sunflare.vfx");

  if(getdvarint(@ "hash_e6afce2cf5cf7515")) {}

  utility::post_load_precache(&function_625db34652815f74);
  utility::post_load_precache(&function_b5ed8bd22451bbec);
}

function function_b5ed8bd22451bbec() {
  if(isplatformxb3() || isplatformps4()) {
    return;
  }

  types = [];
  types[types.size] = "soldier";
  types[types.size] = "civilian";

  foreach(type in types) {
    utility::setfootstepeffect(type, "dirt", level._effect["vfx_gunship_footstep_dust"]);
    utility::setfootstepeffect(type, "gravel", level._effect["vfx_gunship_footstep_dust"]);
    utility::setfootstepeffect(type, "sand", level._effect["vfx_gunship_footstep_dust"]);
  }
}

function function_625db34652815f74() {
  setsaveddvar(@ "hash_73e2c09456bc391e", 100000);
  setsaveddvar(@ "hash_ec39e239ba3c71d8", 100000);
  setsaveddvar(@ "hash_68968fdfbbd998b1", 100000);
  setsaveddvar(@ "hash_9e1db007ccf525db", 600);
  setsaveddvar(@ "hash_c600978aa1233d0c", 600);
  setsaveddvar(@ "hash_5d1173b97891b621", 600);
  setsaveddvar(@ "hash_7fc8a5a4fbb9280d", 600);
  setsaveddvar(@ "hash_7de085d323d26185", 100000);
  setsaveddvar(@ "hash_c9e47178d66b198a", 100000);
  setsaveddvar(@ "hash_5649c6bbba6c7ced", 15000);
}