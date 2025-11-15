/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_prototype_fx.gsc
*************************************************/

#using scripts\shared\flagsys_shared;
#namespace zm_prototype_fx;

function main() {
  scriptedfx();
  level thread fx_overrides();
}

function scriptedfx() {
  level._effect["large_ceiling_dust"] = "dlc5/zmhd/fx_dust_ceiling_impact_lg_mdbrown";
  level._effect["poltergeist"] = "dlc5/zmhd/fx_zombie_couch_effect";
  level._effect["nuke_dust"] = "maps/zombie/fx_zombie_body_nuke_dust";
  level._effect["lght_marker"] = "dlc5/tomb/fx_tomb_marker";
  level._effect["lght_marker_flare"] = "dlc5/tomb/fx_tomb_marker_fl";
  level._effect["zombie_grain"] = "misc/fx_zombie_grain_cloud";
}

function fx_overrides() {
  level flagsys::wait_till("load_main_complete");
  level._effect["additionalprimaryweapon_light"] = "dlc5/zmhd/fx_perk_mule_kick";
}