/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\hud_message_shared.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\spawning_squad;
#using scripts\core_common\system_shared;
#namespace hud_message;

function private autoexec __init__system__() {
  system::register(#"hud_message", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_start_gametype(&init);
}

function init() {}

function playnotifyloop(duration) {
  playnotifyloop = spawn("script_origin", (0, 0, 0));
  playnotifyloop playLoopSound(#"uin_notify_data_loop");
  duration -= 4;

  if(duration < 1) {
    duration = 1;
  }

  wait duration;
  playnotifyloop delete();
}

function setlowermessage(text, time) {
  self notify(#"hash_6ceeeb477ece797b");

  if(isDefined(time) && time > 0) {
    self luinotifyevent(#"hash_424b9c54c8bf7a82", 2, text, int(time));
    return;
  }

  self luinotifyevent(#"hash_424b9c54c8bf7a82", 1, text);
}

function clearlowermessage() {
  self endon(#"hash_6ceeeb477ece797b");

  if(!isPlayer(self)) {
    return;
  }

  self luinotifyevent(#"hash_6b9a1c6794314120");
}

function isintop(players, topn) {
  for(i = 0; i < topn; i++) {
    if(isDefined(players[i]) && self == players[i]) {
      return true;
    }
  }

  return false;
}