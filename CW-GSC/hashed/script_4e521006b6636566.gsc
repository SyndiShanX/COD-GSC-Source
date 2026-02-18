/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4e521006b6636566.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_stats;
#namespace namespace_c46118a7;

function private autoexec __init__system__() {
  system::register(#"hash_125fc0c0065c7dea", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(util::get_game_type() === # "hash_125fc0c0065c7dea") {
    callback::add_callback(#"hash_5118a91e667446ee", &function_9e216600);
    level.var_e35c191f = 1;
  }
}

function function_9e216600() {
  if(getdvarint(#"hash_3ec3a7252086be23", 0)) {
    foreach(player in getplayers()) {
      player zm_stats::increment_challenge_stat(#"hash_7aecddb420d2f602");
    }
  }
}