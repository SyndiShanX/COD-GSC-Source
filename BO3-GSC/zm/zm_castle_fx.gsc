/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_castle_fx.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#namespace zm_castle_fx;

function main() {
  precache_scripted_fx();
  precache_createfx_fx();
}

function precache_scripted_fx() {
  level._effect["zapper"] = "dlc1/castle/fx_elec_trap_castle";
  level._effect["zapper_light_ready"] = "maps/zombie/fx_zombie_light_glow_green";
  level._effect["zapper_light_notready"] = "maps/zombie/fx_zombie_light_glow_red";
  level._effect["elec_md"] = "zombie/fx_elec_player_md_zmb";
  level._effect["elec_sm"] = "zombie/fx_elec_player_sm_zmb";
  level._effect["elec_torso"] = "zombie/fx_elec_player_torso_zmb";
  level._effect["battery_charge"] = "dlc1/castle/fx_battery_lightning_castle";
  level._effect["dempsey_rocket_twinkle"] = "dlc1/castle/fx_dempsey_satellite_twinkle";
  level._effect["dark_matter"] = "dlc1/castle/fx_ee_dark_matter_spill";
  level._effect["keeper_beam"] = "dlc1/castle/fx_ee_keeper_beam_tgt_castle";
  level._effect["keeper_charge"] = "dlc1/castle/fx_ee_keeper_channeling_stone_tgt";
  level._effect["mpd_fx"] = "dlc1/castle/fx_ee_mpd_loop";
  level._effect["summoning_key_source"] = "dlc1/castle/fx_ee_ritual_key_electricity_src";
  level._effect["rocket_explosion"] = "dlc1/castle/fx_ee_rocket_exp";
  level._effect["ghost_torso"] = "dlc1/castle/fx_keeper_ghost_ambient_torso";
  level._effect["ghost_trail"] = "dlc1/castle/fx_keeper_ghost_mist_trail";
  level._effect["summoning_key_glow"] = "dlc1/castle/fx_ritual_key_glow_charging";
  level._effect["summoning_key_done"] = "dlc1/castle/fx_ritual_key_soul_exp_igc";
  level._effect["keeper_summon"] = "dlc1/zmb_weapon/fx_bow_storm_orb_zmb";
  level._effect["keeper_torso"] = "zombie/fx_keeper_ambient_torso_zod_zmb";
  level._effect["keeper_mouth"] = "zombie/fx_keeper_glow_mouth_zod_zmb";
  level._effect["keeper_trail"] = "zombie/fx_keeper_mist_trail_zod_zmb";
}

function precache_createfx_fx() {}