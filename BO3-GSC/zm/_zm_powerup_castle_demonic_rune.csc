/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_powerup_castle_demonic_rune.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\zm\_zm_powerups;
#namespace zm_powerup_demonic_rune;

function autoexec __init__sytem__() {
  system::register("zm_powerup_demonic_rune", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "demonic_rune_fx", 5000, 1, "int", & function_4a94c040, 0, 0);
  zm_powerups::include_zombie_powerup("demonic_rune_lor");
  zm_powerups::add_zombie_powerup("demonic_rune_lor");
  zm_powerups::include_zombie_powerup("demonic_rune_ulla");
  zm_powerups::add_zombie_powerup("demonic_rune_ulla");
  zm_powerups::include_zombie_powerup("demonic_rune_oth");
  zm_powerups::add_zombie_powerup("demonic_rune_oth");
  zm_powerups::include_zombie_powerup("demonic_rune_zor");
  zm_powerups::add_zombie_powerup("demonic_rune_zor");
  zm_powerups::include_zombie_powerup("demonic_rune_mar");
  zm_powerups::add_zombie_powerup("demonic_rune_mar");
  zm_powerups::include_zombie_powerup("demonic_rune_uja");
  zm_powerups::add_zombie_powerup("demonic_rune_uja");
}

function function_4a94c040(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    playfxontag(localclientnum, "dlc1/castle/fx_demon_gate_rune_glow", self, "tag_origin");
  }
}