/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_disable_hud.csc
*****************************************************/

#include scripts\core_common\system_shared;
#include scripts\zm\perk\zm_perk_death_perception;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_trial;

#namespace zm_trial_disable_hud;

autoexec __init__system__() {
  system::register(#"zm_trial_disable_hud", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"disable_hud", &on_begin, &on_end);
}

private on_begin(local_client_num, params) {
  level thread function_40349f7c();
}

function_40349f7c(localclientnum) {
  level endon(#"hash_38932f8deb28b470", #"end_game");
  wait 12;
  level.var_dc60105c = 1;
  maxclients = getmaxlocalclients();

  for(localclientnum = 0; localclientnum < maxclients; localclientnum++) {
    if(isDefined(function_5c10bd79(localclientnum))) {
      foreach(player in getplayers(localclientnum)) {
        player zm::function_92f0c63(localclientnum);
      }

      foreach(player in getplayers(localclientnum)) {
        player zm_perk_death_perception::function_25410869(localclientnum);
      }
    }
  }
}

private on_end(local_client_num) {
  level notify(#"hash_38932f8deb28b470");
  level.var_dc60105c = undefined;
  maxclients = getmaxlocalclients();

  for(localclientnum = 0; localclientnum < maxclients; localclientnum++) {
    if(isDefined(function_5c10bd79(localclientnum))) {
      foreach(player in getplayers(localclientnum)) {
        player zm::function_92f0c63(localclientnum);
      }

      foreach(player in getplayers(localclientnum)) {
        player zm_perk_death_perception::function_25410869(localclientnum);
      }
    }
  }
}