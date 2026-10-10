/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\maps\sp_jup_silo\sp_jup_silo_fx.gsc
*************************************************************/

#using script_5e60754c97311cd;
#using scripts\common\exploder;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace sp_jup_silo_fx;

function main() {
  level._effect["vfx_silo_imp_flesh_sml_exit_negx"] = loadfx("vfx/jup/level/sp_jup_silo/vfx_silo_imp_flesh_sml_exit_negx.vfx");
  level._effect["vfx_silo_imp_flesh_sml_exit_x"] = loadfx("vfx/jup/level/sp_jup_silo/vfx_silo_imp_flesh_sml_exit_x.vfx");
  level._effect["vfx_silo_finale_door_dust_fall_01"] = loadfx("vfx/jup/level/sp_jup_silo/vfx_silo_finale_door_dust_fall_01.vfx");
  level._effect["vfx_jup_silo_hangar_door_open_base"] = loadfx("vfx/jup/level/sp_jup_silo/vfx_jup_silo_hangar_door_open_base.vfx");
  level._effect["vfx_jup_silo_hangar_door_open_door"] = loadfx("vfx/jup/level/sp_jup_silo/vfx_jup_silo_hangar_door_open_door.vfx");
  level._effect["vfx_silo_dust_kickup_char_boot"] = loadfx("vfx/jup/level/sp_jup_silo/vfx_silo_dust_kickup_char_boot.vfx");
  level._effect["vfx_heli_death"] = loadfx("vfx/iw9/veh/scriptables/death/vfx_veh_med_bird_explosion.vfx");
  level._effect["vfx_klaxon_flare2"] = loadfx("vfx/mgl/core/vehicles/aircraft_light_red_blink_lit.vfx");
  arr01 = [];
  arr01[arr01.size] = "outside_silo_zone";
  arr01[arr01.size] = "outside_silo_zone_02";
  arr01[arr01.size] = "outside_silo_zone_03";
  arr01[arr01.size] = "outside_silo_zone_04";
  arr01[arr01.size] = "outside_silo_zone_05";
  arr01[arr01.size] = "outside_silo_zone_06";
  thread function_b9e130d444d299c9("outside_silo_exploder", arr01);
  arr02 = [];
  arr02[arr02.size] = "underground_zone";
  arr02[arr02.size] = "underground_zone_02";
  thread function_b9e130d444d299c9("underground_exploder", arr02);
}