/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_demo.csc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace zm_demo;

function private autoexec __init__system__() {
  system::register(#"zm_demo", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(isdemoplaying()) {
    if(!isDefined(level.demolocalclients)) {
      level.demolocalclients = [];
    }

    callback::on_localclient_connect(&player_on_connect);
  }
}

function player_on_connect(localclientnum) {
  level thread watch_predicted_player_changes(localclientnum);
}

function watch_predicted_player_changes(localclientnum) {
  level.demolocalclients[localclientnum] = spawnStruct();
  level.demolocalclients[localclientnum].nonpredicted_local_player = function_27673a7(localclientnum);
  level.demolocalclients[localclientnum].predicted_local_player = function_5c10bd79(localclientnum);

  while(true) {
    nonpredicted_local_player = function_27673a7(localclientnum);
    predicted_local_player = function_5c10bd79(localclientnum);

    if(nonpredicted_local_player !== level.demolocalclients[localclientnum].nonpredicted_local_player) {
      level notify(#"demo_nplplayer_change", localclientnum);
      level notify("demo_nplplayer_change" + localclientnum, {
        #old_player: level.demolocalclients[localclientnum].nonpredicted_local_player, #new_player: nonpredicted_local_player
      });
      level.demolocalclients[localclientnum].nonpredicted_local_player = nonpredicted_local_player;
    }

    if(predicted_local_player !== level.demolocalclients[localclientnum].predicted_local_player) {
      level notify(#"demo_plplayer_change", {
        #localclientnum: localclientnum, #old_player: level.demolocalclients[localclientnum].predicted_local_player, #new_player: predicted_local_player
      });
      level notify("demo_plplayer_change" + localclientnum, {
        #old_player: level.demolocalclients[localclientnum].predicted_local_player, #new_player: predicted_local_player
      });
      level.demolocalclients[localclientnum].predicted_local_player = predicted_local_player;
    }

    waitframe(1);
  }
}