/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_prototype_fx.csc
*************************************************/

#namespace zm_prototype_fx;

function main() {
  disablefx = getdvarint("disable_fx");
  if(!isDefined(disablefx) || disablefx <= 0) {
    precache_scripted_fx();
  }
}

function precache_scripted_fx() {
  level._effect["eye_glow"] = "zombie/fx_glow_eye_orange";
  level._effect["zombie_grain"] = "misc/fx_zombie_grain_cloud";
  level._effect["headshot"] = "impacts/fx_flesh_hit";
  level._effect["headshot_nochunks"] = "misc/fx_zombie_bloodsplat";
  level._effect["bloodspurt"] = "misc/fx_zombie_bloodspurt";
  level._effect["animscript_gib_fx"] = "weapon/bullet/fx_flesh_gib_fatal_01";
  level._effect["animscript_gibtrail_fx"] = "trail/fx_trail_blood_streak";
  level.breakables_fx["barrel"]["explode"] = "explosions/fx_exp_dest_barrel_sm";
  level.breakables_fx["barrel"]["burn_start"] = "dlc5/prototype/fx_barrel_ignite";
  level._effect["perk_machine_light_yellow"] = "dlc5/zmhd/fx_wonder_fizz_light_yellow";
  level._effect["perk_machine_light_red"] = "dlc5/zmhd/fx_wonder_fizz_light_red";
  level._effect["perk_machine_light_green"] = "dlc5/zmhd/fx_wonder_fizz_light_green";
  level._effect["perk_machine_location"] = "dlc5/prototype/fx_wonder_fizz_lightning_all_interior";
}

function scriptedfx() {
  level._effect["large_ceiling_dust"] = "dlc5/zmhd/fx_dust_ceiling_impact_lg_mdbrown";
  level._effect["poltergeist"] = "dlc5/zmhd/fx_zombie_couch_effect";
  level._effect["nuke_dust"] = "maps/zombie/fx_zombie_body_nuke_dust";
}