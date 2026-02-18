/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\powerup\zm_powerup_nuke.csc
***********************************************/

#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_powerups;
#namespace zm_powerup_nuke;

function private autoexec __init__system__() {
  system::register(#"zm_powerup_nuke", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  zm_powerups::include_zombie_powerup("nuke");
  zm_powerups::add_zombie_powerup("nuke");
  clientfield::register("actor", "zm_nuked", 1, 1, "int", &zombie_nuked, 0, 0);
  clientfield::register("vehicle", "zm_nuked", 1, 1, "int", &zombie_nuked, 0, 0);
}

function zombie_nuked(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self zombie_death::flame_death_fx(bwastimejump);
}