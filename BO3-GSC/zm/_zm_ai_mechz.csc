/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_ai_mechz.csc
*************************************************/

#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_zm_elemental_zombies;
#namespace zm_ai_mechz;

function autoexec __init__sytem__() {
  system::register("zm_ai_mechz", &__init__, &__main__, undefined);
}

function autoexec __init__() {}

function __main__() {
  visionset_mgr::register_overlay_info_style_burn("mechz_player_burn", 5000, 15, 1.5);
}