/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_58d14a82f7aa9d6d.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\system_shared;

#namespace namespace_21c59b5;

autoexec __init__system__() {
  system::register(#"hash_18ce058ad321248f", &__init__, undefined, undefined);
}

autoexec __init() {
  level.var_bf744846 = (isDefined(getgametypesetting(#"hash_3778ec3bd924f17c")) ? getgametypesetting(#"hash_3778ec3bd924f17c") : 0) && (isDefined(getgametypesetting(#"hash_7226479da761e69d")) ? getgametypesetting(#"hash_7226479da761e69d") : 0);
  level.var_69167fa4 = (isDefined(getgametypesetting(#"hash_3778ec3bd924f17c")) ? getgametypesetting(#"hash_3778ec3bd924f17c") : 0) && (isDefined(getgametypesetting(#"hash_68f4f3fd681ae3ea")) ? getgametypesetting(#"hash_68f4f3fd681ae3ea") : 0);
  level.var_30c7dc14 = (isDefined(getgametypesetting(#"hash_3778ec3bd924f17c")) ? getgametypesetting(#"hash_3778ec3bd924f17c") : 0) && (isDefined(getgametypesetting(#"hash_6c72667787a1fcc9")) ? getgametypesetting(#"hash_6c72667787a1fcc9") : 0);
}

__init__() {
  callback::on_localplayer_spawned(&on_local_player_spawned);
  level thread function_c13d6f7d();
}

on_local_player_spawned(localclientnum) {
  if(!isDefined(self)) {
    return;
  }

  player = self;
  var_ad0cc7c4 = isDefined(player stats::get_stat(localclientnum, "completedCTChallenges")) && player stats::get_stat(localclientnum, "completedCTChallenges");

  if(var_ad0cc7c4 && level.var_bf744846) {
    var_699f8485 = findstaticmodelindexarray("ct_challenge_complete");
    var_21034fe0 = findstaticmodelindexarray("no_challenge_complete");

    foreach(n_index in var_21034fe0) {
      hidestaticmodel(n_index);
    }

    foreach(n_index in var_699f8485) {
      unhidestaticmodel(n_index);
    }
  }
}

function_c13d6f7d() {
  var_699f8485 = findstaticmodelindexarray("ct_challenge_complete");
  var_21034fe0 = findstaticmodelindexarray("no_challenge_complete");

  if(level.var_bf744846) {
    foreach(n_index in var_699f8485) {
      hidestaticmodel(n_index);
    }

    return;
  }

  foreach(n_index in var_699f8485) {
    hidestaticmodel(n_index);
  }

  foreach(n_index in var_21034fe0) {
    hidestaticmodel(n_index);
  }
}