/*********************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_armamental_accomplishment.gsc
*********************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_armamental_accomplishment;

function autoexec __init__sytem__() {
  system::register("zm_bgb_armamental_accomplishment", & __init__, undefined, "bgb");
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_armamental_accomplishment", "rounds", 3, & enable, & disable, undefined);
}

function enable() {
  self setperk("specialty_fastmeleerecovery");
  self setperk("specialty_fastweaponswitch");
  self setperk("specialty_fastequipmentuse");
  self setperk("specialty_fasttoss");
}

function disable() {
  self unsetperk("specialty_fastmeleerecovery");
  self unsetperk("specialty_fastweaponswitch");
  self unsetperk("specialty_fastequipmentuse");
  self unsetperk("specialty_fasttoss");
}