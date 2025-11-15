/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\ac130_fx.gsc
********************************/

main() {
  level._effect["houseFire"] = loadfx("fx\explosions\ac130_house_explosion");
  level._effect["fire_bits"] = loadfx("fx\explosions\ac130_house_fire_bits");
  level._effect["fire_bits_sm"] = loadfx("fx\explosions\ac130_house_fire_bits_sm");
  level._effect["dust_line"] = loadfx("vfx\map\ac130\ac130_crane_dust_line");
  level._effect["smk_churn"] = loadfx("vfx\map\ac130\ac130_house_smk_churn");
  level._effect["heli_kickup"] = loadfx("fx\treadfx\ac130_heli_kickup");
  level._effect["00_particle_shadow_animated_lrg_e"] = loadfx("vfx\cloud\00_particle_shadow_animated_lrg_e");
  level._effect["00_particle_shadow_animated_med_e"] = loadfx("vfx\cloud\00_particle_shadow_animated_med_e");
  level._effect["00_particle_shadow_animated_sm_e"] = loadfx("vfx\cloud\00_particle_shadow_animated_sm_e");
  treadfx_override();
  maps\createfx\ac130_fx::main();
  maps\createfx\ac130_sound::main();
}

treadfx_override() {
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "brick", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "bark", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "carpet", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "cloth", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "concrete", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "dirt", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "flesh", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "foliage", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "glass", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "grass", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "gravel", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "ice", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "metal", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "mud", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "paper", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "plaster", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "rock", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "sand", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "snow", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "water", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "wood", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "asphalt", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "ceramic", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "plastic", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "rubber", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "cushion", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "fruit", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "painted metal", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "default", "fx\treadfx\ac130_heli_kickup");
  maps\_treadfx::setvehiclefx("script_vehicle_ch46e_opened_door", "none", "fx\treadfx\ac130_heli_kickup");
}