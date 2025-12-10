/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_idle_eyes.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_idle_eyes;

function autoexec __init__sytem__() {
  system::register("zm_bgb_idle_eyes", &__init__, undefined, undefined);
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_idle_eyes", "activated");
  visionset_mgr::register_visionset_info("zm_bgb_idle_eyes", 1, 31, undefined, "zombie_noire");
  visionset_mgr::register_overlay_info_style_postfx_bundle("zm_bgb_idle_eyes", 1, 1, "pstfx_zm_screen_warp");
}