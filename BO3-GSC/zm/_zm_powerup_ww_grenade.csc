/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_powerup_ww_grenade.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\system_shared;
#using scripts\zm\_zm_powerups;
#namespace zm_powerup_ww_grenade;

function autoexec __init__sytem__() {
  system::register("zm_powerup_ww_grenade", & __init__, undefined, undefined);
}

function __init__() {
  zm_powerups::include_zombie_powerup("ww_grenade");
  zm_powerups::add_zombie_powerup("ww_grenade");
}