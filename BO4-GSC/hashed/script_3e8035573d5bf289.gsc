/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_3e8035573d5bf289.gsc
***********************************************/

#include scripts\core_common\aat_shared;
#include scripts\core_common\ai\zombie_death;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\util;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_laststand;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_utility;

#namespace namespace_e7b06f1b;

autoexec __init__system__() {
  system::register(#"hash_6119ea2d427fdf8a", &__init__, undefined, undefined);
}

__init__() {}

function_f1d9de41(player) {
  player zm_utility::function_7a35b1d7(self.hint);
  level thread function_386c20ef(player);
}

function_386c20ef(player) {
  if(isDefined(player.lives) && player.lives < 5) {
    player.lives++;
    return;
  }

  if(player zm_laststand::function_618fd37e() < 5) {
    player zm_laststand::function_3a00302e();
  }
}