/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_powerup_genesis_random_weapon.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\zm\_zm_powerups;
#namespace zm_powerup_genesis_random_weapon;

function autoexec __init__sytem__() {
  system::register("zm_powerup_genesis_random_weapon", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "random_weap_fx", 15000, 1, "int", & function_1913104f, 0, 0);
  zm_powerups::include_zombie_powerup("genesis_random_weapon");
  zm_powerups::add_zombie_powerup("genesis_random_weapon");
}

function function_1913104f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    playFXOnTag(localclientnum, "dlc1/castle/fx_demon_gate_rune_glow", self, "tag_origin");
  }
}