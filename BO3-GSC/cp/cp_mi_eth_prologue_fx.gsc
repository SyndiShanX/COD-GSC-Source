/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_eth_prologue_fx.gsc
*************************************************/

#using scripts\codescripts\struct;
#namespace cp_mi_eth_prologue_fx;

function main() {
  level._effect["gen_explosion"] = "explosions/fx_exp_generic_lg";
  level._effect["rock_explosion"] = "explosions/fx_exp_grenade_dirt";
  level._effect["fx_apc_fire"] = "fire/fx_fire_apc_bridge_prologue";
  level._effect["dropship_spotlight"] = "light/fx_light_landingspot_vtol_dropship_bright";
  level._effect["vtol_rotorwash"] = "dirt/fx_dust_rotorwash_vtol_prologue";
  level._effect["apc_dmg_low"] = "vehicle/fx_apc_rail_dmg_state_01";
  level._effect["apc_dmg_high"] = "vehicle/fx_apc_rail_dmg_state_02";
  level._effect["apc_death_fx_cin"] = "fire/fx_fire_apc_end_prologue";
  level._effect["prologue_transition_debris"] = "debris/fx_debris_transition_prologue";
  level._effect["vtol_death_explosion"] = "explosions/fx_vexp_hunter_death_sm";
  level._effect["vtol_death_smoke"] = "smoke/fx_smk_hunter_crash_trail_child_sm";
}