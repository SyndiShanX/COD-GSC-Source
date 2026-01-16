/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_powerup_weapon_minigun.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\system_shared;
#using scripts\zm\_zm_powerups;
#namespace zm_powerup_weapon_minigun;

function autoexec __init__sytem__() {
  system::register("zm_powerup_weapon_minigun", & __init__, undefined, undefined);
}

function __init__() {
  zm_powerups::include_zombie_powerup("minigun");
  if(tolower(getdvarstring("g_gametype")) != "zcleansed") {
    zm_powerups::add_zombie_powerup("minigun", "powerup_mini_gun");
  }
}