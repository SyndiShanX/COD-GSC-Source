/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_powerup_shield_charge.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\system_shared;
#using scripts\zm\_zm_powerups;
#namespace zm_powerup_shield_charge;

function autoexec __init__sytem__() {
  system::register("zm_powerup_shield_charge", &__init__, undefined, undefined);
}

function __init__() {
  zm_powerups::include_zombie_powerup("shield_charge");
  zm_powerups::add_zombie_powerup("shield_charge");
}