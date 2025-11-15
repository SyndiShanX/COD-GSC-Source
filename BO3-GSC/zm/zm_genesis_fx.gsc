/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_genesis_fx.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#namespace zm_genesis_fx;

function main() {
  precache_scripted_fx();
  precache_createfx_fx();
}

function precache_scripted_fx() {
  level._effect["portal_3p"] = "zombie/fx_quest_portal_trail_zod_zmb";
  level._effect["beast_return_aoe_kill"] = "zombie/fx_bmode_attack_grapple_zod_zmb";
  level._effect["fx_margwa_explo_head_aoe_zod_zmb"] = "zombie/fx_margwa_explo_head_aoe_zod_zmb";
  level._effect["raps_meteor_fire"] = "zombie/fx_meatball_trail_sky_zod_zmb";
  level._effect["headshot"] = "impacts/fx_flesh_hit";
  level._effect["headshot_nochunks"] = "misc/fx_zombie_bloodsplat";
  level._effect["bloodspurt"] = "misc/fx_zombie_bloodspurt";
  level._effect["animscript_gib_fx"] = "weapon/bullet/fx_flesh_gib_fatal_01";
  level._effect["animscript_gibtrail_fx"] = "trail/fx_trail_blood_streak";
  level._effect["switch_sparks"] = "env/electrical/fx_elec_wire_spark_burst";
  level._effect["keeper_spawn"] = "zombie/fx_portal_keeper_spawn_zod_zmb";
  level._effect["pap_cord_impact"] = "impacts/fx_bul_impact_blood_body_fatal_zmb";
  level._effect["fury_ground_tell_fx"] = "zombie/fx_meatball_impact_ground_tell_zod_zmb";
}

function precache_createfx_fx() {}

function function_2c301fae() {
  level thread function_12901f9a();
  level thread function_7eea24df();
}

function function_12901f9a() {
  level._effect["jugger_light"] = "dlc4/genesis/fx_perk_juggernaut";
  level._effect["revive_light"] = "dlc4/genesis/fx_perk_quick_revive";
  level._effect["sleight_light"] = "dlc4/genesis/fx_perk_sleight_of_hand";
  level._effect["doubletap2_light"] = "dlc4/genesis/fx_perk_doubletap";
  level._effect["marathon_light"] = "dlc4/genesis/fx_perk_stamin_up";
  level._effect["additionalprimaryweapon_light"] = "dlc4/genesis/fx_perk_mule_kick";
}

function function_7eea24df() {
  level._effect["lght_marker"] = "dlc4/genesis/fx_weapon_box_marker_genesis";
}