/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\powerup\zm_powerup_bonus_points_team.csc
*******************************************************/

#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_powerups;

#namespace zm_powerup_bonus_points_team;

autoexec __init__system__() {
  system::register(#"zm_powerup_bonus_points_team", &__init__, undefined, undefined);
}

__init__() {
  zm_powerups::include_zombie_powerup("bonus_points_team");
  zm_powerups::add_zombie_powerup("bonus_points_team");
}