/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_riotshield_tomb.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weap_riotshield;
#using scripts\zm\craftables\_zm_craft_shield;
#namespace tomb_shield;

function autoexec __init__sytem__() {
  system::register("zm_weap_tomb_shield", & __init__, & __main__, undefined);
}

function __init__() {
  zm_craft_shield::init("craft_shield_zm", "tomb_shield", "wpn_t7_zmb_hd_origins_shield_dmg00_world");
  level.weaponriotshield = getweapon("tomb_shield");
  zm_equipment::register("tomb_shield", & "ZOMBIE_EQUIP_RIOTSHIELD_PICKUP_HINT_STRING", & "ZOMBIE_EQUIP_RIOTSHIELD_HOWTO", undefined, "riotshield");
}

function __main__() {
  zm_equipment::register_for_level("tomb_shield");
  zm_equipment::include("tomb_shield");
}