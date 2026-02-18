/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\multilockapguidance.csc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace antipersonnel_guidance;

function private autoexec __init__system__() {
  system::register(#"multilockap_guidance", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level thread player_init();
}

function player_init() {
  util::waitforclient(0);
  players = getlocalplayers();

  foreach(player in players) {
    player thread watch_lockon(0);
  }
}

function watch_lockon(localclientnum) {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"lockon_changed");
    state = waitresult.state;
    target = waitresult.target;

    if(isDefined(self.replay_lock) && (!isDefined(target) || self.replay_lock != target)) {
      self.ap_lock = undefined;
    }

    switch (state) {
      case 0:
      case 1:
      case 3:
        break;
      case 2:
      case 4:
        self.ap_lock = target;
        break;
    }
  }
}