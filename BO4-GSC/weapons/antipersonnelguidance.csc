/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\antipersonnelguidance.csc
***********************************************/

#include scripts\core_common\duplicaterender_mgr;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace antipersonnel_guidance;

autoexec __init__system__() {
  system::register(#"antipersonnel_guidance", &__init__, undefined, undefined);
}

__init__() {
  level thread player_init();
  duplicate_render::set_dr_filter_offscreen("ap", 75, "ap_locked", undefined, 2, "mc/hud_outline_model_red", 0);
}

player_init() {
  util::waitforclient(0);
  players = getlocalplayers();

  foreach(player in players) {
    player thread watch_lockon(0);
  }
}

watch_lockon(localclientnum) {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"lockon_changed");
    target = waitresult.target;
    state = waitresult.state;

    if(isDefined(self.replay_lock) && (!isDefined(target) || self.replay_lock != target)) {
      self.ap_lock duplicate_render::change_dr_flags(localclientnum, undefined, "ap_locked");
      self.ap_lock = undefined;
    }

    switch (state) {
      case 0:
      case 1:
      case 3:
        target duplicate_render::change_dr_flags(localclientnum, undefined, "ap_locked");
        break;
      case 2:
      case 4:
        target duplicate_render::change_dr_flags(localclientnum, "ap_locked", undefined);
        self.ap_lock = target;
        break;
    }
  }
}