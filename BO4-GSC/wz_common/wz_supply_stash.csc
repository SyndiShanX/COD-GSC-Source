/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_supply_stash.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace wz_supply_stash;

autoexec __init__system__() {
  system::register(#"wz_supply_stash", &__init__, undefined, undefined);
}

__init__() {
  level.var_cee10b49 = [];
  callback::on_localclient_connect(&on_localclient_connect);
}

private on_localclient_connect(localclientnum) {
  if(isDefined(getgametypesetting(#"wzenablebountyhuntervehicles")) && getgametypesetting(#"wzenablebountyhuntervehicles") || isDefined(getgametypesetting(#"hash_23e09b48546a7e3b")) && getgametypesetting(#"hash_23e09b48546a7e3b")) {
    level thread function_53d906fd(localclientnum);
    return;
  }

  if(isDefined(getgametypesetting("infectionMode")) && getgametypesetting("infectionMode")) {
    level thread function_fd3f6235(localclientnum);
  }
}

private function_53d906fd(localclientnum) {
  while(true) {
    player = function_5c10bd79(localclientnum);
    playfx = 0;

    if(isDefined(player) && isalive(player)) {
      vehicle = getplayervehicle(player);
      playfx = isDefined(vehicle) && vehicle.scriptvehicletype === "player_muscle";
    }

    foreach(stash in level.item_spawn_stashes) {
      if(function_8a8a409b(stash)) {
        if(stash.var_aa9f8f87 === #"supply_stash_parent_dlc1" || stash.var_aa9f8f87 === #"supply_stash_parent") {
          stash update_fx(localclientnum, playfx, function_ffdbe8c2(stash));
        }
      }
    }

    foreach(drop in level.var_624588d5) {
      if(isDefined(drop) && isDefined(drop.var_3a55f5cf) && drop.var_3a55f5cf) {
        state = 0;

        if(drop getanimtime("p8_fxanim_wz_supply_stash_04_used_anim") > 0) {
          state = 2;
        } else if(drop getanimtime("p8_fxanim_wz_supply_stash_04_open_anim") > 0) {
          state = 1;
        }

        drop update_fx(localclientnum, playfx, state);
      }
    }

    wait 0.2;
  }
}

private function_fd3f6235(localclientnum) {
  while(true) {
    player = function_5c10bd79(localclientnum);
    playfx = 0;

    if(player clientfield::get_to_player("infected") != 1) {
      playfx = 1;
    }

    foreach(drop in level.var_624588d5) {
      if(isDefined(drop) && isDefined(drop.var_3a55f5cf) && drop.var_3a55f5cf) {
        state = 0;

        if(drop getanimtime("p8_fxanim_wz_supply_stash_04_used_anim") > 0) {
          state = 2;
        } else if(drop getanimtime("p8_fxanim_wz_supply_stash_04_open_anim") > 0) {
          state = 1;
        }

        drop update_fx(localclientnum, playfx, state);
      }
    }

    wait 0.2;
  }
}

update_fx(localclientnum, playfx, state) {
  if(playfx && state == 0) {
    if(!isDefined(self.var_d3d42148)) {
      self.var_d3d42148 = playFX(localclientnum, #"hash_6bcc939010112ea", self.origin);
    }

    return;
  }

  if(isDefined(self.var_d3d42148)) {
    stopfx(localclientnum, self.var_d3d42148);
    self.var_d3d42148 = undefined;
  }
}