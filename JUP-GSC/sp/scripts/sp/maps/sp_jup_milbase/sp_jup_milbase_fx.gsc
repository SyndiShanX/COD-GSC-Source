/*******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\maps\sp_jup_milbase\sp_jup_milbase_fx.gsc
*******************************************************************/

#namespace sp_jup_milbase_fx;

function main() {
  level._effect["vfx_jup_milbase_cigarette_smoke_02_y"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_cigarette_smoke_02_y.vfx");
  level._effect["vfx_jup_milbase_cigarette_smoke_00"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_cigarette_smoke_00.vfx");
  level._effect["vfx_jup_milbase_cigarette_smoke_background"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_cigarette_smoke_background.vfx");
  level._effect["vfx_jup_milbase_cigarette_smoke_07"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_cigarette_smoke_07.vfx");
  level._effect["vfx_jup_milbase_cigarette_smoke_06"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_cigarette_smoke_06.vfx");
  level._effect["vfx_jup_milbase_character_gas_vig_ground"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_character_gas_vig_ground.vfx");
  level._effect["vfx_jup_milbase_blima_exhaust"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_blima_exhaust.vfx");
  level._effect["vfx_jup_milbase_exfil_rotor_wash"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_exfil_rotor_wash.vfx");
  level._effect["vfx_jup_milbase_character_gas_vig"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_character_gas_vig.vfx");
  level._effect["vfx_jup_gas_cloud_room_01"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_gas_cloud_room_01.vfx");
  level._effect["vfx_milbase_cigarette_flare"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_milbase_cigarette_flare.vfx");
  level._effect["vfx_jup_milbase_cigarette_smoke_04"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_cigarette_smoke_04.vfx");
  level._effect["vfx_jup_milbase_cigarette_smoke_03"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_cigarette_smoke_03.vfx");
  level._effect["vfx_jup_milbase_cigarette_smoke_exhale_01"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_cigarette_smoke_exhale_01.vfx");
  level._effect["vfx_jup_milbase_cigarette_smoke_exhale_ch_01"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_cigarette_smoke_exhale_ch_01.vfx");
  level._effect["vfx_jup_milbase_room_meltyface_gas_02"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_room_meltyface_gas_02.vfx");
  level._effect["vfx_jup_milbase_melting_man_spit"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_melting_man_spit.vfx");
  level._effect["vfx_jup_milbase_melting_man_smk_limb_trail"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_melting_man_smk_limb_trail.vfx");
  level._effect["vfx_chemical_melting_man_smk_limb"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_chemical_melting_man_smk_limb.vfx");
  level._effect["vfx_jup_milbase_melting_man_smk_head"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_melting_man_smk_head.vfx");
  level._effect["vfx_jup_milbase_sunflare"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_sunflare.vfx");
  level._effect["vfx_jup_milbase_room_meltyface_gas"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_room_meltyface_gas.vfx");
  level._effect["vfx_jup_milbase_glass_cracking_door_narrow"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_glass_cracking_door_narrow.vfx");
  level._effect["vfx_jup_milbase_dust_blow"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_dust_blow.vfx");
  level._effect["vfx_jup_milbase_dust_blow_ch"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_dust_blow_ch.vfx");
  level._effect["vfx_jup_milbase_gas_cloud_03"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_gas_cloud_03.vfx");
  level._effect["vfx_jup_milbase_tire_dust"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_tire_dust.vfx");
  level._effect["vfx_jup_milbase_cigarette_smoke_02"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_cigarette_smoke_02.vfx");
  level._effect["vfx_milbase_falling_dust_ceiling"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_milbase_falling_dust_ceiling.vfx");
  level._effect["vfx_milbase_granules_dust_rocks_falling_ch2"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_milbase_granules_dust_rocks_falling_ch2.vfx");
  level._effect["vfx_jup_milbase_cigarette_smoke_01"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_cigarette_smoke_01.vfx");
  level._effect["cp_jup_milbase_helicopter_downdraft_01"] = loadfx("vfx/jup/level/cp_jup_milbase/cp_jup_milbase_helicopter_downdraft_01.vfx");
  level._effect["vfx_jup_milbase_gas_heli_interior_02"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_gas_heli_interior_02.vfx");
  level._effect["vfx_jup_milbase_gas_under_heli_01"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_gas_under_heli_01.vfx");
  level._effect["vfx_jup_milbase_in_heli_gas"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_in_heli_gas.vfx");
  level._effect["cp_jup_milbase_helicopter_downdraft_02"] = loadfx("vfx/jup/level/cp_jup_milbase/cp_jup_milbase_helicopter_downdraft_02.vfx");
  level._effect["vfx_jup_milbase_roof_gas_02"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_roof_gas_02.vfx");
  level._effect["vfx_jup_milbase_helicopter_downdraft_fade"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_helicopter_downdraft_fade.vfx");
  level._effect["vfx_jup_milbase_helicopter_downdraft_ch"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_helicopter_downdraft_ch.vfx");
  level._effect["vfx_jup_milbase_ambient_gas_vent_wide"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_ambient_gas_vent_wide.vfx");
  level._effect["vfx_jup_milbase_door_gas"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_door_gas.vfx");
  level._effect["vfx_jup_milbase_ambient_gas_lrg"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_ambient_gas_lrg.vfx");
  level._effect["vfx_jup_milbase_ambient_gas"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_ambient_gas.vfx");
  level._effect["vfx_jup_milbase_ambient_gas_vent"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_ambient_gas_vent.vfx");
  level._effect["vfx_jup_milbase_ambient_gas_ground_sml"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_ambient_gas_ground_sml.vfx");
  level._effect["vfx_jup_milbase_gas_sphere"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_gas_sphere.vfx");
  level._effect["vfx_jup_milbase_gas_vent_sml"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_gas_vent_sml.vfx");
  level._effect["vfx_jup_milbase_dynamic_gas"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_dynamic_gas.vfx");
  level._effect["vfx_jup_milbase_greenout_gas"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_greenout_gas.vfx");
  level._effect["vfx_jup_milbase_gas_heli_interior"] = loadfx("vfx/jup/level/cp_jup_milbase/vfx_jup_milbase_gas_heli_interior.vfx");

  if(getdvarint(@ "hash_e6afce2cf5cf7515")) {}
}