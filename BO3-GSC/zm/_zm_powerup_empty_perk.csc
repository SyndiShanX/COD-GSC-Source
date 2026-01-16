/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_powerup_empty_perk.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\system_shared;
#using scripts\zm\_zm_powerups;
#namespace zm_powerup_free_perk;

function autoexec __init__sytem__() {
  system::register("zm_powerup_empty_perk", & __init__, undefined, undefined);
}

function __init__() {
  zm_powerups::include_zombie_powerup("empty_perk");
  zm_powerups::add_zombie_powerup("empty_perk");
}