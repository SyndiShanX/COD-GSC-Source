/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\powerup\zm_powerup_nuke.csc
***********************************************/

#include scripts\core_common\ai\zombie_death;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_powerups;

#namespace zm_powerup_nuke;

autoexec __init__system__() {
  system::register(#"zm_powerup_nuke", &__init__, undefined, undefined);
}

__init__() {
  zm_powerups::include_zombie_powerup("nuke");
  zm_powerups::add_zombie_powerup("nuke");
  clientfield::register("actor", "zm_nuked", 1, 1, "int", &zombie_nuked, 0, 0);
  clientfield::register("vehicle", "zm_nuked", 1, 1, "int", &zombie_nuked, 0, 0);
}

zombie_nuked(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self zombie_death::flame_death_fx(localclientnum);
}