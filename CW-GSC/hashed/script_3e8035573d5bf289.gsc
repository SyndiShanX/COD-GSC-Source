/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3e8035573d5bf289.gsc
***********************************************/

#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_bgb;
#using scripts\zm_common\zm_laststand;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_utility;
#namespace namespace_e7b06f1b;

function private autoexec __init__system__() {
  system::register(#"hash_6119ea2d427fdf8a", &preinit, undefined, undefined, undefined);
}

function private preinit() {}

function function_f1d9de41(player) {
  level thread function_386c20ef(player);
}

function function_386c20ef(player) {
  if(isDefined(player.lives) && player.lives < 5) {
    player.lives++;
    return;
  }

  if(player zm_laststand::function_618fd37e() < 5) {
    player zm_laststand::function_3a00302e();
  }
}