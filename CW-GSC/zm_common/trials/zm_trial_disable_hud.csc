/*****************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_disable_hud.csc
*****************************************************/

#using scripts\core_common\system_shared;
#using scripts\zm\perk\zm_perk_death_perception;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_trial;
#namespace zm_trial_disable_hud;

function private autoexec __init__system__() {
  system::register(#"zm_trial_disable_hud", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  zm_trial::register_challenge(#"disable_hud", &on_begin, &on_end);
}

function private on_begin(local_client_num, params) {
  level thread function_40349f7c();
}

function function_40349f7c(localclientnum) {
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

function private on_end(local_client_num) {
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