/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5c6dce5ab3ddcd4f.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#namespace paintshop;

function private autoexec __init__system__() {
  system::register(#"paintshop", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(getdvarint(#"hash_2728dd57f235e6e5", 0)) {
    callback::on_spawned(&on_player_spawned);
  }
}

function private on_player_spawned(localclientnum) {
  spawned_player = self;
  local_player = function_5c10bd79(localclientnum);

  if(spawned_player.team == local_player.team || function_b37afded(spawned_player.team, local_player.team)) {
    if(function_5020f5d1(localclientnum) < function_5ada7356()) {
      spawned_player function_2bbc8349(localclientnum, 1);
    }

    return;
  }

  spawned_player function_2bbc8349(localclientnum, 0);
}

function function_2bbc8349(localclientnum, enable) {
  if(!getdvarint(#"hash_2728dd57f235e6e5", 0)) {
    return;
  }

  if(isDefined(localclientnum) && isDefined(self) && isDefined(enable) && isPlayer(self)) {
    player = self;
    player function_8f214149(localclientnum, enable);
  }
}