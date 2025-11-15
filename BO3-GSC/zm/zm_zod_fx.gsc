/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_zod_fx.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#namespace zm_zod_fx;

function main() {
  precache_scripted_fx();
  precache_createfx_fx();
}

function precache_scripted_fx() {
  level._effect["idgun_cocoon_off"] = "zombie/fx_idgun_cocoon_explo_zod_zmb";
  level._effect["pap_basin_glow"] = "zombie/fx_ritual_pap_basin_fire_zod_zmb";
  level._effect["pap_basin_glow_lg"] = "zombie/fx_ritual_pap_basin_fire_lg_zod_zmb";
  level._effect["cultist_crate_personal_item"] = "zombie/fx_cultist_crate_smk_zod_zmb";
  level._effect["robot_landing"] = "zombie/fx_robot_helper_jump_landing_zod_zmb";
  level._effect["robot_sky_trail"] = "zombie/fx_robot_helper_trail_sky_zod_zmb";
  level._effect["robot_ground_spawn"] = "zombie/fx_robot_helper_ground_tell_zod_zmb";
  level._effect["portal_shortcut_closed"] = "zombie/fx_quest_portal_tear_zod_zmb";
}

function precache_createfx_fx() {}