/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_98a64d96183c8f8.gsc
************************************************/

#using script_5e60754c97311cd;
#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace namespace_334206cebfdc5b72;

function main() {
  level._effect["vfx_chemical_hatch_open"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_chemical_hatch_open.vfx");
  level._effect["vfx_chemical_glow_yellow_01"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_chemical_glow_yellow_01.vfx");
  level._effect["vfx_chemical_infil_vectorfield"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_chemical_infil_vectorfield.vfx");
  level._effect["vfx_chemical_glow_red_01"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_chemical_glow_red_01.vfx");
  level._effect["vfx_chemical_sunflare"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_chemical_sunflare.vfx");
  level._effect["vfx_chemical_character_gas_head_vig"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_chemical_character_gas_head_vig.vfx");
  level._effect["vfx_chemical_character_gas_body_vig"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_chemical_character_gas_body_vig.vfx");
  level._effect["vfx_chemical_reactor"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_chemical_reactor.vfx");
  level._effect["vfx_chemical_clouds_backdoor"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_chemical_clouds_backdoor.vfx");
  level._effect["vfx_chemical_exfil_window_clouds"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_chemical_exfil_window_clouds.vfx");
  level._effect["vfx_chemical_amb_motes_01"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_chemical_amb_motes_01.vfx");
  level._effect["vfx_cine_ac130_lights"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_cine_ac130_lights.vfx");
  level._effect["vfx_ac130_rotors"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_ac130_rotors.vfx");
  level._effect["vfx_chemical_melting_man_spit"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_chemical_melting_man_spit.vfx");
  level._effect["vfx_chemical_melting_man_smk_limb_trail"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_chemical_melting_man_smk_limb_trail.vfx");
  level._effect["vfx_chemical_smk_rising"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_chemical_smk_rising.vfx");
  level._effect["vfx_chemical_melting_man_smk_head"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_chemical_melting_man_smk_head.vfx");
  level._effect["vfx_chemical_supplydrop_lensflare_yellow"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_chemical_supplydrop_lensflare_yellow.vfx");
  level._effect["vfx_jup_canister_blinking_red_light"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_jup_canister_blinking_red_light.vfx");
  level._effect["vfx_chemical_melting_man_smk_limb"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_chemical_melting_man_smk_limb.vfx");
  level._effect["vfx_chemical_canister_concrete_impact"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_chemical_canister_concrete_impact.vfx");
  level._effect["vfx_canister_blinking_light_green"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_canister_blinking_light_green.vfx");
  level._effect["vfx_chemical_gas_camera"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_chemical_gas_camera.vfx");
  level._effect["vfx_chemical_red_rotating_light_01"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_chemical_red_rotating_light_01.vfx");
  level._effect["vfx_chemical_smk_signal"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_chemical_smk_signal.vfx");
  level._effect["vfx_chemical_seeping_gas"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_chemical_seeping_gas.vfx");
  level._effect["vfx_chemical_veh_chopper_explosion"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_chemical_veh_chopper_explosion.vfx");
  level._effect["vfx_veh_blima_explosion"] = loadfx("vfx/iw9/veh/scriptables/death/vfx_veh_blima_explosion.vfx");
  level._effect["vfx_chemical_red_flare"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_chemical_red_flare.vfx");
  level._effect["vfx_volumetric_particles_1"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_volumetric_particles_1.vfx");
  level._effect["gunship_flares"] = loadfx("vfx/iw8_mp/killstreak/vfx_ac130_flares.vfx");
  setDvar(@ "hash_463c394a8f4350b0", "0 0 0");
  thread function_b9e130d444d299c9("main_cooling_tower", "zone01");
  level.var_ac6e882054f231cf = 1;
  level._effect["vfx_dam_truck_bomb_glow_01"] = loadfx("vfx/jup/level/cp_jup_dam/vfx_dam_truck_bomb_glow_01.vfx");
  level._effect["vfx_chopper_air_explosion"] = loadfx("vfx/iw8_cp/chopper/vfx_chopper_air_explosion");
  level._effect["vfx_chopper_fire_cont"] = loadfx("vfx/core/expl/fire_smoke_trail_L_emitter");
  level._effect["vfx_chopper_sparks"] = loadfx("vfx/iw8_cp/level/cp_stk_faridah/vfx_chopper_sparks");
  level._effect["vfx_fire_smoke"] = loadfx("vfx/core/expl/fire_smoke_trail_L");
  level._effect["vfx_disarm_sparks"] = loadfx("vfx/jup/level/cp_jup_dam/vfx_dam_bomb_disarm_sparks_truck");
  level._effect["vfx_heli_explosion_large"] = loadfx("vfx/iw9/veh/scriptables/vfx_veh9_explosion_mil.vfx");

  if(getDvar(@ "clientsideeffects") != "<dev string:x1c>") {}
}