/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_demo.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace zm_demo;

autoexec __init__system__() {
  system::register(#"zm_demo", &__init__, undefined, undefined);
}

__init__() {
  if(isdemoplaying()) {
    if(!isDefined(level.demolocalclients)) {
      level.demolocalclients = [];
    }

    callback::on_localclient_connect(&player_on_connect);
  }
}

player_on_connect(localclientnum) {
  level thread watch_predicted_player_changes(localclientnum);
}

watch_predicted_player_changes(localclientnum) {
  level.demolocalclients[localclientnum] = spawnStruct();
  level.demolocalclients[localclientnum].nonpredicted_local_player = function_27673a7(localclientnum);
  level.demolocalclients[localclientnum].predicted_local_player = function_5c10bd79(localclientnum);

  while(true) {
    nonpredicted_local_player = function_27673a7(localclientnum);
    predicted_local_player = function_5c10bd79(localclientnum);

    if(nonpredicted_local_player !== level.demolocalclients[localclientnum].nonpredicted_local_player) {
      level notify(#"demo_nplplayer_change", localclientnum);
      level notify("demo_nplplayer_change" + localclientnum, {
        #old_player: level.demolocalclients[localclientnum].nonpredicted_local_player, 
        #new_player: nonpredicted_local_player
      });
      level.demolocalclients[localclientnum].nonpredicted_local_player = nonpredicted_local_player;
    }

    if(predicted_local_player !== level.demolocalclients[localclientnum].predicted_local_player) {
      level notify(#"demo_plplayer_change", {
        #localclientnum: localclientnum, 
        #old_player: level.demolocalclients[localclientnum].predicted_local_player, 
        #new_player: predicted_local_player
      });
      level notify("demo_plplayer_change" + localclientnum, {
        #old_player: level.demolocalclients[localclientnum].predicted_local_player, 
        #new_player: predicted_local_player
      });
      level.demolocalclients[localclientnum].predicted_local_player = predicted_local_player;
    }

    waitframe(1);
  }
}